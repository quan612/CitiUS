@InboundMaintenance @Phones @BANK @epic:84633
Feature: InboundMTPhonesForBANK
	To test the updating of phone for account through Maintenance file for Citi BANK accounts	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_4283
No phone in ARx, receiving Citi MT with all bad phone indicators (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               |            |               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 0 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | B          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | B          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | B          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	Then The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | B             | V              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | B             | V              | Home                 | Mobile              |


Scenario: CITI_4284
No phone in ARx, receiving Citi MT with all good phone indicators (BANK)
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
		| Today's date         | MT               | MASOPF     | D          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | N             | N              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | D             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4285
No phone in ARx, receiving Citi MT with bad Home Written indicator applies to all phones (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|            |               |            |               | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 0 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | W          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | A          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | A          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | W             | X              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Home                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4286
No phone in ARx, receiving Citi MT with bad Work Verbal indicator applies to all phones (BANK)
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
		| Today's date         | MT               | MASOPF     | V          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | A          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | V             | V              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Home                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4287
Home Work Cell are good from DL, receiving Citi MT with Home Verbal DNC (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 3 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | B          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | N          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | N             | N              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4288
Home Work Cell are good from DL, receiving Citi MT with Work Verbal DNC (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | A             | 6479992222 | A             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 3 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | X          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | N             | N              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | X             | V              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4289
Home Work Cell are good from DL, receiving Citi MT with Cell Written DNC applies to all phone statuses (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | E             |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 3 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | D          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | W          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | N             | N              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | D             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | W             | X              | Home                 | Mobile              |


Scenario: CITI_4290
Home Work Cell are same and good from DL, receiving Citi MT with Home Verbal DNC (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | A             |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | B          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Work                 | Mobile              |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | A             | W              | Work                 | Mobile              |


Scenario: CITI_4291
Home Work Cell are same and good from DL, receiving Citi MT with Work Verbal DNC (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASOPH     | 6479991111 |
		| Today's date         | MT               | MASOPF     | X          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | X             | V              | Work                 | Mobile              |
		| 6479991111  | MASCPN               | MASCPI             | A             | W              | Work                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4292
Home Work Cell are same and good from DL, receiving Citi MT with Cell Written DNC applies to all phone statuses (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | W          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Work         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | W             | X              | Work                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4293
Home Work Cell are same and good from DL, ARx has extra phones, receiving Citi MT with Cell Written DNC applies to all phones (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Landline
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | W          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Work         | Mobile      |
		| 6479994444  | X           | 3           | Home         | Landline    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | W             | X              | Work                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4294
Home Work Cell are bad from DL, receiving Citi MT with good for those Home Work Cell (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | A          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | D          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | D             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4295
Home Work Cell are same and bad from DL, receiving Citi MT with good indicator for those Home Work Cell (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | B             | 6479991111 | B             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | B             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 1 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | A          |
		| Today's date         | MT               | MASOPH     | 6479991111 |
		| Today's date         | MT               | MASOPF     | D          |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | D             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4296
Home Work Cell are bad from DL file then receiving a Citi MT file with new good Home Work Cell (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479994444 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479995555 |
		| Today's date         | MT               | MASOPF     | D          |
		| Today's date         | MT               | MASCPN     | 6479996666 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
		| 6479994444  | N           | 3           | Home         | Landline    |
		| 6479995555  | A           | 4           | Work         | Landline    |
		| 6479996666  | W           | 19          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479994444  | MASHPH               | MASHPF             | N             | N              | Home                 | Landline            |
		| 6479995555  | MASOPH               | MASOPF             | D             | A              | Work                 | Landline            |
		| 6479996666  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4297
Verify the processing of Citi Maintenance when missing the indicator update (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |	
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
	And The user drops the file to the client UNC path
	Then An exception error is thrown as General Error exception


Scenario: CITI_4298
Verify the processing of Citi Maintenance when missing the phone number update (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | CellNumber | CellIndicator |
		| 6479991111 | B             | 6479992222 | B             | 6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASHPF     | N         |
	And The user drops the file to the client UNC path
	Then An exception error is thrown as General Error exception


Scenario: CITI_4299
Verify the processing of Citi Maintenance when the phone indicator is not in the mapping (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | Z          |
	And The user drops the file to the client UNC path
	Then An exception error is thrown as General Error exception


Scenario: CITI_4300
Home Work are good from DL then receiving a Citi MT with good Cell number that is same with current Home (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | J          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | W           | 1           | Home         | Mobile      |
		| 6479992222  | A           | 2           | Work         | Landline    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4301
Home Work are good from DL then receiving a Citi MT with a different good Cell number (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | CellNumber | CellIndicator |
		| 6479991111 | A             | 6479992222 | A             |            |               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_4302
Home Work Cell are good from DL then receiving a Citi MT with new different good Home Work Cell (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479994444 |
		| Today's date         | MT               | MASHPF     | J          |
		| Today's date         | MT               | MASOPH     | 6479995555 |
		| Today's date         | MT               | MASOPF     | J          |
		| Today's date         | MT               | MASCPN     | 6479996666 |
		| Today's date         | MT               | MASCPI     | J          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
		| 6479994444  | A           | 3           | Home         | Landline    |
		| 6479995555  | A           | 4           | Work         | Landline    |
		| 6479996666  | W           | 19          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479994444  | MASHPH               | MASHPF             | J             | A              | Home                 | Landline            |
		| 6479995555  | MASOPH               | MASOPF             | J             | A              | Work                 | Landline            |
		| 6479996666  | MASCPN               | MASCPI             | J             | W              | Home                 | Mobile              |


Scenario: CITI_3915
Receiving Citi MT for phone update when InternalExternal = O and Recoverer = AGENCY and there is no outgoing history
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  | Flag | RecovererId |
		| Today's date         | MT               | MASHPH     | 6479991111 | O    | Agency      |
		| Today's date         | MT               | MASHPF     | B          | O    | Agency      |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |


Scenario: CITI_4304
Receiving Citi MT for phone update when InternalExternal = O and Recoverer = AGENCY where there was outgoing history and they are same
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When the user changes the phone number 6479991111 to status Verbal Do Not Call
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  | Flag | RecovererId |
		| Today's date         | MT               | MASHPH     | 6479991111 | O    | Agency      |
		| Today's date         | MT               | MASHPF     | X          | O    | Agency      |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | X             | V              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |


Scenario: CITI_4443
Home Work Cell is good then loads an incoming MT file with Not In Service Home Work Cell
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
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
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18          | Home         | Mobile      |