Feature: CitiNBSTestAccountRecord
	To test the loading of new Citi accounts from "A" record

Scenario: CITI_1
Verify the records within A00 can be processed and saved to database as expected
#	Given The user modifies the Citi New Business File with "A" record
#	When The user drops the file to the client UNC path
#	And The file is processed
#	And A new account is placed in ARxCollect
#	#Then The account information is: DOB1 is mapped as 6/12/1988
#	Then The employer information: EmployerName is Global Affinity
#	Then The employer information: AddressLine1 is 1490 Denison Street
#	Then The account extras information: Text4 is A1B2
#	Then The account extras information: Text5 is D321
#	Then The account extras information: Text6 is 75
#	Then The account extras information: Text7 is 315
#	Then The account extras information: Number1 is 11
#	Then The account extras information: Text24 is G
#
#	
#	Then The account information: ServiceDate is 1/3/2017
#	Then The account information: ChargeOffDate is 1/4/2017
#	Then The account information: CommissionRate is 51.15
#	Then The account information: SIN1 is 45540789
#	
#	Then The account extras information: Currency1 is 1234.36
#	Then The account extras information: Currency2 is 1.34
#	Then The account extras information: Currency3 is 2.45
#	#net principal
#	Then The account extras information: Currency4 is 5050.55  
#	Then The account extras information: Currency6 is 3.75
#	#fee balance
#	Then The account extras information: Currency8 is 47.82
#	#past due
#	Then The account extras information: Currency14 is 78.00
#	Then The account extras information: Currency17 is 4000.91
#	Then The account extras information: Currency22 is 45.78
#	#total due
#	Then The account extras information: Currency27 is 433.00
#	Then The account extras information: Currency28 is 50.05
#	#Principal due
#	Then The account extras information: Currency29 is 500.71
#	Then The account extras information: Currency33 is 12.21
#	Then The account extras information: Currency34 is 175.57
#	Then The account extras information: Currency35 is 34.96
#
#
#	#total currentDue
#	Then The account extras information: Currency9 is 5.73
#
#	Then The account extras information: Date1 is 1/5/2017
#	Then The account extras information: Date2 is 1/9/2018
#	Then The account extras information: Date3 is 1/10/2018
#	Then The account extras information: Date4 is 1/11/2018
#	Then The account extras information: Date5 is 1/2/2018
#	Then The account extras information: Date8 is 1/6/2018
#
#	#Then The account information: CurrentBalance is 9876.19
#	Then The account extras information: Text1 is N
#	Then The account extras information: Text25 is W
#	#status reason
#	Then The account extras information: Text27 is 203
#	#joint
#	Then The account extras information: Text29 is C
#
#
#	#todo: make contacts table test step, for AKA1
#
#	Then The account extras information: Number16 is 1
	#Then The account information is: Name2 is mapped as RUSSELL H HANSTEIN
