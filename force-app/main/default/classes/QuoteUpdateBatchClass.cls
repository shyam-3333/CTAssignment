public class QuoteUpdateBatchClass implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, (SELECT Id FROM Quotes order by CreatedDate desc limit 1) FROM Opportunity WHERE CreatedDate = LAST_N_DAYS:240');
    }
    
    public void execute(Database.BatchableContext BC, List<Opportunity> scope){
        system.debug('scope.size:====='+scope.size());
        List<string> QuoteIdList = new List<string>();
        List<quote> quoteList = new List<quote>();
        for(Opportunity opp: scope){
            if(opp.Quotes.size() > 0){
                QuoteIdList.add(opp.Quotes[0].id);
            }
        }
        system.debug('QuoteIdList:==='+QuoteIdList);
        for(quote q : [SELECT Id,Last_Created_Quote__c from quote where id IN:QuoteIdList]){
            if(q.Last_Created_Quote__c != true){
                q.Last_Created_Quote__c = true;
                quoteList.add(q);  
            }
        }
        
        if(!quoteList.isEmpty()){
            update quoteList;
        }
    }
    
    public void finish(Database.BatchableContext BC){
        messaging.SingleEmailMessage msg =  new messaging.SingleEmailMessage();
        msg.setToAddresses(new List<String>{'sfdcadmin@titan.co.in'});
        msg.setPlainTextBody('Batch completed');
        msg.setSubject('Batch update');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{msg});
    }
}