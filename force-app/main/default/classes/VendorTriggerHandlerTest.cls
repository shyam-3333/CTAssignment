/*
 Created By   : Mutturaj Heroor
 Created Date : 15/10/2020
 Test Class Name   : VendorTriggerHandlerTest
*/
@isTest
public class VendorTriggerHandlerTest{
    static testMethod void accountTest(){
        Id prodTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        
        AutoNumber__c auto = new AutoNumber__c();
        auto.Auto_Number__c = 0;
        auto.Name = 'SKU_Number';
        insert auto;
        
        Vendor__c vend = new Vendor__c();
        vend.name = 'Test';
        vend.Mail_ID__c = 'test@gmail.com';
        vend.Mobile_Phone__c = '8722348910';
        vend.vendor_code__c = 'asd';
        
        insert vend;
        
       
        
        Product__c pro = new Product__c();
        pro.Name = 'Test';
        pro.Vendor_custom__c = vend.id;
        pro.RecordTypeId = prodTypeId;
        pro.cost__c = 123;
        pro.Quantity__c= 123;
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Handloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Zari_Type__c = 'Silk';
        pro.Body_Pattern__c = 'Chunri Buti';
        pro.Border_Pattern__c = 'Ganga Jamuna';
        pro.Pallu_Pattern__c = 'Contrast';
        pro.Base_Colour__c = 'Green';
        pro.Zari_Type__c = 'Tested';
        pro.Proc_Type__c = 'Trading (buy and sell)';
        
        insert pro;
        
        //vend.Description = 'Test';
        vend.Vendor_Code__c = '123sd';
        update vend;
     
    }
}