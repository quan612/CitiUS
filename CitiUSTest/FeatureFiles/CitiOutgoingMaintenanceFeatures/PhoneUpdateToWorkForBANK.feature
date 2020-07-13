@OutboundMaintenance @Work @BANK
Feature: Phone Update To Work for BANK
	To test sending of phone to Citi related to  Work updates 	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |

# location change
Scenario: CITI_4147
Citi Home Cell is good, agent changes this Home Location to Work, there is no other work phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             |            |               |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             |
	When The user drops the file to the client UNC path
	And The file is processed
	When A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to location Work
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASOPH     | 6479991111 |
		| MASOPF     |            |


