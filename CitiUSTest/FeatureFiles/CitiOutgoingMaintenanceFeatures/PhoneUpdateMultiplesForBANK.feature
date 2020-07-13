@OutboundMaintenance @Phones @MultipleChanges @epic:84633
Feature: Multiples Phones Updates for BANK

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_4344
Citi Cell is good, agent changes this Cell status to Active and doing multiple changes test A1
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             | 
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    | 
	When the user changes the phone number 6479993333 to status Active
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |  
	When the user changes the phone number 6479991111 to status Wrong Number
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
	When the user changes the phone number 6479993333 to status Wireless
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479993333 to status Active
	When the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |
	When the user changes the phone number 6479991111 to status Active
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASRPH    |
		| MASRPF    |	


Scenario: CITI_4345
Citi Cell is good, agent changes this Cell status to Active and doing multiple changes test A2
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479993333 to status Active
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to status Wrong Number
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
	When the user changes the phone number 6479993333 to status Wireless
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479993333 to status Active
	When the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |

###############################################################################
Scenario: CITI_4346
Citi Cell is good, agent changes this Cell status to Active and doing multiple changes test A3
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479993333 to status Active
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to status Wrong Number
	When the user changes the phone number 6479991111 to status Active
	When the user changes the phone number 6479991111 to status Verbal Do Not Call
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | V          |
