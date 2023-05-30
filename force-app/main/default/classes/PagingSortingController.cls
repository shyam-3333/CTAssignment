global class PagingSortingController {
    @AuraEnabled 
    global static Product__c[] getProducts() {
        return [SELECT Id, Name, Vendor_Name__c, Product_Category_Taneira__c, SKU_Code__c FROM Product__c];
    }
}