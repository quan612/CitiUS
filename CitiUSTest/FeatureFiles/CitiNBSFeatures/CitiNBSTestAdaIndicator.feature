Feature: CitiNBSTestAdaIndicator
	To test the loading of new accounts with ADA indicators within "X" record

#Scenario: CITI_650
#Verify the processing of new assignment file when ADA indicator = B
#	Given The user modifies the Citi New Business File with "X" record and ADA indicator equals to "B" - Visually Impaired
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account extras information: Text8 is B
#	
#Scenario: CITI_653
#Verify the processing of new assignment file when ADA indicator = E
#	Given The user modifies the Citi New Business File with "X" record and ADA indicator equals to "E" - Visually Impaired
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account extras information: Text8 is E
#
#Scenario: CITI_654
#Verify the processing of new assignment file when ADA indicator = D
#	Given The user modifies the Citi New Business File with "X" record and ADA indicator equals to "D" - Hearing Impaired
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account extras information: Text13 is D
#
#Scenario: CITI_655
#Verify the processing of new assignment file when ADA indicator = H
#	Given The user modifies the Citi New Business File with "X" record and ADA indicator equals to "H" - Speech Impaired
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account extras information: Text19 is H