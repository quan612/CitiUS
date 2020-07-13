@OutboundMaintenance @Home @OILS
Feature: Phone Update To Home for OILS
	To test sending of phone to Citi related to Home	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4347
Citi Home Work are different and good, there is no other phone in ARx, receive Cell that matches Citi Home in MT file, add a new Home in ARx (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | B          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	When the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     | Y          |


##########################################################################
Scenario: CITI_4119
Citi Home is good and then user changes the Home to Wrong Number (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	And the user adds a new number 6479993333 with status Active location Home service Landline
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASHPH     | 6479993333 |
		| MASHPF     | Y          |		
