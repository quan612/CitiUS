using System;
using CitiUSTest.Serializer;

// this is taken from Synchrony outbound MT file processing project
namespace CitiUSTest.Models.Maintenance
{
    [FixedWidthRecord]
    public class BaseRecord : IComparable
    {
        private string _recovererId = "BATCH";
        public int AccountId { get; set; }

        public virtual DateTime TransactionDateTime { get; set; }

        //public virtual string TransactionDateTime { get; set; }

        [FixedWidthField(13, 20, null, ' ', false)]
        public string AccountNumber { get; set; }

        [FixedWidthField(33, 2, null, ' ', false)]
        public string TransactionCode { get; set; }

        [FixedWidthField(82, 4, null, ' ', false)]
        public string RecovererCode { get; set; }

        [FixedWidthField(86, 7, null, ' ', false)]
        public string RecovererId
        {
            get
            {
                return _recovererId;
            }
            set
            {
                _recovererId = value;
            }
        }

        /// <summary>Compares the current instance with another object of the same type and returns an integer that indicates whether the current instance precedes, follows, or occurs in the same position in the sort order as the other object.</summary>
        /// <param name="obj">An object to compare with this instance. </param>
        /// <returns>A value that indicates the relative order of the objects being compared. The return value has these meanings: Value Meaning Less than zero This instance precedes <paramref name="obj" /> in the sort order. Zero This instance occurs in the same position in the sort order as <paramref name="obj" />. Greater than zero This instance follows <paramref name="obj" /> in the sort order. </returns>
        /// <exception cref="T:System.ArgumentException">
        /// <paramref name="obj" /> is not the same type as this instance. </exception>
        public int CompareTo(object obj)
        {
            var other = obj as BaseRecord;

            if (other == null)
            {
                throw new ArgumentException("Object must be of type BaseRecord", "obj");
            }

            var reco = string.Compare(RecovererCode, other.RecovererCode, StringComparison.Ordinal);

            if (reco != 0)
            {
                return reco;
            }

            var account = string.Compare(AccountNumber, other.AccountNumber, StringComparison.Ordinal);

            if (account != 0)
            {
                return account;
            }

            var transDate = new DateTime(TransactionDateTime.Year, TransactionDateTime.Month, TransactionDateTime.Day, TransactionDateTime.Hour, TransactionDateTime.Minute, 0);
            var otherDate = new DateTime(other.TransactionDateTime.Year, other.TransactionDateTime.Month, other.TransactionDateTime.Day, other.TransactionDateTime.Hour, other.TransactionDateTime.Minute, 0);
            var compareDate = transDate.CompareTo(otherDate);

            if (compareDate != 0)
            {
                return compareDate;
            }

            var transCode = string.Compare(TransactionCode, other.TransactionCode, StringComparison.Ordinal);

            if (transCode != 0)
            {
                return transCode;
            }
            return compareDate;
            //var thisComment = this as MaintenanceCommentRecord;
            //var otherComment = other as MaintenanceCommentRecord;

            //if (thisComment == null || otherComment == null)
            //{
            //    return compareDate;
            //}

            //return thisComment.SequenceNumber.CompareTo(otherComment.SequenceNumber);
        }
        
    }
}