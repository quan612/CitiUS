@OutboundMaintenance @NoPhoneUpdate @OILS @epic:84633
Feature: NoPhoneUpdateForOILS
	To test sending of nothing to Citi


Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |


Scenario: CITI_4331
Citi Home Work Cell 4th are good and there is no phone update in ARx (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | B          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | M          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
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


Scenario: CITI_4332
Citi Home Work 4th are same and good and load a same Cell phone in MT file (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	And The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | W               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
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


Scenario: CITI_4349
Citi Home Work 4th are different and good and load Verbal DNC Home Work 4th in MT (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	And The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479993333        | E                    | M               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | N          |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | N          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASRPH    |
		| MASRPF    |


Scenario: CITI_4354
Verify that phone number like 0000000000 9999999999 should not be sent in outbound MT file even if it is in ARxCollect (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               |            |               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 1111111111 with status Active location Home service Landline
	And the user creates a call record for phone number 1111111111 with Right Party Contact as true
	And the user adds a new number 2222222222 with status Active location Work service Landline
	And the user creates a call record for phone number 2222222222 with Right Party Contact as true
	And the user adds a new number 3333333333 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 3333333333 with Right Party Contact as true
	And the user adds a new number 9999999999 with status Active location Home service Landline
	And the user creates a call record for phone number 9999999999 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
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


Scenario: CITI_4445
Citi Home Work Cell 4th are Not In Service then adding new good phones but there is no RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18          | Home         | Mobile      |
		| 6479994444  | N           | 3           | Unknown      | Unknown     |
	When the user adds a new number 6479995555 with status Active location Home service Landline
	When the user adds a new number 6479996666 with status Active location Home service Mobile
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


Scenario: CITI_4446
Citi Home Work Cell 4th are Not In Service then adding new good phones and there are call records but the dispositions are not RPC (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18          | Home         | Mobile      |
		| 6479994444  | N           | 3           | Unknown      | Unknown     |
	When the user adds a new number 6479995555 with status Active location Home service Landline
	When the user adds a new number 6479996666 with status Active location Home service Mobile
	And the user creates a call record for phone number 6479995555 with Right Party Contact as false
	And the user creates a call record for phone number 6479996666 with Right Party Contact as false
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


Scenario: CITI_4459
Citi Home Work Cell are Good, Home Work Cell changed to Verbal DNC by Citi MT (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | N          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | N          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18           | Home         | Mobile      |
	When The user generates an outbound maintenance file for OILS_ALL
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


Scenario: CITI_4460
Citi Home Work Cell are Good, Home Work Cell changed to Written DNC by Citi MT (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | E             | 6479992222 | E             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | C          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | C          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | C          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
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


Scenario: CITI_4461
Citi Home Work Cell are Good, Home Work Cell changed to Not In Service by Citi MT (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | E             | 6479992222 | E             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | D          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | D          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | D          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18           | Home         | Mobile      |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode  |
		| MASHPH     |
		| MASHPF     |
		| MASOPH     |
		| MASOPF     |
		| MASCPN     |
		| MASCPI     |
		| MASRPH     |
		| MASRPF     |


# location change
Scenario: CITI_4507
Citi Home is good, agent changes this Home Location to Work and there is another Work phone in ARx as good (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | H             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the client UNC path
	And The file is processed
	When A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to location Work
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
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
		

Scenario: CITI_4508
Citi Home Cell are Good, agent changes Citi Home service to Mobile (OILS)
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
	And the user changes the phone number 6479991111 to service Mobile
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

