trigger Trigger_Update_PriceOn_Opp_Prod on Product2 (after update) {

    Map<ID,Decimal> matprice = new Map<Id,Decimal>();
    Map<ID,Decimal> valueprice = new Map<Id,Decimal>();
    Map<ID,Decimal> qty = new Map<Id,Decimal>();
    
     Map<ID,Decimal> splprice = new Map<Id,Decimal>();
      Map<ID,Decimal> boiprice = new Map<Id,Decimal>();

    Set<ID> prodid = new Set<ID>();
    Set<String> prodid1 = new Set<String>();
    List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
    List<QuoteLineItem> qlilist = new List<QuoteLineItem>();
    List<PricebookEntry> pbelist = new List<PricebookEntry>();
            
    for(Product2 p : Trigger.New){
        Product2 oldprod = Trigger.oldMap.get(p.ID);
        if(p.Average_EAU__c != oldprod.Average_EAU__c || p.Material_Cost_Piece__c != oldprod.Material_Cost_Piece__c || p.Value_ADD_Piece__c != oldprod.Value_ADD_Piece__c || p.Spl_Process_Cost_Piece__c != oldprod.Spl_Process_Cost_Piece__c || p.BOI_Cost_Piece__c != oldprod.BOI_Cost_Piece__c){
            matprice.put(p.ID,p.Material_Cost_Piece__c);    
            valueprice.put(p.ID,p.Value_ADD_Piece__c);
            
            splprice.put(p.ID,p.Spl_Process_Cost_Piece__c);
            boiprice.put(p.ID,p.BOI_Cost_Piece__c);
            
            qty.put(p.ID,p.Average_EAU__c);
            prodid.add(p.ID);
            prodid1.add(String.valueof(p.ID).substring(0,15));
        }
    }
    
    System.debug(prodid);
    if(prodid.size() > 0){
        for(OpportunityLineItem oli : [select Id,Material_Cost_Piece__c,Quantity,Value_ADD_Piece__c,Spl_Process_Cost_Piece__c,BOI_Cost_Piece__c,ProductID__c from OpportunityLineItem where Opportunity_Stage__c != 'PO Received (Closed Won)' AND Opportunity_Stage__c != 'RFQ Closed' AND Opportunity_Stage__c != 'Closed Lost' AND ProductID__c IN: prodid1]){
             OpportunityLineItem oli1 = new OpportunityLineItem(ID = oli.ID);
             oli1.Material_Cost_Piece__c = matprice.get(oli.ProductID__c);
             oli1.Value_ADD_Piece__c = valueprice.get(oli.ProductID__c);
             
             oli1.Spl_Process_Cost_Piece__c = splprice.get(oli.ProductID__c);
             oli1.BOI_Cost_Piece__c = boiprice.get(oli.ProductID__c);
             
             oli1.Quantity = qty.get(oli.ProductID__c);
             olilist.add(oli1);
        }
        for(QuoteLineItem qli : [select ID,Material_Cost_Piece__c,Value_ADD_Piece__c,Spl_Process_Cost_Piece__c,BOI_Cost_Piece__c,Opportunity_Status__c,PricebookEntry.Product2Id from QuoteLineItem where Opportunity_Status__c != 'PO Received (Closed Won)' AND  Opportunity_Status__c != 'RFQ Closed' AND Opportunity_Status__c != 'Closed Lost' AND PricebookEntry.Product2Id IN: prodid]){
             QuoteLineItem qli1 = new QuoteLineItem (ID = qli.ID);
             qli1.Material_Cost_Piece__c = matprice.get(qli.PricebookEntry.Product2Id);
             qli1.Value_ADD_Piece__c = valueprice.get(qli.PricebookEntry.Product2Id);
             qli1.Spl_Process_Cost_Piece__c = splprice.get(qli.PricebookEntry.Product2Id); 
             qli1.BOI_Cost_Piece__c = boiprice.get(qli.PricebookEntry.Product2Id);            
             qlilist.add(qli1);

        }
        for(PricebookEntry pbe : [select Id,Product2Id,UnitPrice from PricebookEntry where Product2Id IN: prodID]){
            PricebookEntry pbe1 = new PricebookEntry(ID = pbe.ID);
            if(matprice.get(pbe.Product2Id)==null)
            {
            matprice.put(pbe.Product2Id,0);
            }
            if(valueprice.get(pbe.Product2Id)==null)
            {
            valueprice.put(pbe.Product2Id,0);
            }
            if(splprice.get(pbe.Product2Id)==null)
            {
            splprice.put(pbe.Product2Id,0);
            }
            if(boiprice.get(pbe.Product2Id)==null)
            {
            boiprice.put(pbe.Product2Id,0);
            }
            
            pbe1.UnitPrice =  matprice.get(pbe.Product2Id) + valueprice.get(pbe.Product2Id) + splprice.get(pbe.Product2Id) + boiprice.get(pbe.Product2Id);             
            pbelist.add(pbe1);
        }
        
        Update olilist;
        Update qlilist;
        Update pbelist;
    }
}