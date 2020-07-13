Feature: CitiNBSTestNoteRecord
	To test the loading of Citi US account when receiving H record in NBS file.

#Scenario: CITI_696
#Verify the new business DL file when note section contains POA, poa, atty rep string
#	Given The user modifies the Citi New Business File with H record containing words like POA, poa, atty rep
#	When The user drops the file to the client UNC path
#	And The file is processed
#	When A new account is placed in ARxCollect
#	Then The account is put to support queue CITIAREPQUEUE
