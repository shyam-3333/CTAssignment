/*
* Class Name   : FeedbackVoiceCustomer
* Created By   : Madhushree H J
* Created Date : 4-08-2022
* Description  :this class is used to create a backup feedback records through vf page with captured feedback details.
*/
public without sharing class FeedbackVoiceCustomer {
     /*
     *@description this method is used to move the page to next page on click on button next().
     *@return its returning the next page.
      
     */
    //Declaring a variable to store the backUp Record enterd Value.
    Public Id feedbackId;
    public String name{set;get;}
    public String email{set;get;}
    public Date   receivedDate{set;get;}
    public String submitterEmail{set;get;}
    public String phone{set;get;}
    public String submitterEmailChecking{set;get;}
    
    public Integer overallProcess{set;get;}
    public Integer  infrastructure{set;get;}
    public Integer technicalCompetency{set;get;}
    public Integer evidence{set;get;}
    public Integer expectations{set;get;}
    public String tealAutomation{set;get;}
    public String  reference{set;get;}
    public String futureOutlook {set;get;}
    public String suggetion{set;get;}
    public boolean showForm{set;get;}
    public boolean showError{set;get;}
    public String survey1{set;get;}
    public String survey2{set;get;}
    public String survey3{set;get;}
    public String survey4{set;get;}
    public String survey5{set;get;}
    public String survey6{set;get;}
    public String survey7{set;get;}
    public String survey8{set;get;}
    public String survey9{set;get;}
    //declaring error variable
    public boolean showErr1{set;get;}
    public boolean showErr2{set;get;}
    public boolean showErr3{set;get;}
    public boolean showErr4{set;get;}
    public boolean showErr5{set;get;}
    public boolean showErr6{set;get;}
    public boolean showErr7{set;get;}
    public boolean showErr8{set;get;}
    public boolean showErr9{set;get;}
    
    
    /*
     * @description this metod is used to query the customer feedback information and custom metadata values .
     */
    public FeedbackVoiceCustomer()
    {
        
        List<Customer_Voice_Feedback__mdt> m=[SELECT Voice_Feedback_Survey_Question__c FROM Customer_Voice_Feedback__mdt ];
       
        
        survey1=string.valueOf(m[0].Voice_Feedback_Survey_Question__c);
        survey2=string.valueOf(m[1].Voice_Feedback_Survey_Question__c);
        survey3=string.valueOf(m[2].Voice_Feedback_Survey_Question__c);
        survey4=string.valueOf(m[3].Voice_Feedback_Survey_Question__c);
        survey5=string.valueOf(m[4].Voice_Feedback_Survey_Question__c);
        survey6=string.valueOf(m[5].Voice_Feedback_Survey_Question__c);
        survey7=string.valueOf(m[6].Voice_Feedback_Survey_Question__c);
        survey8=string.valueOf(m[7].Voice_Feedback_Survey_Question__c);
        survey9=string.valueOf(m[8].Voice_Feedback_Survey_Question__c);
        //querying feedback object
        feedbackId=ApexPages.currentPage().getParameters().get('Id');
        Customer_Feedback__c fb=[Select Id,Name,Email__c,Phone__c,Feedback_Status__c From Customer_Feedback__c Where Id=:feedbackId ];
        name=fb.Name;
        email=fb.Email__c;
        phone=fb.Phone__c;
        if(fb.Feedback_Status__c=='Received'||fb.Feedback_Status__c=='Not Interested'){
            showForm=true;
        }else
        {
            showForm=false;
        }
        showError=false;
        showError=false;
        showErr1 = false;
        showErr2 = false;
        showErr3 = false;
        showErr4 = false;
        showErr5 = false;
        showErr6 = false;
        showErr7 = false;
        showErr8 = false;
        showErr9 = false;
    }
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
    public PageReference next(){
        return Page.FeedbackVoiceCustomerVfPageOne;
    }
     /*
     *@description this method is used to move the page to previous page on click on button previous().
     *@return its returning the previous page.
      
     */
    public Pagereference previous(){
        return Page.FeedbackVoiceCustomerVfPage;
    }
     /*
     *@description this method is used to create a backup feedback record on click on save button save().
     *@return its returning the thank you page.
      
     */
    public PageReference save(){
        //fetching customer feedback record id.
        
        backupFeedback.Customer_Feedback__c=ApexPages.currentPage().getParameters().get('Id');
        
        //assigning all the variable to BackUpFeedback Object specific field to create a BackupFeedback record.
        backupFeedback.Name=name;           
        backupFeedback.Phone__c=phone;
        backupFeedback.Email__c=email;
       
       backupFeedback.Feedback_Received_Date__c=System.now();
        backupFeedback.Feedback_Status__c='Received';
        showErr1 = overallProcess!=null ? false : true;
        showErr2 = infrastructure!=null ? false : true;
        showErr3 =technicalCompetency!=null ? false : true;
        showErr4 =  evidence!=null ? false : true;
        showErr5 = expectations!=null ? false : true;
        showErr6 = tealAutomation!='' ? false : true;
        showErr7 = reference!='' ? false : true;
        showErr8 =  futureOutlook!='' ? false : true;
        showErr9 = suggetion!='' ? false : true;
        if(showErr1 ||  showErr2 || showErr3 ||  showErr4 ||showErr5 ||  showErr6 ||showErr7 ||  showErr8 ||showErr9)
        {
            return null;
        }else{
            
            backupFeedback.Rate_Our_Overall_Process__c=overallProcess;
            backupFeedback.Rate_Our_Infrastructure__c=infrastructure;
            backupFeedback.Rate_Our_Technical_Competency__c=technicalCompetency;
            backupFeedback.Rate_Evidence_For_Process_Showcased__c=evidence;
            backupFeedback.Whether_We_Reached_Your_Expectations__c=expectations;
            backupFeedback.First_Impression_About_TEAL_Automation__c=tealAutomation;
            backupFeedback.From_Where_Do_You_Get_Our_Reference__c=reference;
            backupFeedback.Future_Outlook__c=futureOutlook;
            
            backupFeedback.Feedback_Suggestions__c=suggetion;
            insert backupFeedback; // inserts the new record into the database
            
            return page.FeedbackThankYouPageee;
        }
        
        
        
        
        
        
        
    }
    
    
    
}