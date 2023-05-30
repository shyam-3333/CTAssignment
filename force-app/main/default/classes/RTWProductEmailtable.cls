public class RTWProductEmailtable {
    public list<RTW_Product__c> proList{get;set;}
    public RTWProductEmailtable(){
        string ProductKey = apexpages.currentpage().getparameters().get('ProductKey');
        system.debug('keyFinder==>'+ProductKey);
        If(!test.isRunningTest()){
            if(ProductKey != null && ProductKey != ''){
            proList = [select id,name,vendor_custom__r.Name,SKU__c,Photo__c,Product__c,Quantity__c,Buyers_Cost__c from RTW_Product__c where name = :ProductKey];
        }
        }
        else{
            proList = [select id,vendor_custom__r.Name,SKU__c,Photo__c,name,Product__c,Quantity__c,Buyers_Cost__c from RTW_Product__c];
            string description;
            description = 'Contoller of VF page';
        }
        
    }

}