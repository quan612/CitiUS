using System.Linq;
using TechTalk.SpecFlow;
using SpecFlowIntegration.Hooks;
using Arx.Managers;
using NUnit.Framework;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class DeathBKCCSTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;

        public DeathBKCCSTestSteps(
            TestScopeContext testScope, 
            ScenarioContext scenarioContext
            )
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        [Then(@"The bankruptcy information is: BKCaseNumber (.*), BKFileDate (.*)")]
        public void VerifyTheAccountBankruptcyInformation(string bkCaseNumber, string bkFileDate)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            var trustee = account.DebtorBankruptcyTrustees.FirstOrDefault();

            if (trustee != null)
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(bkCaseNumber, trustee.CaseNumber);

                    if (trustee.BankruptcyDate.HasValue)
                        Assert.AreEqual(bkFileDate, trustee.BankruptcyDate.Value.ToShortDateString().ToString());
                });
            }
        }
    }
}
