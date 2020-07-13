namespace CitiUSTest.Models.Maintenance
{
    public static class OutgoingFileConstants
    {
        public const string Space = " ";

        public const char PadStringCharacter = ' ';

        public const char PadNumberCharacter = '0';

        public const string DateFormat = "yyyyMMdd";

        public const string DateTimeFormat = "yyyyMMddHHmm";

        public const string HeaderTransactionCode = "HD";

        public const string MaintenanceTransactionCode = "MT";

        public const string MaintenanceCommentCode = "94";

        public const string PaymentDetailTransactionCode = "5A";

        public const string ReversalDetailTransactionCode = "57";

        public const string CommissionDetailTransactionCode = "49";

        public const string CommissionTransactionDescription = "Commission";

        public const string PaymentTransactionDescription = "Payment";

        public const string ReversalTransactionDescription = "Reversal";

        public const string ContactLetterCommentCode = "9C";

        public const string GeneralCommentCode = "90";

        public const string PaymentStartDateCode = "R4";

        public const string PaymentAmountCode = "R6";

        public const string PaymentEndDateCode = "R5";

        public const string SynchronyRemitLogCategory = "Synchrony Remit Processor";

        public const string SynchronyAuditLogCategory = "Synchrony Audit Processor";

        public const string SynchronyVarLogCategory = "Synchrony VAR Processor";

        public const int MaxRecordsPerHeader = 99999;
    }
}
