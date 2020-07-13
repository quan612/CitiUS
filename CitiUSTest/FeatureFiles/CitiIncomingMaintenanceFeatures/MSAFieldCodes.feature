@InboundMaintenance @MSA @epic:85568
Feature: Inbound MT with MSA field codes	

Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| OILS    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4693
Verify the saving of MAS field codes for MSA when the values were blank from placement	
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value |
		| Date1  |       |
		| Text13 |       |
		| Date2  |       |
		| Date3  |       |
		| Date4  |       |
		| Date5  |       |  
		| Text14 |       |  
	Then The eCollectApps.Citi.ExtrasOverflow table for the account is as below:
		| Field  | Value |
		| MASPPI |       |
		| MASEM1 |       |
		| MASEU1 |       |
		| MASEI1 |       |
		| MASEM2 |       |
		| MASEI2 |       |
		| MASEU2 |       |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value        |
		| Today's date         | MT               | MASPPI     | AB               |
		| Today's date         | MT               | MASEM1     | email1@gmail.com |
		| Today's date         | MT               | MASEU1     | Y                |
		| Today's date         | MT               | MASEI1     | Y                |
		| Today's date         | MT               | MASEM2     | email2@yahoo.com |
		| Today's date         | MT               | MASEI2     | N                |
		| Today's date         | MT               | MASEU2     | N                |
		| Today's date         | MT               | MASLRA     | 20201212         |
		| Today's date         | MT               | MASECI     | H                |
		| Today's date         | MT               | MASLND     | 20201111         |
		| Today's date         | MT               | MASLSD     | 20201010         |
		| Today's date         | MT               | MASNSD     | 20200909         |
		| Today's date         | MT               | MASCLD     | 20200808         |
		| Today's date         | MT               | MASDVT     | M                |  
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field  | Value                  |
		| Date1  | 12/12/2020 12:00:00 AM |
		| Text13 | H                      |
		| Date2  | 11/11/2020 12:00:00 AM |
		| Date3  | 10/10/2020 12:00:00 AM |
		| Date4  | 9/9/2020 12:00:00 AM   |
		| Date5  | 8/8/2020 12:00:00 AM   |
		| Text14 | M                      | 
	Then The eCollectApps.Citi.ExtrasOverflow table for the account is as below:
		| Field  | Value            |
		| MASPPI | AB               |
		| MASEM1 | email1@gmail.com |
		| MASEU1 | Y                |
		| MASEI1 | Y                |
		| MASEM2 | email2@yahoo.com |
		| MASEI2 | N                |
		| MASEU2 | N                |  

Scenario: CITI_4694
Verify the saving of MAS field codes for MSA when the values are different in inbound MT
	Given The user modifies the X00 record in DL file with credentials:
		| Field           | Value            |
		| MsaPromoPrefInd | 76               |
		| MsaEmail1Addr   | email1@gmail.vn |
		| MsaEmail1Usblty | U                |
		| MsaEmail1Cnsnt  | U                |
		| MsaEmail2Addr   | email2@yahoo.vn |
		| MsaEmail2Usblty | B                |
		| MsaEmail2Cnsnt  | B                |
		| MsaDtLasReage   | 20201212         |
		| MsaErlyCoInd    | H                |
		| MsaDtLstBadCk   | 20201111         |
		| MsaLstStmtDt    | 20201010         |
		| MsaNxtStmtDt    | 20200909         |
		| MsaCloseDt      | 20200808         |		
		| MsaDeviceType   | M                | 
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value                  |
		| Date1  | 12/12/2020 12:00:00 AM |
		| Text13 | H                      |
		| Date2  | 11/11/2020 12:00:00 AM |
		| Date3  | 10/10/2020 12:00:00 AM |
		| Date4  | 9/9/2020 12:00:00 AM   |
		| Date5  | 8/8/2020 12:00:00 AM   |
		| Text14 | M                      | 
	Then The eCollectApps.Citi.ExtrasOverflow table for the account is as below:
		| Field  | Value           |
		| MASPPI | 76              |
		| MASEM1 | email1@gmail.vn |
		| MASEU1 | U               |
		| MASEI1 | U               |
		| MASEM2 | email2@yahoo.vn |
		| MASEI2 | B               |
		| MASEU2 | B               |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value         |
		| Today's date         | MT               | MASPPI     | YU                |
		| Today's date         | MT               | MASEM1     | email1B@gmail.com |
		| Today's date         | MT               | MASEU1     | N                 |
		| Today's date         | MT               | MASEI1     | N                 |
		| Today's date         | MT               | MASEM2     | email2B@yahoo.com |
		| Today's date         | MT               | MASEI2     | Y                 |
		| Today's date         | MT               | MASEU2     | Y                 |
		| Today's date         | MT               | MASLRA     | 20211212          |
		| Today's date         | MT               | MASECI     | N                 |
		| Today's date         | MT               | MASLND     | 20211111          |
		| Today's date         | MT               | MASLSD     | 20211010          |
		| Today's date         | MT               | MASNSD     | 20210909          |
		| Today's date         | MT               | MASCLD     | 20210808          |
		| Today's date         | MT               | MASDVT     | D                 |  
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field  | Value                  |
		| Date1  | 12/12/2021 12:00:00 AM |
		| Text13 | N                      |
		| Date2  | 11/11/2021 12:00:00 AM |
		| Date3  | 10/10/2021 12:00:00 AM |
		| Date4  | 9/9/2021 12:00:00 AM   |
		| Date5  | 8/8/2021 12:00:00 AM   |
		| Text14 | D                      | 
	Then The eCollectApps.Citi.ExtrasOverflow table for the account is as below:
		| Field  | Value             |
		| MASPPI | YU                |
		| MASEM1 | email1B@gmail.com |
		| MASEU1 | N                 |
		| MASEI1 | N                 |
		| MASEM2 | email2B@yahoo.com |
		| MASEI2 | Y                 |
		| MASEU2 | Y                 |

