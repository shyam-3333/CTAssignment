/**************************************************************************************************************
* Created by: Vinoth kumar A
* Crated on : 07/10/2019
* Description: This Test class for the trigger SurveyTakenEmailAlertTrigger and helper class SurveyTakenEmailAlertHelper
**************************************************************************************************************/
@isTest
public class SurveyTakenEmailAlertTest {
@isTest
    public static void doTest(){
        
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
        
        Contact Con = new Contact();
        Con.LastName = 'Vinoth';
        con.Email = 'Vinoth.kumar@kvpcorp.com';
        Con.AccountId = acc.Id;
        
        Insert Con;
        
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
        
        insert Opp;
        
        Survey__c Sur = new Survey__c();
        Sur.Name = 'Survey Name';
        Insert Sur;
        
        Visit__c vst = new Visit__c();
        vst.Name = 'TestVisit';
        vst.Account__c = acc.Id;
        vst.OwnerId = u.Id;
        vst.Visit_Category__c = 'General Followup';
        vst.Visit_Type__c = 'By Customer';
        vst.Date_Time_of_Visit__c = system.today();
        vst.Minutes_of_Meeting__c = 'test';
        vst.Conclusion_Notes__c = 'test';
        vst.EmailReminderStatus__c = true;
        insert vst;
        
        
       SurveyTaker__c st = new SurveyTaker__c();
        st.Contact__c = Con.Id;
        st.Survey__c = Sur.Id;
        st.Email__c = 'Vinoth.kumar@kvpcorp.com';
        st.OppId__c = Opp.Id;
        
        Insert st;
        
        SurveyTaker__c stv = new SurveyTaker__c();
        stv.Contact__c = Con.Id;
        stv.Survey__c = Sur.Id;
        stv.Email__c = 'Vinoth.kumar@kvpcorp.com';
        stv.VisitId__c = vst.Id;
        
        Insert stv;
    }
}