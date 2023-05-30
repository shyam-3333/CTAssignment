trigger Trigger_Update_Quantity on OpportunityLineItem (before insert) {

    Set<ID> prod_id = new Set<ID>();
    Map<Id,Decimal> prod_quan = new Map<ID,Decimal>();
    List<OpportunityLineItem> updateoli = new List<OpportunityLineItem>();
    Map<ID,Decimal> oppunit = new Map<Id,Decimal>();
    
    for(OpportunityLineItem oli : Trigger.New){
        prod_id.add(oli.ProductID__c);
        System.debug(prod_id);
    }
    
    for(Product2 p : [select ID,Average_EAU__c from Product2 where ID IN: prod_id]){
        if(p.Average_EAU__c != null)
            prod_quan.put(p.ID,p.Average_EAU__c);
        else
            prod_quan.put(p.ID,1);    
    }
    
    for(OpportunityLineItem oli : Trigger.New){
        if(oli.Quantity == 1)
           oli.Quantity = prod_quan.get(oli.ProductID__c);
    }
}