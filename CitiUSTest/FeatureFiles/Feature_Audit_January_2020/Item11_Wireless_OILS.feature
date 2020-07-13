@OutboundMaintenance @Item11 @BANK
Feature: Item11_Wireless_OILS
	http://devtracker.globalcollection.net/f/cases/29037/Feature-Int-11-Citi-Audit_-Wireless-phone-numbers-should-not-be-sent-as-home-phone-number-to-Citi

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

#excel		
Scenario: CITI_4494
Verify outbound MT when Citi Home Work is good, in ARxCollect the user changes the Home to have Wireless status and add a new Home (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479991111 |
		| MASCPI     | Y          |
	When the user adds a new number 6479993333 with status Active location Home service Landline
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479993333 |
		| MASHPF     | Y          |
	
#excel
Scenario: CITI_4495
Verify outbound MT when Citi Home Work is good, in ARxCollect the user changes the Home to have Wireless status and add a new Home then add another Home (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479991111 |
		| MASCPI     | Y          |
	When the user adds a new number 6479993333 with status Active location Home service Landline
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479993333 |
		| MASHPF     | Y          |
	When the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |


Scenario: CITI_4496
Verify outbound MT when Citi Home Work Cell is good, in ARxCollect the user changes the Home to have Wireless status and add a new Home (OILS)
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
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
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
	When the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     | Y          |
		| MASRPH     | 6479991111 |
		| MASRPF     | Y          |
	

#excel
Scenario: CITI_4497
Citi Home would be replaced if the status is changed to Wireless (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
		And the user creates a call record for phone number 6479991111 with Right Party Contact as true
		And the user creates a call record for phone number 6479992222 with Right Party Contact as true
		And the user creates a call record for phone number 6479993333 with Right Party Contact as true
		And the user creates a call record for phone number 6479994444 with Right Party Contact as true	
	When the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
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
		| MASRPH    |
		| MASRPF    |  
	When the user changes the phone number 6479991111 to status Wireless	
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |


#same as above just the way to change the number to Cell		
Scenario: CITI_4498
Citi Home would be replaced if the service is changed to Mobile (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
		And the user creates a call record for phone number 6479991111 with Right Party Contact as true
		And the user creates a call record for phone number 6479992222 with Right Party Contact as true
		And the user creates a call record for phone number 6479993333 with Right Party Contact as true
		And the user creates a call record for phone number 6479994444 with Right Party Contact as true	
	When the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
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
		| MASRPH    |
		| MASRPF    |  
	When the user changes the phone number 6479991111 to service Mobile	
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |  		


#excel
Scenario: CITI_4499
Citi Cell would be replaced if the status is changed to Active and the service is changed to Landline (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
		And the user creates a call record for phone number 6479991111 with Right Party Contact as true
		And the user creates a call record for phone number 6479992222 with Right Party Contact as true
		And the user creates a call record for phone number 6479993333 with Right Party Contact as true
		And the user creates a call record for phone number 6479994444 with Right Party Contact as true	
	When the user adds a new number 6479995555 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
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
		| MASRPH    |
		| MASRPF    |  
	When the user changes the phone number 6479993333 to status Active
	When the user changes the phone number 6479993333 to service Landline
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASCPN     | 6479995555 |
		| MASCPI     | Y          |


### specific case  issue 29248, must send Wireless as Home as there is no replacement for Home
Scenario: CITI_4500
Citi 4th phone is sent when it has Wireless status and there is already a Citi Cell (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | N             | 6479992222 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | N          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | N          |
		And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
		And the user creates a call record for phone number 6479991111 with Right Party Contact as true
		And the user creates a call record for phone number 6479992222 with Right Party Contact as true
		And the user creates a call record for phone number 6479993333 with Right Party Contact as true
		And the user creates a call record for phone number 6479994444 with Right Party Contact as true	
	When the user adds a new number 6479995555 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASCPN     | 6479995555 |
		| MASCPI     | Y          |
	When the user changes the phone number 6479991111 to status Wireless
	When the user changes the phone number 6479991111 to service Landline
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |
		#| MASRPH     | 6479991111 |
		#| MASRPF     | Y          |


#excel
Scenario: CITI_4501
Citi Home Work Cell 4th is bad, add new good Home then change current Cell to Good then change current Home to Good (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | N             | 6479992222 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | N          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | N          |
		And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
		And the user creates a call record for phone number 6479991111 with Right Party Contact as true
		And the user creates a call record for phone number 6479992222 with Right Party Contact as true
		And the user creates a call record for phone number 6479993333 with Right Party Contact as true
		And the user creates a call record for phone number 6479994444 with Right Party Contact as true	
	When the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |
	When the user changes the phone number 6479993333 to status Wireless	
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASCPN     | 6479993333 |
		| MASCPI     | Y          |
	When the user changes the phone number 6479991111 to status Active
		And The user generates an outbound maintenance file for OILS_ALL
		And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASRPH     | 6479991111 |
		| MASRPF     | Y          |

