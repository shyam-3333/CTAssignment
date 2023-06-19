@isTest
public class pimaryContactHandler_test {

    @isTest
    static void testGetPrimaryContact() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact = new Contact(AccountId = testAccount.Id, FirstName = 'Test', LastName = 'Contact', Primary_Contact__c = true);
        insert testContact;
        
        // Call the method under test
        List<Contact> result = PimaryContactHnadler.getPrimaryContact(testAccount.Id);
        
        // Perform assertions
        System.assertEquals(1, result.size());
        Contact returnedContact = result[0];
        System.assertEquals(testContact.Id, returnedContact.Id);
        System.assertEquals(testContact.AccountId, returnedContact.AccountId);
        System.assertEquals(testContact.FirstName, returnedContact.FirstName);
        System.assertEquals(testContact.LastName, returnedContact.LastName);
        System.assertEquals(testContact.Name, returnedContact.Name);
        System.assertEquals(testContact.Primary_Contact__c, returnedContact.Primary_Contact__c);
        // Additional assertions based on expected behavior
    }
    
    @isTest
    static void testContactsPrimaryCheckbox() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact1 = new Contact(AccountId = testAccount.Id, FirstName = 'Test1', LastName = 'Contact1');
        Contact testContact2 = new Contact(AccountId = testAccount.Id, FirstName = 'Test2', LastName = 'Contact2');
        insert new List<Contact>{testContact1, testContact2};
        
        List<Contact> contactList = [SELECT Id, Primary_Contact__c FROM Contact WHERE AccountId = :testAccount.Id];
        
        // Call the method under test
        String result = PimaryContactHnadler.contactsprimarycheckbox(testContact2.Id, contactList);
        
        // Perform assertions
        System.assertEquals('success', result);
        
        // Verify updated contacts
        List<Contact> updatedContacts = [SELECT Id, Primary_Contact__c FROM Contact WHERE AccountId = :testAccount.Id];
        System.assertEquals(2, updatedContacts.size());
        
        /*for (Contact contact : updatedContacts) {
            if (contact.Id == testContact2.Id) {
                System.assertTrue(contact.Primary_Contact__c);
            } else {
                System.assertFalse(contact.Primary_Contact__c);
            }
        }*/
        
        // Verify updated account
        Account updatedAccount = [SELECT Id, Customer_Primary_Contact__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(testContact2.Name, updatedAccount.Customer_Primary_Contact__c);
        
        // Additional assertions based on expected behavior
    }
}