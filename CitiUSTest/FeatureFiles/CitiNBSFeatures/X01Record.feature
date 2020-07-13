@Placement @X01_Record @epic:85568
Feature: X01 Record
	Related to X01 record

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

Scenario: CITI_4698
Verify the saving of bucket and rollbck fields when we receive non-blank values in X01 Record
	Given The user modifies the X01 record in DL file with credentials:
		| Field          | Value |
		| MsaDelqBucket1 | 11A   |
		| MsaDelqBucket2 | 22B   |
		| MsaDelqBucket3 | 33C   |
		| MsaDelqBucket4 | 66F   |
		| MsaDelqBucket5 | 55E   |
		| MsaDelqBucket6 | 44D   |
		| MsaRollBck1    | 111A  |
		| MsaRollBck2    | 222B  |
		| MsaRollBck3    | 333C  |
		| MsaRollBck4    | 666F  |
		| MsaRollBck5    | 555E  |
		| MsaRollBck6    | 444D  | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   | 1.11  |
		| Number5   | 2.22  |
		| Number6   | 3.33  |
		| Number7   | 6.66  |
		| Number8   | 5.55  |
		| Number9   | 4.44  |
		| Currency1 | 6.66  |
		| Number10  | 11.11 |
		| Number11  | 22.22 |
		| Number12  | 33.33 |
		| Number13  | 66.66 |
		| Number14  | 55.55 |
		| Number15  | 44.44 | 

Scenario: CITI_4699
Verify the saving of bucket and rollbck fields when we receive blank values in X01 Record
	Given The user modifies the X01 record in DL file with credentials:
		| Field          | Value |
		| MsaDelqBucket1 |       |
		| MsaDelqBucket2 |       |
		| MsaDelqBucket3 |       |
		| MsaDelqBucket4 |       |
		| MsaDelqBucket5 |       |
		| MsaDelqBucket6 |       |
		| MsaRollBck1    |       |
		| MsaRollBck2    |       |
		| MsaRollBck3    |       |
		| MsaRollBck4    |       |
		| MsaRollBck5    |       |
		| MsaRollBck6    |       | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   |       |
		| Number5   |       |
		| Number6   |       |
		| Number7   |       |
		| Number8   |       |
		| Number9   |       |
		| Currency1 |       |
		| Number10  |       |
		| Number11  |       |
		| Number12  |       |
		| Number13  |       |
		| Number14  |       |
		| Number15  |       | 

