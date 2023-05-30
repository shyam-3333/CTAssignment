@isTest
public class AccountTriggerHandler_Test{
   static testMethod void accountTest(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Id prodTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        
        AutoNumber__c auto = new AutoNumber__c();
        auto.Auto_Number__c = 0;
        auto.Name = 'SKU_Number';
        insert auto;
        
        Account acc = new Account();
        acc.name = 'Test';
        acc.Mail_ID__c = 'test@gmail.com';
        //acc.Mobile_Phone__c = '8722348910';
        acc.vendor_code__c = 'asd';

        acc.RecordTypeId = recordTypeId;
        insert acc;
        
       
        
        Product__c pro = new Product__c();
        pro.Name = 'Test';
        pro.Account__c = acc.id;
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
        
        acc.Description = 'Test';
        acc.Vendor_Code__c = '123sd';
        update acc;
     
       AccountTriggerHandler.accountAfterUpdate(null, null);
       AccountTriggerHandler.accountBeforeInsert(null);
    }
}