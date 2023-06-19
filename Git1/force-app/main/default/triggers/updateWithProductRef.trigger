trigger updateWithProductRef on SQX_Part__c (before insert) {
    Set<String> partNames = new Set<String>();
    Set<String> partNumbers = new Set<String>();

    for (SQX_Part__c part : Trigger.new) {
        partNames.add(part.Name);
        partNumbers.add(part.Part_Number__c);
    }

    Map<String, Product2> productsByPartName = new Map<String, Product2>([SELECT Id, Name FROM Product2 WHERE Name IN :partNames]);
    Map<String, Product2> productsByPartNumber = new Map<String, Product2>([SELECT Id, Name FROM Product2 WHERE ProductCode IN :partNumbers]);

    List<SQX_Part__c> partsToUpdate = new List<SQX_Part__c>();

    for (SQX_Part__c part : Trigger.new) {
        String partName = part.Name;
        String partNumber = part.Part_Number__c;

        if (productsByPartName.containsKey(partName)) {
            // Product already exists, update the Part record with the product reference
            Product2 existingProduct = productsByPartName.get(partName);
            part.Product__c = existingProduct.Id;
            partsToUpdate.add(part);
        } else if (productsByPartNumber.containsKey(partNumber)) {
            // Product already exists, update the Part record with the product reference
            Product2 existingProduct = productsByPartNumber.get(partNumber);
            part.Product__c = existingProduct.Id;
            partsToUpdate.add(part);
        } else {
            // Create a new product record and update the Part record with the new product reference
            Product2 newProduct = new Product2(
                Name = part.Name,
                ProductCode = part.Part_Number__c
                // Set additional fields as needed
            );
            insert newProduct;
            part.Product__c = newProduct.Id;
            partsToUpdate.add(part);
        }
    }

    // Perform bulk update of the Part records
    if (!partsToUpdate.isEmpty()) {
        update partsToUpdate;
    }

}