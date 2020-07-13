using TechTalk.SpecFlow;
using System;
using Arx.Managers;
using NUnit.Framework;
using SpecFlowIntegration.Hooks;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class AccountBalanceTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;

        public AccountBalanceTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        /// <summary>
        /// Verify the account balance info based on account balance fields:
        /// Principal Original, Principal Balance, Principal Adjustment, Principal Paid, Current Balance, Original Balance
        /// </summary>
        /// <param name="accountBalanceField"></param>
        /// <param name="expectedResult"></param>
        [Then(@"The account balance information: (.*) is \$(.*)")]
        public void ThenTheAccountInformationIs(string accountBalanceField, string expectedResult)
        {
            var accountBalance = AccountManager.GetAccountBalanceDetails(_testScope.accountId);
            object actualResult = null;

            switch (accountBalanceField)
            {
                case "Principal Original":
                    actualResult = accountBalance.Principal.PrincipalOriginal;
                    break;
                case "Principal Balance":
                    actualResult = accountBalance.Principal.PrincipalBalance;
                    break;
                case "Principal Adjustment":
                    actualResult = accountBalance.Principal.PrincipalAdjustment;
                    break;
                case "Principal Paid":
                    actualResult = accountBalance.Principal.PrincipalPaid;
                    break;
                case "Current Balance":
                    actualResult = accountBalance.CurrentBalance;
                    break;
                case "Original Balance":
                    actualResult = accountBalance.OriginalBalance;
                    break;
                default:
                    throw new Exception("Account balance field cannot be found");

            }

            actualResult = Convert.ToDecimal(string.Format("{0:F2}", actualResult)).ToString("0.00");
            Console.WriteLine("Actual result is " + actualResult?.ToString());
            Console.WriteLine("Expected result is " + expectedResult.ToString());

            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(expectedResult, actualResult);
            });
        }
    }
}
