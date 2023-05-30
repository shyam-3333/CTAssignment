@istest
public class EV_PrimaryContact_HandlerTest {
         
    @istest
    public static void getPrimaryContactTest(){
       
        // Create TEst Data
        Account acc = new Account(Name = 'Test acc');
        insert acc;

        Contact con1 = new Contact(AccountId = acc.Id, FirstName = 'Sachin', LastName = 'Tendulkar', Primary_Contact__c = true);
        Contact con2 = new Contact(AccountId = acc.Id, FirstName = 'Rahul', LastName = 'Dravid', Primary_Contact__c = false);
        insert new List<Contact>{con1, con2};

        // Call the getPrimaryContact method
        List<Contact> Conlist = EV_PrimaryContact_Handler.getPrimaryContact(acc.Id);

        // Perform Assertions
        System.assertEquals(2, Conlist.size(), 'The result should contain 2 contacts');
        System.assertEquals(true, Conlist[0].Primary_Contact__c, 'The first contact should be marked as primary');
        System.assertEquals(false, Conlist[1].Primary_Contact__c, 'The second contact should not be marked as primary');
    

    }
    @istest
    public static void contactsprimarycheckboxTest(){
     
       // Create Test Data
        Account acc = new Account(Name = 'Test acc');
        insert acc;

        Contact con1 = new Contact(AccountId = acc.Id, FirstName = 'Sachin', LastName = 'Tendulkar', Primary_Contact__c = true);
        Contact con2 = new Contact(AccountId = acc.Id, FirstName = 'Rahul', LastName = 'Dravid', Primary_Contact__c = false);
        insert new List<Contact>{con1, con2};

        // Call the contactsprimarycheckbox method
        String result = EV_PrimaryContact_Handler.contactsprimarycheckbox(con2.Id, new List<Contact>{con1, con2});

        // Perform Assertion
        System.assertEquals('success', result, 'Result should be "success"');

        // Verify the changes made by contactsprimarycheckbox method
        List<Contact> updatedContacts = [SELECT Id, Primary_Contact__c FROM Contact WHERE AccountId = :acc.Id];
        System.assertEquals(false, updatedContacts[0].Primary_Contact__c, 'The first contact should not be marked as primary');
        System.assertEquals(true, updatedContacts[1].Primary_Contact__c, 'The second contact should be marked as primary');

        Account updatedAccount = [SELECT Id, Customer_Primary_Contact__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Rahul Dravid', updatedAccount.Customer_Primary_Contact__c, 'Customer_Primary_Contact__c field on Account should be updated');
    }
    
     @isTest
    public static void ContactsPrimaryCheckbox_FailureTest() {
        // Create Test data setup
        Contact con = new Contact();
        // Do not insert the contact to check an exception

        // Call the contactsprimarycheckbox method
        String result = EV_PrimaryContact_Handler.contactsprimarycheckbox(con.Id, new List<Contact>{con});

        // Verify the result
        System.assertEquals('Failure', result, 'Result should be "Failure"');
    }
}