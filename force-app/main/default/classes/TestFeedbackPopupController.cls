@isTest
public class TestFeedbackPopupController {
    @isTest
    public static void testDisplayFeedbackRecord(){
        
        Id closedWonId=Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Closed_Won_Feedback').getRecordTypeId();
        Id closedLostId=Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Closed_Lost_Feedback').getRecordTypeId();
        Account acct = new Account();
        acct.Name = 'test';
        insert acct;
        
        Contact cc=new Contact();
        cc.FirstName='test';
        cc.LastName='class';
        cc.MobilePhone='1234567898';
        cc.Email='test@gmail.com';
        cc.Designation__c='test';
        cc.AccountId=acct.Id;
        insert cc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('MBA').getRecordTypeId();
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Under-Study';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Customer_Primary_Contact__c=cc.Id;
        opp.Amount=10000;
        opp.Type='Tools & Fixer';
        insert opp;
        List<String> listId=new  List<String>();
        Customer_Feedback__c feedback=new Customer_Feedback__c();
        feedback.Opportunity__c=opp.Id;
        feedback.Name= 'test';
        feedback.Phone__c=cc.Phone;
        feedback.Email__c=cc.Email;
        feedback.Feedback_Status__c='Sent';
        feedback.RecordTypeId = closedWonId;
        insert feedback;
        listId.add(feedback.Id);
        
        feedback.Feedback_Status__c = 'Sent';
        feedback.FeedBack_Sent_Date__c = system.now(); 
        feedback.First_Reminder_Sent__c = False;
        feedback.Second_Reminder_Sent__c = False;
        update feedback;
        Test.startTest(); 
        FeedbackPopupController.displayFeedbackRecord(feedback.Id);
        FeedbackPopupController.updateFeedBack(listId,opp.Id);
        Test.stopTest();
        
    }
    
}