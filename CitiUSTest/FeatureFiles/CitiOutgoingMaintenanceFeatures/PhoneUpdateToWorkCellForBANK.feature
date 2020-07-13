@OutboundMaintenance @WorkCell @BANK
Feature: Phone Update To Work Cell for BANK
	To test sending of phone to Citi related to Work Cell updates 	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_4262
Citi Home Work Cell are Good then receiving a bad indicator in Citi MT that applies to all phones (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | W          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASOPH     | 6479992222 |
		| MASOPF     | W          |
		| MASCPN     | 6479993333 |
		| MASCPI     | W          |



