using System;
using System.Collections.Generic;
using System.Linq;
using Arx;
using TechTalk.SpecFlow;
using SpecFlowIntegration.Hooks;
using Arx.Managers;
using GlobalCollection.eCollect.DataAccess;
using NUnit.Framework;
using SpecFlowIntegration.FileProcessingTest.Helper;
using TechTalk.SpecFlow.Assist;
using SpecFlowIntegration.FileProcessingTest.Models;
using SpecFlowIntegration.FileProcessingTest.Service;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class AccountPhoneTestSteps : TechTalk.SpecFlow.Steps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;
        private readonly AccountTestService _accountTest;
        private List<Phone> _phones;

        public AccountPhoneTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
            _accountTest = new AccountTestService();
        }

        [StepArgumentTransformation("(.*)phone")]
        public int GetPhoneSlotNumberFromString(string phoneSlot)
        {
            var slot = 0;
            switch (phoneSlot.Trim())
            {
                case "first":
                case "1st":
                case "Home":
                    slot = 1;
                    break;
                case "second":
                case "2nd":
                case "Work":
                    slot = 2;
                    break;
                case "Cell":
                case "18th":
                    slot = 18;
                    break;
            }
            return slot;
        }

        [Then(@"The phone (.*) is not added to the account")]
        public void VerifyPhoneIsNotAddedToTheAccount(string phoneNumber)
        {
            _phones = PhoneManager.GetPhones(_testScope.accountId);
            var phone = _phones.FirstOrDefault(x => x.PhoneNumber == phoneNumber);

            if (phone == null)
            {
                return;
            }
            else
            {
                _testScope.softAssert.Add(() =>
                {
                   Assert.Fail("The phone is added, test fail");
                });
            }
        }
               

        [Then(@"The (.*) slot has status equals (.*)")]
        public void VerifyThePhoneStatus(int slot, string phoneStatus)
        {
            if (slot == 0) Assert.Fail("Slot = 0, please check the step");
            _phones = PhoneManager.GetPhones(_testScope.accountId);
            var phone = _phones.FirstOrDefault(x => x.PhoneSlot == slot);

            if (phone == null)
            {
                _testScope.softAssert.Add(() => { Assert.Fail("Account has no phone to test"); });
            }

            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(phoneStatus, phone.PhoneStatus.Description);
                });
            }
        }

        [Then(@"The (.*) slot has location equals (.*)")]
        public void VerifyThePhoneLocationType(int slot, Phone.PhoneLocationTypes locationType)
        {
            if (slot == 0) Assert.Fail("Slot = 0, please check the step");
            _phones = PhoneManager.GetPhones(_testScope.accountId);
            var phone = _phones.FirstOrDefault(x => x.PhoneSlot == slot);

            if (phone == null)
            {
                _testScope.softAssert.Add(() => { Assert.Fail("Account has no phone to test"); });
            }

            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(locationType, phone.LocationType);
                });
            }
        }

        [Then(@"The (.*) slot has service equals (.*)")]
        public void VerifyThePhoneServiceType(int slot, Phone.PhoneServiceTypes serviceType)
        {
            if (slot == 0) Assert.Fail("Slot = 0, please check the step");
            _phones = PhoneManager.GetPhones(_testScope.accountId);
            var phone = _phones.FirstOrDefault(x => x.PhoneSlot == slot);

            if (phone == null)
            {
                _testScope.softAssert.Add(() => { Assert.Fail("Account has no phone to test"); });
            }

            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(serviceType, phone.ServiceType);
                });
            }
        }

        [Then(@"The (.*) slot has Consent To Dialer equals (.*)")]
        public void VerifyThePhoneConsentOnDialer(int slot, Phone.ConsentMode consentMode)
        {
            if (slot == 0) Assert.Fail("Slot = 0, please check the step");
            _phones = PhoneManager.GetPhones(_testScope.accountId);
            var phone = _phones.FirstOrDefault(x => x.PhoneSlot == slot);

            if (phone == null)
            {
                _testScope.softAssert.Add(() => { Assert.Fail("Account has no phone to test"); });
            }

            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(consentMode, phone.ConsentForAutomatedDialing);
                });
            }
        }

        [Then(@"The Account Phones table for the account is as below:")]
        public void Verify_The_Account_Phones_Table(Table table)
        {           
            var allPhonesRecords = _testScope.commonTestService.GetAccountPhonesRecords(_testScope.accountId);
            table.CompareToSet<AccountPhonesRecords>(allPhonesRecords);
        }

        [Then(@"The Account Phones table for the account has (.*) records")]
        public void Verify_The_Number_Of_Records_In_Account_Phones(int numberOfRecords)
        {
            _phones = PhoneManager.GetPhones(_testScope.accountId);

            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(_phones.Count, numberOfRecords);
            });
        }

        
        [When(@"the user adds a new number (.*) with status (.*) location (.*) service (.*)")]
        public void User_Adds_A_New_Phone_Number(
            string phoneNumber,
            string phoneStatus,
            Phone.PhoneLocationTypes location,
            Phone.PhoneServiceTypes service)
        {
            var accountPhones = PhoneManager.GetPhones(_testScope.accountId);

            if (accountPhones.FirstOrDefault(x => x.PhoneNumber == phoneNumber) != null)
            {
                throw new Exception("This number " + phoneNumber + " already existed on the account");
            }

            var status = _accountTest.GetPhoneStatusMapping(phoneStatus);
            var phoneSlot = accountPhones.GetNextAvailableSlot();
            _accountTest.AddPhoneNumber(_testScope.accountId, phoneNumber, service, location, phoneSlot, status);
        }

        [When(@"the user changes the phone number (.*) to location (.*)")]
        public void Changing_Phone_Location(string phoneNumber, Phone.PhoneLocationTypes location)
        {
            var phones = PhoneManager.GetPhones(_testScope.accountId);
            var oldPhone = phones.SingleOrDefault(p => p.PhoneNumber == phoneNumber);

            if (oldPhone == null) return;
            var newPhone = _accountTest.DuplicateThisPhone(oldPhone);
            newPhone.LocationType = location;
            _accountTest.UpdatePhone(newPhone, oldPhone);
        }

        [When(@"the user changes the phone number (.*) to service (.*)")]
        public void Changing_Phone_Service(string phoneNumber, Phone.PhoneServiceTypes service)
        {
            var phones = PhoneManager.GetPhones(_testScope.accountId);
            var oldPhone = phones.SingleOrDefault(p => p.PhoneNumber == phoneNumber);

            if (oldPhone == null) return;
            var newPhone = _accountTest.DuplicateThisPhone(oldPhone);
            newPhone.ServiceType = service;
            _accountTest.UpdatePhone(newPhone, oldPhone);
        }

        [When(@"the user changes the phone number (.*) to status (.*)")]
        public void Changing_Phone_Status(string phoneNumber, string phoneStatus)
        {
            var phones = PhoneManager.GetPhones(_testScope.accountId);
            var oldPhone = phones.SingleOrDefault(p => p.PhoneNumber == phoneNumber);

            if (oldPhone == null) return;
            var newPhone = _accountTest.DuplicateThisPhone(oldPhone);
            var newStatus = _accountTest.GetPhoneStatusMapping(phoneStatus);
            newPhone.PhoneStatusId = newStatus;
            _accountTest.UpdatePhone(newPhone, oldPhone);
        }
        
        [When(@"the user changes all the phones number of the account to status (.*)")]
        public void Changing_All_Phones_To_Status(string phoneStatus)
        {
            var newStatus = _accountTest.GetPhoneStatusMapping(phoneStatus);
            var phones = PhoneManager.GetPhones(_testScope.accountId);

            foreach (var phone in phones)
            {
                var newPhone = _accountTest.DuplicateThisPhone(phone);
                newPhone.PhoneStatusId = newStatus;
                _accountTest.UpdatePhone(newPhone, phone);
            }
        }
                      
    }
}
