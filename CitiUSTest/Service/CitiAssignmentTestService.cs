using System;
using System.Collections.Generic;
using System.Globalization;
using CitiUSTest.Models.IncomingAssignment;
using CitiUSTest.Serializer;
using CitiUSTest.Repository;

namespace CitiUSTest.Service
{
    public class CitiAssignmentTestService
    {
        private static readonly object MyLock = new object();
        private readonly CitiTestRepository _citiTestRepository;
        
        public CitiAssignmentTestService()
        {
            _citiTestRepository = new CitiTestRepository();
        }

        /*Generic method to modify the new business record*/
        public void ModifyNewBusinessRecords<T>(IEnumerable<T> records, string sourceFile, int lineNumber)
        {
            var serializers = new Dictionary<Type, FixedWidthSerializer>
            {
                {typeof(T), new FixedWidthSerializer(typeof(T))}
            };

            foreach (var item in records)
            {
                var t = item.GetType();
                if (serializers.ContainsKey(t))
                {
                    serializers[t].ModifyFields(sourceFile, item, lineNumber);
                }
                else
                {
                    throw new Exception($"Unknown BaseRecord implementation: {t.Name}");
                }
            }
        }


        public void ModifyNewBusinessHeaderRecords(IEnumerable<CitiNbsHeaderRecords> records, string sourceFile, int lineNumber)
        {
            var serializers = new Dictionary<Type, FixedWidthSerializer>
            {
                {typeof(CitiNbsHeaderRecords), new FixedWidthSerializer(typeof(CitiNbsHeaderRecords))},
            };

            foreach (var item in records)
            {
                var t = item.GetType();
                if (serializers.ContainsKey(t))
                {
                    serializers[t].ModifyFields(sourceFile, item, lineNumber);
                }
                else
                {
                    throw new Exception($"Unknown BaseRecord implementation: {t.Name}");
                }
            }

        }




        public void ModifyNewBusinessAccountRecords(
            IEnumerable<AccountRecord> citiNbsAccountRecords,
            string sourceFile, 
            int lineNumber)
        {

            var serializers = new Dictionary<Type, FixedWidthSerializer>
            {
                {typeof(AccountRecord), new FixedWidthSerializer(typeof(AccountRecord))},
            };

            foreach (var item in citiNbsAccountRecords)
            {
                var t = item.GetType();
                if (serializers.ContainsKey(t))
                {
                    serializers[t].ModifyFields(sourceFile, item, lineNumber);
                }
                else
                {
                    throw new Exception($"Unknown BaseRecord implementation: {t.Name}");
                }
            }
        }        

        public void ModifyNewBusinessX00Record(X00Record xRecord, string sourceFile, int lineNumber)
        {
            var serialize = new FixedWidthSerializer(typeof(X00Record));
            serialize.ModifyFields(sourceFile, xRecord, lineNumber);
        }

        public void ModifyNewBusinessX01Record(X01Record xRecord, string sourceFile, int lineNumber)
        {
            var serialize = new FixedWidthSerializer(typeof(X01Record));
            serialize.ModifyFields(sourceFile, xRecord, lineNumber);
        }

        public void ModifyNewBusinessHRecords(IEnumerable<CitiNbsHRecords> hRecords, string sourceFile, int lineNumber)
        {

            var serializers = new Dictionary<Type, FixedWidthSerializer>
            {
                {typeof(CitiNbsHRecords), new FixedWidthSerializer(typeof(CitiNbsHRecords))},
            };

            foreach (var item in hRecords)
            {
                var t = item.GetType();
                if (serializers.ContainsKey(t))
                {
                    serializers[t].ModifyFields(sourceFile, item, lineNumber);
                }
                else
                {
                    throw new Exception($"Unknown BaseRecord implementation: {t.Name}");
                }
            }
        }       

        public void ModifyNewBusinessMRecord(MRecord mRecord, string sourceFile, int lineNumber)
        {
            var serialize = new FixedWidthSerializer(typeof(MRecord));
            serialize.ModifyFields(sourceFile, mRecord, lineNumber);
        }

        public string GetClientAccountNumber(string sourceFolder, string newFile)
        {
            var lastOccupiedClientAccount = _citiTestRepository.GetLastOccupiedClientAccountNumber();
            var newClientAccountNumber = lastOccupiedClientAccount;

            do
            {
                newClientAccountNumber = (Convert.ToDecimal(newClientAccountNumber) + 1).ToString(CultureInfo.InvariantCulture);
            }
            while (_citiTestRepository.IsClientAccountNumberExist(newClientAccountNumber));

            _citiTestRepository.InsertClientAccountToLastOccupiedClientAccountTable(newClientAccountNumber);

            return newClientAccountNumber;
        }

    }
}
