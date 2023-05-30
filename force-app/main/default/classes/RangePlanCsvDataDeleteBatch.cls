/************************************************************************************
Created By: Samarth Hegade
@description: This is a scheduled Batch used to Delete Csv data stored in content Document that is older than 165 days. Runs Daily
**************************************************************************************/
global class RangePlanCsvDataDeleteBatch Implements Database.Batchable <sObject>,Schedulable {
	 global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT id from RangePlanCSVData__c where Record_age__c > 165';
        return Database.getQueryLocator(query);
    }

     
    global void execute(Database.BatchableContext bc, List<RangePlanCSVData__c> scope) {
        List<ContentDocumentLink> fileLinkList = new List<ContentDocumentLink>();
        List<ContentDocument> fileList = new List<ContentDocument>();
        List<Id> rIds = new List<Id>();
        List<Id> linkIds = new List<Id>();
        
        if(scope != null){
            for(RangePlanCSVData__c rp : scope){
            	linkIds.add(rp.Id);
        	}
            
            
        	fileLinkList=[SELECT Id,contentdocumentid,linkedentity.name,linkedentityid,linkedentity.type FROM ContentDocumentLink where LinkedEntityId IN:linkIds];
            
            for(ContentDocumentLink cd :fileLinkList ){
                rIds.add(cd.contentdocumentid);
            }
            fileList = [SELECT Id, CreatedBy.name, ContentSize, ParentId FROM ContentDocument where Id IN:rIds];
    
            delete fileLinkList;
            delete fileList;
            delete scope;
                
            }    
    }
    
    global void finish (Database.BatchableContext bc) {
        
    }
    
    global void execute(SchedulableContext sc)

     {

         RangePlanCsvDataDeleteBatch b = new RangePlanCsvDataDeleteBatch();
    	 database.executeBatch(b);

     }
}