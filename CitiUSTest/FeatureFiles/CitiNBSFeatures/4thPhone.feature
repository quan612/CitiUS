@Placement @Phones @4thPhone 
Feature: Nbs4thPhone
	To test the loading of 4th phone for new account loaded into the system 

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/12/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4374
Verify the loading of 4th phone where the Indicator = N, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | N                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Unknown      | Landline    |

Scenario: CITI_4375
Verify the loading of 4th phone where the Indicator = D, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | D                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Unknown      | Landline    |

Scenario: CITI_4376
Verify the loading of 4th phone where the Indicator = E, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Unknown      | Landline    |

Scenario: CITI_4377
Verify the loading of 4th phone where the Indicator = B, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | B                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Unknown      | Landline    |

Scenario: CITI_4378
Verify the loading of 4th phone where the Indicator = V, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | V                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Unknown      | Landline    |

Scenario: CITI_4379
Verify the loading of 4th phone where the Indicator = H, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | H                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Unknown      | Landline    | Denied          |

Scenario: CITI_4380
Verify the loading of 4th phone where the Indicator = S, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | S                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Unknown      | Landline    |
	Then The action code 234 is applied to the account

Scenario: CITI_4381
Verify the loading of 4th phone where the Indicator = U, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | U                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType | ConsentToDialer |
		| 6479991111  | A           | 1           | Unknown      | Landline    | Denied          |

Scenario: CITI_4382
Verify the loading of 4th phone where the Indicator = Y, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | Y                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Unknown      | Landline    |

Scenario: CITI_4383
Verify the loading of 4th phone where the Indicator = C, device type = L and the account has other phones with good indicators
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479993333        | C                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 3           | Unknown      | Landline    |
	Then The action code 234 is applied to the account

Scenario: CITI_4384
Verify the loading of 4th phone where the Indicator = E, device type = M
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | M               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | W           | 1           | Unknown      | Mobile      |

Scenario: CITI_4385
Verify the loading of 4th phone where the Indicator = E, device type = U
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | U               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Unknown      | Unknown     |

Scenario: CITI_4386
Verify the loading of 4th phone where the Indicator = E, device type = I
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | I               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | I           | 1           | Unknown      | Unknown     |

Scenario: CITI_4387
Verify the loading of 4th phone where the Indicator = E, device type = something not in the mapping
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | E                    | Q               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | I           | 1           | Unknown      | Unknown     |

Scenario: CITI_4388
Verify the loading of 4th phone where the Indicator = X, device type = L and the account has other phones with good indicators 
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | B             |
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479993333        | X                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 3           | Unknown      | Landline    |
	Then The action code 234 is applied to the account

Scenario: CITI_4389
Verify the loading of 4th phone where other phones Indicator = C, 4th phone number indicator is good
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | C             | 6479992222 | C             |
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479993333        | B                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 3           | Unknown      | Landline    |
	Then The action code 234 is applied to the account

Scenario: CITI_4390
Verify the loading of 4th phone where other phones Indicator = X, 4th phone number indicator is good
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | X             | 6479992222 | X             |
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479993333        | B                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 3           | Unknown      | Landline    |
	Then The action code 234 is applied to the account

Scenario: CITI_4408
Verify the loading of 4th phone where the Indicator = unknown indicator, device type = L
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 6479991111        | O                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | A           | 1           | Unknown      | Landline    |

Scenario: CITI_4409
Verify the loading of 4th phone where the number is 999 999 9999
	Given The user modifies the X00 record in DL file with credentials:
		| FourthPhoneNumber | FourthPhoneIndicator | FourthPhoneType |
		| 9999999999        | B                    | L               |
	When The user drops the file to the client UNC path
	And The file is processed
	And A new account is placed in ARxCollect
	Then The phone 9999999999 is not added to the account