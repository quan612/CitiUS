using System;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow;
using GlobalCollection.eCollect.Server.Services.DataContracts;


namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class FileProcessingTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;


        public FileProcessingTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        [When(@"The user drops the file to the UNC path, and the file is processed")]
        public void WhenTheUserDropsTheFileAndTheFileIsProcessed()
        {
            WhenTheUserDropsTheFileToUNCPath();
            WhenTheFileIsProcessed();
        }

        [When(@"The user drops the file to the UNC path, and the file is processed and the eCollect Job is done")]
        public void WhenTheUserDropsTheFileAndTheFileIsProcessedAndTheECollectUpdateJobDone()
        {
            WhenTheUserDropsTheFileToUNCPath();
            WhenTheFileIsProcessed();
            When_The_ECollect_Update_Finished();
        }

        [When(@"The user drops the file to the client UNC path")]
        public void WhenTheUserDropsTheFileToUNCPath()
        {
            _testScope.commonTestService.PickAndDropFile(
                _testScope.clientConfigurations.SourceFolder
                , _testScope.clientConfigurations.UncPath
                , _testScope.fileReceived);

            _testScope.commonTestService.IsFilePickedByFileWatcher(_testScope.clientConfigurations.UncPath + _testScope.fileReceived);
        }

        [When(@"The file is processed")]
        public void WhenTheFileIsProcessed()
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
                Console.WriteLine(e);
                throw;
            }
        }

        [When(@"The ECollectUpdate Job is finished")]
        public void When_The_ECollect_Update_Finished()
        {
            var fileReceivedId = _testScope.commonTestService.GetFileReceivedId(_testScope.fileReceived);
            var jobQueueEntry = _testScope.commonTestService.GetJobQueueEntryByJobType(_testScope.clientConfigurations, fileReceivedId, (int)JobType.ECollectUpdate);
            _testScope.commonTestService.CheckJobQueueBasedOnJobId(jobQueueEntry.JobQueueId);
        }

        [When(@"The ECollect Import Job and its dependent job are completed")]
        public void When_The_ECollect_Import_Finished()
        {
            var fileReceivedId = _testScope.commonTestService.GetFileReceivedId(_testScope.fileReceived);
            var currentImportJob = _testScope.commonTestService.GetJobQueueEntryByJobType(_testScope.clientConfigurations, fileReceivedId, (int)JobType.ECollectImport);
            _testScope.commonTestService.CheckJobQueueBasedOnJobId(currentImportJob.JobQueueId);

            var dependentJobs = _testScope.commonTestService.GetDependentJobs(currentImportJob);
            if (dependentJobs.Count != 0)
            {
                foreach (var job in dependentJobs)
                {
                    _testScope.commonTestService.CheckJobQueueBasedOnJobId(job.JobQueueId);
                }
            }
        }

        [When(@"The associated job is completed")]
        public void When_The_Given_Job_Is_Completed()
        {
            try
            {
                var jobQueue = _testScope.commonTestService.GetJobQueueBasedOnClientFileType(_testScope.clientFileType, JobType.FileQueueUpdater);
                var dependentJobs = _testScope.commonTestService.GetDependentJobs(jobQueue);

                _testScope.commonTestService.CheckJobQueueBasedOnJobId(jobQueue.JobQueueId);

                if (dependentJobs.Count != 0)
                {
                    foreach (var job in dependentJobs)
                    {
                        _testScope.commonTestService.CheckJobQueueBasedOnJobId(job.JobQueueId);
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        [When(@"A new account is placed in ARxCollect")]
        public void WhenNewAccountIsPlaced()
        {
            _testScope.accountId = _testScope.commonTestService.GetNewAccountId(_testScope.clientAccount);
            if (_testScope.accountId == 0)
            {
                throw new Exception("No new account placed in ARxCollect");
            }
            Console.WriteLine("The account in current context: " + _testScope.accountId);

            _testScope.testLinkNotes = _testScope.testLinkNotes + " Account tested: " + _testScope.accountId + "\n";


            //_testScope.accountId = 100714520;
        }

    }
}
