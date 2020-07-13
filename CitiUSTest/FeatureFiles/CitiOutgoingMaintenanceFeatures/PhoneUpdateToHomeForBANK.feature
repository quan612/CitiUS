@OutboundMaintenance @Home @BANK
Feature: Phone Update To Home for BANK
	To test sending of phone to Citi related to Home, Work, Cell number updates 	

Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| BANK    | Yesterday|
		And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |
		

Scenario: CITI_4131
Citi Home is good, agent changes this Home Location to Work and status to bad at the same time, there is no other Home in ARx (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               |            |               |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	When the user adds a new number 6479991111 with status Active location Home service Landline
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     |            |
	When the user changes the phone number 6479991111 to location Work
	And the user changes the phone number 6479991111 to status Wrong Number
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |


Scenario: CITI_4133
Receive different indicators for same Home Work Cell, Home Good Work Bad Cell Bad, verify the outgoing file (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479991111 | B             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | X             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect		
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | V          |


			