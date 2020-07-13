@OutboundMaintenance @NoPhoneUpdate @BANK @epic:84633
Feature: No Phone Update For BANK
	To test that no phone update should be sent to Citi

Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate  |
		| BANK    | Yesterday |
	And The user modifies the account record in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 433902      | BANK    | GL03          |


Scenario: CITI_4325
Citi Home Work Cell are good and there is no phone update in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
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


Scenario: CITI_4326
Citi Home Work Cell are same and good and there is no phone update in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | H             | 6479991111 | A             | 
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479991111 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
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


Scenario: CITI_4348
Citi Home Work are same and good and load a same Cell phone in MT file (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479991111 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | A          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |


# good to wireless  where there is a good Cell
Scenario: CITI_4343
Citi Home Work Cell good, the agent changes this Home status to Wireless
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | H             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to status Wireless
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


# good to good status and service landline to Mobile when there is no cell => send nothing
Scenario: CITI_4164
Citi Home Work is good, the agent changes this Home service to Mobile and status to Wireless
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | H             | 6479992222 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to service Mobile
	And the user changes the phone number 6479991111 to status Wireless
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


# good to good - status change when there is no cell => send nothing
Scenario: CITI_4337
Citi Home Work is good, the agent changes this Home status to Wireless and there is no Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator | 
		| 6479991111 | H             | 6479992222 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to status Wireless
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


# good to good service change when there is no cell = > send nothing
Scenario: CITI_4338
Citi Home Work is good, the agent changes this Home service to Mobile, keep status as Active
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | J             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to service Mobile
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


# good to good status change from active to wireless when there is a bad Cell => send nothing
Scenario: CITI_4342
Citi Home Work good Cell bad, the agent changes this Home status to Wireless when there is a bad Cell in ARx
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | J             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to status Wireless
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


# wireless to active - good to good when there is no Home - PASS
Scenario: CITI_4340
Citi Cell is good, agent changes this Cell status to Active and there is no Home is ARxCollect
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		|            |               | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
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
	When the user changes the phone number 6479993333 to status Active
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


# wireless to active - good to good when there is a bad Home - PASS
Scenario: CITI_4341
Citi Cell is good, agent changes this Cell status to Active and there is a bad Home in ARxCollect
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | B             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
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
	When the user changes the phone number 6479993333 to status Active
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


Scenario: CITI_4234
Citi Home Work Cell are Good, Home Work Cell changed to Wrong Number by Citi MT (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | B          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | B          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | B          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
		| MASRPH    |
		| MASRPF    |


Scenario: CITI_4242
Citi Home Work Cell are Good, Home Work Cell changed to Not In Service by Citi MT (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | N          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | N          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | N          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | N           | 1           | Home         | Landline    |
		| 6479992222  | N           | 2           | Work         | Landline    |
		| 6479993333  | N           | 18          | Home         | Mobile      |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
		| MASRPH    |
		| MASRPF    |

################################################################################
Scenario: CITI_4243
Citi Home Work Cell are Good, Home Work Cell changed to Verbal DNC by Citi MT (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | B          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | B          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | B          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | V           | 1           | Home         | Landline    |
		| 6479992222  | V           | 2           | Work         | Landline    |
		| 6479993333  | V           | 18          | Home         | Mobile      |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
		| MASRPH    |
		| MASRPF    |


Scenario: CITI_4244
Citi Home Work Cell are Good, Home Work Cell changed to Written DNC by Citi MT (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASHPH     | 6479991111 |
		| Today's date         | MT               | MASHPF     | W          |
		| Today's date         | MT               | MASOPH     | 6479992222 |
		| Today's date         | MT               | MASOPF     | W          |
		| Today's date         | MT               | MASCPN     | 6479993333 |
		| Today's date         | MT               | MASCPI     | W          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | X           | 1           | Home         | Landline    |
		| 6479992222  | X           | 2           | Work         | Landline    |
		| 6479993333  | X           | 18          | Home         | Mobile      |
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
		| MASRPH    |
		| MASRPF    |


Scenario: CITI_4224
Citi Home Work are Good, received a Citi MT with Cell that matches Home and there is no Cell in ARx (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | A          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	Then The Account Phones table for the account is as below:
		| PhoneNumber | PhoneStatus | DisplaySlot | LocationType | ServiceType |
		| 6479991111  | W           | 1           | Home         | Mobile      |
		| 6479992222  | A           | 2           | Work         | Landline    |	
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
		| MASRPH    |
		| MASRPF    |


Scenario: CITI_4227
Citi Home Work are Good, received a Citi MT with Cell that matches Home and there is no Cell in ARx (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | A             | 6479992222 | A             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value  |
		| Today's date         | MT               | MASCPN     | 6479991111 |
		| Today's date         | MT               | MASCPI     | A          |
	And The user drops the file to the UNC path, and the file is processed and the eCollect Job is done
	When The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCPN    |
		| MASCPI    |
		| MASRPH    |
		| MASRPF    |


#location change
Scenario: CITI_4149
Citi Home is good, agent changes this Home Location to Work and there is another Work phone in ARx as good
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | H             | 6479992222 | H             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | J             | 
	When The user drops the file to the client UNC path
	And The file is processed
	When A new account is placed in ARxCollect
	And The user generates an outbound maintenance file for BANK_ALL
	And The associated job is completed
	When the user changes the phone number 6479991111 to location Work	
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
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


Scenario: CITI_4258
Citi Home Cell are Good, agent changes Citi Home service to Mobile (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given ThThe user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | D             | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to service Mobile
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
		
Scenario: CITI_4259
Citi Home Good Cell Bad, agent changes Citi Home service to Mobile (BANK)
	Given The user modifies the account record in DL file with credentials:
		| HomeNumber | HomeIndicator | WorkNumber | WorkIndicator |
		| 6479991111 | D             | 6479992222 | D             |
	Given The user modifies the X00 record in DL file with credentials:
		| CellNumber | CellIndicator |
		| 6479993333 | B             |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user changes the phone number 6479991111 to service Mobile
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
