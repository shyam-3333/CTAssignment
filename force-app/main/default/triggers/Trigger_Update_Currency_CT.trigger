trigger Trigger_Update_Currency_CT on Cost_Tracking__c (before insert) {

    Set<ID> oppid = new Set<ID>();
    Map<ID,String> oppcurr = new Map<ID,String>();
    Set<ID> ctid = new Set<ID>();
    List<Cost_Tracking__c> ctlist = new List<Cost_Tracking__c>();
    
    for(Cost_Tracking__c ct : Trigger.New){
        oppid.add(ct.Opportunity__c);
        ctid.add(ct.id);
    }
    
    for(Opportunity o : [select ID,CurrencyISOCode from Opportunity where ID IN: oppid]){
        oppcurr.put(o.Id,o.CurrencyISOCode);
    }
    
    for(Cost_Tracking__c ct : Trigger.New){
        ct.CurrencyISOCode = oppcurr.get(ct.Opportunity__c);
    }
    
    for(Cost_Tracking__c ct : [select Id,Final__c from Cost_Tracking__c where ID NOT IN: ctid AND Opportunity__c IN: oppid]){
        Cost_Tracking__c ct1 = new Cost_Tracking__c(ID = ct.ID);
        ct1.Final__c = false;
        ctlist.add(ct1);
    }
    
    Update ctlist;
}