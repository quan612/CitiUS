@OutboundMaintenance @Cell @CPLR @epic:84633
Feature: Phone Update To Cell for CPLR
	To test sending of phone to Citi related to Cell	

Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| CPLR    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 5015        | CPLR    | GIPS          |

Scenario: CITI_4466
Citi Cell is good, agent changes this cell to Verbal DNC (CPLR)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Verbal Do Not Call
	And The user generates an outbound maintenance file for CPLR_SEARS
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479993333 |
		| MASCPI     | X          |


Scenario: CITI_4467
Citi Cell is Verbal DNC, agent changes this cell to Active (CPLR)
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
	And The user generates an outbound maintenance file for CPLR_SEARS
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479993333 |
		| MASCPI     | Y          |
