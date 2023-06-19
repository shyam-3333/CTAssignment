@istest
public class EVErrorPageControllerTest {
   /* @istest
    public static void openNewPageTest(){
        PageReference testPage = Page.ThankYouPageNo3;
   //testPage.getParameters().put('oid', '12345');   
   Test.setCurrentPage(testPage);
   Test.StartTest();
   EVErrorPageController controller = new EVErrorPageController();
   controller.openNewPage();
   //Assertion
  
   Test.StopTest();
    }


    @IsTest
    public static void testOpenNewPage() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Set the current page parameters
        ApexPages.currentPage().getParameters().put('ID', testAccount.Id);

        // Call the method to test
        PageReference pageRef = EVErrorPageController.openNewPage();

        // Verify the page reference
        System.assertEquals(page.ThankYouPageNo3, pageRef);

        // Verify the email sending logic
        Messaging.SingleEmailMessage[] sentEmails = [SELECT Id, ToAddress, TemplateId, WhatId, OrgWideEmailAddressId, TreatTargetObjectAsRecipient, TargetObjectId, SaveAsActivity
                                                    FROM Messaging.SingleEmailMessage];
        System.assertEquals(1, sentEmails.size());
        Messaging.SingleEmailMessage sentEmail = sentEmails[0];
        System.assertEquals('shyam.k@kvpcorp.com', sentEmail.getToAddresses()[0]);
        System.assertEquals('00X7d0000012YcBEAU', sentEmail.getTemplateId());
        System.assertEquals(testAccount.Id, sentEmail.getWhatId());
        System.assertNotEquals(null, sentEmail.getOrgWideEmailAddressId());
        System.assertEquals(false, sentEmail.getTreatTargetObjectAsRecipient());
        System.assertEquals('0037d00002AReZQAA1', sentEmail.getTargetObjectId());
        System.assertEquals(false, sentEmail.getSaveAsActivity());

        // Verify the email sending result
        Messaging.SendEmailResult[] emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{sentEmail});
        System.assertEquals(1, emailResults.size());
        Messaging.SendEmailResult emailResult = emailResults[0];
        System.assertTrue(emailResult.isSuccess());
    }

Public database.querylocator start(database.batchableContext info){
string query='Select ID,NAme From Account';
return database.getqueryLocator(Query);
}
	
Public void execute(database.batchableContext info, List<Account>listAcc){
}
Public void finish(database.batchableContext info){}
........................................................
@IsTest
public class TestClassName {
    @IsTest
    public static void testActionMethod() {
        // Create test data
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        // Set other required fields
        
        // Insert test data
        insert testAccount;
        
        // Call the action method
        Test.startTest();
        PageReference pageRef = ClassName.action();
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(true, pageRef.getRedirect());
        System.assertEquals('ExpectedRedirectURL', pageRef.getUrl());
        
        // Additional assertions for updated fields and email sending can be added
    }
    
    @IsTest
    public static void testUpdaterMethod() {
        // Create test data
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        // Set other required fields
        
        // Insert test data
        insert testAccount;
        
        // Call the updater method
        Test.startTest();
        String redirectURL = ClassName.updater(testAccount.Id);
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals('ExpectedRedirectURL', redirectURL);
        
        // Additional assertions for updated fields and email sending can be added
    }
    
    @IsTest
    public static void testIsWithin24HourMethod() {
        // Create test data
        Datetime mailRecievedDatetime = Datetime.newInstance(2023, 5, 26, 10, 0, 0);
        Datetime clickedDatetimeWithin24Hours = Datetime.newInstance(2023, 5, 26, 14, 0, 0);
        Datetime clickedDatetimeOutside24Hours = Datetime.newInstance(2023, 5, 27, 10, 0, 0);
        
        // Call the isWithin24Hour method
        Test.startTest();
        Boolean within24Hours1 = ClassName.isWithin24Hour(mailRecievedDatetime, clickedDatetimeWithin24Hours);
        Boolean within24Hours2 = ClassName.isWithin24Hour(mailRecievedDatetime, clickedDatetimeOutside24Hours);
        Test.stopTest();
        
        // Perform assertions
        System.assertEquals(true, within24Hours1);
        System.assertEquals(false, within24Hours2);
    }
    
    @IsTest
    public static void testSendEmailToAccountOwnerMethod() {
        // Create test data
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        // Set other required fields
        
        // Insert test data
        insert testAccount;
        
        // Call the sendEmailToAccountOwner method
        Test.startTest();
        ClassName.sendEmailToAccountOwner(testAccount.Id);
        Test.stopTest();
        
        // Perform assertions or check email sending using a different approach
    }
}



}*/


}