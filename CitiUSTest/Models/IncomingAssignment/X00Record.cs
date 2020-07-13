using CitiUSTest.Serializer;

namespace CitiUSTest.Models.IncomingAssignment
{
    [FixedWidthRecord]
    public class X00Record:BaseRecord
    {
        [FixedWidthField(26, 3, null, ' ', false)]
        public string DaysDelinquent { get; set; }

        [FixedWidthField(29, 1, null, ' ', false)]
        public string DelinquencyBucket { get; set; }

        [FixedWidthField(30, 12, null, ' ', false)]
        public string DelinquencyHistory { get; set; }

        [FixedWidthField(42, 4, null, ' ', false)]
        public string TreatmentTag { get; set; }

        [FixedWidthField(47, 1, null, ' ', false)]
        public string CellIndicator { get; set; }

        [FixedWidthField(48, 16, null, ' ', false)]
        public string CellNumber { get; set; }

        [FixedWidthField(170, 2, null, ' ', false)]
        public string MsaPromoPrefInd { get; set; }

        [FixedWidthField(172, 40, null, ' ', false)]
        public string MsaEmail1Addr { get; set; }

        [FixedWidthField(212, 1, null, ' ', false)]
        public string MsaEmail1Usblty { get; set; }

        [FixedWidthField(213, 1, null, ' ', false)]
        public string MsaEmail1Cnsnt { get; set; }

        [FixedWidthField(214, 40, null, ' ', false)]
        public string MsaEmail2Addr { get; set; }

        [FixedWidthField(255, 1, null, ' ', false)]
        public string MsaEmail2Usblty { get; set; }

        [FixedWidthField(254, 1, null, ' ', false)]
        public string MsaEmail2Cnsnt { get; set; }

        [FixedWidthField(256, 8, null, ' ', false)]
        public string MsaDtLasReage { get; set; }

        [FixedWidthField(264, 1, null, ' ', false)]
        public string MsaErlyCoInd { get; set; }

        [FixedWidthField(265, 8, null, ' ', false)]
        public string MsaDtLstBadCk { get; set; }

        [FixedWidthField(273, 8, null, ' ', false)]
        public string MsaLstStmtDt { get; set; }

        [FixedWidthField(281, 8, null, ' ', false)]
        public string MsaNxtStmtDt { get; set; }

        [FixedWidthField(289, 8, null, ' ', false)]
        public string MsaCloseDt { get; set; }



        [FixedWidthField(322, 13, null, ' ', true)]
        public string ChargeOffAmount { get; set; }

        [FixedWidthField(335, 13, null, ' ', true)]
        public string ChargeOffInterest { get; set; }

        [FixedWidthField(348, 13, null, ' ', true)]
        public string ChargeOffFees { get; set; }

        [FixedWidthField(361, 13, null, ' ', true)]
        public string ChargeOffCredit { get; set; }

        [FixedWidthField(374, 13, null, ' ', true)]
        public string ChargeOffPayments { get; set; }

        [FixedWidthField(387, 13, null, ' ', false)]
        public string OtherDebt { get; set; }
       
        [FixedWidthField(613, 20, null, ' ', false)]
        public string FourthPhoneNumber { get; set; }

        [FixedWidthField(633, 1, null, ' ', false)]
        public string FourthPhoneIndicator { get; set; }

        [FixedWidthField(634, 1, null, ' ', false)]
        public string FourthPhoneType { get; set; }

        [FixedWidthField(635, 1, null, ' ', false)]
        public string MsaDeviceType { get; set; }

    }
}
