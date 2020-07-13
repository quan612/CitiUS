// --------------------------------------------------------------------------------------------------------------------
// <copyright file="FixedWidthRecordAttribute.cs" company="i4 Quality Software Inc.">
//  (c) 2018 i4 Quality Software Inc.  
// </copyright>
// <summary>
//   Defines the FixedWidthRecordAttribute type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

using System;

namespace CitiUSTest.Serializer
{
    [AttributeUsage(AttributeTargets.Class)]
    public class FixedWidthRecordAttribute : Attribute
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="FixedWidthRecordAttribute"/> class.
        /// </summary>
        /// <param name="paddingCharacter">
        /// Padding used when there are gaps in between fields.
        /// </param>
        public FixedWidthRecordAttribute(char paddingCharacter = ' ')
        {
            PaddingCharacter = paddingCharacter;
        }

        public char PaddingCharacter { get; }
    }
}