Scenario: CITI_4695
Verify the saving of MAS field codes for MSA when the values are blank in inbound MT
	Given The user modifies the X00 record in DL file with credentials:
		| Field           | Value            |
		| MsaPromoPrefInd | 9C               |
		| MsaEmail1Addr   | email1@gmail.com |
		| MsaEmail1Usblty | Y                |
		| MsaEmail1Cnsnt  | Y                |
		| MsaEmail2Addr   | email2@yahoo.com |
		| MsaEmail2Usblty | N                |
		| MsaEmail2Cnsnt  | N                |
		| MsaDtLasReage   | 20201212         |
		| MsaErlyCoInd    | H                |
		| MsaDtLstBadCk   | 20201111         |
		| MsaLstStmtDt    | 20201010         |
		| MsaNxtStmtDt    | 20200909         |
		| MsaCloseDt      | 20200808         |	
		| MsaDeviceType   | M                |	
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field  | Value                  |
		| Date1  | 12/12/2020 12:00:00 AM |
		| Text13 | H                      |
		| Date2  | 11/11/2020 12:00:00 AM |
		| Date3  | 10/10/2020 12:00:00 AM |
		| Date4  | 9/9/2020 12:00:00 AM   |
		| Date5  | 8/8/2020 12:00:00 AM   |
		| Text14 | M                      |  
	Then The eCollectApps.Citi.ExtrasOverflow table for the account is as below:
		| Field  | Value            |
		| MASPPI | 9C               |
		| MASEM1 | email1@gmail.com |
		| MASEU1 | Y                |
		| MASEI1 | Y                |
		| MASEM2 | email2@yahoo.com |
		| MASEI2 | N                |
		| MASEU2 | N                |
	When The user creates a Citi Inbound Maintenance File using account from previous steps:
		| Transaction DateTime | Transaction Code | Field Code | New Value |
		| Today's date         | MT               | MASPPI     |           |
		| Today's date         | MT               | MASEM1     |           |
		| Today's date         | MT               | MASEU1     |           |
		| Today's date         | MT               | MASEI1     |           |
		| Today's date         | MT               | MASEM2     |           |
		| Today's date         | MT               | MASEI2     |           |
		| Today's date         | MT               | MASEU2     |           |
		| Today's date         | MT               | MASLRA     |           |
		| Today's date         | MT               | MASECI     |           |
		| Today's date         | MT               | MASLND     |           |
		| Today's date         | MT               | MASLSD     |           |
		| Today's date         | MT               | MASNSD     |           |
		| Today's date         | MT               | MASCLD     |           |
		| Today's date         | MT               | MASDVT     |           |  
	When The user drops the file to the UNC path, and the file is processed
	And The ECollectUpdate Job is finished	
	Then The Interal Extras table for the account is as below:
		| Field  | Value |
		| Date1  |       |
		| Text13 |       |
		| Date2  |       |
		| Date3  |       |
		| Date4  |       |
		| Date5  |       |
		| Text14 |       | 
	Then The eCollectApps.Citi.ExtrasOverflow table for the account is as below:
		| Field  | Value |
		| MASPPI |       |
		| MASEM1 |       |
		| MASEU1 |       |
		| MASEI1 |       |
		| MASEM2 |       |
		| MASEI2 |       |
		| MASEU2 |       |
