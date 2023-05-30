/*
* Class Name   : BackupFeedBckController
* Created By   : Madhushree H J
* Created Date : 09-08-2022
* Description  :this class is used to create a backup feedback records through vf page with captured feedback details.
*/
public without sharing class BackupFeedBckController 
{
    /*
     *@description this method is used to move the page to next page on click on button next().
     *@return its returning the next page.
      
     */
    //Declaring a variable to store the backUp Record enterd Value.
    Public Id feedbackId;
    public String name{set;get;}
    public String email{set;get;}
    public Date   receivedDate{set;get;}
    public String submitterName{set;get;}
    public String submitterEmail{set;get;}
    public String submitterEmailChecking{set;get;}
    public String phone{set;get;}
    public String status{set;get;}
    public String types{set;get;}
    public String organization{set;get;}
    public String projectName{set;get;}
    public String designation{set;get;}
    public String priceReview{set;get;}
    public String leadReview{set;get;}
    public String competencyReview{set;get;}
    public String customerEngagementReview{set;get;}
    public Decimal quality{set;get;}
    public Decimal overallCompetency{set;get;}
    public Decimal adherenceToSchedule {set;get;}
    public Decimal customerEngagement{set;get;}
    public Decimal documentsQuality{set;get;}
    public Boolean price{set;get;}
    public Boolean competency{set;get;}
    public Boolean leadTime{set;get;}
    public Boolean engagement{set;get;}
    public Boolean otherFactors{set;get;}
    public String otherSuggestion{set;get;}
    public String suggetion{set;get;}
    public boolean showForm{set;get;}
    public boolean showError{set;get;}
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
    public boolean showErr10{set;get;}
    public boolean showErr11{set;get;}
    public boolean showErr12{set;get;}
    public boolean showErr13{set;get;}
    public boolean showErr14{set;get;}
    public boolean showErr15{set;get;}
    public boolean showErr16{set;get;}
    public List<Opportunity_Closed_Won__mdt> customMetaData{set;get;}
    //   public Boolean showAccessPanel {get;set;}
    
    public String survey1{set;get;}
    public String survey2{set;get;}
    public String survey3{set;get;}
    public String survey4{set;get;}
    public String survey5{set;get;}
    public String survey6{set;get;}
    public String survey7{set;get;}
    public String survey8{set;get;}
    public String survey9{set;get;}
    public String survey10{set;get;}
    public String survey11{set;get;}
    
    
    /*
     * @description this metod is used to query the customer feedback information and custom metadata values .
     */
    public BackupFeedBckController()
    {
        
        List<Opportunity_Closed_Won__mdt> m=[SELECT Closed_Won_Survey_Question__c FROM Opportunity_Closed_Won__mdt ];
        
        
        survey1=string.valueOf(m[0].Closed_Won_Survey_Question__c);
        survey2=string.valueOf(m[1].Closed_Won_Survey_Question__c);
        survey3=string.valueOf(m[2].Closed_Won_Survey_Question__c);
        survey4=string.valueOf(m[3].Closed_Won_Survey_Question__c);
        survey5=string.valueOf(m[4].Closed_Won_Survey_Question__c);
        survey6=string.valueOf(m[5].Closed_Won_Survey_Question__c);
        survey7=string.valueOf(m[6].Closed_Won_Survey_Question__c);
        survey8=string.valueOf(m[7].Closed_Won_Survey_Question__c);
        survey9=string.valueOf(m[8].Closed_Won_Survey_Question__c);
        survey10=string.valueOf(m[9].Closed_Won_Survey_Question__c);
        survey11=string.valueOf(m[10].Closed_Won_Survey_Question__c);
        //Querying Customer feedback based on id
      feedbackId=ApexPages.currentPage().getParameters().get('Id');
      Customer_Feedback__c fb=[Select Id,Name,Email__c,Phone__c,Organization__c,Project_Name__c,Designation__c,Feedback_Status__c From Customer_Feedback__c Where Id=:feedbackId ];
        name=fb.Name;
        email=fb.Email__c;
        phone=fb.Phone__c;
        organization=fb.Organization__c;
        projectName=fb.Project_Name__c;
        designation=fb.Designation__c;
        if(fb.Feedback_Status__c=='Received'||fb.Feedback_Status__c=='Not Interested'){
            showForm=true;
        }else
        {
            showForm=false;
        }
        
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
        showErr10 = false;
        showErr11 = false;
        showErr12 = false;
        showErr13 = false;
        showErr14 = false;
        showErr15 = false;
        showErr16=false;
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
         showErr16= submitterEmailChecking==null? true:false;
        if(showErr16)
        {
            return null;
        }else{
             return Page.BackUpFeedbackVfPageOne;
        }

       
        
    }
     /*
     *@description this method is used to move the page to previous page on click on button previous().
     *@return its returning the previous page.
      
     */
    
    public Pagereference previous(){
        return Page.BackupFeedbackVfPage;
        
    }
    /*
     *@description this method is used to create a backup feedback record on click on save button save().
     *@return its returning the thank you page.
      
     */
    public PageReference save(){
        
        //getting Feedback record id.
        
        backupFeedback.Customer_Feedback__c=ApexPages.currentPage().getParameters().get('Id');
        //assigning all the variable to BackUpFeedback Object specific field to create a BackupFeedback record.
        backupFeedback.Name=name;          
        backupFeedback.Phone__c=phone;
        backupFeedback.Email__c=email;
        backupFeedback.Feedback_Status__c='Received';
        
        backupFeedback.Submitter_Email_Checking__c=submitterEmailChecking;
        backupFeedback.Feedback_Received_Date__c=System.now();
        showErr1 = quality!=null ? false : true;
        showErr2 = overallCompetency!=null ? false : true;
        showErr3 = adherenceToSchedule!=null ? false : true;
        showErr4 = customerEngagement!=null ? false : true;
        showErr5 = documentsQuality!=null ? false : true;
        showErr6 =(price ||leadTime || competency ||engagement )!=false ? false : true;
        showErr7 =priceReview =='' && price == true ? true: false;
        showErr8 =leadReview =='' && leadTime == true? true : false;
        showErr9 = competencyReview ==''&& competency == true? true : false;
        showErr10 =customerEngagementReview =='' && engagement== true ? true : false;
        showErr11 = suggetion!='' ? false : true;
        showErr12 =priceReview !='' && price == false ? true: false;
        showErr13 =leadReview !='' && leadTime == false? true : false;
        showErr14 = competencyReview !=''&& competency == false? true : false;
        showErr15 =customerEngagementReview !='' && engagement== false ? true : false;
        if(showErr1 ||  showErr2 || showErr3 ||  showErr4 ||showErr5 ||showErr6  ||showErr11 ||showErr7 || showErr8 ||showErr9 ||showErr10||showErr12 ||showErr13 ||showErr14||showErr15 )
        {
            return null;
        }else{
            backupFeedback.Rate_The_Quality_Of_Solution_Provided__c=quality;
            backupFeedback.Rate_The_Overall_Competency__c=overallCompetency;
            backupFeedback.Adherence_To_schedule__c=adherenceToSchedule;
            backupFeedback.Rate_The_Customer_Engagement__c=customerEngagement;
            backupFeedback.Rate_The_Quality_Of_Documents__c=documentsQuality;
            backupFeedback.Price__c=price;
            backupFeedback.Price_Reiw__c=priceReview;
            backupFeedback.Lead_Time__c=leadTime;
            backupFeedback.Lead_Time_Review__c=leadReview;
            backupFeedback.Competency__c=competency;
            backupFeedback.Competency_Review__c=competencyReview;
            backupFeedback.Customer_Engagement__c=engagement;
            backupFeedback.Customer_Engagement_Review__c=customerEngagementReview;
            backupFeedback.Other_Factor_Suggestion__c=otherSuggestion;
            backupFeedback.Feedback_Suggestions__c=suggetion;
            insert backupFeedback; 
            
            return page.FeedbackThankYouPage;
        }
        
    }
}