/*
* Created by    : Praveen (Lister)
* Created on    : Nov-14-2019
* Purpose       : This trigger has the consolidated logic of Trigger_Check_Duplicate and Trigger_Create_second_Followup
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
trigger Trg_Lead on Lead (before insert,after insert,before update,after update) {
    if(TriggerStatus__c.getInstance(Util_Common.LEADTRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.LEADTRIGGER).Active__c){
     
        if(trigger.isAfter){
            if(trigger.isUpdate){
                LeadTriggerHandler.createFollowUptask(Trigger.new,trigger.oldmap);
            }
        }
        if(trigger.isBefore){
            if(trigger.isInsert){
                LeadTriggerHandler.escalationMail(Trigger.new);
            }
        }
       
    }
}