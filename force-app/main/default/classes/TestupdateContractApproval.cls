/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix changed test.starttest() & test.stoptest() position
*/
@isTest (seealldata = false)
public class TestupdateContractApproval{
    public static testMethod void insertUpdate(){
       
        Account ac= new Account(Name='Test');
        insert ac;
        list<Contract_Details__c> contractlst = new list<Contract_Details__c>();
        Contract_Details__c condt = new Contract_Details__c(Customer__c=ac.Id,Discount__c = 15,Valid_From__c = system.now(),
                                                            Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Product_Sub_Category__c='Watches',Value_From__c = 50,  
                                                            Value_To__c =500000 );
        contractlst.add(condt);
        
        Contract_Details__c condt1 = new Contract_Details__c(Customer__c=ac.Id,Discount__c = 15,Valid_From__c = system.now(),
                                                            Valid_To__c = system.now().adddays(5),Brand__c = 'Sonata',Product_Sub_Category__c='Watches',
                                                            Value_From__c = 50,Value_To__c =500000);
        contractlst.add(condt1);
        
        if(contractlst.size()>0)
        insert contractlst;
       
                
        Product2 p2 = new product2(name='unittest');
        p2.Family = 'License';
        p2.Product_Category__c = 'Titan';
        p2.Sub_Category__c = 'Watches';
        insert p2;
        //Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId ,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Revised Quote',CloseDate = System.today(),AccountId = ac.id);
        insert opp;  
       list<Quote> qlist = new list<Quote>();
                           
        Quote q= new Quote(OpportunityId = opp.Id,Name = 'Field',Approval_Status_count_LineItem__c = '',Quote_Status_watches_new__c = '',
                           Quote_Status_Customization__c = '',Contract_Approval_Status__c = 'Approved',Approval_Status_Quote__c = 'Approved',
                           Contract_Approval__c = True,Product_for_Approval__c = 'Watches / Accessories',
                           Product_Catagory__c='Titan',Product_Sub_Category__c='Watches',Sent_to_Approval__c = false,Price_After_Discount__c = 5000,
                           Price_Before_Discount__c =100,Pricebook2Id = pricebookId ,Quote_Parity_Value__c = 3,Order_Type__c = 'Regular'); 
        RecordType rtd = [select id,Name from RecordType where SobjectType='Quote' and Name='Watches' Limit 1];
        //q.Discount_Corp__c = contractlst[0].Discount__c;
        q.Approved_Discount_corp__c=q.Discount_Corp__c;
        //q.AccountId = ac.Id;
        q.Approved_QuoteLineItem__c=q.Total_No_of_QuoteLineItem__c;
        q.Approval_Status_Quote__c='Approved';
        q.Quote_Status_watches_new__c='';
        q.Approval_Status_count_LineItem__c='';
        q.recordTypeId=rtd.id; 
        q.Product_for_Approval__c='Jewellery Products All';
        q.Contract_Approval__c = false; 
        q.Contract_Approval_Status__c = 'pending';
        qlist.add(q);
        Quote q1= new Quote(OpportunityId = opp.Id,Name = 'Field',Approval_Status_count_LineItem__c = '',Quote_Status_watches_new__c = '',
                           Quote_Status_Customization__c = '',Contract_Approval_Status__c = 'Approval Required',Approval_Status_Quote__c = 'Approved',
                           Contract_Approval__c = True,Product_for_Approval__c = 'Watches / Accessories',
                           Product_Catagory__c='Titan',Product_Sub_Category__c='Watches',Sent_to_Approval__c = false,Price_After_Discount__c = 5000,
                           Price_Before_Discount__c =100,Pricebook2Id = pricebookId ,Quote_Parity_Value__c = 3,Order_Type__c = 'Regular'); 
        RecordType rtd1 = [select id,Name from RecordType where SobjectType='Quote' and Name='Watches' Limit 1];
        q1.Approved_Discount_corp__c=q.Discount_Corp__c;
        //q1.AccountId = ac.Id;
        q1.Approved_QuoteLineItem__c=q.Total_No_of_QuoteLineItem__c;
        q1.Approval_Status_Quote__c='Approved';
        q1.Quote_Status_watches_new__c='';
        q1.Approval_Status_count_LineItem__c='';
        q1.recordTypeId=rtd1.id; 
        q1.Product_for_Approval__c='Jewellery Products All';
        q1.Contract_Approval__c = false; 
        q1.Contract_Approval_Status__c = 'pending';
        q1.Order_Type__c = 'Regular';
        qlist.add(q1);
        test.startTest();//<T01>
        if(qlist.size()>0)
         insert qlist;
        test.stopTest();
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,Discount_c__c=5,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id);
        insert qli;
        
    }
       
    public static testMethod void insertUpdatetwo(){
        test.startTest();
        Account ac= new Account(Name='Test');
        insert ac;
        Contract_Details__c condt = new Contract_Details__c(Customer__c=ac.Id,Discount__c = 15,Valid_From__c = system.now(),
                                                            Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Product_Sub_Category__c='Watches',Value_From__c = 50,  
                                                            Value_To__c =500000 );
        insert condt;
        Contract_Details__c condt1 = new Contract_Details__c(Customer__c=ac.Id,Discount__c = 15,Valid_From__c = system.now(),
                                                            Valid_To__c = system.now().adddays(5),Brand__c = 'Sonata',Product_Sub_Category__c='Watches',
                                                            Value_From__c = 50,Value_To__c =500000);
        insert condt1;        
        
        Product2 p2 = new product2(name='unittest');
        p2.Family = 'License';
        p2.Product_Category__c = 'Titan';
        p2.Sub_Category__c = 'Watches';
        insert p2;
        //Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId ,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Quote_Preparation',CloseDate = System.today(),AccountId = ac.id);
        insert opp;  
        list<Quote> qlist = new list<Quote>();                     
        Quote q= new Quote(OpportunityId = opp.Id,Name = 'Field',Approval_Status_count_LineItem__c = '',Quote_Status_watches_new__c = 'test',
                           Quote_Status_Customization__c = '',Contract_Approval_Status__c = 'Approval Required',Approval_Status_Quote__c = 'Approved',
                           Contract_Approval__c = True,Product_for_Approval__c = 'Watches / Accessories',
                           Product_Catagory__c='Titan',Product_Sub_Category__c='Watches',Sent_to_Approval__c = false,Price_After_Discount__c = 5000,
                           Price_Before_Discount__c =100,Pricebook2Id = pricebookId ,Quote_Parity_Value__c = 3,Order_Type__c = 'Regular'); 
        RecordType rtd = [select id,Name from RecordType where SobjectType='Quote' and Name='Watches' Limit 1];
        q.Approved_Discount_corp__c=q.Discount_Corp__c;
        q.Approved_QuoteLineItem__c=q.Total_No_of_QuoteLineItem__c;
        q.Approval_Status_Quote__c='Approved';
        q.Quote_Status_watches_new__c='';
        q.Approval_Status_count_LineItem__c='';
        q.recordTypeId=rtd.id; 
        q.Contract_Approval__c = false; 
        q.Customization_Payment_Criteria__c ='Discounted';
        q.Contract_Approval_Status__c = 'pending';
        qlist.add(q);
        Quote q1= new Quote(OpportunityId = opp.Id,Name = 'Field',Approval_Status_count_LineItem__c = '',Quote_Status_watches_new__c = '',
                           Quote_Status_Customization__c = '',Contract_Approval_Status__c = 'Approval Required',Approval_Status_Quote__c = 'Approved',
                           Contract_Approval__c = True,Product_for_Approval__c = 'Jewellery Products All',
                           Product_Catagory__c='Titan',Product_Sub_Category__c='Watches',Sent_to_Approval__c = false,Price_After_Discount__c = 5000,
                           Price_Before_Discount__c =100,Pricebook2Id = pricebookId ,Quote_Parity_Value__c = 3,Order_Type__c = 'Regular'); 
        RecordType rtd1 = [select id,Name from RecordType where SobjectType='Quote' and Name='Jewellery' Limit 1];
        q1.Approved_Discount_corp__c=q1.Discount_Corp__c;
        q1.Approved_QuoteLineItem__c=q1.Total_No_of_QuoteLineItem__c;
        q1.Approval_Status_Quote__c='Approved';
        q1.Quote_Status_watches_new__c='';
        q1.Approval_Status_count_LineItem__c='';
        q1.recordTypeId=rtd1.id; 
        q1.Contract_Approval__c = false; 
        q1.Contract_Approval_Status__c = 'pending';
        q1.Customization_Payment_Criteria__c ='';
        q1.Order_Type__c = 'Regular';
        qlist.add(q1);
        
        if(qlist.size()>0){
        	insert qlist;    
        }
         
        list<QuoteLineItem> qliLst = new list<QuoteLineItem>();
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,Discount_c__c=5,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id);
        qliLst.add(qli);
        QuoteLineItem qli2 = new QuoteLineItem(QuoteId = q.Id,Discount_c__c=10,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id);
        qliLst.add(qli2);
        if(qliLst.size()>0){
            insert qliLst; 
        }
        QuoteLineItem ql = new QuoteLineItem();
        ql.Id = qli.Id;
        ql.Discount_c__c = 20;
        update ql;
        
        test.stopTest();//<T01>

	}
    public static testMethod void insertUpdate3(){
        test.startTest();
        Account ac= new Account(Name='Test');
        insert ac;
        Contract_Details__c condt = new Contract_Details__c(Customer__c=ac.Id,Discount__c = 15,Valid_From__c = system.now(),
                                                            Valid_To__c = system.now().adddays(5),Brand__c = 'Titan',Product_Sub_Category__c='Watches',Value_From__c = 50,  
                                                            Value_To__c =500000 );
        insert condt;
        Contract_Details__c condt1 = new Contract_Details__c(Customer__c=ac.Id,Discount__c = 15,Valid_From__c = system.now(),
                                                            Valid_To__c = system.now().adddays(5),Brand__c = 'Sonata',Product_Sub_Category__c='Watches',
                                                            Value_From__c = 50,Value_To__c =500000);
        insert condt1;          
        
        Product2 p2 = new product2(name='unittest');
        p2.Family = 'License';
        p2.Product_Category__c = 'Gift Voucher';
        p2.Sub_Category__c = 'Valid on Gold Coins';
        insert p2;
        //Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId ,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe;                  
        
        Opportunity opp = new Opportunity(Name = 'Test',StageName ='Quote_Preparation',CloseDate = System.today(),AccountId = ac.id);
        insert opp;  
                             
        Quote q= new Quote(OpportunityId = opp.Id,Name = 'Field',Approval_Status_count_LineItem__c = '',Quote_Status_watches_new__c = 'test',
                           Quote_Status_Customization__c = '',Contract_Approval_Status__c = 'Approval Required',Approval_Status_Quote__c = 'Approved',
                           Contract_Approval__c = True,Product_for_Approval__c = 'Watches / Accessories',
                           Product_Catagory__c='Gift Voucher',Product_Sub_Category__c='Valid on Gold Coins',Sent_to_Approval__c = false,Price_After_Discount__c = 5000,
                           Price_Before_Discount__c =100,Pricebook2Id = pricebookId ,Quote_Parity_Value__c = 3); 
        RecordType rtd = [select id,Name from RecordType where SobjectType='Quote' and Name='Watches' Limit 1];
        
        q.recordTypeId=rtd.id; 
        q.Contract_Approval__c = false; 
        q.Customization_Payment_Criteria__c ='Discounted';
        q.Contract_Approval_Status__c = 'pending';
        q.Order_Type__c = 'Regular';
        insert q;
        Quote q1= new Quote(OpportunityId = opp.Id,Name = 'Field',Approval_Status_count_LineItem__c = '',Quote_Status_watches_new__c = 'test',
                           Quote_Status_Customization__c = '',Contract_Approval_Status__c = 'Approval Required',Approval_Status_Quote__c = 'Approved',
                           Contract_Approval__c = True,Product_for_Approval__c = 'Watches / Accessories',
                           Product_Catagory__c='Gift Voucher',Product_Sub_Category__c='Valid on Gold Coins',Sent_to_Approval__c = false,Price_After_Discount__c = 5000,
                           Price_Before_Discount__c =100,Pricebook2Id = pricebookId ,Quote_Parity_Value__c = 3,Order_Type__c = 'Regular'); 
        RecordType rtd1 = [select id,Name from RecordType where SobjectType='Quote' and Name='Watches' Limit 1];
         
        q1.recordTypeId=rtd1.id; 
        q1.Contract_Approval__c = false; 
        q1.Contract_Approval_Status__c = 'pending';
        q1.Customization_Payment_Criteria__c ='Discounted';
        insert q1;
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,Discount_c__c=5,UnitPrice = 10000.00,Quantity = 2,PricebookEntryId =pbe.Id);
        insert qli;
                    
        delete qli;
       
        test.stopTest();      
    }
     
  }