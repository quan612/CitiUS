Feature: AddressNoEchoMacyCanada
	To test specific scenarios related to audit on 21 January 2020

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| DSNB    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| AMEX         | 7700        | DSNB    | 0521          |

###################
Scenario: CITI_4514
Verify there is no echo back when the primary address is changed by processing MT file for Macy Canada that has MASSTC does not match province part in Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | UNIT 8              |
		| Today's date         | MT               | MASAD2     | DARTMOUTH NS B1B2B3 |
		| Today's date         | MT               | MASCTY     | CANADA              |
		| Today's date         | MT               | MASSTC     | XK                  |
		| Today's date         | MT               | MASZIP     | 00000               |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8     |            | DARTMOUTH | QC        | B1B2B3      |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

###################
Scenario: CITI_4519
Verify there is no echo back when the primary address is changed by processing MT file for Macy Canada that has MASAD2 city part does not match city part in Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value             |
		| Today's date         | MT               | MASAD1     | UNIT 8                |
		| Today's date         | MT               | MASAD2     | MISSISSAUGA NS B1B2B3 |
		| Today's date         | MT               | MASCTY     | CANADA                |
		| Today's date         | MT               | MASSTC     | XN                    |
		| Today's date         | MT               | MASZIP     | 00000                 |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City   | Addr1Prov | Addr1Postal |
		| UNIT 8     |            | MISSISSAUGA | NS        | B1B2B3      |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

###################
Scenario: CITI_4520
Verify there is no echo back when the primary address is changed by processing MT file for Macy Canada that has MASAD2 province part does not match province part in Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | UNIT 8              |
		| Today's date         | MT               | MASAD2     | DARTMOUTH QC B1B2B3 |
		| Today's date         | MT               | MASCTY     | CANADA              |
		| Today's date         | MT               | MASSTC     | XN                  |
		| Today's date         | MT               | MASZIP     | 00000               |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8     |            | DARTMOUTH | QC        | B1B2B3      |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

###################
Scenario: CITI_4521
Verify there is no echo back when the primary address is changed by processing MT file for Macy Canada that has MASAD2 zip part does not match zip part in Addr1Line2
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | UNIT 8              |
		| Today's date         | MT               | MASAD2     | DARTMOUTH NS T1T2T3 |
		| Today's date         | MT               | MASCTY     | CANADA              |
		| Today's date         | MT               | MASSTC     | XN                  |
		| Today's date         | MT               | MASZIP     | 00000               |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8     |            | DARTMOUTH | NS        | T1T2T3      |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

###################
Scenario: CITI_4522
Verify there is no echo back when the primary address is changed by processing MT file for Macy Canada that has MASCTY does not match Addr1Country
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | UNIT 8              |
		| Today's date         | MT               | MASAD2     | DARTMOUTH NS B1B2B3 |
		| Today's date         | MT               | MASCTY     | Iran                |
		| Today's date         | MT               | MASSTC     | XN                  |
		| Today's date         | MT               | MASZIP     | 00000               |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal | Addr1Country |
		| UNIT 8     |            | DARTMOUTH | NS        | B1B2B3      | Iran         |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

#maszip does not affect, the postal part will change the addr1Postal
Scenario: CITI_4523
Verify there is no echo back when the primary address is changed by processing MT file for Macy Canada that has MASZIP does not match Addr1Postal
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | UNIT 8              |
		| Today's date         | MT               | MASAD2     | DARTMOUTH NS B1B2B3 |
		| Today's date         | MT               | MASCTY     | CANADA              |
		| Today's date         | MT               | MASSTC     | XN                  |
		| Today's date         | MT               | MASZIP     | 589230245           |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8     |            | DARTMOUTH | NS        | B1B2B3      |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |

###################
Scenario: CITI_4547
Verify the Macy Canada address update is sent to Citi if the changes are made from user
	Given The user modifies the account record in DL file with credentials:
		| Address1               | Address2            | City   | State | ZipCode |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA | XN    | 00000   |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The account address is as below:
		| Addr1Line1             | Addr1Line2          | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8 850 RADDALL AVE | DARTMOUTH NS B1B2B3 | CANADA    | NS        | 00000       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value           |
		| Today's date         | MT               | MASAD1     | UNIT 8              |
		| Today's date         | MT               | MASAD2     | DARTMOUTH NS B1B2B3 |
		| Today's date         | MT               | MASCTY     | CANADA              |
		| Today's date         | MT               | MASSTC     | XN                  |
		| Today's date         | MT               | MASZIP     | 589230245           |
	When The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The account address is as below:
		| Addr1Line1 | Addr1Line2 | Addr1City | Addr1Prov | Addr1Postal |
		| UNIT 8     |            | DARTMOUTH | NS        | B1B2B3      |
	When The user applies an action code 662
	When The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASAD1    |
		| MASAD2    |
		| MASCTY    |
		| MASSTC    |
		| MASZIP    |
	When the user changes the account primary address as below:
		| Line1  | Line2 | City    | Prov | Postal |
		| UNIT 9 |       | TORONTO | ON   | M1M1M1 |
	And The user generates an outbound maintenance file for DSNB_PRE_VISA
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value         |
		| MASAD1     | UNIT 9            |
		| MASAD2     | TORONTO ON M1M1M1 |
		| MASCTY     | Canada            |
		| MASSTC     | XO                |
		| MASZIP     | 00000             |
