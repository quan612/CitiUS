using CitiUSTest.Serializer;

namespace CitiUSTest.Models.IncomingAssignment
{
    [FixedWidthRecord]
    public class X01Record:BaseRecord
    {
        [FixedWidthField(31, 13, null, ' ', true)]
        public string MsaDelqBucket1 { get; set; }

        [FixedWidthField(44, 13, null, ' ', true)]
        public string MsaDelqBucket2 { get; set; }

        [FixedWidthField(57, 13, null, ' ', true)]
        public string MsaDelqBucket3 { get; set; }

        [FixedWidthField(70, 13, null, ' ', true)]
        public string MsaDelqBucket4 { get; set; }

        [FixedWidthField(83, 13, null, ' ', true)]
        public string MsaDelqBucket5 { get; set; }

        [FixedWidthField(96, 13, null, ' ', true)]
        public string MsaDelqBucket6 { get; set; }

        [FixedWidthField(109, 13, null, ' ', true)]
        public string MsaRollBck1 { get; set; }

        [FixedWidthField(122, 13, null, ' ', true)]
        public string MsaRollBck2 { get; set; }

        [FixedWidthField(135, 13, null, ' ', true)]
        public string MsaRollBck3 { get; set; }

        [FixedWidthField(148, 13, null, ' ', true)]
        public string MsaRollBck4 { get; set; }

        [FixedWidthField(161, 13, null, ' ', true)]
        public string MsaRollBck5 { get; set; }

        [FixedWidthField(174, 13, null, ' ', true)]
        public string MsaRollBck6 { get; set; }

    }
}
