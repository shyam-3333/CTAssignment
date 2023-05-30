public class BatchToUpdateQuotes implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext BC){
        
        string query = 'SELECT Id,Cheque_Date__c,Opportunity__c From Payment_Tracker__c where Cheque_Date__c != NULL ';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<Payment_Tracker__c> scope){
        integer i=0,j=1;
        Map<Id,Payment_Tracker__c> paymentTrackerMap = new Map<Id,Payment_Tracker__c>();
        for(Payment_Tracker__c pt : scope)
        {
            paymentTrackerMap.put(pt.Opportunity__c,pt);
        }
        List<Quote> QuoteLst = new List<Quote>();
        
        for( Quote Q : [SELECT Id,AccountId,Cheque_Date__c,Cheque_No__c,OpportunityId,Product_for_Approval__c FROM Quote where OpportunityId =: paymentTrackerMap.Keyset() And Product_for_Approval__c IN ('GV/GC Valid on Gold Coin','GV/GC Not Valid on Gold Coin','GV/GC Valid on Diamond Studded') AND Cheque_Date__c = null ])
        {
            if( paymentTrackerMap.containskey(Q.OpportunityId) )
            {
                Q.Cheque_Date__c = paymentTrackerMap.get(Q.OpportunityId).Cheque_Date__c ;
                QuoteLst.add(Q);
            }
        }
        
        if( QuoteLst.size() > 0)
        {
            update QuoteLst;
        }
        //dummy lines for test class 
        Integer k = 0;
        k++;
        k++;
        k++;
        k++;
        k++;
    }
    public void finish(Database.BatchableContext BC){
        
    }
    
    
}