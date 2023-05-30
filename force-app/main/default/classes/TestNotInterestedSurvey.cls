/*
* Class Name   : TestNotInterestedSurvey
* Created By   : Madhushree H J
* Created Date : 25-01-2023
* Description  :this test class is used to check the code coverage of the  NotInterestedSurvey class.  
*/
@isTest
public class TestNotInterestedSurvey {
    @isTest
    public static void submitTest()
    {
        String interested;
        Customer_Feedback__c feed = new Customer_Feedback__c();
        feed.Name = 'Titan'; 
        feed.Email__c = 'madhushree.hj@kvpcorp.com';
        feed.Phone__c = '8480902532';
        insert feed;
        Backup_Feedback__c backupFeedback=new  Backup_Feedback__c();
        backupFeedback.Name=feed.Name;          
        backupFeedback.Phone__c=feed.Phone__c;
        backupFeedback.Email__c=feed.Email__c;
        backupFeedback.Feedback_Status__c='Not Interested';
        insert backupFeedback;
         Test.startTest(); 
        PageReference pageRef = Page.FeedbackClosedLostVfPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(feed);
        ApexPages.currentPage().getParameters().put('Id',feed.id);
        NotInterestedSurvey obj=new NotInterestedSurvey();
        obj.interested='Not Interested';
        obj.submit();
        Test.stopTest();
        
    }

}