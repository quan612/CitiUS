Feature: _Demo for BANK

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |

Scenario: CITI_demoBank1
Citi Home Work Cell test supplemental
	Given The user modifies the account record in DL file with credentials:
	| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | CellNumber | CellIndicator | AccountStatus | State |
	| 6479991111 | L             | 6479992222 | L             | 6479993333 | L             | P30           | ON    | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCNT     | abc |
		| Today's date         | MT               | MASOCC     | bca          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
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
		| MASCNT    |
		| MASOCC    |
	