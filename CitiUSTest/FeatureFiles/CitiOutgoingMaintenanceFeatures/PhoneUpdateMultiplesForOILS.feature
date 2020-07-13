@OutboundMaintenance @Phones @MultipleChanges @epic:84633
Feature: Multiples Phones Updates for OILS

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

# wireless to active - good to good - where there is a home - Then combination of steps
Scenario: CITI_4442
Citi Cell is good, agent changes this Cell status to Active and doing multiple changes test (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | E             | 6479992222 | E             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And The user generates an outbound maintenance file for OILS_ALL
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
	And The user generates an outbound maintenance file for OILS_ALL
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
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
	When the user changes the phone number 6479993333 to status Wireless
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
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
	When the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479996666 |
		| MASCPI     | Y          |
		| MASRPH     | 6479993333 |
		| MASRPF     | Y          |
	When the user changes the phone number 6479991111 to status Active
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |

###############################################################################
