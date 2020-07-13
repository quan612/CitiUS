Feature: _Demo for OILS

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| OILS    | Yesterday |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_demo1
Citi Home Work Cell changed to Wrong Number many times
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479994444 | J             | 6479995555 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect	
	And the user changes all the phones number of the account to status Verbal Do Not Call
	And The user drops the file to the client UNC path
	And The file is processed
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The comment records are sent in the outbound maintenance file as below:
		| Transaction Code | New Value                  |
		| 94               | 647-999-4444 - Do Not Call |
		| 94               | 647-999-5555 - Do Not Call |		
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479994444 |
		| Today's date         | MT               | MASHPF     | D          |
		| Today's date         | MT               | MASOPH     | 6479995555 |
		| Today's date         | MT               | MASOPF     | D          |	
	And The user drops the file to the client UNC path
	And The file is processed
	When The user applies an action code 662
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed	
	Then The comment records are not sent in the outbound maintenance file
		| Transaction Code |
		| 94               |


Scenario: CITI_demo2
Citi Cell would be replaced if the status is changed to Active and the service is changed to Landline (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | D          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | D          |
		And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
		And the user creates a call record for phone number 6479991111 with Right Party Contact as true
		And the user creates a call record for phone number 6479992222 with Right Party Contact as true
		And the user creates a call record for phone number 6479993333 with Right Party Contact as true
		And the user creates a call record for phone number 6479994444 with Right Party Contact as true	
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | E          |		
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	

Scenario: CITI_demoOils3
Citi Home Work Cell test supplemental
	Given The user modifies the account record in DL file with credentials:
	| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | AccountStatus | State |
	| 6479991111 | E             | 6479992222 | E             | P30           | NC    |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect	
	#When The user creates a Citi Inbound Maintenance File using account from previous steps:
	#	| Transaction DateTime | Transaction Code | Field Code | New Value  |
	#	| Today's date         | MT               | MASCPN     | 6479993333 |
	#	| Today's date         | MT               | MASCPI     | N          |
	#	| Today's date         | MT               | MASRPH     | 6479994444 |
	#	| Today's date         | MT               | MASRPF     | N          |
	#And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
	#When The user creates a Citi Inbound Maintenance File using account from previous steps:
	#	| Transaction DateTime | Transaction Code | Field Code | New Value  |
	#	| Today's date         | MT               | MASCPN     | 6479993333 |
	#	| Today's date         | MT               | MASCPI     | E          |
	#	| Today's date         | MT               | MASRPH     | 6479994444 |
	#	| Today's date         | MT               | MASRPF     | E          |
	#And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
