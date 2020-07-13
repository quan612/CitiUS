using Arx;

namespace FileProcessingTest.Model
{
    public class AccountPhonesRecords
    {
        public int AccountId { get; set; }
        public string PhoneNumber { get; set; }
        public string PhoneStatus { get; set; }
        public string DisplaySlot { get; set; }
        public Phone.PhoneServiceTypes ServiceType { get; set; }
        public Phone.PhoneLocationTypes LocationType { get; set; }

    }
}
