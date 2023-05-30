/*********************************************************************
   Class Name       : NPDAprovalControllerTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPDAprovalController. 
   Created By       : Keyur Modi
   Created Date     : 28/11/2015
   LastModifiedby   : Dheeraj Gangulli
   LastModifiedDate : 09/03/2016  
*********************************************************************/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister) 	11/27/2019   T01   Test Class Failure Fix 
*/
@isTest
private class NPDAprovalControllerTest {
    
    static testMethod void unitTest() {
        Test.startTest(); 
            PageReference pageRef = Page.NPDApprovalPage;
            Test.setCurrentPage(pageRef);
             
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp; 
            
            NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
            insert oProjItem;
            
            NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
            insert oCollection;
            
            NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage1.Type__c                      =    'Stage';
            insert oStage1;
            
            NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
            oStage2.Actual_Start_Date__c                           =    System.today();
            oStage2.Type__c                                        =    'Sub-stage';
            oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
            oStage2.Market__c                                      =    'Domestic';
            oStage2.Status__c                                      =    'In Progress';
            oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
            oStage2.NPD_Stage__c                                   =    oStage1.Id;
            oStage2.Planned_Start_Date__c                          =    System.today();
            oStage2.Total_Lead_Time__c = 0;
            oStage2.Position__c        = 1;
            oStage2.SerialNo__c        =    'AR-0101';
            oStage2.Planned_Lead_Time__c = 10;
            oStage2.Planned_End_Date__c =     System.today().addYears(1);
            oStage2.Phase__c = 'Design';
            oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
            oStage2.No_of_Designs__c = 2;
            insert oStage2;
            
            NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
            oActivity.Name__c = 'Briefing to IDS';
            oActivity.Actual_Start_Date__c = (System.Today()-2);//<T01> Validation rule AED can't be lesser than ASD
            oActivity.Planned_Lead_Time__c = 10;
            oActivity.Status__c = 'In Progress';
            oActivity.No_of_Designs__c = 2;
            oActivity.Approval_Status__c = 'None';
            oActivity.Market__c = 'Domestic';
            oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
            oActivity.Approval_Required__c = true;
            oActivity.NPD_Stage__c = oStage2.Id;
            oActivity.NPD_Project_Items__c = oProjItem.Id;
            oActivity.Position__c = 1;
            oActivity.SerialNo__c = 'AR-0101001';
            oActivity.Active__c = true;
           // oActivity.NPD_Project_Name__c =projName.id ;
            insert oActivity;
            // NPD checklist 
            NPD_Checklist__c ochecklist          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            ochecklist.NPD_Activity_Chklist__c   =    oActivity.Id;
            insert ochecklist;
            
            
            Apexpages.currentpage().getparameters().put('id',oActivity.Id);
            
            NPDApprovalController oNPDAppContrl    =    new NPDApprovalController();
            oNPDAppContrl.demo1();
            oNPDAppContrl.editCheckList();
            oNPDAppContrl.saveCheckList();
            oNPDAppContrl.CancelCheckList();
            //oNPDAppContrl.redirectDetailView();
            //oNPDAppContrl.ApproveRecord();
            //oNPDAppContrl.RejectRecord();
            //oNPDAppContrl.approvOrReject('Approve');
            //oNPDAppContrl.getWorkItemId(oActivity.id);
            oNPDAppContrl.viewFieldHistory();
            oNPDAppContrl.closePopup();
            //oNPDAppContrl.approveCheckList();
            //oNPDAppContrl.rejectCheckList();
            //oNPDAppContrl.droppedCheckList();
            //oNPDAppContrl.getApprovalActionsVisible();
            
        Test.stopTest();
    }
    
