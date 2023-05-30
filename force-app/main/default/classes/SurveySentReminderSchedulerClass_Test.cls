/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 30/05/2019
* Description: Test class for OpportunityStageWonOrLostSurveyReminder
*******************************************************************************/
@isTest
    public class SurveySentReminderSchedulerClass_Test {
  
    @isTest public static void ReminderEmail(){
        
        Survey__c s =  new Survey__c();
        s.Name = 'Survey';
        insert s;
        
        Survey_Sent__c Sst = new Survey_Sent__c();
        Sst.Email__c ='vinoth.kumar@kvpcorp.com';
        //Sst.CreatedDate = '';
        Sst.Email_Body__c = 'Test Email Body';
        Sst.Surveys__c = s.id;
        insert Sst;
        
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
        insert acc;
        
        Contact conNew = new Contact();
        conNew.Firstname = 'vinoth';
        conNew.LastName = 'kumar';
        conNew.AccountId = acc.Id;
        conNew.Email='vinoth.kumar@kvpcorp.com';
        insert conNew;
        
        Opportunity opp = new Opportunity();
        opp.OwnerId = u.Id;
        opp.AccountId = acc.Id;
        opp.Name='Test_Opp';
        opp.Amount=10000;
        opp.Temp_amount__c = 10000;
        opp.Type='New Opportunity';
        opp.Region_Picklist__c = 'South';
        opp.CloseDate=System.Today();
        Opp.SurveyReminderEmailSentDate__c = system.today();
        opp.StageName = 'Order Won';
        opp.Member1__c = u.Id;
        opp.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp.Sub_Activities__c = 'Mail Confirmation';
        opp.Mail_Confirmation_Date__c = system.today();
        
        insert Opp;
        
         Opportunity opp1 = new Opportunity();
        opp1.OwnerId = u.Id;
        opp1.AccountId = acc.Id;
        opp1.Name='Test_Opp';
        opp1.Amount=10000;
        opp1.Temp_amount__c = 10000;
        opp1.Type='New Opportunity';
        opp1.Region_Picklist__c = 'South';
        opp1.CloseDate=System.Today();
        opp1.StageName = 'Opportunity Lost';
        opp1.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp1.Reason__c = 'Lost on cost';
         DateTime dt = DateTime.newInstance(2019,11,01,0,0,0);
        Opp1.SurveyReminderEmailSentDate__c = dt;
        opp1.Member1__c = u.Id;
        Opp1.Regret_Remarks__c = 'Regret remarks';
        insert opp1;
         Opportunity opp2 = new Opportunity();
        opp2.OwnerId = u.Id;
        opp2.AccountId = acc.Id;
        opp2.Name='Test_Opp';
        opp2.Amount=10000;
        opp2.Temp_amount__c = 10000;
        opp2.Type='New Opportunity';
        opp2.Region_Picklist__c = 'South';
       // Opp2.SurveyReminderEmailSentDate__c = system.today();
        opp2.CloseDate=System.Today();
        opp2.StageName = 'Opportunity Lost';
        opp2.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp2.Reason__c = 'Lost on cost';
        opp2.Member1__c = u.Id;
        Opp2.Regret_Remarks__c = 'Regret remarks';
        insert opp2;
         
        
       Database.executeBatch(new SurveySentCustomerReminderBatchClass(),5);
       Database.executeBatch(new SurveySentOppOwnerReminderBatchClass(),5);
        
        SurveySentReminderSchedulerClass Ss =  new SurveySentReminderSchedulerClass();
        String CT = '0 0 7 * * ?';
        system.schedule('Survey Sent Reminder Email Scheduler:', CT, Ss);
    }

}