Feature: InboundMTStatusUpdateMASSTS
	To test the loading of inbound MT with field code MASSTS

#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1064
Verify the processing of MT file for account has MTSSTS received from Citi and action code 642 is applied
	Given The user creates a Citi NBS based on the sample file
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished
	Then The action code 642 is applied to the account  			

	Examples: 
	|Transaction DateTime | Transaction Code| Field Code| New Value|
	|2019/09/13		      | MT              | MASSTS    | PC2      | 
	|2019/09/13	          | MT              | MASSTS    | PC7      |
	|2019/09/13	          | MT              | MASSTS    | P3L      | 
	|2019/09/13	          | MT              | MASSTS    | P32      | 
	|2019/09/13	          | MT              | MASSTS    | 327      | 
	|2019/09/13	          | MT              | MASSTS    | 322      | 
	|2019/09/13	          | MT              | MASSTS    | 342      | 
	|2019/09/13	          | MT              | MASSTS    | 317      |  
	|2019/09/13	          | MT              | MASSTS    | 312      |
	|2019/09/13	          | MT              | MASSTS    | 307      |
	|2019/09/13	          | MT              | MASSTS    | 302      |


#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1065
Verify the processing of MT file for account has MTSSTS received from Citi and action code 643 is applied
	Given The user creates a Citi NBS based on the sample file
	When The user drops the file to the client UNC path
		And The file is processed
		And A new account is placed in ARxCollect
	    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
		And The user drops the file to the client UNC path
		And The file is processed
		And The ECollectUpdate Job is finished
	Then The action code 643 is applied to the account  		

	Examples: 
	|Transaction DateTime | Transaction Code| Field Code| New Value|
	|2019/09/13		      | MT              | MASSTS    | 303      | 
	|2019/09/13	          | MT              | MASSTS    | 308      |
	|2019/09/13	          | MT              | MASSTS    | 313      | 
#   |2019/09/13	          | MT              | MASSTS    | 318      |  a mistake from code, overrlapped value
	|2019/09/13	          | MT              | MASSTS    | 343      | 
	|2019/09/13	          | MT              | MASSTS    | 323      | 
	|2019/09/13	          | MT              | MASSTS    | 328      | 
	|2019/09/13	          | MT              | MASSTS    | P33      |  
	|2019/09/13	          | MT              | MASSTS    | P3M      |
	|2019/09/13	          | MT              | MASSTS    | PC8      |
	|2019/09/13	          | MT              | MASSTS    | PC3      |


#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1066
	Verify the processing of MT file for account has MTSSTS received from Citi and action code 644 is applied
		Given The user creates a Citi NBS based on the sample file
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then The action code 644 is applied to the account  		

		Examples: 
		|Transaction DateTime | Transaction Code| Field Code| New Value|
		|2019/09/13		      | MT              | MASSTS    | PC4      | 
		|2019/09/13	          | MT              | MASSTS    | PC9      |
		|2019/09/13	          | MT              | MASSTS    | P3N      | 
		|2019/09/13	          | MT              | MASSTS    | P34      | 
		|2019/09/13	          | MT              | MASSTS    | 329      | 
		|2019/09/13	          | MT              | MASSTS    | 324      | 
		|2019/09/13	          | MT              | MASSTS    | 344      | 
		|2019/09/13	          | MT              | MASSTS    | 319      |  
		|2019/09/13	          | MT              | MASSTS    | 314      |
		|2019/09/13	          | MT              | MASSTS    | 309      |
		|2019/09/13	          | MT              | MASSTS    | 304      |


#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1067
	Verify the processing of MT file for account has MTSSTS received from Citi and action code 645 is applied
		Given The user creates a Citi NBS based on the sample file
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then The action code 645 is applied to the account  		

		Examples: 
		|Transaction DateTime | Transaction Code| Field Code| New Value|
		|2019/09/13		      | MT              | MASSTS    | 350      | 
		|2019/09/13	          | MT              | MASSTS    | 351      |
		|2019/09/13	          | MT              | MASSTS    | 352      | 
		|2019/09/13	          | MT              | MASSTS    | 353      | 
		|2019/09/13	          | MT              | MASSTS    | 354      | 
		|2019/09/13	          | MT              | MASSTS    | 355      | 
		|2019/09/13	          | MT              | MASSTS    | 358      | 
		|2019/09/13	          | MT              | MASSTS    | P35      |  
		|2019/09/13	          | MT              | MASSTS    | P3R      |
		|2019/09/13	          | MT              | MASSTS    | PD1      |
		|2019/09/13	          | MT              | MASSTS    | PD2      |


#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1068
	Verify the processing of MT file for account has MTSSTS received from Citi and action code 646 is applied (only applied to CRET)
		Given The user creates a Citi NBS based on the sample file
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates the Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then The action code 646 is applied to the account  
			And The account is put to support queue CSSIFExceptionCiti

		Examples: 
		|Transaction DateTime | Transaction Code| Field Code| New Value|
		|2019/09/13		      | MT              | MASSTS    | PD3      | 
		|2019/09/13	          | MT              | MASSTS    | PJ3      |
		|2019/09/13	          | MT              | MASSTS    | PA3      | 
		|2019/09/13	          | MT              | MASSTS    | PB3      | 
		|2019/09/13	          | MT              | MASSTS    | 35A      | 
		|2019/09/13	          | MT              | MASSTS    | 35B      | 
		|2019/09/13	          | MT              | MASSTS    | 35C      | 
		|2019/09/13	          | MT              | MASSTS    | 35D      |  
		|2019/09/13	          | MT              | MASSTS    | 35E      |
		|2019/09/13	          | MT              | MASSTS    | 35F      |
		

