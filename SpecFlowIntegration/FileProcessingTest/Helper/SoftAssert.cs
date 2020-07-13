﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Arx.Core.Attributes.RSharp;
using NUnit.Framework;
using SpecFlowIntegration.FileProcessingTest.Helper;

namespace SpecFlowIntegration.FileProcessingTest.Helper
{
    public class SoftAssert : IDisposable
    {
        private readonly IList<GroupedAssertion> _assertions;

        private bool _hasVerifiedAlready = false;

        public SoftAssert()
        {
            this._assertions = new List<GroupedAssertion>();
        }

        public void Dispose()
        {
            if (!_hasVerifiedAlready)
            {
                this.Verify();
            }
        }

        public bool ShowFailingFilePath { get; set; }

        public void Add([InstantHandle] Action assertion)
        {
            try
            {
                assertion();
            }
            catch (AssertionException exception)
            {
                this._assertions.Add(new GroupedAssertion(exception.Message,
                    new StackTrace(exception, true)));
            }
        }

        public void Verify()
        {
            this._hasVerifiedAlready = true;
            var exceptionCount = 0;
            var exceptionTrace = new StringBuilder();
            var hasThrown = false;

            exceptionTrace.AppendLine("Test failed because one or more assertions failed: ");

            foreach (var assertion in this._assertions)
            {
                if (exceptionCount > 0) exceptionTrace.AppendLine();

                exceptionTrace.AppendLine(
                    string.Format("{0})\t{1}", ++exceptionCount, FormatExceptionMessage(assertion.Message)));

                exceptionTrace.AppendLine(assertion.StackTrace.ToString());

                hasThrown = true;
            }

            if (hasThrown)
            {
                throw new AssertionException(exceptionTrace.ToString());
            }
        }

        private static string FormatExceptionMessage(string message)
        {
            message = message.Trim();
            return message.Replace("\r\n", "\r\n\t");
        }
    }
}