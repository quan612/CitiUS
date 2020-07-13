using CitiUSTest.Models;
using CitiUSTest.Models.Maintenance;
using CitiUSTest.Service;
using SpecFlowIntegration.Hooks;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CitiUSTest.CustomStepDefinitions
{
    [Binding]
    public class CitiInboundMaintenanceTestStepsDefinition
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;
        
        public CitiInboundMaintenanceTestStepsDefinition(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        private void InternalGenerateMaintenanceFile(Table table)
        {
            var items = table.CreateSet<IncomingMaintenanceItems>();
            var incomingMaintenanceTest = new IncomingMaintenanceTestService();

            incomingMaintenanceTest.CreateMaintenanceFileHeader();
            foreach (var item in items)
            {
                incomingMaintenanceTest.BuildMaintenanceItems(
                    item.TransactionDateTime,
                    _testScope.accountId,
                    item.TransactionCode,
                    item.FieldCode,
                    item.NewValue,
                    item.Flag,
                    item.RecovererId
                    );
            }

            incomingMaintenanceTest.PrepareMaintenanceItems();
            _testScope.fileReceived = incomingMaintenanceTest.WriteMaintenanceFile(_scenarioContext.ScenarioInfo.Title, _testScope.clientConfigurations.SourceFolder);
        }
       
        /// <summary>
        /// Generating an inbound MT file based on table values.
        /// </summary>
        /// <param name="table"></param>
        [When(@"The user creates a Citi Inbound Maintenance File using account from previous steps:")]
        public void When_The_User_Creates_A_Citi_Inbound_Maintenance_File_With_Account(Table table)
        {
            _testScope.clientConfigurations = new CitiInboundMaintenanceConfigurations();
            InternalGenerateMaintenanceFile(table);
        }


        /// <summary>
        /// Generating an inbound MT file with parameters.
        /// </summary>
        /// <param name="transactionDateTime"></param>
        /// <param name="transactionCode"></param>
        /// <param name="fieldCode"></param>
        /// <param name="newValue"></param>
        [When(@"The user creates a Citi Inbound MT File with (.*), (.*), (.*), (.*)")]
        public void When_The_User_Creates_A_Citi_Inbound_Maintenance_File_Using_Credentials(string transactionDateTime, string transactionCode, string fieldCode, string newValue)
        {
            _testScope.clientConfigurations = new CitiInboundMaintenanceConfigurations();
            var incomingMaintenanceTest = new IncomingMaintenanceTestService();

            incomingMaintenanceTest.CreateMaintenanceFileHeader();
            incomingMaintenanceTest.BuildMaintenanceItems(
                (transactionDateTime),
                _testScope.accountId,
                transactionCode,
                fieldCode,
                newValue,
                "I",
                "BATCH");
            incomingMaintenanceTest.PrepareMaintenanceItems();
            _testScope.fileReceived = incomingMaintenanceTest.WriteMaintenanceFile(_scenarioContext.ScenarioInfo.Title, _testScope.clientConfigurations.SourceFolder);
        }


        /*   Financial maintenance */
        #region Financial

        private void InternalGenerateFinancialFile(Table table)
        {
            var items = table.CreateSet<IncomingFinancialItems>();
            var incomingMaintenanceTest = new IncomingMaintenanceTestService();

            incomingMaintenanceTest.CreateFinancialFileHeader(_testScope.accountId);
            foreach (var item in items)
            {
                incomingMaintenanceTest.BuildFinancialItems(
                    item.TransactionDateTime,
                    _testScope.accountId,
                    item.TransactionCode,
                    item.TransactionAmount);
            }

            incomingMaintenanceTest.PrepareFinancialItems();
            _testScope.fileReceived = incomingMaintenanceTest.WriteFinancialFile(_scenarioContext.ScenarioInfo.Title, _testScope.clientConfigurations.SourceFolder);
        }


        /// <summary>
        /// Generating an inbound MT file with financial format from table values.
        /// </summary>
        /// <param name="table"></param>
        [When(@"The user creates a Citi Inbound Financial File using account from previous steps:")]
        public void When_The_User_Creates_A_Citi_Inbound_Financial_File_With_Account(Table table)
        {
            _testScope.clientConfigurations = new CitiInboundMaintenanceConfigurations();
            InternalGenerateFinancialFile(table);
        }


        /// <summary>
        /// Generating an inbound MT file with financial format.
        /// </summary>
        /// <param name="transactionDateTime"></param>
        /// <param name="transactionCode"></param>
        /// <param name="transactionAmount"></param>
        [When(@"The user creates a Citi Inbound Financial File with (.*), (.*), (.*)")]
        public void When_The_User_Creates_A_Citi_Inbound_Financial_File_With_Credentials(string transactionDateTime, string transactionCode, string transactionAmount)
        {
            _testScope.clientConfigurations = new CitiInboundMaintenanceConfigurations();
            var incomingMaintenanceTest = new IncomingMaintenanceTestService();

            incomingMaintenanceTest.CreateFinancialFileHeader(_testScope.accountId);
            incomingMaintenanceTest.BuildFinancialItems(
                transactionDateTime,
                _testScope.accountId,
                transactionCode,
                transactionAmount);

            incomingMaintenanceTest.PrepareFinancialItems();
            _testScope.fileReceived = incomingMaintenanceTest.WriteFinancialFile(_scenarioContext.ScenarioInfo.Title, _testScope.clientConfigurations.SourceFolder);

        }
        #endregion
    }
}



///// <summary>
///// 
///// </summary>
///// <param name="table"></param>
//[When(@"The user modifies the Citi Inbound MT file with values:")]
//public void When_The_User_Modifies_The_Citi_Inbound_Maintenance_File(Table table)
//{
//    _testScope.clientConfigurations = new CitiInboundMaintenanceConfigurations();
//    _testScope.accountId = Convert.ToInt32(table.Rows[0][1]);
//    InternalGenerateMaintenanceFile(table);
//}