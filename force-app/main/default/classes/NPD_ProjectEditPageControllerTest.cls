/*********************************************************************
   Class Name       : NPD_ProjectEditPageControllerTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPD_ProjectEditPageController. 
   Created By       : Keyur Modi
   Created Date     : 4/02/2016
   LastModifiedby   : Keyur Modi
   LastModifiedDate : 4/02/2016  
*********************************************************************/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/19/2019   T01	   Hardcoded URL change fix
Saradha(Lister)  11/27/2019   T02	   Test Class Fix 
*/
@isTest
private class NPD_ProjectEditPageControllerTest{
    
    static testMethod void unitTest() {
        Test.startTest(); 
        PageReference pageRef = Page.NPD_ProjectEditPage;
        Test.setCurrentPage(pageRef);
        Boolean con=true;
        string strallcom='make';
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem               =    NPD_TestUtilityClass.getProjItemForStage('CFT Scheduling','Activity',oProjTemp.Id);
        oProjItem.Development_Component_Route__c     =   'test';
        oProjItem.Revision_Substage__c               =    TRUE;
        insert oProjItem;
         
         NPD_Project_Items__c oProjItem11               =   NEW NPD_Project_Items__c ();
         oProjItem11.Project_Template__c                =   oProjTemp.Id;
         oProjItem11.Title__c                           =  'CFT Scheduling';        
         oProjItem11.Development_Component_Route__c      =   'test';
         oProjItem11.Development_WH_Full_watch_Route__c  =   'ui';
         oProjItem11.Revision_Substage__c                =    TRUE;
         insert oProjItem11;
         
         
        NPD_Project_Items__c oProjItem1              =    NPD_TestUtilityClass.getProjItemForStage('Case Development - INH','Sub-stage',oProjTemp.Id);
        oProjItem1.Development_Component_Route__c    = 'test';
        //oProjItem1.Revision_Substage__c            =    TRUE; 
        insert oProjItem1; 
        
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
        projName.Model_No__c='MODEL101';
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
        projName.ImageUpload__c='<img src="'+sfdcURL+'/servlet/servlet.FileDownload?file=00Pf0000000LVSgEAO"></img>'; 
        projName.Development_Route__c='Component Route';
               insert projName; 
        
         //Insert Project Name
        NPD_Project_Name__c projName1 = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);
        projName1.Model_No__c='MODEL101';
        insert projName1;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.Name__c                      =    'Case Development - INH';
        oStage1.NPD_Project_Name__c          =    projName1.id;
        insert oStage1;
        
        NPD_Stage__c oStage                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage.Type__c                      =    'Sub-stage';
        oStage.Name__c                      =    'Case Development - INH';
        oStage.NPD_Project_Name__c          =    projName.id;
        
        insert oStage;
        
       
        
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('CFT Scheduling');
        oActivity.Name__c = 'CFT Scheduling';
        oActivity.Type__c= 'Activity';
        oActivity.Actual_Start_Date__c = (system.today() -2 );//<T02>
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage.Id;
        oActivity.NPD_Project_Items__c = oProjItem11.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c = projName.id ;
        insert oActivity;
        // NPD checklist 
        NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
        insert ochecklist1;
        
        System.debug('==projName.id=='+projName.id);
        Apexpages.currentpage().getparameters().put('proID',projName.Id);
        apexpages.currentPage().getParameters().put('proID',projName.Id);
        
