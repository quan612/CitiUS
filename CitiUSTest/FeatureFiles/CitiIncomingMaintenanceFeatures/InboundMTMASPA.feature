Feature: InbountMTMASPA
	For updating account charge off information

IBM Signed Numeric Table
{ = 0     } = -0
A = 1     J = -1
B = 2     K = -2
C = 3     L = -3
D = 4     M = -4
E = 5     N = -5
F = 6     O = -6
G = 7     P = -7
H = 8     Q = -8
I = 9     R = -9

Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| OILS    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4364
Verify the processing of MASPA1
	Given The user modifies the X00 record in DL file with credentials:
		|ChargeOffAmount | 
		|55A			 |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffAmount is 5.51
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		|Transaction DateTime | Transaction Code| Field Code|New Value |
		|Today's date		  | MT              | MASPA1    |9993C	   |	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished	
	Then The account information: ChargeOffAmount is 999.33


Scenario: CITI_4365
Verify the processing of MASPA2
	Given The user modifies the X00 record in DL file with credentials:
		| Field             | Value  |
		| ChargeOffInterest | 99999H |	
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffInterest is 9999.98
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		|Transaction DateTime | Transaction Code| Field Code|New Value |
		|Today's date		  | MT              | MASPA2    |0{	       |	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished	
	Then The account information: ChargeOffInterest is 0.00


Scenario: CITI_4366
Verify the processing of MASPA3
	Given The user modifies the X00 record in DL file with credentials:
	| Field         | Value   |
	| ChargeOffFees | 123456G | 		
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffFees is 12345.67
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		|Transaction DateTime | Transaction Code| Field Code|New Value |
		|Today's date		  | MT              | MASPA3    |123456I   |	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished	
	Then The account information: ChargeOffFees is 12345.69	


Scenario: CITI_4367
Verify the processing of MASPA4
	Given The user modifies the X00 record in DL file with credentials:
	| Field           | Value   |
	| ChargeOffCredit | 123456{ |	
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
		Then The account extras information: Curr10 is 12345.60
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		|Transaction DateTime | Transaction Code| Field Code|New Value |
		|Today's date		  | MT              | MASPA4    |130A   |	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished	
	Then The account extras information: Curr10 is 13.01


Scenario: CITI_4368
Verify the processing of MASPA5
	Given The user modifies the X00 record in DL file with credentials:
	| Field             | Value   |
	| ChargeOffPayments | 012342B |  		
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffPayments is 1234.22
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		|Transaction DateTime | Transaction Code| Field Code|New Value |
		|Today's date		  | MT              | MASPA5    |012342E   |	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished	
	Then The account information: ChargeOffPayments is 1234.25


Scenario: CITI_4369
Verify the processing of MASPA6
	Given The user modifies the X00 record in DL file with credentials:
	| Field     | Value |
	| OtherDebt | 5466C | 
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account extras information: Curr11 is 546.63
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		|Transaction DateTime | Transaction Code| Field Code|New Value |
		|Today's date		  | MT              | MASPA6    |9999I     |	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished	
	Then The account extras information: Curr11 is 999.99