    static testMethod void unitTest1() {
        Test.startTest(); 
            PageReference pageRef = Page.NPDApprovalPage;
            Test.setCurrentPage(pageRef);
            
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp; 
            
            NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
            insert oProjItem;
            
            NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
            insert oCollection;
            
            NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage1.Type__c                      =    'Stage';
            insert oStage1;
            
            NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
            oStage2.Actual_Start_Date__c                           =    System.today();
            oStage2.Type__c                                        =    'Sub-stage';
            oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
            oStage2.Market__c                                      =    'Domestic';
            oStage2.Status__c                                      =    'In Progress';
            oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
            oStage2.NPD_Stage__c                                   =    oStage1.Id;
            oStage2.Planned_Start_Date__c                          =    System.today();
            oStage2.Total_Lead_Time__c = 0;
            oStage2.Position__c        = 1;
            oStage2.SerialNo__c        =    'AR-0101';
            oStage2.Planned_Lead_Time__c = 10;
            oStage2.Planned_End_Date__c =     System.today().addYears(1);
            oStage2.Phase__c = 'Design';
            oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
            oStage2.No_of_Designs__c = 2;
            insert oStage2;
            
          /*  NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
            oActivity.Name__c = 'Briefing to IDS';
            oActivity.Actual_Start_Date__c = system.today();
            oActivity.Planned_Lead_Time__c = 10;
            oActivity.Status__c = 'In Progress';
            oActivity.No_of_Designs__c = 2;
            oActivity.Approval_Status__c = 'None';
            oActivity.Market__c = 'Domestic';
            oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
            oActivity.Approval_Required__c = true;
            oActivity.NPD_Stage__c = oStage2.Id;
            oActivity.NPD_Project_Items__c = oProjItem.Id;
            oActivity.Position__c = 1;
            oActivity.SerialNo__c = 'AR-0101001';
            oActivity.Active__c = true;
            //NPD_Project_Name__c = ;
            insert oActivity;*/
            
            Apexpages.currentpage().getparameters().put('id',oStage2.Id);
            
            NPDApprovalController oNPDAppContrl    =    new NPDApprovalController();
           oNPDAppContrl.demo1();
        Test.stopTest();
    }
    
