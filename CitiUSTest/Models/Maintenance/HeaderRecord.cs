using System;
using Arx.Core.Utilities;
using CitiUSTest.Serializer;

namespace CitiUSTest.Models.Maintenance
{
    [FixedWidthRecord]
    public class HeaderRecord : BaseRecord
    {
        private decimal _grossBatchTotalAmount;
        private decimal _netBatchTotalAmount;

        public HeaderRecord()
        {
            TransactionCode = OutgoingFileConstants.HeaderTransactionCode;
        }

        [FixedWidthField(1, 12, "{0:yyyyMMdd}", ' ', false)]
        public new DateTime TransactionDateTime { get; set; }

        [FixedWidthField(64, 4, null, ' ', false)]
        public string CreditorId { get; set; }

        public decimal GrossBatchTotalAmount
        {
            get { return _grossBatchTotalAmount; }
            set { _grossBatchTotalAmount = Math.Round(value, 2, MidpointRounding.AwayFromZero); }
        }

        [FixedWidthField(35, 10, null, '0', true)]
        public string GrossAmount => GrossBatchTotalAmount.ToEbcdicZonedDecimalString(2);

        public decimal NetBatchTotalAmount
        {
            get { return _netBatchTotalAmount; }
            set { _netBatchTotalAmount = Math.Round(value, 2, MidpointRounding.AwayFromZero); }
        }

        [FixedWidthField(45, 10, null, '0', true)]
        public string NetBatchAmount => NetBatchTotalAmount.ToEbcdicZonedDecimalString(2);

        [FixedWidthField(55, 5, null, '0', true)]
        public int TransactionCount { get; set; }

        [FixedWidthField(60, 4, null, ' ', false)]
        public new string RecovererCode { get; set; }

        [FixedWidthField(86, 7, null, ' ', false)]
        public new string RecovererId => "";

        [FixedWidthField(96, 4, null, ' ', false)]
        public string MioCode { get; set; }

        //[FixedWidthField(94, 7)]
        //public string Filler { get; set; }
    }
}
