global with sharing class UpdateVendorPricingFieldBatch implements Database.Batchable<sObject>{
    //public static Map<String,String> pricingTypeMap = new Map<String,String>();//{'AGGREGATOR'=>'C','MASTER WEAVER'=>'B','DESIGNER'=>'D','WEAVER'=>'A'};
    //public static  Map<String,UpdateVendorPricingField__c> getPricingType = UpdateVendorPricingField__c.getAll();
    //public static List<UpdateVendorPricingField__c> pricingFieldLst = new List<UpdateVendorPricingField__c>();
   
    
    global Database.queryLocator start(Database.BatchableContext bc){
       // Id vendorRecType =Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        //System.debug('vendorRecType:: '+vendorRecType);
        return Database.getQueryLocator('SELECT ID,Name,Category__c,Pricing_Type__c FROM vendor__c WHERE Category__c !=NULL AND Category__c !=\'\'');
    }
    global void execute(Database.BatchableContext bc , List<sObject> scope){
        Map<String,String> pricingTypeMap = new Map<String,String>();
        Map<String,UpdateVendorPricingField__c> getPricingType = UpdateVendorPricingField__c.getAll();
        List<UpdateVendorPricingField__c> pricingFieldLst = new List<UpdateVendorPricingField__c>();
        pricingFieldLst.addAll(getPricingType.values());
        for(UpdateVendorPricingField__c pricing : pricingFieldLst){
            pricingTypeMap.put(pricing.Vendor_Type__c.toUpperCase(),pricing.Pricing_Type_Code__c.toUpperCase());
        }
        System.debug('scope:: '+scope);
        System.debug('pricingTypeMap:: '+pricingTypeMap);
        List<vendor__c> scopeList = new List<vendor__c>();
        scopeList =(List<vendor__c>)scope;
        List<vendor__c> accList = new List<vendor__c>();
        vendor__c accObj;
        for(vendor__c each : scopeList){
                //accObj = new Account();
                accObj = each;
                if(pricingTypeMap.containsKey(accObj.Category__c.toUpperCase())){
                    accObj.Pricing_Type__c = pricingTypeMap.get(accObj.Category__c.toUpperCase());
                }
                accList.add(accObj);
        }
        System.debug('accList:: '+accList);
        if(accList.size()>0){
            Database.update(accList,False);
        }
    }
    global void finish(Database.BatchableContext bc){

    }
    
}