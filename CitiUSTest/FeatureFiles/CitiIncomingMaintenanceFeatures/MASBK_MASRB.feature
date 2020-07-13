@InboundMaintenance @MASBK_MASRB @epic:85568
Feature: Inbound MT with MASBK MASRB field codes
	
Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| OILS    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4700
Verify the saving of bucket values when processing an inbound MT
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   |       |
		| Number5   |       |
		| Number6   |       |
		| Number7   |       |
		| Number8   |       |
		| Number9   |       |
		| Currency1 |       | 		
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASBK1     | 11A       |
		| Today's date         | MT               | MASBK2     | 22B       |
		| Today's date         | MT               | MASBK3     | 33C       |
		| Today's date         | MT               | MASBK4     | 66F       |
		| Today's date         | MT               | MASBK5     | 55E       |
		| Today's date         | MT               | MASBK6     | 44D       |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   | 1.11  |
		| Number5   | 2.22  |
		| Number6   | 3.33  |
		| Number7   | 6.66  |
		| Number8   | 5.55  |
		| Number9   | 4.44  |
		| Currency1 | 6.66  |

Scenario: CITI_4701
Verify the updating of bucket values when having values received in placement and then having different values in inbound MT
	Given The user modifies the X01 record in DL file with credentials:
		| Field          | Value |
		| MsaDelqBucket1 | 1.11  |
		| MsaDelqBucket2 | 2.22  |
		| MsaDelqBucket3 | 3.33  |
		| MsaDelqBucket4 | 6.66  |
		| MsaDelqBucket5 | 5.55  |
		| MsaDelqBucket6 | 4.44  |	
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   | 1.11  |
		| Number5   | 2.22  |
		| Number6   | 3.33  |
		| Number7   | 6.66  |
		| Number8   | 5.55  |
		| Number9   | 4.44  |
		| Currency1 | 6.66  |		
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASBK1     | 11.11     |
		| Today's date         | MT               | MASBK2     | 12.22     |
		| Today's date         | MT               | MASBK3     | 13.33     |
		| Today's date         | MT               | MASBK4     | 16.66     |
		| Today's date         | MT               | MASBK5     | 15.55     |
		| Today's date         | MT               | MASBK6     | 14.44     | 
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   | 11.11 |
		| Number5   | 12.22 |
		| Number6   | 13.33 |
		| Number7   | 16.66 |
		| Number8   | 15.55 |
		| Number9   | 14.44 |
		| Currency1 | 16.66 |

Scenario: CITI_4702
Verify the updating of bucket values when having values received in placement and then having blank values in inbound MT
	Given The user modifies the X01 record in DL file with credentials:
		| Field          | Value |
		| MsaDelqBucket1 | 1.11  |
		| MsaDelqBucket2 | 2.22  |
		| MsaDelqBucket3 | 3.33  |
		| MsaDelqBucket4 | 6.66  |
		| MsaDelqBucket5 | 5.55  |
		| MsaDelqBucket6 | 4.44  |	
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   | 1.11  |
		| Number5   | 2.22  |
		| Number6   | 3.33  |
		| Number7   | 6.66  |
		| Number8   | 5.55  |
		| Number9   | 4.44  |
		| Currency1 | 6.66  | 		
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASBK1     |           |
		| Today's date         | MT               | MASBK2     |           |
		| Today's date         | MT               | MASBK3     |           |
		| Today's date         | MT               | MASBK4     |           |
		| Today's date         | MT               | MASBK5     |           |
		| Today's date         | MT               | MASBK6     |           | 
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field     | Value |
		| Number4   |       |
		| Number5   |       |
		| Number6   |       |
		| Number7   |       |
		| Number8   |       |
		| Number9   |       |
		| Currency1 |       |

Scenario: CITI_4703
Verify the saving of roolbck values when processing an inbound MT
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field    | Value |
		| Number10 |       |
		| Number11 |       |
		| Number12 |       |
		| Number13 |       |
		| Number14 |       |
		| Number15 |       |  	
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASRB1     | 21.11     |
		| Today's date         | MT               | MASRB2     | 22.22     |
		| Today's date         | MT               | MASRB3     | 23.33     |
		| Today's date         | MT               | MASRB4     | 26.66     |
		| Today's date         | MT               | MASRB5     | 25.55     |
		| Today's date         | MT               | MASRB6     | 24.44     |  
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field    | Value |
		| Number10 | 21.11 |
		| Number11 | 22.22 |
		| Number12 | 23.33 |
		| Number13 | 26.66 |
		| Number14 | 25.55 |
		| Number15 | 24.44 | 

Scenario: CITI_4704
Verify the updating of rollbck values when having values received in placement and then having different values in inbound MT
	Given The user modifies the X01 record in DL file with credentials:
		| Field          | Value |
		| MsaRollBck1    | 11.11 |
		| MsaRollBck1    | 22.22 |
		| MsaRollBck1    | 33.33 |
		| MsaRollBck1    | 44.44 |
		| MsaRollBck1    | 55.55 |
		| MsaRollBck1    | 66.66 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field    | Value |
		| Number10 | 11.11 |
		| Number11 | 22.22 |
		| Number12 | 33.33 |
		| Number13 | 44.44 |
		| Number14 | 55.55 |
		| Number15 | 66.66 |		
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASRB1     | 991.11    |
		| Today's date         | MT               | MASRB2     | 992.22    |
		| Today's date         | MT               | MASRB3     | 993.33    |
		| Today's date         | MT               | MASRB4     | 996.66    |
		| Today's date         | MT               | MASRB5     | 995.55    |
		| Today's date         | MT               | MASRB6     | 994.44    |   
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field    | Value  |
		| Number10 | 991.11 |
		| Number11 | 992.22 |
		| Number12 | 993.33 |
		| Number13 | 996.66 |
		| Number14 | 995.55 |
		| Number15 | 994.44 |  
	
Scenario: CITI_4705
Verify the updating of rollbck values when having values received in placement and then having blank values in inbound MT
	Given The user modifies the X01 record in DL file with credentials:
		| Field          | Value |
		| MsaRollBck1    | 11.11 |
		| MsaRollBck1    | 22.22 |
		| MsaRollBck1    | 33.33 |
		| MsaRollBck1    | 44.44 |
		| MsaRollBck1    | 55.55 |
		| MsaRollBck1    | 66.66 |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field    | Value |
		| Number10 | 11.11 |
		| Number11 | 22.22 |
		| Number12 | 33.33 |
		| Number13 | 44.44 |
		| Number14 | 55.55 |
		| Number15 | 66.66 |		
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASRB1     |           |
		| Today's date         | MT               | MASRB2     |           |
		| Today's date         | MT               | MASRB3     |           |
		| Today's date         | MT               | MASRB4     |           |
		| Today's date         | MT               | MASRB5     |           |
		| Today's date         | MT               | MASRB6     |           |
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field    | Value |
		| Number10 |       |
		| Number11 |       |
		| Number12 |       |
		| Number13 |       |
		| Number14 |       |
		| Number15 |       |