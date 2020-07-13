@OutboundMaintenance @HomeWork @OILS
Feature: PhoneUpdateToHomeWorkForOILS
	To test sending of Home and Work phone to Citi

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| OILS    | Yesterday |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4352
Citi Home Work are different and good and load Verbal DNC Cell in MT that applies to all phone status (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | X          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | X          |
		| MASOPH     | 6479992222 |
		| MASOPF     | X          |


Scenario: CITI_4447
Citi Work 4th are good, a new Work is added and the Citi Work changed to Home (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               | 6479992222 | E             |
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479994444        | E                    | L               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479991111 with status Active location Work service Landline
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH     |
		| MASHPF     |
		| MASOPH     |
		| MASOPF     |
		| MASCPN     |
		| MASCPI     |
		| MASRPH     |
		| MASRPF     |
	When the user changes the phone number 6479992222 to location Home
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479992222 |
		| MASHPF     | Y          |
		| MASOPH     | 6479991111 |
		| MASOPF     | Y          |


Scenario: CITI_4448
Citi Home Work are good, changing location to Unknown and status to Wrong Number (OILS) (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When the user changes the phone number 6479991111 to location Unknown
	When the user changes the phone number 6479992222 to location Unknown
	When the user changes all the phones number of the account to status Wrong Number
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed	
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479992222 |
		| MASOPF     | N          |
