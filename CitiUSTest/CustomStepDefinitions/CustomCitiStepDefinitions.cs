using System;
using System.Collections.Generic;
using System.Linq;
using Arx;
using Arx.Insight.Entities;
using Arx.Insight.Entities.Managers;
using Arx.Managers;
using CitiUSTest.Models;
using CitiUSTest.Service;
using NUnit.Framework;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CitiUSTest.CustomStepDefinitions
{
    [Binding]
    class CustomCitiTestSteps
    {
        private readonly TestScopeContext _testScope;        
        private readonly GeneralTestService _citiTestService;        

        public CustomCitiTestSteps(
            TestScopeContext testScope
            )
        {
            _testScope = testScope;          
            _citiTestService = new GeneralTestService();
        }

        [Then(@"The Citi Phone tracker table for the account is as below:")]
        public void Verify_The_Citi_Phones_Tracker_Table(Table table)
        {            
            var allTrackerRecordsOfAccount = _citiTestService.GetCitiPhoneTrackerRecords(_testScope.accountId);
            table.CompareToSet<CitiPhoneTrackerRecords>(allTrackerRecordsOfAccount);
        }

        /// <summary>
        /// Create a new call record with right party contact
        /// Disposition will not affect RPC 
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <param name="isRightPartyContact"></param>
        [When(@"the user creates a call record for phone number (.*) with Right Party Contact as (.*)")]
        public void User_Creates_A_Call_Record_For_Phone_Number(string phoneNumber, bool isRightPartyContact)
        {
            var updatedCallRecord = CallRecordManager.GetCallRecord(25925251);
            var newCall = new CallRecord
            {
                StartTime = DateTime.Now,
                EndTime = DateTime.Now.AddHours(1),
                AccountBalance = updatedCallRecord.AccountBalance,
                AccountNumber = _testScope.accountId.ToString(),
                PhoneNumber = phoneNumber,
                Disposition = 1,
                Answered = true,
                IsRightPartyContact = isRightPartyContact,
                IsContact = true,
                IsAttempt = true,
                AccountSystemId = 1
             };

            newCall.Save();
        }
        
        [Then(@"The account primary address is as below:")]
        public void ThenTheAccountPrimaryAddressIsBelow(Table table)
        {
            var expectedRecords = table.CreateInstance<AccountAddressesRecords>();
            var addresses = AddressManager.GetAddresses(_testScope.accountId);

            var primaryAddress = addresses.FirstOrDefault(x => x.PrimaryAddress);

            if (primaryAddress == null)
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.Fail("The account has no primary address");

                });
            }
            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(expectedRecords.Addr1Line1, primaryAddress.Line1);
                    Assert.AreEqual(expectedRecords.Addr1Line2, primaryAddress.Line2);
                    Assert.AreEqual(expectedRecords.Addr1City, primaryAddress.City);
                    Assert.AreEqual(expectedRecords.Addr1Prov, primaryAddress.Province);
                    Assert.AreEqual(expectedRecords.Addr1Postal, primaryAddress.PostalCode);
                    //Assert.AreEqual(expectedRecords.Addr1Country, primaryAddress.Country);
                });
            }
        }

        [Then(@"The account address is as below:")]
        public void ThenTheAccountAddressIsBelow(Table table)
        {
            var addressRecords = _citiTestService.GetAccountAddressesRecords(_testScope.accountId);
            foreach (var address in addressRecords)
            {
                var temp = address.Addr1City;
                address.Addr1City = temp.Trim();
            }
            
            table.CompareToSet<AccountAddressesRecords>(addressRecords);
        }

        [Then(@"The eCollectApps.Citi.ExtrasOverflow table for the account is as below:")]
        public void Verify_The_eCollectApps_Citi_ExtrasOverflow_Table(Table table)
        {
            var actualResult = _citiTestService.GetCitiExtrasOverflow(_testScope.accountId);
            table.CompareToSet<CitiExtrasOverflow>(actualResult);
        }
    }
}
