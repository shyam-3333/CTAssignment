Global class runPartProduct Implements schedulable{
    global void execute(schedulableContext sc){
       /*updatingPartProductBatch_Handler run= new updatingPartProductBatch_Handler();//This will call Batch Class
        database.executeBatch(run,100);
        System.debug('This is Schedulable Class');*/
        List<SQX_Part__c>listParts= new List<SQX_Part__c>();
        Set<String> partNames = new Set<String>();
        Set<String> partNumbers = new Set<String>();

    for (SQX_Part__c part : listParts) {
        if (String.isBlank(part.Product__c)) {
            partNames.add(part.Name);
            partNumbers.add(part.Part_Number__c);
        }
        Product2 newProduct = new Product2(
                    Name = part.Name,
                    ProductCode = part.Part_Number__c
                );
        insert newProduct;
                part.Product__c = newProduct.Id;
    }
        
                

    // Query existing products based on part names and numbers
    /*Map<String, Product2> existingProducts = new Map<String, Product2>();
    for (Product2 product : [SELECT Id, Name, ProductCode FROM Product2 WHERE Name IN :partNames AND ProductCode IN :partNumbers]) {
        existingProducts.put(product.Name + '_' + product.ProductCode, product);
    }

    // Iterate through parts again to update product references
    for (SQX_Part__c part : listParts) {
        if (String.isBlank(part.Product__c)) {
            String productKey = part.Name + '_' + part.Part_Number__c;
            Product2 existingProduct = existingProducts.get(productKey);

            if (existingProduct != null) {
                //part.Product__c = existingProduct.Id;
                
                
            } else {
                Product2 newProduct = new Product2(
                    Name = part.Name,
                    ProductCode = part.Part_Number__c
                );
                insert newProduct;
                part.Product__c = newProduct.Id;
            }
            
        }
    }*/
}
        
            }