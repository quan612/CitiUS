using SpecFlowIntegration.FileProcessingTest.Contracts;

namespace CitiUSTest.Models
{
    public class CitiNbsConfigurations : IConfigurationContext
    {

        public string UncPath { get; } = @"\\timon\Servers\Taskserver02\PartnerNet\Citi\ReceivedFiles\";

        public string SourceFolder { get; } = @"\\timon\IncomingFiles\Test\New folder\";

        public string SourceFile { get; } = "ca_Sample_A_00.dl";

        public int ClientFileTypeId { get; } = 1;

        public int JobType { get; } = 4;
    }
}
