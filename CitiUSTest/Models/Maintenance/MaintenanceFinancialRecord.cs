using System;
using CitiUSTest.Serializer;

namespace CitiUSTest.Models.Maintenance
{
    [FixedWidthRecord]
    public class MaintenanceFinancialRecord: BaseRecord
    {
        private string _commissionPercent;
        private string _transactionDateTime;
        public const string InternalExternalFlag = "I";

        public MaintenanceFinancialRecord()
        {
            
        }

        //public int AccountId { get; set; }        

        [FixedWidthField(1, 12, "{0:yyyyMMddHHmm}", ' ', false)]
        public new string TransactionDateTime
        {
            get
            {
                return DateTime.Parse(_transactionDateTime).ToString("yyyyMMddHHmm");
            }

            set { _transactionDateTime = ConvertToDateTimeString.MapStringToDateValue(value); }
        }

        //[FixedWidthField(13, 20, null, ' ', false)]
        //public string AccountNumber { get; set; }

        //[FixedWidthField(33, 2, null, ' ', false)]
        //public string TransactionCode { get; set; }

        [FixedWidthField(35, 10, null, ' ', false)]
        public string TransactionAmount { get; set; }

        [FixedWidthField(45, 1, null, ' ', false)]
        public string InterestFlag => "N";

        [FixedWidthField(46, 1, null, ' ', false)]
        public string SelfDirectedFlag => " ";

        [FixedWidthField(47, 19, null, ' ', false)]
        public string TransactionDescription { get; set; }

        [FixedWidthField(67, 10, null, ' ', false)]
        public string NetPaymentAmount => TransactionAmount;

        [FixedWidthField(77, 4, null, ' ', false)]
        public string CommissionPercent
        {
            get
            {
                return string.IsNullOrEmpty(_commissionPercent) ? "000{" : _commissionPercent;
            }

            set { _commissionPercent = value; }
        }

        [FixedWidthField(81, 1, null, ' ', false)]
        public string Flag => InternalExternalFlag;

        //[FixedWidthField(82, 4, null, ' ', false)]
        //public string RecovererCode { get; set; }

        [FixedWidthField(86, 7, null, ' ', false)]
        public new string RecovererId => "system";

        [FixedWidthField(94, 2, null, ' ', false)]
        public string Filler1 { get; set; }

        [FixedWidthField(96, 4, null, ' ', false)]
        public string MioCode { get; set; }

        [FixedWidthField(100, 1, null, ' ', false)]
        public string EndOfRecordFiller { get; set; }
    }
}
