using System.Data;
using System.Data.SqlClient;
using Arx.Utils.Data;
using System.Collections.Generic;
using Arx.Core.Exceptions;
using GlobalCollection.eCollect.Server.Services.DTO.FileSent;
using CitiUSTest.Models;
using SpecFlowIntegration.FileProcessingTest.Repository;


namespace CitiUSTest.Repository
{
    public class CitiTestRepository:CommonTestRepository
    {      
        public CitiTestRepository()
        {
             DataUtilities.CommandTimeout = 300;
        }

        public string GetLastOccupiedClientAccountNumber()
        {
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"select top 1 ClientAccount 
                                    from [eCollectApps].[Automation].[LastOccupiedClientAccount] order by 1 desc"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                object clientAccount = null;
                using (var reader = cmd.ExecuteReader())
                {
                    var dt = new DataTable();
                    dt.Load(reader);

                    foreach (DataRow row in dt.Rows)
                    {
                        clientAccount = row["ClientAccount"];
                    }
                }

                return clientAccount != null ?
                      clientAccount.ToString() : "1";
            }
        }

        public void InsertClientAccountToLastOccupiedClientAccountTable(string clientAccount)
        {
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"insert into [eCollectApps].[Automation].[LastOccupiedClientAccount] 
                                            (clientAccount) values (@clientAccount)"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                var param = new SqlParameter { ParameterName = "@clientAccount", Value = clientAccount };
                cmd.Parameters.Add(param);

                cmd.ExecuteNonQuery();
            }
        }

        public List<FileSentRecord> GetFileList(int clientFileTypeId)
        {
            using (var conn = new SqlConnection())
            {
                const string sql = @"Select top 1 * from [eCollect_v1_1].[dbo].[fileSent] where clientFileTypeId = @clientFileTypeId order by 1 desc";

                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@clientFileTypeId", clientFileTypeId)
                };

                return DataUtilities.SqlExecuteReader<FileSentRecord>(ConnectionString, DataUtilities.CommandTimeout, sql, parameters);
            }
        }

        public void GeneratingOutboundMaintenance(int clientFileTypeId)
        {
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"
                    DECLARE @newID bigint 
                        INSERT INTO eCollect_v1_1.dbo.JobQueue (ClientFileTypeId, JobType, EnqueueDate, Status, DependsOnJobQueueId, OnHold)
                            VALUES (@cftId, 6, GETDATE(), 0, null, 0);
                            SELECT @newId = SCOPE_IDENTITY(); 
    
                        INSERT INTO eCollect_v1_1.dbo.JobQueue (ClientFileTypeId, JobType, EnqueueDate, Status, DependsOnJobQueueId, OnHold)
                            VALUES (@cftId, 5, GETDATE(), 0, @newId, 0);
                            SELECT @newId = SCOPE_IDENTITY();"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                var param = new SqlParameter { ParameterName = "@cftId", Value = clientFileTypeId };
                cmd.Parameters.Add(param);
                cmd.ExecuteNonQuery();
            }
        }
       
        public void UpdatePhoneStatus(int accountid,
            int slot,
           // PropertyMapping.UpdateFieldDataType fieldType,
           // PropertyMapping.UpdateFieldTable tableNumber,
            string newString,
            string oldString
            )
        {
            var noteType = 220 + slot;
            // var noteType = ChangedFieldCodes.First(code => TrimEquals(code.Name, fieldName) && TrimEquals(code.TableName, tableNumber.ToString()));
            // var fieldName1 = field.GetUpdateFieldName(tableType, slot);
            using (var conn = new SqlConnection())
            {
                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@AccountID", accountid),
                    DataUtilities.CreateNullableSqlParameter("@FieldName", "PhoneStatus" + slot.ToString()),
                    DataUtilities.CreateNullableSqlParameter("@FieldType", 0), //(int)fieldType
                    DataUtilities.CreateNullableSqlParameter("@TableNumber", 2), //account phone table = 2
                    DataUtilities.CreateNullableSqlParameter("@NewString", newString),
                    DataUtilities.CreateNullableSqlParameter("@OldString", oldString),
                    DataUtilities.CreateNullableSqlParameter("@UserID", "A"),
                    DataUtilities.CreateNullableSqlParameter("@PositionID", 3), //Quan positionid
                    DataUtilities.CreateNullableSqlParameter("@NoteType", noteType.ToString()),
                    DataUtilities.CreateNullableSqlParameter("@UpdateLastWorkDate", 0),
                    DataUtilities.CreateNullableSqlParameter("@IsUpdatePhoneStatusOK", 100)
                };

                int returnValue;
                DataUtilities.SqlExecuteStoredProcedureNonQuery(ConnectionString, "spUpdateField", parameters, out returnValue);

                if (returnValue != 0)
                {
                    throw new UpdateFieldException(returnValue);
                }
            }
        }
        
        public List<CitiPhoneTrackerRecords> GetCitiPhoneTrackers(int accountId)
        {
            using (var conn = new SqlConnection())
            {
                const string sql = @"Select * from eCollectApps.citi.PhoneTracker where accountId = @accountId";

                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@accountId", accountId)
                };

                return DataUtilities.SqlExecuteReader<CitiPhoneTrackerRecords>(
                    ConnectionString, 
                    DataUtilities.CommandTimeout, 
                    sql, 
                    parameters);
            }
        }

        public List<CitiExtrasOverflow> GetCitiExtrasOverflow(int accountId)
        {
            using (var conn = new SqlConnection())
            {
                const string sql = @"select e.AccountId, e.FieldCodeMappingId, f.Code as Field, e.Value 
                                        from eCollectApps.Citi.ExtrasOverflow e
	                                    join FieldCodesMapping f on e.FieldCodeMappingId = f.FieldCodesMappingId
	                                        where accountId = @accountId";

                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@accountId", accountId)
                };               

                return DataUtilities.SqlExecuteReader<CitiExtrasOverflow>(
                    ConnectionString,
                    DataUtilities.CommandTimeout,
                    sql,
                    parameters);
            }
        }

        public List<AccountAddressesRecords> GetAccountAddressesRecords(int accountId)
        {
            using (var conn = new SqlConnection())
            {
                const string sql = @"Select * from eCollect_v1_1.dbo.Addresses where accountId = @accountId";

                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@accountId", accountId)
                };

                return DataUtilities.SqlExecuteReader<AccountAddressesRecords>(
                    ConnectionString,
                    DataUtilities.CommandTimeout,
                    sql,
                    parameters);
            }
        }
       
    }
}
