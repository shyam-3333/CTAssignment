public class BatchToUpdateProductForApproval implements Database.Batchable<sObject>{
    
    
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        string query = 'select id,Amount,Quote_Count__c from opportunity where RecordType.Name = \'Jewellery\' and createdDATE >= 2019-04-01T00:00:00Z';      return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC,List<opportunity> scope){
        set<id> opportunityIds = new set<id>();
        map<id,string> oppIDWithPFA = new map<id,string>();
        list<opportunity> oppList = new list<opportunity>();
        for(opportunity opp :scope){
            opportunityIds.add(opp.Id);
        }
        for(quote q1 :[select id,Product_for_approval__c,opportunityId from quote where opportunityId in :opportunityIds  order by CreatedDate Asc]){
            oppIDWithPFA.put(q1.opportunityId, q1.Product_for_approval__c);
        }
        for(Id IDs :oppIDWithPFA.keySet()){
            opportunity opp = new opportunity();
            opp.id = IDs;
            Opp.Product_for_approval_Q__c = oppIDWithPFA.get(IDs);
            oppList.add(opp);
        }
        Database.SaveResult [] updateResult = Database.update(oppList, false);
        
        for (Database.SaveResult r : updateResult)
            
        {
            //  system.debug('infos==>'+r);
            if (!r.isSuccess())
                
            {
                for (Database.Error e : r.getErrors())
                    
                    System.debug('Errors in data==>'+e);
            }
            
        }
    }
    public void finish(Database.BatchableContext BC){
        
    }
    
    
}