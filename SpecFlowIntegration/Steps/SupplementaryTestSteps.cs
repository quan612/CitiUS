using System;
using System.Linq;
using Arx;
using TechTalk.SpecFlow;
using SpecFlowIntegration.Hooks;
using Arx.Managers;
using NUnit.Framework;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class SupplementaryTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;

        public SupplementaryTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        [Then(@"The attorney information is: AttorneyName (.*), AttorneyAddress1 (.*), AttorneyAddress2 (.*), AttorneyAddress3 (.*)")]
        public void VerifyTheAccountAttorneyInformation(string attorneyName,
            string attorneyAddress1,
            string attorneyAddress2,
            string attorneyAddress3)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            var attorney = account.DebtorAttorneys.FirstOrDefault();

            if (attorney != null)
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.AreEqual(attorneyName, attorney.AttorneyName);
                    Assert.AreEqual(attorneyAddress1, attorney.AddressLine1);
                    Assert.AreEqual(attorneyAddress2, attorney.AddressLine2);
                    Assert.AreEqual(attorneyAddress3, attorney.AddressLine3);
                });
            }
        }

        /// <summary>
        /// Mapping for employerField is based on DebtorEmployer from ARxAPI
        /// AddressLine1, AddressLine2, AddressLine3, Description, Fax, EmployerName, Phone, Position, Schedule, Slot
        /// </summary>
        /// <param name="employerField"></param>
        ///  <param name="expectedResult"></param>
        [Then(@"The employer information: (.*) is (.*)")]
        public void VerifyTheAccountEmployeeInformation(string employerField, string expectedResult)
        {
            object actualResult = null;
            var account = AccountManager.GetAccount(_testScope.accountId);
            var employment = account.DebtorEmployment.FirstOrDefault();
            var mapping = typeof(DebtorEmployer).GetProperty(employerField);

            if (mapping != null)
            {
                actualResult = mapping.GetValue(employment);

                _testScope.softAssert.Add(() =>
                {
                     Assert.AreEqual(actualResult, expectedResult);
                });
            }
            else
            {
                throw new Exception("Mapping for " + employerField + " not found");
            }
        }
    }
}
