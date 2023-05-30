/*
* Class Name   : BackupFeedBckControllerTest
* Created By   : Madhushree H J
* Created Date : 21-08-2022
* Description  :this test  class is used to test the test covarage of  BackupFeedBckController.
*/
@isTest
public class BackupFeedBckControllerTest {
    
    
    @isTest
    public static void saveTest()
    {
        Customer_Feedback__c feed = new Customer_Feedback__c();
        feed.Name = 'Titan'; 
        feed.Email__c = 'madhushree.hj@kvpcorp.com';
        feed.Phone__c = '8480902532';
        feed.Organization__c = 'KVP';
        feed.Project_Name__c ='Titan Feedback';
        feed.Designation__c = 'HR';
        feed.Feedback_Status__c = 'Received'; 
        
        insert feed;
        Backup_Feedback__c backupFeedback=new  Backup_Feedback__c();
        backupFeedback.Customer_Feedback__c=feed.Id;
        
        backupFeedback.Name=feed.Name;          
        backupFeedback.Phone__c=feed.Phone__c;
        backupFeedback.Email__c=feed.Email__c;
        //backupFeedback.FeedBack_Sent_Date__c=system.now();
        backupFeedback.Feedback_Status__c='Sent';
        backupFeedback.Submitter_Email__c='madhushreehjh@gmail.com';
        backupFeedback.Submitter_Email_Checking__c='Yes';
        backupFeedback.Feedback_Received_Date__c=System.now();
        backupFeedback.Rate_The_Quality_Of_Solution_Provided__c=10;
        backupFeedback.Rate_The_Overall_Competency__c=10;
        backupFeedback.Adherence_To_schedule__c=10;
        backupFeedback.Rate_The_Customer_Engagement__c=10;
        backupFeedback.Rate_The_Quality_Of_Documents__c=10;
        backupFeedback.Price__c=true;
        backupFeedback.Lead_Time__c=true;
        backupFeedback.Competency__c=true;
        backupFeedback.Customer_Engagement__c=false;
        
        backupFeedback.Other_Factor_Suggestion__c='good';
        backupFeedback.Feedback_Suggestions__c='good';
        
        
        
        insert backupFeedback; // inserts the new 
        
        Test.startTest();   
        PageReference pageRef = Page.BackupFeedbackVfPage;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(feed);
        ApexPages.currentPage().getParameters().put('Id',feed.id);
        BackupFeedBckController obj = new BackupFeedBckController();
        
        obj.price=true;
        obj.leadTime=true;
        obj.competency=true;
        obj.engagement=true;
        obj.competencyReview='good';
        obj.priceReview='good';
        obj.leadReview='good';
        obj.competencyReview='good';
        obj.suggetion='good';
        obj.showErr1=true;
        obj.showErr2=true;
        obj.submitterEmail='madhushree@gmail.com';
        obj.status='Received';
        obj.types='Closed Won Feedback';
        obj.otherFactors=true;
        obj.submitterName='kvp';
        obj.receivedDate=System.today();
        obj.showErr12=true;
        obj.showErr4=true;
        obj.showErr5=true;
        obj.showErr3=true;
        obj.showErr6=true;
        obj.showErr7=false;
        obj.showErr8=false;
        obj.showErr9=false;
        obj.showErr10=false;
        obj.showErr11=true;
        obj.adherenceToSchedule=10;
        obj.customerEngagement=10;
        obj.documentsQuality=10;
        obj.overallCompetency=10;
        obj.submitterEmailChecking='no';
        obj.otherSuggestion='good';
        obj.next();
        obj.previous();
        
        
        obj.save();
        Test.stopTest();
        
    }
}