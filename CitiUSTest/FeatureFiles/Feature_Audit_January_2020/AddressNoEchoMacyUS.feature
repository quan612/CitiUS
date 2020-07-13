Feature: AddressNoEchoMacyUS
	To test specific scenarios related to audit on 21 January 2020

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| DSNB    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| AMEX         | 7800        | DSNB    | SCA3          |

#the address is switched before saving in placement file
Scenario: CITI_4515
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASAD1 does not match Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1111 RIVERSHOW BLVD |
		| Today's date         | MT               | MASAD2     | APT 14              |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1111 RIVERSHOW BLVD | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file
Scenario: CITI_4516
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASAD2 does not match Addr1Line1
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | APT 999999999       |
		| Today's date         | MT               | MASAD2     | 1416 S GLENDALE AVE |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1          | Addr1Line2    | Addr1City | Addr1Prov | Addr1Postal |
		| 1416 S GLENDALE AVE | APT 999999999 | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file
Scenario: CITI_4517
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASAD2 does not match Addr1Line1 and MASAD1 does not match Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1111 RIVERSHOW BLVD |
		| Today's date         | MT               | MASAD2     | APT 999999999       |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1          | Addr1Line2    | Addr1City | Addr1Prov | Addr1Postal |
		| 1111 RIVERSHOW BLVD | APT 999999999 | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file
Scenario: CITI_4518
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASAD2 matches Addr1Line1 and MASAD1 matches Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1416 S GLENDALE AVE |
		| Today's date         | MT               | MASAD2     | APT 14              |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file, addressline 2 will be cleared in this scenario
Scenario: CITI_4524
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has only MASAD1 field code and it matches Addr1Line1
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASAD1     | APT 14     |
		| Today's date         | MT               | MASCTY     | GLENDALE   |
		| Today's date         | MT               | MASSTC     | CA         |
		| Today's date         | MT               | MASZIP     | 91205-3343 |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     |            | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file, addressline 2 will be cleared, addressline1 is updated
Scenario: CITI_4525
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has only MASAD1 field code and it does not match Addr1Line1
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 9999 RIVERSHOW BLVD |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1          | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| 9999 RIVERSHOW BLVD |            | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


#the address is switched before saving in placement file, addressline 2 will be cleared, addressline1 is updated
Scenario: CITI_4526
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has only MASAD2 field code and it does not match Addr1Line1
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD2     | 9999 RIVERSHOW BLVD |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1          | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| 9999 RIVERSHOW BLVD |            | GLENDALE  | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |


#the address is switched before saving in placement file, exception error if only MASAD2 and it is empty
Scenario: CITI_4527
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has only MASAD2 field code and it is blank
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASAD2     |            |
		| Today's date         | MT               | MASCTY     | GLENDALE   |
		| Today's date         | MT               | MASSTC     | CA         |
		| Today's date         | MT               | MASZIP     | 91205-3343 |
	When The user drops the file to the client UNC path
	Then A general error status happens when processing the row record
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file, city is updated
Scenario: CITI_4528
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASCTY does not match Addr1City
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1416 S GLENDALE AVE |
		| Today's date         | MT               | MASAD2     | APT 14              |
		| Today's date         | MT               | MASCTY     | Markham             |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | Markham   | CA        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file, province is updated
Scenario: CITI_4529
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASSTC does not match Addr1Prov
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1416 S GLENDALE AVE |
		| Today's date         | MT               | MASAD2     | APT 14              |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | FL                  |
		| Today's date         | MT               | MASZIP     | 91205-3343          |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | FL        | 912053343   |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#the address is switched before saving in placement file, zip is updated
Scenario: CITI_4530
Verify there is no echo back when the primary address is changed by processing MT file for Macy US that has MASZIP does not match Addr1Postal
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1416 S GLENDALE AVE |
		| Today's date         | MT               | MASAD2     | APT 14              |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | CA                  |
		| Today's date         | MT               | MASZIP     | 12345               |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 12345       |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

###################
Scenario: CITI_4548
Verify the Macy US address update is sent to Citi if the changes are made from user
	Given The user modifies the account record in DL file with credentials:
		| Address1            | Address2 | City     | State | ZipCode   |
		| 1416 S GLENDALE AVE | APT 14   | GLENDALE | CA    | 912053343 |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | CA        | 912053343   |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | 1416 S GLENDALE AVE |
		| Today's date         | MT               | MASAD2     | APT 14              |
		| Today's date         | MT               | MASCTY     | GLENDALE            |
		| Today's date         | MT               | MASSTC     | NY                  |
		| Today's date         | MT               | MASZIP     | 12345               |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| APT 14     | 1416 S GLENDALE AVE | GLENDALE  | NY        | 12345       |
	When The user applies an action code 662
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |
	When the user changes the account primary address as below:
		| Line1  | Line2            | City     | Prov | Postal |
		| UNIT 9 | 1991 THAT STREET | MINESOTA | MN   | 55001  |
	And The user generates an outbound maintenance file for DSNB_POST_VISA
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value               |
		| MASAD1     | UNIT 9 1991 THAT STREET |
		| MASAD2     |                         |
		| MASCTY     | MINESOTA                |
		| MASSTC     | MN                      |
		| MASZIP     | 55001                   |
