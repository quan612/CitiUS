using System;
using System.Linq;
using System.Configuration;
using TestLinkApi;


namespace TestLinkReporter
{
    public class TestLinkReport
    {
        // Link to api: https://metacpan.org/pod/TestLink::API
        // Using Singleton for the purpose of executing tests in parallel https://csharpindepth.com/articles/Singleton

        private readonly TestLink _testLink;
        private static readonly Lazy<TestLinkReport> Lazy = new Lazy<TestLinkReport>(() => new TestLinkReport());
        public static TestLinkReport Instance => Lazy.Value;

        public void ProcessResult(
            string currentTestCaseName,
            string testProject,
            string testPlan,
            string status,
            string executionNotes
        )
        {
            try
            {
                //var currentTestCaseName = testContext.ScenarioInfo.Description.Replace("\t", "");
                //Getting the test case based on test project, test suite, test plan
                var testPlanRepository = _testLink.getTestPlanByName(testProject, testPlan);
                var testCasesOfTestPlan = _testLink.GetTestCasesForTestPlan(testPlanRepository.id);
                
                var currentTestCaseRepository = _testLink.GetTestCaseIDByName(currentTestCaseName).Single();
                var testCaseRepository = testCasesOfTestPlan.Where(a => a.tc_id == currentTestCaseRepository.id)
                    .ToList().FirstOrDefault();

                var testCaseStatus = GetTestCaseStatus(status);

                if (testCaseRepository == null) Console.WriteLine("Cannot find test case in test plan");
                else
                {
                    _testLink.ReportTCResult(
                        testCaseRepository.tc_id,
                        testPlanRepository.id,
                        testCaseStatus,
                        1,
                        "Timon",
                        false,
                        true,
                        executionNotes);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            

        }
        

        private TestLinkReport()
        {
            var apiKey = ConfigurationManager.AppSettings["apiKey"];
            var testLinkUrl = ConfigurationManager.AppSettings["testLinkUrl"];
            _testLink = new TestLink(apiKey, testLinkUrl);
        }

        private string GetTestCaseStatus(string status)
        {
            switch (status)
            {
                case "OK":
                    return "p";
                case "Failed":
                    return "f";
                case "Blocked":
                    return "b";
                default:
                    return "f";
            }
        }

        //private TestCaseFromTestPlan GetIndividualTestCaseFromListOfTestCases(
        //    List<TestCaseFromTestPlan> testCases, ScenarioContext testContext)
        //{
        //    var currentTestCase = testContext.ScenarioInfo.Description.Replace("\t", "");
        //    var testCaseRepository = testCases.Where(a => a.name == currentTestCase)
        //        .ToList().FirstOrDefault();

        //    if( testCaseRepository != null) return testCaseRepository;
        //    Console.WriteLine("Cannot find test case");
        //    return null;
        //}
    }
}
