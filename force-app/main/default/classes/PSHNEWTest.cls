@isTest

private class PSHNEWTest{

    static testMethod void PSHNewTest() {
 
         Opportunity o = new Opportunity();
         o.Name = 'Test for PSH New';
         o.StageName = 'Under Study';
         o.CloseDate = System.Today() + 10;
         insert o;
         
         List<Project_Stage_History_New__c> pshnewlist = new List<Project_Stage_History_New__c>(); 
         
         Project_Stage_History_New__c  pshnew = new Project_Stage_History_New__c();
         pshnew.Stage_Name__c = 'Design';
         pshnew.Opportunity__c = o.ID;
         pshnewlist.add(pshnew);
         
         Project_Stage_History_New__c  pshnew1 = new Project_Stage_History_New__c();
         pshnew1.Stage_Name__c = 'Commissioning';
         pshnew1.Opportunity__c = o.ID;
         pshnewlist.add(pshnew1);
         
         Project_Stage_History_New__c  pshnew2 = new Project_Stage_History_New__c();
         pshnew2.Stage_Name__c = 'Warranty';
         pshnew2.Opportunity__c = o.ID;
         pshnewlist.add(pshnew2);
         
         Project_Stage_History_New__c  pshnew3 = new Project_Stage_History_New__c();
         pshnew3.Stage_Name__c = 'Testing';
         pshnew3.Opportunity__c = o.ID;
         pshnewlist.add(pshnew3);
         
         insert pshnewlist;
         
         pshnewlist.clear();
         
         Project_Stage_History_New__c  pshnew4 = new Project_Stage_History_New__c(ID = pshnew.ID);
         pshnew4.Actual_Start_Date_PS__c = System.today() + 10;
         pshnewlist.add(pshnew4);
         
         Project_Stage_History_New__c  pshnew5 = new Project_Stage_History_New__c(ID = pshnew1.ID);
         pshnew5.Actual_End_Date_PS__c = System.today() + 10;
         pshnewlist.add(pshnew5);
         
         Project_Stage_History_New__c  pshnew6 = new Project_Stage_History_New__c(ID = pshnew2.ID);
         pshnew6.Actual_End_Date_PS__c = System.today() + 10;
         pshnewlist.add(pshnew6);
         
         Project_Stage_History_New__c  pshnew7 = new Project_Stage_History_New__c(ID = pshnew3.ID);
         pshnew7.MQ2_Date__c = System.today() + 10;
         pshnewlist.add(pshnew7);

         Update pshnewlist;            
    }
}