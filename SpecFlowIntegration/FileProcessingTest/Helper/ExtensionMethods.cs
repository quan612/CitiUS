using System.Collections.Generic;
using System.Linq;
using Arx;

namespace SpecFlowIntegration.FileProcessingTest.Helper
{
    public static class ExtensionMethods
    {
        /// <summary>
        /// Find the next available phone slot that is not controlled by Citi (slots 1 and 2 belong to Citi).
        /// </summary>
        /// <param name="phones">
        /// An account's phones.
        /// </param>
        /// <returns>
        /// The next available slot or 0 if none are available.
        /// </returns>
        public static int GetNextAvailableSlot(this IEnumerable<Phone> phones)
        {
            var freeSlots = Enumerable.Range(3, 23).Except(phones.Select(phone => phone.PhoneSlot)).ToList();
            return freeSlots.Any() ? freeSlots.Min() : 0;
        }
    }
}
