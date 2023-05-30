@isTest
public class TestLead {

    static testMethod void myUnitTest() {
        
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
        l.website = 'www.testcrm.com';
        insert l;
        
        update l;
    }
}