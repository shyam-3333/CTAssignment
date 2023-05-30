/*********************************************************************
   Class Name       : NPDStageTriggerTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPDStageTrigger. 
   Created By       : Aamir Khan
   Created Date     : 01/12/2015
   LastModifiedby   : Aamir Khan
   LastModifiedDate : 01/12/2015  
*********************************************************************/
@isTest
public class NPDStageTriggerTest{

 public static testMethod void testNPDStageTrigger() {
 
    Npd_activity_trigger_controller__c cus1=  new Npd_activity_trigger_controller__c();
    cus1.name='stagetrigger';
    cus1.continueExecution__c =  true;
          
        Test.StartTest(); 
        PageReference pageRef = Page.NPD_Project;
        Test.setCurrentPage(pageRef);
        
        //Insert Checklist
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        //Insert NPD MAster for strap type 
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        //Insert NPD MAster for Case Material
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        insert masterSM;
        
        
        //Insert Project Name 
        NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
        insert projName;
        
        NPD_Project_Name__c projName1 = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
       
        // Insert Owner       
        NPD_Master__c  oMaster     =    new NPD_Master__c();
        oMaster.Name               =    'Test Master';
        oMaster.Type__c            =    'Owner';
        insert oMaster;
        
        map<String,NPD_Stage__c> mapSerialNo_Stage = new map<String,NPD_Stage__c>();
        map<id,NPD_Stage__c> mapIdStage = new map<id,NPD_Stage__c>();
        set<id>setId = new set<id>();
        set<String>setIdStr = new set<String>();
        List<NPD_Stage__c> lstStage = new List<NPD_Stage__c>();
        list<id>lstStageId = new list<id>();
       
       
        NPD_Stage__c oStage1 = new NPD_Stage__c();     
        oStage1.Name__c = 'stage';              
        oStage1.Type__c = 'Stage';
        oStage1.PredecessorSerialNo__c = 'test';
       // lstStage.add(oStage1);
       insert oStage1;
        
       
        NPD_Stage__c oStage2 = new NPD_Stage__c();     
        oStage2.Name__c = 'stage';              
        oStage2.Type__c = 'Sub-Stage';
        oStage2.npd_stage__c = oStage1.id;
        oStage2.PredecessorSerialNo__c = 'test';
        oStage2.active__c = true;
        oStage2.position__c = 2;
        oStage2.Complexity_Typess__c = 'Medium';
        oStage2.source__c = 'IDS';
        oStage2.Complexity_Typess__c='simple';
        
        //lstStage.add(oStage);
        insert oStage2;
        
        oStage2.Complexity_Typess__c = 'Medium' ;
        update oStage2;
        
        
       
        NPD_Stage__c oStage = new NPD_Stage__c();     
        oStage.Name__c = 'stage';              
        oStage.Type__c = 'Sub-Stage';
        oStage.PredecessorSerialNo__c = 'test';
        oStage2.active__c = true;
        lstStage.add(oStage);
        insert lstStage;
                       
        NPD_Stage__c stage = new NPD_Stage__c();     
        stage.Name__c = 'stage';              
        stage.Revised_Start_Date__c = NULL;
        stage.Revised_End_Date__c = NULL;
        stage.active__c = true;
        stage.Owner__c = oMaster.id; 
        insert stage;
        
                  
        stage.Revised_Start_Date__c = Date.today();
        stage.Revised_End_Date__c = Date.today()+1;
       
        update stage;
                        
        NPD_Stage__c stage1 = new NPD_Stage__c();     
        stage1.Name__c = 'stage1';         
        stage1.NPD_Stage__c = stage.id;     
        stage1.PredecessorSerialNo__c = 'test';
        stage1.Revised_Start_Date__c = Date.today();
        stage1.Revised_End_Date__c = Date.today()+1;
        stage1.active__c = true;
        insert stage1;
          
        
        for(NPD_Stage__c obj:lstStage){
         lstStageId.add(obj.id); 
         mapIdStage.put(obj.id,obj);
         mapSerialNo_Stage.put(obj.SerialNo__c,obj);
         setid.add(obj.NPD_Stage__c);
         setidstr.add(obj.NPD_Stage__c);
        
        }
        
        NPD_UtilityController utilCon = new NPD_UtilityController(lstStage,mapIdStage);
          
        NPD_UtilityController.dateCalulationForStage(lstStage,mapSerialNo_Stage);  
        //NPD_UtilityController.checkStageStatusAndActualDate(setid,lstStage);
        //NPD_UtilityController.checkStageStatusNotStarted(setId,lstStage,mapIdStage); 
        NPD_UtilityController.afterUpdateSubStageHandlerForStartDate(lstStage,mapIdStage);
        NPD_UtilityController.afterUpdateStageHandlerForPlannedDateStage(lstStageId,mapIdStage);
        utilCon.beforeUpdateStageHandler();
 
    npd_stage__c ns9 = new npd_stage__c();
  //  ns9.Complexity_Typess__c = 'Medium';
    ns9.type__c = 'stage';
    insert ns9;
    
    npd_stage__c ns10 = new npd_stage__c();
    ns10.Complexity_Typess__c = 'Medium';
    ns10.type__c = 'sub-stage';
    ns10.npd_stage__c = ns9.id;
    ns10.position__c = 1;
    insert ns10;
 
    npd_stage__c ns11 = new npd_stage__c();
    ns11.Complexity_Typess__c = 'Medium';
    ns11.type__c = 'sub-stage';
    ns11.npd_stage__c = ns9.id;
    ns11.position__c = 2;
    insert ns11;
 
   npd_stage__c ns12 = new npd_stage__c();
   ns12.id =  ns10.id;
    ns12.Complexity_Typess__c = 'complex';
    update ns12;
 
        Test.StopTest();
    }
    
    


}