   /* static testMethod void unitTest2() {
        Test.startTest(); 
            PageReference pageRef = Page.NPDApprovalPage;
            Test.setCurrentPage(pageRef);
            
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp; 
            
            NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
            insert oProjItem;
            
            NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
            insert oCollection;
            
            NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage1.Type__c                      =    'Stage';
            insert oStage1;
            
            NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
            oStage2.Actual_Start_Date__c                           =    System.today();
            oStage2.Type__c                                        =    'Sub-stage';
            oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
            oStage2.Market__c                                      =    'Domestic';
            oStage2.Status__c                                      =    'In Progress';
            oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
            oStage2.NPD_Stage__c                                   =    oStage1.Id;
            oStage2.Planned_Start_Date__c                          =    System.today();
            oStage2.Total_Lead_Time__c = 0;
            oStage2.Position__c        = 1;
            oStage2.SerialNo__c        =    'AR-0101';
            oStage2.Planned_Lead_Time__c = 10;
            oStage2.Planned_End_Date__c =     System.today().addYears(1);
            oStage2.Phase__c = 'Design';
            oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
            oStage2.No_of_Designs__c = 2;
            insert oStage2;
            
            NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
            oActivity.Name__c = 'Briefing to IDS';
            oActivity.Actual_Start_Date__c = system.today();
            oActivity.Planned_Lead_Time__c = 10;
            oActivity.Status__c = 'In Progress';
            oActivity.No_of_Designs__c = 2;
            oActivity.Approval_Status__c = 'None';
            oActivity.Market__c = 'Domestic';
            oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
            oActivity.Approval_Required__c = true;
            oActivity.NPD_Stage__c = oStage2.Id;
            oActivity.NPD_Project_Items__c = oProjItem.Id;
            oActivity.Position__c = 1;
            oActivity.SerialNo__c = 'AR-0101001';
            oActivity.Active__c = true;
            //NPD_Project_Name__c = ;
            insert oActivity;
            
              // NPD checklist 
            NPD_Checklist__c ochecklist          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            ochecklist.Approval_Status__c        =    'Rejected';
            ochecklist.NPD_Activity_Chklist__c   =    oActivity.Id;
            insert ochecklist;
            
            Apexpages.currentpage().getparameters().put('id',oActivity.Id);
            
            NPDApprovalController oNPDAppContrl    =    new NPDApprovalController();
            oNPDAppContrl.demo1();
            oNPDAppContrl.editCheckList();
            oNPDAppContrl.CancelCheckList();
            //oNPDAppContrl.redirectDetailView();
            //oNPDAppContrl.ApproveRecord();
            //oNPDAppContrl.RejectRecord();
            //oNPDAppContrl.approvOrReject('Approve');
            //oNPDAppContrl.getWorkItemId(oActivity.id);
            oNPDAppContrl.viewFieldHistory();
            oNPDAppContrl.closePopup();
            //oNPDAppContrl.approveCheckList();
            //oNPDAppContrl.rejectCheckList();
            //oNPDAppContrl.droppedCheckList();
            //oNPDAppContrl.getApprovalActionsVisible();
            oActivity.Approval_Status__c = 'Approved';
            update oActivity; 
            oNPDAppContrl.saveCheckList();
        Test.stopTest();
    }*/
    static testMethod void unitTest3() {
        Test.startTest(); 
            PageReference pageRef = Page.NPDApprovalPage;
            Test.setCurrentPage(pageRef);
            
            // NPD checklist 
            NPD_Checklist__c ochecklist          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            insert ochecklist;
            
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
            NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
            insert projName; 
            
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp; 
            
            NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
            insert oProjItem;
            
            NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
            insert oCollection;
            
            NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage1.Type__c                      =    'Stage';
            insert oStage1;
            
            NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
            oStage2.Actual_Start_Date__c                           =    System.today();
            oStage2.Type__c                                        =    'Sub-stage';
            oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
            oStage2.Market__c                                      =    'Domestic';
            oStage2.Status__c                                      =    'In Progress';
            oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
            oStage2.NPD_Stage__c                                   =    oStage1.Id;
            oStage2.Planned_Start_Date__c                          =    System.today();
            oStage2.Total_Lead_Time__c = 0;
            oStage2.Position__c        = 1;
            oStage2.SerialNo__c        =    'AR-0101';
            oStage2.Planned_Lead_Time__c = 10;
            oStage2.Planned_End_Date__c =     System.today().addYears(1);
            oStage2.Phase__c = 'Design';
            oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
            oStage2.No_of_Designs__c = 2;
            insert oStage2;
            
            NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
            oActivity.Name__c = 'Briefing to IDS';
            oActivity.Actual_Start_Date__c = (System.Today()-2);//<T01> Validation rule AED can't be lesser than ASD
            oActivity.Planned_Lead_Time__c = 10;
            oActivity.Status__c = 'In Progress';
            oActivity.No_of_Designs__c = 2;
            oActivity.Approval_Status__c = 'None';
            oActivity.Market__c = 'Domestic';
            oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
            oActivity.Approval_Required__c = true;
            oActivity.NPD_Stage__c = oStage2.Id;
            oActivity.NPD_Project_Items__c = oProjItem.Id;
            oActivity.Position__c = 1;
            oActivity.SerialNo__c = 'AR-0101001';
            oActivity.Active__c = true;
            //oActivity.Approval_Status__c = 'Approved';
            oActivity.NPD_Project_Name__c = projName.id;
            insert oActivity;
            
            // NPD checklist 
            NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            ochecklist1.Approval_Status__c        =    'Dropped';
            ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
            insert ochecklist1;
            
             // NPD checklist 
            NPD_Checklist__c ochecklist2          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            ochecklist2.Approval_Status__c        =    'Approved';
            ochecklist2.NPD_Activity_Chklist__c   =    oActivity.Id;
            insert ochecklist2;
            
            Apexpages.currentpage().getparameters().put('id',oActivity.Id);
            
            NPDApprovalController oNPDAppContrl    =    new NPDApprovalController();
            oNPDAppContrl.demo1();
            oNPDAppContrl.editCheckList();
            oNPDAppContrl.CancelCheckList();
           // oNPDAppContrl.redirectDetailView();
            //oNPDAppContrl.RejectRecord();
            oNPDAppContrl.viewFieldHistory();
            oNPDAppContrl.closePopup();
            //oNPDAppContrl.getApprovalActionsVisible();
            /*oActivity.Approval_Status__c = 'Approved';
            update oActivity; */ 
            oNPDAppContrl.saveCheckList();
           
        Test.stopTest();
    }
    static testMethod void unitTest4() {
        Test.startTest(); 
            PageReference pageRef = Page.NPDApprovalPage;
            Test.setCurrentPage(pageRef);
            
            // NPD checklist 
            NPD_Checklist__c ochecklist          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            insert ochecklist;
            
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
            NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
            insert projName; 
            
            NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp; 
            
            NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
            insert oProjItem;
            
            NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
            insert oCollection;
            
            NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
            oStage1.Type__c                      =    'Stage';
            insert oStage1;
            
            NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
            oStage2.Actual_Start_Date__c                           =    System.today();
            oStage2.Type__c                                        =    'Sub-stage';
            oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
            oStage2.Market__c                                      =    'Domestic';
            oStage2.Status__c                                      =    'In Progress';
            oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
            oStage2.NPD_Stage__c                                   =    oStage1.Id;
            oStage2.Planned_Start_Date__c                          =    System.today();
            oStage2.Total_Lead_Time__c = 0;
            oStage2.Position__c        = 1;
            oStage2.SerialNo__c        =    'AR-0101';
            oStage2.Planned_Lead_Time__c = 10;
            oStage2.Planned_End_Date__c =     System.today().addYears(1);
            oStage2.Phase__c = 'Design';
            oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
            oStage2.No_of_Designs__c = 2;
            oStage2.NPD_Project_Name__c = projName.Id;
            insert oStage2;
            
            NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
            oActivity.Name__c = 'Briefing to IDS';
            oActivity.Actual_Start_Date__c = (System.Today()-2);//<T01> Validation rule AED can't be lesser than ASD
            oActivity.Planned_Lead_Time__c = 10;
            oActivity.Status__c = 'In Progress';
            oActivity.No_of_Designs__c = 2;
            oActivity.Approval_Status__c = 'None';
            oActivity.Market__c = 'Domestic';
            oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
            oActivity.Approval_Required__c = true;
            oActivity.NPD_Stage__c = oStage2.Id;
            oActivity.NPD_Project_Items__c = oProjItem.Id;
            oActivity.Position__c = 1;
            oActivity.SerialNo__c = 'AR-0101001';
            oActivity.Active__c = true;
            //oActivity.Approval_Status__c = 'Approved';
            oActivity.NPD_Project_Name__c = projName.id;
            insert oActivity;
            
            // NPD checklist 
            NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            ochecklist1.Approval_Status__c        =    'Dropped';
            ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
            insert ochecklist1;
            
             // NPD checklist 
            NPD_Checklist__c ochecklist2          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            ochecklist2.Approval_Status__c        =    'Approved';
            ochecklist2.NPD_Activity_Chklist__c   =    oActivity.Id;
            insert ochecklist2;
            
            Apexpages.currentpage().getparameters().put('id',oActivity.Id);
            
            NPDApprovalController oNPDAppContrl    =    new NPDApprovalController();
            oNPDAppContrl.demo1();
            oNPDAppContrl.editCheckList();
            oNPDAppContrl.CancelCheckList();
           // oNPDAppContrl.redirectDetailView();
           // oNPDAppContrl.RejectRecord();
            oNPDAppContrl.viewFieldHistory();
            oNPDAppContrl.closePopup();
            //oNPDAppContrl.getApprovalActionsVisible();
            /*oActivity.Approval_Status__c = 'Approved';
            update oActivity; */ 
            oNPDAppContrl.saveCheckList();
            oNPDAppContrl.stage = oStage2;
            oNPDAppContrl.redirectDetailViewstage();
            oNPDAppContrl.ApproveRecordstage();
            oNPDAppContrl.RejectRecordstage();
            
            oNPDAppContrl.allowattach = true;
            oNPDAppContrl.showAttachment();
            
            oNPDAppContrl.allowattach = true;
            oNPDAppContrl.hideAttachment();
            
            Blob b = Blob.valueOf('Test Data'); 
            attachment a1= new attachment();
            a1.name='hello';
            a1.body=b;
            a1.parentid = oActivity.id;
            oNPDAppContrl.upload();
            
            
            
        Test.stopTest();
    }
}