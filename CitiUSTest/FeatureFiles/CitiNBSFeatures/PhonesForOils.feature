@Placement @Phones @OILS @epic:84633
Feature: NbsPhonesForOils
	To test the loading of phone for new account loaded into the system for Citi OILS accounts	

Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |  
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |


Scenario: CITI_882
Verify the phone status where MIO = OILS and all phone Indicators = N
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | N             | 6479992222 | N             | 
	Given The user modifies the X00 record in DL file with credentials:
		#| Field         | Value      |
		#| CellIndicator | N          |
		#| CellNumber    | 6479993333 |
		|CellNumber | CellIndicator |
		|6479993333 | N             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect		
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |		
		| 6479993333  | V           | 18          | Home         | Mobile      |


Scenario: CITI_883
Verify the phone status where MIO = OILS and all phone Indicators = E
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | E             | 6479992222 | E             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |		
		| 6479993333  | W           | 18          | Home         | Mobile      |


Scenario: CITI_884
Verify the phone status where MIO = OILS and all phone Indicators = D
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | D             | 6479992222 | D             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |		
		| 6479993333  | N           | 18          | Home         | Mobile      |


Scenario: CITI_885
Verify the phone status where MIO = OILS and all phone Indicators = B
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | B             | 6479992222 | B             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |		
		| 6479993333  | W           | 18          | Home         | Mobile      |


Scenario: CITI_886
Verify the phone status where MIO = OILS and all phone Indicators = V
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | V             | 6479992222 | V             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | V             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |		
		| 6479993333  | W           | 18          | Home         | Mobile      |


Scenario: CITI_887
Verify the phone status where MIO = OILS and all phone Indicators = H
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | H             | 6479992222 | H             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | H             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Home         | Landline    | Denied          |
		| 6479992222  | A           | 2           | Work         | Landline    | Denied          |
		| 6479993333  | W           | 18          | Home         | Mobile      | Denied          |
	

Scenario: CITI_888
Verify the phone status where MIO = OILS and all phone Indicators = S
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | S             | 6479992222 | S             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | S             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account


Scenario: CITI_889
Verify the phone status where MIO = OILS and all phone Indicators = U
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | U             | 6479992222 | U             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | U             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Home         | Landline    | Denied          |
		| 6479992222  | A           | 2           | Work         | Landline    | Denied          |
		| 6479993333  | W           | 18          | Home         | Mobile      | Denied          |


Scenario: CITI_890
Verify the phone status where MIO = OILS and all phone Indicators = Y
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | Y             | 6479992222 | Y             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | Y             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 18          | Home         | Mobile      |


Scenario: CITI_891
Verify the phone status where MIO = OILS and Home Indicator = C
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | C             | 6479992222 | Y             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | Y             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account


Scenario: CITI_892
Verify the phone status where MIO = OILS and Work Indicator = C
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | Y             | 6479992222 | C             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | Y             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account


Scenario: CITI_893
Verify the phone status where MIO = OILS and Cell Indicator = C
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|6479991111 | Y             | 6479992222 | Y             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | C             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account


Scenario: CITI_894
Verify the phone status where MIO = OILS and Home Indicator = X
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | X             | 6479992222 | Y             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | Y             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account


Scenario: CITI_895
Verify the phone status where MIO = OILS and Work Indicator = X
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | Y             | 6479992222 | X             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | Y             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account


Scenario: CITI_896
Verify the phone status where MIO = OILS and Cell Indicator = X
	Given The user modifies the account record in DL file with credentials:
		|HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		|6479991111 | Y             | 6479992222 | Y             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		|CellNumber | CellIndicator |
		|6479993333 | X             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	Then The action code 234 is applied to the account
