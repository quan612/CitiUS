using TechTalk.SpecFlow;
using System;
using System.Linq;
using Arx;
using Arx.Managers;
using NUnit.Framework;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow.Assist;
using SpecFlowIntegration.FileProcessingTest.Models;
using SpecFlowIntegration.FileProcessingTest.Service;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class AddressesTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;
        private readonly AccountTestService _accountTest;
    

        public AddressesTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
            _accountTest = new AccountTestService();
        }

        [Then(@"The account address slot (.*) is: line1 (.*), line2 (.*), city (.*), province (\w+), postal code (.*)")]
        public void ThenTheAccountAddressIs(string slot, string addressLine1, string addressLine2, string addressCity, string addressProvince, string addressPostalCode)
        {
            var accountAddresses = AddressManager.GetAddresses(_testScope.accountId);
            var address = accountAddresses.FirstOrDefault(a => a.AddressSlot == Convert.ToInt16(slot));

            if (address == null)
            {
                Assert.Fail("Account address is null.");
            }
            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(addressLine1, address.Line1);
                    Assert.AreEqual(addressLine2, address.Line2);
                    Assert.AreEqual(addressCity, address.City);
                    Assert.AreEqual(addressProvince, address.Province);
                    Assert.AreEqual(addressPostalCode, address.PostalCode);
                });
            }
        }

        [Then(@"The account address province at slot (.*) is (.*)")]
        public void ThenTheAccountAddressProvinceIs(string slot, string addressProvince)
        {
            var accountAddresses = AddressManager.GetAddresses(_testScope.accountId);
            var address = accountAddresses.FirstOrDefault(a => a.AddressSlot == Convert.ToInt16(slot));

            if (address == null)
            {
                Assert.Fail("Account address is null.");
            }
            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(addressProvince, address.Province);
                });
            }
        }


        [Then(@"The primary address is: line1 (.*), line2 (.*), city (.*), province (\w+), postal code (.*)")]
        public void ThenTheAccountPrimaryAddressIs(string addressLine1, string addressLine2, string addressCity, string addressProvince, string addressPostalCode)
        {
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
                    Assert.AreEqual(addressLine1, primaryAddress.Line1);
                    Assert.AreEqual(addressLine2, primaryAddress.Line2);
                    Assert.AreEqual(addressCity, primaryAddress.City);
                    Assert.AreEqual(addressProvince, primaryAddress.Province);
                    Assert.AreEqual(addressPostalCode, primaryAddress.PostalCode);
                });
            }
        }

        [Then(@"The primary address province is (\w+)")]
        public void ThenTheAccountPrimaryProvinceIs(string addressProvince)
        {
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
                    Assert.AreEqual(addressProvince, primaryAddress.Province);
                });
            }
        }

        [Then(@"The primary address is ok to mail")]
        public void ThenThePrimaryAddressOkToMailIs(bool okToMail = true)
        {
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
                    Assert.AreEqual(okToMail, primaryAddress.OkToMail);
                });
            }
        }

        [Then(@"The primary address is not ok to mail")]
        public void ThenThePrimaryAddressIsNotOkToMail()
        {
            ThenThePrimaryAddressOkToMailIs(false);
        }

        [When(@"the user changes the account primary address as below:")]
        public void Changing_Account_Address(Table table)
        {
            var currentPrimaryAddress = AddressManager.GetAddresses(_testScope.accountId).SingleOrDefault(address => address.PrimaryAddress);
            var addressToUpdate = table.CreateInstance<AccountPrimaryAddressRecords>();

            if (currentPrimaryAddress == null) return;
            var newAddress = new Address()
            {
                AccountId = _testScope.accountId,
                AddressSlot = currentPrimaryAddress.AddressSlot,
                Line1 = addressToUpdate.Line1 ?? currentPrimaryAddress.Line1,
                Line2 = addressToUpdate.Line2 ?? currentPrimaryAddress.Line2,
                City = addressToUpdate.City ?? currentPrimaryAddress.City,
                Province = addressToUpdate.Prov ?? currentPrimaryAddress.Province,
                PostalCode = addressToUpdate.Postal ?? currentPrimaryAddress.PostalCode,
                Country = addressToUpdate.Country ?? currentPrimaryAddress.Country
            };

            _accountTest.UpdateAddress(_testScope.accountId, newAddress, currentPrimaryAddress);
        }
    }
}
