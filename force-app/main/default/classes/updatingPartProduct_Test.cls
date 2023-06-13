@IsTest
public class updatingPartProduct_Test {
    @IsTest
    static void updatePartProductTestForAdmin() {
        // Create test Part records.
        List<SQX_Part__c> parts = new List<SQX_Part__c>();
        parts.add(new SQX_Part__c(Name = 'Part 1', Part_Number__c = '001', Product__c = null));
        parts.add(new SQX_Part__c(Name = 'Part 2', Part_Number__c = '002', Product__c = null));
        insert parts;
        
        // Create test Product records
        Product2 existingProduct1 = new Product2(Name = 'Part 1', ProductCode = '123');
        Product2 existingProduct2 = new Product2(Name = 'Part 2', ProductCode = '456');
        insert new List<Product2>{existingProduct1, existingProduct2};
            
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'SKhad', Email='testabc@testorg.com', EmailEncodingKey='UTF-8', 
                          LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='onlineforms@testorg.com');
        
        Test.startTest();
        system.runAs(U){
            // Test the updateParts method
            updatingPartProduct_Handler.updateParts(Parts);
            // Update the Part records to trigger the trigger logic
            List<SQX_Part__c> updatedParts = new List<SQX_Part__c>();
            for (SQX_Part__c part : parts) {
                part.Name = 'Updated ' + part.Name;
                part.Part_Number__c = '00' + part.Part_Number__c;
                updatedParts.add(part);
            }
            update updatedParts;
            
            Test.stopTest();
            
               
                	
            }
        }
            
    @IsTest
    static void updatePartProductTestForUser() {
        // Create test Part records.
        List<SQX_Part__c> parts = new List<SQX_Part__c>();
        parts.add(new SQX_Part__c(Name = 'Part 1', Part_Number__c = '001', Product__c = null));
        parts.add(new SQX_Part__c(Name = 'Part 2', Part_Number__c = '002', Product__c = null));
        insert parts;
        
        // Create test Product records
        Product2 existingProduct1 = new Product2(Name = 'Part 1', ProductCode = '123');
        Product2 existingProduct2 = new Product2(Name = 'Part 2', ProductCode = '456');
        insert new List<Product2>{existingProduct1, existingProduct2};
            
            Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u1 = new User(Alias = 'sk1', Email='testabc1@abc.com', EmailEncodingKey='UTF-8', 
                          LastName='sdk2', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p1.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='test3@abc.com');
        
        Test.startTest();
        system.runAs(U1){
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
            
          Test.stopTest();	
            }
        }
    }