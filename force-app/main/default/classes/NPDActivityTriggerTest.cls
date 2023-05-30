/*********************************************************************
   Class Name       : NPDActivityTriggerTest 
   Type             : Test Class
   Description      : This test class covers code coverage of NPDActivityTrigger. 
   Created By       : Aamir Khan
   Created Date     : 01/12/2015
   LastModifiedby   : Sudama Lokshman
   LastModifiedDate : 04/06/2017  
*********************************************************************/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix 
*/
@isTest
public class NPDActivityTriggerTest {
      public static testMethod void testNPDActivityTrigger(){
           NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
           insert checklist;
           
           NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
           insert masterCM;
           
           NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
           insert masterST;
           
           NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
           insert masterSM;
        
           NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
           npdProject.ImageUpload__c = '';
           insert npdProject;
           
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp;
        
           NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
           oProjItem.Field_Set__c = '???Name!!!';
           insert oProjItem;
           
           NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
           oStage1.Type__c                      =    'Stage';
           oStage1.NPD_Project_Name__c = npdProject.Id;
           oStage1.NPD_Project_Items__c =  oProjItem.id;             
           oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
           oStage1.Sub_Brand1__c                                  =    'Son';
           oStage1.Market__c                                      =    'ISD';
           oStage1.Source__c                                      =    'Dom';
           oStage1.Active__c = true;
           oStage1.Type__c = 'Stage';
           oStage1.Planned_Start_Date__c= system.today();
           oStage1.Planned_lead_time__c= 4;
           oStage1.Position__c= 1;
           oStage1.PredecessorSerialNo__c= null;
           oStage1.SerialNo__c        =    'AR-01';
           //oStage1.Optional_Sub_Stages__c = 'r1:##r2:##';
           oStage1.Optional_Sub_Stages__c = ':##SHOWN'; 
           oStage1.Revision_Substage__c = false;
        
           insert oStage1;
           
           NPD_Stage__c oStage2                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage2.Type__c                      =    'Stage';
            oStage2.NPD_Project_Name__c = npdProject.Id;
            oStage2.NPD_Project_Items__c =  oProjItem.id;             
            oStage2.Marketing_brief_concept_reference_number__c    =    'MAR900';
            oStage2.Sub_Brand1__c                                  =    'Son';
            oStage2.Market__c                                      =    'ISD';
            oStage2.Source__c                                      =    'Dom';
            oStage2.Active__c = true;
            oStage2.Type__c = 'Sub-Stage';
            oStage2.Planned_Start_Date__c= system.today();
            oStage2.Planned_lead_time__c= 4;
            oStage2.Position__c= 1;
            oStage2.PredecessorSerialNo__c= null;
            oStage2.SerialNo__c        =    'AR-01';
            //oStage2.Optional_Sub_Stages__c = 'r1:##r2:##'; 
            oStage2.Optional_Sub_Stages__c = ':##SHOWN'; 
            oStage2.Revision_Substage__c = false;
            oStage2.NPD_Stage__c = oStage1.Id;
            insert oStage2;  
            
           List<NPD_Activity__c> actList = new List<NPD_Activity__c>();
               
           NPD_Activity__c activity = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
           activity.Status__c               = 'Not Started';
           activity.Actual_Start_Date__c    = NULL;
      //     activity.Actual_End_Date__c      = NULL;      by sudama       
           insert activity; 
           
           NPD_Activity__c activity1 = new NPD_Activity__c();
           activity1.Active__c            =    false;
           activity1.Approval_Status__c   = 'Approved';
           activity1.Status__c            = 'Pending';
           activity1.Type__c              = 'Activity';  
           activity1.NPD_Activity__c      =  activity.id;
           activity1.brand1__c            =  'Titan';
           activity1.Revision_Active__c    = True;
           insert activity1; 
           
           Test.StartTest();
           activity1.Status__c            = 'Not Started';
           activity1.Quantity_Required_Standard_Option__c = 10;
           activity1.Name__c = 'Pilot Lot Manufacturing - Press';
           activity1.Master_Type1__c = 'Metal';
           activity1.SerialNo__c ='AR-0301004';
           activity1.Active__c            =    true;
           activity1.Actual_Start_Date__c = System.Today();
       //    activity1.Actual_End_Date__c = System.Today() + 10;  by sudama
           activity1.NPD_Stage__c = oStage2.Id;
       //    activity1.Revision_Status__c   = 'Activate R1';
       //    activity1.Status_R0__c         ='inProgress';
           update activity1;
           
           Test.StopTest();
           
           activity1.Status__c            = 'Completed';
           activity1.Type__c              = 'Sub-Activity';
           activity1.Name__c ='Proto Dial Drawing Release and Receipt';
           //activity1.Actual_Start_Date__c = System.Today() - 5;
           //activity1.Actual_End_Date__c = System.Today() + 15; 
           update activity1;
           
           
         }
     public static testMethod void testNPDActivityTriggerNew(){
           NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
           insert checklist;
           
           NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
           insert masterCM;
           
           NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
           insert masterST;
           
           NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
           insert masterSM;
        
           NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
           npdProject.ImageUpload__c = '';
           insert npdProject;
           
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp;
        
           NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
           oProjItem.Field_Set__c = '???Name!!!';
           insert oProjItem;
           
           NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
           oStage1.Type__c                      =    'Stage';
           oStage1.NPD_Project_Name__c = npdProject.Id;
           oStage1.NPD_Project_Items__c =  oProjItem.id;             
           oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
           oStage1.Sub_Brand1__c                                  =    'Son';
           oStage1.Market__c                                      =    'ISD';
           oStage1.Source__c                                      =    'Dom';
           oStage1.Active__c = true;
           oStage1.Type__c = 'Stage';
           oStage1.Planned_Start_Date__c= system.today();
           oStage1.Planned_lead_time__c= 4;
           oStage1.Position__c= 1;
           oStage1.PredecessorSerialNo__c= null;
           oStage1.SerialNo__c        =    'AR-01';
           //oStage1.Optional_Sub_Stages__c = 'r1:##r2:##';
           oStage1.Optional_Sub_Stages__c = ':##SHOWN'; 
           oStage1.Revision_Substage__c = false;
        
           insert oStage1;
           
           NPD_Stage__c oStage2                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage2.Type__c                      =    'Stage';
            oStage2.NPD_Project_Name__c = npdProject.Id;
            oStage2.NPD_Project_Items__c =  oProjItem.id;             
            oStage2.Marketing_brief_concept_reference_number__c    =    'MAR900';
            oStage2.Sub_Brand1__c                                  =    'Son';
            oStage2.Market__c                                      =    'ISD';
            oStage2.Source__c                                      =    'Dom';
            oStage2.Active__c = true;
            oStage2.Type__c = 'Sub-Stage';
            oStage2.Planned_Start_Date__c= system.today();
            oStage2.Planned_lead_time__c= 4;
            oStage2.Position__c= 1;
            oStage2.PredecessorSerialNo__c= null;
            oStage2.SerialNo__c        =    'AR-01';
            //oStage2.Optional_Sub_Stages__c = 'r1:##r2:##'; 
            oStage2.Optional_Sub_Stages__c = ':##SHOWN'; 
            oStage2.Revision_Substage__c = false;
            oStage2.NPD_Stage__c = oStage1.Id;
            insert oStage2;  
            
           List<NPD_Activity__c> actList = new List<NPD_Activity__c>();
               
           NPD_Activity__c activity = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
           activity.Status__c               = 'Not Started';
          activity.Actual_Start_Date__c    = (System.today() -2 );//<T01>
         //  activity.Actual_End_Date__c      = NULL;           
           insert activity; 
           
           NPD_Activity__c activity1 = new NPD_Activity__c();
           activity1.Active__c            =    false;
           activity1.Approval_Status__c   = 'None';
           activity1.Status__c            = 'Pending';
           activity1.Type__c              = 'Activity';  
           activity1.NPD_Activity__c      =  activity.id;
           activity1.brand1__c            =  'Titan';
           activity1.Actual_Start_Date__c = System.Today();
           //activity1.R1_ASD__c             = System.Today();
           //activity1.R1_AED__c             = System.Today();
           activity1.R2_ASD__c             = System.Today();
           activity1.R2_AED__c             = System.Today();
           activity1.Approval_Required__c  = True;
           activity1.Revision_Active__c    = True;
           
           insert activity1; 
           
           Test.StartTest();
           activity1.Status__c            = 'In Progress';
           activity1.Quantity_Required_Standard_Option__c = 10;
           activity1.Name__c = 'Pilot Lot Manufacturing - Press';
           activity1.Master_Type1__c = 'Metal';
           activity1.SerialNo__c ='AR-0301004';
       //    activity1.Active__c            =    true;
           activity1.Approval_Status__c   = 'Approved';
       //    activity1.Actual_Start_Date__c = System.Today();
           activity1.Actual_End_Date__c = System.Today() + 10;
           activity1.NPD_Stage__c = oStage2.Id;
           activity1.Revision_Status__c   = 'Activate R1';
           activity1.Status_R0__c         ='Completed';
           activity1.Status__c         = 'Completed';
           activity1.R1_AED__c             = null;
           activity1.R2_AED__c             = null;
           activity1.R1_ASD__c             = System.Today()-1;
           activity1.R2_ASD__c             = System.Today()-1;
            try{
            update activity1;
           }catch(Exception e){
                 Boolean expectedExceptionThrown =  e.getMessage().contains('Sorry! you dont have permission to update both dates at a time.') ? true : false;
                System.AssertEquals(expectedExceptionThrown,false);
           }
           activity1.R1_ASD__c             = null;
           activity1.R2_ASD__c             = null;
           activity1.Actual_Start_Date__c = null;
            try{
            update activity1;
           }catch(Exception e){
                 Boolean expectedExceptionThrown =  e.getMessage().contains('Sorry! you dont have permission to update both dates at a time.') ? true : false;
                System.AssertEquals(expectedExceptionThrown,true);
           }           
         }
}