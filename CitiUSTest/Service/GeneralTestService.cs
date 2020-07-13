using System.Collections.Generic;
using CitiUSTest.Repository;
using CitiUSTest.Models;

namespace CitiUSTest.Service
{
    public class GeneralTestService
    {
        private readonly CitiTestRepository _citiTestRepository;
        public GeneralTestService()
        {
            _citiTestRepository = new CitiTestRepository();
        }

        public List<CitiPhoneTrackerRecords> GetCitiPhoneTrackerRecords(int accountId)
        {
           return _citiTestRepository.GetCitiPhoneTrackers(accountId);
        }

        public List<AccountAddressesRecords> GetAccountAddressesRecords(int accountId)
        {
            return _citiTestRepository.GetAccountAddressesRecords(accountId);
        }

        public List<CitiExtrasOverflow> GetCitiExtrasOverflow(int accountId)
        {
            return _citiTestRepository.GetCitiExtrasOverflow(accountId);
        }
    }
}
