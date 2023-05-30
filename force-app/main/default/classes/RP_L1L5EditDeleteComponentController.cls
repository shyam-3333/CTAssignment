/*******************************************
Created By : Chakresh Verma,Vindya Achar
@description: This class will fetch and display all the active L1-L5 Master records , Url redirection onclick of Name and it will delete the selcted records.
**********************************************/
public with sharing class RP_L1L5EditDeleteComponentController {
    @AuraEnabled
   /* @description: This method will Fetch the active L1-L5 Master records*/
    public static List<DataTableWrapper> getL1L5Master() {        
        List<L1_L5_Master__c> masterList = new List<L1_L5_Master__c> ();
        if (L1_L5_Master__c.sObjectType.getDescribe().isAccessible()) {
            masterList = [SELECT Id, Name,Product_Category_1__c,Product_category_value_1__c,Product_Category_2__c,Product_category_value_2__c,Product_Category_3__c,Product_category_value_3__c,Product_Category_4__c,Product_category_value_4__c,Precedence__c,L1__c,L2__c,L3__c,L4__c,L5__c,Active__c FROM L1_L5_Master__c where Active__c = true  Order By CreatedDate DESC];            
        }
        List<DataTableWrapper> listToComponent = new List<DataTableWrapper>();
        for (L1_L5_Master__c l1l5Master : masterList) {
            DataTableWrapper obj = new DataTableWrapper();
            obj.name = l1l5Master.Name;
            obj.isDelete = false;
            obj.nameUrl = '/'+l1l5Master.Id;
            obj.l1obj = l1l5Master;
            obj.recordId = l1l5Master.Id;
            obj.ruleNo= l1l5Master.Precedence__c;
            obj.ProductCategory1 = l1l5Master.Product_Category_1__c;
            obj.ProductCategory2 = l1l5Master.Product_Category_2__c;
            obj.ProductCategory3 = l1l5Master.Product_Category_3__c;
            obj.ProductCategory4 = l1l5Master.Product_Category_4__c;
            obj.ProductCategoryValue1 = l1l5Master.Product_category_value_1__c;
            obj.ProductCategoryValue2 = l1l5Master.Product_category_value_2__c;
            obj.ProductCategoryValue3 = l1l5Master.Product_category_value_3__c;
            obj.ProductCategoryValue4 = l1l5Master.Product_category_value_4__c;
            obj.l1 = l1l5Master.L1__c;
            obj.l2 = l1l5Master.L2__c;
            obj.l3 = l1l5Master.L3__c;
            obj.l4 = l1l5Master.L4__c;
            obj.l5 = l1l5Master.L5__c;
            obj.active = l1l5Master.Active__c;
            listToComponent.add(obj);
        }
        return listToComponent;
    }
    /* @description: This method will delete the selected L1-L5 master records*/
    @AuraEnabled
    public static string deleteL1L5Master( String jsonData ) {
        List<DataTableWrapper> dataWrapper = (List < DataTableWrapper >)JSON.deserialize(jsonData, List<DataTableWrapper>.class);
        System.debug('dataWrapper'+dataWrapper);
        String returnData = '';
        List<L1_L5_Master__c> dataToDelete = new List<L1_L5_Master__c>();
        for(DataTableWrapper data1 : dataWrapper){
            if(data1.isDelete){
                dataToDelete.add(new L1_L5_Master__c(Id = data1.recordId));
                returnData+=data1.Name;
                System.debug('isDelete--> '+data1.Name);
            }
        }
        try {
            if(L1_L5_Master__c.SObjectType.getDescribe().isDeletable()){
                 delete dataToDelete;
            }
           
            return returnData;
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
    /* @description: Wrapper class to display the values in table*/
    Public class DataTableWrapper {
        @AuraEnabled public L1_L5_Master__c l1obj {get;set;}
        @AuraEnabled public String nameUrl {get;set;}
        @AuraEnabled public String recordId {get;set;}
        @AuraEnabled public String name {get;set;}
        @AuraEnabled public String ruleNo {get;set;}
        @AuraEnabled public String productCategory1 {get;set;}
        @AuraEnabled public String productCategory2 {get;set;}
        @AuraEnabled public String productCategory3 {get;set;}
        @AuraEnabled public String productCategory4 {get;set;}
        @AuraEnabled public String productCategoryValue1 {get;set;}
        @AuraEnabled public String productCategoryValue2 {get;set;}
        @AuraEnabled public String productCategoryValue3 {get;set;}
        @AuraEnabled public String productCategoryValue4 {get;set;}
        @AuraEnabled public String l1 {get;set;}
        @AuraEnabled public String l2 {get;set;}
        @AuraEnabled public String l3 {get;set;}
        @AuraEnabled public String l4 {get;set;}
        @AuraEnabled public String l5 {get;set;}
        @AuraEnabled public Boolean active {get;set;}
        @AuraEnabled public Boolean isDelete;
    }
}