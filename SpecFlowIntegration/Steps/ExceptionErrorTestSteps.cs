using System;
using TechTalk.SpecFlow;
using SpecFlowIntegration.Hooks;
using NUnit.Framework;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class ExceptionErrorTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;

        public ExceptionErrorTestSteps(
            TestScopeContext testScope, 
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        [Then(@"An exception error is thrown as (.*)")]
        public void VerifyTheExceptionError(string exception){
            
            try
            {
                var fileReceivedId = _testScope.commonTestService.GetFileReceivedId(_testScope.fileReceived);
                var jobQueueId = _testScope.commonTestService.GetJobQueueId(_testScope.clientConfigurations, fileReceivedId);
                _testScope.commonTestService.CheckJobQueueBasedOnJobId(jobQueueId);
                _testScope.commonTestService.CheckRowsValidInFileReceivedRow(fileReceivedId);
                _testScope.commonTestService.CheckRowProcessStatus(fileReceivedId);
            }
            catch (Exception e)
            {
                if (!e.Message.Contains(exception))
                {
                    _testScope.softAssert.Add(() =>
                    {
                        Assert.Fail("Exception error is not thrown correctly");
                    });
                }
                
            }
        }

        [Then(@"An error happens when processing the row. No matching reversal")]
        public void No_Transaction_Match_Reversal_Found()
        {
            try
            {
                var fileReceivedId = _testScope.commonTestService.GetFileReceivedId(_testScope.fileReceived);
                Console.WriteLine("File received id = " + fileReceivedId);

                var jobQueueId = _testScope.commonTestService.GetJobQueueId(_testScope.clientConfigurations, fileReceivedId);
                Console.WriteLine("Job Queue id = " + jobQueueId);

                _testScope.commonTestService.CheckJobQueueBasedOnJobId(jobQueueId);
                _testScope.commonTestService.CheckRowsValidInFileReceivedRow(fileReceivedId);
                _testScope.commonTestService.CheckRowProcessStatus(fileReceivedId);
            }
            catch (Exception e)
            {
                if (e.Message.Contains("No Transaction Match Reversal"))
                {
                    Assert.Pass("The exception is thrown as expected");
                }
                else
                {
                    Assert.Fail("The exception 'No Transaction Match Reversal' is not thrown as expected");
                }
            }
        }

        [Then(@"A general error status happens when processing the row record")]
        public void General_Error_Status()
        {
            try
            {
                var fileReceivedId = _testScope.commonTestService.GetFileReceivedId(_testScope.fileReceived);
                Console.WriteLine("File received id = " + fileReceivedId);

                var jobQueueId = _testScope.commonTestService.GetJobQueueId(_testScope.clientConfigurations, fileReceivedId);
                Console.WriteLine("Job Queue id = " + jobQueueId);

                _testScope.commonTestService.CheckJobQueueBasedOnJobId(jobQueueId);
                _testScope.commonTestService.CheckRowsValidInFileReceivedRow(fileReceivedId);
                _testScope.commonTestService.CheckRowProcessStatus(fileReceivedId);
            }
            catch (Exception e)
            {
                if (e.Message.Contains("General Error exception."))
                {
                    Assert.Pass("The exception is thrown as expected");
                }
                else
                {
                    Assert.Fail("The exception 'General Error exception' is not thrown as expected");
                }
            }
        }
    }
}
