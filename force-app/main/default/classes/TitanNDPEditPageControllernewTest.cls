/*
    Name:                       TitanNDPEditPageControllernewTest
    Created By:                 Sudama Lokshman
    Created Date:               12/04/2017
    Description:                Test Class of TitanNDPEditPageControllernew Coltroller            
    Methods Used:
*/

@isTest
public class TitanNDPEditPageControllernewTest{
    public static testMethod void testMethodOne(){

        NPD_Master__c  masterBrand = NPD_TestUtilityClass.getNPDMaster('Brand');
        masterBrand.SalesforceUser__c = UserInfo.getUserID();
        masterBrand.Name = 'Test PMG 1';
        insert masterBrand; 
      
        //
             
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        NPD_Master__c  nm1=new NPD_Master__c();
        nm1.name='testingtask';
        nm1.SalesforceUser__c=u.id;
        nm1.UserID__c='testing@gmail.com';
        insert nm1; 
        
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
        
         //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert Project Name 
        NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);
            projName.NPD_Collections__c = collection.id;
            projName.source__c = 'IDS';
            projName.Brand1__c = 'Titan';
            projName.ImageUpload__c = '<img src="https://na20.salesforce.com/servlet/servlet.FileDownload?file=00P1400000s8SuhEAE"></img>';
        insert projName;
        
        // insert project templte
          NPD_Project_Template__c  projTemplate = NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert projTemplate;
            
        // insert project items
          NPD_Project_Items__c  projItems = NPD_TestUtilityClass.getProjItemForStage('Make or Buy and Model No. Allocation','Sub-Activity',projTemplate.Id);
            projItems.Field_Set__c = '???ISCM_Briefing_Date__c,Case_Model_No_Allocation_date__c';
            insert projItems;
            
           NPD_Project_Items__c  projItems1 = NPD_TestUtilityClass.getProjItemForStage('Proto Design Input','Sub-Activity',projTemplate.Id);
            projItems.Field_Set__c = '???ISCM_Briefing_Date__c,Case_Model_No_Allocation_date__c';
            insert projItems1;
            
        // insert Email 
        NPD_Email__c  email = new NPD_Email__c(Name = 'Proto Design Input',NPD_Project_Items__c =projItems1.id,Type__c = 'Successor');    
        insert email;
        // Insert Project Complexity
  /*     NPD_Complexity__c projectComplexity = new NPD_Complexity__c();
       projectComplexity.Name__c  = 'Medium';
       projectComplexity.Type__c   = 'Sub-stage';
       projectComplexity.Lead_Time_del__c = 30;      
       projectComplexity.record_name__c  =  'testing substage';
       projectComplexity.source__c = 'IDS';
       projectComplexity.Record_Type__c ='Complexity Type';
       insert projectComplexity;   */
        
         //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
            insert oProjTemp; 
            
        //Insert NPD Project Item
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
            insert oProjItem1;
       /* NPD_Stage__c oStage0                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage0.Planned_Start_Date__c        =    SYstem.today();
        oStage0.Planned_Lead_Time__c         =    7;
        insert oStage0; */ 
              
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
       oStage1.Actual_Start_Date__c                           =    System.today();
        oStage1.Type__c                                        =    'Sub-Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'In Progress';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage1.NPD_Stage__c                                   =    oStage0.Id;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    5;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Start_Date__c                          =    SYstem.today();
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.NPD_User__c                                    =    masterBrand.id;
        oStage1.Source__c                                      =    'OSD';
        insert oStage1; 
        
        //Insert NPD Stage    
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Stage';
        oStage2.Active__c                                      =    TRUE;
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'In Progress';
        oStage2.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c                             =    4;
        oStage2.Position__c                                    =    2;
        oStage2.SerialNo__c                                    =    'AR-0101';
        oStage2.Planned_Lead_Time__c                           =    10;
        oStage2.Planned_End_Date__c                            =    System.today().addDays(2);
        oStage2.Phase__c                                       =    'Design';
        oStage2.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage2.NPD_Project_Name__c                            =    projName.id;
        oStage2.No_of_Designs__c                               =    2;
        oStage2.Status__c                                      =    'In Progress';
        oStage2.Source__c                                      =    'OSD';
        oStage2.design_manager_npd_master__c                   =     nm1.id;
    //    oStage2.NPD_User__c                                    =    masterBrand.id;
        oStage2.NPD_Collections__c                             = collection.Id;
         oStage2.brand1__c= 'Titan';
        insert oStage2;
        
