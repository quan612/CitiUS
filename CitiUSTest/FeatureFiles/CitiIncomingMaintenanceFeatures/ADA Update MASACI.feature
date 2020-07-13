Feature: ADA Update MASACI
	To test the loading of inbound MT with field code MASACI
	
#--------------------------------------------------------------------------------
Scenario: CITI-4055
Verify the processing of MT file when field code MASACI is received and indicator B is accompanied
	Given The user creates a Citi NBS based on the sample file	
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
		And The user creates a Citi Inbound Maintenance File using account from previous steps:
			|Transaction DateTime | Transaction Code| Field Code| New Value|
			|2019/09/13			  | MT              | MASACI    | B        |
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished
	Then The account extras information: Text8 is B
		And A noteline is added to the account as ADA Indicator:Visually Impaired:  B

	
#--------------------------------------------------------------------------------
Scenario: CITI-1058
Verify the processing of MT file when field code MASACI is received and indicator E is accompanied
	
	Given The user creates a Citi NBS based on the sample file	
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
		And The user creates a Citi Inbound Maintenance File using account from previous steps:
			|Transaction DateTime | Transaction Code| Field Code| New Value|
			|2019/09/16			  | MT              | MASACI    | E        | 		

		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished

	Then The account extras information: Text8 is E
		And A noteline is added to the account as ADA Indicator:Visually Impaired:  E


#--------------------------------------------------------------------------------
Scenario: CITI-1059
	Verify the processing of MT file when field code MASACI is received and indicator D is accompanied
	
		Given The user creates a Citi NBS based on the sample file
		
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
			And The user creates a Citi Inbound Maintenance File using account from previous steps:
				|Transaction DateTime | Transaction Code| Field Code| New Value|
				|2019/09/16			  | MT              | MASACI    | D        | 		

			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished

		Then The account extras information: Text13 is D
		And A noteline is added to the account as ADA Indicator:Hearing Impaired:  D


#--------------------------------------------------------------------------------
Scenario: CITI-1060
Verify the processing of MT file when field code MASACI is received and indicator H is accompanied
	
	Given The user creates a Citi NBS based on the sample file	
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
		And The user creates a Citi Inbound Maintenance File using account from previous steps:
			|Transaction DateTime | Transaction Code| Field Code| New Value|
			|2019/09/16			  | MT              | MASACI    | H        |
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished

	Then The account extras information: Text19 is H
		And A noteline is added to the account as ADA Indicator:Speech Impaired:  H


#--------------------------------------------------------------------------------
Scenario: CITI-1062
Verify the processing of MT file when field code MASACI is received and a random indicator is received
	
	Given The user creates a Citi NBS based on the sample file	
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
		And The user creates a Citi Inbound Maintenance File using account from previous steps:
			|Transaction DateTime | Transaction Code| Field Code| New Value|
			|Today's date		  | MT              | MASACI    | A        |
		And The user drops the file to the client UNC path		

	Then A general error status happens when processing the row record
		And The account extras information: Text8 is null
		And The account extras information: Text13 is null
		And The account extras information: Text19 is null		