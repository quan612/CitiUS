@OutboundMaintenance @Cell @BANK @epic:84633
Feature: Phone Update To Cell for BANK
	To test sending of phone to Citi related to Cell updates 	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |

Scenario: CITI_4152
Citi Cell is good, agent changes this Cell to Wrong Number (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479993333 to status Wrong Number
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479993333 |
		| MASCPI     | B          |

Scenario: CITI_4158
Citi Cell is Not In Service, agent changes this cell to Active (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479993333 to status Active
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |

