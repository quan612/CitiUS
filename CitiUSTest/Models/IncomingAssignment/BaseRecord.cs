using CitiUSTest.Serializer;

namespace CitiUSTest.Models.IncomingAssignment
{
    [FixedWidthRecord]
    public class BaseRecord
    {
        [FixedWidthField(1, 20, null, ' ', false)]
        public string ClientAccountNumber { get; set; }

        [FixedWidthField(21, 1, null, ' ', false)]
        public string RecordType { get; set; }

        [FixedWidthField(692, 4, null, ' ', false)]
        public string MioCode { get; set; }

        [FixedWidthField(696, 4, null, ' ', false)]
        public string RecovererCode { get; set; }
    }
}
