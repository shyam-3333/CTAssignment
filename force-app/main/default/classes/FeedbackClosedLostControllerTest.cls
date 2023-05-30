/*
* Class Name   : FeedbackClosedLostControllerTest
* Created By   : Madhushree H J
* Created Date : 20-08-2022
* Description  :this class is used for to check the test covarage of FeedbackClosedLostController.
*/
@isTest
public class FeedbackClosedLostControllerTest {
    
    @isTest
    public static void saveTest()
    {
         Boolean price;
        price=false;
         Boolean competency;
        competency=false;
         Boolean leadTime;
        leadTime=false;
         Boolean engagement;
        engagement=false;
        Customer_Feedback__c feed = new Customer_Feedback__c();
        feed.Name = 'Titan'; 
        feed.Email__c = 'madhushree.hj@kvpcorp.com';
        feed.Phone__c = '8480902532';
        feed.Organization__c = 'KVP';
        feed.Project_Name__c ='Titan Feedback';
        feed.Designation__c = 'HR';
        
        insert feed;
        
        Backup_Feedback__c backupFeedback=new  Backup_Feedback__c();
       // backupFeedback.Customer_Feedback__c=feed.Id;
        
        backupFeedback.Name=feed.Name;          
        backupFeedback.Phone__c=feed.Phone__c;
        backupFeedback.Email__c=feed.Email__c;
        
        backupFeedback.Submitter_Email__c='madhushreehjh@gmail.com';
        backupFeedback.Submitter_Email_Checking__c='Yes';
        backupFeedback.Feedback_Received_Date__c=System.now();
        
        backupFeedback.Rate_The_Quality_Of_Solution_Provided__c=10;
        backupFeedback.Rate_The_Overall_Competency__c=10;
        backupFeedback.Adherence_To_schedule__c=10;
        backupFeedback.Rate_The_Customer_Engagement__c=10;
        backupFeedback.Rate_The_Quality_Of_Documents__c=10;
        backupFeedback.Price__c= price; 
        backupFeedback.Lead_Time__c=leadTime;
        backupFeedback.Competency__c=competency;
        backupFeedback.Customer_Engagement__c=engagement;
        
        backupFeedback.Other_Factor_Suggestion__c='good';
        backupFeedback.Feedback_Suggestions__c='good';
        
        
        
        insert backupFeedback; // inserts the new 
        
        
        Test.startTest();   
        PageReference pageRef = Page.FeedbackClosedLostVfPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(feed);
        ApexPages.currentPage().getParameters().put('Id',feed.id);
        FeedbackClosedLostController obj = new FeedbackClosedLostController();
        obj.price=true;
        obj.leadTime=true;
        obj.competency=true;
        obj.engagement=true;
        
        obj.next();
        obj.previous();
        
        obj.save();
        
        Test.stopTest();
        
    }
    
}