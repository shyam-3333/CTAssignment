@isTest
public class ProposalToolTestDataFactory {
    
    public static Product_Master__c createProduct(String recordType,String category){
        
        Product_Master__c product = new Product_Master__c();
        product.sku__c = 'Test';
        product.Base_Sku__c = 'Base_Code';
        product.Sellable_SKU__c = '12345';
        product.Name__c = 'Test';
        product.price__c =10;
        product.Offer_Price__c =10;        
        product.List_Price__c =10;
        product.Title__c ='test';
        product.frame_gender__c = 'Men';
        product.attribute_set_name__c = category;
        product.categories__c = category;
        product.Product_Category__c = category;
        product.Product_To_Show__c = true;
        product.All_Images__c = 'Test.jpg';
        product.images__c = 'Test.jpg';
        
        
        product.brand__c= 'r';
        product.RecordTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
        product.attribute_set_name__c = 'Sunglasses';
        insert product;
        
        Product_SKU__c productSKU = new Product_SKU__c();
        productSKU.Product_Master__c = product.Id;
        productSKU.Base_Sku__c = product.sku__c;
        productSKU.sku__c = 'Test';
        
        productSKU.Offer_price__c = 10;
        productSKU.List_price__c = 11;
        insert productSKU;
        return product;
    }
    
    public static Proposal_Tool_Filter__c createProposalFilter(String productType,String typeOfFilter){
        
        Proposal_Tool_Filter__c propFilter = new Proposal_Tool_Filter__c();
        propFilter.Label__c ='test123';
        propFilter.Value__c = 'test123';
        propFilter.Product_Type__c = productType;
        propFilter.Type_Of_Filter__c= typeOfFilter;
        insert propFilter;
        return propFilter;
        
    }
    
    
    public static Product_Master__c createProductForAWS(String recordType,String category){
        
        Product_Master__c product = new Product_Master__c();
        product.sku__c = 'Test';
        product.Base_Sku__c = 'Base_Code';
        
        product.Sellable_SKU__c = '12345';
        product.Name__c = 'Test';
        product.price__c =10;
        product.Offer_Price__c =10;        
        product.List_Price__c =10;
        product.Title__c ='test';
        product.frame_gender__c = 'Men';
        product.attribute_set_name__c = category;
        product.categories__c = category;
        product.Product_Category__c = category;
        product.Product_To_Show__c = true;
        product.All_Images__c = 'Test.jpg';
        product.images__c = 'Test.jpg';
        
        
        product.brand__c= 'r';
        product.RecordTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
        product.attribute_set_name__c = 'Sunglasses';
        insert product;
        
        Product_SKU__c productSKU = new Product_SKU__c();
        productSKU.Product_Master__c = product.Id;
        productSKU.Base_Sku__c = product.sku__c;
        productSKU.sku__c = 'Test';
        
        productSKU.Offer_price__c = 10;
        productSKU.List_price__c = 11;
        //insert productSKU;
        return product;
    }
    
    public static AWS_Configuration__c createAWSConfig(String className){
        
        AWS_Configuration__c awsConfig = new AWS_Configuration__c();
        awsConfig.Name = className;
        awsConfig.Number_of_days_to_be_deducted__c = -1;
        insert awsConfig;
        return awsConfig;
        
    }
}