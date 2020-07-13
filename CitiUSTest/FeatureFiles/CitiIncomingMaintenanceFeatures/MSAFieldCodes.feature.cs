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
namespace CitiUSTest.FeatureFiles.CitiIncomingMaintenanceFeatures
{
    using TechTalk.SpecFlow;
    using System;
    using System.Linq;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "3.1.0.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("Inbound MT with MSA field codes")]
    [NUnit.Framework.CategoryAttribute("InboundMaintenance")]
    [NUnit.Framework.CategoryAttribute("MSA")]
    [NUnit.Framework.CategoryAttribute("epic:85568")]
    public partial class InboundMTWithMSAFieldCodesFeature
    {
        
        private TechTalk.SpecFlow.ITestRunner testRunner;
        
        private string[] _featureTags = new string[] {
                "InboundMaintenance",
                "MSA",
                "epic:85568"};
        
#line 1 "MSAFieldCodes.feature"
#line hidden
        
        [NUnit.Framework.OneTimeSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Inbound MT with MSA field codes", null, ProgrammingLanguage.CSharp, new string[] {
                        "InboundMaintenance",
                        "MSA",
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
#line 4
#line hidden
#line 5
 testRunner.Given("The user creates a Citi NBS based on the sample file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table123 = new TechTalk.SpecFlow.Table(new string[] {
                        "MIOCode",
                        "ListDate"});
            table123.AddRow(new string[] {
                        "OILS",
                        "2019/08/15"});
#line 6
  testRunner.And("The user modifies the header record with credentials:", ((string)(null)), table123, "And ");
#line hidden
            TechTalk.SpecFlow.Table table124 = new TechTalk.SpecFlow.Table(new string[] {
                        "LoanTypeCode",
                        "OfficerCode",
                        "MIOCode",
                        "RecovererCode"});
            table124.AddRow(new string[] {
                        "CONS",
                        "0800",
                        "OILS",
                        "GIC5"});
#line 9
  testRunner.And("The user modifies the recoverer in DL file with credentials:", ((string)(null)), table124, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4693")]
        public virtual void CITI_4693()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4693", "Verify the saving of MAS field codes for MSA when the values were blank from plac" +
                    "ement\t", ((string[])(null)));
#line 13
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
#line 15
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 16
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table125 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table125.AddRow(new string[] {
                            "Date1",
                            ""});
                table125.AddRow(new string[] {
                            "Text13",
                            ""});
                table125.AddRow(new string[] {
                            "Date2",
                            ""});
                table125.AddRow(new string[] {
                            "Date3",
                            ""});
                table125.AddRow(new string[] {
                            "Date4",
                            ""});
                table125.AddRow(new string[] {
                            "Date5",
                            ""});
                table125.AddRow(new string[] {
                            "Text14",
                            ""});
#line 17
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table125, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table126 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table126.AddRow(new string[] {
                            "MASPPI",
                            ""});
                table126.AddRow(new string[] {
                            "MASEM1",
                            ""});
                table126.AddRow(new string[] {
                            "MASEU1",
                            ""});
                table126.AddRow(new string[] {
                            "MASEI1",
                            ""});
                table126.AddRow(new string[] {
                            "MASEM2",
                            ""});
                table126.AddRow(new string[] {
                            "MASEI2",
                            ""});
                table126.AddRow(new string[] {
                            "MASEU2",
                            ""});
#line 26
 testRunner.Then("The eCollectApps.Citi.ExtrasOverflow table for the account is as below:", ((string)(null)), table126, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table127 = new TechTalk.SpecFlow.Table(new string[] {
                            "Transaction DateTime",
                            "Transaction Code",
                            "Field Code",
                            "New Value"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASPPI",
                            "AB"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEM1",
                            "email1@gmail.com"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEU1",
                            "Y"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEI1",
                            "Y"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEM2",
                            "email2@yahoo.com"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEI2",
                            "N"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEU2",
                            "N"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLRA",
                            "20201212"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASECI",
                            "H"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLND",
                            "20201111"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLSD",
                            "20201010"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASNSD",
                            "20200909"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASCLD",
                            "20200808"});
                table127.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASDVT",
                            "M"});
#line 35
 testRunner.When("The user creates a Citi Inbound Maintenance File using account from previous step" +
                        "s:", ((string)(null)), table127, "When ");
#line hidden
#line 51
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 52
 testRunner.And("The ECollectUpdate Job is finished", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table128 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table128.AddRow(new string[] {
                            "Date1",
                            "12/12/2020 12:00:00 AM"});
                table128.AddRow(new string[] {
                            "Text13",
                            "H"});
                table128.AddRow(new string[] {
                            "Date2",
                            "11/11/2020 12:00:00 AM"});
                table128.AddRow(new string[] {
                            "Date3",
                            "10/10/2020 12:00:00 AM"});
                table128.AddRow(new string[] {
                            "Date4",
                            "9/9/2020 12:00:00 AM"});
                table128.AddRow(new string[] {
                            "Date5",
                            "8/8/2020 12:00:00 AM"});
                table128.AddRow(new string[] {
                            "Text14",
                            "M"});
#line 53
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table128, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table129 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table129.AddRow(new string[] {
                            "MASPPI",
                            "AB"});
                table129.AddRow(new string[] {
                            "MASEM1",
                            "email1@gmail.com"});
                table129.AddRow(new string[] {
                            "MASEU1",
                            "Y"});
                table129.AddRow(new string[] {
                            "MASEI1",
                            "Y"});
                table129.AddRow(new string[] {
                            "MASEM2",
                            "email2@yahoo.com"});
                table129.AddRow(new string[] {
                            "MASEI2",
                            "N"});
                table129.AddRow(new string[] {
                            "MASEU2",
                            "N"});
#line 62
 testRunner.Then("The eCollectApps.Citi.ExtrasOverflow table for the account is as below:", ((string)(null)), table129, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4694")]
        public virtual void CITI_4694()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4694", "Verify the saving of MAS field codes for MSA when the values are different in inb" +
                    "ound MT", ((string[])(null)));
#line 72
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
                TechTalk.SpecFlow.Table table130 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table130.AddRow(new string[] {
                            "MsaPromoPrefInd",
                            "76"});
                table130.AddRow(new string[] {
                            "MsaEmail1Addr",
                            "email1@gmail.vn"});
                table130.AddRow(new string[] {
                            "MsaEmail1Usblty",
                            "U"});
                table130.AddRow(new string[] {
                            "MsaEmail1Cnsnt",
                            "U"});
                table130.AddRow(new string[] {
                            "MsaEmail2Addr",
                            "email2@yahoo.vn"});
                table130.AddRow(new string[] {
                            "MsaEmail2Usblty",
                            "B"});
                table130.AddRow(new string[] {
                            "MsaEmail2Cnsnt",
                            "B"});
                table130.AddRow(new string[] {
                            "MsaDtLasReage",
                            "20201212"});
                table130.AddRow(new string[] {
                            "MsaErlyCoInd",
                            "H"});
                table130.AddRow(new string[] {
                            "MsaDtLstBadCk",
                            "20201111"});
                table130.AddRow(new string[] {
                            "MsaLstStmtDt",
                            "20201010"});
                table130.AddRow(new string[] {
                            "MsaNxtStmtDt",
                            "20200909"});
                table130.AddRow(new string[] {
                            "MsaCloseDt",
                            "20200808"});
                table130.AddRow(new string[] {
                            "MsaDeviceType",
                            "M"});
#line 74
 testRunner.Given("The user modifies the X00 record in DL file with credentials:", ((string)(null)), table130, "Given ");
#line hidden
#line 90
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 91
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table131 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table131.AddRow(new string[] {
                            "Date1",
                            "12/12/2020 12:00:00 AM"});
                table131.AddRow(new string[] {
                            "Text13",
                            "H"});
                table131.AddRow(new string[] {
                            "Date2",
                            "11/11/2020 12:00:00 AM"});
                table131.AddRow(new string[] {
                            "Date3",
                            "10/10/2020 12:00:00 AM"});
                table131.AddRow(new string[] {
                            "Date4",
                            "9/9/2020 12:00:00 AM"});
                table131.AddRow(new string[] {
                            "Date5",
                            "8/8/2020 12:00:00 AM"});
                table131.AddRow(new string[] {
                            "Text14",
                            "M"});
#line 92
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table131, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table132 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table132.AddRow(new string[] {
                            "MASPPI",
                            "76"});
                table132.AddRow(new string[] {
                            "MASEM1",
                            "email1@gmail.vn"});
                table132.AddRow(new string[] {
                            "MASEU1",
                            "U"});
                table132.AddRow(new string[] {
                            "MASEI1",
                            "U"});
                table132.AddRow(new string[] {
                            "MASEM2",
                            "email2@yahoo.vn"});
                table132.AddRow(new string[] {
                            "MASEI2",
                            "B"});
                table132.AddRow(new string[] {
                            "MASEU2",
                            "B"});
#line 101
 testRunner.Then("The eCollectApps.Citi.ExtrasOverflow table for the account is as below:", ((string)(null)), table132, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table133 = new TechTalk.SpecFlow.Table(new string[] {
                            "Transaction DateTime",
                            "Transaction Code",
                            "Field Code",
                            "New Value"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASPPI",
                            "YU"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEM1",
                            "email1B@gmail.com"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEU1",
                            "N"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEI1",
                            "N"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEM2",
                            "email2B@yahoo.com"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEI2",
                            "Y"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEU2",
                            "Y"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLRA",
                            "20211212"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASECI",
                            "N"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLND",
                            "20211111"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLSD",
                            "20211010"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASNSD",
                            "20210909"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASCLD",
                            "20210808"});
                table133.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASDVT",
                            "D"});
#line 110
 testRunner.When("The user creates a Citi Inbound Maintenance File using account from previous step" +
                        "s:", ((string)(null)), table133, "When ");
#line hidden
#line 126
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 127
 testRunner.And("The ECollectUpdate Job is finished", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table134 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table134.AddRow(new string[] {
                            "Date1",
                            "12/12/2021 12:00:00 AM"});
                table134.AddRow(new string[] {
                            "Text13",
                            "N"});
                table134.AddRow(new string[] {
                            "Date2",
                            "11/11/2021 12:00:00 AM"});
                table134.AddRow(new string[] {
                            "Date3",
                            "10/10/2021 12:00:00 AM"});
                table134.AddRow(new string[] {
                            "Date4",
                            "9/9/2021 12:00:00 AM"});
                table134.AddRow(new string[] {
                            "Date5",
                            "8/8/2021 12:00:00 AM"});
                table134.AddRow(new string[] {
                            "Text14",
                            "D"});
#line 128
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table134, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table135 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table135.AddRow(new string[] {
                            "MASPPI",
                            "YU"});
                table135.AddRow(new string[] {
                            "MASEM1",
                            "email1B@gmail.com"});
                table135.AddRow(new string[] {
                            "MASEU1",
                            "N"});
                table135.AddRow(new string[] {
                            "MASEI1",
                            "N"});
                table135.AddRow(new string[] {
                            "MASEM2",
                            "email2B@yahoo.com"});
                table135.AddRow(new string[] {
                            "MASEI2",
                            "Y"});
                table135.AddRow(new string[] {
                            "MASEU2",
                            "Y"});
#line 137
 testRunner.Then("The eCollectApps.Citi.ExtrasOverflow table for the account is as below:", ((string)(null)), table135, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CITI_4695")]
        public virtual void CITI_4695()
        {
            string[] tagsOfScenario = ((string[])(null));
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CITI_4695", "Verify the saving of MAS field codes for MSA when the values are blank in inbound" +
                    " MT", ((string[])(null)));
#line 147
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
                TechTalk.SpecFlow.Table table136 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table136.AddRow(new string[] {
                            "MsaPromoPrefInd",
                            "9C"});
                table136.AddRow(new string[] {
                            "MsaEmail1Addr",
                            "email1@gmail.com"});
                table136.AddRow(new string[] {
                            "MsaEmail1Usblty",
                            "Y"});
                table136.AddRow(new string[] {
                            "MsaEmail1Cnsnt",
                            "Y"});
                table136.AddRow(new string[] {
                            "MsaEmail2Addr",
                            "email2@yahoo.com"});
                table136.AddRow(new string[] {
                            "MsaEmail2Usblty",
                            "N"});
                table136.AddRow(new string[] {
                            "MsaEmail2Cnsnt",
                            "N"});
                table136.AddRow(new string[] {
                            "MsaDtLasReage",
                            "20201212"});
                table136.AddRow(new string[] {
                            "MsaErlyCoInd",
                            "H"});
                table136.AddRow(new string[] {
                            "MsaDtLstBadCk",
                            "20201111"});
                table136.AddRow(new string[] {
                            "MsaLstStmtDt",
                            "20201010"});
                table136.AddRow(new string[] {
                            "MsaNxtStmtDt",
                            "20200909"});
                table136.AddRow(new string[] {
                            "MsaCloseDt",
                            "20200808"});
                table136.AddRow(new string[] {
                            "MsaDeviceType",
                            "M"});
#line 149
 testRunner.Given("The user modifies the X00 record in DL file with credentials:", ((string)(null)), table136, "Given ");
#line hidden
#line 165
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 166
 testRunner.And("A new account is placed in ARxCollect", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table137 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table137.AddRow(new string[] {
                            "Date1",
                            "12/12/2020 12:00:00 AM"});
                table137.AddRow(new string[] {
                            "Text13",
                            "H"});
                table137.AddRow(new string[] {
                            "Date2",
                            "11/11/2020 12:00:00 AM"});
                table137.AddRow(new string[] {
                            "Date3",
                            "10/10/2020 12:00:00 AM"});
                table137.AddRow(new string[] {
                            "Date4",
                            "9/9/2020 12:00:00 AM"});
                table137.AddRow(new string[] {
                            "Date5",
                            "8/8/2020 12:00:00 AM"});
                table137.AddRow(new string[] {
                            "Text14",
                            "M"});
#line 167
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table137, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table138 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table138.AddRow(new string[] {
                            "MASPPI",
                            "9C"});
                table138.AddRow(new string[] {
                            "MASEM1",
                            "email1@gmail.com"});
                table138.AddRow(new string[] {
                            "MASEU1",
                            "Y"});
                table138.AddRow(new string[] {
                            "MASEI1",
                            "Y"});
                table138.AddRow(new string[] {
                            "MASEM2",
                            "email2@yahoo.com"});
                table138.AddRow(new string[] {
                            "MASEI2",
                            "N"});
                table138.AddRow(new string[] {
                            "MASEU2",
                            "N"});
#line 176
 testRunner.Then("The eCollectApps.Citi.ExtrasOverflow table for the account is as below:", ((string)(null)), table138, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table139 = new TechTalk.SpecFlow.Table(new string[] {
                            "Transaction DateTime",
                            "Transaction Code",
                            "Field Code",
                            "New Value"});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASPPI",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEM1",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEU1",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEI1",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEM2",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEI2",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASEU2",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLRA",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASECI",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLND",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASLSD",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASNSD",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASCLD",
                            ""});
                table139.AddRow(new string[] {
                            "Today\'s date",
                            "MT",
                            "MASDVT",
                            ""});
#line 185
 testRunner.When("The user creates a Citi Inbound Maintenance File using account from previous step" +
                        "s:", ((string)(null)), table139, "When ");
#line hidden
#line 201
 testRunner.When("The user drops the file to the UNC path, and the file is processed", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
#line 202
 testRunner.And("The ECollectUpdate Job is finished", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
                TechTalk.SpecFlow.Table table140 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table140.AddRow(new string[] {
                            "Date1",
                            ""});
                table140.AddRow(new string[] {
                            "Text13",
                            ""});
                table140.AddRow(new string[] {
                            "Date2",
                            ""});
                table140.AddRow(new string[] {
                            "Date3",
                            ""});
                table140.AddRow(new string[] {
                            "Date4",
                            ""});
                table140.AddRow(new string[] {
                            "Date5",
                            ""});
                table140.AddRow(new string[] {
                            "Text14",
                            ""});
#line 203
 testRunner.Then("The Interal Extras table for the account is as below:", ((string)(null)), table140, "Then ");
#line hidden
                TechTalk.SpecFlow.Table table141 = new TechTalk.SpecFlow.Table(new string[] {
                            "Field",
                            "Value"});
                table141.AddRow(new string[] {
                            "MASPPI",
                            ""});
                table141.AddRow(new string[] {
                            "MASEM1",
                            ""});
                table141.AddRow(new string[] {
                            "MASEU1",
                            ""});
                table141.AddRow(new string[] {
                            "MASEI1",
                            ""});
                table141.AddRow(new string[] {
                            "MASEM2",
                            ""});
                table141.AddRow(new string[] {
                            "MASEI2",
                            ""});
                table141.AddRow(new string[] {
                            "MASEU2",
                            ""});
#line 212
 testRunner.Then("The eCollectApps.Citi.ExtrasOverflow table for the account is as below:", ((string)(null)), table141, "Then ");
#line hidden
            }
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion