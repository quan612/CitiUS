using System;
using Arx.Managers;
using BoDi;
using NUnit.Framework;
using TechTalk.SpecFlow;
using Allure.Commons;

namespace SpecFlowIntegration.Hooks
{
    [Binding]
    public class Hooks
    {
        private TestScopeContext _testScope;
        private ScenarioContext _scenario;
        private readonly IObjectContainer _objectContainer;
        private static readonly AllureLifecycle allure = AllureLifecycle.Instance;

        public Hooks(IObjectContainer objectContainer, ScenarioContext scenario)
        {
            _objectContainer = objectContainer;
            _scenario = scenario;
        }

        [BeforeTestRun]
        public static void SetUpTestScope()
        {
            UserManager.Login("System", "System");
        }

        [AfterTestRun]
        public static void AfterTestSuite()
        {
            
            try
            {
                UserManager.GetLoggedInUser();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                UserManager.LogOff();                
            }
        }        

        [BeforeScenario]
        public void CreateScenario(ScenarioContext scenarioContext)
        {
            _testScope = new TestScopeContext();
            _objectContainer.RegisterInstanceAs<TestScopeContext>(_testScope);            

            _testScope.testLinkNotes = @"
         <div style='background: linear-gradient(to right, #30CFD0 0%, #330867 100%);-webkit-background-clip: text;-webkit-text-fill-color: transparent;font-weight:bold;font-size:1.2rem'>Executing test case: "
                                       + scenarioContext.ScenarioInfo.Title + @"</div>";
        }

        [AfterScenario(Order = 0)]
        public void AfterScenario()
        {           
            _scenario.TryGetValue(out TestResult testresult);
            allure.UpdateTestCase(testresult.uuid, x => x.name = x.name + ": " 
            + _scenario.ScenarioInfo.Description);
           // allure.UpdateTestCase(testresult.uuid, x => x.labels.Add("Date", "050505");

        }

        [BeforeStep]
        public void BeforeAnyStep(ScenarioContext scenarioContext)
        {
            TestContext.Progress.WriteLine("Running step " + scenarioContext.StepContext.StepInfo.Text);
        }
        
    }
}

