using System;
using Arx.Managers;

namespace CitiUSTest.Models.Maintenance
{
    public class IncomingFinancialItems
    {
        public string TransactionDateTime { get; set; }

        public int AccountId { get; set; }
        public string TransactionCode { get; set; }
        public string TransactionAmount { get; set; }
        public string RecovererCode { get; set; }

        public MaintenanceFinancialRecord ToFinancialRecord(string transactionCode, string transactionAmount)
        {
            var account = AccountManager.GetAccount(AccountId);
            var accountExtras = AccountExtrasManager.GetAccountExtras(AccountId);

            var record = new MaintenanceFinancialRecord()
            {
                TransactionDateTime = TransactionDateTime,
                AccountId = AccountId,
                AccountNumber = account.ClientAccount1,
                TransactionCode = transactionCode,
                TransactionAmount = transactionAmount,
                RecovererCode = accountExtras.Text12,
                MioCode = accountExtras.Text11
            };
            return record;
        }
    }
}
