@isTest
public class LeadTriggerHandlerTest {

    static testMethod void myUnitTest() {
        
        User u =[Select Id from User where Id =: UserInfo.getUserId() LIMIT 1];
        
        List<Task> listTask = new List<Task>();
        List<Lead> listLead = new List<Lead>();
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'LeadTrigger';
        tt.Active__c = true;
        insert tt;
        
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
        l.Phone = '9095908667';
        l.isConverted = false;
        l.website = 'www.testcrm.com';
        l.LeadSource = 'Linkedin form';
        l.Region_Picklist__c = 'North';
        l.OwnerId = UserInfo.getUserId();
        insert l; 
        update l;
        
        
        Task t = new Task();
        t.Titan_Subject__c = 'Task Subject';
        t.WhoId = l.Id;
        t.IsRecurrence = true;
        t.RecurrenceType ='RecursDaily';
        t.OwnerId = UserInfo.getUserId();
        t.IsReminderSet = true;
    //    t.ActivityDate = System.today();
        t.Subject = 'veryHighPrioritySubject';
        t.RecurrenceStartDateOnly = System.today() + 7;
        t.RecurrenceInterval = 7;
        t.RecurrenceEndDateOnly = System.today() + 10;
        listTask.add(t);
        Insert listTask;
        
        
    }
}