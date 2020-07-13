using System;
using System.Data.SqlClient;
using System.Linq;
using Arx.Core.Exceptions;
using Arx.Managers;
using Arx.Utils.Data;
using Arx;
using System.Collections.Generic;
using System.Data;


namespace SpecFlowIntegration.FileProcessingTest.Repository
{
    public class AccountTestRepository : BaseRepository
    {
        public void UpdateChangeHistoryUserId(int id)
        {
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"
                    update ChangeHistory set userId = 'Quan.Huynh' where id = @id"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                var param = new SqlParameter { ParameterName = "@id", Value = id };
                cmd.Parameters.Add(param);
                cmd.ExecuteNonQuery();
            }
        }

        public void UpdateAccountPhonesLastModified(int accountId, int slot)
        {
            using (var conn = new SqlConnection())
            {
                conn.ConnectionString = ConnectionString;
                var cmd = new SqlCommand((@"
                    update AccountPhones set LastModifiedBy = 'Quan.Huynh' 
                           where accountId = @accountId and displaySlot = @slot"), conn);

                if (conn.State != ConnectionState.Open)
                    conn.Open();

                cmd.Parameters.Add(new SqlParameter { ParameterName = "@accountId", Value = accountId });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "@slot", Value = slot });
                cmd.ExecuteNonQuery();
            }
        }
        
