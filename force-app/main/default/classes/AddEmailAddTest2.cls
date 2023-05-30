/*@istest
public class AddEmailAddTest2 {
    
    @testsetup
    public static void testData(){
        Account acc= new account();
        acc.name='AccName';
        acc.Recipient_Email_Address__c='abc@gmail.com';
        insert acc;
        
        Contact con= new Contact();
        con.lastname='ConName';
        con.Email='xyz@gmail.com';
        con.Primary_contact__c=true;
        con.AccountID=acc.ID;
        insert con;
        
    }
    @istest
    public static void testFieldUpdate(){
        
    }
    

}*/
@isTest
public class AddEmailAddTest2 {
    @isTest
    public static void testFieldUpdate() {
        // Test data setup
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(AccountId = testAccount.Id, LastName = 'Test Contact', Primary_contact__c = true, Email = 'test@example.com');
        insert testContact;

        AddEmailAddressCont.fieldUpdate(testAccount.Id);

        // Verify the changes made by fieldUpdate method
        testAccount = [SELECT Verification_Sent_On__c, Recipient_Email_Address__c, Customer_Primary_Contact__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(System.now().date(), testAccount.Verification_Sent_On__c.date(), 'Verification_Sent_On__c should be populated');
        System.assertNotEquals(null, testAccount.Recipient_Email_Address__c, 'Recipient_Email_Address__c should not be null');
        System.assertNotEquals(null, testAccount.Customer_Primary_Contact__c, 'Customer_Primary_Contact__c should not be null');

        // Verify the emails sent
        List<Task> tasks = [SELECT Subject, WhoId, WhatId, Description FROM Task WHERE WhatId = :testAccount.Id];
        System.assertEquals(2, tasks.size(), 'Two emails should be sent');
        System.assertEquals('Email Template 1', tasks[0].Subject, 'Subject of the first email should be correct');
        System.assertEquals('Email Template 2', tasks[1].Subject, 'Subject of the second email should be correct');
        System.assertEquals(testAccount.Id, tasks[0].WhatId, 'WhatId of the first email should be the Account Id');
        System.assertEquals(testAccount.Id, tasks[1].WhatId, 'WhatId of the second email should be the Account Id');
    }

    @isTest
    public static void testSendVerification() {
        // Test data setup
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        String otherEmails = 'test1@example.com, test2@example.com';
        Boolean result = AddEmailAddressCont.sendVerification(otherEmails, testAccount.Id);

        // Verify the result of sendVerification method
        System.assertEquals(true, result, 'Result should be true');

        // Verify the email sent
        List<Task> tasks = [SELECT Subject, WhoId, WhatId, Description FROM Task WHERE WhatId = :testAccount.Id];
        System.assertEquals(1, tasks.size(), 'One email should be sent');
        System.assertEquals('Email Template 2', tasks[0].Subject, 'Subject of the email should be correct');
        System.assertEquals(testAccount.Id, tasks[0].WhatId, 'WhatId of the email should be the Account Id');
        System.assertEquals('test1@example.com, test2@example.com', tasks[0].Description, 'Description of the email should contain the correct email addresses');
    }
}