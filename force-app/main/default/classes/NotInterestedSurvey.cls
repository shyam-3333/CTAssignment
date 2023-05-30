/*
* Class Name   : NotInterestedSurvey
* Created By   : Madhushree H J
* Created Date : 22-01-2023
* Description  :this class is used to check wheater user interested to take survey or not.  
*/
public without sharing class NotInterestedSurvey {
    public String feedbackId;
    Public string interested{set;get;}
    public String name{set;get;}
    public String email{set;get;}
    public String phone{set;get;}
    public boolean showForm{set;get;}
    public Backup_Feedback__c backupFeedback {
        get {
            
            if (backupFeedback == null)
            {
                backupFeedback = new Backup_Feedback__c();
            }
                
            return backupFeedback;
        }
        set;
    }

    /*
     * @description this metod is used to check the feedback status NotInterestedSurvey().
     */
    public NotInterestedSurvey()
    {
        feedbackId=ApexPages.currentPage().getParameters().get('Id');
      Customer_Feedback__c fb=[Select Id,Name,Email__c,Phone__c,Feedback_Status__c From Customer_Feedback__c Where Id =:feedbackId ];
        name=fb.Name;
        email=fb.Email__c;
        phone=fb.Phone__c;
        if(fb.Feedback_Status__c=='Not Interested'||fb.Feedback_Status__c=='Received'){
            showForm=true;
        }else
        {
            showForm=false;
        }
        
    }
     /*
     * @description his metod is used to capture the feedback status.
     * @return returning the thank you page.
     */
    public PageReference submit()
    {
        
        //getting Feedback record id.
        
        backupFeedback.Customer_Feedback__c=feedbackId;
        //assigning all the variable to BackUpFeedback Object specific field to create a BackupFeedback record.
        backupFeedback.Name=name;          
        backupFeedback.Phone__c=phone;
        backupFeedback.Email__c=email;
        backupFeedback.Feedback_Received_Date__c=System.now();
        
        backupFeedback.Feedback_Status__c='Not Interested';
        
        
        
        insert  backupFeedback;
        return Page.ThankYouPage;
    }
    
}