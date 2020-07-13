Feature: AddressNoEcho
	To test specific scenarios related to audit on 21 January 2020

Background:

#Given The user creates a Citi NBS based on the sample file
#And The user modifies the header record with credentials:
#	| MIOCode | ListDate   |
#	| OILS    | 2020/01/18 |
#And The user modifies the recoverer in DL file with credentials:
#	| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
#	| CONS         | 0800        | OILS    | GIC5          |
Scenario: CITI_9999
Verify there is no echo back when the primary address is changed by processing an incoming MT file for foreign address update
	#Given The user modifies the account record in DL file with credentials:
	#	| Address1     | Address2          | City    | State | ZipCode |
	#	| 199 North Rd | Toronto ON M1M1M1 | Markham | FC    | M2M2M2  |
	#When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account primary address is:
		| Addr1Line1   | Addr1Line2        | Addr1Prov | Addr1City | Addr1Postal | Addr1Country |
		| 199 North Rd | Toronto ON M1M1M1 | FC        | Markham   | M2M2M2      |              |
	#When The user creates a Citi Inbound Maintenance File using account from previous steps:
	#	| Transaction DateTime | Transaction Code | Field Code | New Value          |
	#	| Today's date         | MT               | MASAD1     | 9999 road apt 1234 |
	#	| Today's date         | MT               | MASAD2     | Canada AB A1A2A3   |
	#	| Today's date         | MT               | MASCTY     |                    |
	#	| Today's date         | MT               | MASSTC     | FC                 |
	#	| Today's date         | MT               | MASZIP     | Z1Z2Z3             |
	#When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	#Then The account primary address is:
	#	| Addr1Line1         | Addr2Line2 | Addr1Prov | Addr1City | Addr1Postal | Addr1Country |
	#	| 9999 road apt 1234 |            | FC        | Canada    | Z1Z2Z3      |              |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |