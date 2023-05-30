/*
* Created by    : Praveen (Lister)
* Created on    : Nov-18-2019
* Purpose       : This trigger handler has a consolidated logic of Trigger_Update_Opportunity,Trigger_Update_No_of_Attachments,Trigger_Update_Attachment_Name and PhotoBackupUpdate
***********************************************************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
************************************************************************************************************************************************************************************
*/
trigger Trg_Attachment on Attachment (before insert,after Insert,after Delete) {
    if(TriggerStatus__c.getInstance(Util_Common.TASKTRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.TASKTRIGGER).Active__c){
        if(trigger.isBefore){
            if(trigger.isInsert){
                AttachmentTriggerHandler.validateAttachment(Trigger.new);
            }
        }
        if(trigger.isAfter){
            if(trigger.isInsert){
                AttachmentTriggerHandler.updateProductFields(Trigger.new);
                AttachmentTriggerHandler.updateOpportunity(Trigger.new,null);
            }
            if(trigger.isDelete){
                AttachmentTriggerHandler.updateOpportunity(null,Trigger.old);
            }
        }
    }
}