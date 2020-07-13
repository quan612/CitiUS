using System.Collections.Generic;
using CitiUSTest.Models;
using CitiUSTest.Models.IncomingAssignment;
using CitiUSTest.Service;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CitiUSTest.CustomStepDefinitions
{
    [Binding]
    public class CitiTestStepsDefinition : TechTalk.SpecFlow.Steps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;
        private CitiNbsTestScope _citiScope;

        private const int HeaderRecordLineNumber = 0;
        private const int ARecordLineNumber = 1;
        private const int X00RecordLineNumber = 2;
        private const int H00RecordLineNumber = 3;
        private const int M00RecordLineNumber = 4;
        private const int X01RecordLineNumber = 5;
        public CitiTestStepsDefinition(TestScopeContext testScope, ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }
        
        [Given(@"The user creates a Citi NBS based on the sample file")]
        public void The_User_Creates_A_Citi_Nbs_File_Based_On_The_Sample()
        {            
            _citiScope = new CitiNbsTestScope(_scenarioContext);
            _citiScope.citiTestService = new CitiAssignmentTestService();
            _testScope.clientConfigurations = new CitiNbsConfigurations();

            _testScope.fileReceived = _testScope.commonTestService.DuplicateSourceFile(
                _testScope.clientConfigurations.SourceFolder,
                _testScope.clientConfigurations.SourceFile,
                _scenarioContext.ScenarioInfo.Title);

            _testScope.clientAccount = _citiScope.citiTestService.GetClientAccountNumber(
                _testScope.clientConfigurations.SourceFolder, 
                _testScope.fileReceived);
            HandleNewClientAccountInNewBusinessFile(_testScope.clientAccount);

        }
                

        [Given(@"The user modifies the header record with credentials:")]
        public void The_User_Modifies_Header_Record(Table table)
        {
            var records = table.CreateSet<CitiNbsHeaderRecords>();
            _citiScope.citiTestService.ModifyNewBusinessHeaderRecords(
                records, 
                _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived,
                HeaderRecordLineNumber);
        }

        [Given(@"The user modifies the account record in DL file with credentials:")]
        public void The_User_Modifies_A_Record(Table table)
        {
            var accountRecords = table.CreateSet<AccountRecord>();
            _citiScope.citiTestService.ModifyNewBusinessAccountRecords(accountRecords, 
                _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived,
                ARecordLineNumber);
        }

        [Given(@"The user modifies the X00 record in DL file with credentials:")]
        public void The_User_Modifies_X00_Record(Table table)
        {            
            var x00Record = table.CreateInstance<X00Record>();
            _citiScope.citiTestService.ModifyNewBusinessX00Record(
                x00Record,
                _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived,
                X00RecordLineNumber);
        }

        [Given(@"The user modifies the X01 record in DL file with credentials:")]
        public void The_User_Modifies_X01_Record(Table table)
        {            
            var x01Record = table.CreateInstance<X01Record>();
            _citiScope.citiTestService.ModifyNewBusinessX01Record(
                x01Record,
                _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived,
                X01RecordLineNumber);
        }

        [Given(@"The user modifies the M record in DL file with credentials:")]
        public void The_User_Modifies_M_Record(Table table)
        {          
            var mRecord = table.CreateInstance<MRecord>();
            _citiScope.citiTestService.ModifyNewBusinessMRecord(
                mRecord,
                _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived,
                M00RecordLineNumber);
        }

        [Given(@"The user modifies the recoverer in DL file with credentials:")]
        public void The_User_Modifies_Recoverer_In_DL_File(Table table)
        {
            var aRecords = table.CreateSet<AccountRecord>();
            var x00Record = table.CreateInstance<X00Record>();
            var hRecords = table.CreateSet<CitiNbsHRecords>();
            var mRecord = table.CreateInstance<MRecord>();
            var x01Record = table.CreateInstance<X01Record>();

            _citiScope.citiTestService.ModifyNewBusinessAccountRecords(aRecords, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, ARecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessX00Record(x00Record, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, X00RecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessHRecords(hRecords, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, H00RecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessMRecord(mRecord, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, M00RecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessX01Record(x01Record, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, X01RecordLineNumber);
        }

        private void HandleNewClientAccountInNewBusinessFile(string clientAccount)
        {
            var aRecords = new List<AccountRecord>()
            {
                new AccountRecord()
                {
                    ClientAccountNumber = clientAccount
                }
            };

            var x00Record = new X00Record()
            {
                ClientAccountNumber = clientAccount
            };

            var hRecords = new List<CitiNbsHRecords>()
            {
                new CitiNbsHRecords()
                {
                    ClientAccountNumber = clientAccount
                }
            };           

            var mRecord = new MRecord()
            {
                ClientAccountNumber = clientAccount
            };

            var x01Record = new X01Record()
            {
                ClientAccountNumber = clientAccount
            };

            _citiScope.citiTestService.ModifyNewBusinessAccountRecords(aRecords, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, ARecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessX00Record(x00Record, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, X00RecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessHRecords(hRecords, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, H00RecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessMRecord(mRecord, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, M00RecordLineNumber);
            _citiScope.citiTestService.ModifyNewBusinessX01Record(x01Record, _testScope.clientConfigurations.SourceFolder + _testScope.fileReceived, X01RecordLineNumber);

        }
    }
}
