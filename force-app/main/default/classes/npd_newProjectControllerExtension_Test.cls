@isTest 
private class npd_newProjectControllerExtension_Test
{
 @isTest private static void testmethod1()
 { 
  
  
  // Insering customsetting. 
  Npd_activity_trigger_controller__c cus1=  new Npd_activity_trigger_controller__c();
  cus1.name='stagetrigger';
  cus1.continueExecution__c = false;
  insert cus1;
  
  // Inserting  npd_complexity.
  
  NPD_Complexity__c nc2 = new NPD_Complexity__c();
       nc2.Name__c  = 'Medium';
       nc2.Type__c   = 'Sub-stage';
       nc2.Lead_Time_del__c = 30;      
       nc2.record_name__c  =  'Proto Type Manufacturing';
       nc2.source__c = 'IDS';
       nc2.Record_Type__c ='Complexity Type';
       
       insert nc2;
       
        
  NPD_Complexity__c nc3 = new NPD_Complexity__c();
       nc3.Name__c  = 'Medium';
       nc3.Type__c   = 'Sub-stage';
       nc3.Lead_Time_del__c = 30;      
       nc3.record_name__c  =  'Proto Approval';
       nc3.source__c = 'IDS';
       nc3.Record_Type__c ='Complexity Type';
       
       insert nc3;
        
       
       
  
  npd_collections__c nc1= new npd_collections__c();
  nc1.name='titan raga';
  nc1.Tentative_Launch_Month_Date__c = system.now().date();
  insert nc1;
  
  npd_project_name__c np1 = new npd_project_name__c();
  np1.name='Model titan123';
  np1.source__c ='IDS';
  np1.Project_Complexity__c= 'Medium';
  np1.npd_collections__c = nc1.id;
  np1.newModelRefresh__c = 'false';
  insert np1;
  
   ApexPages.currentPage().getParameters().put('projId',np1.id);
  
  
   // parent stage Design 
   npd_stage__c ns1= new npd_stage__c();
   ns1.name__c = 'design';
   ns1.position__c = 2;
   ns1.source__c ='IDS';
   ns1.Complexity_Typess__c = 'medium';
   ns1.Planned_Lead_Time__c = 20;
   ns1.npd_collections__c = nc1.id;
   ns1.npd_project_name__c = np1.id;
   ns1.active__c = true;
   ns1.type__c ='stage';
   ns1.active__c =true;
   insert ns1;
   
   // Design stage sub stage.
   npd_stage__c ns2= new npd_stage__c();
   ns2.name__c = 'Proto Type Manufacturing';
   ns2.position__c = 1;
   ns2.source__c ='IDS';
   ns2.Complexity_Typess__c = 'medium';
   ns2.Planned_Lead_Time__c = 20;
   ns2.npd_Stage__c =ns1.id;
   ns2.npd_collections__c = nc1.id;
   ns2.npd_project_name__c = np1.id;
   ns2.active__c = true;
   ns2.type__c ='sub-stage';
   ns2.active__c =true;
   insert ns2;
  
   npd_stage__c ns3= new npd_stage__c();
   ns3.name__c = 'Proto Approval';
   ns3.position__c = 2;
   ns3.source__c ='IDS';
   ns3.Complexity_Typess__c = 'medium';
   ns3.Planned_Lead_Time__c = 20;
   ns3.npd_Stage__c =ns1.id;
   ns3.npd_collections__c = nc1.id;
   ns3.npd_project_name__c = np1.id;
   ns3.active__c = true;
   ns3.type__c ='sub-stage';
   ns3.active__c =true;
   insert ns3;
 
  npd_newProjectControllerExtension npc = new npd_newProjectControllerExtension();
  npc.fillComplexityLeadTimes();
 
 }

}