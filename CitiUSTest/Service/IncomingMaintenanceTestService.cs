using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Arx.Managers;
using CitiUSTest.Models.Maintenance;
using CitiUSTest.Serializer;

namespace CitiUSTest.Service
{
    public class IncomingMaintenanceTestService
    {
        private readonly Dictionary<string, Dictionary<int, List<BaseRecord>>> _fileItems;
        private readonly List<BaseRecord> _finalItems;
        private IncomingMaintenanceItems _mtRecordsToAppend;

        private readonly Dictionary<string, Dictionary<int, List<BaseRecord>>> _financialItems;
        private readonly List<BaseRecord> _finalFinancialItems;
        private IncomingFinancialItems _financialRecordsToAppend;

        public IncomingMaintenanceTestService()
        {
            _finalItems = new List<BaseRecord>();
            _fileItems = new Dictionary<string, Dictionary<int, List<BaseRecord>>>();

            _finalFinancialItems = new List<BaseRecord>();
            _financialItems = new Dictionary<string, Dictionary<int, List<BaseRecord>>>();
        }

        #region Maintenance test service

        public void CreateMaintenanceFileHeader()
        {
            var header = new HeaderRecord
            {
                TransactionDateTime = DateTime.Today,
                RecovererCode = "GIC",
                CreditorId = "0645",
            };

            _finalItems.Add(header);
        }

        public void BuildMaintenanceItems(
            string transactionDateTime,
            int accountId,
            string transactionCode,
            string fieldCode,
            string newValue,
            string flag,
            string recovererId)
        {
            if (string.IsNullOrEmpty(flag)) flag = "I";
            if (string.IsNullOrEmpty(recovererId)) recovererId = "BATCH";
            _mtRecordsToAppend = new IncomingMaintenanceItems
            {
                TransactionDateTime = transactionDateTime,
                AccountId = accountId,
                TransactionCode = transactionCode,
                FieldCode = fieldCode,
                NewValue = newValue,
                Flag = flag,
                RecovererId = recovererId
            };
            AddMaintenanceItems(_mtRecordsToAppend.ToDetailRecord(fieldCode, newValue));
        }

        private void AddMaintenanceItems(BaseRecord record)
        {
            if (!_fileItems.ContainsKey(record.RecovererCode))
            {
                _fileItems.Add(record.RecovererCode, new Dictionary<int, List<BaseRecord>>());
            }

            if (!_fileItems[record.RecovererCode].ContainsKey(record.AccountId))
            {
                _fileItems[record.RecovererCode].Add(record.AccountId, new List<BaseRecord>());
            }

            _fileItems[record.RecovererCode][record.AccountId].Add(record);
        }

        public void PrepareMaintenanceItems()
        {
            foreach (var recoverer in _fileItems.Keys)
            {
                var items = _fileItems[recoverer][_mtRecordsToAppend.AccountId];
                foreach (var item in items)
                {
                    _finalItems.Add(item);
                }
            }
        }

        public string WriteMaintenanceFile(string scenarioTitle, string sourceFolder)
        {
            var parameters = DateTime.Now.ToString("yyyyMMddHHmmss");
            var fileName = scenarioTitle + "_" + parameters + ".mt";
            var fullPathFile = Path.Combine(sourceFolder, fileName);

            //using (var writer = new StreamWriter(_fileName, false, Cft.FileEncoding ?? Encoding.ASCII))
            using (var writer = new StreamWriter(fullPathFile, false, Encoding.ASCII))
            {
                var serializers = new Dictionary<Type, FixedWidthSerializer>
                {
                    { typeof(HeaderRecord), new FixedWidthSerializer(typeof(HeaderRecord)) },
                    { typeof(MaintenanceDetailRecord), new FixedWidthSerializer(typeof(MaintenanceDetailRecord)) },
                    //{ typeof(MaintenanceCommentRecord), new FixedWidthSerializer(typeof(MaintenanceCommentRecord)) }
                };

                foreach (var item in _finalItems)
                {
                    var t = item.GetType();
                    if (serializers.ContainsKey(t))
                    {
                        serializers[t].Serialize(writer, item);
                    }
                    else
                    {
                        throw new Exception($"Unknown BaseRecord implementation: {t.Name}");
                    }

                    writer.WriteLine();
                }
            }

            return fileName;
        }
#endregion

        #region Financial test service
        public void CreateFinancialFileHeader(int accountId)
        {
            var accountExtras = AccountExtrasManager.GetAccountExtras(accountId);
            var header = new HeaderRecord
            {
                TransactionDateTime = DateTime.Today,
                RecovererCode = "GIC",
                CreditorId = "0645",
                MioCode = accountExtras.Text11
            };

            _finalFinancialItems.Add(header);
        }
        
        public void BuildFinancialItems(
            string transactionDateTime,
            int accountId,
            string transactionCode,
            string transactionAmount
            )
        {
            _financialRecordsToAppend = new IncomingFinancialItems
            {
                TransactionDateTime = transactionDateTime,
                AccountId = accountId,
                TransactionCode = transactionCode,
                TransactionAmount = transactionAmount
            };

            AddFinancialItems(_financialRecordsToAppend.ToFinancialRecord(transactionCode, transactionAmount));
        }



        public void PrepareFinancialItems()
        {
            foreach (var recoverer in _financialItems.Keys)
            {
                var items = _financialItems[recoverer][_financialRecordsToAppend.AccountId];
                foreach (var item in items)
                {
                    _finalFinancialItems.Add(item);
                }
            }
        }

        public string WriteFinancialFile(string scenarioTitle, string sourceFolder)
        {
            var parameters = DateTime.Now.ToString("yyyyMMddHHmmss");
            var fileName = scenarioTitle + "_" + parameters + ".mt";
            var fullPathFile = Path.Combine(sourceFolder, fileName);
            
            using (var writer = new StreamWriter(fullPathFile, false, Encoding.ASCII))
            {
                var serializers = new Dictionary<Type, FixedWidthSerializer>
                {
                    { typeof(HeaderRecord), new FixedWidthSerializer(typeof(HeaderRecord)) },
                    { typeof(MaintenanceFinancialRecord), new FixedWidthSerializer(typeof(MaintenanceFinancialRecord)) },

                };

                foreach (var item in _finalFinancialItems)
                {
                    var t = item.GetType();
                    if (serializers.ContainsKey(t))
                    {
                        serializers[t].Serialize(writer, item);
                    }
                    else
                    {
                        throw new Exception($"Unknown BaseRecord implementation: {t.Name}");
                    }

                    writer.WriteLine();
                }
            }

            return fileName;
        }

        private void AddFinancialItems(MaintenanceFinancialRecord record)
        {
            if (!_financialItems.ContainsKey(record.RecovererCode))
            {
                _financialItems.Add(record.RecovererCode, new Dictionary<int, List<BaseRecord>>());
            }

            if (!_financialItems[record.RecovererCode].ContainsKey(record.AccountId))
            {
                _financialItems[record.RecovererCode].Add(record.AccountId, new List<BaseRecord>());
            }

            _financialItems[record.RecovererCode][record.AccountId].Add(record);
        }

        #endregion
    }
}
