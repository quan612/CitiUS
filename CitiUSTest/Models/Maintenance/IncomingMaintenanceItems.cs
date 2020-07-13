using System;
using Arx.Managers;

namespace CitiUSTest.Models.Maintenance
{
    public class IncomingMaintenanceItems
    {
        public string TransactionDateTime { get; set; }
        public int AccountId { get; set; }
        public string TransactionCode { get; set; }
        public string FieldCode { get; set; }
        public string NewValue { get; set; }
        public string Flag { get; set; }
        public string RecovererId { get; set; }

        public MaintenanceDetailRecord ToDetailRecord(string fieldCode, string newValue)
        {
            var account = AccountManager.GetAccount(AccountId);
            var accountExtras = AccountExtrasManager.GetAccountExtras(AccountId);

            var record = new MaintenanceDetailRecord
            {
                TransactionDateTime = TransactionDateTime,
                AccountId = AccountId,
                AccountNumber = account.ClientAccount1,
                FieldCode = fieldCode,
                NewValue = newValue,
                RecovererCode = accountExtras.Text12,
                MioCode = accountExtras.Text11,
                Flag = Flag,
                RecovererId = RecovererId
            };
            return record;
        }
    }
}
