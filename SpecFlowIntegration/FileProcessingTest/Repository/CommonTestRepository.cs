using System;
using System.Collections.Generic;
using System.Threading;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using Arx.Utils.Data;
using GlobalCollection.eCollect.Server.Services.DataContracts;
using SpecFlowIntegration.FileProcessingTest.Models;

namespace SpecFlowIntegration.FileProcessingTest.Repository
{
    public class CommonTestRepository:BaseRepository
    {
        //private static string _connection = "Server=Donald\\Release;Database=eCollect_v1_1;UID=sa;PWD=i$qs1234;MultipleActiveResultSets=True;";

        public CommonTestRepository()
        {
             DataUtilities.CommandTimeout = 300;
        }
        public bool IsClientAccountNumberExist(string clientAccountNumber)
        {
            var encAccountNumber = Arx.Core.Utilities.AesEncryption.AesEncrypt(clientAccountNumber, false);
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"	 SELECT CASE WHEN EXISTS
                                                (SELECT 1 FROM eCollect_v1_1.dbo.Accounts WHERE ClientAccount = @clientAccountNumber) THEN 1 ELSE 0 END"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                var param = new SqlParameter { ParameterName = "@clientAccountNumber", Value = encAccountNumber };
                cmd.Parameters.Add(param);

                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        public List<FileReceivedEntry> GetFileReceivedEntry(string fileName)
        {
            const string sql = @"select top 1 * from eCollect_v1_1.dbo.FileReceived (nolock) 
                                where fileName = @fileName ";
            var parameters = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@fileName", fileName)
            };

            return DataUtilities.SqlExecuteReader<FileReceivedEntry>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
        }
        
        public List<JobQueueEntry> GetJobQueueEntry(int clientFileTypeID, long fileReceivedId, int jobType)
        {
            const string sql = @"select top 1 * from eCollect_v1_1.dbo.Jobqueue (nolock) 
                                where clientFileTypeID = @clientFileTypeID 
                                and fileReceivedId = @fileReceivedId 
                                and jobType = @jobType";
            var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@clientFileTypeID", clientFileTypeID),
                    DataUtilities.CreateNullableSqlParameter("@fileReceivedId", fileReceivedId),
                    DataUtilities.CreateNullableSqlParameter("@jobType", jobType)
                };

            return DataUtilities.SqlExecuteReader<JobQueueEntry>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
        }

        public List<JobQueueEntry> GetJobQueueBasedOnJobType(int clientFileTypeId, int jobType)
        {
            const string sql = @"select top 1 * from eCollect_v1_1.dbo.Jobqueue (nolock) 
                                    where clientFileTypeID = @clientFileTypeID                                 
                                    and jobType = @jobType
                                    order by 1 desc";
            var parameters = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@clientFileTypeID", clientFileTypeId),
                DataUtilities.CreateNullableSqlParameter("@jobType", jobType),
            };

