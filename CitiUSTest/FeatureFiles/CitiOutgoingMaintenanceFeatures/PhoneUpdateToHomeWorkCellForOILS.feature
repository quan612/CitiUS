@OutboundMaintenance @HomeWorkCell @OILS @epic:84633
Feature: PhoneUpdateToHomeWorkCellForOILS
	To test sending of phone to Citi related to Home, Work, Cell number updates 	


Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |


Scenario: CITI_4328
Citi Home Work Cell changed to Wrong Number and there is no other good phone in ARx (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |		
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Wrong Number
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479992222 |
		| MASOPF     | N          |
		| MASCPN     | 6479993333 |
		| MASCPI     | N          |
		| MASRPH     | 6479994444 |
		| MASRPF     | N          |

		
Scenario: CITI_4329
Citi Home Work Cell changed to Wrong Number, there are other good Home Work Cell in ARx but there is no RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Wrong Number
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479992222 |
		| MASOPF     | N          |
		| MASCPN     | 6479993333 |
		| MASCPI     | N          |
		| MASRPH     | 6479994444 |
		| MASRPF     | N          |


Scenario: CITI_4414
Citi Home Work Cell 4th changed to Wrong Number, there are other good Home Work Cell 4th in ARx and there is RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Wrong Number
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479997777 with Right Party Contact as true
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479998888 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |
		| MASOPH     | 6479996666 |
		| MASOPF     | Y          |
		| MASCPN     | 6479997777 |
		| MASCPI     | Y          |
		| MASRPH     | 6479998888 |
		| MASRPF     | Y          |


Scenario: CITI_4330
Citi Home Work Cell are same and changed to Wrong Number and there is no other good phone in ARx (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes the phone number 6479991111 to status Wrong Number
	And the user changes the phone number 6479993333 to status Wrong Number
	And the user changes the phone number 6479994444 to status Wrong Number
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479991111 |
		| MASOPF     | N          |
		| MASCPN     | 6479993333 |
		| MASCPI     | N          |
		| MASRPH     | 6479994444 |
		| MASRPF     | N          |


Scenario: CITI_4419
Citi Home Work are same and changed to Wrong Number and there are other good Home Work Cell 4th in ARx (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Wrong Number
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479997777 with Right Party Contact as true
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479998888 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |
		| MASOPH     | 6479996666 |
		| MASOPF     | Y          |
		| MASCPN     | 6479997777 |
		| MASCPI     | Y          |
		| MASRPH     | 6479998888 |
		| MASRPF     | Y          |


Scenario: CITI_4420
Citi Home Work Cell 4th changed to Not In Service and there is no other good phone in ARx (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Not In Service
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | D          |
		| MASOPH     | 6479992222 |
		| MASOPF     | D          |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |
		| MASRPH     | 6479994444 |
		| MASRPF     | D          |


Scenario: CITI_4421
Citi Home Work Cell 4th changed to Not In Service, there are other good Home Work Cell 4th in ARx but there is no RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Not In Service
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | D          |
		| MASOPH     | 6479992222 |
		| MASOPF     | D          |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |
		| MASRPH     | 6479994444 |
		| MASRPF     | D          |
		

Scenario: CITI_4422
Citi Home Work Cell 4th changed to Not In Service, there are other good Home Work Cell 4th in ARx and there is RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Not In Service
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479997777 with Right Party Contact as true
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479998888 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |
		| MASOPH     | 6479996666 |
		| MASOPF     | Y          |
		| MASCPN     | 6479997777 |
		| MASCPI     | Y          |
		| MASRPH     | 6479998888 |
		| MASRPF     | Y          |


Scenario: CITI_4423
Citi Home Work Cell 4th changed to Verbal DNC and there is no other good phone in ARx (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Verbal Do Not Call
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | X          |
		| MASOPH     | 6479992222 |
		| MASOPF     | X          |
		| MASCPN     | 6479993333 |
		| MASCPI     | X          |
		| MASRPH     | 6479994444 |
		| MASRPF     | X          |


Scenario: CITI_4424
Citi Home Work Cell 4th changed to Verbal DNC, there are other good Home Work Cell 4th in ARx but there is no RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Verbal Do Not Call
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | X          |
		| MASOPH     | 6479992222 |
		| MASOPF     | X          |
		| MASCPN     | 6479993333 |
		| MASCPI     | X          |
		| MASRPH     | 6479994444 |
		| MASRPF     | X          |


Scenario: CITI_4425
Citi Home Work Cell 4th changed to Verbal DNC, there are other good Home Work Cell 4th in ARx and there is RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Verbal Do Not Call
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479997777 with Right Party Contact as true
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479998888 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |
		| MASOPH     | 6479996666 |
		| MASOPF     | Y          |
		| MASCPN     | 6479997777 |
		| MASCPI     | Y          |
		| MASRPH     | 6479998888 |
		| MASRPF     | Y          |


Scenario: CITI_4426
Citi Home Work Cell 4th changed to Written DNC and there is no other good phone in ARx (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Written Do Not call
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | C          |
		| MASOPH     | 6479992222 |
		| MASOPF     | C          |
		| MASCPN     | 6479993333 |
		| MASCPI     | C          |
		| MASRPH     | 6479994444 |
		| MASRPF     | C          |


Scenario: CITI_4427
Citi Home Work Cell 4th changed to Written DNC, there are other good Home Work Cell 4th in ARx but there is no RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Written Do Not Call
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | C          |
		| MASOPH     | 6479992222 |
		| MASOPF     | C          |
		| MASCPN     | 6479993333 |
		| MASCPI     | C          |
		| MASRPH     | 6479994444 |
		| MASRPF     | C          |


Scenario: CITI_4428
Citi Home Work Cell 4th changed to Written DNC, there are other good Home Work Cell 4th in ARx and there is RPC for those phones (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes all the phones number of the account to status Written Do Not Call
	And the user adds a new number 6479995555 with status Active location Home service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Active location Work service Landline
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	And the user adds a new number 6479997777 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479997777 with Right Party Contact as true
	And the user adds a new number 6479998888 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479998888 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479995555 |
		| MASHPF     | Y          |
		| MASOPH     | 6479996666 |
		| MASOPF     | Y          |
		| MASCPN     | 6479997777 |
		| MASCPI     | Y          |
		| MASRPH     | 6479998888 |
		| MASRPF     | Y          |


Scenario: CITI_4429
Citi Home Work Cell 4th are Not In Service, changing those phones to Active (OILS)
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
	And the user changes the phone number 6479991111 to status Active
	And the user changes the phone number 6479992222 to status Active
	And the user changes the phone number 6479993333 to status Wireless
	And the user changes the phone number 6479994444 to status Wireless
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |
		| MASOPH     | 6479992222 |
		| MASOPF     | Y          |
		| MASCPN     | 6479993333 |
		| MASCPI     | Y          |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |


Scenario: CITI_4430
  Citi Home Work Cell 4th are Verbal DNC, changing those phones to Active (OILS)
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
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user changes the phone number 6479991111 to status Active
	And the user changes the phone number 6479992222 to status Active
	And the user changes the phone number 6479993333 to status Wireless
	And the user changes the phone number 6479994444 to status Active
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |
		| MASOPH     | 6479992222 |
		| MASOPF     | Y          |
		| MASCPN     | 6479993333 |
		| MASCPI     | Y          |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |


Scenario: CITI_4431
  Citi Home Work Cell 4th are Written DNC, changing those phones to Active (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | C             | 6479992222 | C             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | C          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | C          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user changes the phone number 6479991111 to status Active
	And the user changes the phone number 6479992222 to status Active
	And the user changes the phone number 6479993333 to status Wireless
	And the user changes the phone number 6479994444 to status Active
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |
		| MASOPH     | 6479992222 |
		| MASOPF     | Y          |
		| MASCPN     | 6479993333 |
		| MASCPI     | Y          |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |


Scenario: CITI_4418
Citi Home Work Cell are different and good and load Written DNC 4th phone in MT that applies to all phone status (OILS)
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
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | X          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
		| 6479994444  | V           | 3           | Unknown      | Unknown     |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | X          |
		| MASOPH     | 6479992222 |
		| MASOPF     | X          |
		| MASCPN     | 6479993333 |
		| MASCPI     | X          |


Scenario: CITI_4134
Citi Home Work are different and good then Work is changed to Cell by MT file then add a new Work (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479992222 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
	When the user adds a new number 6479993333 with status Active location Work service Landline
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |		
		| MASOPH     | 6479993333 |
		| MASOPF     | Y          |
		#| MASCPN     | 6479992222 |
		#| MASCPI     | Y          |


Scenario: CITI_4506
Citi Home Work Cell is same and bad then user adds new Home Work Cell with bad status then user changes all phones to good (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | N             | 6479991111 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | N          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done	
	And the user adds a new number 6479992222 with status Active location Home service Landline
	And the user adds a new number 6479993333 with status Active location Work service Landline
	And the user adds a new number 6479994444 with status Wireless location Home service Mobile
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
		And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |	
		| MASHPH     | 6479992222 |
		| MASHPF     | Y          |
		| MASOPH     | 6479993333 |
		| MASOPF     | Y          |
		| MASCPN     | 6479994444 |
		| MASCPI     | Y          |
		| MASRPH     | 6479991111 |
		| MASRPF     | Y          |
		