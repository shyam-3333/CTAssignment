/*
* Created by    : Mutturaj Heroor
* Created on    : March-15-2021
* Purpose       : LitmusCalloutClassTest is Used for Testcoverage of LitmusCalloutClass *******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
@isTest
public class LitmusCalloutClassTest {

    @isTest
    public static void testCalloutMethod(  )
    {
        Test.setMock(HttpCalloutMock.class, new LitmusCalloutMock());
        //Preparing Metadata it required 
        TriggerStatus__c trgStaus = new TriggerStatus__c();
        trgStaus.Active__c = true;
        trgStaus.Name = 'OpportunityTrigger';
        insert trgStaus;
        
        LitmusApiOnRegion__c apiNameOnRegion = new LitmusApiOnRegion__c(Name='yp0q_test',Region__c='North');
        insert apiNameOnRegion;
        
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
        cont.Email = 'hulakanteppa.h@kvpcorp.com';
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
        
        System.debug(opp.AccountId + '' + opp.Account.Name);
        opp.StageName = 'RFQ_Study' ;//'Order Closed';
        opp.RFQ_Reference1__c = 'test';
        opp.RFQ_Received_Date_Date__c = System.today();
        update opp;
        
        Quote qt = new Quote();
        qt.RecordTypeId = qouteRecordTypeId;
        qt.OpportunityId = opp.Id;
        qt.ContactId = cont.Id;
        qt.Name = 'test Quote';
        
        insert qt;
        
        opp.StageName = 'Quote_Preparation';
        update opp;
        
        CheckValidation__c checkVal = new CheckValidation__c(isChecked__c=false);
        insert checkVal;
        Payment_Tracker__c payment = new Payment_Tracker__c();
        payment.Opportunity__c = opp.Id;
        payment.Amount_Recieved__c = 30000;
        payment.Bank_Name__c = 'SBI';
        payment.Payment_Type__c = 'Balance';
        payment.Payment_Mode__c = 'RTGS';
        payment.Location_of_The_Bank__c ='KOLKATA';
        payment.RTGS_No__c = 'SBIR52020120461';
        
        insert payment;
        
        opp.StageName = 'Received PO/Order Won';
        opp.PO_Reference__c ='test';
        opp.PO_Date__c = system.today();
        opp.PO_No__c = '1234' ;
        opp.Payment_Due_Date__c = system.today();
        opp.Requested_Payment_Date__c = system.today();
        opp.Delivery_Status__c = 'Completed';
        opp.Payment_Status__c ='Completed';
        
        update opp;
        
        opp.StageName ='Order Closed';
        opp.Invoice_date__c=date.newInstance(2022, 10, 15);
        opp.Invoice_No__c='1123test';
        update opp;
        
        
    }
    @isTest
    public static void testCalloutMethod2(  )
    {
        Test.setMock(HttpCalloutMock.class, new LitmusCalloutMock());
        //Preparing Metadata it required 
        TriggerStatus__c trgStaus = new TriggerStatus__c();
        trgStaus.Active__c = true;
        trgStaus.Name = 'OpportunityTrigger';
        insert trgStaus;
        
        LitmusApiOnRegion__c apiNameOnRegion = new LitmusApiOnRegion__c(Name='yp0q_test',Region__c='North');
        insert apiNameOnRegion;
        
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
        cont.Email = 'hulakanteppa.h@kvpcorp.com';
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
        
        
        opp.Gift_Card_Transaction_Date__c =date.newInstance(2022, 10, 15);
        update opp;
        
        
    }
}