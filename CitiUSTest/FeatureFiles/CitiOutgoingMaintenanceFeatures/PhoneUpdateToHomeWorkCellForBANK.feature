@OutboundMaintenance @HomeWorkCell @BANK @epic:84633
Feature: Phone Update To Home, Work, Cell for BANK
	To test sending of phone to Citi related to Home, Work, Cell number updates 	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_4080
Citi Home Work Cell changed to Wrong Number and there is no other good phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | J             | 6479992222 | J             | 
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Wrong Number
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
		| MASOPH     | 6479992222 |
		| MASOPF     | B          |
		| MASCPN     | 6479993333 |
		| MASCPI     | B          |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | I              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | B             | I              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | B             | I              | Home                 | Mobile              |


Scenario: CITI_4081
Citi Home Work Cell changed to Wrong Number, there are other good Home Work Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Wrong Number
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user adds a new number 6479995555 with status Active location Work service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4082
Citi Home Work Cell are same and changed to Wrong Number and there is no other good phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479991111 | A             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
		| MASOPH     | 6479991111 |
		| MASOPF     | B          |
		| MASCPN     | 6479991111 |
		| MASCPI     | B          |


Scenario: CITI_4083
Citi Home Work Cell are same and changed to Wrong Number, there are other good Home Work Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479991111 | A             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user adds a new number 6479995555 with status Active location Work service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4084
Citi Home Work Cell changed to Not In Service and there is no other good phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Not In Service
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479992222 |
		| MASOPF     | N          |
		| MASCPN     | 6479993333 |
		| MASCPI     | N          |


Scenario: CITI_4085
Citi Home Work Cell changed to Not In Service and there are other good Home Work Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Not In Service
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user adds a new number 6479995555 with status Active location Work service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4088
Citi Home Work Cell changed to Verbal DNC and there is no other good phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Verbal Do Not Call
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | V          |
		| MASOPH     | 6479992222 |
		| MASOPF     | V          |
		| MASCPN     | 6479993333 |
		| MASCPI     | V          |


Scenario: CITI_4089
Citi Home Work Cell changed to Verbal DNC and there are other good Home Work Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Verbal Do Not Call
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user adds a new number 6479995555 with status Active location Work service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4090
Citi Home Work Cell are same and changed to Verbal DNC and there is no other good phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Verbal Do Not Call
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | V          |
		| MASOPH     | 6479991111 |
		| MASOPF     | V          |
		| MASCPN     | 6479991111 |
		| MASCPI     | V          |


Scenario: CITI_4092
Citi Home Work Cell changed to Written DNC and there is no other good phone in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Written Do Not Call
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | W          |
		| MASOPH     | 6479992222 |
		| MASOPF     | W          |
		| MASCPN     | 6479993333 |
		| MASCPI     | W          |


Scenario: CITI_4093
Citi Home Work Cell changed to Written DNC and there are other good Home Work Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Written Do Not Call
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user adds a new number 6479995555 with status Active location Work service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user adds a new number 6479996666 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4096
Citi Home Work Cell are Wrong Number, there are other Wrong Number phones in ARx, change other phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Wrong Number
	And the user adds a new number 6479994444 with status Wrong Number location Home service Landline
	And the user adds a new number 6479995555 with status Wrong Number location Work service Landline
	And the user adds a new number 6479996666 with status Wrong Number location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	And the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4097
Citi Home Work Cell are Wrong Number, there are other Wrong Number phones in ARx, change all phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Wrong Number
	And the user adds a new number 6479994444 with status Wrong Number location Home service Landline
	And the user adds a new number 6479995555 with status Wrong Number location Work service Landline
	And the user adds a new number 6479996666 with status Wrong Number location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	And the user changes the phone number 6479991111 to status Active
	And the user changes the phone number 6479992222 to status Active
	And the user changes the phone number 6479993333 to status Active
	And the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4098
Citi Home Work Cell are same and Wrong Number, there are other Wrong Number phones in ARx, change other phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed	
	When A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	And the user adds a new number 6479994444 with status Wrong Number location Home service Landline
	And the user adds a new number 6479995555 with status Wrong Number location Work service Landline
	And the user adds a new number 6479996666 with status Wrong Number location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	And the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4099
Citi Home Work Cell are same and Wrong Number, there are other Wrong Number phones in ARx, change all phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | H             | 6479991111 | A             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	And the user adds a new number 6479994444 with status Wrong Number location Home service Landline
	And the user adds a new number 6479995555 with status Wrong Number location Work service Landline
	And the user adds a new number 6479996666 with status Wrong Number location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	And the user changes the phone number 6479991111 to status Active
	And the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4100
Citi Home Work Cell are Not In Service, there are other Not In Servce phones in ARx, change other phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Not In Service
	And the user adds a new number 6479994444 with status Not In Service location Home service Landline
	And the user adds a new number 6479995555 with status Not In Service location Work service Landline
	And the user adds a new number 6479996666 with status Not In Service location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479992222 |
		| MASOPF     | N          |
		| MASCPN     | 6479993333 |
		| MASCPI     | N          |
	When the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4101
