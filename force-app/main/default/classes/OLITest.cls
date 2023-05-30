@isTest

private class OLITest{

    static testMethod void OLITestMethod() {
 
         Opportunity o = new Opportunity();
         o.Name = 'Test for OLI';
         o.StageName = 'Under Study';
         o.CloseDate = System.Today() + 10;
         insert o;
         
        
        Product2 p2 = new product2(name='unittest');
        p2.Family = 'License';
        p2.Product_Category__c = 'Titan';
        p2.Sub_Category__c = 'Watches';
        insert p2;
        
  
         Product2 p3 = new product2(name='unittest');
         p3.Family = 'License';
         p3.Product_Category__c = 'Titan';
         p3.Sub_Category__c = 'Watches';
         insert p3;
         
        
         
         PriceBook2 pb = [select id, Name from PriceBook2 where Name='Standard Price Book' limit 1];
         System.Debug('+++++' + pb);
         
         List<PricebookEntry> pbelist = new List<PricebookEntry>();
         
         PricebookEntry pbe = new PricebookEntry ();
         pbe.Pricebook2Id = pb.ID;
         pbe.Product2Id = p2.ID; 
         pbe.UnitPrice = 1000;
         pbe.isActive = true;
         pbelist.add(pbe);
         
         PricebookEntry pbe1 = new PricebookEntry ();
         pbe1.Pricebook2Id = pb.ID;
         pbe1.Product2Id = p3.ID; 
         pbe1.UnitPrice = 1000;
         pbe1.isActive = true;
         pbelist.add(pbe1);
         
         insert pbelist;
         
         List<OpportunityLineItem> olilist = new List<OpportunityLineItem>();
         
         OpportunityLineItem  oli = new OpportunityLineItem();
          System.Debug('+++++' + pb);
      //   oli.PricebookEntry.Pricebook2Id = pb.ID;
    //     oli.PricebookEntry.Product2Id = p2.ID;
         oli.PricebookEntryId = pbe.ID;
         oli.OpportunityID = o.ID;
         oli.Quantity = 10;
         oli.FA_Price_Piece__c = 100;
         oli.Value_ADD_Piece__c = 100;
         oli.Material_Cost_Piece__c = 100;
         oli.One_Time_Development_Charges_Part__c = 100;
         olilist.add(oli);
         
         OpportunityLineItem  oli1 = new OpportunityLineItem();
       // System.Debug('+++++' + pb);
      //  oli1.PricebookEntry.Pricebook2Id = pb.ID;
      //   oli1.PricebookEntry.Product2Id = p2.ID;
         oli1.OpportunityID = o.ID;
         oli1.PricebookEntryId = pbe1.ID;
         oli1.Quantity = 10;
         olilist.add(oli1);
         
         insert olilist;
         
         Quote q = new Quote();
         q.Name = 'Test for QLI';
         q.OpportunityID = o.Id;
         q.Pricebook2Id  = pb.ID;
         insert q;
         
         QuoteLineItem qli = new QuoteLineItem();
         qli.Quantity = 10;
         qli.PricebookEntryID = pbe.ID;
         qli.QuoteId  = q.ID;
         qli.UnitPrice = 1000;    
         insert qli;
    }
}