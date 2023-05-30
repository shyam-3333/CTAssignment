@isTest
public class VisitOwnerEmailReminder_Test {
    @isTest public static void VisitOwnerEmailReminder(){
        
        String testLbl = Label.VisitOwnerEmailReminderCustomLabel;
        
        
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
        vst.EmailReminderStatus__c = true;
        insert vst;
        
        Database.executeBatch(new VisitOwnerReminderBatchClass(),1);
        
        VisitOwnerEmailReminderScheduler Vo =  new VisitOwnerEmailReminderScheduler();
        String CT = '0 30 7 * * ?';
        system.schedule('Visit Owner Reminder Email Scheduler:', CT, Vo);
    }

}