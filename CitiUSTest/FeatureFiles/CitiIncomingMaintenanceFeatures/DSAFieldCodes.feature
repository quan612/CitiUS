@InboundMaintenance @DSA @epic:85568
Feature: Inbound MT with DSA field codes
	For updating account DSA

Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| OILS    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4688
Verify the processing of MAS field codes for DSA	
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value |
		| Text6  |       |
		| Text7  |       |
		| Text8  |       |
		| Text9  |       |
		| Text10 |       |
		| Text11 |       |
		| Text15 |       |
		| Text12 |       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value     |
		| Today's date         | MT               | MASDNM     | Test DSA Name |
		| Today's date         | MT               | MASDA1     | Address 1     |
		| Today's date         | MT               | MASDA2     | Address 2     |
		| Today's date         | MT               | MASDCT     | Toronto       |
		| Today's date         | MT               | MASDST     | AZ            |
		| Today's date         | MT               | MASDZP     | 12345-1234    |
		| Today's date         | MT               | MASDPH     | 4169991234    |
		| Today's date         | MT               | MASDEM     | abc@gmail.com |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field  | Value         |
		| Text6  | Test DSA Name |
		| Text7  | Address 1     |
		| Text8  | Address 2     |
		| Text9  | Toronto       |
		| Text10 | AZ            |
		| Text11 | 12345-1234    |
		| Text15 | 4169991234    |
		| Text12 | abc@gmail.com | 

Scenario: CITI_4689
Verify the values can be updated when we had some DSA values from placement and then having different values from MAS field codes in MT file
	Given The user modifies the M record in DL file with credentials:
		| Field       | Value         |
		| DsaName     | Test DSA Name |
		| DsaAddress1 | Address 1     |
		| DsaAddress2 | Address 2     |
		| DsaCity     | Toronto       |
		| DsaState    | AZ            |
		| DsaZip      | 12345-1234    |
		| DsaPhone    | 4169991234    |
		| DsaEmail    | abc@gmail.com |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value         |
		| Text6  | Test DSA Name |
		| Text7  | Address 1     |
		| Text8  | Address 2     |
		| Text9  | Toronto       |
		| Text10 | AZ            |
		| Text11 | 12345-1234    |
		| Text15 | 4169991234    |
		| Text12 | abc@gmail.com | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value          |
		| Today's date         | MT               | MASDNM     | Quan               |
		| Today's date         | MT               | MASDA1     | line 1 changed     |
		| Today's date         | MT               | MASDA2     | line 2 changed     |
		| Today's date         | MT               | MASDCT     | Vancouver          |
		| Today's date         | MT               | MASDST     | BC                 |
		| Today's date         | MT               | MASDZP     | M2M3M4             |
		| Today's date         | MT               | MASDPH     | 6479991111         |
		| Today's date         | MT               | MASDEM     | test1234@yahoo.com | 
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field  | Value              |
		| Text6  | Quan               |
		| Text7  | line 1 changed     |
		| Text8  | line 2 changed     |
		| Text9  | Vancouver          |
		| Text10 | BC                 |
		| Text11 | M2M3M4             |
		| Text15 | 6479991111         |
		| Text12 | test1234@yahoo.com |

Scenario: CITI_4690
Verify the processing of MAS field codes for DSA when the values are blank in MT file
	Given The user modifies the M record in DL file with credentials:
		| Field       | Value         |
		| DsaName     | Test DSA Name |
		| DsaAddress1 | Address 1     |
		| DsaAddress2 | Address 2     |
		| DsaCity     | Toronto       |
		| DsaState    | AZ            |
		| DsaZip      | 12345-1234    |
		| DsaPhone    | 4169991234    |
		| DsaEmail    | abc@gmail.com |  
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value         |
		| Text6  | Test DSA Name |
		| Text7  | Address 1     |
		| Text8  | Address 2     |
		| Text9  | Toronto       |
		| Text10 | AZ            |
		| Text11 | 12345-1234    |
		| Text15 | 4169991234    |
		| Text12 | abc@gmail.com | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASDNM     |           |
		| Today's date         | MT               | MASDA1     |           |
		| Today's date         | MT               | MASDA2     |           |
		| Today's date         | MT               | MASDCT     |           |
		| Today's date         | MT               | MASDST     |           |
		| Today's date         | MT               | MASDZP     |           |
		| Today's date         | MT               | MASDPH     |           |
		| Today's date         | MT               | MASDEM     |           |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field  | Value |
		| Text6  |       |
		| Text7  |       |
		| Text8  |       |
		| Text9  |       |
		| Text10 |       |
		| Text11 |       |
		| Text15 |       |
		| Text12 |       |
