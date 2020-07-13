﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:3.1.0.0
//      SpecFlow Generator Version:3.1.0.0
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace CitiUSTest.FeatureFiles.CitiNBSFeatures
{
    using TechTalk.SpecFlow;
    using System;
    using System.Linq;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "3.1.0.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("M Record")]
    [NUnit.Framework.CategoryAttribute("Placement")]
    [NUnit.Framework.CategoryAttribute("M_Record")]
    [NUnit.Framework.CategoryAttribute("epic:85568")]
    public partial class MRecordFeature
    {
        
        private TechTalk.SpecFlow.ITestRunner testRunner;
        
        private string[] _featureTags = new string[] {
                "Placement",
                "M_Record",
                "epic:85568"};
        
#line 1 "MRecord.feature"
#line hidden
        
        [NUnit.Framework.OneTimeSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "M Record", "\tTo test the loading of supplementary information for Citi US account when receiv" +
                    "ing M record in NBS file.", ProgrammingLanguage.CSharp, new string[] {
                        "Placement",
                        "M_Record",
                        "epic:85568"});
            testRunner.OnFeatureStart(featureInfo);
        }
        
        [NUnit.Framework.OneTimeTearDownAttribute()]
        public virtual void FeatureTearDown()
        {
            testRunner.OnFeatureEnd();
            testRunner = null;
        }
        
        [NUnit.Framework.SetUpAttribute()]
        public virtual void TestInitialize()
        {
        }
        
        [NUnit.Framework.TearDownAttribute()]
        public virtual void TestTearDown()
        {
            testRunner.OnScenarioEnd();
        }
        
        public virtual void ScenarioInitialize(TechTalk.SpecFlow.ScenarioInfo scenarioInfo)
        {
            testRunner.OnScenarioInitialize(scenarioInfo);
            testRunner.ScenarioContext.ScenarioContainer.RegisterInstanceAs<NUnit.Framework.TestContext>(NUnit.Framework.TestContext.CurrentContext);
        }
        
        public virtual void ScenarioStart()
        {
            testRunner.OnScenarioStart();
        }
        
        public virtual void ScenarioCleanup()
        {
            testRunner.CollectScenarioErrors();
        }
        
        public virtual void FeatureBackground()
        {
#line 5
#line hidden
#line 6
testRunner.Given("The user creates a Citi NBS based on the sample file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table309 = new TechTalk.SpecFlow.Table(new string[] {
                        "MIOCode",
                        "ListDate"});
            table309.AddRow(new string[] {
                        "BANK",
                        "Yesterday"});
#line 7
 testRunner.And("The user modifies the header record with credentials:", ((string)(null)), table309, "And ");
#line hidden
            TechTalk.SpecFlow.Table table310 = new TechTalk.SpecFlow.Table(new string[] {
                        "LoanTypeCode",
                        "OfficerCode",
                        "MIOCode",
                        "RecovererCode"});
            table310.AddRow(new string[] {
                        "CONS",
                        "433902",
                        "BANK",
                        "GL03"});
#line 10
 testRunner.And("The user modifies the account record in DL file with credentials:", ((string)(null)), table310, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4685")]
        public virtual void CITI_4685()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4685", "Verify the saving DSA fields to InternalExtras when we receive a value that is no" +
                    "t blank", ((string[])(null)));
#line 14
this.ScenarioInitialize(scenarioInfo);
#line hidden
            bool isScenarioIgnored = default(bool);
            bool isFeatureIgnored = default(bool);
            if ((tagsOfScenario != null))
            {
                isScenarioIgnored = tagsOfScenario.Where(__entry => __entry != null).Where(__entry => String.Equals(__entry, "ignore", StringComparison.CurrentCultureIgnoreCase)).Any();
            }
            if ((this._featureTags != null))
            {
                isFeatureIgnored = this._featureTags.Where(__entry => __entry != null).Where(__entry => String.Equals(__entry, "ignore", StringComparison.CurrentCultureIgnoreCase)).Any();
            }
            if ((isScenarioIgnored || isFeatureIgnored))
            {
                testRunner.SkipScenario();
            }
            else
            {
                this.ScenarioStart();
#line 5
this.FeatureBackground();
#line hidden
                TechTalk.SpecFlow.Table table311 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table311.AddRow(new string[] {
                            "DsaName",
                            "Test DSA Name"});
                table311.AddRow(new string[] {
                            "DsaAddress1",
                            "Address 1"});
                table311.AddRow(new string[] {
                            "DsaAddress2",
                            "Address 2"});
                table311.AddRow(new string[] {
                            "DsaCity",
                            "Toronto"});
                table311.AddRow(new string[] {
                            "DsaState",
                            "AZ"});
                table311.AddRow(new string[] {
                            "DsaZip",
                            "12345-1234"});
                table311.AddRow(new string[] {
                            "DsaPhone",
                            "4169991234"});
                table311.AddRow(new string[] {
                            "DsaEmail",
                            "abc@gmail.com"});
#line 16
 testRunner.Given("The user modifies the M record in DL file with credentials:", ((string)(null)), table311, "Given ");
#line hidden
#line 26
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 27
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table312 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table312.AddRow(new string[] {
                            "Text6",
                            "Test DSA Name"});
                table312.AddRow(new string[] {
                            "Text7",
                            "Address 1"});
                table312.AddRow(new string[] {
                            "Text8",
                            "Address 2"});
                table312.AddRow(new string[] {
                            "Text9",
                            "Toronto"});
                table312.AddRow(new string[] {
                            "Text10",
                            "AZ"});
                table312.AddRow(new string[] {
                            "Text11",
                            "12345-1234"});
                table312.AddRow(new string[] {
                            "Text15",
                            "4169991234"});
                table312.AddRow(new string[] {
                            "Text12",
                            "abc@gmail.com"});
#line 28
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table312, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4686")]
        public virtual void CITI_4686()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4686", "Verify the saving DSA fields to InternalExtras when we receive a value that is bl" +
                    "ank", ((string[])(null)));
#line 39
this.ScenarioInitialize(scenarioInfo);
#line hidden
            bool isScenarioIgnored = default(bool);
            bool isFeatureIgnored = default(bool);
            if ((tagsOfScenario != null))
            {
                isScenarioIgnored = tagsOfScenario.Where(__entry => __entry != null).Where(__entry => String.Equals(__entry, "ignore", StringComparison.CurrentCultureIgnoreCase)).Any();
            }
            if ((this._featureTags != null))
            {
                isFeatureIgnored = this._featureTags.Where(__entry => __entry != null).Where(__entry => String.Equals(__entry, "ignore", StringComparison.CurrentCultureIgnoreCase)).Any();
            }
            if ((isScenarioIgnored || isFeatureIgnored))
            {
                testRunner.SkipScenario();
            }
            else
            {
                this.ScenarioStart();
#line 5
this.FeatureBackground();
#line hidden
                TechTalk.SpecFlow.Table table313 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table313.AddRow(new string[] {
                            "DsaName",
                            ""});
                table313.AddRow(new string[] {
                            "DsaAddress1",
                            ""});
                table313.AddRow(new string[] {
                            "DsaAddress2",
                            ""});
                table313.AddRow(new string[] {
                            "DsaCity",
                            ""});
                table313.AddRow(new string[] {
                            "DsaState",
                            ""});
                table313.AddRow(new string[] {
                            "DsaZip",
                            ""});
                table313.AddRow(new string[] {
                            "DsaPhone",
                            ""});
                table313.AddRow(new string[] {
                            "DsaEmail",
                            ""});
#line 41
 testRunner.Given("The user modifies the M record in DL file with credentials:", ((string)(null)), table313, "Given ");
#line hidden
#line 51
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 52
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table314 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table314.AddRow(new string[] {
                            "Text6",
                            ""});
                table314.AddRow(new string[] {
                            "Text7",
                            ""});
                table314.AddRow(new string[] {
                            "Text8",
                            ""});
                table314.AddRow(new string[] {
                            "Text9",
                            ""});
                table314.AddRow(new string[] {
                            "Text10",
                            ""});
                table314.AddRow(new string[] {
                            "Text11",
                            ""});
                table314.AddRow(new string[] {
                            "Text15",
                            ""});
                table314.AddRow(new string[] {
                            "Text12",
                            ""});
#line 53
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table314, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4687")]
        public virtual void CITI_4687()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4687", "Verify the saving DSA fields to InternalExtras when we receive a value with maxim" +
                    "um char length", ((string[])(null)));
#line 64
this.ScenarioInitialize(scenarioInfo);
#line hidden
            bool isScenarioIgnored = default(bool);
            bool isFeatureIgnored = default(bool);
            if ((tagsOfScenario != null))
            {
                isScenarioIgnored = tagsOfScenario.Where(__entry => __entry != null).Where(__entry => String.Equals(__entry, "ignore", StringComparison.CurrentCultureIgnoreCase)).Any();
            }
            if ((this._featureTags != null))
            {
                isFeatureIgnored = this._featureTags.Where(__entry => __entry != null).Where(__entry => String.Equals(__entry, "ignore", StringComparison.CurrentCultureIgnoreCase)).Any();
            }
            if ((isScenarioIgnored || isFeatureIgnored))
            {
                testRunner.SkipScenario();
            }
            else
            {
                this.ScenarioStart();
#line 5
this.FeatureBackground();
#line hidden
                TechTalk.SpecFlow.Table table315 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table315.AddRow(new string[] {
                            "DsaName",
                            "Test Long Name value that is > 40 chars abcde"});
                table315.AddRow(new string[] {
                            "DsaAddress1",
                            "Test Long Address value that is > 40 chars abcde"});
                table315.AddRow(new string[] {
                            "DsaAddress2",
                            "Test Long Address value that is > 40 chars abcde"});
                table315.AddRow(new string[] {
                            "DsaCity",
                            "Test Long city value > 20 chars"});
                table315.AddRow(new string[] {
                            "DsaState",
                            "ONTARIO"});
                table315.AddRow(new string[] {
                            "DsaZip",
                            "M1M2M3M4M5M6M7"});
                table315.AddRow(new string[] {
                            "DsaPhone",
                            "647999123456789123"});
                table315.AddRow(new string[] {
                            "DsaEmail",
                            "abc@gmail.com"});
#line 66
 testRunner.Given("The user modifies the M record in DL file with credentials:", ((string)(null)), table315, "Given ");
#line hidden
#line 76
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 77
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table316 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table316.AddRow(new string[] {
                            "Text6",
                            "Test Long Name value that is > 40 chars"});
                table316.AddRow(new string[] {
                            "Text7",
                            "Test Long Address value that is > 40 cha"});
                table316.AddRow(new string[] {
                            "Text8",
                            "Test Long Address value that is > 40 cha"});
                table316.AddRow(new string[] {
                            "Text9",
                            "Test Long city value"});
                table316.AddRow(new string[] {
                            "Text10",
                            "ON"});
                table316.AddRow(new string[] {
                            "Text11",
                            "M1M2M3M4M5"});
                table316.AddRow(new string[] {
                            "Text15",
                            "6479991234567891"});
                table316.AddRow(new string[] {
                            "Text12",
                            "abc@gmail.com"});
#line 78
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table316, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
