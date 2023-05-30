/*
* Created by    : Praveen (Lister)
* Created on    : Nov-07-2019
* Purpose 		: This trigger handler has a consolidated logic of Trigger_Update_Completed_Date,Trigger_Check_survey_response and Trigger_Delete_Other_Recurring_Tasks 
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)   Nov-07-2019   T01     Update completed date
Praveen(Lister)   Nov-07-2019   T02     Update contact fields
Praveen(Lister)   Nov-07-2019   T03     Delete the task and incerease the counter value in lead 
*/

public class TaskTriggerHandler {
    Private final static string taskCompletedStatus ='Completed';
    Private final static string subjectCustomer ='Customer';
    Private final static string subjectSatisfaction ='Satisfaction';
    Private final static string subjectSurvey ='Survey';
    Private final static string leadSubject ='Lead Followup Call';
    Private final static string contactPrefix='003';
    Private final static string opptPrefix='006';
    Private final static string leadPrefix='00Q';
    
    //<T01>
    // Populate completed date in the task 
    public static void populateTaskFields(List<Task> lstTaskNew){
        for(Task objTask : lstTaskNew){
            if(objTask.Status == taskCompletedStatus)
                objTask.Completed_Date_del__c  = System.today();
        }
    }
    //</T01>
    
    //<T02>
    // Update the Contact fields  
    public static void populateContactFields(List<Task> lstTaskNew){
        Set<ID> conid = new Set<ID>();
        List<Contact> conlist = new List<Contact>();
        
        for(Task objTask : lstTaskNew){
            if(objTask.Subject != null && objTask.Subject.contains(subjectCustomer) &&  objTask.Subject.contains(subjectSatisfaction) && objTask.Subject.contains(subjectSurvey)){
                if(objTask.WhoID != null && String.valueof(objTask.WhoID).substring(0,3) == contactPrefix)
                    conid.add(objTask.WhoID);
            }
        }
        if(conid.size()>0){
            List<Contact> listContact = [select Id,Survey_Responded__c,Survey_Sent__c from Contact where ID IN: conid];
            if(listContact.size()>0){
                for(Contact cont : listContact){
                    cont.Survey_Sent__c = true;
                    cont.Survey_Responded__c = false;
                    conlist.add(cont);
                }
            }
        }
        if(conlist.size()>0){
            try{
                update conlist;
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
    }
    //</T02>
    //<T03>
    // Delete the task and incerease the counter value in lead
    public static void deleteOtherRecurringTasks(List<Task> lstTaskNew , Map<Id, Task> mapOldTask){
        Set<String> tasKRelatedID =new Set<String>();
        Set<String> taskSubject = new Set<String>();
        Set<String> taskcat = new Set<String>();
        Set<ID> leadID = new Set<ID>();
        Date today = System.Today();
        List<Lead> leadList = new List<Lead>();
        
        for(Task objTask : lstTaskNew){
            
            Task oldtsk = mapOldTask.get(objTask.ID);
            
            if(objTask.Status == taskCompletedStatus){
                if(objTask.WhatID != null && String.valueof(objTask.whatId).substring(0,3) == opptPrefix){
                    tasKRelatedID.add(objTask.WhatID);
                    taskcat.add(objTask.Task_Category__c);
                    taskSubject.add(objTask.Subject);
                }else if((objTask.whoID != null && String.valueof(objTask.WhoID).substring(0,3) == leadPrefix && objTask.Subject.contains(leadSubject))){
                    tasKRelatedID.add(objTask.WhoID);
                    taskSubject.add(objTask.Subject);
                    leadID.add(objTask.WhoID);
                }
            }
            if(objTask.whoID != oldtsk.whoID && objTask.whoID != null && String.valueof(objTask.whoID).substring(0,3) == contactPrefix && objTask.Subject.contains(leadSubject)){
                tasKRelatedID.add(objTask.WhoID);
                taskSubject.add(objTask.Subject);
            }
        }
        // Delete the task
        if(tasKRelatedID.size()>0){
            List<Task> listTask = [select Id from Task where Status !=: taskCompletedStatus AND ActivityDate >: today AND ((WhatID IN: tasKRelatedID AND Subject IN: taskSubject) OR (WhoID IN: tasKRelatedID AND Subject IN: taskSubject)) ];
            if(listTask.size()>0){
                try{
                    Delete listTask;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
        }
        // Update the Counter value in lead
        if(leadID.size()>0){
            for(Lead objLead : [select Id,Counter__c,IsConverted from Lead where ID IN: leadID]){
                if(objLead.IsConverted == false){
                    Lead newLead = new Lead(ID = objLead.ID);
                    if(objLead.Counter__c != null)    
                        newLead.Counter__c = objLead.Counter__c+1;
                    else
                        newLead.Counter__c = 1;
                    
                    leadlist.add(newLead);
                }
            }
            if(leadlist.size()>0){
                try{
                    update leadlist;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
            
        }
    }
    //<T03>
}