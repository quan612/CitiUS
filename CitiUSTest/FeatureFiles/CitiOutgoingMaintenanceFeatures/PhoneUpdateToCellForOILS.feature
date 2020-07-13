@OutboundMaintenance @Cell @OILS @epic:84633
Feature: Phone Update To Cell for OILS
	To test sending of phone to Citi related to Home	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4462
Citi Cell is good, agent changes this cell to Not In Service (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Not In Service
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |


Scenario: CITI_4463
Citi Cell is Verbal DNC, agent changes this cell to Active (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Active
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479993333 |
		| MASCPI     | Y          |