using Arx;

namespace SpecFlowIntegration.FileProcessingTest.Models
{
    public class AccountPhonesRecords
    {
        public int AccountId { get; set; }
        public string PhoneNumber { get; set; }
        public string PhoneStatus { get; set; }
        public string DisplaySlot { get; set; }
        public Phone.PhoneServiceTypes ServiceType { get; set; }
        public Phone.PhoneLocationTypes LocationType { get; set; }
        public Phone.ConsentMode ConsentToDialer { get; set; }
    }
}
