@isTest(seeAllData = true)
class TestTrigger_Update_PriceOn_Opp_Prod {
    static testmethod void TestTrigger_Update_PriceOn_Opp_Prod(){
            Test.startTest();
            Account acct= new Account(Name='Test');
            insert acct;
       
            Opportunity opp = new Opportunity();
            opp.Name = 'test';
            opp.AccountId = acct.ID;
            opp.CloseDate = system.today();
            opp.StageName = 'Quotation Submission';
            opp.RFQ_Received_Date_Date__c = system.today();
            opp.RFQ_Due_Date__c = system.today();      
            insert opp;
            system.assertEquals('Quotation Submission',opp.StageName);
            Contract_Details__c condt = new Contract_Details__c(Discount__c = 5,Valid_From__c = system.now().adddays(-5),Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Value_From__c = 50,Value_To__c =2000);
            
            Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
            insert p2;
            
            Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
            
            PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
            insert pbe;                  
     
            OpportunityLineItem oLi2 = new OpportunityLineItem(PricebookEntryId=pbe.Id,OpportunityId=opp.Id,Quantity=10,TotalPrice=100);
            oLi2.Material_Cost_Piece__c = 10;
            oLi2.Value_ADD_Piece__c = 10;
            oLi2.Spl_Process_Cost_Piece__c = 10;
            oLi2.BOI_Cost_Piece__c = 10;
            oLi2.Quantity = 10;
            insert oLi2;    
            system.debug('opp line item values-------------->'+oLi2);
            Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
            Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3); 
            insert q;
            
            QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id=p2.Id);
            insert qli;
            
            Test.stopTest();
        
    }
    
   
}