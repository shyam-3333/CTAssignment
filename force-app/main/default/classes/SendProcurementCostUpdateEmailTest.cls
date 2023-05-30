@isTest
private class SendProcurementCostUpdateEmailTest {

    private static testMethod void updateProduct(){
        Product__c product = new Product__c();
        product.PO_Number__c='987456';
        product.Collection__c='123456';
        product.Procurement_Cost__c=5000;
       
        insert product;
         product.Stage__c='Category';
        product.Procurement_Cost__c=6000;
        product.Old_Procurement_Cost__c=5000;
        product.category_user_email__c='ABC@gmail.com';
        update product;
        
         
    }

}