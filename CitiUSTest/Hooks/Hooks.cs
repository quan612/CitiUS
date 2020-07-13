using System;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow;
using TestLinkReporter;
using Allure.Commons;

namespace CitiUSTest.Hooks
{
    [Binding]
    public class Hooks
    {
        private readonly TestScopeContext _testScope;            
        private ScenarioContext _scenario;

        private const string TestProject = "Citi_US";
        private const string TestPlan = "Automation Test";
        private string _status;        

        public Hooks(TestScopeContext testScope, ScenarioContext scenario)
        {
            _testScope = testScope;
            _scenario = scenario;
        }

        [AfterScenario]
        public void AfterScenario()
        {
            try
            {                
                _testScope.Dispose();
                _status = _scenario.ScenarioExecutionStatus.ToString();
            }
            catch (Exception e)
            {               
                _status = "Failed";
                _testScope.testLinkNotes = _testScope.testLinkNotes + " Test fails at " + e;
            }
            finally
            {
                var currentTestCaseName = _scenario.ScenarioInfo.Description.Replace("\t", "");
                Console.WriteLine("Current test case name " + currentTestCaseName);
                TestLinkReport.Instance.ProcessResult(
                    currentTestCaseName,
                    TestProject,
                    TestPlan,
                    _status,
                    _testScope.testLinkNotes);
            }
        }        
    }
}

