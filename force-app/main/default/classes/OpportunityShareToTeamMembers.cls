public class OpportunityShareToTeamMembers {
    
    public void whileInsert(list<opportunity> newList){
        List<OpportunityShare> oppShares = new List<OpportunityShare>();
        for(opportunity i : newList)
        {
            if(i.Member2__c != null && i.Member2__c != i.OwnerId){
                OpportunityShare os = new OpportunityShare();
                os.OpportunityId = i.id; // *** ERROR - not writable ***
                os.OpportunityAccessLevel = 'Edit';
                os.UserOrGroupId = i.Member2__c;
                os.RowCause = 'Manual';
                oppShares.add(os);
            }
            if(i.Member1__c != null && i.Member1__c != i.OwnerId){
                OpportunityShare os1 = new OpportunityShare();
                os1.OpportunityId = i.id; // *** ERROR - not writable ***
                os1.OpportunityAccessLevel = 'Edit';
                os1.UserOrGroupId = i.Member1__c;
                os1.RowCause = 'Manual';
                oppShares.add(os1); 
            }
            
        }
        if(oppshares.size()>0){
            insert oppShares;
        }
    }
    public void whileUpdate(list<opportunity> newList,map<Id,opportunity> oldMap){
        List<OpportunityShare> oppShares = new List<OpportunityShare>();
        for(opportunity i : newList)
        {
            if(i.Member2__c != oldMap.get(i.Id).Member2__c && i.Member2__c != i.OwnerId ){
                OpportunityShare os = new OpportunityShare();
                os.OpportunityId = i.id; // *** ERROR - not writable ***
                os.OpportunityAccessLevel = 'Edit';
                os.UserOrGroupId = i.Member2__c;
                os.RowCause = 'Manual';
                oppShares.add(os);
            }
            if(i.Member1__c != oldMap.get(i.Id).Member1__c && i.Member1__c != i.OwnerId){
                OpportunityShare os1 = new OpportunityShare();
                os1.OpportunityId = i.id; // *** ERROR - not writable ***
                os1.OpportunityAccessLevel = 'Edit';
                os1.UserOrGroupId = i.Member1__c;
                os1.RowCause = 'Manual';
                oppShares.add(os1); 
            }
             
        }
        if(oppshares.size()>0){
            insert oppShares;
        }
        
    }
}