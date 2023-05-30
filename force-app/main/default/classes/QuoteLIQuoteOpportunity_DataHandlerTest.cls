@isTest(seeAllData=false)
public class QuoteLIQuoteOpportunity_DataHandlerTest {
    static testmethod void QuoteLIQuoteOpportunity_DataHandlermethod(){
        Id rid1= Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Preliminary Type').getRecordTypeId();
        Account ac= new Account();
        ac.Name='Test';
        insert ac;
        
        
        Contact conNew = new Contact();
        conNew.Firstname = 'PeeWee';
        conNew.LastName = 'Herman';
        conNew.AccountId = ac.Id;
        conNew.Email='sachin.deshmukh@kvpcorp.com';
        insert conNew;
        
        Product2 pObj = new Product2();
        pObj.Name = 'Gold Coin 24 Karat';
        pObj.IsActive = true;
        pObj.Product_Category__c = 'Titan';
        pObj.Sub_Category__c = 'Watches';
        
        insert pObj;  
        
     /*   Pricebook2  standardPB = new Pricebook2();
        standardPB = [select id from Pricebook2 where isStandard=true limit 1];
        System.debug('----standardPB------>'+standardPB);*/
        
        Id standardPB = Test.getStandardPricebookId();
        PricebookEntry pbe = new PricebookEntry();
        
       pbe.Pricebook2Id = standardPB;//.Id;
        pbe.Product2Id = pObj.Id;
        pbe.UnitPrice = 10000;
        pbe.IsActive = true;
        pbe.UseStandardPrice = false;
        insert pbe;  
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName ='Proforma Invoice';
        opp.CloseDate = System.today();
        opp.AccountId = ac.id;
        opp.RecordTypeId=rid1;
        opp.Opportunity_Type__c='Dealer Incentive';
        insert opp;
        
        Quote q = new Quote();
        q.OpportunityId = opp.Id;
        q.Name = 'Field';
        q.Email='test@gmail.com';
        q.Pricebook2Id =standardPB;//.id;
        q.ContactId = conNew.id;
        q.CurrencyIsoCode = 'INR';
        insert q;
        
        Quote_Items__c qt1 = new Quote_Items__c();
        qt1.Quote__c= q.id;
        qt1.S_No__c = 1234;
        qt1.Unit_Price__c= 100;
        qt1.Quantity__c=1;
        
        insert qt1;
        
        Test.startTest();
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = q.Id;
        qli.UnitPrice = 10000.00;
        qli.Quantity = 2;
        qli.PricebookEntryId =pbe.Id;
        
        insert qli;
        
        Test.setCurrentPage(Page.QuoteLI_Page);
        
        QuoteLIQuoteOpportunity_DataHandler qliobj = new QuoteLIQuoteOpportunity_DataHandler(new ApexPages.StandardController(qli));
        qliobj.getQuoteData();
        qliobj.redirect('id');
    }
    
    static testmethod void test1(){
        Lead l = new Lead();
         l.Phone = '9009009000';
         l.Email = 'abc@test.com';
         l.MobilePhone ='1234567890';   
         l.LastName = 'Test1';
         l.Company = 'ABC Pvt';
        l.LeadSource = 'TG-CG';
        l.Message__c = 'Test';
        insert l;
       Task t = Util_Common.getFollowUpTask(l,1,'test', 2);
       String s = Util_Common.getError('test');
        Util_Common.sendEmail('test@test.com','test',system.today(),system.today()+1);
         Account a = new Account(Name = 'Test Account for Test');
         insert a;
         Opportunity o1 = new Opportunity();
         Id rid1= Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Preliminary Type').getRecordTypeId();
         o1.Name = 'Test 2 for Opp Test Method ';
         o1.AccountID = a.ID;
         o1.RecordTypeId = rid1;
         //o1.Type = 'Spares';
         o1.StageName = 'Preliminary Opportunity';
         o1.CloseDate = System.Today() + 10;
         o1.Opportunity_Type__c='Dealer Incentive';
        insert o1;
        system.debug('Business_Division_Used__c'+o1.Business_Division_Used__c);
        Cost_Tracking__c ct= Util_Common.insertCostTrack(o1);
        Id rid= Schema.SObjectType.Project_Stage_History__c.getRecordTypeInfosByName().get('MBA').getRecordTypeId();
        Project_Stage_History__c ps = Util_Common.insertProjStageHist('Proforma Invoice',o1.id,rid);
        OpportunityTeamMember op= Util_Common.insertOpptTeam(o1.id,UserInfo.getUserId(),'test');
        
    } 
}