@InboundMaintenance @Phones @4thPhone
Feature: 4thPhone
	To test the updating of phone for account when receiving the 4th phone number and indicator	

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| OILS    | Yesterday |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4391
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = N
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | N          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the client UNC path
	And The file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | V           | 3           | Unknown      | Unknown     |

Scenario: CITI_4392
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = D
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | D          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | N           | 3           | Unknown      | Unknown     |

Scenario: CITI_4393
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = E
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | A           | 3           | Unknown      | Landline    |

Scenario: CITI_4394
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = B
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | B          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | A           | 3           | Unknown      | Landline    |

Scenario: CITI_4395
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = V
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | V          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | A           | 3           | Unknown      | Landline    |

Scenario: CITI_4396
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = H
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | H          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Home         | Landline    | Unknown         |
		| 6479992222  | A           | 2           | Work         | Landline    | Unknown         |
		| 6479993333  | A           | 3           | Unknown      | Landline    | Denied          |

Scenario: CITI_4397
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = S
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | S          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | V           | 3           | Unknown      | Unknown     |
	Then The action code 234 is applied to the account

Scenario: CITI_4398
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = U
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | U          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Home         | Landline    | Unknown         |
		| 6479992222  | A           | 2           | Work         | Landline    | Unknown         |
		| 6479993333  | A           | 3           | Unknown      | Landline    | Denied          |

Scenario: CITI_4399
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = Y
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | Y          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | A           | 3           | Unknown      | Landline    |

Scenario: CITI_4400
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = C
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | C          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 3           | Unknown      | Unknown     |
	Then The action code 234 is applied to the account

Scenario: CITI_4401
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = X
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | X          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 3           | Unknown      | Unknown     |
	Then The action code 234 is applied to the account

Scenario: CITI_4402
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = E, device type = M
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | M          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | W           | 3           | Unknown      | Mobile      |

Scenario: CITI_4403
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = E, device type = U
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | U          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | A           | 3           | Unknown      | Unknown     |

Scenario: CITI_4404
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = E, device type = I
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | I          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | I           | 3           | Unknown      | Unknown     |

Scenario: CITI_4405
Home Work are good from new business file, then receiving Citi MT with 4th number with indicator = Unknown Indicator
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPF     | Z          |
		| Today's date         | MT               | MASRPT     | L          |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Home         | Landline    |
		| 6479992222  | A           | 2           | Work         | Landline    |
		| 6479993333  | A           | 3           | Unknown      | Landline    |

Scenario: CITI_4406
Home Work are good from new business file, then receiving Citi MT with 4th number with missing indicator update
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASRPH     | 6479993333 |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the client UNC path
	Then An exception error is thrown as General Error exception

Scenario: CITI_4407
Home Work are good from new business file, then receiving Citi MT with 4th number with missing phone number update
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account has 2 records
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASRPF     | Z         |
		| Today's date         | MT               | MASRPT     | L         |
	And The user drops the file to the client UNC path
	Then An exception error is thrown as General Error exception