@istest
public class EV_ApprovalConfirmationComponentTest {
    
    @istest
    public static void quoteApprovalTest(){
        
        // Create test data
        Opportunity opp = New Opportunity();
        opp.name='TestOpp';
        Opp.CloseDate=system.today();
        opp.StageName='closed Won';
        
        test.startTest();
        Insert Opp;
        
        Quote qt=new Quote();
        qt.Name='TestQuote';
        qt.OpportunityId=opp.Id;
        qt.Recipient_Email_ID__c='abc@xyz.com';        
        Insert qt;
        // Call the method to be tested
        String result= EV_QuoteApprovalController.quoteApproval(qt.Id);
        test.stopTest();
        
        // Perform assertions
        System.assertEquals('abc@xyz.com', result );
    }
    
}