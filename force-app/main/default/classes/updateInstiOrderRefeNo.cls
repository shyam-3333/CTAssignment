@isTest
private class updateInstiOrderRefeNo{

    static testMethod void testNewChildObj() {
    Account acc = new Account(name='demo',Industry='demo',Region_Picklist__c='north');
    Insert Acc;
    
    Opportunity opp = new Opportunity(name='test',INSTI_Order_Reference__c = '2016/12345',AccountId = acc.id,StageName='new', Type= 'new Opportunity',CloseDate=system.today(),Region_Picklist__c='north',Amount=500);
    insert opp;
    
      Quote qc = new Quote(name='test ashutosh',OpportunityId=opp.id);
    insert qc;
    update opp;
   
  
}
}