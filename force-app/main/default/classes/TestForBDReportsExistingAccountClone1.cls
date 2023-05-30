@isTest(seeAllData=true)
public class TestForBDReportsExistingAccountClone1 
{
  static testMethod void myUnitTest() {
    RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='MBA' Limit 1];
    
    Lead l = new Lead();
        l.FirstName = 'CRM Testing First';
        l.LastName = 'CRM Testing Last';
        l.Company = 'CRM Testing INCtest';
        l.description = 'Test descr';
        l.city = 'test';
        l.street = 'test';
        l.state = 'CA';
        l.country = 'United States';
        l.status = 'Qualified';
        l.email = 'test@testnetgear.com';
        l.website = 'www.testcrm.com';
        insert l;
        
    Account acct = new Account();
        acct.Name = 'test';
        acct.Postal_code__c='8683';
        acct.BillingPostalCode='7547';
        acct.Industry='Automotive';
        acct.Account_SAP_Id__c ='1234';
        acct.Financial_Stability_Risk__c = 'High';
        acct.Payment_Structure_Collection_Risk__c ='High';
        acct.Country_Specific_Statutory_Risk__c ='High'; 
        acct.Service_Availability_Risk_Other_Countrie__c='High';
        acct.Country_Specific_Statutory_Risk_Details__c ='ashu';
        acct.Financial_Stability_Risk_Details__c ='test1';
        acct.Payment_Structure_Collection_Risk_Detail__c = 'test2';
        acct.Service_Availability_Risk_Details__c ='asd';
        acct.recordtypeid =rt.Id;
        acct.Product_Category__c = 'Batteries';
        acct.Competitor_Info__c = 'test1223';
        acct.Lead_Source__c = 'Internet';   
        acct.BillingState='Karnataka';
        acct.BillingCity='bangalore';
        insert acct;
        
        Contact con = new Contact();
        con.FirstName = 'Robin';
        con.LastName = 'Koehler';
        con.AccountId = acct.Id;
        insert con;  
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Order Won';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Basic_Price__c  = 100;
        opp.Turnover1__c = 50;
        opp.PO_Date__c = system.today();  
        opp.LOI_Date__c = system.today();  
        opp.Member1__c = '00530000004B7s8AAC';
        opp.Member2__c = '00530000006BYTLAA4'; 
        opp.Competitor_Info__c = 'test';
        insert opp;
        Quote qt = new Quote();
        qt.Name = 'test1_R1';
        qt.OpportunityId = opp.ID;
        Insert qt;
        
        Task ta = new Task();
        ta.Subject='call';
        ta.ActivityDate= system.today();
        ta.Description = 'abc';
        ta.Completed_Date_del__c=system.today()+20;
        ta.Revised_Date__c = system.today()+90;
        ta.WhatId = acct.ID;
        insert ta;
        
        Visit__c vi = new Visit__c();
        vi.Visit_Category__c='General Followup';
        vi.Visit_Agenda__c = 'test';
        vi.Date_Time_of_Visit__c = system.today()+90;
        vi.Customer_Participant1__c = con.Id; 
        vi.Conclusion_Notes__c = 'testashj';
        vi.Account__c = acct.Id;
        vi.Lead__c = l.Id;
        vi.Opportunity__c = opp.Id;
        insert vi;
        
        test.startTest();
      BDReportsNewLead_CLONE1 controller = new BDReportsNewLead_CLONE1();
        BDReports_ExistingAccounts_Clone1 obj = new BDReports_ExistingAccounts_Clone1(controller);
      
          obj.SomeData();
        obj.Replicate();
        obj.duplicate(); 
        obj.eplicate();
        obj.plicate();
        obj.licate();
        obj.ete();
        obj.ate();
        obj.cate();
        obj.prest();
        obj.crest();
        obj.just();
        obj.Julk();
        obj.april();
        obj.Demolish();
      test.stopTest();

        
}
}