         NPD_Activity__c oActivity1            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
       // oActivity1.Name__c = 'Proto Dial Drawing Release and Receipt';
        oActivity1.Name__c = 'Watch Deposition';
        oActivity1.Actual_Start_Date__c = system.today()-3;
        oActivity1.Actual_End_Date__c=system.today().addDays(-1);
        oActivity1.Planned_Lead_Time__c = 10;
        oActivity1.Status__c = 'Completed';
        oActivity1.NPD_Collections__c = collection.Id;
        oActivity1.No_of_Designs__c = 2;
        oActivity1.Approval_Status__c = 'Approved';
        oActivity1.Market__c = 'Domestic';
        oActivity1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity1.Approval_Required__c = true;
        oActivity1.NPD_Stage__c = oStage2.Id;
        oActivity1.NPD_Project_Items__c = projItems.Id;
        oActivity1.Position__c = 1;
        oActivity1.SerialNo__c = 'AR-0101001';
        oActivity1.Active__c = true;
        oActivity1.NPD_User__c                                    =    masterBrand.id;
        oActivity1.NPD_Project_Name__c =projName.id;
     //   oActivity1.NPD_Activity__c=oActivity.id;
        oActivity1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        insert oActivity1;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'Proto Design Input';
        oActivity.Actual_Start_Date__c = system.today()-2;
        oActivity.Actual_End_Date__c=system.today().addDays(-1);
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'Approved';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage2.Id;
        oActivity.NPD_Project_Items__c = projItems.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Items__c = projItems.id;
        oActivity.NPD_Project_Name__c =projName.id;
     //   oActivity.NPD_User__c                                    =    masterBrand.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity.NPD_Activity__c=oActivity1.id;
        insert oActivity;
        
        
           //Insert NPD Activity
        NPD_Activity__c oActivity111   =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity111.Name__c = 'Proto Design Input';
        oActivity111.Actual_Start_Date__c = system.today()-2;
        oActivity111.Actual_End_Date__c=system.today().addDays(-1);
        oActivity111.Planned_Lead_Time__c = 10;
        oActivity111.Status__c = 'In Progress';
        oActivity111.No_of_Designs__c = 2;
        oActivity111.Approval_Status__c = 'Approved';
        oActivity111.Market__c = 'Domestic';
        oActivity111.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity111.Approval_Required__c = true;
        oActivity111.NPD_Stage__c = oStage2.Id;
        oActivity111.NPD_Project_Items__c = projItems.Id;
        oActivity111.Position__c = 1;
        oActivity111.SerialNo__c = 'AR-0101001';
        oActivity111.Active__c = true;
        oActivity111.NPD_Project_Items__c = projItems.id;
        oActivity111.NPD_Project_Name__c =projName.id;
        oActivity.NPD_User__c                                    =    masterBrand.id;
        oActivity111.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity111.NPD_Activity__c=oActivity1.id;
        insert oActivity111;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity2            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity2.Name__c = 'Dial for Proto Mfg';
        oActivity2.Actual_Start_Date__c = system.today()-2;
        oActivity2.Actual_End_Date__c=system.today().addDays(-1);
        oActivity2.Planned_Lead_Time__c = 10;
        oActivity2.Status__c = 'In Progress';
        oActivity2.No_of_Designs__c = 2;
        oActivity2.Approval_Status__c = 'Approved';
        oActivity2.Market__c = 'Domestic';
        oActivity2.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity2.Approval_Required__c = true;
        oActivity2.NPD_Stage__c = oStage2.Id;
        oActivity2.NPD_Project_Items__c = projItems.Id;
        oActivity2.Position__c = 1;
        oActivity2.SerialNo__c = 'AR-0101001';
        oActivity2.Active__c = true;
        oActivity2.NPD_User__c                                    =    masterBrand.id;
        oActivity2.NPD_Project_Name__c =projName.id;
        oActivity2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity2.NPD_Activity__c=oActivity1.id;
        insert oActivity2;
          ApexPages.currentPage().getParameters().put('brand','Titan');
                  
