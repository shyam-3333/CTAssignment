/*
****  Created By          : Dheeraj Gangulli
****  Last Modified By    : Dheeraj Gangulli
****  Last Modified       : 11/03/2015
****  Description         : This test class is used for NPD_DetailViewController.
*/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  11/19/2019   T01		T01- 	Hardcoded URL change fix
*/
@isTest(seeAllData = false)
private Class NPD_PDViewController_NewTest{

    Private static testMethod void testing123()
    {
     
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
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
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
        
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;   

                ApexPages.currentPage().getParameters().put('proID', npdProject.Id);    

     

        
       
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
       
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = true; 
        activitynpd2.Revision_Active__c = false;
       
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.SerialNo__c = 'AR-01';   
        activitynpd2.Line_Item_Approval_Required__c = true;     
        activitynpd2.type__c = 'Activity';
        insert activitynpd2;
         
         

NPD_ProjectDetailViewController_New  np1 = new NPD_ProjectDetailViewController_New ();  
            np1.relatedListType ='Task';
           np1.rowNum =0;
           
           Task t1= new Task();
           t1.subject='hello';
           t1.whatid=activitynpd2.id;
           t1.tempuser__c = 'Roshi Rai';
           t1.Priority ='Low';
           t1.Status ='In Progress';
           insert t1;
           
           task t2 =[select id,subject from task where id =:t1.id];
           
           system.assertequals(t1.subject,t2.subject);
           
           
        NPD_ProjectDetailViewController_New.taskWrapper    tw1 =  new NPD_ProjectDetailViewController_New.taskWrapper();
           
           
           Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
           User u = new User(Alias = 'standt', Email='standarduser@tkvpcorp.com', 
            EmailEncodingKey='UTF-8', Firstname='Roshi', LastName='Rai', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@tkvpcorp.com');
            insert u;
           
           user u1=[select id,name from user where id=:u.id];
           
          // system.assertequals(u.name,u1.name);
           
           npd_master__c n1 = new npd_master__c();
           n1.name='Roshi Rai';
           n1.salesforceuser__c = u.id;
           insert n1;
           
           
           
           
           
           np1.prepareFieldListForActivity();
                   np1.saveIndividualTask();
          
           np1.createTask();
           
           np1.saveIndividualTask();
            
            
            
    
    }
    
     //Test method for stage methods   
     static testMethod void test1() {      
        
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
        insert npdProject;
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        oProjItem.Field_Set__c = '???Name!!!';
        insert oProjItem;
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
                
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;                
        
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
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id; 
        activitynpd.Revision_Active__c = false;
        activitynpd.NPD_Stage__c = oStage2.Id;  
        activitynpd.Optional_Activity_Sub_Activity__c =  ':##SHOWN';  
        activitynpd.SerialNo__c = 'AR-01';  
        //activitynpd.NPD_Activity__c = 
        //activitynpd.SFActivityid__c = UserInfo.getUserId();
        insert activitynpd;
                
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;
        activitynpd1.Revision_Active__c = false;
        activitynpd1.NPD_Stage__c = oStage2.Id;                  
        activitynpd1.SerialNo__c = 'AR-01';
        insert activitynpd1 ;        
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2.Type__c = 'Sub-Activity';
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = false; 
        activitynpd2.Revision_Active__c = false;
        activitynpd2.NPD_Stage__c = oStage2.Id;
        activitynpd2.NPD_Activity__c =  activitynpd.Id; 
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.SerialNo__c = 'AR-01';          
        insert activitynpd2;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = oStage2.Id;
        insert at; 
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = oStage2.Id;
        insert nt;
        
        task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id;  
        tk.tempuser__c = 'Test Master';      
        insert tk;
        
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.Id); 
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();        
        
        Test.StartTest();
         
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
        NPD_Project_Name__c   np1= new NPD_Project_Name__c();
        np1.name='testing sriramGuru';
         
        np1.ImageUpload__c = sfdcURL+'/img/seasonLogos/2016_summer_2.png';
        insert np1;
        
       
        
        
      
        
        np.prepareMapForStageAndActivities();
        np.storeProjectId();
        np.getrecord();
        
        np.tempstageid = oStage1.Id;
        np.processActiveDeactivestage();
        
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.processActiveDeactiveForSubstage();        
        
        
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.isRecHidden = false;
        np.showHideSubStage();               
        
        
        np.EditRecord();
        np.editStage();
        np.callRollupLeadTime();        
        np.childId = oStage1.Id;
        Test.StopTest();
        np.EditRecord();        
        np.editStage();
                
        np.createTask();
        
        np.createNote();
        np.getIsCheckLists();
        np.getIsNotes();
        np.getIsAttachment();
        np.createAttachment();        
             
        np.rowNum = 0;
        np.relatedListType = 'Note';
        np.saveIndividualTask();
                
        np.relatedListType = 'Task';
        np.editTask();
        try{
            np.deleteTask();
         np.cancelUpload();
        np.cancelTask();
        np.editTask();
        np.cancelUpload();
        np.cancelTask();
        
        }Catch(Exception e){}         
        np.relatedListType = 'Note';
        
        
        np.relatedListType = 'Attachment';
        np.cancelUpload();
        np.cancelTask();
        
        np.record = oProjItem;
        np.validateChecklist(oProjItem);
        
        NPD_ProjectDetailViewController_New.appHistoryWrap wrapList = new NPD_ProjectDetailViewController_New.appHistoryWrap();
            
    }
    
    //Test method for activity methods   
    
     static testMethod void test2() {     
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
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
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
        
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;                
        
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
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id; 
        activitynpd.Revision_Active__c = false;
        activitynpd.NPD_Stage__c = oStage2.Id;  
        activitynpd.Optional_Activity_Sub_Activity__c =  ':##SHOWN';
        activitynpd.Checklist_Columns__c = 'Activity Reference'; 
        activitynpd.SerialNo__c = 'AR-01';    
        activitynpd.Name__c = 'Case/Model No Allocation';
        //activitynpd.Actual_Start_Date__c = System.Today() - 1;
        insert activitynpd;
        
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;
        activitynpd1.Revision_Active__c = false;
        activitynpd1.NPD_Stage__c = oStage2.Id; 
        activitynpd1.Checklist_Columns__c = 'Activity Reference';
        activitynpd1.SerialNo__c = 'AR-01';    
        activitynpd1.Name__c = 'Case/Model No Allocation';  
        //activitynpd1.Actual_Start_Date__c = System.Today() - 1;            
        insert activitynpd1 ;        
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2.Type__c = 'Sub-Activity';
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = false; 
        activitynpd2.Revision_Active__c = false;
        activitynpd2.NPD_Stage__c = oStage2.Id;
        activitynpd2.NPD_Activity__c =  activitynpd.Id; 
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.Checklist_Columns__c = 'Activity Reference';   
        activitynpd2.SerialNo__c = 'AR-01'; 
        activitynpd2.Name__c = 'Case/Model No Allocation';  
        //activitynpd2.Actual_Start_Date__c = System.Today() - 1;     
        insert activitynpd2;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = activitynpd2.Id;
        insert at;
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = activitynpd2.Id;
        insert nt;
        
        Task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = activitynpd2.Id; 
              
        insert tk;
        
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.Id); 
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();        
        
        np.prepareMapForStageAndActivities();
        np.storeProjectId();
        np.getrecord();
        
        np.tempstageid = oStage1.Id;
        np.processActiveDeactivestage(); 
        
        np.parentID = oStage2.Id;
        np.childId =  activitynpd.Id;
        np.processActiveDeactiveForActivity();    
        
            
        np.parentID = activitynpd.Id;
        np.childId = activitynpd2.Id;
        np.processActiveDeactiveForSubActivity();
        
        
        np.parentID = activitynpd.Id;
        np.childId = activitynpd2.Id;        
        np.processActiveDeactiveSubActivity(); 
        
        Test.startTest();
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.isRecHidden = false;
        np.showHideSubStage();       
        
        
        np.parentID = oStage2.Id;
        np.childId =  activitynpd.Id;
        //np.showHideActivity();
        
        np.parentId = activitynpd.Id;
        np.childId = activitynpd2.Id;
        np.showHideSubActivity();
        
        np.editRecord();
        np.editActivity();
        
        
        np.queryToUpdateMapForActivity();
        np.queryToUpdateMapForSubActivity();
        np.createTask();
        np.createNote();
        np.createCheckList();
        np.getIsCheckLists();
        np.getIsNotes();
        np.getIsAttachment();
        np.createAttachment();

        np.upload();
        
        
        
        np.approvalMethod();
        np.lineitemapprovalhistory();
        np.closePopup1();
        np.redirectPopup1();
        np.getHomePage();
        np.processActiveDeactiveSubstage();
        np.getAccountList();        
        
        np.newProject(); 
        
        np.chkattachment(activitynpd2.Id);
        np.getSubmitCheckVisible();
        np.submitChecklist();
        
        //np.displayupdatedSubAtivity();
        //np.displayupdatedAtivity();       
        Test.stopTest();
        
            
    }
    
    //Test method for stage methods (UPLOAD METHOD)  
     static testMethod void test3() {     
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
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
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
                
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;                
        
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
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id; 
        activitynpd.Revision_Active__c = false;
        activitynpd.NPD_Stage__c = oStage2.Id;  
        activitynpd.Optional_Activity_Sub_Activity__c =  ':##SHOWN';  
        activitynpd.SerialNo__c = 'AR-01';  
        activitynpd.Line_Item_Approval_Required__c = true;  
        insert activitynpd;
                
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;
        activitynpd1.Revision_Active__c = false;
        activitynpd1.NPD_Stage__c = oStage2.Id;                  
        activitynpd1.SerialNo__c = 'AR-01';
        activitynpd1.Line_Item_Approval_Required__c = true; 
        insert activitynpd1 ;        
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2.Type__c = 'Sub-Activity';
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = false; 
        activitynpd2.Revision_Active__c = false;
        activitynpd2.NPD_Stage__c = oStage2.Id;
        activitynpd2.NPD_Activity__c =  activitynpd.Id; 
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.SerialNo__c = 'AR-01';   
        activitynpd2.Line_Item_Approval_Required__c = true;     
        insert activitynpd2;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpg';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = oStage1.Id;
        insert at; 
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = oStage2.Id;
        insert nt;
        
        task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id;        
        insert tk;
        
        Test.StartTest();
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.Id); 
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();        
        
        np.prepareMapForStageAndActivities();
        np.storeProjectId();
        np.getrecord();
        
        /*
        np.tempstageid = oStage1.Id;
        np.processActiveDeactivestage();
        
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.processActiveDeactiveForSubstage();        
        */
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.isRecHidden = false;
        np.showHideSubStage();               
        np.EditRecord();
        np.editStage();
        
        np.childId = oStage1.Id;
        np.EditRecord();
        np.editStage();
        
        np.createTask();
        np.createNote();
        np.getIsCheckLists();
        np.getIsNotes();
        np.getIsAttachment();
        np.createAttachment();
        np.attach1.Name = 'test.jpg';        
        
        np.childID = oStage1.Id;
        np.upload();
        np.lineitemapprovalhistory();
        
        try{
            np.approvalitems();
        }Catch(Exception e){}
        Test.StopTest();
            
    }
    
    //Test method for stage methods  FALSE CONDITION 
     static testMethod void test4() {     
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
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
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
                
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;                
        
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
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id; 
        activitynpd.Revision_Active__c = false;
        activitynpd.NPD_Stage__c = oStage2.Id;  
        activitynpd.Optional_Activity_Sub_Activity__c =  ':##SHOWN';  
        activitynpd.SerialNo__c = 'AR-01';  
        insert activitynpd;
                
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;
        activitynpd1.Revision_Active__c = false;
        activitynpd1.NPD_Stage__c = oStage2.Id;                  
        activitynpd1.SerialNo__c = 'AR-01';
        insert activitynpd1 ;        
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2.Type__c = 'Sub-Activity';
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = false; 
        activitynpd2.Revision_Active__c = false;
        activitynpd2.NPD_Stage__c = oStage2.Id;
        activitynpd2.NPD_Activity__c =  activitynpd.Id; 
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.SerialNo__c = 'AR-01';          
        insert activitynpd2;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = oStage2.Id;
        insert at; 
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = oStage2.Id;
        insert nt;
        
        task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id;  
        tk.tempuser__c = 'Test Master';      
        insert tk;
        
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.Id); 
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();        
        
        np.prepareMapForStageAndActivities();
        np.storeProjectId();
        np.getrecord();
        
        np.tempstageid = oStage1.Id;
        np.processActiveDeactivestage();
        
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.processActiveDeactiveForSubstage();        
        
        Test.StartTest();
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.isRecHidden = true;
        np.showHideSubStage();               
        np.EditRecord();
        np.editStage();
        
        np.childId = oStage1.Id;
        np.EditRecord();
        
        np.editStage();
        
        np.createTask();
        np.createNote();
        np.getIsCheckLists();
        np.getIsNotes();
        np.getIsAttachment();
        np.createAttachment();        
                
        np.rowNum = 0;
        np.relatedListType = 'Note';
        np.saveIndividualTask();
        
        Test.StopTest();
            
    }
    
    static testMethod void test5() {     
        
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
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
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
        
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;                
        
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
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id; 
        activitynpd.Revision_Active__c = false;
        activitynpd.NPD_Stage__c = oStage2.Id;  
        activitynpd.Optional_Activity_Sub_Activity__c =  ':##SHOWN';
        activitynpd.Checklist_Columns__c = 'Activity Reference'; 
        activitynpd.SerialNo__c = 'AR-01';    
        insert activitynpd;
        
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;
        activitynpd1.Revision_Active__c = false;
        activitynpd1.NPD_Stage__c = oStage2.Id; 
        activitynpd1.Checklist_Columns__c = 'Activity Reference';
        activitynpd1.SerialNo__c = 'AR-01';                  
        insert activitynpd1 ;        
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2.Type__c = 'Sub-Activity';
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = false; 
        activitynpd2.Revision_Active__c = false;
        activitynpd2.NPD_Stage__c = oStage2.Id;
        activitynpd2.NPD_Activity__c =  activitynpd.Id; 
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.Checklist_Columns__c = 'Activity Reference';   
        activitynpd2.SerialNo__c = 'AR-01';        
        insert activitynpd2;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = activitynpd2.Id;
        insert at;
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = activitynpd2.Id;
        insert nt;
        
        Task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = activitynpd2.Id; 
              
        insert tk;
        
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.Id); 
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();        
        
        np.prepareMapForStageAndActivities();
        np.storeProjectId();
        np.getrecord();
        
        np.tempstageid = oStage1.Id;
        np.processActiveDeactivestage(); 
        
        np.parentID = oStage2.Id;
        np.childId =  activitynpd.Id;
        np.processActiveDeactiveForActivity();    
        
        //Try    
        np.parentID = activitynpd.Id;
        np.childId = activitynpd2.Id;
        np.processActiveDeactiveForSubActivity();
        
        np.parentID = activitynpd.Id;
        np.childId = activitynpd2.Id;        
        np.processActiveDeactiveSubActivity(); 
        
        Test.StartTest();
        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.isRecHidden = false;
        np.showHideSubStage();       
        
        
        np.parentID = oStage2.Id;
        np.childId =  activitynpd.Id;
        //np.showHideActivity();
        
        np.parentId = activitynpd.Id;
        np.childId = activitynpd2.Id;
        np.showHideSubActivity();
        
        np.editRecord();
        np.editActivity();
        
        /*
        np.queryToUpdateMapForActivity();
        np.queryToUpdateMapForSubActivity();
        
        np.createTask();
        np.createNote();
        np.createCheckList();
        np.getIsCheckLists();
        np.getIsNotes();
        np.getIsAttachment();
        */
        np.createAttachment();
        
        np.upload();
        try{
          //  np.approvalitems();  
        }Catch(Exception e){}  
    
        Test.StopTest();
            
    }
    
    //Test method for activity methods   
     static testMethod void test6() {     
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.SalesforceUser__c = UserInfo.getUserID().subString(0,15);
        insert masterST;
        
        NPD_Master__c  masterPD = NPD_TestUtilityClass.getNPDMaster('projectid');
        masterPD.SalesforceUser__c = UserInfo.getUserID().subString(0,15);
        insert masterPD;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM.SalesforceUser__c = UserInfo.getUserID().subString(0,15);
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterSM.SalesforceUser__c = UserInfo.getUserID().subString(0,15);
        insert masterSM;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        npdProject.ImageUpload__c = '';
        insert npdProject;
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        oProjItem.Field_Set__c = '???Name!!!';
        insert oProjItem;
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
        
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname;                
        
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
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id; 
        activitynpd.Revision_Active__c = false;
        activitynpd.NPD_Stage__c = oStage2.Id;  
        activitynpd.Optional_Activity_Sub_Activity__c =  ':##SHOWN';
        activitynpd.Checklist_Columns__c = 'Activity Reference'; 
        activitynpd.SerialNo__c = 'AR-01';    
        activitynpd.Name__c = 'Case/Model No Allocation';
        activitynpd.NPD_User__c = masterCM.Id;
        insert activitynpd;
        
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;
        activitynpd1.Revision_Active__c = false;
        activitynpd1.NPD_Stage__c = oStage2.Id; 
        activitynpd1.Checklist_Columns__c = 'Activity Reference';
        activitynpd1.SerialNo__c = 'AR-01';    
        activitynpd1.Name__c = 'Case/Model No Allocation';   
        activitynpd1.NPD_User__c = masterCM.Id;           
        insert activitynpd1 ;        
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2.Type__c = 'Activity';
        activitynpd2.NPD_Project_Name__c = npdProject.Id;
        activitynpd2.Active__c = false; 
        activitynpd2.Revision_Active__c = false;
        activitynpd2.NPD_Stage__c = oStage2.Id;
        activitynpd2.NPD_Activity__c =  activitynpd.Id; 
        activitynpd2.Optional_Activity_Sub_Activity__c =  ':##SHOWN';   
        activitynpd2.Checklist_Columns__c = 'Activity Reference';   
        activitynpd2.SerialNo__c = 'AR-01'; 
        activitynpd2.Name__c = 'Case/Model No Allocation';   
        activitynpd2.NPD_User__c = masterCM.Id;
        activitynpd2.Sub_Brand1__c ='sonata123';
        activitynpd2.Market__c = 'deomestic';
        activitynpd2.Source__c ='IDS';
        activitynpd2.No_of_Designs__c =10;
        activitynpd2.Phase__c = 'design';
        
        
        insert activitynpd2;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = activitynpd2.Id;
        insert at;
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = activitynpd2.Id;
        insert nt;
        
        Task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = activitynpd2.Id; 
              
        insert tk;
        
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.Id); 
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();        
        
        np.prepareMapForStageAndActivities();
        np.storeProjectId();
        np.getrecord();
        
        np.tempstageid = oStage1.Id;
        np.processActiveDeactivestage(); 
        
        np.parentID = oStage2.Id;
        np.childId =  activitynpd.Id;
        np.processActiveDeactiveForActivity();    
        
        Test.StartTest();   
        np.parentID = activitynpd.Id;
        np.childId = activitynpd2.Id;
        np.processActiveDeactiveForSubActivity();
        
        np.parentID = activitynpd.Id;
        np.childId = activitynpd2.Id;        
        np.processActiveDeactiveSubActivity(); 

        np.parentID = oStage1.Id;
        np.childId =  oStage2.Id;
        np.isRecHidden = false;
        np.showHideSubStage();       
        
        
        np.parentID = oStage2.Id;
        np.childId =  activitynpd.Id;
        //np.showHideActivity();
        
        np.parentId = activitynpd.Id;
        np.childId = activitynpd2.Id;
        np.showHideSubActivity();
        
        np.editRecord();
        np.editActivity();
        
        np.queryToUpdateMapForActivity();
        np.queryToUpdateMapForSubActivity();
        np.createTask();
        np.createNote();
        np.createCheckList();
        np.getIsCheckLists();
        np.getIsNotes();
        np.getIsAttachment();
        np.createAttachment();
        
        np.upload();
        
        np.approvalMethod();
        
        
        
        
        
        
        
        
        
        
        np.lineitemapprovalhistory();
        np.closePopup1();
        np.redirectPopup1();
        np.getHomePage();
        np.processActiveDeactiveSubstage();
        np.getAccountList();        
        
        np.newProject(); 
        np.chkattachment(activitynpd2.Id);
        np.getSubmitCheckVisible();
        np.submitChecklist();
        
        np.displayupdatedSubAtivity();
        np.displayupdatedAtivity();       
        
        
        
        
        
      //  nac1.Marketing_brief_concept_reference_number__c = 'MBR-001';
        
        
     //   np.childId =  oStage2.Id;
        
     //   np.autoPopulate();
        
        
        
        Test.StopTest();
            
    }
    
    
    
}