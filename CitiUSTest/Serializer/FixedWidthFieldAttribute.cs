// --------------------------------------------------------------------------------------------------------------------
// <copyright file="FixedWidthFieldAttribute.cs" company="i4 Quality Software Inc.">
// (c) 2017 ALL RIGHTS RESERVED
// </copyright>
// <summary>
//   Defines the FixedWidthFieldAttribute type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

using System;

namespace CitiUSTest.Serializer
{
    [AttributeUsage(AttributeTargets.Property)]
    public class FixedWidthFieldAttribute : Attribute
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="FixedWidthFieldAttribute"/> class.
        /// </summary>
        /// <param name="position">
        /// Position of field in record, with 1 being the first position (not 0)
        /// </param>
        /// <param name="length">
        /// Length of field, short values will be padded and long values trimmed.
        /// </param>
        /// <param name="format">
        /// Format string for <see cref="IFormattable"/> values.
        /// </param>
        /// <param name="paddingCharacter">
        /// Used when padding short values.
        /// </param>
        /// <param name="isLtrDirection">
        /// The direction.
        /// </param>
        public FixedWidthFieldAttribute(
            int position, 
            int length, 
            string format = null, 
            char paddingCharacter = ' ', 
            bool isLtrDirection = true,
            string parseFunc = null)
        {
            Position = position;
            Length = length;
            Format = format;
            PaddingCharacter = paddingCharacter;
            IsLtrDirection = isLtrDirection;
            ParseFunc = parseFunc;
        }

        public int Position { get; }

        public int Length { get; }

        public string Format { get; }

        public char PaddingCharacter { get; }

        public bool IsLtrDirection { get; }

        public string ParseFunc { get; }
    }
}