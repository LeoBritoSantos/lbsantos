@isTest
private class CleanUpBatchClassTest 
{
	static testmethod void test()
	{
		String query = 'SELECT Id, CreatedDate FROM Merchandise__c WHERE Id NOT IN (SELECT Merchandise__c FROM Line_Item__c)';

		Merchandise__c[] ml = new List<Merchandise__c>();
		for(Integer i = 0; i < 10; i++)
		{
			Merchandise__c m = new Merchandise__c(
												  	Name = 'Merchandise ' + i,
												  	Description__c = 'Some Description ' + i,
												  	Price__c = i,
												  	Total_Inventory__c = 100 + i
												 );
			ml.add(m);
		}

		insert ml;

		Test.startTest();
			CleanUpRecords c = new CleanUpRecords(query);
			Database.executeBatch(c);
		Test.stopTest();

		Integer i = [SELECT COUNT() FROM Merchandise__c];
		System.assertEquals(i, 0);
	}
}