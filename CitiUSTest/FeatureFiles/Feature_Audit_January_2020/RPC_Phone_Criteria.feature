@OutboundMaintenance @Audit
Feature: RPC_Phone_Criteria
	
Background:
	Given The user creates a Citi NBS based on the sample file
	And The user modifies the header record with credentials:
		| MIOCode | ListDate   |
		| OILS    | 2019/08/15 |
	And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |


###################		
Scenario: CITI_4587
Verify the sending of phone when a new number is set up and there is a call record for this account that is Right Party Contact
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479991111 with status Active location Home service Landline
	And the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |  

	
###################	
Scenario: CITI_4588
Verify the sending of phone when a new number is set up and there is a call record for this account but it is not RPC
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479991111 with status Active location Home service Landline
	And the user creates a call record for phone number 6479991111 with Right Party Contact as false
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCNT    |
		| MASOCC    | 
		| MASRPH    |
		| MASRPF    |


###################	
Scenario: CITI_4589
Verify the sending of phone when a new number is set up and there is a no call record for this account
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479991111 with status Active location Home service Landline	
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCNT    |
		| MASOCC    | 
		| MASRPH    |
		| MASRPF    |


###################	
Scenario: CITI_4590
Verify the sending of phone when a new number is set up and there is a call record set up many days later
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479991111 with status Active location Home service Landline	
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCNT    |
		| MASOCC    | 
		| MASRPH    |
		| MASRPF    |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCNT    |
		| MASOCC    | 
		| MASRPH    |
		| MASRPF    |
	When The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records below should not be sent for the account in the file
		| FieldCode |
		| MASHPH    |
		| MASHPF    |
		| MASOPH    |
		| MASOPF    |
		| MASCNT    |
		| MASOCC    | 
		| MASRPH    |
		| MASRPF    |
	When the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          | 


###################	
Scenario: CITI_4591
Verify the sending of phone when a new number is set up with RPC and the status is changed multiple times
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect
	And the user adds a new number 6479991111 with status Active location Home service Landline	
	When the user creates a call record for phone number 6479991111 with Right Party Contact as true
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          | 
	When the user changes the phone number 6479991111 to status Verbal Do Not Call
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | X          | 
	When the user changes the phone number 6479991111 to status Active
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          | 
	When the user changes the phone number 6479991111 to status Written DNC
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | C          | 
	When the user changes the phone number 6479991111 to status Active
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |
	When the user changes the phone number 6479991111 to status Not In Service
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | D          | 
	When the user changes the phone number 6479991111 to status Active
	And The user generates an outbound maintenance file for OILS_ALL
	And The associated job is completed
	Then The records are sent in the outbound maintenance file as below:
		| Field Code | New Value  |
		| MASHPH     | 6479991111 |
		| MASHPF     | Y          |
