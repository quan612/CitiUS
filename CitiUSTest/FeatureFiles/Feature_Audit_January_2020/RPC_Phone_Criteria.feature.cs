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
namespace CitiUSTest.FeatureFiles.Feature_Audit_January_2020
{
    using TechTalk.SpecFlow;
    using System;
    using System.Linq;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "3.1.0.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("RPC_Phone_Criteria")]
    [NUnit.Framework.CategoryAttribute("OutboundMaintenance")]
    [NUnit.Framework.CategoryAttribute("Audit")]
    public partial class RPC_Phone_CriteriaFeature
    {
        
        private TechTalk.SpecFlow.ITestRunner testRunner;
        
        private string[] _featureTags = new string[] {
                "OutboundMaintenance",
                "Audit"};
        
#line 1 "RPC_Phone_Criteria.feature"
#line hidden
        
        [NUnit.Framework.OneTimeSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "RPC_Phone_Criteria", null, ProgrammingLanguage.CSharp, new string[] {
                        "OutboundMaintenance",
                        "Audit"});
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
#line 4
#line hidden
#line 5
 testRunner.Given("The user creates a Citi NBS based on the sample file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table1311 = new TechTalk.SpecFlow.Table(new string[] {
                        "MIOCode",
                        "ListDate"});
            table1311.AddRow(new string[] {
                        "OILS",
                        "2019/08/15"});
#line 6
 testRunner.And("The user modifies the header record with credentials:", ((string)(null)), table1311, "And ");
#line hidden
            TechTalk.SpecFlow.Table table1312 = new TechTalk.SpecFlow.Table(new string[] {
                        "LoanTypeCode",
                        "OfficerCode",
                        "MIOCode",
                        "RecovererCode"});
            table1312.AddRow(new string[] {
                        "CONS",
                        "0800",
                        "OILS",
                        "GIC5"});
#line 9
 testRunner.And("The user modifies the recoverer in DL file with credentials:", ((string)(null)), table1312, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4587")]
        public virtual void CITI_4587()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4587", "Verify the sending of phone when a new number is set up and there is a call recor" +
                    "d for this account that is Right Party Contact", ((string[])(null)));
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
#line 4
this.FeatureBackground();
#line hidden
#line 17
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 18
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 19
 testRunner.And("the user adds a new number 6479991111 with status Active location Home service La" +
                        "ndline", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 20
 testRunner.And("the user creates a call record for phone number 6479991111 with Right Party Conta" +
                        "ct as true", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 21
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 22
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1313 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1313.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1313.AddRow(new string[] {
                            "MASHPF",
                            "Y"});
#line 23
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1313, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4588")]
        public virtual void CITI_4588()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4588", "Verify the sending of phone when a new number is set up and there is a call recor" +
                    "d for this account but it is not RPC", ((string[])(null)));
#line 30
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
#line 4
this.FeatureBackground();
#line hidden
#line 32
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 33
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 34
 testRunner.And("the user adds a new number 6479991111 with status Active location Home service La" +
                        "ndline", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 35
 testRunner.And("the user creates a call record for phone number 6479991111 with Right Party Conta" +
                        "ct as false", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 36
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 37
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1314 = new TechTalk.SpecFlow.Table(new string[] {
                            "FieldCode"});
                table1314.AddRow(new string[] {
                            "MASHPH"});
                table1314.AddRow(new string[] {
                            "MASHPF"});
                table1314.AddRow(new string[] {
                            "MASOPH"});
                table1314.AddRow(new string[] {
                            "MASOPF"});
                table1314.AddRow(new string[] {
                            "MASCNT"});
                table1314.AddRow(new string[] {
                            "MASOCC"});
                table1314.AddRow(new string[] {
                            "MASRPH"});
                table1314.AddRow(new string[] {
                            "MASRPF"});
#line 38
 testRunner.Then("The records below should not be sent for the account in the file", ((string)(null)), table1314, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4589")]
        public virtual void CITI_4589()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4589", "Verify the sending of phone when a new number is set up and there is a no call re" +
                    "cord for this account", ((string[])(null)));
#line 51
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
#line 4
this.FeatureBackground();
#line hidden
#line 53
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 54
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 55
 testRunner.And("the user adds a new number 6479991111 with status Active location Home service La" +
                        "ndline", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 56
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 57
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1315 = new TechTalk.SpecFlow.Table(new string[] {
                            "FieldCode"});
                table1315.AddRow(new string[] {
                            "MASHPH"});
                table1315.AddRow(new string[] {
                            "MASHPF"});
                table1315.AddRow(new string[] {
                            "MASOPH"});
                table1315.AddRow(new string[] {
                            "MASOPF"});
                table1315.AddRow(new string[] {
                            "MASCNT"});
                table1315.AddRow(new string[] {
                            "MASOCC"});
                table1315.AddRow(new string[] {
                            "MASRPH"});
                table1315.AddRow(new string[] {
                            "MASRPF"});
#line 58
 testRunner.Then("The records below should not be sent for the account in the file", ((string)(null)), table1315, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4590")]
        public virtual void CITI_4590()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4590", "Verify the sending of phone when a new number is set up and there is a call recor" +
                    "d set up many days later", ((string[])(null)));
#line 71
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
#line 4
this.FeatureBackground();
#line hidden
#line 73
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 74
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 75
 testRunner.And("the user adds a new number 6479991111 with status Active location Home service La" +
                        "ndline", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 76
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 77
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1316 = new TechTalk.SpecFlow.Table(new string[] {
                            "FieldCode"});
                table1316.AddRow(new string[] {
                            "MASHPH"});
                table1316.AddRow(new string[] {
                            "MASHPF"});
                table1316.AddRow(new string[] {
                            "MASOPH"});
                table1316.AddRow(new string[] {
                            "MASOPF"});
                table1316.AddRow(new string[] {
                            "MASCNT"});
                table1316.AddRow(new string[] {
                            "MASOCC"});
                table1316.AddRow(new string[] {
                            "MASRPH"});
                table1316.AddRow(new string[] {
                            "MASRPF"});
#line 78
 testRunner.Then("The records below should not be sent for the account in the file", ((string)(null)), table1316, "Then ");
#line hidden
#line 88
 testRunner.When("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 89
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1317 = new TechTalk.SpecFlow.Table(new string[] {
                            "FieldCode"});
                table1317.AddRow(new string[] {
                            "MASHPH"});
                table1317.AddRow(new string[] {
                            "MASHPF"});
                table1317.AddRow(new string[] {
                            "MASOPH"});
                table1317.AddRow(new string[] {
                            "MASOPF"});
                table1317.AddRow(new string[] {
                            "MASCNT"});
                table1317.AddRow(new string[] {
                            "MASOCC"});
                table1317.AddRow(new string[] {
                            "MASRPH"});
                table1317.AddRow(new string[] {
                            "MASRPF"});
#line 90
 testRunner.Then("The records below should not be sent for the account in the file", ((string)(null)), table1317, "Then ");
#line hidden
#line 100
 testRunner.When("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 101
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1318 = new TechTalk.SpecFlow.Table(new string[] {
                            "FieldCode"});
                table1318.AddRow(new string[] {
                            "MASHPH"});
                table1318.AddRow(new string[] {
                            "MASHPF"});
                table1318.AddRow(new string[] {
                            "MASOPH"});
                table1318.AddRow(new string[] {
                            "MASOPF"});
                table1318.AddRow(new string[] {
                            "MASCNT"});
                table1318.AddRow(new string[] {
                            "MASOCC"});
                table1318.AddRow(new string[] {
                            "MASRPH"});
                table1318.AddRow(new string[] {
                            "MASRPF"});
#line 102
 testRunner.Then("The records below should not be sent for the account in the file", ((string)(null)), table1318, "Then ");
#line hidden
#line 112
 testRunner.When("the user creates a call record for phone number 6479991111 with Right Party Conta" +
                        "ct as true", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 113
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 114
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1319 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1319.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1319.AddRow(new string[] {
                            "MASHPF",
                            "Y"});
#line 115
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1319, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4591")]
        public virtual void CITI_4591()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4591", "Verify the sending of phone when a new number is set up with RPC and the status i" +
                    "s changed multiple times", ((string[])(null)));
#line 122
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
#line 4
this.FeatureBackground();
#line hidden
#line 124
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 125
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 126
 testRunner.And("the user adds a new number 6479991111 with status Active location Home service La" +
                        "ndline", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 127
 testRunner.When("the user creates a call record for phone number 6479991111 with Right Party Conta" +
                        "ct as true", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 128
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 129
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1320 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1320.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1320.AddRow(new string[] {
                            "MASHPF",
                            "Y"});
#line 130
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1320, "Then ");
#line hidden
#line 134
 testRunner.When("the user changes the phone number 6479991111 to status Verbal Do Not Call", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 135
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 136
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1321 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1321.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1321.AddRow(new string[] {
                            "MASHPF",
                            "X"});
#line 137
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1321, "Then ");
#line hidden
#line 141
 testRunner.When("the user changes the phone number 6479991111 to status Active", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 142
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 143
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1322 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1322.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1322.AddRow(new string[] {
                            "MASHPF",
                            "Y"});
#line 144
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1322, "Then ");
#line hidden
#line 148
 testRunner.When("the user changes the phone number 6479991111 to status Written DNC", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 149
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 150
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1323 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1323.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1323.AddRow(new string[] {
                            "MASHPF",
                            "C"});
#line 151
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1323, "Then ");
#line hidden
#line 155
 testRunner.When("the user changes the phone number 6479991111 to status Active", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 156
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 157
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1324 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1324.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1324.AddRow(new string[] {
                            "MASHPF",
                            "Y"});
#line 158
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1324, "Then ");
#line hidden
#line 162
 testRunner.When("the user changes the phone number 6479991111 to status Not In Service", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 163
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 164
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1325 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1325.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1325.AddRow(new string[] {
                            "MASHPF",
                            "D"});
#line 165
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1325, "Then ");
#line hidden
#line 169
 testRunner.When("the user changes the phone number 6479991111 to status Active", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 170
 testRunner.And("The user generates an outbound maintenance file for OILS_ALL", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
#line 171
 testRunner.And("The associated job is completed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table1326 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field Code",
                            "New Value"});
                table1326.AddRow(new string[] {
                            "MASHPH",
                            "6479991111"});
                table1326.AddRow(new string[] {
                            "MASHPF",
                            "Y"});
#line 172
 testRunner.Then("The records are sent in the outbound maintenance file as below:", ((string)(null)), table1326, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