        // should not use this, will remove later
        public void UpdatePhoneStatus(int accountid,
           int slot,
           string newString,
           string oldString
           )
        {
            var noteType = 220 + slot;
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




        //todo: change all above methods to update field


        public void UpdatePhone(Phone newPhone, Phone oldPhone, List<PropertyMapping> propertyMappings, string userId, int positionId)
        {

            UpdateField<Phone>(newPhone, oldPhone, propertyMappings, userId, positionId, newPhone.AccountId, newPhone.PhoneSlot);

            var parameter = new[]
            {
                DataUtilities.CreateNullableSqlParameter("@AccountID", newPhone.AccountId),
                DataUtilities.CreateNullableSqlParameter("@SlotNumber", newPhone.PhoneSlot),
                DataUtilities.CreateNullableSqlParameter("@LocationType", newPhone.LocationType),
                DataUtilities.CreateNullableSqlParameter("@ServiceType", newPhone.ServiceType),
                DataUtilities.CreateNullableSqlParameter("@ConsentToCall", newPhone.ConsentToCall),
                DataUtilities.CreateNullableSqlParameter("@ConsentToTextMessage ", newPhone.ConsentToTextMessage),
                DataUtilities.CreateNullableSqlParameter("@ConsentToDialer ", newPhone.ConsentForAutomatedDialing),
                DataUtilities.CreateNullableSqlParameter("@VerificationStatus", newPhone.VerificationStatus),
                DataUtilities.CreateNullableSqlParameter("@ConsentedPreferredStartTime", newPhone.ConsentedPreferredStartTime),
                DataUtilities.CreateNullableSqlParameter("@ConsentedPreferredEndTime", newPhone.ConsentedPreferredEndTime),
                DataUtilities.CreateNullableSqlParameter("@LastWashSendDate", newPhone.LastWashSendDate),
                DataUtilities.CreateNullableSqlParameter("@ExternalScore", newPhone.ExternalScore),
                DataUtilities.CreateNullableSqlParameter("@UserID", userId),
                DataUtilities.CreateNullableSqlParameter("@PositionID", positionId)
            };

            DataUtilities.SqlExecuteStoredProcedureNonQuery(ConnectionString, "spSaveAccountPhone", parameter);
        }


        public void UpdateField<T>(T newObject, T oldObject, List<PropertyMapping> propertyMappings, string userId, int positionId, int accountId, int? slot)
        {
            foreach (var field in propertyMappings.Where(mapping => mapping.ChangedField))
            {
                var propertyType = GetUpdateFieldTableType<T>(field.Property);
                var newVal = GetFieldTypeValue(newObject, field.Property, field, propertyType);

                // TODO: oldObject == null: possible compare of value type with null, shouldn't be an issue but could cause problems, consider specifying T to be reference type
                var oldVal = oldObject == null ? String.Empty : GetFieldTypeValue(oldObject, field.Property, field, propertyType);
                if (newVal != oldVal)
                {
                    var fieldType = GetUpdateFieldTableType<T>(field.Property);
                    var tableType = UpdateFieldTablesMapping[typeof(T)];
                    var fieldName = field.GetUpdateFieldName(tableType, slot);

                    UpdateField(accountId, fieldName, fieldType, tableType, newVal, oldVal, userId, positionId);
                }
            }
        }

        private void UpdateField(
            int accountId,
            string fieldName,
            PropertyMapping.UpdateFieldDataType fieldType,
            PropertyMapping.UpdateFieldTable tableNumber,
            string newString,
            string oldString,
            string userId,
            int positionId)
        {
            var noteType = ChangedFieldCodeManager.GetChangedFieldCodes().First(code => TrimEquals(code.Name, fieldName) && TrimEquals(code.TableName, tableNumber.ToString()));

            using (var conn = new SqlConnection())
            {
                var parameters = new[]
                {
                    DataUtilities.CreateNullableSqlParameter("@AccountID", accountId),
                    DataUtilities.CreateNullableSqlParameter("@FieldName", fieldName),
                    DataUtilities.CreateNullableSqlParameter("@FieldType", fieldType), //(int)fieldType
                    DataUtilities.CreateNullableSqlParameter("@TableNumber", (int)tableNumber),
                    DataUtilities.CreateNullableSqlParameter("@NewString", newString),
                    DataUtilities.CreateNullableSqlParameter("@OldString", oldString),
                    DataUtilities.CreateNullableSqlParameter("@UserID", userId),
                    DataUtilities.CreateNullableSqlParameter("@PositionID", positionId),
                    DataUtilities.CreateNullableSqlParameter("@NoteType", noteType.CodeId),
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

        #region private_methods

        private static PropertyMapping.UpdateFieldDataType GetUpdateFieldTableType<T>(string property)
        {
            var propertyInfo = typeof(T).GetProperty(property);
            if (propertyInfo == null)
            {
                throw new Exception(String.Format("Property \"{0}\" not found", property));
            }

            return UpdateFieldTableTypesMapping[propertyInfo.PropertyType];
        }

        private static string GetFieldTypeValue(object obj, string property, PropertyMapping mapping, PropertyMapping.UpdateFieldDataType fieldType)
        {
            var objType = obj.GetType();
            var typeProperty = objType.GetProperty(property);
            var propertyValue = typeProperty.GetValue(obj, null);
            if (propertyValue == null)
            {
                return String.Empty;
            }

            string returnValue;
            switch (fieldType)
            {
                case PropertyMapping.UpdateFieldDataType.NumberField:
                    returnValue = typeProperty.PropertyType.IsEnum
                        ? Convert.ToInt32(propertyValue).ToString()
                        : propertyValue.ToString();

                    break;

                case PropertyMapping.UpdateFieldDataType.StringField:
                    returnValue = propertyValue.ToString();
                    break;

                case PropertyMapping.UpdateFieldDataType.DateField:
                    if (propertyValue is DateTime)
                    {
                        var dateValue = (DateTime)propertyValue;
                        returnValue = dateValue == DateTime.MinValue ? String.Empty : $"{dateValue:yyyy-MM-dd HH:mm:ss}";
                    }
                    else
                    {
                        returnValue = String.Empty;
                    }

                    break;

                case PropertyMapping.UpdateFieldDataType.BitField:
                    var boolValue = Convert.ToBoolean(propertyValue);
                    returnValue = boolValue ? "1" : "0";
                    break;

                default:
                    throw new ArgumentOutOfRangeException("fieldType");
            }

            // we have a value, we need to check whether or not it needs to be encrypted.
            // returnValue = mapping.IsEncrypted ? Core.Utilities.AesEncryption.AesEncrypt(returnValue) : Regex.Replace(returnValue, @"((?<!')'(?!'))", "''");

            return returnValue;
        }

        private static readonly Dictionary<Type, PropertyMapping.UpdateFieldTable> UpdateFieldTablesMapping = new Dictionary<Type, PropertyMapping.UpdateFieldTable>
        {
            { typeof(Account), PropertyMapping.UpdateFieldTable.Accounts },
            { typeof(Debtor), PropertyMapping.UpdateFieldTable.Accounts },
            { typeof(AccountExtras), PropertyMapping.UpdateFieldTable.Extras },
            { typeof(AccountInternalExtras), PropertyMapping.UpdateFieldTable.InternalExtras },
            { typeof(Phone), PropertyMapping.UpdateFieldTable.Phones },
            { typeof(Address), PropertyMapping.UpdateFieldTable.Addresses },
            { typeof(DebtorBankAccount), PropertyMapping.UpdateFieldTable.Supplementary },
            { typeof(DebtorEmployer), PropertyMapping.UpdateFieldTable.Supplementary },
            { typeof(Attorney), PropertyMapping.UpdateFieldTable.Supplementary },
            { typeof(DebtorAlias), PropertyMapping.UpdateFieldTable.Contacts },
            { typeof(DebtorEmailAddress), PropertyMapping.UpdateFieldTable.Contacts },
            { typeof(DebtorNextOfKin), PropertyMapping.UpdateFieldTable.Contacts },
            { typeof(DebtorCreditCounselingService), PropertyMapping.UpdateFieldTable.Deathbkccs },
            { typeof(DebtorExecutor), PropertyMapping.UpdateFieldTable.Deathbkccs },
            { typeof(DebtorTrustee), PropertyMapping.UpdateFieldTable.Deathbkccs },
        };

        private static readonly Dictionary<Type, PropertyMapping.UpdateFieldDataType> UpdateFieldTableTypesMapping = new Dictionary<Type, PropertyMapping.UpdateFieldDataType>
        {
            { typeof(string), PropertyMapping.UpdateFieldDataType.StringField },
            { typeof(DateTime), PropertyMapping.UpdateFieldDataType.DateField },
            { typeof(decimal), PropertyMapping.UpdateFieldDataType.NumberField },
            { typeof(int), PropertyMapping.UpdateFieldDataType.NumberField },
            { typeof(bool), PropertyMapping.UpdateFieldDataType.BitField },
            { typeof(DateTime?), PropertyMapping.UpdateFieldDataType.DateField },
            { typeof(decimal?), PropertyMapping.UpdateFieldDataType.NumberField },
            { typeof(int?), PropertyMapping.UpdateFieldDataType.NumberField },
            { typeof(bool?), PropertyMapping.UpdateFieldDataType.BitField },
            { typeof(Account.AccountType), PropertyMapping.UpdateFieldDataType.NumberField }
        };

        private static bool TrimEquals(string a, string b)
        {
            return a.Trim().Equals(b.Trim(), StringComparison.InvariantCultureIgnoreCase);
        }
       
        #endregion
    }
}
