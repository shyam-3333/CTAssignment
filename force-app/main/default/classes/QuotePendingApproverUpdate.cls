/*
Author: Deepak Singh G
Created date: 20/2/2020
Description: On update if the record is submitted for approval and pending this class fetches the approver data and 
             stores in opportunity.
*/
public class QuotePendingApproverUpdate {
    
    public void checkPendingQuotes(list<quote> newList, map<id,quote> oldMap){
        list<string> quoteIdWithStatus = new List<string>();
        for(quote q1 :newList){
            if(q1.Approval_status_to_opportunity__c == 'Pending' ){
                quoteIdWithStatus.add(q1.Id+','+q1.OpportunityId);
            }
        }
        if(quoteIdWithStatus.size()>0){
            callFuture(quoteIdWithStatus);
        }
    }
    public class wrapperClass{
        Id opportunityId;
        Id quoteId;
        public wrapperClass(list<string> str){
            this.opportunityId = str[0];
            this.quoteId = str[1];
        }
    }
    @future
    public static void callFuture(list<string> quoteAndOpportunityIds){
        list<wrapperClass> wrapList = new list<wrapperClass>();
         map<id,id> QuoteOppId = new map<id,id>();
        set<id> ProcessInstanceIds = new set<id>();
        Map<id,string> QuoteIDAndApprover = new Map<id,string>();
        list<opportunity> oppToUpdate = new list<opportunity>();
        for(string str: quoteAndOpportunityIds){
            list<string> QuoteAndOpportuniyId = str.split(',');
            QuoteOppId.put(QuoteAndOpportuniyId[0],QuoteAndOpportuniyId[1]);
            wrapperClass wrap = new wrapperClass(QuoteAndOpportuniyId);
            wrapList.add(wrap);
        }
        for(ProcessInstance PI : [SELECT IsDeleted, Id, TargetObjectId,status FROM ProcessInstance where TargetObjectId = :QuoteOppId.KeySet() and status = 'Pending']){
            ProcessInstanceIds.add(PI.Id);
        }
        for(ProcessInstanceWorkitem PIWI :[SELECT Id,ProcessInstanceId,ProcessInstance.TargetObjectId,  Actor.Name FROM ProcessInstanceWorkitem where ProcessInstanceId = :ProcessInstanceIds]){
            QuoteIDAndApprover.put(PIWI.ProcessInstance.TargetObjectId,PIWI.Actor.Name);
        }
        for(id quoteId :QuoteIDAndApprover.keySet()){
            Opportunity opp = new opportunity();
            opp.Id = QuoteOppId.get(quoteId);
            opp.Quote_Approver__c = QuoteIDAndApprover.get(quoteId);
            opp.Quote_Approval_Status__c = 'Pending';
            oppToUpdate.add(opp);
        }
        update oppToUpdate;
    }
}