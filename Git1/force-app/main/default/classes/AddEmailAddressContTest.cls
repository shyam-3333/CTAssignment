@isTest
private class AddEmailAddressContTest {

    /*@isTest
    static void testFieldUpdate() {
        // Create test data
        Account Acc = new Account(Name = 'Test Account', Recipient_Email_Address__c = 'test@example.com');
        insert Acc;
        
        Contact testContact = new Contact(AccountId = acc.Id, lastName = 'Test Contact', Email = 'testRecipiant@example.com', Primary_contact__c = true );
        insert testContact;
        
        // Call the method being tested
        Test.startTest();
        String errorMessage = AddEmailAddressCont.fieldUpdate(acc.Id);
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals('', errorMessage, 'Error message should be empty');
        
        // Retrieve the updated Account record
        Account updatedAccount = [SELECT Id, Verification_Sent_On__c FROM Account WHERE Id = :acc.Id];
        
        // Perform assertions on the updated record
        System.assertNotEquals(null, updatedAccount.Verification_Sent_On__c, 'Verification_Sent_On__c field should be populated');
    
    /////
    
        
        // Set up email template IDs and primary contact email
        String emailTemplateId1 = 'templateId1';
        String emailTemplateId2 = 'templateId2';
        String primaryContactEmail = 'primarycontact@example.com';
        
        // Test when Recipient_Email_Address__c is not blank
        //Test.startTest();
        acc.Recipient_Email_Address__c = 'test@example.com';
        insert acc;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{acc.Recipient_Email_Address__c});
        mail.setTemplateId(emailTemplateId1);
        mail.setWhatId(acc.Id);
        mail.setTreatTargetObjectAsRecipient(false);
        mail.setTargetObjectId('0035i00000TJFvdAAH');
        mail.setSaveAsActivity(false);
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        emails.add(mail);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        //Test.stopTest();
        
        // Assert that the email was sent successfully
        System.assertEquals(1, results.size());
        System.assertEquals(true, results[0].isSuccess());
        
        // Test when Recipient_Email_Address__c is blank
        //Test.startTest();
        acc.Recipient_Email_Address__c = '';
        insert acc;
        
        emails.clear();
        
        try {
            Messaging.sendEmail(emails);
        } catch (Exception e) {
            System.assertEquals('Please enter recipient email address', e.getMessage());
        }
        //Test.stopTest();
        
        // Test when Recipient_Email_Address__c and primaryContactEmail are not blank
        //Test.startTest();
        acc.Recipient_Email_Address__c = 'test@example.com';
        acc.Customer_Primary_Contact__c = 'primarycontact';
        insert acc;
        
        Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();
        mail2.setToAddresses(new List<String>{primaryContactEmail});
        mail2.setTemplateId(emailTemplateId2);
        mail2.setWhatId(acc.Id);
        mail2.setTreatTargetObjectAsRecipient(false);
        mail2.setTargetObjectId('0035i00000TJFvdAAH');
        mail2.setSaveAsActivity(false);
        
        emails.clear();
        emails.add(mail2);
        
        results = Messaging.sendEmail(emails);
        Test.stopTest();
        
        // Assert that both emails were sent successfully
        System.assertEquals(2, results.size());
        System.assertEquals(true, results[0].isSuccess());
        System.assertEquals(true, results[1].isSuccess());
    }





    
    
    
    @isTest
    static void testFieldUpdate_WithEmptyRecipientEmail() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Call the method being tested
        Test.startTest();
        String errorMessage = AddEmailAddressCont.fieldUpdate(testAccount.Id);
        Test.stopTest();
        
        // Perform assertions
        System.assertNotEquals('', errorMessage, 'Error message should not be empty');
    }
    
    @isTest
    static void testSendVerification() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        String otherEmails = 'test1@example.com, test2@example.com';
        
        // Call the method being tested
        Test.startTest();
        Boolean result = AddEmailAddressCont.sendVerification(otherEmails, testAccount.Id);
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(true, result, 'Result should be true');
....................................................................................................................
    }*/


@isTest
    static void testFieldUpdate() {
        
        String primaryContactEmail='abc';
        Id emailTemplateId1 = '00X5i0000016n1REAQ';
        Id emailTemplateId2 = '00X5i0000016prrEAA';
        
        // Create test data
        Account Acc1 = new Account(Name = 'Test Account1', Recipient_Email_Address__c = 'test@example.com',Customer_Primary_Contact__c='abc');
        
        insert Acc1;
        
        Account Acc2 = new Account(Name = 'Test Account2', Recipient_Email_Address__c = '');
      
        insert Acc2;
        
        
        
        
        Contact testContact = new Contact(AccountId = Acc1.Id, lastName = 'Test Contact', Email = 'testRecipiant@example.com', Primary_contact__c = true );
        primaryContactEmail=testContact.email;
        insert testContact;
        //.......
        										
        
        // Call the method being tested
        Test.startTest();
        String errorMessage1 = AddEmailAddressCont.fieldUpdate(acc1.Id);
        
        String errorMessage2 = AddEmailAddressCont.fieldUpdate(acc2.Id);
        
        //String errorMessage3 = AddEmailAddressCont.fieldUpdate(acc3.Id);
        Test.stopTest();
        
        
        
    }
   
    
    @isTest
    static void testSendVerification() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        String otherEmails1 = 'test1@example.com, test2@example.com';
        
        String otherEmails2 = 'test1example.com, test2@example';
        // Call the method being tested
        Test.startTest();
        Boolean result1 = AddEmailAddressCont.sendVerification(otherEmails1, testAccount.Id);
        
        Boolean result2 = AddEmailAddressCont.sendVerification(otherEmails2, testAccount.Id);
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(true, result1, 'Result should be true');
        System.assertEquals(false, result2, 'Result should be false');
    }


}