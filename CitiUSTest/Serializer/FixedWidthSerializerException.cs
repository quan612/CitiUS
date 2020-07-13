// --------------------------------------------------------------------------------------------------------------------
// <copyright file="FixedWidthSerializerException.cs" company="i4 Quality Software Inc.">
//  (c) 2018 i4 Quality Software Inc.  
// </copyright>
// <summary>
//   Defines the FixedWidthSerializerException type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

using System;
using System.Runtime.Serialization;

namespace CitiUSTest.Serializer
{
    [Serializable]
    public class FixedWidthSerializerException : Exception
    {
        public FixedWidthSerializerException()
        {
        }

        public FixedWidthSerializerException(string message) : base(message)
        {
        }

        public FixedWidthSerializerException(string message, Exception inner) : base(message, inner)
        {
        }

        protected FixedWidthSerializerException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
