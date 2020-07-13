﻿@Placement @Phones @CPLR @epic:84633
Feature: NbsPhonesForCPLR
	To test the loading of phone for new account loaded into the system for Citi CPLR accounts	


Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| CPLR    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 5015        | CPLR    | GIPS          |


Scenario: CITI_4413
Verify the phone status where MIO = CPLR and all phone Indicators = D
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | D             | 6479992222 | D             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |		
		| 6479993333  | N           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | D             | N              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | D             | N              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | D             | N              | Mobile              | Home                 |
