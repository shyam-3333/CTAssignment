@isTest
public class Npd_Insert_New_Act_Rec_Controller_Test
{
   Private static TestMethod void TestMeth1()
   {
     npd_activity__c na1 = new npd_activity__c();
     na1.name__c='testing act';
     na1.type__c = 'Activity';
     na1.position__c =2;
     
     ApexPages.StandardController s1 = new ApexPages.StandardController(na1);
     
     
     NPD_Collections__c nc1 = new NPD_Collections__c ();
     nc1.name='testin collection';
     nc1.Tentative_Launch_Month_Date__c = system.Today();
     insert nc1;
     
     NPD_Project_Name__c np1 = new NPD_Project_Name__c ();
     np1.name='testing proj';
     np1.NPD_Collections__c = nc1.id;
     insert np1;
     
     npd_stage__c ns1 = new npd_stage__c();
     ns1.name__c='parent stage';
     ns1.type__c ='stage';
     insert ns1;
     
     npd_stage__c ns2 = new npd_stage__c();
     ns2.name__c='parent stage';
     ns2.type__c ='sub-stage';
     ns2.npd_stage__c = ns1.id;
     insert ns2;
     
     npd_activity__c na2= new npd_activity__c();
     na2.name__c='Testing act';
     na2.type__c ='Activity';
     na2.npd_stage__c = ns2.id;
     na2.position__c = 1;
     insert na2;
     
     
     npd_activity__c na3= new npd_activity__c();
     na3.name__c='Testing act';
     na3.type__c ='Activity';
     na3.npd_stage__c = ns2.id;
     na3.position__c = 2;
     insert na3;
     
     npd_activity__c na4= new npd_activity__c();
     na4.name__c='Testing act';
     na4.type__c ='Activity';
     na4.npd_stage__c = ns2.id;
     na4.position__c = 3;
     insert na4;
     
     
     
     Npd_Insert_New_Act_Rec_Controller n1 = new Npd_Insert_New_Act_Rec_Controller(s1);
     n1.selectedCollection = nc1.id;
     n1.selectedProjectName = np1.id;
     n1.selectedStage =ns1.id;
     n1.selectedubstage=ns2.id;
    // n1.SelectedActivity =na2.id;
     
     n1.callmeth();
     n1.SaveRecord();   
   }
   
   
    Private static TestMethod void TestMeth2()
   {
     npd_activity__c na1 = new npd_activity__c();
     na1.name__c='testing act';
     na1.type__c = 'Activity';
     na1.position__c =2;
     
     ApexPages.StandardController s1 = new ApexPages.StandardController(na1);
     
     
     NPD_Collections__c nc1 = new NPD_Collections__c ();
     nc1.name='testin collection';
     nc1.Tentative_Launch_Month_Date__c = system.Today();
     insert nc1;
     
     NPD_Project_Name__c np1 = new NPD_Project_Name__c ();
     np1.name='testing proj';
     np1.NPD_Collections__c = nc1.id;
     insert np1;
     
     npd_stage__c ns1 = new npd_stage__c();
     ns1.name__c='parent stage';
     ns1.type__c ='stage';
     insert ns1;
     
     npd_stage__c ns2 = new npd_stage__c();
     ns2.name__c='parent stage';
     ns2.type__c ='sub-stage';
     ns2.npd_stage__c = ns1.id;
     insert ns2;
     
     npd_activity__c na23= new npd_activity__c();
     na23.name__c='Testing act';
     na23.type__c ='Activity';
     na23.npd_stage__c = ns2.id;
     na23.position__c = 1;
     insert na23;
     
     
     npd_activity__c na2= new npd_activity__c();
     na2.name__c='Testing act';
     na2.type__c ='sub-Activity';
     na2.npd_activity__c = na23.id;
     na2.position__c = 1;
     insert na2;
     
     
     npd_activity__c na3= new npd_activity__c();
     na3.name__c='Testing act';
     na3.type__c ='sub-Activity';
     na3.npd_activity__c = na23.id;
     na3.position__c = 2;
     insert na3;
     
     npd_activity__c na4= new npd_activity__c();
     na4.name__c='Testing act';
     na4.type__c ='sub-Activity';
     na4.npd_activity__c = na23.id;
     na4.position__c = 3;
     insert na4;
     
     
     
     Npd_Insert_New_Act_Rec_Controller n1 = new Npd_Insert_New_Act_Rec_Controller(s1);
     n1.selectedCollection = nc1.id;
     n1.selectedProjectName = np1.id;
     n1.selectedStage =ns1.id;
     n1.selectedubstage=ns2.id;
     n1.SelectedActivity =na2.id;
     
     n1.callmeth();
     n1.SaveRecord();   
   }
   
}