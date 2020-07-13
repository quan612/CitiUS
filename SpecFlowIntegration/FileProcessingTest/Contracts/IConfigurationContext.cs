namespace SpecFlowIntegration.FileProcessingTest.Contracts
{
    public interface IConfigurationContext{

        string SourceFile { get; }
        string SourceFolder { get; }
        string UncPath { get; }
        int ClientFileTypeId { get; }
        int JobType { get; }
    }
}
