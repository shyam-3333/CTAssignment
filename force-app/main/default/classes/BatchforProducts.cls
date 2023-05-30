public class BatchforProducts implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        string query = 'SELECT Id,Product_Category_Taneira__c From Product__c where Product_Category_Taneira__c != null';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<Product__c> scope){
        	
        List<Product__c> updateProdList = new List<Product__c>();
        for(Product__c pr:scope)
        {
            
            Product__c prod = new Product__c();
            prod.Id = pr.Id ;
            //string prodcategory = pr.Product_Category_Taneira__c;
            prod.Product_Category_Taneira__c =pr.Product_Category_Taneira__c.toUpperCase() ;
            updateProdList.add(prod);
        }
        system.debug('Product list'+updateProdList);
        if(updateProdList.size() > 0)
            update updateProdList;
        system.debug('Product list size'+updateProdList.size());
    }
    public void finish(Database.BatchableContext BC){
        
    }
}