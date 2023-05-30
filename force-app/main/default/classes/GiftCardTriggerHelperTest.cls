@isTest
public class GiftCardTriggerHelperTest 
{
    @isTest
	public static void testGiftCardHelper()
    {
        //fetching Record Type Ids
        Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();
        Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        Id qouteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        Account acc = new Account();
        acc.RecordTypeId = accountRecordTypeId;
        acc.Name = 'Test Litmus Acc1';
        acc.Date_of_establishment_of_company__c = system.today();
        acc.Region_Picklist__c = 'North' ;
        acc.Type = 'Customer';
        acc.GSTN_Number__c = 'AWLPH1234567890' ;
        acc.Last_Billed_Month__c = system.today();
        acc.Customer_Category__c = 'Active ( Billed in 2020 )' ;
        acc.Channel__c = 'Education and training';
        acc.CustomerSegment__c = 'GIFTING AGENCY';
        acc.Customer_Subsegment__c = 'New';
        acc.Pan_No__c = '09876';
        acc.BillingState = 'Karnataka';
        acc.CST_No__c = '123';
        acc.TIN_No__c = '123';
        Insert acc;
        
        Contact cont = new Contact();
        cont.FirstName = 'Mutturaj';
        cont.LastName = 'Heroor';
        cont.Email = 'Test.h@kvpcorp.com';
        cont.MobilePhone = '8762921827';
        cont.AccountId = acc.Id;
        insert cont ;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Litmus Testing Opp';
        opp.StageName = 'Requirement Analysis' ;
        opp.Amount = 30000;
        opp.RecordTypeId = oppRecordTypeId;
        opp.Type = 'New Opportunity';
        opp.Region_Picklist__c = 'North';
        opp.CloseDate = system.today();
        opp.Opportunity_Type__c = 'Dealer Incentive' ;
        opp.RFQ_Reference1__c = 'test';
        opp.RFQ_Received_Date_Date__c = system.today() ;
        opp.LeadSource = 'Campaign';
        opp.Livelihood_Date_of_billing__c = system.today();
        
        insert opp;
        
        Quote qt = new Quote();
        qt.RecordTypeId = qouteRecordTypeId;
        qt.OpportunityId = opp.Id;
        qt.ContactId = cont.Id;
        qt.Name = 'test Quote';
		        
        insert qt;
        List<Quote> qt2=[Select id,INSTI_Order_Reference__c from Quote where id=:qt.id limit 1];
		//System.debug(' Test----->>INSTI_Order_Reference__c :'+qt2[0].INSTI_Order_Reference__c);
        
        Gift_Cards__c gcObj=new Gift_Cards__c();
        gcObj.Quote__c=qt2[0].id;
        gcObj.Card_Number__c='1122';
        gcObj.Transaction_Date__c=date.newInstance(2022, 10, 15);
        gcObj.Transaction_Type__c='GIFT CARD ACTIVATE';
        gcObj.Invoice_Number__c=qt2[0].INSTI_Order_Reference__c;
        System.assertNotEquals(null,gcObj.Invoice_Number__c);
        insert gcObj;
        
        //System.debug('Test---->>quote id: '+gcObj.Quote__c+' tran date :'+gcObj.Transaction_Date__c+' insti : '+gcObj.Invoice_Number__c +' type : '+gcObj.Transaction_Type__c);
    }
    @isTest
	public static void testGiftCardHelper2()
    {
        GiftCardTriggerHelper.firstRun=true;
        //fetching Record Type Ids
        Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();
        Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        Id qouteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        Account acc2 = new Account();
        acc2.RecordTypeId = accountRecordTypeId;
        acc2.Name = 'Test Litmus Acc1';
        acc2.Date_of_establishment_of_company__c = system.today();
        acc2.Region_Picklist__c = 'North' ;
        acc2.Type = 'Customer';
        acc2.GSTN_Number__c = 'AWLPH1234567890' ;
        acc2.Last_Billed_Month__c = system.today();
        acc2.Customer_Category__c = 'Active ( Billed in 2020 )' ;
        acc2.Channel__c = 'Education and training';
        acc2.CustomerSegment__c = 'GIFTING AGENCY';
        acc2.Customer_Subsegment__c = 'New';
        acc2.Pan_No__c = '09876';
        acc2.BillingState = 'Karnataka';
        acc2.CST_No__c = '123';
        acc2.TIN_No__c = '123';
        Insert acc2;
        
        Contact cont2 = new Contact();
        cont2.FirstName = 'Mutturaj';
        cont2.LastName = 'Heroor2';
        cont2.Email = 'Test2.h@kvpcorp.com';
        cont2.MobilePhone = '8762921827';
        cont2.AccountId = acc2.Id;
        insert cont2 ;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc2.Id;
        opp.Name = 'Litmus Testing Opp2';
        opp.StageName = 'Requirement Analysis' ;
        opp.Amount = 30000;
        opp.RecordTypeId = oppRecordTypeId;
        opp.Type = 'New Opportunity';
        opp.Region_Picklist__c = 'North';
        opp.CloseDate = system.today();
        opp.Opportunity_Type__c = 'Dealer Incentive' ;
        opp.RFQ_Reference1__c = 'test';
        opp.RFQ_Received_Date_Date__c = system.today() ;
        opp.LeadSource = 'Campaign';
        opp.Livelihood_Date_of_billing__c = system.today();
        
        insert opp;
        
        Quote qtt2 = new Quote();
        qtt2.RecordTypeId = qouteRecordTypeId;
        qtt2.OpportunityId = opp.Id;
        qtt2.ContactId = cont2.Id;
        qtt2.Name = 'test Quote2';
		        
        insert qtt2;
        List<Quote> qt2N=[Select id,INSTI_Order_Reference__c from Quote where id=:qtt2.id limit 1];
		System.debug(' Test----->>INSTI_Order_Reference__c :'+qt2N[0].INSTI_Order_Reference__c);
        
        Gift_Cards__c gcObj2=new Gift_Cards__c();
        gcObj2.Quote__c=Null;
        gcObj2.Card_Number__c='1123';
        gcObj2.Transaction_Date__c=date.newInstance(2022, 10, 15);
        
        gcObj2.Transaction_Type__c='GIFT CARD ACTIVATE';
        gcObj2.Invoice_Number__c=qt2N[0].INSTI_Order_Reference__c;
        //System.assertNotEquals(null,gcObj.Invoice_Number__c);
        insert gcObj2;
        System.debug('first quote id '+gcObj2.Quote__c);
        Gift_Cards__c gcObjN=new Gift_Cards__c();
        gcObjN.id=gcObj2.Id;
        gcObjN.Quote__c=qt2N[0].id;
        update gcObjN;
        
        System.debug('Test---->>quote id: '+gcObjN.Quote__c+' tran date :'+gcObj2.Transaction_Date__c+' insti : '+gcObj2.Invoice_Number__c +' type : '+gcObj2.Transaction_Type__c);
        
        
        Opportunity opp2 = new Opportunity();
        opp2.AccountId = acc2.Id;
        opp2.Name = 'Litmus Testing Opp2';
        opp2.StageName = 'Requirement Analysis' ;
        opp2.Amount = 30000;
        opp2.RecordTypeId = oppRecordTypeId;
        opp2.Type = 'New Opportunity';
        opp2.Region_Picklist__c = 'North';
        opp2.CloseDate = system.today();
        opp2.Opportunity_Type__c = 'Dealer Incentive' ;
        opp2.RFQ_Reference1__c = 'test';
        opp2.RFQ_Received_Date_Date__c = system.today() ;
        opp2.LeadSource = 'Campaign';
        opp2.Livelihood_Date_of_billing__c = system.today();
        
        insert opp2;
        
        Quote qtt3 = new Quote();
        qtt3.RecordTypeId = qouteRecordTypeId;
        qtt3.OpportunityId = opp2.Id;
        qtt3.ContactId = cont2.Id;
        qtt3.Name = 'test Quote2';
		        
        insert qtt3;
        List<Quote> qt2N2=[Select id,INSTI_Order_Reference__c from Quote where id=:qtt3.id limit 1];
        Gift_Cards__c gcObj3=new Gift_Cards__c();
        gcObj3.Quote__c=Null;
        gcObj3.Card_Number__c='1123';
        gcObj3.Transaction_Date__c=date.newInstance(2022, 10, 15);
        
        gcObj3.Transaction_Type__c='GIFT CARD ACTIVATE';
        gcObj3.Invoice_Number__c='2022/'+qt2N2[0].INSTI_Order_Reference__c;
        //System.assertNotEquals(null,gcObj.Invoice_Number__c);
        insert gcObj3;
        System.debug('first quote id '+gcObj2.Quote__c);
        Gift_Cards__c gcObjN2=new Gift_Cards__c();
        gcObjN2.id=gcObj3.Id;
        gcObjN2.Quote__c=qt2N2[0].id;
        update gcObjN2;
    }
}