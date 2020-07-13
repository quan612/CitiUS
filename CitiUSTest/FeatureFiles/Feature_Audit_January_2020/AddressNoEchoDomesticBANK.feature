Feature: AddressNoEchoDomesticBANK
	To test specific scenarios related to audit on 21 January 2020

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_4509
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that has MASAD2 does not match Addr1Line2 (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value         |
		| Today's date         | MT               | MASAD1     | 11743 CULVER BLVD |
		| Today's date         | MT               | MASAD2     | APT 345           |
		| Today's date         | MT               | MASCTY     | LOS ANGELES       |
		| Today's date         | MT               | MASSTC     | CA                |
		| Today's date         | MT               | MASZIP     | 900667412         |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 345    | LOS ANGELES | CA        | 900667412   |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4510
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that has MASAD1 does not match Addr1Line1 (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value   |
		| Today's date         | MT               | MASAD1     | abced 343   |
		| Today's date         | MT               | MASAD2     | APT 3       |
		| Today's date         | MT               | MASCTY     | LOS ANGELES |
		| Today's date         | MT               | MASSTC     | CA          |
		| Today's date         | MT               | MASZIP     | 900667412   |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| abced 343  | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4511
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that only has MASAD1 (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value   |
		| Today's date         | MT               | MASAD1     | abced 343   |
		| Today's date         | MT               | MASCTY     | LOS ANGELES |
		| Today's date         | MT               | MASSTC     | CA          |
		| Today's date         | MT               | MASZIP     | 900667412   | 
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| abced 343  |            | LOS ANGELES | CA        | 900667412   |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4512
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that only has MASAD2 (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value        |
		| Today's date         | MT               | MASAD2     | line 2 only here |
		| Today's date         | MT               | MASCTY     | LOS ANGELES      |
		| Today's date         | MT               | MASSTC     | CA               |
		| Today's date         | MT               | MASZIP     | 900667412        |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1       | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| line 2 only here |            | LOS ANGELES | CA        | 900667412   |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4513
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that only has MASAD2 and it is blank (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value   |
		| Today's date         | MT               | MASAD2     |             |
		| Today's date         | MT               | MASCTY     | LOS ANGELES |
		| Today's date         | MT               | MASSTC     | CA          |
		| Today's date         | MT               | MASZIP     | 900667412   |  
	When The user drops the file to the client UNC path
	Then A general error status happens when processing the row record
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4540
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that has MASCTY does not match Addr1City (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value         |
		| Today's date         | MT               | MASAD1     | 11743 CULVER BLVD |
		| Today's date         | MT               | MASAD2     | APT 3             |
		| Today's date         | MT               | MASCTY     | NEW YORK          |
		| Today's date         | MT               | MASSTC     | CA                |
		| Today's date         | MT               | MASZIP     | 900667412         |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | NEW YORK  | CA        | 900667412   |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4541
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that has MASSTC does not match Addr1Prov (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value         |
		| Today's date         | MT               | MASAD1     | 11743 CULVER BLVD |
		| Today's date         | MT               | MASAD2     | APT 3             |
		| Today's date         | MT               | MASCTY     | NEW YORK          |
		| Today's date         | MT               | MASSTC     | NY                |
		| Today's date         | MT               | MASZIP     | 900667412         |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | NEW YORK  | NY        | 900667412   |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4542
Verify there is no echo back when the primary address is changed by processing MT file for domestic address update that has MASZIP does not match Addr1Postal (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value         |
		| Today's date         | MT               | MASAD1     | 11743 CULVER BLVD |
		| Today's date         | MT               | MASAD2     | APT 3             |
		| Today's date         | MT               | MASCTY     | NEW YORK          |
		| Today's date         | MT               | MASSTC     | NY                |
		| Today's date         | MT               | MASZIP     | 10001             |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | NEW YORK  | NY        | 10001       |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


Scenario: CITI_4546
Verify the domestic address update is sent to Citi if the changes are made from user (BANK)
	Given The user modifies the account record in DL file with credentials:
		| Address1          | Address2 | City        | State | ZipCode   |
		| 11743 CULVER BLVD | APT 3    | LOS ANGELES | CA    | 900667412 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | LOS ANGELES | CA        | 900667412   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value         |
		| Today's date         | MT               | MASAD1     | 11743 CULVER BLVD |
		| Today's date         | MT               | MASAD2     | APT 3             |
		| Today's date         | MT               | MASCTY     | NEW YORK          |
		| Today's date         | MT               | MASSTC     | NY                |
		| Today's date         | MT               | MASZIP     | 10001             |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1        | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| 11743 CULVER BLVD | APT 3      | NEW YORK  | NY        | 10001       |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |
	When the user changes the account primary address as below:
		| Line1         | Line2    | City     | Prov | Postal    |
		| 9999 RIVER ST | APT 9090 | MINESOTA | WA   | 102030405 |
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value              |
		| MASAD1     | 9999 RIVER ST APT 9090 |
		| MASAD2     |                        |
		| MASCTY     | MINESOTA               |
		| MASSTC     | WA                     |
		| MASZIP     | 102030405              |  
