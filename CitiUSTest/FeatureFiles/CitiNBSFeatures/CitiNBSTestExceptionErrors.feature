Feature: CitiNBSTestExceptionErrors
	To test the loading of new placement file in case there is an exception error.

#Scenario: CITI_929
#Verify the processing of new dl file when clientID cannot be determined due to invalid MIO Code, RecovererID or OfficerCode
#	Given The user modifies the Citi New Business File with invalid MIO Code
#	When The user drops the file to the client UNC path
#	Then An exception error is thrown as Client Mapping Not Found