using System;
using CitiUSTest.Serializer;

namespace CitiUSTest.Models.Maintenance
{
    [FixedWidthRecord]
    public class MaintenanceDetailRecord : BaseRecord
    {        
        private string _flag="I";
        private string _transactionDateTime;
        public MaintenanceDetailRecord()
        {
            TransactionCode = OutgoingFileConstants.MaintenanceTransactionCode;
        }

        [FixedWidthField(1, 12, "{0:yyyyMMddHHmm}", ' ', false)]
        public new string TransactionDateTime
        {
            get
            {
                return DateTime.Parse(_transactionDateTime).ToString("yyyyMMddHHmm");
            }

            set { _transactionDateTime = ConvertToDateTimeString.MapStringToDateValue(value); }
        }

        [FixedWidthField(35, 6, null, ' ', false)]
        public string FieldCode { get; set; }

        [FixedWidthField(41, 40, null, ' ', false)]
        public string NewValue { get; set; }

        [FixedWidthField(81, 1, null, ' ', false)]
        public string Flag {
            get
            {
                return _flag;
            }
            set
            {
                _flag =  value;
            }
        }

        [FixedWidthField(96, 4, null, ' ', false)]
        public string MioCode { get; set; }

        [FixedWidthField(100, 1, null, ' ', false)]
        public string EndOfRecordFiller { get; set; }

        //[FixedWidthField(82, 4, null, ' ', false)]
        //public string RecovererCode { get; set; }
    }
}
