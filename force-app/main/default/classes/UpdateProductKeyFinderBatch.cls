global class UpdateProductKeyFinderBatch implements  DataBase.Batchable<sObject>,Schedulable{

    global Database.QueryLocator start(Database.BatchableContext BC){
        String recType=Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        return Database.getQueryLocator('Select ID,Name,Quantity__c,Cost__c,Product_Category_Taneira__c,CreatedDate,Cluster__c,Account__c,vendor_custom__c,Offline_Username__c,Product_Key_Finder__c,Updated_in_TaneiraView__c FROM Product__c WHERE Product_Key_Finder__c =NULL AND Product_Key_Finder__c =\'\' AND RecordTypeId =:recType AND RE_ORDER__c!=true AND CreatedDate > 2017-11-30T07:11:29.000Z  ORDER BY CreatedDate DESC');
    }
    global void execute(Database.BatchableContext BC,List<Product__c> scope){
        List<Product__c> prodList = new List<Product__c>();
        Product__c prodObj;
        String prodKey;
        for(Product__c each : scope){
            prodObj = new Product__c();
            prodObj.Id=each.Id;
            prodKey = (String.valueOf(each.CreatedDate).substring(0,13).trim()+each.vendor_custom__c+each.Product_Category_Taneira__c+each.Cluster__c+each.Offline_Username__c).trim();
            prodKey = prodKey.replaceAll( '\\s+', '');
            prodObj.Product_Key_Finder__c = prodKey;
            prodList.add(prodObj);
        }
        if(!prodList.isEmpty()){
            update prodList;
        }
    }
    global void finish(Database.BatchableContext info){
        
    }
    global void execute(SchedulableContext sc) {        
        UpdateProductKeyFinderBatch b1 = new UpdateProductKeyFinderBatch();
        Database.executeBatch(b1,200);           
    }
}