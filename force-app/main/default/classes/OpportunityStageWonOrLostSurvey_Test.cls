@isTest(SeeAllData=true)
public class OpportunityStageWonOrLostSurvey_Test {
    @isTest public static void oppObject(){
        Id compId = [Select id from Competitor__c limit 1].Id;
        User u = new User();
        // u = [select Id from User  limit 1]; 
        u.firstName = 'vinoth';
        u.LastName = 'kumar';
        u.Alias = 'vino';
        u.Email = 'vinoth.kumar@kvpcorp.com';
        u.Username = 'vinoth.kumar@abc.com';
        u.CommunityNickname = 'vin';
        u.UserRole =[select id, name from UserRole where name like '%Mechanical%' limit 1];
        system.debug('user role:'+u.UserRole.name);
        u.ProfileId = [select id from Profile limit 1].id;
        u.EmailEncodingKey = 'UTF-8';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.LocaleSidKey = 'en_US';
        u.LanguageLocaleKey = 'en_US';
        u.CurrencyIsoCode = 'INR';
        insert u;
        
        Account acc = new Account();
        acc.name = 'Test Acc';
        acc.Delivery_Type__c = 'Export';
        acc.Industry = 'Aerospace & Defense';
        acc.Region_Picklist__c = 'South';
        acc.Company_Type__c = 'OEM';
        acc.Account_SAP_Id__c = 'abc';
        acc.Financial_Stability_Risk__c ='abc';
        acc.Payment_Structure_Collection_Risk__c = 'Low';
        acc.Country_Specific_Statutory_Risk__c = 'Low';
        acc.Service_Availability_Risk_Other_Countrie__c = 'Low';
        acc.Postal_code__c='765';
        acc.BillingPostalCode='64574';
        insert acc;
        List<opportunity> oppList = new List<Opportunity>(); 
            Test.startTest();
        Opportunity opp = new Opportunity();
        opp.OwnerId = u.Id;
        
        opp.AccountId = acc.Id;
        opp.Name='Test_Opp';
        opp.Amount=10000;
        opp.Temp_amount__c = 10000;
        opp.Type='Repeat Opportunity';
        opp.Region_Picklist__c = 'South';
        opp.CloseDate=System.Today();
        opp.StageName = 'Concept Finalization';
        opp.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp.Member1__c = u.Id;
        opp.Sub_Activities__c = 'Mail Confirmation';
        opp.Mail_Confirmation_Date__c = system.today();
        
        oppList.add(opp);
        
        
        
        OpportunityStageWonOrLostSurveyHelper.codeCoverageMethod();
        //update opp;
        Opportunity opp1 = new Opportunity();
        opp1.OwnerId = u.Id;
        opp1.AccountId = acc.Id;
        opp1.Name='Test_Opp';
        opp1.Amount=10000;
        
        opp1.Temp_amount__c = 10000;
        opp1.Type='Repeat Opportunity';
        opp1.Region_Picklist__c = 'South';
        opp1.CloseDate=System.Today();
        opp1.StageName = 'Concept Finalization';
        opp1.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp1.Member1__c = u.Id;
        opp1.Sub_Activities__c = 'Mail Confirmation';
        opp1.Mail_Confirmation_Date__c = system.today();
        opp1.Quote_indent_No__c = '1234';
        opp1.Customer_Type__c = 'Existing Customer';
        oppList.add(Opp1);
        insert oppList;
        oppList[0].Payment_Status__c = 'Completed';
        oppList[0].Delivery_Status__c = 'Completed';
        oppList[0].StageName = 'Order Closed';
        update oppList[0];
        Quote q = new Quote();
        q.Name = 'Test_Opp';
        q.OpportunityID = oppList[1].Id;
        q.Total_Price_Qli__c = 24;
        q.Pricebook2Id = Test.getStandardPricebookId();
        q.Product_Sub_Category__c= 'Watches';
        q.Product_Catagory__c='Sonata';
        q.Indent_Created__c = true;
        q.Product_for_Approval__c = 'Watches Gift Voucher';
        insert q;         
        opp1.Payment_Status__c = 'Completed';
        opp1.Delivery_Status__c = 'Completed';
        opp1.StageName = 'Opportunity Lost';
        opp1.Reason__c = 'Lost on cost';
        opp1.Competitor_Quoted_Price__c=97;
        opp1.Competitor_Quote_Lead_Time__c=30;
        opp1.Regret_Remarks__c = 'sdsegergtegrg';
        opp1.Opportunity_Lost_Date__c = Date.today();
        opp1.Description = 'Test';
        opp1.Competitor1__c = compId;
        //update opp1;
        Test.stopTest();
        /* 
        Opportunity opp1 = new Opportunity();
        opp1.OwnerId = u.Id;
        opp1.AccountId = acc.Id;
        opp1.Name='Test_Opp';
        opp1.Amount=10000;
        opp1.Temp_amount__c = 10000;
        opp1.Type='Repeat Opportunity';
        opp1.Region_Picklist__c = 'South';
        opp1.CloseDate=System.Today();
        opp1.StageName = 'Concept Finalization';
        opp1.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp1.Reason__c = 'Lost on cost';
        opp1.Member1__c = u.Id;
        Opp1.Regret_Remarks__c = 'Regret remarks';
        opp1.Customer_Type__c = 'Existing Customer';
        insert opp1;
        opp1.Related_Parent_Opportunity__c =  opp.Id;      
        opp1.StageName = 'Opportunity Lost';
        update opp1;
        list<Opportunity> oppList = new list<Opportunity>();
        oppList.add(opp);
        oppList.add(opp1);
        Map<id,Opportunity> OppMap = new Map<id,Opportunity>();
        OppMap.put(opp.id,opp);
        OppMap.put(opp1.id,opp1);
        OpportunityStageWonOrLostSurveyHelper.OpportunitySurvey(oppList,OppMap);
        
        Quote q = new Quote();
        q.Name = 'Test_Opp';
        q.OpportunityID = opp1.Id;
        q.Total_Price_Qli__c = 24;
        q.Pricebook2Id = Test.getStandardPricebookId();
        q.Product_Sub_Category__c= 'Watches';
        q.Product_Catagory__c='Sonata';
        q.Indent_Created__c = true;
        q.Product_for_Approval__c = 'Watches Gift Voucher';
        insert q;*/
    }
}