#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1069
	Verify the processing of MT file for account has MTSSTS received from Citi and action code 647 is applied
		Given The user creates a Citi NBS based on the sample file
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then The action code 647 is applied to the account  
		Then The account is put to support queue CSRecallMonitorCiti

		Examples: 
		|Transaction DateTime | Transaction Code| Field Code| New Value|
		|2019/09/13		      | MT              | MASSTS    | 373      | 


#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1070
	Verify the processing of MT file for account has MTSSTS received from Citi and action code 648 is applied
		Given The user creates a Citi NBS based on the sample file
		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished
		Then The action code 648 is applied to the account  
		Then The account is put to support queue CSRecallMonitorCiti

		Examples: 
		|Transaction DateTime | Transaction Code| Field Code| New Value|
		|2019/09/13		      | MT              | MASSTS    | 375      | 
		

#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1045
	Verify the processing of MT file for account that has MASSTS received from Citi and were charged off
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
				|Account status | 
				|000			|  

		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished

		Then The account extras information: Text7 is <New Value>
			And The action code 641 is NOT applied to the account  
			And The account is not moved to any support queue
		
		Examples: 
		|Transaction DateTime | Transaction Code| Field Code| New Value|
		|2019/09/16			  | MT              | MASSTS    | 301      | 
		|2019/09/16			  | MT              | MASSTS    | 302      |
		|2019/09/16			  | MT              | MASSTS    | 303      |
		|2019/09/16			  | MT              | MASSTS    | 306      |
		|2019/09/16			  | MT              | MASSTS    | 307      |
		|2019/09/16			  | MT              | MASSTS    | 308      |
		|2019/09/16			  | MT              | MASSTS    | 311      |
		|2019/09/16			  | MT              | MASSTS    | 312      |
		|2019/09/16			  | MT              | MASSTS    | 313      |
		|2019/09/16			  | MT              | MASSTS    | 316      |
		|2019/09/16			  | MT              | MASSTS    | 317      |
		|2019/09/16			  | MT              | MASSTS    | 318      |
		|2019/09/16			  | MT              | MASSTS    | 321      |
		|2019/09/16			  | MT              | MASSTS    | 322      |
		|2019/09/16			  | MT              | MASSTS    | 323      |
		|2019/09/16			  | MT              | MASSTS    | 326      |
		|2019/09/16			  | MT              | MASSTS    | 327      |
		|2019/09/16			  | MT              | MASSTS    | 328      |
		|2019/09/16			  | MT              | MASSTS    | P31      |
		|2019/09/16			  | MT              | MASSTS    | PC1      |
		|2019/09/16			  | MT              | MASSTS    | PC6      |
		|2019/09/16			  | MT              | MASSTS    | P3K      |
#		|2019/09/16			  | MT              | MASSTS    | P30      |  
#this P30 is a mistake from the code, overlapped with the same code of next test case
		|2019/09/16			  | MT              | MASSTS    | 341      |


#--------------------------------------------------------------------------------------------------
Scenario Outline: CITI-1046
	Verify the processing of MT file for account that has MASSTS received from Citi and were NOT charged off (to be moved to Support)
		Given The user creates a Citi NBS based on the sample file
			And The user modifies the account record in DL file with credentials:
				|Account status | 
				|000			|  

		When The user drops the file to the client UNC path
			And The file is processed
			And A new account is placed in ARxCollect
		    And The user creates a Citi Inbound MT File with <Transaction DateTime>, <Transaction Code>, <Field Code>, <New Value>	
			And The user drops the file to the client UNC path
			And The file is processed
			And The ECollectUpdate Job is finished

		Then The account extras information: Text7 is <New Value>
			And The action code 641 is applied to the account  
			And The account is put to support queue CSSIFExceptionsCiti
		
			Examples: 
			|Transaction DateTime | Transaction Code| Field Code| New Value|
			|2019/09/16			  | MT              | MASSTS    | 300      | 
			|2019/09/16			  | MT              | MASSTS    | 305      |
			|2019/09/16			  | MT              | MASSTS    | 310      |
			|2019/09/16			  | MT              | MASSTS    | 315      |
			|2019/09/16			  | MT              | MASSTS    | 320      |
			|2019/09/16			  | MT              | MASSTS    | 325      |
			|2019/09/16			  | MT              | MASSTS    | 340      |
			|2019/09/16			  | MT              | MASSTS    | P30      |
			|2019/09/16			  | MT              | MASSTS    | PC0      |
			|2019/09/16			  | MT              | MASSTS    | PC5      |
			|2019/09/16			  | MT              | MASSTS    | P3J      |
		
