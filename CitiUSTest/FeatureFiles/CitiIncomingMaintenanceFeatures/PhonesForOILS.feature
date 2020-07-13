@InboundMaintenance @Phones @OILS @epic:84633
Feature: InboundMTPhonesForOILS
	To test the updating of phone for account through Maintenance file for Citi OILS accounts	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| OILS    | Yesterday |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |


Scenario: CITI_4305
No phone in ARx, receiving Citi MT with all bad phone indicators (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               |            |               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 0 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | N          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | N          |
	And The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	Then The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | N             | V              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | N             | V              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | N             | V              | Home                 | Mobile              |


Scenario: CITI_4306
No phone in ARx, receiving Citi MT with all good phone indicators (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               |            |               |
	When The user drops the file to the UNC path, and the file is processed	
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 0 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | D          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | E          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | B          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | D             | N              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | E             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | B             | W              | Home                 | Mobile              |


Scenario: CITI_4307
No phone in ARx, receiving Citi MT with bad Home Written indicator applies to all phones (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               |            |               |
	When The user drops the file to the UNC path, and the file is processed	
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 0 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | C          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | Y          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | Y          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18           | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | C             | X              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | Y             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | Y             | W              | Home                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4308
No phone in ARx, receiving Citi MT with bad Work Verbal indicator applies to all phones (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|            |               |            |               | 
	When The user drops the file to the UNC path, and the file is processed	
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 0 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | A          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | X          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | A          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | X             | V              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Home                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4309
Home Work Cell are good from DL, receiving Citi MT with Home Verbal DNC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | E             |
	When The user drops the file to the UNC path, and the file is processed		
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 3 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | E          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | N             | V              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | E             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | E             | W              | Home                 | Mobile              |


Scenario: CITI_4310
Home Work Cell are good from DL, receiving Citi MT with Work Verbal DNC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | E             |
	When The user drops the file to the UNC path, and the file is processed		
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 3 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | V          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | S          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | U          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      | 
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | V             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | S             | V              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | U             | W              | Home                 | Mobile              |


Scenario: CITI_4311
Home Work Cell are good from DL, receiving Citi MT with Cell Written DNC applies to all phone statuses (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 3 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | H          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | U          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | C          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | H             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | U             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | C             | X              | Home                 | Mobile              |


Scenario: CITI_4312
Home Work Cell are same and good from DL, receiving Citi MT with Home Verbal DNC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | E             |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | N             | V              | Work                 | Mobile              |
		| 6479991111  | MASOPH               | MASOPF             | E             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | E             | W              | Work                 | Mobile              | 


Scenario: CITI_4313
Home Work Cell are same and good from DL, receiving Citi MT with Work Verbal DNC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | CellNumber | CellIndicator |
		| 6479991111 | E             | 6479991111 | E             |            |               |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | E             |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASOPH     | 6479991111 |
		| Today's date         | MT               | MASOPF     | S          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | E             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | S             | V              | Work                 | Mobile              |
		| 6479991111  | MASCPN               | MASCPI             | E             | W              | Work                 | Mobile              |
	And The action code 234 is applied to the account
	

Scenario: CITI_4314
Home Work Cell are same and good from DL, receiving Citi MT with Cell Written DNC applies to all phone statuses (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | E             |  
	When The user drops the file to the UNC path, and the file is processed	
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | C          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Work         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | E             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | E             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | C             | X              | Work                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4315
Home Work Cell are same and good from DL, ARx has extra phones, receiving Citi MT with Cell Written DNC applies to all phones (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
		Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | E             |  
	When The user drops the file to the UNC path, and the file is processed	
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Landline
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | C          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Work         | Mobile      |
		| 6479994444  | X           | 3           | Home         | Landline    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | E             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | E             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | C             | X              | Work                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4316
Home Work Cell are bad from DL, receiving Citi MT with good for those Home Work Cell (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | N             | 6479992222 | N             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | N             |  
	When The user drops the file to the UNC path, and the file is processed	
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | U          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | E          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | B          |
	And The user drops the file to the UNC path, and the file is processed	
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | U             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | E             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | B             | W              | Home                 | Mobile              |


Scenario: CITI_4444
Home Work is good then loads an incoming MT file with Not In Service Home Work Cell 4th phone (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator | FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479993333 | A             | 6479994444        | A                    | L               |
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
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | D          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18          | Home         | Mobile      |
		| 6479994444  | N           | 3           | Unknown      | Landline    |