using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using CitiUSTest.Models.Maintenance;
using CitiUSTest.Repository;
using CitiUSTest.Serializer;
using GlobalCollection.eCollect.DataAccess.Automation;

namespace CitiUSTest.Service
{
    public class OutgoingMaintenanceTestService
    {
        private readonly Dictionary<string, Dictionary<int, List<BaseRecord>>> _fileItems;
        private readonly List<BaseRecord> _finalItems;
        //private IncomingMaintenanceItems _mtRecordsToAppend;
        private readonly CitiTestRepository _citiTestRepository;

        public OutgoingMaintenanceTestService()
        {
            _finalItems = new List<BaseRecord>();
            _fileItems = new Dictionary<string, Dictionary<int, List<BaseRecord>>>();
            _citiTestRepository = new CitiTestRepository();
        }
        
        public void GenerateOutboundMaintenanceFile(ClientFileType cft)
        {
            _citiTestRepository.GeneratingOutboundMaintenance(cft.ClientFileTypeId);
        }
        
        public string GetLastGeneratedMaintenanceFile(ClientFileType cft)
        {
            var list = _citiTestRepository.GetFileList(cft.ClientFileTypeId);
            var file = list.FirstOrDefault();

            if (file != null)
            {
                Console.WriteLine("Generated file is: " + file.UNCPath + file.FileName);
                return file.UNCPath + file.FileName;
            }
                
            return null;
        }
        
        public List<MaintenanceDetailRecord> ReadRecordsFromMaintenanceFile(string fullPathFile)
        {
            var records = new List<MaintenanceDetailRecord>();
            
            var allLines = File.ReadAllLines(fullPathFile);
            var reader = new FixedWidthReader(typeof(MaintenanceDetailRecord));

            for (var i = 1; i <= allLines.Length-1;i++)
            {
                var record = (MaintenanceDetailRecord)reader.ReadRecord(allLines[i]);
                records.Add(record);
            }

            return records;
        }

        public List<MaintenanceCommentRecord> ReadCommentRecordsFromMaintenanceFile(string fullPathFile)
        {
            var records = new List<MaintenanceCommentRecord>();
            var allLines = File.ReadAllLines(fullPathFile);
            var reader = new FixedWidthReader(typeof(MaintenanceCommentRecord));

            for (var i = 1; i <= allLines.Length - 1; i++)
            {
                var record = (MaintenanceCommentRecord)reader.ReadRecord(allLines[i]);
                records.Add(record);
            }

            return records;
        }
    }
}
