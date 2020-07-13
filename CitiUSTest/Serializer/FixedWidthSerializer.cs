// --------------------------------------------------------------------------------------------------------------------
// <copyright file="FixedWidthSerializer.cs" company="i4 Quality Software Inc.">
//  (c) 2018 i4 Quality Software Inc.  
// </copyright>
// <summary>
//   Defines the FixedWidthSerializer type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using Arx.Core.Attributes.RSharp;
using CitiUSTest.Models.Maintenance;
using Common;


namespace CitiUSTest.Serializer
{
    public class FixedWidthSerializer
    {
        private readonly List<PropGetter> _fields;
        private readonly FixedWidthRecordAttribute _recordAttr;

        public FixedWidthSerializer([NotNull] Type recordType)
        {
            if (recordType == null)
            {
                throw new ArgumentNullException(nameof(recordType));
            }

            _recordAttr = GetSingleAttribute<FixedWidthRecordAttribute>(recordType);
            if (_recordAttr == null)
            {
                throw new FixedWidthSerializerException("Type is not decorated with FixedWidthRecord");
            }

            var q =
                from prop in recordType.GetProperties()
                let fieldAttr = GetSingleAttribute<FixedWidthFieldAttribute>(prop)
                where fieldAttr != null
                orderby fieldAttr.Position
                select new PropGetter(fieldAttr, prop);

            _fields = q.ToList();

            ValidateFields();
        }

        public void Serialize(TextWriter writer, object item)
        {
            var currentPosition = 1;
            foreach (var field in _fields)
            {
                if (field.FieldAttr.Position > currentPosition)
                {
                    var padLength = field.FieldAttr.Position - currentPosition;
                    writer.Write(new string(_recordAttr.PaddingCharacter, padLength));
                    currentPosition += padLength;
                }

                var value = field.GetValue(item);
                writer.Write(value);
                currentPosition += value.Length;
            }
        }

        public void ModifyFields(string sourceFile, object item, int lineNumber)
        {
            var lineArray = File.ReadAllLines(sourceFile);
            foreach (var field in _fields)
            {
                if (field.GetValue(item).Length < field.FieldAttr.Length)
                    throw new Exception("the modified string is longer than the mapping field length");

                //if the object has value = blank and not null, the field in the file will turn to blank
                if (field.GetValue(item).Trim() == "" && field.IsGetValueNull(item))
                      continue;

                var newValue = field.GetValue(item) + StringUtils.Filler(field.FieldAttr.Length - field.GetValue(item).Length);

                lineArray[lineNumber] = lineArray[lineNumber].Remove(field.FieldAttr.Position - 1, field.FieldAttr.Length);
                lineArray[lineNumber] = lineArray[lineNumber].Insert(field.FieldAttr.Position - 1, newValue);
            }

            File.WriteAllLines(sourceFile, lineArray);
        }

        private static TAttr GetSingleAttribute<TAttr>(MemberInfo member) where TAttr : Attribute
        {
            var attributes = member.GetCustomAttributes(typeof(TAttr), true);
            return (TAttr)attributes.FirstOrDefault();
        }

        private void ValidateFields()
        {
            foreach (var field in _fields)
            {
                if (field.FieldAttr.Position < 1)
                {
                    throw new FixedWidthSerializerException("Fields must have position greater or equal to one,");
                }

                if (field.FieldAttr.Length < 1)
                {
                    throw new FixedWidthSerializerException("Fields must have length of at least one.");
                }
            }

            // make sure that no two fields overlap
            var uniquePairs =
                from a in _fields
                from b in _fields.Except(new[] { a })
                select new
                {
                    AStart = a.FieldAttr.Position,
                    AEnd = a.FieldAttr.Position + a.FieldAttr.Length - 1,
                    BStart = b.FieldAttr.Position,
                    BEnd = b.FieldAttr.Position + b.FieldAttr.Length - 1
                };

            foreach (var item in uniquePairs)
            {
                if (item.AEnd - item.BStart >= 0 && item.BEnd - item.AStart >= 0)
                {
                    var a = Math.Max(item.AStart, item.BStart);
                    var b = Math.Min(item.AEnd, item.BEnd);
                    var overlap = a == b ? $"at position {a}" : $"between positions {a} and {b}";
                    throw new FixedWidthSerializerException("Fields overlap " + overlap);
                }
            }
        }

        private class PropGetter
        {
            private static readonly CustomFormatProvider FormatProvider = new CustomFormatProvider();
            private readonly Func<object, object> _getter;

            public PropGetter(FixedWidthFieldAttribute fieldAttr, PropertyInfo property)
            {
                FieldAttr = fieldAttr;
                _getter = CompileGetter(property);
            }

            public FixedWidthFieldAttribute FieldAttr { get; }

            public string GetValue(object item)
            {
                var value = _getter(item);
                var stringValue = FieldAttr.Format == null ? value?.ToString() ?? string.Empty : string.Format(FormatProvider, FieldAttr.Format, value);
                var padded = FieldAttr.IsLtrDirection ? stringValue.PadLeft(FieldAttr.Length, FieldAttr.PaddingCharacter) : stringValue.PadRight(FieldAttr.Length, FieldAttr.PaddingCharacter);
                return padded.Substring(0, FieldAttr.Length);
            }

            public bool IsGetValueNull(object item)
            {
                if (_getter(item) == null)
                    return true;
                return false;
            }

            private static Func<object, object> CompileGetter(PropertyInfo property)
            {
                var input = Expression.Parameter(typeof(object), "item");
                var cast = Expression.Convert(input, property.DeclaringType);
                var get = Expression.Call(cast, property.GetMethod);
                var box = Expression.Convert(get, typeof(object));
                var getterName = $"{property.DeclaringType.FullName}.compiledGet_{property.Name}";
                var lambda = Expression.Lambda<Func<object, object>>(box, getterName, new[] { input });
                return lambda.Compile();
            }

            private class CustomFormatProvider : IFormatProvider, ICustomFormatter
            {
                public object GetFormat(Type formatType) => formatType == typeof(ICustomFormatter) ? this : null;

                public string Format(string format, object arg, IFormatProvider formatProvider)
                {
                    // TODO: do EBCDIC and any other custom stuff. For now, just pass through to default
                    return HandleOtherFormats(format, arg);
                }

                private static string HandleOtherFormats(string format, object arg)
                {
                    var formattable = arg as IFormattable;
                    if (formattable != null)
                    {
                        return formattable.ToString(format, CultureInfo.CurrentCulture);
                    }

                    return arg == null ? string.Empty : arg.ToString();
                }
            }
        }
    }
}