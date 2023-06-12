@IsTest
public class updatingPartProduct_Test {
 @IsTest
    static void testUpdatePartProductReference() {
        // Create test Part records
        List<SQX_Part__c> parts = new List<SQX_Part__c>();
        parts.add(new SQX_Part__c(Name = 'Part 1', Part_Number__c = '001', Product__c = null));
        parts.add(new SQX_Part__c(Name = 'Part 2', Part_Number__c = '002', Product__c = null));
        insert parts;
        
        // Create test Product records.
        Product2 existingProduct1 = new Product2(Name = 'Part 1', ProductCode = '123');
        Product2 existingProduct2 = new Product2(Name = 'Part 2', ProductCode = '456');
        insert new List<Product2>{existingProduct1, existingProduct2};
            
            Test.startTest();
        // Test the updateParts method
        updatingPartProduct_Handler.updateParts(Parts);
        
        // Update the Part records to trigger the trigger logic.
        List<SQX_Part__c> updatedParts = new List<SQX_Part__c>();
        for (SQX_Part__c part : parts) {
            part.Name = 'Updated ' + part.Name;
            part.Part_Number__c = '00' + part.Part_Number__c;
            updatedParts.add(part);
        }
        update updatedParts;
        
        
        
        // Verify that the Part records have been updated with product references
        List<SQX_Part__c> updatedPartsCheck = [SELECT Id, Product__c FROM SQX_Part__c WHERE Id IN :parts];
        for (SQX_Part__c part : updatedPartsCheck) {
            //System.assertNotEquals(null, part.Product__c, 'Product reference not updated for Part: ' + part.Name);
            System.assertEquals(existingProduct1.Id, updatedParts[0].Product__c);
            System.assertEquals(existingProduct2.Id, updatedParts[1].Product__c);
            Test.stopTest();
        }
    }
}