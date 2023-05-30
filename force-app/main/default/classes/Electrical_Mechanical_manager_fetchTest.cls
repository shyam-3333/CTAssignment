@isTest
public class Electrical_Mechanical_manager_fetchTest {

    public static testMethod void insertOpportunity(){ 
         Map<String,Schema.RecordTypeinfo> rec = Opportunity.SobjectType.getDescribe().getRecordTypeInfosByName();
         List<Opportunity> opplist = new List<Opportunity>();
        
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'OpportunityTrigger';
        tt.Active__c =true;
        insert tt;

         Profile p = [Select Id from Profile where Name LIKE '%Team member%' limit 1];
    
          User u = [Select ID,UserRole.Name from User Where   id = '0051O00000DNX3G' limit 1];
          User u1 = [Select ID,UserRole.Name from User Where  id = '0051O00000CiRHj'  limit 1];
        User u2 = [Select ID,UserRole.Name from User Where  id = '00530000004B7s4'  limit 1];
        User u3 = [Select ID,UserRole.Name from User Where  id = '0051O00000DNX4Y'  limit 1];
        system.debug('User1'+u);
        system.debug('user2'+u1);

          Account a = new Account();
            a.Name = 'test';
            a.Type = 'Suspect';
            a.BillingPostalCode = '506319';
            insert a;
 
         Opportunity o = new Opportunity();
         o.Name = 'Test for Opp Test Method';
         o.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
         o.AccountID = a.ID;
         o.Type = 'AMC';
         o.StageName = 'Preliminary Opportunity';
         o.CloseDate = System.Today() + 10;
          o.Member1__c = u1.Id;
         o.Member2__c = u.Id;
         opplist.add(o);   
         
         Opportunity o1 = new Opportunity();
         o1.Name = 'Test 2 for Opp Test Method ';
         o1.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
         o1.AccountID = a.ID;
         o1.Type = 'New';
         o1.StageName = 'Preliminary Opportunity';
         o1.CloseDate = System.Today() + 10;
         opplist.add(o1);
         
         Opportunity o2 = new Opportunity();
         o2.Name = 'Test 3 for Opp Test Method ';
         o2.RecordTypeId = rec.get('PECSA').getRecordTypeId();
         o2.AccountID = a.ID;
         o2.StageName = 'Preliminary Opportunity';
         o2.CloseDate = System.Today() + 10;
         opplist.add(o2);
         
         insert opplist;
        opplist.clear();
         
         Opportunity o10 = new Opportunity(ID = o1.ID);
        o10.Member1__c = u2.Id;
        o10.Member2__c = u3.Id;
         o10.OwnerID = u.ID;
         opplist.add(o10);
         
         update opplist;
    }
}