@isTest(seeAllData=true)
 public class TestQuoteRollUptotalAmount{
     @isTest public static void unitTest(){
        Opportunity o = new Opportunity();
            o.Name = 'Test for Clone';
            o.CloseDate = System.Today() + 10;
            o.StageName = 'Preliminary Opportunity';
            insert o;
        Quote q = new Quote();
            q.Name = 'Test for Clone';
            q.OpportunityID = o.ID;
            q.Total_Price_Qli__c = 123;
            q.Pricebook2Id = Test.getStandardPricebookId();
            q.Product_Sub_Category__c= 'Not Valid On Gold Coin';
            q.Product_Catagory__c='Gift Voucher';
            //q.RecordType.Name= 'Jewellery';
            insert q;
            
            //Pricebook2 standardPB = [select name, isactive from Pricebook2 where IsStandard = true Limit 1 ];
          // Pricebook2 prb= new  Pricebook2(Name='Test',Description ='Price Book 2009 Products',IsActive = true);
       /// insert prb;
        
       
        
        
        Product2 objp = new Product2(Name = 'Test Product 1',Product_Category__c='Sonata',Sub_Category__c='Watches' );
        insert objp; 
        Pricebook2 pb2 = new Pricebook2(Name='DIE');
        insert pb2; 
        PricebookEntry pbe =new PricebookEntry(unitprice=0.01,Product2Id=objp.Id,Pricebook2Id=Test.getStandardPricebookId(),IsActive = true); 
        insert pbe;
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardPB.Id, Product2Id = pr.Id, UnitPrice = 10000, IsActive = true, UseStandardPrice = false);
        //insert standardPrice;
        
       // PricebookEntry pbe = new PricebookEntry(Pricebook2Id = prb.Id, Product2Id = pr.Id, UnitPrice = 10000, IsActive = true, UseStandardPrice = true);
        //insert pbe;
        //q.PricebookEntryId = pbe.id;
        update q;       
        QuoteLineItem qi = new QuoteLineItem ();
            qi.quoteId = q.ID;
            qi.Quantity = 2;
            qi.UnitPrice = 12;
            qi.PricebookEntryId = pbe.id;
            qi.Product2Id= objp.id;
            
            //qi.
            //qi.
            Insert qi;
            
           
        
     }
}