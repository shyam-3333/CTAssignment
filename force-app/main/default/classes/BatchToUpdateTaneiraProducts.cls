public class BatchToUpdateTaneiraProducts implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext BC){
        
        string query = 'SELECT Id,Proc_Type__c,Proc_Source__c From Product__c where Proc_Type__c = \'Outsourced Design\'  ';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<Product__c> scope){
        for(Product__c pr:scope)
        	system.debug(pr.Proc_Type__c);
        List<Product__c> updateProdList = new List<Product__c>();
        for(Product__c pr:scope)
        {
            Product__c prod = new Product__c();
            prod.Id = pr.Id ;
            prod.Proc_Type__c = 'Vendor Co created';
            prod.Proc_Source__c = pr.Proc_Type__c ;
            updateProdList.add(prod);
        }
        
        if(updateProdList.size() > 0)
            update updateProdList;
    }
    public void finish(Database.BatchableContext BC){
        
    }
    
    
}