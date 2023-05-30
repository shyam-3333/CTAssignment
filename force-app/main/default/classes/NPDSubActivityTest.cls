@isTest
public class NPDSubActivityTest {
      public static testMethod void test(){
           Test.StartTest(); 
               list<NPD_Activity__c> updatednpdActivityList = new list<NPD_Activity__c>();
               set<NPD_Activity__c>setid = new set<NPD_Activity__c>();
               NPD_Activity__c npdActivity = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
               npdActivity.Status__c   = 'Not Started';
  
               insert npdActivity; 
               
               NPD_Activity__c npdActivity1 = new NPD_Activity__c();
               npdActivity1.Active__c            =    true;
               npdActivity1.Approval_Status__c = 'Approved';
               npdActivity1.Status__c          = 'Completed';
               npdActivity1.Type__c            = 'Activity';  
               npdActivity1.NPD_Activity__c    =  npdActivity.id;
               insert npdActivity1; 
              
               
               
               
               npdActivity.Active__c            =    true;
               npdActivity.Approval_Status__c = 'Approved';
               npdActivity.Status__c          = 'Completed';
               npdActivity.Type__c            = 'Activity';
               npdActivity.Successor__c       = 'success';
               updatednpdActivityList.add(npdActivity); 
               update updatednpdActivityList;        
               
               for(NPD_Activity__c npdid:updatednpdActivityList){
                   setid.add(npdid); 
               }
               NPDSubactivity.collectMailIDs(updatednpdActivityList);
               NPDSubactivity.sendNotificationMail(setid);
               
               
           Test.StopTest();
      }
          /* public static testMethod void test1(){
              Test.StartTest(); 
                list<NPD_Activity__c> updatednpdActivityList1 = new list<NPD_Activity__c>();
               NPD_Activity__c npdActivity5 = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
               npdActivity5.Status__c   = 'Not Started';
               insert npdActivity5;
               
               NPD_Activity__c npdActivity4 = new NPD_Activity__c();
               npdActivity4.Active__c            =    true;
               npdActivity4.Approval_Status__c = 'Pending';
               npdActivity4.Status__c          = 'Not Started';
               npdActivity4.Type__c            = 'Activity';  
               npdActivity4.Approval_Required__c = TRUE;
               npdActivity4.NPD_Activity__c    =  npdActivity5.id;
               insert npdActivity4; 
              
               npdActivity5.Active__c            =    true;
               npdActivity5.Approval_Status__c = 'Approved';
               npdActivity5.Status__c          = 'Completed';
               npdActivity5.Type__c            = 'Activity';
               updatednpdActivityList1.add(npdActivity5); 
               update updatednpdActivityList1;        
              Test.StopTest();
                   
       }*/
}