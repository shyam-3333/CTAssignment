/*************************************************************
* Created by: Vinoth Kumar A
* Created on: 04/03/2019
* Description: Test class to test ProductEmailSchedulerClass 
* ************************************************************/ 
@isTest
public class TestProductEmailSchedulerClass {
    @isTest public static void testemail(){
        Test.StartTest();
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c ='8762921827' ;
        acc.Mail_ID__c = 'Muttu@gmail.com';
        insert acc;
        
        Product__c prd = new Product__c();
        prd.Name = 'ApprovalRequestTest1';
        prd.RE_ORDER__c = FALSE;
        prd.Product_Category_Taneira__c = 'Saree';
        prd.Cluster__c = 'BANARAS';
        prd.Taneira_Material_Weft__c = 'SILK';
        prd.Material_Wrap__c = 'SILK';
        prd.Workmanship__c = 'Ikkat';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 3;
        prd.Cost__c = 50;
        prd.Loom__c = 'Handloom';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        insert prd;
        
        prd.RE_ORDER__c = TRUE;
        update prd;
        
        ProductEmailBatchClass b = new ProductEmailBatchClass(); 
        database.executebatch(b);
        
        ProductEmailSchedulerClass sch = new ProductEmailSchedulerClass();
        String CT = '0 0 19 * * ?';
        system.schedule('Product re-order email daily by 7PM', CT, sch);
        Test.stopTest();
    }
    
}