Citi Home Work Cell are Not In Service, there are other Not In Service phones in ARx, change all phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Not In Service
	And the user adds a new number 6479994444 with status Not In Service location Home service Landline
	And the user adds a new number 6479995555 with status Not In Service location Work service Landline
	And the user adds a new number 6479996666 with status Not In Service location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479992222 |
		| MASOPF     | N          |
		| MASCPN     | 6479993333 |
		| MASCPI     | N          |
	When the user changes the phone number 6479991111 to status Active
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user changes the phone number 6479992222 to status Active
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Active
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user changes the phone number 6479994444 to status Active
	And the user changes the phone number 6479995555 to status Active
	And the user changes the phone number 6479996666 to status Active
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     |            |
		| MASOPH     | 6479992222 |
		| MASOPF     |            |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |


#Scenario: CITI_4102
#Scenario: CITI_4103
Scenario: CITI_4104
Citi Home Work Cell are Verbal DNC, there are other Verbal DNC phones in ARx, change other phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Verbal Do Not Call
	And the user adds a new number 6479994444 with status Verbal Do Not Call location Home service Landline
	And the user adds a new number 6479995555 with status Verbal Do Not Call location Work service Landline
	And the user adds a new number 6479996666 with status Verbal Do Not Call location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | V          |
		| MASOPH     | 6479992222 |
		| MASOPF     | V          |
		| MASCPN     | 6479993333 |
		| MASCPI     | V          |
	When the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4105
Citi Home Work Cell are Verbal DNC, there are other Verbal DNC phones in ARx, change all phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Verbal Do Not Call
	And the user adds a new number 6479994444 with status Verbal Do Not Call location Home service Landline
	And the user adds a new number 6479995555 with status Verbal Do Not Call location Work service Landline
	And the user adds a new number 6479996666 with status Verbal Do Not Call location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | V          |
		| MASOPH     | 6479992222 |
		| MASOPF     | V          |
		| MASCPN     | 6479993333 |
		| MASCPI     | V          |
	When the user changes the phone number 6479991111 to status Active
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user changes the phone number 6479992222 to status Active
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Active
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user changes the phone number 6479994444 to status Active
	And the user changes the phone number 6479995555 to status Active
	And the user changes the phone number 6479996666 to status Active
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     |            |
		| MASOPH     | 6479992222 |
		| MASOPF     |            |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |


#Scenario: CITI_4106
#Scenario: CITI_4107
Scenario: CITI_4108
Citi Home Work Cell are Written DNC, there are other Written DNC phones in ARx, change other phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Written Do Not Call
	And the user adds a new number 6479994444 with status Written Do Not Call location Home service Landline
	And the user adds a new number 6479995555 with status Written Do Not Call location Work service Landline
	And the user adds a new number 6479996666 with status Written Do Not Call location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | W          |
		| MASOPH     | 6479992222 |
		| MASOPF     | W          |
		| MASCPN     | 6479993333 |
		| MASCPI     | W          |
	When the user changes the phone number 6479994444 to status Active
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479995555 to status Active
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	And the user changes the phone number 6479996666 to status Active
	And the user creates a call record for phone number 6479996666 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479995555 |
		| MASOPF     |            |
		| MASCPN     | 6479996666 |
		| MASCPI     | D          |


Scenario: CITI_4109
Citi Home Work Cell are Written DNC, there are other Written DNC phones in ARx, change all phones in ARx to Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Written Do Not Call
	And the user adds a new number 6479994444 with status Written Do Not Call location Home service Landline
	And the user adds a new number 6479995555 with status Written Do Not Call location Work service Landline
	And the user adds a new number 6479996666 with status Written Do Not Call location Home service Mobile
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | W          |
		| MASOPH     | 6479992222 |
		| MASOPF     | W          |
		| MASCPN     | 6479993333 |
		| MASCPI     | W          |
	When the user changes the phone number 6479991111 to status Active
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user changes the phone number 6479992222 to status Active
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Active
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And the user changes the phone number 6479994444 to status Active
	And the user changes the phone number 6479995555 to status Active
	And the user changes the phone number 6479996666 to status Active
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     |            |
		| MASOPH     | 6479992222 |
		| MASOPF     |            |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |

##########################################################################
#Scenario: CITI_4110

#Scenario: CITI_4111


# bad to bad
Scenario: CITI_4112
Citi Home Work Cell changed to Written DNC and there is no other good phone in ARx, then changing those Home Work Cell to Wrong Number
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes all the phones number of the account to status Written Do Not Call
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | W          |
		| MASOPH     | 6479992222 |
		| MASOPF     | W          |
		| MASCPN     | 6479993333 |
		| MASCPI     | W          |
	When the user changes the phone number 6479991111 to status Wrong Number
	And the user changes the phone number 6479992222 to status Wrong Number
	And the user changes the phone number 6479993333 to status Wrong Number
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
		| MASOPH     | 6479992222 |
		| MASOPF     | B          |
		| MASCPN     | 6479993333 |
		| MASCPI     | B          |

		
# same phone B
Scenario: CITI_4336
Citi Home Work Cell are same and changed to Wrong Number, there is another good Home in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479991111 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |
		| MASOPH     | 6479991111 |
		| MASOPF     | B          |
		| MASCPN     | 6479991111 |
		| MASCPI     | B          |


# same phone D	Bad to Good
Scenario: CITI_4355
Citi Home Work Cell are same and changed to Wrong Number and then changed to Good
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wrong Number
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
		| MASOPH     | 6479991111 |
		| MASOPF     | B          |
		| MASCPN     | 6479991111 |
		| MASCPI     | B          |
	When the user changes the phone number 6479991111 to status Wireless
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     |            |
		| MASOPH     | 6479991111 |
		| MASOPF     |            |
		| MASCPN     | 6479991111 |
		| MASCPI     | D          |
