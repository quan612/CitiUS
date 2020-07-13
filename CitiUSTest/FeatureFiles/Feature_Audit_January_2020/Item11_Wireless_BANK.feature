@OutboundMaintenance @Item11 @BANK
Feature: Item11_Wireless_BANK
	http://devtracker.globalcollection.net/f/cases/29037/Feature-Int-11-Citi-Audit_-Wireless-phone-numbers-should-not-be-sent-as-home-phone-number-to-Citi

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |

Scenario: CITI_4474
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Wireless, Service = Landline, Location = Home and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Wireless location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |

Scenario: CITI_4475
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Active, Service = Mobile, Location = Home and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Mobile
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |

Scenario: CITI_4476
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Wireless, Service = Mobile, Location = Home and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Wireless location Home service Mobile
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |

Scenario: CITI_4477
Verify outbound MT when Citi Home Work Cell is bad, and a new phone is set up in ARxCollect with Status = Active, Service = Mobile, Location = Home and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Mobile
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479994444 |
		| MASCPI     | D          |

Scenario: CITI_4478
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Wireless, Service = Landline, Location = Work and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Wireless location Work service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |

Scenario: CITI_4479
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Active, Service = Mobile, Location = Work and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Work service Mobile
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |

Scenario: CITI_4480
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Wireless, Service = Mobile, Location = Work and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Wireless location Work service Mobile
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |

Scenario: CITI_4481
Verify outbound MT when Citi Home Work Cell is bad, and a new phone is set up in ARxCollect with Status = Active, Service = Mobile, Location = Work and there is RPC
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Work service Mobile
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479994444 |
		| MASCPI     | D          |

Scenario: CITI_4482
Verify outbound MT when Citi Home Work is good and no Cell, in ARxCollect the user changes the Home to have Wireless status
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479991111 |
		| MASCPI     | D          |

Scenario: CITI_4483
Verify outbound MT when Citi Home Work is good and no Cell, in ARxCollect the user changes the Home to have Mobile service
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to service Mobile
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479991111 |
		| MASCPI     | D          |

Scenario: CITI_4484
Verify outbound MT when Citi Home Work is good and no Cell, in ARxCollect the user changes the Work to have Wireless status
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479992222 to status Wireless
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479992222 |
		| MASCPI     | D          |

Scenario: CITI_4485
Verify outbound MT when Citi Home Work is good and no Cell, in ARxCollect the user changes the Work to have Mobile service
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479992222 to service Mobile
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479992222 |
		| MASCPI     | D          |

Scenario: CITI_4486
Verify outbound MT when Citi Home Work is bad and Cell is good, and a new phone is set up in ARxCollect with Status = Wireless, Service = Landline, Location = Home and there is RPC and change current Cell to bad
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Wireless location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479993333 to status Verbal Do Not Call
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479994444 |
		| MASCPI     | D          |

Scenario: CITI_4487
Verify outbound MT when Citi Home Work Cell is good, add another Home, and change current Home service to Mobile
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479991111 to service Mobile
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |

Scenario: CITI_4488
Verify outbound MT when Citi Home Work Cell is good, add another Home, and change current Home status to Wireless
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |

Scenario: CITI_4489
Verify outbound MT when Citi Home Work Cell is good, add another Work, and change current Work service to Mobile
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Work service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479992222 to service Mobile
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASOPH     | 6479994444 |
		| MASOPF     |            |

Scenario: CITI_4490
Verify outbound MT when Citi Home Work Cell is good, add another Work, and change current Work status to Wireless
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |

Scenario: CITI_4491
Citi Home Work is good, user changes Home to service Mobile then 1 day later add a new Cell then 1 day after change current Home to Wrong Number
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to service Mobile
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASCPN     | 6479991111 |
		| MASCPI     | D          |
	When the user adds a new number 6479993333 with status Wireless location Home service Landline
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
	When the user changes the phone number 6479991111 to status Wrong Number
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | B          |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |

Scenario: CITI_4492
Verify outbound MT when Citi Work is good Cell is bad and no Home, in ARxCollect the user changes the Cell to have status Active and Service Landline
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479993333 to status Active
	And the user changes the phone number 6479993333 to service Landline
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479993333 |
		| MASHPF     |            |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |

Scenario: CITI_4493
Verify outbound MT when Citi Home is good Cell is bad and no Work, in ARxCollect the user changes the Cell to have status Active service Landline location Work
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             |            |               |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479993333 to status Active
	And the user changes the phone number 6479993333 to service Landline
	And the user changes the phone number 6479993333 to location Work
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASOPH     | 6479993333 |
		| MASOPF     |            |
		| MASCPN     | 6479993333 |
		| MASCPI     | D          |

Scenario: CITI_4502
Citi Home Cell is good, change current Home to Wireless and then add another good Home to the account
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             |            |               |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to status Wireless
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
	When the user adds a new number 6479994444 with status Active location Home service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479994444 |
		| MASHPF     |            |

Scenario: CITI_4503
Citi Work Cell is good, change current Work to Wireless and then add another good Work to the account
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479992222 to status Wireless
	And the user creates a call record for phone number 6479992222 with Right Party Contact as true
	And the user creates a call record for phone number 6479993333 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
	When the user adds a new number 6479994444 with status Active location Work service Landline
	And the user creates a call record for phone number 6479994444 with Right Party Contact as true
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASOPH     | 6479994444 |
		| MASOPF     |            |