using CitiUSTest.Serializer;

namespace CitiUSTest.Models.IncomingAssignment
{
    [FixedWidthRecord]
    public class AccountRecord:BaseRecord
    {       

        [FixedWidthField(69, 25, null, ' ', false)]
        public string Address1 { get; set; }

        [FixedWidthField(94, 25, null, ' ', false)]
        public string Address2 { get; set; }

        [FixedWidthField(119, 20, null, ' ', false)]
        public string City { get; set; }

        [FixedWidthField(154, 2, null, ' ', false)]
        public string State { get; set; }

        [FixedWidthField(156, 10, null, ' ', false)]
        public string ZipCode { get; set; }

        [FixedWidthField(139, 15, null, ' ', false)]
        public string County { get; set; }

        [FixedWidthField(490, 2, null, ' ', false)]
        public string Occupation { get; set; }

        [FixedWidthField(166, 16, null, ' ', false)]
        public string HomeNumber { get; set; }

        [FixedWidthField(182, 16, null, ' ', false)]
        public string WorkNumber { get; set; }

        [FixedWidthField(672, 1, null, ' ', false)]
        public string HomeIndicator { get; set; }

        [FixedWidthField(673, 1, null, ' ', false)]
        public string WorkIndicator { get; set; }

        [FixedWidthField(309, 3, null, ' ', false)]
        public string AccountStatus { get; set; }

        [FixedWidthField(380, 10, null, ' ', false)]
        public string CurrentBalance { get; set; }

        [FixedWidthField(390, 9, null, ' ', false)]
        public string NetPrinciple { get; set; }

        [FixedWidthField(668, 4, null, ' ', false)]
        public string CommissionRate { get; set; }

        [FixedWidthField(286, 4, null, ' ', false)]
        public string LoanTypeCode { get; set; }

        [FixedWidthField(290, 6, null, ' ', false)]
        public string OfficerCode { get; set; }

        
    }
}
