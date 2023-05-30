/*
Class Name   : FeedbackPopupController
Created By   : Nitin Aggarwal
Description  : This class used for to fetch the Customer Feedback records and show in LWC page 
               and to update Feedback Status and Feedback Sent date after the selection of records in LWC popup page.
Created Date : 16/08/2022
*/
public with sharing class FeedbackPopupController {
    
  /*     This method is created to fetch the customer feedback records and assign to LWC popup page.   */
    @AuraEnabled
    public static List<Customer_Feedback__c> displayFeedbackRecord(String recordId){   
        
        Id recordTypeLost = Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Closed_Lost_Feedback').getRecordTypeId();
        Id recordTypeWon = Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Closed_Won_Feedback').getRecordTypeId();
       
        List<Customer_Feedback__c> FeedbackList = [Select Id, Name, Contact_Name__c, Email__c,Customer_Feedback_Number__c, FeedBack_Sent_Date__c,Sent_Date_Time__c, Customer_Role__c From Customer_Feedback__c where (RecordTypeId =: recordTypeLost OR RecordTypeId =: recordTypeWon) AND (Feedback_Status__c =: 'Sent' OR Feedback_Status__c =: 'Overdue') AND Opportunity__c =:recordId limit 10];
        return FeedbackList;
        
    }
    
  /*     This method is used update the customer feedback records whose feedback status is 'Sent' or 'Overdue' 
         through opportunity popup selected records in LWC page. */
    @AuraEnabled
    public static List<Customer_Feedback__c> updateFeedBack(List<String> selectedIds, String oppId){
       
        List<Customer_Feedback__c> custfeedItem = new List<Customer_Feedback__c>();
        Set<String> uniqueIds = new Set<String>();
        uniqueIds.addAll(selectedIds);
        List<Customer_Feedback__c> custfeedList = [Select Id, Name, Email__c,First_Reminder_Sent__c,First_Reminder_Sent_Date_Time__c,Second_Reminder_Sent__c,Second_Reminder_Sent_Date_Time__c, Customer_Feedback_Number__c  From Customer_Feedback__c Where Id IN:uniqueIds];
        Customer_Feedback__c feedRec;
        for(String feedBackId : uniqueIds){
            feedRec = new Customer_Feedback__c(Id=feedBackId);
            feedRec.Feedback_Status__c = 'Sent';
            feedRec.FeedBack_Sent_Date__c = system.now(); 
            feedRec.First_Reminder_Sent__c = False;
            feedRec.First_Reminder_Sent_Date_Time__c = null;
            feedRec.Second_Reminder_Sent__c = False;
            feedRec.Second_Reminder_Sent_Date_Time__c = null;
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
        return displayFeedbackRecord(OppId);
    }
}