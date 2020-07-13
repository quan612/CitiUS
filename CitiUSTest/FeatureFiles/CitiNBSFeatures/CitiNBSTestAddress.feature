Feature: CitiNBSTestAddress
	To test the loading of address for Citi US account.

#Scenario: CITI_934
#Verify the saving of address when MIO is DSNB, OILS, CPLR and State = FC
#	Given The user modifies the Citi New Business File with line1 1041 GREENOAKS DR, line2 MISSISSAUGA ON L5J3A1, state FC, zip 00000 and MIO is either DSNB, OILS, or CPLR
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The primary address is: line1 1041 GREENOAKS DR, line2 MISSISSAUGA ON L5J3A1, city , province FC, postal code 00000
#
#Scenario: CITI_935
#Verify the saving of address when MIO = DSNB and State starts with X
#	Given The user modifies the Citi New Business File with state "XK"
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The primary address province is QC
#
#Scenario: CITI_936
#Verify the saving of address when MIO = DSNB, OILS, CPLR and State is not FC and State does not start with X and AccountAddress2 is NOT empty
#	Given The user modifies the Citi New Business File with line1 150 CASTELLANO, line2 APT 705, city EL PASO, state TX, zip 799120000 and MIO is either DSNB, OILS, or CPLR
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The primary address is: line1 APT 705, line2 150 CASTELLANO, city EL PASO, province TX, postal code 799120000
#
#Scenario: CITI_937
#Verify the saving of address when MIO = DSNB, OILS, CPLR and State is not FC and State does not start with X and AccountAddress2 is empty
#	Given The user modifies the Citi New Business File with line1 2737 N MOBILE AVE, city CHICAGO, state IL, zip 606391021 and MIO is either DSNB, OILS, or CPLR
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The primary address is: line1 2737 N MOBILE AVE, line2 , city CHICAGO, province IL, postal code 606391021
#
#Scenario: CITI_938
#Verify the saving of address when MIO is not DSNB, OILS, CPLR
#	Given The user modifies the Citi New Business File with line1 8009 S INDIANA AVE, line2 APT 1, city CHICAGO, state IL, zip 60619-3543 and MIO is either BANK, or COST
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The primary address is: line1 8009 S INDIANA AVE, line2 APT 1, city CHICAGO, province IL, postal code 60619-3543
#
#Scenario: CITI_939
#Verify if the address is ok to mail where Address Flag = L, W, B
#	Given The user modifies the Citi New Business File with Address Flag either L, W, or B
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	Then The primary address is not ok to mail