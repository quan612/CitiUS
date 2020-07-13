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
    [NUnit.Framework.DescriptionAttribute("Phone Update To Work for BANK")]
    [NUnit.Framework.CategoryAttribute("OutboundMaintenance")]
    [NUnit.Framework.CategoryAttribute("Work")]
    [NUnit.Framework.CategoryAttribute("BANK")]
    public partial class PhoneUpdateToWorkForBANKFeature
    {
        
        private TechTalk.SpecFlow.ITestRunner testRunner;
        
        private string[] _featureTags = new string[] {
                "OutboundMaintenance",
                "Work",
                "BANK"};
        
#line 1 "PhoneUpdateToWorkForBANK.feature"
#line hidden
        
        [NUnit.Framework.OneTimeSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Phone Update To Work for BANK", "\tTo test sending of phone to Citi related to  Work updates \t", ProgrammingLanguage.CSharp, new string[] {
                        "OutboundMaintenance",
                        "Work",
                        "BANK"});
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
            TechTalk.SpecFlow.Table table942 = new TechTalk.SpecFlow.Table(new string[] {
                        "MIOCode",
                        "ListDate"});
            table942.AddRow(new string[] {
                        "BANK",
                        "Yesterday"});
#line 7
 testRunner.And("The user modifies the header record with credentials:", ((string)(null)), table942, "And ");
#line hidden
            TechTalk.SpecFlow.Table table943 = new TechTalk.SpecFlow.Table(new string[] {
                        "LoanTypeCode",
                        "OfficerCode",
                        "MIOCode",
                        "RecovererCode"});
            table943.AddRow(new string[] {
                        "CONS",
                        "433902",
                        "BANK",
                        "GL03"});
#line 10
 testRunner.And("The user modifies the account record in DL file with credentials:", ((string)(null)), table943, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4147")]
        public virtual void CITI_4147()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4147", "Citi Home Cell is good, agent changes this Home Location to Work, there is no oth" +
                    "er work phone in ARx", ((string[])(null)));
#line 15
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
                TechTalk.SpecFlow.Table table944 = new TechTalk.SpecFlow.Table(new string[] {
                            "HomeNumber",
                            "HomeIndicator",
                            "WorkNumber",
                            "WorkIndicator"});
                table944.AddRow(new string[] {
                            "6479991111",
                            "H",
                            "",
                            ""});
#line 17
 testRunner.Given("The user modifies the account record in DL file with credentials:", ((string)(null)), table944, "Given ");
#line hidden
                TechTalk.SpecFlow.Table table945 = new TechTalk.SpecFlow.Table(new string[] {
                            "CellNumber",
                            "CellIndicator"});
                table945.AddRow(new string[] {
                            "6479993333",
                            "J"});
#line 20
 testRunner.Given("The user modifies the X00 record in DL file with credentials:", ((string)(null)), table945, "Given ");
#line hidden
#line 23
 testRunner.When("The user drops the file to the client UNC path", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 24
 testRunner.And("The file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 25
 testRunner.When("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 26
 testRunner.And("The user generates an outbound maintenance file for BANK_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 27
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 28
 testRunner.When("the user changes the phone number 6479991111 to location Work", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 29
 testRunner.And("the user creates a call record for phone number 6479991111 with Right Party Conta" +
                        "ct as true", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 30
 testRunner.And("The user generates an outbound maintenance file for BANK_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 31
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table946 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table946.AddRow(new string[] {
                            "MASOPH",
                            "6479991111"});
                table946.AddRow(new string[] {
                            "MASOPF",
                            ""});
#line 32
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table946, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion