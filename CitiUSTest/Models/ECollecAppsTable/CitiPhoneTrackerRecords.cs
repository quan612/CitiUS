using Arx;

namespace CitiUSTest.Models
{
    public class CitiPhoneTrackerRecords
    {
        public int AccountId { get; set; }
        public string PhoneNumber { get; set; }
        public string CitiPhoneNumberField { get; set; }
        public string CitiIndicatorField { get; set; }
        public string CitiIndicator { get; set; }
        public string ArxPhoneStatus { get; set; }
        public Phone.PhoneServiceTypes ArxPhoneServiceType { get; set; }
        public Phone.PhoneLocationTypes ArxPhoneLocationType { get; set; }
    }
}
