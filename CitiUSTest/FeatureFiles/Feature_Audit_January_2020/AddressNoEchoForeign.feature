Feature: AddressNoEchoForeign
	To test specific scenarios related to audit on 21 January 2020

Background:
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |
	#And The user modifies the header record with credentials:
	#	| MIOCode | ListDate |
	#	| DSNB    | 2019/08/15|
	#And The user modifies the recoverer in DL file with credentials:
	#	| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
	#	| AMEX         | 7800        | DSNB    | SCA3          |



Scenario: CITI_4469
Verify there is no echo back when the primary address is changed by processing MT file for Foreign Address that has MASAD1 does not match Addr1Line1
	Given The user modifies the account record in DL file with credentials:
		| Address1      | Address2          | City   | State | ZipCode |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA | FC    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
		And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1    | Addr1Line2        | Addr1City | Addr1Prov | Addr1Postal |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA    | FC        | 00000       | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value             |
		| Today's date         | MT               | MASAD1     | FLAT 4 140 MOUNT WISE |
		| Today's date         | MT               | MASAD2     | TORONTO ON M4E2P1     |
		| Today's date         | MT               | MASCTY     | CANADA                |
		| Today's date         | MT               | MASSTC     | FC                    |
		| Today's date         | MT               | MASZIP     | 00000                 |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1            | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| FLAT 4 140 MOUNT WISE |            | CANADA    | FC        | 00000       |
	When The user applies an action code 662
		And The user generates an outbound maintenance file for OILS_ALL
		And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


#address line 2 will always be cleared, to empty? there is no update
Scenario: CITI_4531
Verify there is no echo back when the primary address is changed by processing MT file for Foreign Address that has MASAD2 does not match Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1      | Address2          | City   | State | ZipCode |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA | FC    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
		And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1    | Addr1Line2        | Addr1City | Addr1Prov | Addr1Postal |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA    | FC        | 00000       | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value                   |
		| Today's date         | MT               | MASAD1     | FLAT 4 140 MOUNT WISE       |
		| Today's date         | MT               | MASAD2     | UNITED KINGDON FC 000000000 |
		| Today's date         | MT               | MASCTY     | CANADA                      |
		| Today's date         | MT               | MASSTC     | FC                          |
		| Today's date         | MT               | MASZIP     | 00000                       | 
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1            | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| FLAT 4 140 MOUNT WISE |            | CANADA    | FC        | 00000       |
	When The user applies an action code 662
		And The user generates an outbound maintenance file for OILS_ALL
		And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


#address line 2 will always be cleared, to empty? there is no update
Scenario: CITI_4532
Verify there is no echo back when the primary address is changed by processing MT file for Foreign Address that has MASCTY does not match Addr1City
	Given The user modifies the account record in DL file with credentials:
		| Address1      | Address2          | City   | State | ZipCode |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA | FC    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
		And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1    | Addr1Line2        | Addr1City | Addr1Prov | Addr1Postal |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA    | FC        | 00000       | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value                   |
		| Today's date         | MT               | MASAD1     | FLAT 4 140 MOUNT WISE       |
		| Today's date         | MT               | MASAD2     | UNITED KINGDON FC 000000000 |
		| Today's date         | MT               | MASCTY     | IRAN                        |
		| Today's date         | MT               | MASSTC     | FC                          |
		| Today's date         | MT               | MASZIP     | 00000                       | 
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1            | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| FLAT 4 140 MOUNT WISE |            | IRAN      | FC        | 00000       |
	When The user applies an action code 662
		And The user generates an outbound maintenance file for OILS_ALL
		And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


#address line 2 will always be cleared, to empty? there is no update
Scenario: CITI_4533
Verify there is no echo back when the primary address is changed by processing MT file for Foreign Address that has MASZIP does not match Addr1Postal
	Given The user modifies the account record in DL file with credentials:
		| Address1      | Address2          | City   | State | ZipCode |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA | FC    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
		And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1    | Addr1Line2        | Addr1City | Addr1Prov | Addr1Postal |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA    | FC        | 00000       | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value                   |
		| Today's date         | MT               | MASAD1     | FLAT 4 140 MOUNT WISE       |
		| Today's date         | MT               | MASAD2     | UNITED KINGDON FC 000000000 |
		| Today's date         | MT               | MASCTY     | UNITED KINGDOM              |
		| Today's date         | MT               | MASSTC     | FC                          |
		| Today's date         | MT               | MASZIP     | 72046                       |  
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1            | Addr1Line2 | Addr1City      | Addr1Prov | Addr1Postal |
		| FLAT 4 140 MOUNT WISE |            | UNITED KINGDOM | FC        | 72046       |
	When The user applies an action code 662
		And The user generates an outbound maintenance file for OILS_ALL
		And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


###################
Scenario: CITI_4549
Verify the Foreign address update is sent to Citi if the changes are made from user
	Given The user modifies the account record in DL file with credentials:
		| Address1      | Address2          | City   | State | ZipCode |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA | FC    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
		And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1    | Addr1Line2        | Addr1City | Addr1Prov | Addr1Postal |
		| 69 LEE AVENUE | TORONTO ON M4E2P1 | CANADA    | FC        | 00000       | 
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value                   |
		| Today's date         | MT               | MASAD1     | FLAT 4 140 MOUNT WISE       |
		| Today's date         | MT               | MASAD2     | UNITED KINGDON FC 000000000 |
		| Today's date         | MT               | MASCTY     | UNITED KINGDOM              |
		| Today's date         | MT               | MASSTC     | FC                          |
		| Today's date         | MT               | MASZIP     | 72046                       |  
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1            | Addr1Line2 | Addr1City      | Addr1Prov | Addr1Postal |
		| FLAT 4 140 MOUNT WISE |            | UNITED KINGDOM | FC        | 72046       |
	When The user applies an action code 662
		And The user generates an outbound maintenance file for OILS_ALL
		And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |
	When the user changes the account primary address as below:
		| Line1                    | Line2 | City    | Prov | Postal |
		| APT 122 3 thang 2 street |       | VIETNAM | FC   | 50505  |
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value                |
		| MASAD1     | APT 122 3 thang 2 street |
		| MASAD2     | VIETNAM FC 50505         |
		| MASCTY     |                          |
		| MASSTC     | FC                       |
		| MASZIP     | 00000                    |


