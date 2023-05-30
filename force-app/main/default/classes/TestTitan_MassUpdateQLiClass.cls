@isTest(seealldata=true)
public class TestTitan_MassUpdateQLiClass
{

    public static testMethod void unitTest(){
       
        Account ac= new Account(Name='Test');
        insert ac;        
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
         
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id);
        insert opp;
        
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3); 
        insert q;
        list<QuoteLineItem> qlist = new list<QuoteLineItem>();
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id=p2.Id);
        insert qli;
       
        Id qid =[select id from quote limit 1].id;
        system.debug('Quote line items'+qid);
        PageReference pgRef = Page.Titan_MassUpdateQuotelLineItems; 
        Test.setCurrentPage(pgRef);
        ApexPages.currentPage().getParameters().put('QuoteId',q.id );
        test.startTest();
        Titan_MassUpdateQLiClass obj= new Titan_MassUpdateQLiClass();
       // obj.BuildPagination(qlist);
        obj.currentPageNumber=1;
        obj.isFilter=false;
        obj.isTable=false;
        obj.updateQuoteLineItem();
        obj.cancelQuoteLineItem();
        obj.GoToFirstPage();
        test.stopTest();
         
    }
      public static testMethod void unitTest2(){
       test.startTest();
        Account ac= new Account(Name='Test');
        insert ac;        
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id);
        insert opp;
        
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3); 
        insert q;
        
        PageReference pgRef = Page.Titan_MassUpdateQuotelLineItems; 
        Test.setCurrentPage(pgRef);
        ApexPages.currentPage().getParameters().put('QuoteId',q.id );
     
        Titan_MassUpdateQLiClass obj= new Titan_MassUpdateQLiClass();
       // obj.BuildPagination(qlist);
        obj.currentPageNumber=1;
        obj.isFilter=false;
        obj.isTable=false;
      
        obj.updateQuoteLineItem();
        obj.cancelQuoteLineItem();
    

       test.stopTest();
    }
     public static testMethod void unitTest4(){
       
        Account ac= new Account(Name='Test');
        insert ac;        
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id);
        insert opp;
        
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3); 
        insert q;
        list<QuoteLineItem> qlist = new list<QuoteLineItem>();
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id=p2.Id);
        insert qli;
       
        Id qid =[select id from quote limit 1].id;
        system.debug('Quote line items'+qid);
        PageReference pgRef = Page.Titan_MassUpdateQuotelLineItems; 
        Test.setCurrentPage(pgRef);
        ApexPages.currentPage().getParameters().put('QuoteId',q.id );
        
        test.startTest();
        Titan_MassUpdateQLiClass obj= new Titan_MassUpdateQLiClass();
       // obj.BuildPagination(qlist);
        obj.currentPageNumber=1;
        obj.isFilter=false;
        obj.isTable=false;
        obj.updateQuoteLineItem();
        obj.cancelQuoteLineItem();
        obj.GoToLastPage();
        test.stopTest();
         
    }
}