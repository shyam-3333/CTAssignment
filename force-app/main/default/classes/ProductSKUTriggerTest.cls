@isTest(seeAllData = false)
public class ProductSKUTriggerTest {

    private static testMethod void productTriggerCoverage() {
        Product_Master__c product = ProposalToolTestDataFactory.createProduct('Eyewear', 'Test');
        String watchesRecordsTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Watches').getRecordTypeId();
        String jewelRecordsTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Bags');
        update new Product_Master__c(Id=product.Id,RecordTypeId=jewelRecordsTypeId,Product_Category__c='Silver Coin');
        System.assertEquals('Test', product.Name__c);
    }
}