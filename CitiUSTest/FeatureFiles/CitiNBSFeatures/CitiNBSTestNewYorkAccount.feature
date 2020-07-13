Feature: CitiNBSTestAccountInNewYork
	To test the loading of new Citi accounts that have state in New York

#Scenario: CITI_670
#Verify new business file for accounts that in New York and text7 does not start with P
#	Given The user modifies the Citi New Business File with state in New York and Extras.Text does not start with P
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account is put to desk 22
#	Then The account is put to support queue NewYorkAccounts
#	
#Scenario: CITI_671
#Verify new business file for accounts that not in New York
#	Given The user modifies the Citi New Business File with state not in New York
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account is put to desk 1
#	Then The account is not moved to any support queue	
#	
#Scenario: CITI_672
#Verify new business file for account in New York with text7 starting with P
#	Given The user modifies the Citi New Business File with state in New York and Extras.Text starts with P
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The account is put to desk 1
#	Then The account is not moved to any support queue		
