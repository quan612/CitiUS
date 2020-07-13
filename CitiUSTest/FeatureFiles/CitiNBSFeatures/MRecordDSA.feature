@Placement @M_Record @DSA @epic:85568
Feature: M_Record DSA
	To test the loading of supplementary information for Citi US account when receiving M record in NBS file.

Background:
Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |

Scenario: CITI_4685
Verify the saving DSA fields to InternalExtras when we receive a value that is not blank
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

Scenario: CITI_4686
Verify the saving DSA fields to InternalExtras when we receive a value that is blank
	Given The user modifies the M record in DL file with credentials:
		| Field       | Value |
		| DsaName     |       |
		| DsaAddress1 |       |
		| DsaAddress2 |       |
		| DsaCity     |       |
		| DsaState    |       |
		| DsaZip      |       |
		| DsaPhone    |       |
		| DsaEmail    |       |
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

Scenario: CITI_4687
Verify the saving DSA fields to InternalExtras when we receive a value with maximum char length
	Given The user modifies the M record in DL file with credentials:
		| Field       | Value                                            |
		| DsaName     | Test Long Name value that is > 40 chars abcde    |
		| DsaAddress1 | Test Long Address value that is > 40 chars abcde |
		| DsaAddress2 | Test Long Address value that is > 40 chars abcde |
		| DsaCity     | Test Long city value > 20 chars                  |
		| DsaState    | ONTARIO                                          |
		| DsaZip      | M1M2M3M4M5M6M7                                   |
		| DsaPhone    | 647999123456789123                               |
		| DsaEmail    | abc@gmail.com                                    | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value                                    |
		| Text6  | Test Long Name value that is > 40 chars  |
		| Text7  | Test Long Address value that is > 40 cha |
		| Text8  | Test Long Address value that is > 40 cha |
		| Text9  | Test Long city value                     |
		| Text10 | ON                                       |
		| Text11 | M1M2M3M4M5                               |
		| Text15 | 6479991234567891                         |
		| Text12 | abc@gmail.com                            | 
