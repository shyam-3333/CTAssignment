/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix changed test.starttest() & test.stoptest() position
*/
@isTest (seealldata = true)
public class TestupdateCategorynSubcategory{
    public static testMethod void insertUpdate(){
        Account ac= new Account(Name='Test');
        insert ac;
        Contract_Details__c condt = new Contract_Details__c(Discount__c = 5,Valid_From__c = system.now().adddays(-5),Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Value_From__c = 50,Value_To__c =2000);
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        //p2.Product_Category__c = null;
        //p2.Sub_Category__c = '';
        //update p2;
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
       Id OPPORTUNITYRECORDTYPEJEWELLERY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id,Type='New Opportunity');
        insert opp;
       
        Id QUOTERECORDTYPEMBA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAQUOTE).getRecordTypeId();
        Id QUOTERECORDTYPEJEWELLERY = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000.50,RecordTypeId=QUOTERECORDTYPEMBA,Total_Price_Qli__c=123456,Contract_Approval__c = true,Contract_Approval_Status__c='Approved',Product_for_Approval__c='Jewellery Products All'); 
        test.startTest();//<T01>
        insert q;
        update q;
        
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id=p2.Id);
        insert qli;
        update qli;
        Test.stopTest();//<T01>
        //QuoteLineItem qli1 = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id= p2.Id );
        //insert qli1;
        
    }
     public static testMethod void qlidelete(){
        Account ac= new Account(Name='Test');
        insert ac;
        Contract_Details__c condt = new Contract_Details__c(Discount__c = 5,Valid_From__c = system.now().adddays(-5),Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Value_From__c = 50,Value_To__c =2000);
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true,Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        //p2.Product_Category__c = null;
        //p2.Sub_Category__c = '';
        //update p2;
        
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        Id OPPORTUNITYRECORDTYPEJEWELLERY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id,Type='New Opportunity');
        insert opp;
        
        Id QUOTERECORDTYPEMBA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAQUOTE).getRecordTypeId();
        Id QUOTERECORDTYPEJEWELLERY = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000.50,RecordTypeId=QUOTERECORDTYPEMBA,Total_Price_Qli__c=123456,Contract_Approval__c = true,Contract_Approval_Status__c='Approved',Product_for_Approval__c='Jewellery Products All'); 
        test.startTest();//<T01>
        insert q;
        update q;
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id= p2.Id);
        insert qli;
        update qli;
         test.stopTest();//<T01>
        QuoteLineItem qli1 = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id= p2.Id);
        insert qli1;
        update qli1;
        delete qli;
       
    }
     public static testMethod void qlidelete1(){
        Account ac= new Account(Name='Test');
        insert ac;
        Contract_Details__c condt = new Contract_Details__c(Discount__c = 5,Valid_From__c = system.now().adddays(-5),Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Value_From__c = 50,Value_To__c =2000);
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        //p2.Product_Category__c = null;
        //p2.Sub_Category__c = '';
        //update p2;
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        Id OPPORTUNITYRECORDTYPEJEWELLERY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id,Type='New Opportunity');
        insert opp;
        
        Id QUOTERECORDTYPEMBA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAQUOTE).getRecordTypeId();
        Id QUOTERECORDTYPEJEWELLERY = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000.50,RecordTypeId=QUOTERECORDTYPEMBA,Total_Price_Qli__c=100000); 
        test.startTest();//<T01>
        insert q;
        update q;
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id= p2.Id);
        insert qli;
        update qli;
         test.stopTest();//<T01>
        //QuoteLineItem qli1 = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id= p2.Id);
        //insert qli1;
        List<QuoteLineItem> qlItem=[select Id,Product_Catagory__c,Product_Sub_Category__c from QuoteLineItem where id =: q.Id];
        String val1;
        String val2;
        For(QuoteLineItem qt:qlItem){
            val1=qt.Product_Catagory__c;
            val2=qt.Product_Sub_Category__c;
        }
        //QuoteLineItem qlii = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id);        
        //insert qlii;
      //delete qlii;
    }
    
    public static testMethod void createQuote(){
        
    Account ac= new Account(Name='Test',Corp_Contract_Number__c=20);
        insert ac;
       
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches',Extra_Charges__c='true');
        insert p2;
        p2.Product_Category__c = 'Titan';
        p2.Sub_Category__c = 'Watches';
        update p2;
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;     
         Contract_Details__c condt = new Contract_Details__c(Discount__c = 5,Valid_From__c = system.now().adddays(-5),Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Value_From__c = 50,Value_To__c =2000,Customer__c=ac.Id);
        Id OPPORTUNITYRECORDTYPEJEWELLERY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id);
        insert opp;
         
        Id QUOTERECORDTYPEMBA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAQUOTE).getRecordTypeId();
        Id QUOTERECORDTYPEJEWELLERY = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000.50,RecordTypeId=QUOTERECORDTYPEMBA,Total_Price_Qli__c=123456,Contract_Approval__c = true,Contract_Approval_Status__c='Approved',Product_for_Approval__c='Jewellery Products All'); 
       
        //insert q;
        
        
       // qq1.numberToWordsQuoteApproval.quoteid=quo.id;
  
        Quote q1= new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000,RecordTypeId=QUOTERECORDTYPEJEWELLERY,Is_Free_Of_Customization_Approved__c='YES',Quote_Currency__c='INR'); 
        
        //insert q1;
        list<Quote> insquote = new list<Quote>();
        insquote.add(q);
        insquote.add(q1);
        test.startTest();//<T01>
        insert insquote;
        Quote_Items__c qt1 = new Quote_Items__c();
        qt1.Quote__c= q.id;
        qt1.S_No__c = 1234;
        qt1.Unit_Price__c=10000;
        qt1.Quantity__c=10;
        qt1.Part_No__c ='1';
        qt1.Batch_Quantity__c=5;
        insert qt1;
          system.debug('QI'+qt1);
         q.Name = 'Field1';
         q.CurrencyIsoCode='INR';
       
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 1,PricebookEntryId =pbe.Id, Product2id=p2.Id);
        //insert qli;
         
        
       
        
        QuoteLineItem qli1 = new QuoteLineItem(QuoteId = q1.Id,UnitPrice = 10000.00,Quantity = 1,PricebookEntryId =pbe.Id, Product2id= p2.Id);
        //insert qli1;
        list<QuoteLineItem>insqlitem = new list<QuoteLineItem>();
        insqlitem.add(qli);
        insqlitem.add(qli1);
       
         insert insqlitem;
        QuoteLineItem qq =[select id,QuoteId,PricebookEntry.Product2.Product_Category__c from QuoteLineItem where QuoteId =:q.id];
          system.debug('qq'+qq);
         update q;
         //update q1;
         test.stopTest();//<T01>
        delete qli1;
        delete qli;
        
       
    }

 public static testMethod void createQuote1(){
     
     QuoteTriggerHandler Qt = new QuoteTriggerHandler();
     Qt.Dummycoverage();
    Account ac= new Account(Name='Test',Corp_Contract_Number__c=20);
        insert ac;
       
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true, Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        p2.Product_Category__c = 'Titan';
        p2.Sub_Category__c = 'Watches';
        update p2;
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;     
         Contract_Details__c condt = new Contract_Details__c(Discount__c = 5,Valid_From__c = system.now().adddays(-5),Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Value_From__c = 50,Value_To__c =2000);
        Id OPPORTUNITYRECORDTYPEJEWELLERY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Proforma Invoice',CloseDate = System.today(),AccountId = ac.id);
        insert opp;
        
        Id QUOTERECORDTYPEMBA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAQUOTE).getRecordTypeId();
        Id QUOTERECORDTYPEJEWELLERY = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000.50,RecordTypeId=QUOTERECORDTYPEMBA,Total_Price_Qli__c=123456,Contract_Approval__c = true,Contract_Approval_Status__c='Approved',Product_for_Approval__c='Jewellery Products All',CurrencyIsoCode='EUR'); 
        test.startTest();//<T01>
        insert q;
      
        Quote q1= new Quote(OpportunityId = opp.Id,Name = 'Field',Sent_to_Approval__c = false,Price_After_Discount__c = 98,Price_Before_Discount__c =100,
        Pricebook2Id = standardPB.Id,Quote_Parity_Value__c = 3,Total_AMC__c=100000,RecordTypeId=QUOTERECORDTYPEJEWELLERY,Is_Free_Of_Customization_Approved__c='YES'); 
        
        insert q1;
        q1.Name = 'Field1';
        update q1;
       
        Quote_Items__c qt1 = new Quote_Items__c();
        qt1.Quote__c= q.id;
        qt1.S_No__c = 1234;
        qt1.Unit_Price__c=10000;
        qt1.Quantity__c=10;
        qt1.Part_No__c ='2';
        qt1.Batch_Quantity__c=5;
        insert qt1;
       
         system.debug('QI'+qt1);
         q.Name = 'Field1';
         q.CurrencyIsoCode='INR';
          update q;
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id=p2.Id);
        insert qli;
       
        test.stopTest();//<T01>
        
        QuoteLineItem qli1 = new QuoteLineItem(QuoteId = q1.Id,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id, Product2id= p2.Id);
        insert qli1;
        delete qli1;
        delete qli;
        
       
    }

    @isTest
    public static void UpdateContractApprovalFunction(){
         Test.startTest();
        Account ac= new Account();
        ac.Name='Test';
        insert ac;
        
        Pricebook2  standardPB = new Pricebook2();
        standardPB = [select id from Pricebook2 where isStandard=true limit 1];
        
         Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName ='Proforma Invoice';
        opp.CloseDate = System.today();
        opp.AccountId = ac.id;
        insert opp;
        
        Quote q = new Quote();
        q.OpportunityId = opp.Id;
        q.Name = 'Field';
        q.Email='test@gmail.com';
        q.Pricebook2Id =standardPB.id;
        // q.ContactId = conNew.id;
        insert q;
        q.id=q.id;
        update q;
        
        
    }

}