using System;
using Arx;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using SpecFlowIntegration.Hooks;
using Arx.Managers;
using NUnit.Framework;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class AccountExtrasTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;

        public AccountExtrasTestSteps(
            TestScopeContext testScope, 
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        [Then(@"The Extras table for the account is as below:")]
        public void Verify_The_Extras_Table(Table table)
        {
            var actualResult = AccountExtrasManager.GetAccountExtras(_testScope.accountId);
            table.CompareToInstance(actualResult);
        }


        [Then(@"The account extras information: (.*) is (.*)")]
        public void VerifyTheAccountExtrasInformation(string extrasField, string expectedResult)
        {
            //object actualResult = null;
            System.Reflection.PropertyInfo mapping;
            var accountExtras = AccountExtrasManager.GetAccountExtras(_testScope.accountId);

            if (extrasField.StartsWith("Curr"))
            {
                mapping = typeof(AccountExtras).GetProperty("Currency" + extrasField.Substring(4, extrasField.Length - 4));
            }
            else
            {
                mapping = typeof(AccountExtras).GetProperty(extrasField);
            }

            /*
            This will return the value of the accountExtras based on the mapping
            If mapping is Text5 -> actualResult is the value of accountExtras.Text5
                                                                                    */
            if (mapping != null)
            {
                var actualResult = mapping.GetValue(accountExtras);

                if (mapping?.PropertyType == typeof(DateTime?) || mapping?.PropertyType == typeof(DateTime))
                    actualResult = Convert.ToDateTime(actualResult).ToShortDateString();

                if (extrasField.StartsWith("Curr"))
                {
                    actualResult = Convert.ToDecimal(string.Format("{0:F2}", actualResult)).ToString("0.00");
                }

                if (extrasField.ToUpper().StartsWith("NUMBER"))
                {
                    //if it likes an integer, then keep the value and don't convert
                    if (Convert.ToDecimal(actualResult) % 1 != 0)
                    {
                        actualResult = Convert.ToDecimal(string.Format("{0:F2}", actualResult)).ToString("0.00");
                    }

                    else
                    {
                        actualResult = Convert.ToInt16(actualResult).ToString();
                    }

                }

                if (expectedResult == "null")
                {
                    Console.WriteLine("result is null");
                    _testScope.softAssert.Add(() =>
                    {
                        Assert.AreEqual(expectedResult, null);
                    });
                }
                else
                {
                    _testScope.softAssert.Add(() =>
                    {
                        Assert.AreEqual(expectedResult, actualResult);
                    });
                }
            }
            else
            {
                throw new Exception("Mapping for account extras is not found.");
            }
        }
    }
}
