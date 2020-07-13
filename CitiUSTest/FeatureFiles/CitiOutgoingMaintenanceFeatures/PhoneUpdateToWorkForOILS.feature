@OutboundMaintenance @Work @OILS
Feature: Phone Update To Work for OILS
	To test sending of phone to Citi related to  Work updates 	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4351
Citi Home Work are different and good and load Written DNC Home in MT that applies to all phone status (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | E             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479993333 |
		| Today's date         | MT               | MASHPF     | C          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 3           | Home         | Landline    |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASOPH     | 6479992222 |
		| MASOPF     | C          |