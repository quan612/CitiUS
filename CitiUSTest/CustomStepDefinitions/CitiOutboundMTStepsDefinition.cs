using System;
using System.Collections.Generic;
using System.Linq;
using Arx;
using Arx.Managers;
using CitiUSTest.DataAccess;
using CitiUSTest.Models;
using CitiUSTest.Models.Maintenance;
using CitiUSTest.Service;
using NUnit.Framework;
using SpecFlowIntegration.FileProcessingTest.Service;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CitiUSTest.CustomStepDefinitions
{
    [Binding]
    public class CitiOutboundMaintenanceTestStepsDefinition:TechTalk.SpecFlow.Steps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;
        private readonly OutgoingMaintenanceTestService _outgoingTest;
        private readonly CommonTestService _commentTest;

        private List<MaintenanceDetailRecord> _outboundMaintenanceRecords;
        private List<MaintenanceCommentRecord> _outboundCommentRecords;

        public CitiOutboundMaintenanceTestStepsDefinition(TestScopeContext testScope, 
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
            _outgoingTest = new OutgoingMaintenanceTestService();
            _commentTest = new CommonTestService();
        }

        [When(@"The user generates an outbound maintenance file for (.*)")]
        public void When_The_User_Generates_A_Citi_Outbound_Maintenance_File(string fileGroupCode)
        {
            //_testScope.accountId = 100696883;
            _testScope.clientFileType = _commentTest.GetClientFileType("MNT", fileGroupCode);
            _outgoingTest.GenerateOutboundMaintenanceFile(_testScope.clientFileType);
        }
        
        [Then(@"The records are sent in the outbound maintenance file as below:")]
        public void Then_The_Record_Is_Sent_In_Citi_Outbound_Maintenance_File(Table table)
        {
            _testScope.fileSent = _outgoingTest.GetLastGeneratedMaintenanceFile(_testScope.clientFileType);
            _outboundMaintenanceRecords = _outgoingTest.ReadRecordsFromMaintenanceFile(_testScope.fileSent);

            var clientAccount = AccountManager.GetAccount(_testScope.accountId).ClientAccount1;
            var expectedRecords = table.CreateSet<MaintenanceDetailRecord>();
            var actualRecords = _outboundMaintenanceRecords.FindAll(x => x.AccountNumber == clientAccount);

            foreach (var expected in expectedRecords)
            {
                Console.WriteLine("Record in file " + expected.NewValue);
                var duplicate = 0;
                foreach (var record in actualRecords)
                {
                    if (expected.FieldCode == record.FieldCode)
                    {
                        _testScope.softAssert.Add(() =>
                        {
                            Assert.AreEqual(expected.NewValue.Trim(), record.NewValue);
                        });
                        duplicate++;
                    }

                    if (duplicate == 2)
                    {
                        throw new Exception("Duplicate records are sent in the outbound maintenance file.");
                    }
                }

                if (duplicate == 0)
                {
                    throw new Exception("Expected record " + expected + " is not presented");
                }
            }
        }

        [Then(@"The comment records are sent in the outbound maintenance file as below:")]
        public void Then_Comment_Records_Are_Sent_In_Citi_Outbound_Maintenance_File(Table table)
        {
            _testScope.fileSent = _outgoingTest.GetLastGeneratedMaintenanceFile(_testScope.clientFileType);
            _outboundCommentRecords = _outgoingTest.ReadCommentRecordsFromMaintenanceFile(_testScope.fileSent);

            var clientAccount = AccountManager.GetAccount(_testScope.accountId).ClientAccount1;
            var expectedRecords = table.CreateSet<MaintenanceCommentRecord>();
            var actualRecords = _outboundCommentRecords.FindAll(x => x.AccountNumber == clientAccount 
                                                                     && x.TransactionCode.Trim() == "94" );
            


            foreach (var expected in expectedRecords)
            {
                Console.WriteLine("Record in file " + expected.NewValue);
                var duplicate = 0;
                foreach (var record in actualRecords)
                {
                    if (expected.NewValue == record.NewValue)
                    {
                        _testScope.softAssert.Add(() =>
                        {
                            Assert.AreEqual(expected.NewValue.Trim(), record.NewValue.Trim());
                        });
                        duplicate++;
                    }


                    if (duplicate == 2)
                    {
                        throw new Exception("Duplicate records are sent in the outbound maintenance file.");
                    }
                }

                if (duplicate == 0)
                {
                    throw new Exception("Expected record " + expected + " is not presented");
                }
            }
        }

        [Then(@"The records below should not be sent for the account in the file")]
        public void Then_The_Records_Should_Not_Be_Sent(Table table)
        {
            _testScope.fileSent = _outgoingTest.GetLastGeneratedMaintenanceFile(_testScope.clientFileType);

            _outboundMaintenanceRecords = _outgoingTest.ReadRecordsFromMaintenanceFile(_testScope.fileSent);

            var clientAccount = AccountManager.GetAccount(_testScope.accountId).ClientAccount1;

            var expectedRecords = table.CreateSet<MaintenanceFieldCode>().ToList()
                .Select(x => x.FieldCode);

            var actualRecords = _outboundMaintenanceRecords.FindAll(x => x.AccountNumber == clientAccount)
                .Select(x => x.FieldCode);

            var isMatch = actualRecords.Intersect(expectedRecords).Any();

            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(false, isMatch);
            });
        }

        [Then(@"The comment records are not sent in the outbound maintenance file")]
        public void Then_The_94_note_Record_Is_Not_Sent_In_Citi_Outbound_Maintenance_File(Table table)
        {
            {
                _testScope.fileSent = _outgoingTest.GetLastGeneratedMaintenanceFile(_testScope.clientFileType);

                _outboundCommentRecords = _outgoingTest.ReadCommentRecordsFromMaintenanceFile(_testScope.fileSent);

                var clientAccount = AccountManager.GetAccount(_testScope.accountId).ClientAccount1;

                var expectedRecords = table.CreateSet<MaintenanceCommentRecord>().ToList()
                    .Select(x => x.TransactionCode);

                var actualRecords = _outboundCommentRecords.FindAll(x => x.AccountNumber == clientAccount)
                    .Select(x => x.TransactionCode);

                var isMatch = actualRecords.Intersect(expectedRecords).Any();

                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(false, isMatch);
                });
            }


        }
        
    }

    class MaintenanceFieldCode
    {
        public string FieldCode { get; set; }
    }
}