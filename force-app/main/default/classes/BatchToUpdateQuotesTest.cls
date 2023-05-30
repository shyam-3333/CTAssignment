@isTest
public class BatchToUpdateQuotesTest {

 
    
    static testMethod void testMethod1(){
    
        Id CSRecordTypeId  = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        ID QuoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
         CheckValidation__c check = CheckValidation__c.getInstance(UserInfo.getOrganizationId());
        check.isChecked__c = true;
        upsert check;
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
        
        
       
        
        quote q1 = new quote();
        q1.RecordTypeId = QuoteRecordTypeId;
        q1.Name = 'aaaa';
        q1.OpportunityId = opp.id;
        q1.Product_for_Approval__c = 'GV/GC Not Valid on Gold Coin';
        q1.Cheque_Date__c = NULL;
        q1.Order_Type__c = 'Regular';
        insert q1;
        
        Payment_Tracker__c pt = new Payment_Tracker__c();
        pt.Cheque_Date__c = system.today() ;
        pt.Opportunity__c = opp.id;
        pt.Cheque_No__c = 'cheque No 123';
        pt.Amount_Recieved__c = 1000;
        pt.Payment_Type__c = 'Advance';
        pt.Payment_Mode__c = 'Cheque';
        insert pt;
        
        
        Opportunity opp1 = new Opportunity();
        opp1.AccountId = acc.Id;
        opp1.Name='Test_Opp';
        opp1.Amount=10000;
        opp1.Temp_amount__c = 10000;
        opp1.Type='New Opportunity';
        opp1.Region_Picklist__c = 'South';
        opp1.CloseDate=System.Today();
        opp1.StageName    =     'Requirement Analysis';
        opp1.recordTypeId    =    CSRecordTypeId;
        insert opp1;
        
        
       
        
        quote q2 = new quote();
        q2.RecordTypeId = QuoteRecordTypeId;
        q2.Name = 'aaaa';
        q2.OpportunityId = opp1.id;
        q2.Cheque_Date__c = NULL;
        q2.Product_for_Approval__c = 'GV/GC Valid on Gold Coin';
        q2.Order_Type__c = 'Regular';
        insert q2;
        
        Payment_Tracker__c pt1 = new Payment_Tracker__c();
        pt1.Cheque_Date__c = system.today() ;
        pt1.Opportunity__c = opp1.id;
        pt1.Cheque_No__c = 'cheque No 123';
        pt1.Amount_Recieved__c = 1000;
        pt1.Payment_Type__c = 'Advance';
        pt1.Payment_Mode__c = 'Cheque';
        insert pt1;
        
       /* opportunity opp1 = new opportunity();
        opp1.recordTypeId    =    CSRecordTypeId;
        opp1.Name = 'test';
        opp1.StageName = 'Revised Quote';
        opp1.AccountId = acc.Id;
        opp1.type = 'New Opportunity';
        opp1.Region_Picklist__c = 'North';
        opp1.Amount = 456312;
        opp1.CloseDate = System.today();
        insert opp1;
        
        quote q2 = new quote();
        q2.RecordTypeId = QuoteRecordTypeId;
        q2.Name = 'bbbb';
        q2.OpportunityId = opp1.id;
        q2.Product_for_Approval__c = 'GV/GC Valid on Gold Coin';
        q2.Order_Type__c = 'Regular';
        insert q2;
        
        Payment_Tracker__c pt1 = new Payment_Tracker__c();
        pt1.Cheque_Date__c = system.today() ;
        pt1.Opportunity__c = opp1.id;
        pt1.Cheque_No__c = 'cheque No 123';
        pt1.Amount_Recieved__c = 1000;
        pt1.Payment_Type__c = 'Advance';
        pt1.Payment_Mode__c = 'Cheque';
        pt1.Bank_Name__c ='Sbi';
        pt1.Location_of_The_Bank__c ='Mumbai';
        pt1.RTGS_No__c = 'RTGS 123';
        insert pt1;
        
        opportunity opp2 = new opportunity();
        opp2.recordTypeId    =    CSRecordTypeId;
        opp2.Name = 'test';
        opp2.StageName = 'Revised Quote';
        opp2.AccountId = acc.Id;
        opp2.type = 'New Opportunity';
        opp2.Region_Picklist__c = 'North';
        opp2.Amount = 456312;
        opp2.CloseDate = System.today();
        insert opp2;
        
        quote q3 = new quote();
        q3.RecordTypeId = QuoteRecordTypeId;
        q3.Name = 'cccc';
        q3.OpportunityId = opp2.id;
        q3.Product_for_Approval__c = 'GV/GC Valid on Diamond Studded';
        q3.Order_Type__c = 'Regular';
        insert q3;
        
        Payment_Tracker__c pt2 = new Payment_Tracker__c();
        pt2.Cheque_Date__c = system.today() ;
        pt2.Opportunity__c = opp2.id;
        pt2.Cheque_No__c = 'cheque No 123';
        pt2.Amount_Recieved__c = 1000;
        pt2.Payment_Type__c = 'Advance';
        pt2.Payment_Mode__c = 'Cheque';
        pt2.Bank_Name__c ='Sbi';
        pt2.Location_of_The_Bank__c ='Mumbai';
        pt2.RTGS_No__c = 'RTGS 123';
        insert pt2;*/
        
        database.executeBatch(new BatchToUpdateQuotes());
        
        
    }
}