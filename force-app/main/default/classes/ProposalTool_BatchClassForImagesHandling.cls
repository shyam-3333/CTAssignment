public class ProposalTool_BatchClassForImagesHandling implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String jewelRecordType = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        String watchesRecordType = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Watches').getRecordTypeId();
        String query = 'SELECT Id,Images_1__c,Images_2__c, Images_3__c, Images_4__c, Images_5__c,Images_6__c, Images_7__c, Images_8__c, Images_9__c, Images_10__c  FROM Product_Master__c where (RecordTypeId =:jewelRecordType Or RecordTypeId=:watchesRecordType)';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Product_Master__c> productMasterData) {
        try {
            
            
            // process each batch of records default size is 200
            List<Product_Master__c> productMaster = new List<Product_Master__c>();
            
            for(Product_Master__c product : productMasterData) {   
                String allImages ='';
                if(product.Images_1__c != null){
                    allImages+=product.Images_1__c+',';
                }
                if(product.Images_2__c != null){
                    allImages+=product.Images_2__c+',';
                }
                if(product.Images_3__c != null){
                    allImages+=product.Images_3__c+',';
                }
                if(product.Images_4__c != null){
                    allImages+=product.Images_4__c+',';
                }
                if(product.Images_5__c != null){
                    allImages+=product.Images_5__c+',';
                }
                if(product.Images_6__c != null){
                    allImages+=product.Images_6__c+',';
                }
                if(product.Images_7__c != null){
                    allImages+=product.Images_7__c+',';
                }
                if(product.Images_8__c != null){
                    allImages+=product.Images_8__c+',';
                }
                if(product.Images_9__c != null){
                    allImages+=product.Images_8__c+',';
                }
                if(product.Images_10__c != null){
                    allImages+=product.Images_8__c+',';
                }
                if(allImages != null && allImages != ''){
                    allImages.removeEnd(',');
                    productMaster.add(new Product_Master__c(Id=product.Id,All_Images__c=allImages,Product_To_Show__c =true));
                }            
            }
            
            
            if(!productMaster.isEmpty()){
                Database.update(productMaster);
            }
            
        } catch(Exception e) {
            System.debug(e);
        }
    } 
    public void finish(Database.BatchableContext BC) {
    }
}