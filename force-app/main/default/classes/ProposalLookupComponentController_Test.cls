@isTest
public class ProposalLookupComponentController_Test {
        public static testMethod void testLookupComponentController() {
            String search = 'ABC';
            String sObjectApiName = 'Product_Master__c';
            String recordId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Eyewear').getRecordTypeId();
            List<Product_Master__c> prod1 = new List<Product_Master__c>();
            sObject prod2;
            prod1 = ProposalToolLookupComponentController.fetchLookupData(search, sObjectApiName);
            prod2 = ProposalToolLookupComponentController.fetchDefaultRecord(recordId, sObjectApiName);
            
   }
}