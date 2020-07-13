using Arx.Managers;
using TechTalk.SpecFlow;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow.Assist;
using Arx;
using System;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class InternalExtrasTest : TechTalk.SpecFlow.Steps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;              

        public InternalExtrasTest(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;           
        }      

        [Then(@"The Interal Extras table for the account is as below:")]
        public void Verify_The_Internal_Extras_Table(Table table)
        {           
            var actualResult = AccountInternalExtrasManager.GetAccountInternalExtras(_testScope.accountId);
            var currentType = typeof(AccountInternalExtras);            
           
            foreach (var prop in currentType.GetProperties())
            {
                //trim space for comparison
                if (prop.Name.StartsWith("Text"))
                {
                    var currentValue = prop.GetValue(actualResult);
                    prop.SetValue(actualResult, currentValue.ToString().Trim());
                }               
            }

            table.CompareToInstance(actualResult);            
        }                             
    }
}
