@Placement @Phones @BANK @epic:84633
Feature: NbsPhonesForBank
	To test the loading of phone for new account loaded into the system for Citi BANK accounts	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_852
Verify the phone status where MIO = Bank and all phone Indicators = B
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |		
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | B             | V              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | B             | V              | Mobile              | Home                 |


Scenario: CITI_853
Verify the phone status where MIO = Bank and all phone Indicators = N
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | N             | 6479992222 | N             |
	Given The user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | N             | N              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | N             | N              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | N             | N              | Mobile              | Home                 |


Scenario: CITI_854
Verify the phone status where MIO = Bank and all phone Indicators = D
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | D             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | D             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | D             | W              | Mobile              | Home                 |


Scenario: CITI_855
Verify the phone status where MIO = Bank and all phone Indicators = J
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | J             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | J             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | J             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | J             | W              | Mobile              | Home                 |


Scenario: CITI_856
Verify the phone status where MIO = Bank and all phone Indicators = A
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Mobile              | Home                 |


Scenario: CITI_857
Verify the phone status where MIO = Bank and all phone Indicators = H
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | H             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | H             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Home         | Landline    | Denied          |
		| 6479992222  | A           | 2           | Work         | Landline    | Denied          |
		| 6479993333  | W           | 18          | Home         | Mobile      | Denied          | 
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType | 
		| 6479991111  | MASHPH               | MASHPF             | H             | A              | Landline            | Home                 | 
		| 6479992222  | MASOPH               | MASOPF             | H             | A              | Landline            | Work                 | 
		| 6479993333  | MASCPN               | MASCPI             | H             | W              | Mobile              | Home                 | 


Scenario: CITI_858
Verify the phone status where MIO = Bank and all phone Indicators = X
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | X             | 6479992222 | X             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | X             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The action code 234 is applied to the account
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | X             | V              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | X             | V              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | X             | V              | Mobile              | Home                 |


Scenario: CITI_859
Verify the phone status where MIO = Bank and all phone Indicators = U
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | U             | 6479992222 | U             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | U             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Home         | Landline    | Denied          |
		| 6479992222  | A           | 2           | Work         | Landline    | Denied          |
		| 6479993333  | W           | 18          | Home         | Mobile      | Denied          | 
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | U             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | U             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | U             | W              | Mobile              | Home                 |


Scenario: CITI_860
Verify the phone status where MIO = Bank and all phone Indicators = R
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | R             | 6479992222 | R             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | R             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | R             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | R             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | R             | W              | Mobile              | Home                 |


Scenario: CITI_861
Verify the phone status where MIO = Bank and only Home Indicator = W
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | W             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | W             | X              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Mobile              | Home                 |
	And The action code 234 is applied to the account


Scenario: CITI_862
Verify the phone status where MIO = Bank and only Work Indicator = W
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | A             | 6479992222 | W             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | W             | X              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Mobile              | Home                 |
	And The action code 234 is applied to the account


Scenario: CITI_863
Verify the phone status where MIO = Bank and only Cell Indicator = W
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | W             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | W             | X              | Mobile              | Home                 |
	And The action code 234 is applied to the account


Scenario: CITI_864
Verify the phone status where MIO = Bank and only Home Indicator = V
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | V             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | V             | V              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Mobile              | Home                 |
	And The action code 234 is applied to the account


Scenario: CITI_865
Verify the phone status where MIO = Bank and only Work Indicator = V
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | V             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | V             | V              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Mobile              | Home                 |
	And The action code 234 is applied to the account


Scenario: CITI_866
Verify the phone status where MIO = Bank and only Cell Indicator = V
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | A             | 6479992222 | A             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | V             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneServiceType | ARxPhoneLocationType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Landline            | Home                 |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Landline            | Work                 |
		| 6479993333  | MASCPN               | MASCPI             | V             | V              | Mobile              | Home                 |
	And The action code 234 is applied to the account


Scenario: CITI_4275
Verify the phone status where MIO = Bank when all numbers are same and indicators are good and same
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | A             | 6479991111 | A             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | W           | 1           | Work         | Mobile    |	  
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | A             | W              | Work                 | Mobile              |


Scenario: CITI_4276
Verify the phone status where MIO = Bank when all numbers are same and indicators are good and different
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | J             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | W           | 1           | Work         | Mobile      | Denied          |  
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | H             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | J             | W              | Work                 | Mobile              |  


Scenario: CITI_4277
Verify the phone status where MIO = Bank when all numbers are same and indicators are bad and different
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | B             | 6479991111 | X             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | X             | V              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | A             | V              | Work                 | Mobile              |
	And The action code 234 is applied to the account


Scenario: CITI_4278
Verify the phone status where MIO = Bank when Home is all 9's and its indicator is good
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 9999999999 | A             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479992222 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 2           | Work         | Landline    |
		| 6479992222  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479992222  | MASCPN               | MASCPI             | A             | W              | Home                 | Mobile              |


Scenario: CITI_4279
Verify the phone status where MIO = Bank when Home is all 9's and its indicator is bad and apply to all status
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 9999999999 | W             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479992222  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | A             | W              | Home                 | Mobile              |
	And The action code 234 is NOT applied to the account


Scenario: CITI_4280
Verify the phone status where MIO = Bank and all phone have an unknown indicator
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | Q             | 6479992222 | T             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | I             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | Q             | A              | Home                 | Landline            |
		| 6479992222  | MASOPH               | MASOPF             | T             | A              | Work                 | Landline            |
		| 6479993333  | MASCPN               | MASCPI             | I             | W              | Home                 | Mobile              |


Scenario: CITI_4281
Verify the phone status where MIO = Bank when Home Work Cell are same and indicators are good and same
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | W           | 1           | Work         | Mobile    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | A             | A              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | A             | A              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | A             | W              | Work                 | Mobile              | 


Scenario: CITI_4282
Verify the phone status where MIO = Bank when Home Work Cell are same and indicators are bad and different
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479991111 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479991111 | A             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Work         | Mobile    |
	And The Citi Phone tracker table for the account is as below:
		| PhoneNumber | CitiPhoneNumberField | CitiIndicatorField | CitiIndicator | ARxPhoneStatus | ARxPhoneLocationType | ARxPhoneServiceType |
		| 6479991111  | MASHPH               | MASHPF             | B             | V              | Home                 | Landline            |
		| 6479991111  | MASOPH               | MASOPF             | A             | V              | Work                 | Landline            |
		| 6479991111  | MASCPN               | MASCPI             | A             | V              | Work                 | Mobile              | 
