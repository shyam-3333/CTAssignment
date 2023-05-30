/*
* Created by    : Praveen (Lister)
* Created on    : Nov-21-2019
* Purpose       : This trigger handler has a consolidated logic of AccountContractValidation,QuoteRollUptotalAmount,RollUpAmount,salespriceUpdate and updateCategorynSubcategory
***********************************************************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
************************************************************************************************************************************************************************************
*/
trigger Trg_QuoteLineItem on QuoteLineItem (before insert,before update,after insert,after update,after delete) {
    if(TriggerStatus__c.getInstance(Util_Common.QUOTELINEITEMTRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.QUOTELINEITEMTRIGGER).Active__c){
        if(trigger.isBefore){ 
            if(trigger.isInsert || trigger.isUpdate){
                QuoteLineItemTriggerHandler.populateQLIFields(Trigger.new,Trigger.oldMap);
            }
        }
        if(trigger.isAfter){
            if(trigger.isInsert || trigger.isUpdate){
                QuoteLineItemTriggerHandler.deleteQLI(Trigger.new);
                QuoteLineItemTriggerHandler.updateQuoteFields(Trigger.new,Trigger.oldMap);
            }
            if(trigger.isDelete){
                QuoteLineItemTriggerHandler.updateQuoteFields(Trigger.old,null);
            }
        } 
    }
}