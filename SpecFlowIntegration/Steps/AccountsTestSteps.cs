using TechTalk.SpecFlow;
using System;
using System.Linq;
using Arx;
using Arx.Managers;
using NUnit.Framework;
using SpecFlowIntegration.Hooks;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class AccountsTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;

        public AccountsTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }


        [Then(@"The Account Verbal Language is (.*)")]
        public void ThenTheAccountVerbalIs(string verbalLanguage)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(verbalLanguage.ToUpper(), account.Debtors.FirstOrDefault()?.DriverLicense);
            });
        }

        [Then(@"The Account Written Language is (.*)")]
        public void ThenTheAccountWrittenIs(string writtenLanguage)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(writtenLanguage.ToUpper(), account.LanguageId.ToUpper());
            });
        }
       
        [Then(@"The account information: (.*) is (.*)")]
        public void ThenTheAccountInformationIs(string accountField, string expectedResult)
        {
            object actualResult = null;
            System.Reflection.PropertyInfo mapping;
            var accountDebtor = AccountManager.GetAccountDebtors(_testScope.accountId);
            var account = AccountManager.GetAccount(_testScope.accountId);

            if (accountField.Contains("Name")
                || accountField.Contains("Responsible")
                || accountField.Contains("Salutation")
                || accountField.Contains("DOB")
                || accountField.Contains("DRL")
                || accountField.Contains("ID")
                || accountField.Contains("SIN")
                )
            {
                mapping = GetDebtorMapping(accountField);
                var slot = int.Parse(accountField[accountField.Length - 1].ToString());
                actualResult = mapping.GetValue(accountDebtor.Find(debtor => debtor.Slot == slot));
            }

            else
            {
                mapping = typeof(Account).GetProperty(accountField);
                actualResult = mapping?.GetValue(account);
            }

            // in case nullable datetime or datetime, converting to shortDateString
            // 1988-06-12 00:00:00 => 6/12/1988
            if (mapping?.PropertyType == typeof(DateTime?))
                actualResult = Convert.ToDateTime(actualResult).ToShortDateString();

            if (mapping?.PropertyType == typeof(decimal?) || mapping?.PropertyType == typeof(decimal))
                actualResult = Convert.ToDecimal(string.Format("{0:F2}", actualResult)).ToString("0.00");

            Console.WriteLine("Actual result is " + actualResult.ToString());
            Console.WriteLine("Expected result is " + expectedResult.ToString());

            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(expectedResult, actualResult);
            });
        }

        [Then(@"A noteline is added to the account as (.*)")]
        public void ThenNoteLineIsAddedToTheAccount(string noteline)
        {
            try
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(_testScope.commonTestService.IsNoteLineExistOnAccount(noteline, _testScope.accountId), true);
                });
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw new Exception("Catch exception at Note line verification step.");
            }
        }

        [Then(@"The action code (\d+) is applied to the account")]
        public void ThenTheActionCodeIsApplied(int actionCode)
        {
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(_testScope.commonTestService.IsActionCodeApplied(actionCode, _testScope.accountId), 
                    true);
            });
        }

        [Then(@"The action code (\d+) is NOT applied to the account")]
        public void ThenTheActionCodeIsNOTApplied(int actionCode)
        {
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(_testScope.commonTestService.IsActionCodeApplied(actionCode, _testScope.accountId), 
                    false);
            });
        }

        [Then(@"The account is put to desk (\d+)")]
        public void ThenTheAccountIsPutToDesk(int desk)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(desk, account.Desk.DeskId);
            });
        }

        [Then(@"The account is not moved to any support queue")]
        public void ThenTheAccountIsNotMovedToSupportQueue()
        {
            //Then support queue is blank in the Account table
            ThenTheAccountIsPutToSupportQueue("");
        }

        [Then(@"The account is put to support queue (\w+)")]
        public void ThenTheAccountIsPutToSupportQueue(string supportQueue)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(supportQueue, account.SupportDeskId);
            });
        }
        
        [When(@"The user applies an action code (\d+)")]
        public void When_User_Apply_Action_Code(int actionCode)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            AccountManager.ApplyActionCode(account, ActionCodeManager.GetActionCode(actionCode));
        }

        private System.Reflection.PropertyInfo GetDebtorMapping(string accountField)
        {
            accountField = accountField.Remove(accountField.Length - 1);
            switch (accountField)
            {
                case "Name":
                case "Responsible":
                case "Salutation":
                    return typeof(Debtor).GetProperty(accountField);
                case "DOB":
                    return typeof(Debtor).GetProperty("DateOfBirth");
                case "DRL":
                    return typeof(Debtor).GetProperty("DriverLicense");
                case "ID":
                    return typeof(Debtor).GetProperty("Identification");
                case "SIN":
                case "SSN":
                    return typeof(Debtor).GetProperty("SocialInsuranceNumber");
                default:
                    return null;
            }
        }

    }
}