       NPD_ProjectEditPageController proj = new NPD_ProjectEditPageController();
        proj.con=true;
        proj.EditRec();
        proj.Cancle();
        proj.SaveProject();
        proj.ActiveInactive();
        proj.upload();
        Test.StopTest();
    }
    
   static testMethod void unitTest1() {
        Test.startTest(); 
        PageReference pageRef = Page.NPD_ProjectEditPage;
        Test.setCurrentPage(pageRef);
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('CFT Scheduling','Activity',oProjTemp.Id);
        oProjItem.Development_Component_Route__c= 'test';
        oProjItem.Revision_Substage__c       =    TRUE;
        oProjItem.Development_WH_Full_watch_Route__c = 'test';
        insert oProjItem;
         
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Case Development - INH','Sub-stage',oProjTemp.Id);
        oProjItem1.Development_Component_Route__c= 'test';
        oProjItem1.Revision_Substage__c       =    TRUE; 
        oProjItem1.Development_Component_Route__c=  'test';  
        oProjItem1.Development_WH_Full_watch_Route__c = 'test';
        insert oProjItem1; 
        
         NPD_Project_Items__c oProjItem11                =   NEW NPD_Project_Items__c ();
         oProjItem11.Project_Template__c                =   oProjTemp.Id;
         oProjItem11.Title__c                           =  'CFT Scheduling';
         oProjItem11.Development_Component_Route__c     =   'test';
         oProjItem11.Revision_Substage__c                =    TRUE;
         insert oProjItem11;
        
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
        projName.Model_No__c='MODEL101';
       String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T02>
        projName.ImageUpload__c='<img src="'+sfdcURL+'/servlet/servlet.FileDownload?file=00Pf0000000LVSgEAO"></img>'; 
        projName.Development_Route__c='Development-WH/Full watch Route';
        insert projName; 
        
         //Insert Project Name
        NPD_Project_Name__c projName1 = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);
        projName1.Model_No__c='MODEL101';
        insert projName1;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.Name__c                      =    'Case Development - INH';
        oStage1.NPD_Project_Name__c          =    projName1.id;
        insert oStage1;
        
        NPD_Stage__c oStage                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage.Type__c                      =    'Sub-stage';
        oStage.Name__c                      =    'Case Development - INH';
        oStage.NPD_Project_Name__c          =    projName.id;
        /*oStage.NPD_Stage__c                 =    oStage1.id;
        oStage.Actual_Start_Date__c         =    System.Today();
        oStage.Planned_Start_Date__c        =    System.Today();
        oStage.Planned_End_Date__c          =    System.today().addYears(1);
        oStage.Planned_Lead_Time__c         =    10; */
        insert oStage;
        
        NPD_Stage__c oStage2                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage2.Type__c                      =    'Stage';
        oStage2.Name__c                      =    'Production';
        oStage2.NPD_Project_Name__c          =    projName.id;
        insert oStage2;
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage3.Type__c                      =    'Stage';
        oStage3.Name__c                      =    'Case Development - INH';
        oStage3.NPD_Project_Name__c          =    projName.id;
        oStage3.NPD_Stage__c                 =    oStage2.id;
        insert oStage3;
        
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('CFT Scheduling');
        oActivity.Name__c = 'CFT Scheduling';
        oActivity.Type__c = 'Activity';
        oActivity.Actual_Start_Date__c = (system.today() -2 );//<T01>
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage3.Id;
        
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Items__c =oProjItem11.Id;
        oActivity.NPD_Project_Name__c = projName.id ;
        insert oActivity;
        // NPD checklist 
        NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
        insert ochecklist1;

        System.debug('==projName.id=='+projName.id);
        Apexpages.currentpage().getparameters().put('proID',projName.Id);
        apexpages.currentPage().getParameters().put('proID',projName.Id);
        
        NPD_ProjectEditPageController proj = new NPD_ProjectEditPageController();
        proj.EditRec();
        proj.Cancle();
        proj.SaveProject();
        proj.ActiveInactive();
        
        proj.upload();
        Test.StopTest();
        
        /************************  For testing the create new project ************************/
        
        //String todate = '06/06/2016';
        //Date dt = Date.valueOf(todate);
        
        NPD_ProjectEditPageController  nc123=new NPD_ProjectEditPageController();
        nc123.methodAccount();
        
        
    //  string CaseMaterial='CaseMaterial';
        
        // inserting the temp record.
        
        NPD_Collections__c nc1234= new NPD_Collections__c();
        
        
        
        //nc1234.Actual_Project_End_Date__c=dt;
        //nc1234.Actual_Project_Start_Date__c=dt;
        nc1234.Case_Material__c='silver';
        nc1234.Collection_Name__c='testing';
        nc1234.Comments_Remarks__c='testing';
        nc1234.Development_Route__c='testing';
        nc1234.Gender__c='testing';
        nc1234.Market__c='testing';
        nc1234.Marketing_brief_concept_reference_number__c='testing';
    //  nc1234.MarketingRestrict__c=true;
        nc1234.Movement_Function__c='testing';
        //nc1234.Planned_End_Date__c=dt;
        nc1234.Project_Complexity__c='testing';
        nc1234.Project_Status__c='testing';
        nc1234.Project_Type__c='testing';
        nc1234.PSY_No__c='testing';
        nc1234.Reasons_for_Drop__c='testing';
        nc1234.Strap_Material__c='testing';
        nc1234.Strap_Source__c='testing';
        nc1234.Template_Type__c='testing';
        nc1234.Tentative_Launch_Month_Date__c=Date.today();
        
        insert nc1234;
        
        
    }
}