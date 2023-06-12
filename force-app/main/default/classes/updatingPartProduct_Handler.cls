public class updatingPartProduct_Handler {
    public static void updateParts(List<SQX_Part__c>listParts){
        
        Set<String> partNames = new Set<String>();
        Set<String> partNumbers = new Set<String>();
        
        for (SQX_Part__c part : listParts) {
            if (String.isBlank(part.Product__c)) {
                partNames.add(part.Name);
                partNumbers.add(part.Part_Number__c);
            }
        }
        
        // Query existing products based on part names and numbers
        Map<String, Product2> existingProducts = new Map<String, Product2>();
        for (Product2 product : [SELECT Id, Name, ProductCode FROM Product2 WHERE Name IN :partNames AND ProductCode IN :partNumbers]) {
            existingProducts.put(product.Name + '_' + product.ProductCode, product);
        }
        
        // Iterate through parts again to update product references
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
        /*runPartProduct run= new runPartProduct();  //This will call schedulable class
string cronExp='0 0 6 * * ?';

system.schedule('Myjob', cronExp, run);*/
        
        
    }
    
}