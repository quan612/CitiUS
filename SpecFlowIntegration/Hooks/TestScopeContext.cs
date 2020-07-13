using System;
using SpecFlowIntegration.FileProcessingTest.Contracts;
using SpecFlowIntegration.FileProcessingTest.Helper;
using SpecFlowIntegration.FileProcessingTest.Service;
using NUnit.Framework;
using GlobalCollection.eCollect.DataAccess.Automation;

namespace SpecFlowIntegration.Hooks
{
    public class TestScopeContext : IDisposable
    {
        public CommonTestService commonTestService;
        public SoftAssert softAssert;

        public string testLinkNotes;
        public string clientAccount;
        public int accountId;
        public long fileReceivedId;
        public string fileReceived;
        public string fileSent;
        public IConfigurationContext clientConfigurations;
        public ClientFileType clientFileType;

        public TestScopeContext()
        {
            softAssert = new SoftAssert();
            commonTestService = new CommonTestService();
        }

        public void Dispose()
        {
            try
            {
                softAssert.Dispose();
            }
            catch (AssertionException ex)
            {
                Console.WriteLine(ex);
                throw;
            }
        }
    }
}