        task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id;        
        insert tk;
          
      /*  TitanNDPEditPageControllernew editPage1 = new TitanNDPEditPageControllernew();
            editPage1.strActionId = projName.id;
            editPage1.collection  = 'Demo Collection';
            editPage1.selectedBrandName = 'Titan';
            editPage1.selectedType = 'Stage';
            editPage1.displayImage();
            editPage1.selectCollection();
            editPage1.displaymodel();
            editPage1.displayStageActivity();
            editPage1.displayDynamicTable();
            editPage1.displayStageActivityScreen();
            editPage1.displayActivityScreen(); */
      TitanNDPEditPageControllernew editPage2 = new TitanNDPEditPageControllernew();
              editPage2.selectedid= oStage2.Id;
              editPage2.selectedOwner = 'Test PMG 1';
            editPage2.toaddre = 'sudama.lokshman2010@gmail.com,sudama.lokshman@kvpcorp.com';
            editPage2.subject = 'test mail';
            editPage2.text1 = 'test';
            editPage2.strActionId = projName.id;
            editPage2.selectedid = oActivity1.id;
            editPage2.stagename = 'Proto Design Input';
            editPage2.collection  = 'Demo Collection';
            editPage2.selectedBrandName = 'Titan';
            editPage2.selectedType = 'Activity';
            editPage2.displayImage();
            editPage2.selectCollection();
            editPage2.displaymodel();
            editPage2.displayStageActivity();
            editPage2.displayDynamicTable();
            editPage2.activateActivity();
            editPage2.saveActivity();
            editPage2.displayActivityScreen();
            editPage2.selectedType = 'Stage';
            editPage2.saveStage();
            editPage2.displayStageActivityScreen();
            editPage2.displayStageActivity();
             editPage2.strActionname= 'Marketing Brief/Concept Stage';
            editPage2.displayStageActivity();
           editPage2.selectedType = 'Sub-Activity';
           editPage2.displayStageActivity();
           editPage2.displayActivityScreen();
            TitanNDPEditPageControllernew.taskWrapper wrapTask = new TitanNDPEditPageControllernew.taskWrapper();
            TitanNDPEditPageControllernew.noteWrapper wrapNote = new TitanNDPEditPageControllernew.noteWrapper();
            TitanNDPEditPageControllernew.checkListWrapper wrapCheckList = new TitanNDPEditPageControllernew.checkListWrapper();
            TitanNDPEditPageControllernew.attachWrapper wrapAttachment = new TitanNDPEditPageControllernew.attachWrapper();
            TitanNDPEditPageControllernew.successorEmailWrapper succEmailWrap= new TitanNDPEditPageControllernew.successorEmailWrapper();  
           editPage2.createAttachment();
           editPage2.viewattachment();
           editPage2.uploadAttachment();
           editPage2.cancelUpload();
           editPage2.viewTask();
            editPage2.createTask();
            editPage2.cancelTask();
            editPage2.editTask();
            editPage2.deleteTask();
           editPage2.saveIndividualTask();
            editPage2.viewNote();
           editPage2.createNote();
           editPage2.viewActivityApprovalHistorylist();
           editPage2.viewEmail();
        //   editPage2.send();
           editPage2.Successorlist();
           editPage2.activateStage();
           editPage2.approvalitems();
           editPage2.viewDynamicTable();
           editPage2.createCheckList();
           editPage2.editdynamictable();
         //  editPage2.savedynamictable();
           editPage2.sendEmail();
           editPage2.send();
           editPage2.homePage();
           editPage2.getIsCheckLists();
           editPage2.dummymodel();
           editPage2.canceldynamic();
           

    }
}