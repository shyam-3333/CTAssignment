@isTest

private class LeadTest{

    static testMethod void LeadTestMethod() {
 
         List<Lead> leadlist = new List<Lead>();
         
         Lead l = new Lead();
         l.Phone = '9009009000';
         l.Email = 'abc@test.com';
         l.MobilePhone ='1234567890';   
         l.LastName = 'Test1';
         l.Company = 'ABC Pvt'; 
         leadlist.add(l);
         
         Lead l1 = new Lead();
         l1.Phone = '9129009000';
         l1.Email = 'abcdef@test.com';   
         l1.MobilePhone ='1234567890';   
         l1.LastName = 'Test2';
         l1.Company = 'ABC Pvt';
         leadlist.add(l1);
         
         Lead l2 = new Lead();
         l2.Phone = '9119009000';
         l2.Email = 'abc123@test.com';   
         l2.MobilePhone ='1234567890';   
         l2.LastName = 'Test3';   
         l2.Company = 'ABC Pvt';               
         leadlist.add(l2);
         
         insert leadlist;
         
         leadlist.clear();
         
         Task t1 = new Task();
         t1.WhoID = l.ID;
         insert t1;
         
         Lead l3 = new Lead(ID = l.ID);
         l3.Lead_Priority__c = 'High';
         l3.Lead_follow_up_status__c = 'Second Contact';
         update l3;
         
         Lead l4 = new Lead(ID = l1.ID);
         l4.Lead_Priority__c = 'Medium';
         l4.Lead_follow_up_status__c = 'Second Contact';
         update l4;
         
         Lead l5 = new Lead(ID = l2.ID);
         l5.Lead_Priority__c = 'Low';
         l5.Lead_follow_up_status__c = 'Second Contact';
         update l5;
         
         Task t = [select Id from Task where WhoID =: l.ID limit 1];
         t.Status = 'Completed';
         update t;
         Task t11=[select id,Status from Task where id=:t.id];
         system.assertequals('Completed',t11.Status);
            
    }
}