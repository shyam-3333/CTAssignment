public class ProductInsertEmailAttachment {

    public list<Product__c> proList{get;set;}
    public ProductInsertEmailAttachment(){
        string keyFinder = apexpages.currentpage().getparameters().get('KeyFinder');
        system.debug('keyFinder==>'+keyFinder);
        If(!test.isRunningTest()){
            if(keyFinder != null && keyFinder != ''){
            proList = [select id,Product_Key_Finder__c,vendor_custom__r.Vendor_Code__c,Vendor_Name__c,SKU_Code__c,Photo__c,name,Product_Category_Taneira__c,Cluster__c,Quantity__c,Buyers_Cost__c,Base_Colour__c from product__c where Product_Key_Finder__c = :Keyfinder  ORDER BY SKU_Code__c ASC];
        }
        }
        else{
            proList = [select id,Product_Key_Finder__c,vendor_custom__r.Vendor_Code__c,Vendor_Name__c,SKU_Code__c,Photo__c,name,Product_Category_Taneira__c,Cluster__c,Quantity__c,Buyers_Cost__c,Base_Colour__c from product__c ORDER BY SKU_Code__c ASC ];
            string description;
            description = 'Contoller of VF page';
        }
        
    }
}