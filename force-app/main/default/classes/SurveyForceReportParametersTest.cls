@isTest
public class SurveyForceReportParametersTest {

    @isTest
    public static void testMethod1(){
        Account a = new Account();
            a.Name = 'test';
            a.Type = 'Suspect';
            a.BillingPostalCode = '506319';
            insert a;
 
         Opportunity o = new Opportunity();
         o.Name = 'Test for Opp Test Method';
       //  o.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
         o.AccountID = a.ID;
         o.Type = 'AMC';
         o.StageName = 'Preliminary Opportunity';
         o.CloseDate = System.Today() + 10;
         insert o;  
        o.SurveyReminderEmailSentDate__c = system.now();
        update o;
        
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
        
        Visit__c vst = new Visit__c();
        vst.Name = 'TestVisit';
        vst.Account__c = acc.Id;
        vst.Visit_Category__c = 'General Followup';
        vst.Visit_Type__c = 'By Customer';
        vst.Date_Time_of_Visit__c = system.today();
        vst.Minutes_of_Meeting__c = 'test';
        vst.Conclusion_Notes__c = 'test';
        vst.EmailReminderStatus__c = false;
        insert vst;
        
        vst.EmailReminderStatus__c = true;
        update vst;
    }
}