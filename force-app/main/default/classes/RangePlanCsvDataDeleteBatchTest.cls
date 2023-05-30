@isTest
public class RangePlanCsvDataDeleteBatchTest {
    @testSetup
	static void setup(){
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'RollUpNoOfFiles';
        tt.Active__c = false;
        insert tt;
        
        TriggerStatus__c tl = new TriggerStatus__c();
        tl.Name = 'TestTrigger';
        tl.Active__c = false;
        insert tl;
         
        
		RangePlanCSVData__c rcc = new RangePlanCSVData__c();
	    insert rcc;
        
        
        ContentVersion contver = new ContentVersion();
        contver.ContentLocation = 'S';
        contver.Title = 'L1L5Data.csv';
        contver.VersionData = Blob.valueOf('Test Content');
        contver.pathOnClient ='L1L5Data.csv';

        insert contver;
        
        string versionId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contver.Id].ContentDocumentId;
        
        ContentDocumentLink cd = new ContentDocumentLink();
        cd.ContentDocumentId=versionId;
        cd.LinkedEntityId=rcc.Id;
        cd.Sharetype ='I';
        cd.visibility = 'AllUsers';
        insert cd;
		
		Datetime yesterday = Datetime.now().addDays(-166);
        Test.setCreatedDate(rcc.Id, yesterday); 
        Test.setCreatedDate(contver.Id, yesterday); 
        Test.setCreatedDate(cd.Id, yesterday); 
		
	}
	static testMethod void testMethod1() {
	    Test.startTest();
		RangePlanCsvDataDeleteBatch obj = new RangePlanCsvDataDeleteBatch();
		String sch = '0 0 2 * * ?'; 
		system.schedule('Test Territory Check', sch, obj); 
		Test.stopTest();
    }

}