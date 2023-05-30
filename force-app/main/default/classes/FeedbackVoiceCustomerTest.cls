/*
* Class Name   : FeedbackVoiceCustomerTest
* Created By   : Madhushree H J
* Created Date : 20-08-2022
* Description  :this class is used to check the test coverage of FeedbackVoiceCustomer .
*/
@isTest
public class FeedbackVoiceCustomerTest {
    @isTest
    public static void saveTest()
    {
        Customer_Feedback__c feed = new Customer_Feedback__c();
        feed.Name = 'Titan'; 
        feed.Email__c = 'madhushree.hj@kvpcorp.com';
        feed.Phone__c = '8480902532';
        
        insert feed;
        
        Backup_Feedback__c backupFeedback=new  Backup_Feedback__c();
        backupFeedback.Customer_Feedback__c=feed.Id;
        
        backupFeedback.Name=feed.Name;          
        backupFeedback.Phone__c=feed.Phone__c;
        backupFeedback.Email__c=feed.Email__c;
        backupFeedback.Feedback_Received_Date__c=System.now();
        backupFeedback.Rate_Our_Overall_Process__c=10;
        backupFeedback.Rate_Our_Infrastructure__c=10;
        backupFeedback.Rate_Our_Technical_Competency__c=10;
        backupFeedback.Rate_Evidence_For_Process_Showcased__c=10;
        backupFeedback.Whether_We_Reached_Your_Expectations__c=10;
        backupFeedback.First_Impression_About_TEAL_Automation__c='good';
        backupFeedback.From_Where_Do_You_Get_Our_Reference__c='good';
        backupFeedback.Future_Outlook__c='good';
        
        backupFeedback.Feedback_Suggestions__c='good';
        insert backupFeedback;
        
        Test.startTest();   
        PageReference pageRef = Page.FeedbackVoiceCustomerVfPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(feed);
        ApexPages.currentPage().getParameters().put('Id',feed.id);
        FeedbackVoiceCustomer obj = new FeedbackVoiceCustomer();
        obj.next();
        obj.previous();
        Backup_Feedback__c lst=obj.backupFeedback; 
        obj.save();
        Test.stopTest();
        
    }
    
    
}