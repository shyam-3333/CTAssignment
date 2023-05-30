@isTest(seeAllData = false)

public class NPD_GanttViewReportController_Test{
    
    public static testMethod void testMethod1(){
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.SalesforceUser__c = UserInfo.getUserID();
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        masterPD.SalesforceUser__c = UserInfo.getUserID();
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM.SalesforceUser__c = UserInfo.getUserID();
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterSM.SalesforceUser__c = UserInfo.getUserID();
        insert masterSM;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        npdProject.ImageUpload__c = '';
        npdProject.NPD_Collections__c = collection.Id;
        insert npdProject;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.NPD_Project_Name__c = npdProject.Id;
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Active__c = true;
        oStage1.Type__c = 'Stage';
        oStage1.Planned_Start_Date__c= system.today();
        oStage1.Planned_End_Date__c = system.today().addMonths(6);
        oStage1.Actual_Start_Date__c = system.today().addMonths(1);
        oStage1.Actual_End_Date__c = system.today().addMonths(6);
        oStage1.Planned_lead_time__c= 4;
        oStage1.Position__c= 1;
        oStage1.PredecessorSerialNo__c= null;
        oStage1.SerialNo__c        =    'AR-01';
        oStage1.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage1.Revision_Substage__c = false;
        
        insert oStage1;      
        
        NPD_Stage__c oStage2                 =    NPD_TestUtilityClass.getNPDStage('Production');
        oStage2.NPD_Project_Name__c = npdProject.Id;
        oStage2.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage2.Sub_Brand1__c                                  =    'Son';
        oStage2.Market__c                                      =    'ISD';
        oStage2.Source__c                                      =    'Dom';
        oStage2.Active__c = true;
        oStage2.Type__c = 'Stage';
        oStage2.Planned_Start_Date__c= system.today();
        oStage2.Planned_End_Date__c = system.today().addMonths(6);
        oStage2.Actual_Start_Date__c = system.today().addMonths(1);
        oStage2.Actual_End_Date__c = system.today().addMonths(6);
        oStage2.Planned_lead_time__c= 4;
        oStage2.Position__c= 1;
        oStage2.PredecessorSerialNo__c= null;
        oStage2.SerialNo__c        =    'AR-01';
        oStage2.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage2.Revision_Substage__c = false;
        insert oStage2;      
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Concept Finalization');
        oStage3.NPD_Project_Name__c = npdProject.Id;
        oStage3.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage3.Sub_Brand1__c                                  =    'Son';
        oStage3.Market__c                                      =    'ISD';
        oStage3.Source__c                                      =    'Dom';
        oStage3.Active__c = true;
        oStage3.Type__c = 'Sub-Stage';
        oStage3.Planned_Start_Date__c= system.today();
        oStage3.Planned_End_Date__c = system.today().addMonths(6);
        oStage3.Actual_Start_Date__c = system.today().addMonths(1);
        oStage3.Actual_End_Date__c = system.today().addMonths(6);
        oStage3.Planned_lead_time__c= 4;
        oStage3.Position__c= 1;
        oStage3.PredecessorSerialNo__c= null;
        oStage3.SerialNo__c        =    'AR-01';
        oStage3.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage3.Revision_Substage__c = false;
        oStage3.NPD_Stage__c = oStage1.Id;
        insert oStage3;      
        
        Test.StartTest();
            NPD_GanttViewReportController ganttView = new NPD_GanttViewReportController ();
            ganttView.selectedCollectionName = collection.Id;
            ganttView.queryModels();
            //ganttView.queryData();
            ganttView.selectedModelName = null;
            ganttView.selectedStageName = 'Stage And Sub-Stage';
            ganttView.queryData();
            
        Test.StopTest();
    }
    
