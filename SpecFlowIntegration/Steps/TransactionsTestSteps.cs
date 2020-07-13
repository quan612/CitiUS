using TechTalk.SpecFlow;
using System;
using Arx;
using Arx.Managers;
using NUnit.Framework;
using SpecFlowIntegration.Hooks;

namespace SpecFlowIntegration.Steps
{
    [Binding]
    public class TransactionsTestSteps
    {
        private readonly TestScopeContext _testScope;
        private readonly ScenarioContext _scenarioContext;
        private Transaction _originalTransaction;

        public TransactionsTestSteps(
            TestScopeContext testScope,
            ScenarioContext scenarioContext)
        {
            _testScope = testScope;
            _scenarioContext = scenarioContext;
        }

        /// <summary>
        /// User manually posts a transaction for the account based on transaction name
        /// The posted transaction is tracked in _originalTransaction
        /// </summary>
        /// <param name="transactionName"></param>
        /// <param name="transactionAmount"></param>
        /// <param name="transactionDate"></param>
        [When(@"A user manually posts a (.*) transaction of \$(.*) on (.*)")]
        public void User_Posts_A_Transaction(string transactionName, decimal transactionAmount,
            DateTime transactionDate)
        {
            var account = AccountManager.GetAccount(_testScope.accountId);
            var transactionCodeId = GetTransactionCodeId(transactionName);
            TransactionManager.PostTransaction(account, transactionAmount, transactionCodeId, transactionDate);

            var transactions = TransactionManager.GetTransactionsByAccountId(_testScope.accountId);
            _originalTransaction = transactions.Find(x =>
                x.TransactionCode.TransactionCodeId == transactionCodeId &&
                x.TotalPaid == transactionAmount &&
                x.TransactionDate == transactionDate);
        }

        private string GetTransactionCodeId(string transactionName)
        {
            switch (transactionName)
            {
                case "direct payment":
                    return "Direct";
                case "Automated Cheque":
                    return "ACH";
                case "Check by Phone":
                    return "CBP";
                case "Cheque":
                    return "Cheque";
                case "US Visa":
                    return "US_Visa";
                case "Visa":
                    return "Visa";
                case "balance adjustment":
                    return "ADJUSTCLNT";
                default:
                    return "Direct";
            }
        }

        /// <summary>
        /// The step check if the reversed transaction can be found, based on _originalTransaction from previous step
        /// </summary>
        [Then(@"A reversal transaction is posted to the account")]
        public void A_Reversal_Transaction_Posted()
        {
            var transactions = TransactionManager.GetTransactionsByAccountId(_testScope.accountId);
            var reversalTransaction = transactions.Find(x =>
                                x.Reversal == TransactionReversalType.Reversal &&
                                x.TotalPaid == -(_originalTransaction.TotalPaid) &&
                                //x.TransactionDate == _originalTransaction.TransactionDate &&
                                x.ReversalId == _originalTransaction.TransactionId);

            if (reversalTransaction != null)
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.Pass("The reversal transaction is posted as expected");
                });
            }
            else
            {
                _testScope.softAssert.Add(() =>
                {
                    Assert.Fail("The reversal transaction is not posted as expected. Please see transactionId " 
                                + _originalTransaction.TransactionId + " of account " + _testScope.accountId);
                });
            }
        }

        
        [Then(@"A (.*) is posted to the account with an amount of \$(.*) on (.*)")]
        public void A_Transaction_Is_Posted(string transactionName, decimal totalPaid, DateTime transactionDate)
        {
            var transactionCodeId = GetTransactionCodeId(transactionName);
            var transactions = TransactionManager.GetTransactionsByAccountId(_testScope.accountId);
            var transaction = transactions.Find(x => 
                x.TransactionCode.TransactionCodeId == transactionCodeId &&
                x.TotalPaid == totalPaid &&
                x.TransactionType == TransactionType.Adjustment &&
                x.TransactionDate == transactionDate);
        }

        [Then(@"No transaction is posted for the account")]
        public void No_Transaction_Is_Posted()
        {
            var transactions = TransactionManager.GetTransactionsByAccountId(_testScope.accountId);
            _testScope.softAssert.Add(() =>
            {
                Assert.AreEqual(transactions, null);
            });
        }

    }
}
