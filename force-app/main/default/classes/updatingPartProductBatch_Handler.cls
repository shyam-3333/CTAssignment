public class updatingPartProductBatch_Handler Implements database.batchable <Sobject> {
    
    Public database.querylocator start(database.batchableContext info){
        string query='Select ID,NAme,Part_Number__c,SQX_Part__c.Product__c From SQX_Part__c';
        return database.getqueryLocator(Query);
    }
    
    Public void execute(database.batchableContext info, List<SQX_Part__c>listParts){
        Set<String> partNames = new Set<String>();
        Set<String> partNumbers = new Set<String>();
        
        for (SQX_Part__c part : listParts) {
            if (String.isBlank(part.Product__c)) {
                partNames.add(part.Name);
                partNumbers.add(part.Part_Number__c);
            }
        }
        
        // Query existing products based on part names and numbers.
        Map<String, Product2> existingProducts = new Map<String, Product2>();   
        for (Product2 product : [SELECT Id, Name, ProductCode FROM Product2 WHERE Name IN :partNames AND ProductCode IN :partNumbers]) {
            existingProducts.put(product.Name + '_' + product.ProductCode, product);
            
        }
        
        // Iterate through parts again to update product references.
        for (SQX_Part__c part : listParts) {
            if (String.isBlank(part.Product__c)) {
                String productKey = part.Name + '_' + part.Part_Number__c;
                Product2 existingProduct = existingProducts.get(productKey);
                
                if (existingProduct != null) {
                    part.Product__c = existingProduct.Id;
                } else {
                    Product2 newProduct = new Product2(
                        Name = part.Name,
                        ProductCode = part.Part_Number__c
                    );
                    insert newProduct;
                    part.Product__c = newProduct.Id;
                }
                
            }
        }
        //update listparts;
    }
    Public void finish(database.batchableContext info){
        System.debug('This is Batch Class');
    }
    
}