Feature: X00 Record Charge Off
	Everything related to "X" record
		
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

Scenario: CITI_4356
Verify the saving of Charge Off Amount
	Given The user modifies the X00 record in DL file with credentials:
		| ChargeOffAmount |
		| 12345A   |  
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffAmount is 1234.51

Scenario: CITI_4357
Verify the saving of Charge Off Interest
	Given The user modifies the X00 record in DL file with credentials:
		|ChargeOffInterest | 
		|99999H			   |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffInterest is 9999.98

Scenario: CITI_4358
Verify the saving of Charge Off Fees
	Given The user modifies the X00 record in DL file with credentials:
		|ChargeOffFees | 
		|123456G	   |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffFees is 12345.67

Scenario: CITI_4359
Verify the saving of Charge Off Credit
	Given The user modifies the X00 record in DL file with credentials:
		|ChargeOffCredit | 
		|123456{		 |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account extras information: Curr10 is 12345.60

Scenario: CITI_4360
Verify the saving of payment charge off
	Given The user modifies the X00 record in DL file with credentials:
		|ChargeOffPayments | 
		|012342B		   |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffPayments is 1234.22

Scenario: CITI_4361
Verify the saving of other debt charge off
	Given The user modifies the X00 record in DL file with credentials:
		|OtherDebt | 
		|5466C     |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account extras information: Curr11 is 546.63

Scenario: CITI_4362
Verify the saving of all charge off info
	Given The user modifies the X00 record in DL file with credentials:
	| ChargeOffAmount | ChargeOffInterest | ChargeOffCredit | ChargeOffFees | ChargeOffPayments | OtherDebt    |
	| 91222212345A    | 91222212345A      | 91222212345A    | 91222212345A  | 91222212345A      | 91222212345A |  
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account information: ChargeOffAmount is 9122221234.51
	Then The account information: ChargeOffInterest is 9122221234.51
	Then The account information: ChargeOffFees is 9122221234.51
	Then The account extras information: Curr10 is 9122221234.51
	Then The account information: ChargeOffPayments is 9122221234.51
	Then The account extras information: Curr11 is 9122221234.51
