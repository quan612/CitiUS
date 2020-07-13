Feature: CitiNBSTestLanguage
	To test the loading of language value for new account loaded into the system
	
#Scenario: CITI_3992
#Verify the processing of new business file when a language indicator is specified
#	Given The user modifies the Citi New Business File with a verbal indicator SP and written language indicator EN
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect	
#	Then The Account Verbal Language is Spanish
#	Then The Account Written Language is English
#
#Scenario: CITI_3989
#Verify the processing of new business file when a language indicator "FR" is received
#	Given The user modifies the Citi New Business File with a verbal indicator FR and written language indicator FR
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect	
#	Then The Account Verbal Language is English
#	Then The Account Written Language is English	 
#
#Scenario: CITI_3990
#Verify the noteline when processing a language indicator from new business file
#	Given The user modifies the Citi New Business File with a verbal indicator SP and written language indicator EN
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect	
#	Then The Account Verbal Language is Spanish
#	Then The Account Written Language is English
#	Then A noteline is added to the account as Written language indicator EN
#	Then A noteline is added to the account as Verbal language indicator SP 
#
#Scenario: CITI_3991
#Verify the processing of new business file when the language indicators are blank in the placement file
#	Given The user modifies the Citi New Business File with a verbal indicator BLANK and written language indicator BLANK
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect	
#	Then The Account Verbal Language is English
#	Then The Account Written Language is English
#	Then A noteline is added to the account as Written language indicator EN
#	Then A noteline is added to the account as Verbal language indicator EN 
