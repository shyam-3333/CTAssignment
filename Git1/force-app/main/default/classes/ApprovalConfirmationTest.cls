@istest
public class ApprovalConfirmationTest {

  /*  @IsTest
    public static void testQuoteApproval() {
        // Create test data
        Quote testQuote = new Quote(Recipient_Email_ID__c = 'test@example.com');
        insert testQuote;

        Account testAccount = new Account();
        insert testAccount;

        testQuote.AccountId = testAccount.Id;
        update testQuote;

        // Call the method to test
        YourClass.QuoteWrapper quoteData = YourClass.quoteApproval(testQuote.Id);

        // Verify the returned QuoteWrapper
        System.assertEquals(testQuote.Recipient_Email_ID__c, quoteData.recipientEmail);
        System.assertEquals('False', quoteData.verified);
    }

    @IsTest
    public static void testSaveEmail() {
        // Create test data
        Quote testQuote = new Quote(Recipient_Email_ID__c = 'test@example.com', Approval_Status_Quote__c = 'Awaiting Email Verification');
        insert testQuote;

        // Call the method to test
        String result = YourClass.saveEmail('newemail@example.com', testQuote.Id);

        // Verify the result
        System.assertEquals('No error', result);

        // Verify the updated Quote and Account
        Quote updatedQuote = [SELECT Recipient_Email_ID__c, Approval_Status_Quote__c FROM Quote WHERE Id = :testQuote.Id];
        System.assertEquals('newemail@example.com', updatedQuote.Recipient_Email_ID__c);
        System.assertEquals('Awaiting Email Verification', updatedQuote.Approval_Status_Quote__c);

        Account updatedAccount = [SELECT Recipient_Email_Address__c FROM Account WHERE Id = :testQuote.AccountId];
        System.assertEquals('newemail@example.com', updatedAccount.Recipient_Email_Address__c);
    }
}*/


}