    public static testMethod void testMethod2(){
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.SalesforceUser__c = UserInfo.getUserID();
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        masterPD.SalesforceUser__c = UserInfo.getUserID();
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM.SalesforceUser__c = UserInfo.getUserID();
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterSM.SalesforceUser__c = UserInfo.getUserID();
        insert masterSM;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        npdProject.ImageUpload__c = '';
        npdProject.NPD_Collections__c = collection.Id;
        insert npdProject;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.NPD_Project_Name__c = npdProject.Id;
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Active__c = true;
        oStage1.Type__c = 'Stage';
        oStage1.Planned_Start_Date__c= system.today();
        oStage1.Planned_End_Date__c = system.today().addMonths(6);
        oStage1.Actual_Start_Date__c = system.today().addMonths(1);
        oStage1.Actual_End_Date__c = system.today().addMonths(6);
        oStage1.Planned_lead_time__c= 4;
        oStage1.Position__c= 1;
        oStage1.PredecessorSerialNo__c= null;
        oStage1.SerialNo__c        =    'AR-01';
        oStage1.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage1.Revision_Substage__c = false;
        
        insert oStage1;      
        
        NPD_Stage__c oStage2                 =    NPD_TestUtilityClass.getNPDStage('Production');
        oStage2.NPD_Project_Name__c = npdProject.Id;
        oStage2.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage2.Sub_Brand1__c                                  =    'Son';
        oStage2.Market__c                                      =    'ISD';
        oStage2.Source__c                                      =    'Dom';
        oStage2.Active__c = true;
        oStage2.Type__c = 'Stage';
        oStage2.Planned_Start_Date__c= system.today();
        oStage2.Planned_End_Date__c = system.today().addMonths(6);
        oStage2.Actual_Start_Date__c = system.today().addMonths(1);
        oStage2.Actual_End_Date__c = system.today().addMonths(6);
        oStage2.Planned_lead_time__c= 4;
        oStage2.Position__c= 1;
        oStage2.PredecessorSerialNo__c= null;
        oStage2.SerialNo__c        =    'AR-01';
        oStage2.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage2.Revision_Substage__c = false;
        insert oStage2;      
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Concept Finalization');
        oStage3.NPD_Project_Name__c = npdProject.Id;
        oStage3.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage3.Sub_Brand1__c                                  =    'Son';
        oStage3.Market__c                                      =    'ISD';
        oStage3.Source__c                                      =    'Dom';
        oStage3.Active__c = true;
        oStage3.Type__c = 'Sub-Stage';
        oStage3.Planned_Start_Date__c= system.today();
        oStage3.Planned_End_Date__c = system.today().addMonths(6);
        oStage3.Actual_Start_Date__c = system.today().addMonths(1);
        oStage3.Actual_End_Date__c = system.today().addMonths(6);
        oStage3.Planned_lead_time__c= 4;
        oStage3.Position__c= 1;
        oStage3.PredecessorSerialNo__c= null;
        oStage3.SerialNo__c        =    'AR-01';
        oStage3.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage3.Revision_Substage__c = false;
        oStage3.NPD_Stage__c = oStage1.Id;
        insert oStage3;      
        
        
        Test.StartTest();    
            NPD_GanttViewReportController ganttView = new NPD_GanttViewReportController ();
            ganttView.selectedCollectionName = collection.Id;
            ganttView.queryModels();
            ganttView.queryData();
            
            ganttView.selectedModelName = npdProject.Name;
            ganttView.selectedStageName = 'Stage And Sub-Stage';
            ganttView.queryData();
        
        Test.StopTest();
    }
    
    public static testMethod void testMethod3(){
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.SalesforceUser__c = UserInfo.getUserID();
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        masterPD.SalesforceUser__c = UserInfo.getUserID();
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM.SalesforceUser__c = UserInfo.getUserID();
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterSM.SalesforceUser__c = UserInfo.getUserID();
        insert masterSM;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        npdProject.ImageUpload__c = '';
        npdProject.NPD_Collections__c = collection.Id;
        insert npdProject;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.NPD_Project_Name__c = npdProject.Id;
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Active__c = true;
        oStage1.Type__c = 'Stage';
        oStage1.Planned_Start_Date__c= system.today();
        oStage1.Planned_End_Date__c = system.today().addMonths(6);
        oStage1.Actual_Start_Date__c = system.today().addMonths(1);
        oStage1.Actual_End_Date__c = system.today().addMonths(6);
        oStage1.Planned_lead_time__c= 4;
        oStage1.Position__c= 1;
        oStage1.PredecessorSerialNo__c= null;
        oStage1.SerialNo__c        =    'AR-01';
        oStage1.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage1.Revision_Substage__c = false;
        
        insert oStage1;      
        
        NPD_Stage__c oStage2                 =    NPD_TestUtilityClass.getNPDStage('Production');
        oStage2.NPD_Project_Name__c = npdProject.Id;
        oStage2.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage2.Sub_Brand1__c                                  =    'Son';
        oStage2.Market__c                                      =    'ISD';
        oStage2.Source__c                                      =    'Dom';
        oStage2.Active__c = true;
        oStage2.Type__c = 'Stage';
        oStage2.Planned_Start_Date__c= system.today();
        oStage2.Planned_End_Date__c = system.today().addMonths(6);
        oStage2.Actual_Start_Date__c = system.today().addMonths(1);
        oStage2.Actual_End_Date__c = system.today().addMonths(6);
        oStage2.Planned_lead_time__c= 4;
        oStage2.Position__c= 1;
        oStage2.PredecessorSerialNo__c= null;
        oStage2.SerialNo__c        =    'AR-01';
        oStage2.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage2.Revision_Substage__c = false;
        insert oStage2;      
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Concept Finalization');
        oStage3.NPD_Project_Name__c = npdProject.Id;
        oStage3.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage3.Sub_Brand1__c                                  =    'Son';
        oStage3.Market__c                                      =    'ISD';
        oStage3.Source__c                                      =    'Dom';
        oStage3.Active__c = true;
        oStage3.Type__c = 'Sub-Stage';
        oStage3.Planned_Start_Date__c= system.today();
        oStage3.Planned_End_Date__c = system.today().addMonths(6);
        oStage3.Actual_Start_Date__c = system.today().addMonths(1);
        oStage3.Actual_End_Date__c = system.today().addMonths(6);
        oStage3.Planned_lead_time__c= 4;
        oStage3.Position__c= 1;
        oStage3.PredecessorSerialNo__c= null;
        oStage3.SerialNo__c        =    'AR-01';
        oStage3.Optional_Sub_Stages__c = ':##SHOWN'; 
        oStage3.Revision_Substage__c = false;
        oStage3.NPD_Stage__c = oStage1.Id;
        insert oStage3;      
        
        
        Test.StartTest();    
            NPD_GanttViewReportController ganttView = new NPD_GanttViewReportController ();
            ganttView.selectedCollectionName = collection.Id;
            ganttView.queryModels();
            ganttView.queryData();
            
            ganttView.selectedModelName = npdProject.Name;
            ganttView.selectedStageName = 'Stage';
            ganttView.queryData();
        
        Test.StopTest();
    }
    
}