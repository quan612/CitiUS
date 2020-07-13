using System;
using System.IO;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Linq;
using Arx.Managers;
using FileProcessingTest.Repository;
using FileProcessingTest.Contracts.Configurations;
using GlobalCollection.eCollect.Server.Services.DataContracts;
using GlobalCollection.eCollect.DataAccess.Automation;
using FileProcessingTest.Model;

namespace FileProcessingTest.Service
{
    public class CommonTestService
    {
        public readonly CommonTestRepository commonTestRepository;
        private static readonly object _myLock = new object();

        public CommonTestService()
        {
            commonTestRepository = new CommonTestRepository();
        }

        public void PickAndDropFile(string sourcePath, string destinationPath, string fileName)
        {
            File.Copy(sourcePath + fileName, destinationPath + fileName);
        }

        //todo: may change while condition
        public void CheckJobQueue(int clientFileTypeId, long fileReceivedId, int jobType)
        {
            var timeout = DateTime.Now.Add(TimeSpan.FromSeconds(600));
            var status = JobQueueStatus.Queued;
            
            do
            {
                var jobQueue = commonTestRepository.GetJobQueueEntry(clientFileTypeId, fileReceivedId, jobType);

                foreach (var field in jobQueue)
                {
                    status = field.Status;
                }
                
            } while ((status == JobQueueStatus.Queued || status == JobQueueStatus.InProgress) && DateTime.Now <= timeout);

            switch (status)
            {
                case JobQueueStatus.Success:
                    Console.WriteLine("Job Queue Status = 2. Proceed!!!");
                    break;
                case JobQueueStatus.Error:
                    throw new Exception("Catch status error on processing file, please double check the file Received from the server");
                default:
                    throw new Exception("Job queue is timeout, or status is in queue");
            }
        }

        public void CheckJobQueueBasedOnJobId(long jobQueueId)
        {
            var timeout = DateTime.Now.Add(TimeSpan.FromSeconds(80));
            JobQueueEntry jobQueue;
            var status = JobQueueStatus.Queued;

            do
            {
                jobQueue = commonTestRepository.GetJobQueueEntry(jobQueueId);
                status = jobQueue.Status;
                
            } while ((status == JobQueueStatus.Queued || status == JobQueueStatus.InProgress) && DateTime.Now <= timeout);

            switch (status)
            {
                case JobQueueStatus.Success:
                    Console.WriteLine("Job Queue " + jobQueue.JobQueueId + " has status = 2. Proceed!!!");
                    break;
                case JobQueueStatus.Error:
                    throw new Exception("Catch status error on processing file, please double check the file Received from the server");
                default:
                    throw new Exception("Job queue is timeout, or status is in queue");
            }
        }
        
        /// <summary>
        /// The client account number is increased by 1 before checking with the database
        /// </summary>
        /// <param name="clientAccountNumber"></param>
        /// <returns></returns>
        public string GetNewClientAccountNumber(string clientAccountNumber)
        {
            Console.WriteLine("Current Account Number In database = " + clientAccountNumber);

            do
            {
                clientAccountNumber = (Convert.ToDecimal(clientAccountNumber) + 1).ToString(CultureInfo.InvariantCulture);
            }
            while (commonTestRepository.IsClientAccountNumberExist(clientAccountNumber));

            Console.WriteLine("New Account Number = " + clientAccountNumber);
            return clientAccountNumber;
        }
        

        /// <summary>
        /// Check if the file is picked by file watcher, in order to continue to get fileReceivedId
        /// </summary>
        /// <param name="fileInUncPatch">File Name</param>
        /// 
        public void IsFilePickedByFileWatcher(string fileInUncPatch)
        {
            
            Console.WriteLine("Wait for file " + fileInUncPatch + " to be picked up by file watcher within 300 seconds");
            var timeout = DateTime.Now.Add(TimeSpan.FromSeconds(300));
            while (DateTime.Now <= timeout)
            {
                if (!File.Exists(fileInUncPatch))
                {
                    Console.WriteLine("File is picked by file watcher");
                    break;
                }

                Thread.Sleep(TimeSpan.FromSeconds(1));
                if (DateTime.Now > timeout)
                    throw new Exception("File takes too long to process, over 300 seconds but the file is not picked up!!!");
            }
        }

        public long GetJobQueueIdByJobType(IConfigurationContext configurationContext, long fileReceivedId, int jobType)
        {
            long jobQueueId = 0;
            var jobQueue = commonTestRepository.GetJobQueueEntry(configurationContext.ClientFileTypeId, fileReceivedId, jobType);

            foreach (var field in jobQueue)
            {
                jobQueueId = field.JobQueueId;
                Console.WriteLine("JobQueue Id " + jobQueueId);
            }

            if (jobQueueId == 0)
                throw new Exception("JobQueueId = 0 !!! Please recheck");

            return jobQueueId;
        }

