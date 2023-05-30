/*
Class Name   : VisitFeedbackPopupController
Created By   : Nitin Aggarwal
Description  : This class used for to fetch the Customer Feedback records and show in LWC page 
               and to update Feedback Status and Feedback Sent date after the selection of records in LWC popup page.
Created Date : 17/01/2023
*/
public  class VisitFeedbackPopupController {
     /*
     *@description This method is created to fetch the customer feedback records and assign to LWC popup page displayFeedbackRecord().
     *@return its returning list of customer feedback.
     */
    
  /*     This method is created to fetch the customer feedback records and assign to LWC popup page.   */
    @AuraEnabled
    public static List<Customer_Feedback__c> displayFeedbackRecord(String recordId){   
        
        Id recordTypeVoice = Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Customer_Voice_Feedback').getRecordTypeId();
       
        List<Customer_Feedback__c> FeedbackList = [Select Id, Name, Contact_Name__c, Email__c,Customer_Feedback_Number__c, Feedback_Status__c, FeedBack_Sent_Date__c,Sent_Date_Time__c, Customer_Role__c From Customer_Feedback__c where RecordTypeId =: recordTypeVoice AND Feedback_Status__c =: 'New' AND Visit__c =:recordId limit 10];
        return FeedbackList;
        
    }
    
  /*     This method is used update the customer feedback records whose feedback status is 'New' 
         through Visit popup selected records in LWC page. */
     /*
     *@description This method is used update the customer feedback records whose feedback status is 'New' 
         through Visit popup selected records in LWC page updateFeedBack().
     *@return its returning list of customer feedback.
     */
    @AuraEnabled
    public static List<Customer_Feedback__c> updateFeedBack(List<String> selectedIds, String visitId){
       
        List<Customer_Feedback__c> custfeedItem = new List<Customer_Feedback__c>();
        Set<String> uniqueIds = new Set<String>();
        uniqueIds.addAll(selectedIds);
        List<Customer_Feedback__c> custfeedList = [Select Id, Name, Email__c,First_Reminder_Sent__c,Second_Reminder_Sent__c, Feedback_Status__c, Customer_Feedback_Number__c  From Customer_Feedback__c Where Id IN:uniqueIds];
        Customer_Feedback__c feedRec;
        for(String feedBackId : uniqueIds){
            feedRec = new Customer_Feedback__c(Id=feedBackId);
            feedRec.Feedback_Status__c = 'Sent';
            feedRec.FeedBack_Sent_Date__c = system.now(); 
            feedRec.First_Reminder_Sent__c = False;
            feedRec.Second_Reminder_Sent__c = False;
            custfeedItem.add(feedRec);
        }
        if(custfeedItem.size()>0){
            try{
                update custfeedItem;           
            }
            catch (Exception exp) {
                throw new AuraHandledException(exp.getMessage());
            }
        }
        return displayFeedbackRecord(visitId);
    }

}