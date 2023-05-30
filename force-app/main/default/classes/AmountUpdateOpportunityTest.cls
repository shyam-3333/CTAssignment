/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/27/2019   	T01		T01 - Test Class fix 
*/
@isTest
public class AmountUpdateOpportunityTest {
    public static testmethod void chechTest(){
        
        Id CSRecordTypeId  = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        ID QuoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        TriggerStatus__c triggerStat = new TriggerStatus__c(); //insert custom setting data
        triggerStat.Name =  'OpportunityTrigger';
        triggerStat.Active__c = true;
        insert triggerStat;
        
        TriggerStatus__c triggerStats = new TriggerStatus__c(); //insert custom setting data
        triggerStats.Name =  'quoteLineItemTrigger';
        triggerStats.Active__c = true;
        insert triggerStats;
        
        TriggerStatus__c triggerStat1 = new TriggerStatus__c(); //insert custom setting data
        triggerStat1.Name =  'QuoteNameTrigger';
        triggerStat1.Active__c = true;
        insert triggerStat1;
        
        
        Account acc = new Account();
        acc.name = 'Test Acc';
        acc.Delivery_Type__c = 'Export';
        acc.Industry = 'Aerospace & Defense';
        acc.Region_Picklist__c = 'South';
        acc.Company_Type__c = 'OEM';
        insert acc;
        
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name='Test_Opp';
        opp.Amount=10000;
        opp.Temp_amount__c = 10000;
        opp.Type='New Opportunity';
        opp.Region_Picklist__c = 'South';
        opp.CloseDate=System.Today();
        opp.StageName    =     'Requirement Analysis';
        opp.recordTypeId    =    CSRecordTypeId;
        insert opp;
        
        
        Quote q = new Quote();
        q.Name = 'Test_Opp';
        q.OpportunityID = opp.Id;
        q.Total_Price_Qli__c = 24;
        q.Pricebook2Id = Test.getStandardPricebookId();
        q.Product_Sub_Category__c= 'Watches';
        q.Product_Catagory__c='Sonata';
        q.RecordTypeId = QuoteRecordTypeId;
        insert q;

        
        Product2 objp = new Product2(Name = 'Test Product 1',Product_Category__c='Sonata',Sub_Category__c='Watches' );
        insert objp; 
        Pricebook2 pb2 = new Pricebook2(Name='TestPrice');
        insert pb2; 
        PricebookEntry pbe =new PricebookEntry(unitprice=0.01,Product2Id=objp.Id,Pricebook2Id=Test.getStandardPricebookId(),IsActive = true); 
        insert pbe;
        
        QuoteLineItem qi = new QuoteLineItem ();
        qi.quoteId = q.ID;
        qi.Quantity = 2;
        qi.UnitPrice = 12;
        qi.PricebookEntryId = pbe.id;
        qi.Product2Id= objp.id;
        
        Insert qi;
        Test.StartTest();
          
        //opp.Amount = 24;
        //update opp;
        delete q;
        Test.stopTest();
        //opp.Amount = 10000;
        //update opp;
        
    }
    
    public static testmethod void quoteTest(){
 		List<User> lstUser = new List<User>();//<T01>
        User u1 = new User();
        lstUser=[select Id from User  WHERE UserRole.Name like '%Electrical%' and Name='Arun Balasubramaniam S' limit 1];
        if(lstUser.size() > 0){
            u1 = lstUser.get(0);
        }else{
            u1= TestDataFactory.getElectricalRoleUser();
        }
        User u2 = new User();
        lstUser=[select Id from User  WHERE UserRole.Name like  '%Mechanical%' and Name='G Yogendra' limit 1];
        if(lstUser.size() > 0){
            u2 = lstUser.get(0); 
        }else{
            u2= TestDataFactory.getMechanicalRoleUser();
        }//</T01>
        Id MBARecordTypeId  = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('MBA').getRecordTypeId();
        ID QuoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('MBA Record Type').getRecordTypeId();
        
        TriggerStatus__c triggerStat = new TriggerStatus__c(); //insert custom setting data
        triggerStat.Name =  'QuoteTrigger';
        triggerStat.Active__c = true;
        insert triggerStat;
        
        TriggerStatus__c triggerStats = new TriggerStatus__c(); //insert custom setting data
        triggerStats.Name =  'QuoteNameTrigger';
        triggerStats.Active__c = true;
        insert triggerStats;
        
        
        
        Account acc = new Account();
        acc.name = 'Test Acc';
        acc.Delivery_Type__c = 'Export';
        acc.Industry = 'Aerospace & Defense';
        acc.Region_Picklist__c = 'South';
        acc.Company_Type__c = 'OEM';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name='Test_Ani';
        opp.Amount=10000;
        opp.Type='New Opportunity';
        opp.Region_Picklist__c = 'South';
        opp.CloseDate=System.Today();
        opp.StageName    =     'Preliminary Opportunity';
        opp.recordTypeId    =    MBARecordTypeId;
        opp.Member1__c = u2.Id;
        opp.Member2__c = u1.Id;
        insert opp;
        test.startTest();
        Quote q = new Quote();
        q.Name = 'Test_Opp';
        q.OpportunityID = opp.Id;
        q.Quote_Parity_Value__c = 12;
        q.Pricebook2Id = Test.getStandardPricebookId();
        q.RecordTypeId = QuoteRecordTypeId;
        insert q;
        
        Quote_Items__c qlineItem = new Quote_Items__c();
        qlineItem.Quote__c = q.ID;
        qlineItem.Quantity__c = 2;
        qlineItem.Unit_Price__c = 12;
        insert qlineItem;
        Test.stopTest();
        //delete q;
        
        
    }
    

}