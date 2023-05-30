@isTest
public class NPD_sendEmailsToActivityOwnersTest {
    testmethod static void testme(){
   //n1.NPD_Project_Name__r.name
   
   Npd_activity_trigger_controller__c  CustomSetting1 = new Npd_activity_trigger_controller__c  ();
   CustomSetting1.name='stagetrigger';
   CustomSetting1.continueExecution__c  = false;
   insert CustomSetting1;
   
   npd_stage__c ns1= new npd_stage__c();
   ns1.name__c = 'marketing'; 
  // ns1.planned_end_date__c = date.parse('04-08-2016');
   
   insert ns1;
   
   npd_activity__c n1= new npd_activity__c();
        n1.name__c ='concept design - ids';
        n1.npd_stage__c= ns1.id;
        n1.type__c ='activity';
        n1.status__c ='in progress';
        
        n1.NPD_Sf_owner_email_address__c = 'testinguser@kvp.com';
        n1.NPD_manager_email2__c='testinguser@kvp.com';
        n1.notificationEmail__c = false;
        n1.notificationEmail2__c = false;
         insert n1;
         Test.startTest();
         
   Npd_activity_trigger_controller__c  CustomSetting2 = new Npd_activity_trigger_controller__c  ();
   CustomSetting2.name='stage trigger';
   CustomSetting2.continueExecution__c  = false;
   insert CustomSetting2;
         
         sendEmailsToActivityOwners be=new sendEmailsToActivityOwners();
         //be.query = 'Select Id From npd_activity__c Limit 200';
         Database.executeBatch(be,200);
        
         Test.stopTest();
        
        
    }

}