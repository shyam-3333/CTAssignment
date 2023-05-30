/*
* Created by    : Praveen (Lister)
* Created on    : Nov-20-2019
* Purpose       : This trigger has a consolidated logic of QuoteLineItemBeforeInsetUpdate,Trigger_Update_Currency and Trigger_Update_SNo
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
trigger Trg_QuoteItem on Quote_Items__c (before insert,after Insert,after Delete,after update) {
    if(TriggerStatus__c.getInstance(Util_Common.QUOTEITEMETRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.QUOTEITEMETRIGGER).Active__c){
        if(trigger.isBefore){
            if(trigger.isInsert ){
                QuoteItemTriggerHandler.populateCurrencyCode(Trigger.new);
            }
        }
        if(trigger.isAfter){
            if(trigger.isInsert || trigger.isUpdate){
                QuoteItemTriggerHandler.populateQuoteFields(Trigger.new);
            }else if(trigger.isDelete){
                QuoteItemTriggerHandler.populateQuoteFields(Trigger.old);
            }
        }
    }
}