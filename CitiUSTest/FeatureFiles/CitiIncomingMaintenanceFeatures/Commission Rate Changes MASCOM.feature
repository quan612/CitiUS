Feature: Commission Rate Changes MASCOM
	To test the loading of inbound MT with field code MASCOM. Should not change the commission rate from placement file
	
#------------------------------------------------------------------------------------------------
Scenario: CITI-972
	Verify that if commission rate received in MT file is different with ARx commission rate, ARx commission rate should not be changed
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
				|Commission rate | 
				|4099			 |  

		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect

		Then The account information: CommissionRate is 40.99
		
		When The user creates a Citi Inbound Maintenance File using account from previous steps:
			|Transaction DateTime | Transaction Code| Field Code| New Value		 |
			|2019/09/29			  | MT              | MASCOM    | 000000650{     |
			 
			And The user drops the file to the client UNC path

		Then A general error status happens when processing the row record
			And The account information: CommissionRate is 40.99