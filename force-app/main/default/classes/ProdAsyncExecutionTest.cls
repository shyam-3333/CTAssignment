/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			12/03/2019   T01   0% code for ProdAsyncExecution
*/
@isTest
public class ProdAsyncExecutionTest {
     @isTest static void testexecute() {
        list<Master__c> masterList = new List<Master__c>();
        list<vendor__c> accountList = new List<vendor__c>();
        list<Product__c> productList = new List<Product__c>();
         
        AutoNumber__c atNum = new AutoNumber__c();
        atNum.Auto_Number__c = 0;
        atNum.Name = 'SKU_Number';
        insert atNum;
    
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        vendor__c acc = new vendor__c();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        //acc.RecordTypeId = recordTypeIdAcc;
        insert acc;
            
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();
        pro.Name = 'Test Prod';
        pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Handloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        insert pro;
         
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Color';
        mas.Active__c  = True ;
        mas.Code__c ='R';
        masterList.add(mas);
         //<T01>
         Set<Id> proId = new Set<Id>();
         proId.add(pro.id);
         ProdAsyncExecution proObj = new ProdAsyncExecution(proId);
         System.enqueueJob(proObj);
         //</T01>
    }
}