@isTest
public class productpageComingSoon_Test{
    static testMethod void productTest(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c prod = new Product__c();
        prod.recordTypeId = recordTypeId;
        Test.startTest();
        PageReference pageRef = Page.Product_Page_Coming_Soon; 
        pageRef.getParameters().put('AccontId', '');
       
        Test.setCurrentPage(pageRef);
        productpageComingSoon prodCont = new productpageComingSoon();
        prodCont.doRedirect();
        Test.stopTest();
    }
}