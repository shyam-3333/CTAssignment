/*
* Created by    : Saradha (Lister)
* Created on    : Nov-21-2019
* Purpose       : This trigger has a consolidated logic of AmountInWords ,NumberToWords ,QtValueAfterCust,QuoteAmountUpdateOnOpp ,QuoteBeforeDelete ,QuoteNameUpdate ,QuoteNameUpdateR1 ,Trigger_Update_Currency_Name ,Trigger_Update_Opportunity_Amount ,updateContractApproval ,updateInstiOrderRefeNo ,updateOppAmount1
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
trigger TRG_Quote on Quote (before insert,after Insert,before Delete ,after Delete,before update,after update) {
    if(TriggerStatus__c.getInstance(Util_Common.QUOTETRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.QUOTETRIGGER).Active__c){
        if(trigger.isBefore){
            if(trigger.isInsert ){
                QuoteTriggerHandler.updateCurrencyName(Trigger.new,null);
                QuoteTriggerHandler.updateQuoteNameandLastCreated(Trigger.new);
                QuoteTriggerHandler.numberToWordsQuoteApproval(Trigger.new);
                new AssignStdPKtoQuote().assignPB(Trigger.new);
            }
            if(trigger.isUpdate){
                for(Quote q : Trigger.new){ //new
                    if(q.Approval_status_to_opportunity__c=='Accepted' || q.Approval_status_to_opportunity__c=='Rejected'){
                        system.debug('-- 1 --');
                        QuoteTriggerHandler2.updateComment(Trigger.new);
                        system.debug('-- 2 --');
                    }
                }
                if(!Util_Common.triggerSet.contains('updateCurrencyName')){
                    QuoteTriggerHandler.updateCurrencyName(Trigger.new,Trigger.oldMap);
                    QuoteTriggerHandler.numberToWordsQuoteApproval(Trigger.new);
                    system.debug('updateContractApproval'+Trigger.new);
                    QuoteTriggerHandler.updateContractApproval(Trigger.new);
                    if(Test.isRunningTest()){
                        Util_Common.triggerSet.add('updateCurrencyName');    
                    }
                }
                
                
                
            }
            if(trigger.isDelete){
                QuoteTriggerHandler.stopDeletingApprovedQuote(Trigger.old);
            }
            
        }
        if(trigger.isAfter){
            if(Trigger.isInsert){
                QuoteTriggerHandler.updateInstiOrderRefeNo(Trigger.New);
            }
            if(trigger.isDelete){
                QuoteTriggerHandler.updateQuoteNameandLastCreated(Trigger.old);
                QuoteTriggerHandler.updateOpportunityAmountOnDelete(Trigger.old);
            }
            if(Trigger.isUpdate){
                if(!Util_Common.triggerSet.contains('updateOppAmount')){
                    if(QuoteTriggerHandler.Recursioncheck == true) 
                    {
                        QuoteTriggerHandler.updateOppAmount(Trigger.new,Trigger.oldMap,Trigger.newMap);
                    }
                    QuoteTriggerHandler.updateInstiOrderRefeNo(Trigger.New);
                    QuoteTriggerHandler.updateQuoteLineItem(Trigger.New);
                    if(Test.isRunningTest()){
                        Util_Common.triggerSet.add('updateOppAmount');    
                    }
                }
            }
        }
    }
}