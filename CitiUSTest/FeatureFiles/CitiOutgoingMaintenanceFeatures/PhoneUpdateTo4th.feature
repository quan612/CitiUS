@OutboundMaintenance @Phones @4thPhone
Feature: PhoneUpdateTo4th
	To test sending of 4th phonen number update to Citi

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |


Scenario: CITI_4415
Citi Home Work Cell is good and user adds a new good Home phone with RPC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |
		

Scenario: CITI_4416
Citi Home Work Cell is good and user adds a new good Work phone with RPC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user adds a new number 6479994444 with status Active location Work service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |

Scenario: CITI_4417
Citi Home Work Cell is good and user adds a new good Cell phone with RPC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user adds a new number 6479994444 with status Wireless location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |


Scenario: CITI_4432
Citi Home Work Cell Good, 4th is Wrong Number, change the 4th number to Good (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | I          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user changes the phone number 6479994444 to status Active
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | Y          |

Scenario: CITI_4436
Citi Home Work Cell Good, 4th is Wrong Number, add a new good number in ARx (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | I          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	And the user adds a new number 6479995555 with status Active location Work service Landline
	And the user creates a call record for phone number 6479995555 with Right Party Contact as true
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479995555 |
		| MASRPF     | Y          |

Scenario: CITI_4437
Citi Home Work Cell 4th is good, change 4th number to Wrong number (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes the phone number 6479994444 to status Wrong Number
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | N          |

Scenario: CITI_4438
Citi Home Work Cell 4th is good, change 4th number to Not In Service (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes the phone number 6479994444 to status Not In Service
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | D          |

Scenario: CITI_4439
Citi Home Work Cell 4th is good, change 4th number to Written DNC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes the phone number 6479994444 to status Written Do Not Call
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | C          |

Scenario: CITI_4440
Citi Home Work Cell 4th is good, change 4th number to Verbal DNC (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479992222 | E             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | E          |
		| Today's date         | MT               | MASRPH     | 6479994444 |
		| Today's date         | MT               | MASRPF     | E          |
		| Today's date         | MT               | MASRPT     | L          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes the phone number 6479994444 to status Verbal Do Not Call
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASRPH     | 6479994444 |
		| MASRPF     | X          |

@epic:84633
Scenario: CITI_4441
Citi Home Work Cell 4th are same and active, change the number to Wrong Number (OILS)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | E             | 6479991111 | E             |
	And The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | L               |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | E          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When the user changes the phone number 6479991111 to status Wrong Number
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | N          |
		| MASOPH     | 6479991111 |
		| MASOPF     | N          |
		| MASCPN     | 6479991111 |
		| MASCPI     | N          |
		| MASRPH     | 6479991111 |
		| MASRPF     | N          |
