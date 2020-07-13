@Placement @X00_Record @MSA @epic:85568
Feature: X00 Record MSA
	Related to MSA fields in X00 record
	
Background: 
	Given The user creates a Citi NBS based on the sample file
		And The user modifies the header record with credentials:
		| MIOCode | ListDate |
		| OILS    | 2019/08/15|
		And The user modifies the recoverer in DL file with credentials:
		| LoanTypeCode | OfficerCode | MIOCode | RecovererCode |
		| CONS         | 0800        | OILS    | GIC5          |

Scenario: CITI_4691
Verify the saving of MSA fields when we receive values that are not blank in X00 Record
	Given The user modifies the X00 record in DL file with credentials:
		| Field           | Value            |
		| MsaPromoPrefInd | AB               |
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
	When A new account is placed in ARxCollect	
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

Scenario: CITI_4692
Verify the saving of MSA fields when we receive values that are blank in X00 Record
	Given The user modifies the X00 record in DL file with credentials:
		| Field           | Value |
		| MsaPromoPrefInd |       |
		| MsaEmail1Addr   |       |
		| MsaEmail1Usblty |       |
		| MsaEmail1Cnsnt  |       |
		| MsaEmail2Addr   |       |
		| MsaEmail2Usblty |       |
		| MsaEmail2Cnsnt  |       |
		| MsaDtLasReage   |       |
		| MsaErlyCoInd    |       |
		| MsaDtLstBadCk   |       |
		| MsaLstStmtDt    |       |
		| MsaNxtStmtDt    |       |
		| MsaCloseDt      |       |
		| MsaDeviceType   |       |   
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
	
Scenario: CITI_4696
Verify the mappings for delinquent
	Given The user modifies the X00 record in DL file with credentials:
		| Field              | Value |
		| DaysDelinquent     | 555   |
		| DelinquencyBucket  | 1     |
		| DelinquencyHistory | abcde |
		| TreatmentTag       | tag   |  		
	When The user drops the file to the UNC path, and the file is processed
	When A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field | Value |
		| Text4 | abcde |
		| Text5 | tag   |	
	Then The Extras table for the account is as below:
		| Field    | Value |
		| Number19 | 555   |
		| Number20 | 1     |  

Scenario: CITI_4697
Verify the mappings for delinquent when they are blank in placement file
	Given The user modifies the X00 record in DL file with credentials:
		| Field              | Value |
		| DaysDelinquent     |       |
		| DelinquencyBucket  |       |
		| DelinquencyHistory |       |
		| TreatmentTag       |       |
	When The user drops the file to the UNC path, and the file is processed
	And A new account is placed in ARxCollect	
	Then The Interal Extras table for the account is as below:
		| Field | Value |
		| Text4 |       |
		| Text5 |       |  
	Then The Extras table for the account is as below:
		| Field    | Value |
		| Number19 |       |
		| Number20 |       |  