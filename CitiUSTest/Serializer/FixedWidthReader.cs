using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace CitiUSTest.Serializer
{
    public class FixedWidthReader
    {
        private static readonly MethodInfo Substr = typeof(string).GetMethod(nameof(string.Substring), new[] { typeof(int), typeof(int) });
        private static readonly MethodInfo Trim = typeof(string).GetMethod(nameof(string.Trim), new Type[] { });
        private static readonly MethodInfo StrCat = typeof(string).GetMethod(nameof(string.Concat), new[] { typeof(string), typeof(string) });
        private static readonly MethodInfo ParseExact = typeof(DateTime).GetMethod(nameof(DateTime.ParseExact), new[] { typeof(string), typeof(string), typeof(IFormatProvider) });
        private static readonly ConstructorInfo ExCtor = typeof(FixedWidthSerializerException).GetConstructor(new[] { typeof(string), typeof(Exception) });

        private readonly Func<string, object> _reader;

        public FixedWidthReader(Type recordType)
        {
            if (recordType == null)
            {
                throw new ArgumentNullException(nameof(recordType));
            }

            var recordAttr = GetSingleAttribute<FixedWidthRecordAttribute>(recordType);
            if (recordAttr == null)
            {
                throw new FixedWidthSerializerException("Type is not decorated with FixedWidthRecord");
            }

            var q =
                from prop in recordType.GetProperties()
                let fieldAttr = GetSingleAttribute<FixedWidthFieldAttribute>(prop)
                where fieldAttr != null
                orderby fieldAttr.Position
                select new Field(fieldAttr, prop);

            var fields = q.ToList();
            ValidateFields(fields);
            _reader = CompileReader(recordType, fields);
        }

        public object ReadRecord(string data) => _reader(data);

        /// <summary>
        /// Compiles a dynamic method to create a record object from the string. Much faster than reflection.
        /// The compiled method looks something like this:
        /// <code>
        /// string currentField;
        /// try {
        ///   var record = new Record();
        ///
        ///   currentField = "foo";
        ///   record.Foo = someParsingFunction(data.Substring(0, 10).Trim());
        ///
        ///   currentField = "bar";
        ///   record.Bar = someOtherParsingFunction(data.Substring(10, 10).Trim());
        ///
        ///   // and so forth for all decorated properties
        /// 
        ///   return record;
        /// catch (Exception exception) {
        ///   throw new FixedWidthSerializerException("error in field " + currentField, exception);
        /// }
        /// </code>
        /// </summary>
        private Func<string, object> CompileReader(Type recordType, IEnumerable<Field> fields)
        {
            var data = Expression.Parameter(typeof(string), "data");
            var record = Expression.Variable(recordType, "record");
            var currentField = Expression.Variable(typeof(string), "currentField");

            var tryExpressions = new List<Expression>();
            var newRec = Expression.Assign(record, Expression.New(recordType));
            tryExpressions.Add(Expression.Assign(currentField, Expression.Constant("<Record Constructor>")));
            tryExpressions.Add(newRec);
            foreach (var field in fields)
            {
                var setCurrentField = Expression.Assign(currentField, Expression.Constant(field.Prop.Name));
                tryExpressions.Add(setCurrentField);

                var stringValue = Expression.Call(
                    data,
                    Substr,
                    Expression.Constant(field.Attr.Position - 1),
                    Expression.Constant(field.Attr.Length));

                var trimmed = Expression.Call(stringValue, Trim);
                var parsedValue = ComposeFieldParse(trimmed, field, record);
                var propertySet = Expression.Call(record, field.Prop.SetMethod, parsedValue);
                tryExpressions.Add(propertySet);
            }

            var errorMessage = Expression.Call(StrCat, Expression.Constant("Failed to read value for property "), currentField);

            var caughtException = Expression.Variable(typeof(Exception), "exception");
            var newException = Expression.New(ExCtor, errorMessage, caughtException);
            var catchBlock = Expression.Catch(caughtException, Expression.Throw(newException));
            var tryBlock = Expression.Block(tryExpressions);
            var tryCatch = Expression.TryCatch(tryBlock, catchBlock);

            var variables = new[] { record, currentField, caughtException };
            var methodBody = Expression.Block(typeof(object), variables, tryCatch, record);
            var name = "Read" + recordType.Name;
            var lambda = Expression.Lambda<Func<string, object>>(methodBody, name, new[] { data });
            return lambda.Compile();
        }

        /// <summary>
        /// Creates an expression representing the parsed <paramref name="fieldString"/>.
        /// A parsing mechanism is selected based on property type and attribute.
        /// </summary>
        private static Expression ComposeFieldParse(Expression fieldString, Field field, Expression record)
        {
            var propType = field.Prop.PropertyType;
            var parseFunc = field.Attr.ParseFunc;

            // Parsing function has highest priority
            if (parseFunc != null)
            {
                var propName = field.Prop.Name;
                var parser = record.Type.GetMethod(parseFunc, new[] { typeof(string) });
                if (parser == null)
                {
                    throw new FixedWidthSerializerException($"Could not find parsing function named {parseFunc} for property {propName}. Method must be a public function on record type.");
                }

                if (parser.ReturnType != propType)
                {
                    throw new FixedWidthSerializerException($"Parser func must return same type as decorated property. {propName} is {propType.FullName}, {parseFunc} returns {parser.ReturnType}");
                }

                return Expression.Call(record, parser, fieldString);
            }

            // string properties do not require parsing
            if (propType == typeof(string))
            {
                return fieldString;
            }

            // Handle nullable types. We'll interpret empty string as null. Nullable can't be nested.
            var underlyingType = Nullable.GetUnderlyingType(propType);
            if (underlyingType != null)
            {
                var varFieldValue = Expression.Variable(typeof(string), "fieldString");
                var assignment = Expression.Assign(varFieldValue, fieldString);
                var test = Expression.Equal(varFieldValue, Expression.Constant(string.Empty));
                var parseUnderLying = ParseSimpleValue(underlyingType, varFieldValue, field.Attr.Format);
                var ctor = propType.GetConstructor(new[] { underlyingType });
                if (ctor == null)
                {
                    throw new FixedWidthSerializerException("Could not find constructor for " + propType.Name);
                }

                var ifTrue = Expression.New(propType);
                var ifFalse = Expression.New(ctor, parseUnderLying);
                var conditional = Expression.Condition(test, ifTrue, ifFalse);
                return Expression.Block(propType, new[] { varFieldValue }, assignment, conditional);
            }

            return ParseSimpleValue(propType, fieldString, field.Attr.Format);
        }

        /// <summary>
        /// This field doesn't have a parse func, it's not nullable, and it's not a string
        /// </summary>
        private static Expression ParseSimpleValue(Type typeOfValue, Expression fieldValue, string format)
        {
            // check for format string
            if (format != null)
            {
                if (typeOfValue == typeof(DateTime))
                {
                    return Expression.Call(
                        ParseExact,
                        fieldValue,
                        Expression.Constant(format),
                        Expression.Constant(null, typeof(IFormatProvider)));
                }

                throw new NotSupportedException($"Format string for type {typeOfValue.FullName} is not supported");
            }

            // default to looking for a method Parse(string) on the property type
            var parseMethod = typeOfValue.GetMethod("Parse", new[] { typeof(string) });
            if (parseMethod == null)
            {
                throw new FixedWidthSerializerException("Couldn't find parse method for " + typeOfValue.FullName);
            }

            return Expression.Call(parseMethod, fieldValue);
        }

        private void ValidateFields(List<Field> fields)
        {
            foreach (var writer in fields)
            {
                if (writer.Attr.Position < 1)
                {
                    throw new FixedWidthSerializerException("Fields must have position greater or equal to one,");
                }

                if (writer.Attr.Length < 1)
                {
                    throw new FixedWidthSerializerException("Fields must have length of at least one.");
                }
            }

            // make sure that no two fields overlap
            var uniquePairs =
                from a in fields
                from b in fields.Except(new[] { a })
                select new
                {
                    AStart = a.Attr.Position,
                    AEnd = a.Attr.Position + a.Attr.Length - 1,
                    BStart = b.Attr.Position,
                    BEnd = b.Attr.Position + b.Attr.Length - 1
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

        private static TAttr GetSingleAttribute<TAttr>(MemberInfo member) where TAttr : Attribute
        {
            var attributes = member.GetCustomAttributes(typeof(TAttr), true);
            return (TAttr)attributes.FirstOrDefault();
        }

        private class Field
        {
            public Field(FixedWidthFieldAttribute attr, PropertyInfo prop)
            {
                Attr = attr;
                Prop = prop;
            }

            public FixedWidthFieldAttribute Attr { get; }

            public PropertyInfo Prop { get; }
        }
    }
}