        public long GetJobQueueId(IConfigurationContext configurationContext, long fileReceivedId)
        {
            long jobQueueId = 0;
            var jobQueue = commonTestRepository.GetJobQueueEntry(configurationContext.ClientFileTypeId, fileReceivedId, configurationContext.JobType);

            foreach (var field in jobQueue)
            {
                jobQueueId = field.JobQueueId;
            }

            if (jobQueueId == 0)
                throw new Exception("JobQueueId = 0 !!! Please recheck");
            
            return jobQueueId;
        }

        public JobQueueEntry GetJobQueueBasedOnClientFileType(ClientFileType cft, JobType jobType)
        {
            var jobQueue = commonTestRepository.GetJobQueueBasedOnJobType(cft.ClientFileTypeId, (int)jobType).FirstOrDefault();
            return jobQueue;
        }

        public List<JobQueueEntry> GetDependentJobs(JobQueueEntry job)
        {
            var jobs = commonTestRepository.GetDependentJobs(job);
            return jobs;
        }

        public long GetFileReceivedId(string fileName)
        {
            long fileReceivedId = 0;
            var fileReceived = commonTestRepository.GetFileReceivedEntry(fileName);

            foreach (var field in fileReceived)
            {
                fileReceivedId = field.FileReceivedId;
            }

            if (fileReceivedId == 0)
                throw new Exception("FileReceivedId = 0 !!! Please recheck");
            
            return fileReceivedId;
        }

        public void CheckRowsValidInFileReceivedRow(long fileReceivedId)
        {
            var rows = commonTestRepository.GetRowsValid(fileReceivedId);
            foreach (var row in rows)
            {
                switch (row.Item2)
                {
                    case "N":
                        throw new Exception("FileReceivedRow.ProcessStatus Something wrong please check ");
                    default:
                        break;
                }
            }
        }

        public void CheckRowProcessStatus(long fileReceivedId)
        {
            try
            {
                Thread.Sleep(10000);
                // sleep 10s to get the row status, instead of looping, sometimes there is an error on the job and the row status stays at 0 forever

                var rowProcessStatuses = commonTestRepository.GetRowsProcessStatus(fileReceivedId);

                foreach (var rowStatus in rowProcessStatuses)
                {
                    switch (rowStatus.Item2)
                    {
                        case 0:
                            throw new Exception("FileReceivedRow.ProcessStatus Something wrong please check ");
                        case 1:
                            continue;
                        case 2:
                            throw new Exception("General Error exception. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1);
                        case 3:
                            throw new Exception("Error Account Not Found. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1);
                        case 4:
                            throw new Exception("No Transaction Match Reversal. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1);
                        case 5:
                            throw new Exception("Posting Transaction Error. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1);
                        case 6:
                            throw new Exception("FileReceivedRow.ProcessStatus No Removal Account Closed ");
                        case 7:
                            throw new Exception("Client Mapping Not Found. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1);
                        case 8:
                            throw new Exception("Backed Dated Payment. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1);
                        case 9:
                            throw new Exception("The row is ignored. Status " + rowStatus.Item2 + " at row number " + rowStatus.Item1); ;
                    }
                }
            }

            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public int GetNewAccountId(string clientAccountNumber)
        {
            var account = commonTestRepository.GetNewAccountId(clientAccountNumber);
            return account.FirstOrDefault();
        }
        
        public string DuplicateSourceFile(string sourceFolder, string sourceFile, string testName)
        {
            lock (_myLock)
            {
                var tempFile = Path.GetFileNameWithoutExtension(sourceFile);
                var extension = Path.GetExtension(sourceFile);
                var newFile = tempFile + "_" + testName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + extension;

                File.Copy(sourceFolder + sourceFile, sourceFolder + newFile);
                return newFile;
            }
        }
        
        public bool IsActionCodeApplied(int actionCode, int accountId)
        {
            var listActions = commonTestRepository.GetActionCodesAppliedToAccount(accountId);
            foreach (var code in listActions)
            {
                if (code == actionCode)
                    return true;
            }
            return false;
        }

        public bool IsNoteLineExistOnAccount(string noteLine, int accountId)
        {
            var notes = NoteManager.GetNotes(accountId);
            foreach (var note in notes)
            {
                if (note.Text == noteLine)
                    return true;
            }
            return false;
        }

        public List<AccountPhonesRecords> GetAccountPhonesRecords(int accountId)
        {
            return commonTestRepository.GetAccountPhonesRecords(accountId);
        }
    }    
}