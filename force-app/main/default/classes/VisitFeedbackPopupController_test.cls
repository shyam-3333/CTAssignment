@isTest
public class VisitFeedbackPopupController_test {
    @isTest
    public static void testDisplayFeedbackRecord(){
        
        Id recordTypeVoice = Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Customer_Voice_Feedback').getRecordTypeId();
        
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
        
        Visit__c visit = new Visit__c();
        visit.Name = 'Test Visit';
        visit.Visit_Category__c = 'General Followup';
        visit.Account__c = acct.ID;
        visit.Date_Time_of_Visit__c = system.now();
        visit.Minutes_of_Meeting__c = 'test';
        insert visit;
        

        List<String> listId=new  List<String>();
        Customer_Feedback__c feedback = new Customer_Feedback__c();
        feedback.Visit__c = visit.Id;
        feedback.Name = 'test';
        feedback.Phone__c = cc.Phone;
        feedback.Email__c = cc.Email;
        feedback.Feedback_Status__c = 'Sent';
        feedback.RecordTypeId = recordTypeVoice;
        insert feedback;
        listId.add(feedback.Id);
        
        feedback.Feedback_Status__c = 'Sent';
        feedback.FeedBack_Sent_Date__c = system.now(); 
        feedback.First_Reminder_Sent__c = False;
        feedback.Second_Reminder_Sent__c = False;
        update feedback;
        Test.startTest(); 
        VisitFeedbackPopupController.displayFeedbackRecord(feedback.Id);
        VisitFeedbackPopupController.updateFeedBack(listId,visit.Id);
        Test.stopTest();
        
    }
    


}