using CitiUSTest.Serializer;

namespace CitiUSTest.Models.IncomingAssignment
{
    [FixedWidthRecord]
    public class MRecord:BaseRecord
    {
       
        [FixedWidthField(167, 20, null, ' ', false)]
        public string BKCaseNumber { get; set; }

        [FixedWidthField(187, 8, null, ' ', false)]
        public string BKFieldDate { get; set; }

        [FixedWidthField(235, 40, null, ' ', false)]
        public string DefAttorneyName { get; set; }

        //...

        [FixedWidthField(412, 40, null, ' ', false)]
        public string DsaName { get; set; }

        [FixedWidthField(452, 40, null, ' ', false)]
        public string DsaAddress1 { get; set; }

        [FixedWidthField(492, 40, null, ' ', false)]
        public string DsaAddress2 { get; set; }

        [FixedWidthField(532, 20, null, ' ', false)]
        public string DsaCity { get; set; }

        [FixedWidthField(552, 2, null, ' ', false)]
        public string DsaState { get; set; }

        [FixedWidthField(554, 10, null, ' ', false)]
        public string DsaZip { get; set; }

        [FixedWidthField(564, 16, null, ' ', false)]
        public string DsaPhone { get; set; }

        [FixedWidthField(580, 40, null, ' ', false)]
        public string DsaEmail { get; set; }
    }
}
