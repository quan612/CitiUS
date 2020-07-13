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
namespace CitiUSTest.FeatureFiles.CitiOutgoingMaintenanceFeatures
{
    using TechTalk.SpecFlow;
    using System;
    using System.Linq;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "3.1.0.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("_Demo for BANK")]
    public partial class _DemoForBANKFeature
    {
        
        private TechTalk.SpecFlow.ITestRunner testRunner;
        
        private string[] _featureTags = ((string[])(null));
        
#line 1 "DemoForBank.feature"
#line hidden
        
        [NUnit.Framework.OneTimeSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "_Demo for BANK", null, ProgrammingLanguage.CSharp, ((string[])(null)));
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
#line 3
#line hidden
#line 4
 testRunner.Given("The user creates a Citi NBS based on the sample file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table539 = new TechTalk.SpecFlow.Table(new string[] {
                        "MIOCode",
                        "ListDate"});
            table539.AddRow(new string[] {
                        "BANK",
                        "Yesterday"});
#line 5
 testRunner.And("The user modifies the header record with credentials:", ((string)(null)), table539, "And ");
#line hidden
            TechTalk.SpecFlow.Table table540 = new TechTalk.SpecFlow.Table(new string[] {
                        "LoanTypeCode",
                        "OfficerCode",
                        "MIOCode",
                        "RecovererCode"});
            table540.AddRow(new string[] {
                        "CONS",
                        "433902",
                        "BANK",
                        "GL03"});
#line 8
 testRunner.And("The user modifies the account record in DL file with credentials:", ((string)(null)), table540, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_demoBank1")]
        public virtual void CITI_DemoBank1()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_demoBank1", "Citi Home Work Cell test supplemental", ((string[])(null)));
#line 12
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
#line 3
this.FeatureBackground();
#line hidden
                TechTalk.SpecFlow.Table table541 = new TechTalk.SpecFlow.Table(new string[] {
                            "HomeNumber",
                            "HomeIndicator",
                            "WorkNumber",
                            "WorkIndicator",
                            "CellNumber",
                            "CellIndicator",
                            "AccountStatus",
                            "State"});
                table541.AddRow(new string[] {
                            "6479991111",
                            "L",
                            "6479992222",
                            "L",
                            "6479993333",
                            "L",
                            "P30",
                            "ON"});
#line 14
 testRunner.Given("The user modifies the account record in DL file with credentials:", ((string)(null)), table541, "Given ");
#line hidden
#line 17
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 18
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table542 = new TechTalk.SpecFlow.Table(new string[] {
                            "Transaction DateTime",
                            "Transaction Code",
                            "Field Code",
                            "New Value"});
                table542.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASCNT",
                            "abc"});
                table542.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASOCC",
                            "bca"});
#line 19
 testRunner.When("The user creates a Citi Inbound Maintenance File using account from previous step" +
                        "s:", ((string)(null)), table542, "When ");
#line hidden
#line 23
 testRunner.And("The user drops the file to the UNC path, and the file is processed and the eColle" +
                        "ct Job is done", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 24
 testRunner.And("The user generates an outbound maintenance file for BANK_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 25
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table543 = new TechTalk.SpecFlow.Table(new string[] {
                            "FieldCode"});
                table543.AddRow(new string[] {
                            "MASHPH"});
                table543.AddRow(new string[] {
                            "MASHPF"});
                table543.AddRow(new string[] {
                            "MASOPH"});
                table543.AddRow(new string[] {
                            "MASOPF"});
                table543.AddRow(new string[] {
                            "MASCPN"});
                table543.AddRow(new string[] {
                            "MASCPI"});
                table543.AddRow(new string[] {
                            "MASCNT"});
                table543.AddRow(new string[] {
                            "MASOCC"});
#line 26
 testRunner.Then("The records below should not be sent for the account in the file", ((string)(null)), table543, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion