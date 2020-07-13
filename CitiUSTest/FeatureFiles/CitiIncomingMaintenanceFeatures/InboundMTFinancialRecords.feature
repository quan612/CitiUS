Feature: InboundMTFinancialRecords
	To test the loading of inbound MT with financial code.	

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

#------------------------------------------------------------------------------------------------
Scenario: CITI-1035
	Verify the processing of MT file when the transaction sign is negative
		
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
				|Current Balance | Net Principle | 
				|000054753{      | 00054753{     |

		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect

		Then The account balance information: Principal Balance is $5475.30
		
		When The user creates a Citi Inbound Financial File using account from previous steps:
			|Transaction DateTime | Transaction Code| Transaction Amount| 
			|2019/09/29			  | 51              | 000004750{       | 		
			 
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished

		Then The account balance information: Current Balance is $5000.30


#------------------------------------------------------------------------------------------------
Scenario: CITI-1036
	Verify the processing of MT file when there is a reverse transaction but no matching direct payment is found.
		
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
				|Current Balance | Net Principle |
				|000004567H      | 00004567H     | 

		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect

		Then The account balance information: Principal Balance is $456.78
		
		When The user creates a Citi Inbound Financial File using account from previous steps:
			|Transaction DateTime | Transaction Code| Transaction Amount| 
			|2019/09/29			  | 60              | 000000960{       |			 
			And The user drops the file to the client UNC path
			
		Then An error happens when processing the row. No matching reversal


#------------------------------------------------------------------------------------------------
Scenario: CITI-1037
	Verify the processing of MT file when there is a reverse transaction and a matching direct payment is found
		
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
			|Current Balance | Net Principle |
			|000024567H      | 00024567H     | 
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		Then The account balance information: Principal Balance is $2456.78		
		When A user manually posts a direct payment transaction of $199.99 on 10/7/2019
		Then The account balance information: Current Balance is $2256.79
		When The user creates a Citi Inbound Financial File using account from previous steps:
			|Transaction DateTime | Transaction Code| Transaction Amount| 
			|2019/10/7			  | 60              | 000001999I       |			 
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then A reversal transaction is posted to the account
			And The account balance information: Current Balance is $2456.78


#------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1038
	Verify the processing of financial maintenance file when the transaction type is direct payment.
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
			|Current Balance | Net Principle |
			|000055558C      | 00012345F     |
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		Then The account balance information: Principal Balance is $5555.83		
		When The user creates a Citi Inbound Financial File with <Transaction DateTime>, <Transaction Code>, <Transaction Amount>			 
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then The account balance information: Current Balance is $5080.83
			And A direct payment is posted to the account with an amount of $475.00 on 2019/09/29
		Examples:
		|Transaction DateTime | Transaction Code| Transaction Amount| 
		|2019/09/29			  | 51              | 000004750{       | 
		|2019/09/29			  | 54              | 000004750{       | 		


#------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1039
Verify the processing of financial maintenance file when the transaction type is balance adjustment.
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the account record in DL file with credentials:
		| Current Balance | Net Principle |
		| 000012345F      | 00012345F     |
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	Then The account balance information: Principal Balance is $1234.56		
	When The user creates a Citi Inbound Financial File with <Transaction DateTime>, <Transaction Code>, <Transaction Amount>			 
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished
	Then The account balance information: Current Balance is $<Current Balance>
		And A balance adjustment is posted to the account with an amount of $<Total Paid> on <Transaction DateTime>
	Examples:
		| Transaction DateTime | Transaction Code | Transaction Amount | Total Paid | Current Balance |
		| 2019/08/15           | 11               | 000005231B         | -523.12    | 1757.68         | 
		| 2019/06/01           | 12               | 000005231K         | 523.12     | 711.44          |
		| 2019/07/31           | 13               | 000010009R         | 1000.99    | 233.57          |
		| 2019/09/22           | 14               | 000000230{         | -23.00     | 1257.56         |
		| 2019/10/10           | 15               | 000012345O         | 1234.56    | 0.00            |


#------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1041
	Verify the processing of financial maintenance file when the transaction type is Loss Interest Pre Charge Off

		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
			|Current Balance | Net Principle |
			|000012345F      | 00012345F     | 

		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect

		Then The account balance information: Principal Balance is $1234.56
		
		When The user creates a Citi Inbound Financial File with <Transaction DateTime>, <Transaction Code>, <Transaction Amount>			 
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished

		Then The account balance information: Current Balance is $<Current Balance>
			And A balance adjustment is posted to the account with an amount of $-523.12 on 2019/08/15

		Examples:
		| Transaction DateTime | Transaction Code | Transaction Amount | Total Paid | Current Balance |
		| 2019/08/15           | 19               | 000005231B         | -523.12    | 1757.68          |
		

#------------------------------------------------------------------------------------------------
Scenario Outline: CITI-974
	Verify that if MT transaction date = account list date, then any transaction within MT file should not be posted (for BANK)

		Given The user creates a Citi NBS based on the sample file
			And The user modifies the header record with credentials:
				| List Date  |
				| Yesterday  |
			And The user modifies the account record in DL file with credentials:
				|Current Balance | Net Principle |
				|000012345F      | 00012345F     |

		When The user drops the file to the client UNC path
			And The file is processed
			When A new account is placed in ARxCollect

		Then The account balance information: Principal Balance is $1234.56
		
		When The user creates a Citi Inbound Financial File with <Transaction DateTime>, <Transaction Code>, <Transaction Amount>			 
			And The user drops the file to the client UNC path
			
		Then A general error status happens when processing the row record
			And No transaction is posted for the account

		Examples:
		| Transaction DateTime | Transaction Code | Transaction Amount | 
		| Yesterday            | 19               | 000005231K         | 
		