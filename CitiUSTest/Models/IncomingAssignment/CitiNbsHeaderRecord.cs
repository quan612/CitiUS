using System;
using CitiUSTest.Serializer;

namespace CitiUSTest.Models.IncomingAssignment
{
    [FixedWidthRecord]
    public class CitiNbsHeaderRecords
    {
        private string _listDate=DateTime.Now.ToString();

        [FixedWidthField(15, 8, "{0:yyyyMMdd}", ' ', false)]
        public string ListDate
        {
            get
            {
                return DateTime.Parse(_listDate).ToString("yyyyMMdd");
            }

            set { _listDate = ConvertToDateTimeString.MapStringToDateValue(value); }
        }

        [FixedWidthField(692, 4, null, ' ', false)]
        public string MioCode { get; set; }

    }
}
