using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitiUSTest.Models
{
    public static class ConvertToDateTimeString
    {
        public static string MapStringToDateValue(string value)
        {
            switch (value)
            {
                case "Today's date":
                   return DateTime.Now.ToShortDateString();
                case "Yesterday":
                   return DateTime.Today.AddDays(-1).ToShortDateString();
                default:
                    return value;
            }
        }
    }
}