            return DataUtilities.SqlExecuteReader<JobQueueEntry>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
        }

        public List<JobQueueEntry> GetDependentJobs(JobQueueEntry job)
        {
            const string sql = @"select * from eCollect_v1_1.dbo.Jobqueue (nolock) 
                                    where dependsOnJobQueueId = @dependsOnJobQueueId ";
            var parameters = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@dependsOnJobQueueId", job.JobQueueId),
            };

            return DataUtilities.SqlExecuteReader<JobQueueEntry>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
        }

        public JobQueueEntry GetJobQueueEntry(long jobQueueId)
        {
            const string sql = @"select * from eCollect_v1_1.dbo.JobQueue (nolock) 
                                where jobQueueId = @jobQueueId";
            var parameters = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@jobQueueId", jobQueueId)
            };

            return DataUtilities.SqlExecuteReader<JobQueueEntry>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters).Single();
        }

        public List<Tuple<int, string>> GetRowsValid(long fileReceivedId)
        {
            var items = new List<Tuple<int, string>>();
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"	 select RowNumberInFile, IsRowValid 
                                                     from eCollect_v1_1.dbo.FileReceivedRow (nolock) 
                                                     where fileReceivedId = @fileReceivedId"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                var param = new SqlParameter {ParameterName = "@fileReceivedId", Value = fileReceivedId};
                cmd.Parameters.Add(param);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(Tuple.Create<int, string>(Convert.ToInt32(reader[0]), reader[1].ToString()));
                    }
                }
            }
            return items;
        }

        public List<Tuple<int, int>> GetRowsProcessStatus(long fileReceivedId)
        {
            var items = new List<Tuple<int, int>>();
            
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand(
                    (@"select RowNumberInFile, ProcessStatus 
                            from eCollect_v1_1.dbo.FileReceivedRow (nolock) where fileReceivedId = @fileReceivedId 
                            order by fileReceivedRowId asc"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                var param = new SqlParameter {ParameterName = "@fileReceivedId", Value = fileReceivedId};
                cmd.Parameters.Add(param);
                
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(Tuple.Create<int, int>(Convert.ToInt32(reader[0]), Convert.ToInt32(reader[1])));
                    }
                }
            }

            return items;
        }

        public string[] GetECollectLogMessage(string eventId)
        {
            Thread.Sleep(20000);
            string[] array = new string[200];
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"	 select message from eCollectApps.dbo.log where EventId=@eventID"), conn);
                if (conn.State != ConnectionState.Open)
                    conn.Open();
                SqlParameter param = new SqlParameter();
                cmd.Parameters.AddWithValue("@eventID", eventId);
                cmd.CommandTimeout = 100;
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    int i = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        array[i] = row["message"].ToString();
                        Console.WriteLine(array[i]);
                        i++;
                    }
                }
            }
            return array;
        }

        public List<int> GetNewAccountId(string clientAccountNumber)
        {
            var encAccountNumber = Arx.Core.Utilities.AesEncryption.AesEncrypt(clientAccountNumber, false);
            
            const string sql = @"select account from eCollect_v1_1.dbo.Accounts (nolock) 
                                                     where clientAccount = @clientAccountNumber";
            var parameters = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@clientAccountNumber", encAccountNumber)
            };
           
            return DataUtilities.SqlExecuteReader<int>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
        }
        

        public List<int> GetActionCodesAppliedToAccount(int accountId)
        {
            const string sql = @"select ActionId from eCollect_v1_1.dbo.ActionHistory (nolock) where accountId = @accountId";
            var parameters = new[]
            {
                new SqlParameter("@accountId", SqlDbType.VarChar) { Value = accountId }
            };

            return DataUtilities.SqlExecuteReader<int>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);

        }

        public List<string> GetListOfClientAccountsFromView(string tableView, string fieldName, long fileReceivedId)
        {
            var sql = @"select " + fieldName + " from "
                      + tableView + " (nolock) where fileReceivedId = @fileReceivedId";

            var parameters = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@fileReceivedId", fileReceivedId),
            };
            return DataUtilities.SqlExecuteReader<string>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
        }

        public List<AccountPhonesRecords> GetAccountPhonesRecords(int accountId)
        {
            using (var conn = new SqlConnection())
            {
                const string sql = @"select * from eCollect_v1_1.dbo.accountphones where accountId = @accountId";

                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@accountId", accountId)
                };

                return DataUtilities.SqlExecuteReader<AccountPhonesRecords>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
            }
        }

        #region Private Methods
        private static DataTable GetDataTable(string sql, SqlParameter[] parameters)
        {
            var dt = new DataTable();

            using (var cnn = new SqlConnection(ConnectionString))
            {
                using (var cmd = new SqlCommand(sql, cnn))
                {
                    cnn.Open();
                    cmd.CommandTimeout = 0;

                    if (parameters != null && parameters.Length > 0)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (var reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                        reader.Close();
                    }
                }
            }
            return dt;
        }
        #endregion
    }
}
