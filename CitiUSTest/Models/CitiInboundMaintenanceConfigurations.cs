
using SpecFlowIntegration.FileProcessingTest.Contracts;

namespace CitiUSTest.Models
{
    public class CitiInboundMaintenanceConfigurations : IConfigurationContext
    {
        public string SourceFile { get; set; }
        public string UncPath { get; } = @"\\timon\Servers\Taskserver02\PartnerNet\Citi\ReceivedFiles\";
        public string SourceFolder { get; } = @"\\timon\IncomingFiles\Test\New folder\";
        public int ClientFileTypeId { get; } = 2;
        public int JobType { get; } = 4;
    }
}
