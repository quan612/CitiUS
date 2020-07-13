using System;
using System.Collections.Generic;
using System.Linq;
using Arx;
using Arx.Managers;
using Arx.Utils.Data;

using SpecFlowIntegration.FileProcessingTest.Repository;

namespace SpecFlowIntegration.FileProcessingTest.Service
{
    public class AccountTestService
    {
        private readonly AccountTestRepository _accountTestRepository;
        private const string UserId = "Quan.Huynh";
        private const int PositionId = 3;

        public AccountTestService()
        {
            _accountTestRepository = new AccountTestRepository();
        }

        public void UpdateAddress(int accountId, Address newAddress, Address oldAddress)
        {
            _accountTestRepository.UpdateField<Address>(newAddress, oldAddress, AddressFieldMappings, UserId, PositionId, accountId, newAddress.AddressSlot);
        }

        public void UpdatePhone(Phone newPhone, Phone oldPhone)
        {
           _accountTestRepository.UpdatePhone(newPhone, oldPhone, PhoneFieldMappings, UserId, PositionId);
        }

        public void AddPhoneNumber(
            int accountId,
            string phoneNumber,
            Phone.PhoneServiceTypes phoneServiceType,
            Phone.PhoneLocationTypes phoneLocationType,
            int slot,
            string phoneStatusId)
        {

            if (string.IsNullOrEmpty(phoneNumber)) throw new Exception("Phone number is empty");

            var phone = new Phone
            {
                AccountId = accountId,
                PhoneNumber = phoneNumber,
                ServiceType = phoneServiceType,
                LocationType = phoneLocationType,
                PhoneSlot = slot,
                PhoneStatusId = phoneStatusId
            };

            PhoneManager.SavePhone(phone, UserId, PositionId);
            var account = AccountManager.GetAccount(accountId);
            account.Phones.Add(phone);
        }

        public Phone DuplicateThisPhone(Phone oldPhone)
        {
            var newPhone = new Phone()
            {
                AccountId = oldPhone.AccountId,
                PhoneNumber = oldPhone.PhoneNumber,
                PhoneStatusId = oldPhone.PhoneStatusId,
                Created = oldPhone.Created,
                ConsentedPreferredEndTime = oldPhone.ConsentedPreferredEndTime,
                ConsentedPreferredStartTime = oldPhone.ConsentedPreferredStartTime,
                ConsentGivenOn = oldPhone.ConsentGivenOn,
                LastModified = oldPhone.LastModified,
                LastWashSendDate = oldPhone.LastWashSendDate,
                VerifiedOn = oldPhone.VerifiedOn,
                ConsentGivenCallRecordId = oldPhone.ConsentGivenCallRecordId,
                VerificationCallRecordId = oldPhone.VerificationCallRecordId,
                SourceFileReceivedRowId = oldPhone.SourceFileReceivedRowId,
                ConsentToCall = oldPhone.ConsentToCall,
                ConsentToTextMessage = oldPhone.ConsentToTextMessage,
                ConsentForAutomatedDialing = oldPhone.ConsentForAutomatedDialing,
                PhoneSlot = oldPhone.PhoneSlot,
                LocationType = oldPhone.LocationType,
                ServiceType = oldPhone.ServiceType,
                Source = oldPhone.Source,
                VerificationStatus = oldPhone.VerificationStatus,
                Comment = oldPhone.Comment,
                ConsentRecordedBy = oldPhone.ConsentRecordedBy,
                CountryCode = oldPhone.CountryCode,
                CreatedBy = oldPhone.CreatedBy,
                Extension = oldPhone.Extension,
                LastModifiedBy = oldPhone.LastModifiedBy,
                VerificationRecordedBy = oldPhone.VerificationRecordedBy,
                Deleted = oldPhone.Deleted,
                ExternalScore = oldPhone.ExternalScore,
            };
            return newPhone;
        }

        public string GetPhoneStatusMapping(string phoneStatus)
        {
            string status = phoneStatus.ToUpper();
            switch (status)
            {
                case "WRONG NUMBER":
                    return "I";
                case "ACTIVE":
                    return "A";
                case "NOT IN SERVICE":
                    return "N";
                case "VERBAL DO NOT CALL":
                case "VERBAL DNC":
                    return "V";
                case "WRITTEN DO NOT CALL":
                case "WRITTEN DNC":
                    return "X";
                case "WIRELESS":
                    return "W";
                default:
                    return "I";
            }
        }
        
        #region private methods
        private static readonly List<PropertyMapping> AddressFieldMappings = new List<PropertyMapping>
        {
            new PropertyMapping("AccountId", "AccountID"),
            new PropertyMapping("AddressSlot", "Slot"),
            new PropertyMapping("PrimaryAddress", "IsPrimary"),
            new PropertyMapping("Label", "Label", false, false, true),
            new PropertyMapping("Line1", "Line1", false, false, true),
            new PropertyMapping("Line2", "Line2", false, false, true),
            new PropertyMapping("City", "City", false, false, true),
            new PropertyMapping("Province", "Prov", false, false, true),
            new PropertyMapping("PostalCode", "Postal", false, false, true),
            new PropertyMapping("Country", "Country", false, false, true),
            new PropertyMapping("MailReturnDate", "MRDate", false, false, true),
            new PropertyMapping("MailReturnReason", "MRReason", false, false, true),
            new PropertyMapping("OkToMail", "OKToMail", false, false, true),
        };

        private static readonly List<PropertyMapping> PhoneFieldMappings = new List<PropertyMapping>
        {
            new PropertyMapping("AccountId", "AccountID"),
            new PropertyMapping("PhoneNumber", "Phone", false, false, true),
            new PropertyMapping("PhoneStatusId", "PhoneStatus", false, false, true),
            
            //this is not working, the location service is still updated but there won't be a noteline
            //new PropertyMapping("LocationType", "LocationType", false, false, true),
            //new PropertyMapping("ServiceType", "ServiceType", false, false, true),
        };
        #endregion
    }
}
