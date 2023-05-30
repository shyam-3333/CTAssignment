/*
* Created by    : Praveen (Lister)
* Created on    : Nov-07-2019
* Purpose       : This trigger has the consolidated logic from Trigger_Update_Completed_Date,Trigger_Check_survey_response and Trigger_Delete_Other_Recurring_Tasks 
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/

trigger Trg_Task on Task (before insert,before Update,after Insert,after update) {
    if(TriggerStatus__c.getInstance(Util_Common.ATTTRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.ATTTRIGGER).Active__c){
        if(trigger.isBefore){
            if(trigger.isInsert || trigger.isUpdate){
                TaskTriggerHandler.populateTaskFields(Trigger.new);
            }
        }
        if(trigger.isAfter){
            if(trigger.isInsert){
                TaskTriggerHandler.populateContactFields(Trigger.new);
            } 
            if(trigger.isUpdate){
                TaskTriggerHandler.deleteOtherRecurringTasks(Trigger.new,trigger.oldmap);
            }
        }
    }
}