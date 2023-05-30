@isTest
public class productNewButtonOveride_Test{
    static testMethod void newButtonTest(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c prod = new Product__c();
        prod.recordTypeId = recordTypeId;
        Test.startTest();
        PageReference pageRef = Page.ProductNewButtonOverride; 
        pageRef.getParameters().put('RecordType', prod.recordTypeId);
        //pageRef.getParameters().put('Source', 'New');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(prod);
        ProductNewButtonOverride prodCont = new ProductNewButtonOverride(sc);
        prodCont.source = 'New';
        Test.stopTest();
    }
}