@isTest(seealldata= true)

private class TestNumberToWords {

    static testMethod void myUnitTest() {
        Account ac= new Account();
        ac.Name='Test';
        insert ac;
     
        Contact conNew = new Contact();
        conNew.Firstname = 'PeeWee';
        conNew.LastName = 'Herman';
        conNew.AccountId = ac.Id;
        conNew.Email='sachin.deshmukh@kvpcorp.com';
        insert conNew;
       
        Product2 p2 = new Product2();
        p2.Name = 'Anti-infectives 2007';
        p2.Family = 'Best Practices';
        p2.IsActive = true;
        insert p2;
        
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];

        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = standardPB.Id;
        pbe.Product2Id = p2.Id;
        pbe.UnitPrice = 10000;
        pbe.IsActive = true;
        pbe.UseStandardPrice = false;
        insert pbe;       
            
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName ='Proforma Invoice';
        opp.CloseDate = System.today();
        opp.AccountId = ac.id;
        insert opp;
        
        Contract_Details__c condt = new Contract_Details__c();
        condt.Discount__c = 5;
        condt.Valid_From__c = system.now().adddays(-5);
        condt.Valid_To__c = system.now().adddays(5);
        condt.Brand__c = 'Titan';
        condt.Value_From__c = 50;
        condt.Value_To__c =2000;
        
       
        Quote q = new Quote();
        q.OpportunityId = opp.Id;
        q.Name = 'Field';
        q.ContactId = conNew.id;
        q.Sent_to_Approval__c = false;
        q.Price_After_Discount__c = 98;
        q.Price_Before_Discount__c =100;
        q.Pricebook2Id = standardPB.Id;
        q.Quote_Parity_Value__c = 3; 
        
        insert q;
        
        update q;
       
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = q.Id;
        qli.UnitPrice = 10000.00;
        qli.Quantity = 2;
        qli.PricebookEntryId =pbe.Id;
        try{
        insert qli;
        }catch(DmlException de){System.debug('*********************************'+de);}
        
        
        
        
       
        
        
   }
   }