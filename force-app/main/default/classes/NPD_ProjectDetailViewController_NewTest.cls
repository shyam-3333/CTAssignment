/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  11/19/2019   T01		T01- 	Hardcoded URL change fix
*/
@isTest
private Class NPD_ProjectDetailViewController_NewTest{
     static testMethod void testNPD_ProjectDetailViewController_New1() {     
        //string currentactivityid='testcover';
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper();     
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        insert masterSM;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        insert npdProject;
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        oProjItem.Field_Set__c = 'No_of_Designs__c';
        insert oProjItem;
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id;        
        insert activitynpd ;
        
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;             
        insert activitynpd1 ;
        
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname ;       
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.id);     
        
     
        
        NPD_Stage__c  npdStage = new NPD_Stage__c ();      
        npdStage.NPD_Project_Name__c = npdProject.Id;      
        npdStage.Name__c        =    'Marketing Brief/Concept';
        npdStage.Type__c = 'Stage';      
        npdStage.Marketing_brief_concept_reference_number__c    =    'MAR900';
        npdStage.Sub_Brand1__c                                  =    'Son';
        npdStage.Market__c                                      =    'ISD';
        npdStage.Source__c                                      =    'Dom';
        insert npdStage; 
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.NPD_Project_Name__c = npdProject.Id;              
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Active__c = true;
        oStage1.Type__c = 'stage';
        oStage1.Planned_Start_Date__c= system.today();
        oStage1.Planned_lead_time__c= 4;
        oStage1.Position__c= 1;
        oStage1.PredecessorSerialNo__c= null;
        oStage1.SerialNo__c        =    'AR-01';
        oStage1.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage1;
        
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.brand1__c='Titan';
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
        oStage2.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage2;
        
        NPD_Activity__c oActivity =  new NPD_Activity__c();
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
        oActivity.Active__c = false;
        oActivity.Type__c = 'Activity';
        oActivity.PredecessorSerialNo__c= '';
        // oActivity.NPD_Project_Name__c =projName.id ;
        insert oActivity;        
        
        test.startTest();
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();
        
       // np.currentactivityid='testcover';
        np.ParentId = oStage1.Id;
        np.ChildId = oStage2.Id;
        np.prepareMapForStageAndActivities();
        
        np.ParentId = oActivity.Id;
        np.ChildId = oStage2.Id;
        np.processActiveDeactiveForSubActivity();
        
        
        

        //np.taskWrapper.Subject = 'ghcghchgc'; 
        task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id;        
        insert tk;
        
        np.saveIndividualTask();
        np.childId = oStage2.Id;
        np.prepareFieldListForStage();            
        np.editStage();
        
        np.childId = oStage2.Id;  
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = np.childId;
        insert at;  
        np.getIsAttachment();
        np.createAttachment(); 
        ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c'); 
        ApexPages.currentPage().getParameters().put('relatedListType', 'Attachment');
        
        at.Body =null;
        upsert at;
        
        //np.relatedListType = 'NPD_Checklist__c';
        //np.rowNum = 0;
        np.saveIndividualTask(); 
        np.upload(); 
        np.cancelUpload();      

        
        np.childId=oStage2.id;
        np.parentID=oStage1.id;
        list<npd_stage__c> npdStg01= new list<npd_stage__c>{oStage2};
        np.subStageMap.put(oStage1.Id,npdStg01);
        
        np.isRecHidden= true;
        np.showHideSubStage();  
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
        System.currentPageReference().getParameters().put('pageRef',sfdcURL+'/003/e?retURL=%2F003%');
        np.childId=oStage2.id;
        np.parentID=oStage1.id;
        
        
        np.ParentId = activitynpd.Id;
        np.ChildId = activitynpd1.Id;
        
        list<npd_activity__c> npdact1= new list<npd_activity__c>{activitynpd1};
        np.subActivityMap.put(activitynpd.Id,npdact1);
        np.showHideSubStage(); 
        
        
        np.processActiveDeactiveForSubActivity();
        
        
        
        np.ParentId = activitynpd.Id;
       np.ChildId = activitynpd1.Id;
        
        list<npd_activity__c> npdact11= new list<npd_activity__c>{activitynpd1};
        np.subActivityMap.put(activitynpd.Id,npdact11);
        
        
        np.processActiveDeactiveSubActivity();
        
        
       np.childid = oStage2.id;
        np.parentid = oStage1.id;
        
        list<npd_stage__c> npdstg1 =  new list<npd_stage__c>{oStage2};
        
        np.subStageMap.put(np.parentid,npdstg1);
        
        np.processActiveDeactiveForSubstage();
        
        
        
        
        
         np.ParentId = oStage1.Id;
       np.ChildId = activitynpd1.Id;
        
        list<npd_activity__c> npdact12= new list<npd_activity__c>{activitynpd1};
        np.ActivityMap.put(oStage1.Id,npdact12);
        
        np.processActiveDeactiveForActivity();
        
        
        
           
            PageReference testPage = Page.NPD_DetailView_Page;
               Test.setCurrentPage(testPage);
              // Test.StartTest();
            np.ParentId = oStage1.Id;
            np.ChildId = activitynpd1.Id;
            list<npd_activity__c> npdact13= new list<npd_activity__c>{activitynpd1};
            np.activityMap.put(oStage1.Id,npdact12);
            np.isRecHidden= true;
            //np.showHideActivity();
           // Test.StopTest();
            
            
            
            //PageReference testPage = Page.NPD_DetailView_Page;
            //Test.setCurrentPage(testPage);
            //Test.StartTest();
            np.ParentId = activitynpd.Id;
            np.ChildId = activitynpd1.Id;
            list<npd_activity__c> npdact14= new list<npd_activity__c>{activitynpd1};
            np.activityMap.put(activitynpd.Id,npdact14);
            np.showHideSubActivity();
            //Test.StopTest();
            
            
            
            
            np.childId=oStage2.id;
            np.parentID=oStage1.id;
            list<npd_stage__c> npdStg02= new list<npd_stage__c>{oStage2};
            np.subStageMap.put(oStage1.Id,npdStg02);
            np.isRecHidden= true;
            np.optSubStageNames.add(oStage2.name__c);
            np.showHideSubStage();
            
            np.processActiveDeactiveSubstage();
            test.stopTest();
            
    }
    
   static testMethod void testNPD_ProjectDetailViewController_New2() {        
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper(); 
        PageReference pageRef = Page.NPD_DetailView_Page;
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
        
        ApexPages.currentPage().getParameters().put('proID', projName.id);
        
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
        oStage2.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage2;
        
        NPD_Activity__c oActivity =  new NPD_Activity__c();
        oActivity.Name__c = 'Concept Design - IDS';
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
        oActivity.Active__c = false;
        oActivity.Type__c = 'Activity';
        oActivity.PredecessorSerialNo__c= '';
        // oActivity.NPD_Project_Name__c =projName.id ;
        insert oActivity; 
         
        NPD_Activity__c oActivity1 =  new NPD_Activity__c();
        oActivity1.id=oActivity.id;
        oActivity1.Name__c = 'Concept Design - IDS';
        oActivity1.Type__c = 'Activity';
        update oActivity1;    
        
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); 
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = projName.Id;
        activitynpd1.Active__c = true;
        activitynpd1.NPD_Stage__c = oStage2.Id;  
        activitynpd1.NPD_Activity__c  = oActivity.Id;                 
        insert activitynpd1 ;
        
        NPD_Activity__c  activitynpd2 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd2 .Type__c = 'Sub-Activity';
        activitynpd2 .NPD_Project_Name__c = projName.Id;
        activitynpd2 .Active__c = true;           
        insert activitynpd2 ;
        
        test.startTest();
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();          
        np.prepareMapForStageAndActivities();
        np.parentID= oStage1.Id;
        np.ChildId = oStage2.Id;  
        //np.prepareFieldListForActivity(); 
        np.parentID= activitynpd1.Id;
        np.childId =  activitynpd2.Id;
        //np.editActivity();   
        
        
        
        
        
        
        np.isRecHidden = true;
        np.showHideSubActivity();
        
        
        np.isRecHidden = false;
        np.showHideSubActivity();
        
        
        np.parentID= oStage1.Id;
        np.ChildId = oStage2.Id;  
        np.showHideSubStage();  
        
    
    
    npd_stage__c npdsubstage =[select Actual_Start_Date__c,brand1__c,Type__c,Marketing_brief_concept_reference_number__c,Market__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,No_of_Designs__c from npd_stage__c where id=:oStage2.id];
    
        np.subStageMap.put(oStage2.id, new list<npd_stage__c>{npdsubstage});
        test.stopTest();
                          
  }
       
 static testMethod void testforActivity3(){  
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper();    
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Buy','CBE Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        insert masterSM;
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        insert npdProject;
        system.debug('=====npdProject>>>>>'+npdProject);                           
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.id);
        
        NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        insert oCollection;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.NPD_Project_Name__c          =    npdProject.Id;
        oStage1.No_of_Designs__c = 2;
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
        oStage2.NPD_Project_Name__c = npdProject.Id;
        insert oStage2;
        
        NPD_Activity__c oActivity =  new NPD_Activity__c();
        oActivity.Name__c = 'Concept Design - IDS';
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
        oActivity.Type__c = 'Activity';
        oActivity.PredecessorSerialNo__c= '';
        oActivity.NPD_Project_Name__c =npdProject.id ;
        insert oActivity;
        // NPD checklist        
        
        NPD_Activity__c oActivity1 = new NPD_Activity__c ()  ;
        oActivity1 .Name__c = 'Briefing to Designers';
        oActivity1 .PredecessorSerialNo__c= null;
        oActivity1 .Actual_Start_Date__c = system.today();
        oActivity1 .Planned_Lead_Time__c = 10;
        oActivity1 .Status__c = 'In Progress';
        oActivity1 .No_of_Designs__c = 2;
        oActivity1 .Approval_Status__c = 'None';
        oActivity1 .Market__c = 'Domestic';       
        oActivity1 .Approval_Required__c = true;
        oActivity1 .NPD_Activity__c= oActivity.Id;
        oActivity1 .NPD_Project_Items__c = oProjItem.Id;
        oActivity1 .Position__c = 1;
        oActivity1 .SerialNo__c = 'AR-0101001001';
        oActivity1 .Active__c = true;
        oActivity1 .Type__c = 'Sub-Activity';
        oActivity1.NPD_Project_Name__c = npdProject.Id;
        
        insert oActivity1;                                   
        Id ChildId1;
        
        test.startTest();
        NPD_ProjectDetailViewController_New np = new NPD_ProjectDetailViewController_New();
        np.ParentId = oActivity1.NPD_Stage__c;
        np.childId = oActivity1.Id; 
        ChildId1 = np.childId;
        String objType = 'NPD_Stage__c';
        //ApexPages.currentPage().getParameters().put('objType ', 'NPD_Stage__c');    
        
        np.processActiveDeactiveForActivity(); 
        np.childId = oActivity1.Id;
        
        
        np.processActiveDeactiveSubActivity();
        np.childId = oActivity1.Id;
        
        
        id tempstageid;
        np.processActiveDeactivestage();
        np.tempstageid = oStage1.id;
        
        id parentid;
       
        np.childid = oStage2.id;
        np.parentid = oStage1.id;
          
        
        
        
        
        
        
        np.EditRecord();
        task tkActivity = new Task();
        tkActivity .Subject = 'XXtest1';
        tkActivity .WhatId = np.childId;
        tkActivity.tempuser__c = masterCM.Id;
        //tk.What.Type = 'NPD_Stage__c';
        insert tkActivity ;
        
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = np.childId;
        insert at;
        
        Note ntActivity = new Note();
        ntActivity .title = 'XX1';
        ntActivity .parentid = np.childId;
        insert ntActivity ;
        
        ApexPages.currentPage().getParameters().put('relatedListType', 'Task');
        ApexPages.currentPage().getParameters().put('relatedListType', 'Note');  
        ApexPages.currentPage().getParameters().put('relatedListType', 'Attachment');  
           
        np.prepareFieldListForActivity(); 
        np.event = '';
        np.childId = oActivity.Id;
       // np.editActivity();               
        ApexPages.currentPage().getParameters().put('relatedListType', 'Task');  
        np.getIsAttachment();
        np.createAttachment(); 
        np.relatedListType = 'Note'; 
        //ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c');
        np.saveIndividualTask(); 
        np.relatedListType = 'Task';
        np.upload(); 
        np.cancelUpload();
        
        np.relatedListType = 'NPD_Checklist__c';
        np.saveIndividualTask(); 
        

        delete tkActivity;
        
        
        String ob1 = '???No_of_Designs__c!!!';
        np.prepareWrapper(ob1);         
        
        
       test.stopTest(); 
        
        
       }
       
      
       
      static testMethod Void prepareFieldListForStageMethod(){
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper(); 
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
        
         
        NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        insert oCollection;
        
        //Insert Project Name 
        NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
        projName.NPD_Collections__c = oCollection.Id;
        insert projName; 
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.Marketing_Brief_Stage__c= projName.Id;
        insert npdprojectname ;
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        oProjItem.Field_Set__c = 'No_of_Designs__c';
        insert oProjItem;
       
        ApexPages.currentPage().getParameters().put('proID', projName.id);                  
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.NPD_Project_Items__c= oProjItem.Id;
        oStage1.No_of_Designs__c = 2;
        oStage1.ImageUpload__c = 'xxxx';
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
        
        String objType = 'NPD_Stage__c';
        
        NPD_Activity__c oActivity =  new NPD_Activity__c ();
        oActivity.Name__c = 'Briefing to IDS';
        oActivity.Type__c = 'Activity';
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
        oActivity.Approval_Status__c = 'Pending';
        oActivity.Line_Item_Approval_Required__c = true;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        //oActivity.Approval_Status__c = 'Approved';
        oActivity.NPD_Project_Name__c = projName.id;
        //oActivity.Attachment_Required__c= true;
        insert oActivity;
        
        NPD_Activity__c oActivity1 = new NPD_Activity__c ()  ;
        oActivity1 .Name__c = 'Case/Model No Allocation';       
        oActivity1 .PredecessorSerialNo__c= null;
        oActivity1 .Actual_Start_Date__c = system.today();
        oActivity1 .Planned_Lead_Time__c = 10;
        oActivity1 .Status__c = 'In Progress';
        oActivity1 .No_of_Designs__c = 2;
        oActivity1 .Approval_Status__c = 'None';
        oActivity1 .Market__c = 'Domestic';       
        oActivity1 .Approval_Required__c = true;
        oActivity1 .NPD_Activity__c= oActivity.Id;
        oActivity1 .NPD_Project_Items__c = oProjItem.Id;
        oActivity1.NPD_Project_Name__c = projName.id;
        oActivity1 .Position__c = 1;
        oActivity1 .SerialNo__c = 'AR-0101001001';
        oActivity1 .Active__c = true;       
        oActivity1.NPD_Project_Name__c = projName.id;
        oActivity1 .Type__c = 'Sub-Activity';         
       // oActivity1.Line_Item_Approval_Required__c = true;       
        insert oActivity1;
        
        
        test.startTest();
        NPD_ProjectDetailViewController_New np = new NPD_ProjectDetailViewController_New(); 
        np.ChildId = oStage2.Id; 
        //np.createCheckList();
        NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist1.Approval_Status__c        =    'Dropped';
        ochecklist1.NPD_Activity_Chklist__c   =    oActivity1.Id;
        
        NPD_Project_Name__c projName1 = NPD_TestUtilityClass.getProjName(ochecklist1.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
        projName.NPD_Collections__c = oCollection.Id;
        insert projName1; 
        insert ochecklist1;
        
        test.stopTest();
       }
       
    static testMethod void WrapperClass(){       
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper();
    }
    
   static testMethod void newProjectClass(){
        string  imageurl;
        string imagepiclink;      
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper();
        
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
        
        NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        insert oCollection; 
        //Insert Project Name 
        NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id); 
        projName.NPD_Collections__c = oCollection.Id;
       	String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
        projName.ImageUpload__c= '<img src="'+sfdcURL+'/servlet/servlet.FileDownload?file=00Pf0000000LVKcEAO"></img>';  
        insert projName; 
        
        imageurl=projName.ImageUpload__c;
        integer x=imageurl.indexof('https');
        integer y=imageurl.indexof('"',x);
        
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        //oProjItem.Field_Set__c = 'No_of_Designs__c';
        insert oProjItem;
        
        // NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        // insert oCollection;             
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.Actual_Start_Date__c                           =    System.today();           
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'In Progress';
        oStage1.NPD_Project_Items__c                           =    oProjItem.Id;    
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c = 0;
        oStage1.Position__c        = 1;
        oStage1.SerialNo__c        =    'AR-0101';
        oStage1.Planned_Lead_Time__c = 10;
        oStage1.Planned_End_Date__c =     System.today().addYears(1);
        oStage1.Phase__c = 'Design';
        oStage1.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
        oStage1.No_of_Designs__c = 2;
        oStage1.NPD_Project_Name__c = projName.Id;
        oStage1.PrePredecessorSerialNo__c = '';
        oStage1.ImageUpload__c = 'dhgfcjvjv';
        insert oStage1;
        
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Sub-Stage';
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
        oStage2.PrePredecessorSerialNo__c = '';
        insert oStage2;                
        
        NPD_Stage__c  oStage3     =    new NPD_Stage__c();
        oStage3.Name__c        =    'Briefing';
        //oStage3.NPD_Stage__c  =    oStage2.Id;
        oStage2.Type__c =    'Sub-Stage';
        insert oStage3;  
        
      
          
        
        NPD_Activity__c oActivity =  new NPD_Activity__c ();
        oActivity.Name__c = 'Briefing to IDS';
        oActivity.Type__c = 'Activity';
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
        oActivity.Approval_Status__c = 'Pending';
        oActivity.Line_Item_Approval_Required__c = true;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        //oActivity.Approval_Status__c = 'Approved';
        oActivity.NPD_Project_Name__c = projName.id;
        //oActivity.Attachment_Required__c= true;
        insert oActivity;
        
        NPD_Activity__c oActivity1 = new NPD_Activity__c ()  ;
        oActivity1 .Name__c = 'Case/Model No Allocation';
        oActivity1.Type__c = 'Sub-Activity';
        oActivity1 .PredecessorSerialNo__c= null;
        oActivity1 .Actual_Start_Date__c = system.today();
        oActivity1 .Planned_Lead_Time__c = 10;
        oActivity1 .Status__c = 'In Progress';
        oActivity1 .No_of_Designs__c = 2;
        oActivity1 .Approval_Status__c = 'None';
        oActivity1 .Market__c = 'Domestic';       
        oActivity1 .Approval_Required__c = true;
        oActivity1 .NPD_Activity__c= oActivity.Id;
        oActivity1 .NPD_Project_Items__c = oProjItem.Id;
        oActivity1.NPD_Project_Name__c = projName.id;
        oActivity1 .Position__c = 1;
        oActivity1 .SerialNo__c = 'AR-0101001001';
        oActivity1 .Active__c = true;       
        oActivity1.NPD_Project_Name__c = projName.id;
        oActivity1 .Type__c = 'Sub-Activity'; 
        
        
       // oActivity1.Line_Item_Approval_Required__c = true;       
        insert oActivity1;
        
        // NPD checklist 
        NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist1.Approval_Status__c        =    'Dropped';
        ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
        insert ochecklist1;
        
        // NPD checklist 
        NPD_Checklist__c ochecklist2          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist2.Approval_Status__c        =    'Approved';
        ochecklist2.NPD_Activity_Chklist__c   =    oActivity1.Id;
        insert ochecklist2;
        
        NPD_Activity__c oActivity3=  new NPD_Activity__c ();
        oActivity3.Name__c = 'Briefing to OSD';
        oActivity3.Type__c = 'Activity';
        oActivity3.Actual_Start_Date__c = system.today();
        oActivity3.Planned_Lead_Time__c = 10;
        oActivity3.Status__c = 'In Progress';
        oActivity3.No_of_Designs__c = 2;
        oActivity3.Approval_Status__c = 'None';
        oActivity3.Market__c = 'Domestic';
        oActivity3.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity3.Approval_Required__c = true;
        oActivity3.NPD_Stage__c = oStage2.Id;
        oActivity3.NPD_Project_Items__c = oProjItem.Id;
        oActivity3.Line_Item_Approval_Required__c = true;
        //oActivity3.Position__c = 1;
        //oActivity3.SerialNo__c = 'AR-0101001';
        oActivity3.Active__c = true;
        oActivity3.NPD_Project_Name__c = projName.id;
        oActivity3.Approval_Status__c = 'Approved';
        //oActivity3.NPD_Project_Name__c = projName.id;
        oActivity3.WhenToBeAcive__c = 'ISD';
        // oActivity3.Checklist_Columns__c = 'Activity Reference';
        //oActivity3.Mandatory_Fields__c= 'Activity Reference';
        //oActivity3.Checklist_Columns__c = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        oActivity3.Columns_to_Copy__c = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        oActivity3.Auto_Generated__c = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        insert oActivity3;
        
        NPD_Activity__c   DummyActivity                = NPD_TestUtilityClass.getNPDActivity('Activity');
        //DummyActivity.NPD_Project_Items__c             = productDesignerTemplate.id;
        //DummyActivity.CopiedFrom__c                    = designNoTemplate.id;
        DummyActivity.NPD_Project_Name__c              = projName.id;
        DummyActivity.Approval_Status__c = 'Pending';
        DummyActivity.Line_Item_Approval_Required__c = true;
        DummyActivity.name__c                          = 'Dummy Activity';
        DummyActivity.Checklist_Columns__c             = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Columns_to_Copy__c               = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Auto_Generated__c                = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        insert DummyActivity;
        
        NPD_Checklist__c ochecklist3 =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist3.Approval_Status__c =    'Approved';
        ochecklist3.NPD_Activity_Chklist__c=    oActivity3.Id;
        insert ochecklist3;
        
        task tk = new Task();
        user uu1=[select id,name from user limit 1];
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id; 
        tk.ownerid = uu1.id;       
        insert tk;
                
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = ostage2.Id;
        insert at;
        
        //Error
        Attachment at1 = new Attachment ();
        at1.name = 'XXtest1.jpj';
        at1.Body = Blob.valueOf('ghfhjfjhggjh');
        at1.parentid = oStage1.id;
        insert at1;
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = ostage2.Id;
        
        insert nt;
        
        NPD_Checklist__History checkhis = new NPD_Checklist__History();
        checkhis .Field = 'Approval_Status__c';
        checkhis.parentId = ochecklist3.id;
        insert checkhis;
        
        ApexPages.currentPage().getParameters().put('proID', projName.id);
        test.startTest();
        NPD_ProjectDetailViewController_New np = new NPD_ProjectDetailViewController_New();                       
        
        np.prepareMapForStageAndActivities();
        np.newProject();           
        List<NPD_Stage__c> lstNPDStage = new List<NPD_Stage__c>();
        //lstNPDStage.add(oStage1);
        lstNPDStage.add(oStage2);
        np.childId = oStage2.Id;
        np.parentID= oStage1.Id;
        
        np.prepareMapForStageAndActivities();
        //np.subStageMap.put(oStage1.Id,lstNPDStage);   

        

     //   np.childid = oStage2.id;
     //   np.parentid = oStage1.id;
    //    np.processActiveDeactiveForSubstage();
        
        
        //np.approvalitems();
        np.cancelUpload();
        ApexPages.currentPage().getParameters().put('relatedListType', 'Task');
        ApexPages.currentPage().getParameters().put('relatedListType', 'Note');
        ApexPages.currentPage().getParameters().put('relatedListType', 'Attachment');
        ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c');
        np.prepareFieldListForStage();    
        np.relatedListType = 'Attachment';
        np.rowNum = 0;      
        np.deleteTask();
        
        //np.relatedListType = 'Note';
        //np.rowNum = 0;      
        //np.deleteTask();
        
        np.ChildId = oStage2.Id;
        np.EditRecord();
        np.prepareWrapper(np.ChildId);        
        np.prepareFieldListForStage();
        np.childId = oStage1.Id;
        np.prepareFieldListForStage();
        //np.editActivity();            
        np.editStage();
        np.createTask();
        ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c'); 
        //np.relatedListType='NPD_Checklist__c'; 
        
        np.rowNum = 0;
        np.relatedListType = 'NPD_Checklist__c';
        np.saveIndividualTask();
        np.createNote();
        
        //np.relatedListType = 'Task';
       
        //np.editTask();
        //np.relatedListType = 'Note';
        //np.editTask();
       
        for(Attachment att : [SELECT id,name,parentid,isprivate,Description, Createdbyid FROM Attachment where parentid=: ostage2.Id  ]) {
            wrapperinst2.ate = att ;
            np.attWrapperStageList.add(wrapperinst2);
        }
        np.rowNum = 0;
        np.relatedListType = 'Attachment';
        np.editTask();
       
       NPD_ProjectDetailViewController_New.taskWrapper tskwrp = new NPD_ProjectDetailViewController_New.taskWrapper();
       
       List<NPD_ProjectDetailViewController_New.taskWrapper > wrpLst = new List<NPD_ProjectDetailViewController_New.taskWrapper>();
       tskwrp.isEdit = false;
       
       task tk19 = new Task();
       tk19.Subject = 'XXtest1';
       tk19.WhatId = oStage2.Id;        
       insert tk19;
       
       tskwrp.tsk = tk19;
       wrpLst.add(tskwrp);
       np.taskWrapperStageList.addAll(wrpLst);
       np.rowNum = 0;
       np.relatedListType = 'Task';       
       np.cancelTask();
       
       NPD_ProjectDetailViewController_New.taskWrapper tskwrp1 = new NPD_ProjectDetailViewController_New.taskWrapper();
       
       List<NPD_ProjectDetailViewController_New.taskWrapper > wrpLst1 = new List<NPD_ProjectDetailViewController_New.taskWrapper>();
       tskwrp1.isEdit = false;
       
       
       
       np.taskWrapperStageList.add(tskwrp1);
       np.rowNum = 0;
       np.relatedListType = 'Note';   
           
        np.cancelTask();
        
        np.relatedListType = null;
        
        
        np.getIsCheckLists();
        String ob = 'No_of_Designs__c!!!';        
        np.prepareWrapper(ob );       
        np.prepareFieldsForTable(ob);            
        np.getIsNotes();
        np.childId = oActivity1.id;       
        np.editActivity();
        np.queryToUpdateMapForSubActivity();
        np.queryToUpdateMapForActivity();          
        np.getSubmitCheckVisible();
        np.strErrorMsg = 'Error Message';
        //np.imageURL = '/resource/1449139555000/TitanLogo';
        tk.Subject = 'dhgfhjfhjgjhgjgjh';
        upsert tk;       
        np.saveIndividualTask();
       // test.StartTest(); 
        np.displayupdatedAtivity();
       
        np.displayupdatedSubAtivity();                                   
        np.approvalMethod();
        np.approvalitems();
        np.submitChecklist();
        np.ChildId = oActivity1.Id;
        
        
   /*     
    User mike = new User();
    mike.Username= 'mike3456.white@company.com';
    mike.Email = 'mike3456.white@company.com';
    mike.Lastname = 'mike'; mike.Firstname = 'white';
    mike.Alias = 'mwhite';
    mike.CommunityNickname = 'mwhite01';
    mike.UserRole = [ select id from userrole where id ='00Ef0000000G3BF' ];
    mike.ProfileId = [ select id from profile where id = '00e300000018x77' ].id;
    mike.CurrencyIsoCode = 'USD';
    mike.TimeZoneSidKey = 'GMT';
    mike.LocaleSidKey = 'en_US';
    mike.EmailEncodingKey = 'ISO-8859-1'; mike.LanguageLocaleKey = 'en_US';
    insert mike;
    
    
    
    NPD_Master__c  nm1=new NPD_Master__c();
    nm1.name='testingtask';
    nm1.SalesforceUser__c=mike.id;
    nm1.UserID__c='testing@gmail.com';
    insert nm1; 
    
    Task T1 = new Task();
    T1.Type = 'Email';
    T1.Description = 'testing npd titan'; //string
    T1.OwnerId = mike.id; //user id
    T1.WhatId = nm1.id; //record id
    T1.tempuser__c=nm1.name;
     insert T1;

     list<task> tt=new list<task>();
     tt.add(t1);*/
        
         integer rowNum11;  
        NPD_ProjectDetailViewController_New npdvc= new NPD_ProjectDetailViewController_New();
        string relatedListType11='NPD_Checklist__c';
    
         NPD_Checklist__c ochecklist11          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            insert ochecklist11;
        
        /*NPD_Master__c master=new NPD_Master__c();
        nm1.name='roshi';*/
        
        sobject sobj =new NPD_Checklist__c();
        
        NPDChkboxDynamicApproval  ap= new NPDChkboxDynamicApproval ();
        //ap.ApprovalMethod(oActivity1.Id,'Submission');
        //NPDChkboxDynamicApproval.MultiApprover(ochecklist3.Id,'Submission');
        //NPDChkboxDynamicApproval.ApprovalDone(np.childId);
        np.submitChecklist(); 
       // np.createCheckList();
       // np.prepareFieldsForTable(oActivity3.Checklist_Columns__c);
        
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinstcheck= new NPD_ProjectDetailViewController_New.checkListWrapper();
        wrapperinstcheck.sobj = oActivity3;
        
        //public map <string,string>  autoStagemap = new map<string,string>();
        np.autoStageMap.put(oStage1.name__c,oStage1.Id);
        np.autostring = oStage1.name__c;
        np.autoActivitymap.put(oActivity1.name__c,oActivity1.Id);
        np.getRecord();
        np.autostring = oActivity1.name__c;
        np.getRecord();
        np.prepareFieldListForActivity(); 
        np.queryToUpdateMapForActivity(); 
        np.displayupdatedAtivity();        
        np.event = '';
        np.childId = oActivity3.Id;
        np.editActivity();  
        np.redirectPopup1();
        np.nolinehistory = 'xxtest'; 
        //np.nolinehistory = 'xxtest'; 
        delete tk;
        delete at1;
        delete nt;
        
        np.deleteTask();
        np.closePopup1();
        //np.rowNum11 = 0;
        //np.lineitemapprovalhistory();
        //np.showPopup1();
        np.createCheckList();
        np.saveIndividualTask();
        np.getHomePage();
        
        npd_master__c nmc1=new npd_master__c();
        nmc1.name='npdtitantesting';
        insert nmc1;
        
        string projectId;
        ApexPages.currentPage().getParameters().put('projectId','fe45rfdg4565');
        
        //np.storeProjectId();
        
        if(projectId== null)
        {
        projectId = 'fe45rfdg45650'; 
        }
        
        npd_master__c npdmaster1= new npd_master__c();
         npdmaster1.name='fe45rfdg4995';
         npdmaster1.type__c='projectid';
        insert npdmaster1;
        
        npd_master__c npdmaster = [select id,name,type__c from npd_master__c where type__c='projectid' and id=:npdmaster1.id limit 1];
            npdmaster.name=projectId;
            update npdmaster;
        
        npd_master__c getProjectId = [select id,name,type__c from npd_master__c where type__c='projectid' limit 1];
        projectId=getProjectId.name;
        
        system.assertequals(projectId,npdmaster.name);
        //np.storeProjectId();
        test.stopTest() ;           
       
       
       
       
    } 

    static testMethod void newProjectClass12345(){
        string  imageurl;
        string imagepiclink;      
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper();
        
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
        
        NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        insert oCollection; 
        //Insert Project Name 
        NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id); 
        projName.NPD_Collections__c = oCollection.Id;
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
        projName.ImageUpload__c= '<img src="'+sfdcURL+'/servlet/servlet.FileDownload?file=00Pf0000000LVKcEAO"></img>';  
        insert projName; 
        
        imageurl=projName.ImageUpload__c;
        integer x=imageurl.indexof('https');
        integer y=imageurl.indexof('"',x);
        
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        //oProjItem.Field_Set__c = 'No_of_Designs__c';
        insert oProjItem;
        
        // NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        // insert oCollection;             
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.Actual_Start_Date__c                           =    System.today();           
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'In Progress';
        oStage1.NPD_Project_Items__c                           =    oProjItem.Id;    
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c = 0;
        oStage1.Position__c        = 1;
        oStage1.SerialNo__c        =    'AR-0101';
        oStage1.Planned_Lead_Time__c = 10;
        oStage1.Planned_End_Date__c =     System.today().addYears(1);
        oStage1.Phase__c = 'Design';
        oStage1.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
        oStage1.No_of_Designs__c = 2;
        oStage1.NPD_Project_Name__c = projName.Id;
        oStage1.PrePredecessorSerialNo__c = '';
        oStage1.ImageUpload__c = 'dhgfcjvjv';
        insert oStage1;
        
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Sub-Stage';
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
        oStage2.PrePredecessorSerialNo__c = '';
        insert oStage2;                
        
        NPD_Stage__c  oStage3     =    new NPD_Stage__c();
        oStage3.Name__c        =    'Briefing';
        //oStage3.NPD_Stage__c  =    oStage2.Id;
        oStage2.Type__c =    'Sub-Stage';
        insert oStage3;  
        
      
          
        
        NPD_Activity__c oActivity =  new NPD_Activity__c ();
        oActivity.Name__c = 'Briefing to IDS';
        oActivity.Type__c = 'Activity';
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
        oActivity.Approval_Status__c = 'Pending';
        oActivity.Line_Item_Approval_Required__c = true;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        //oActivity.Approval_Status__c = 'Approved';
        oActivity.NPD_Project_Name__c = projName.id;
        //oActivity.Attachment_Required__c= true;
        insert oActivity;
        
        NPD_Activity__c oActivity1 = new NPD_Activity__c ()  ;
        oActivity1 .Name__c = 'Case/Model No Allocation';
        oActivity1.Type__c = 'Sub-Activity';
        oActivity1 .PredecessorSerialNo__c= null;
        oActivity1 .Actual_Start_Date__c = system.today();
        oActivity1 .Planned_Lead_Time__c = 10;
        oActivity1 .Status__c = 'In Progress';
        oActivity1 .No_of_Designs__c = 2;
        oActivity1 .Approval_Status__c = 'None';
        oActivity1 .Market__c = 'Domestic';       
        oActivity1 .Approval_Required__c = true;
        oActivity1 .NPD_Activity__c= oActivity.Id;
        oActivity1 .NPD_Project_Items__c = oProjItem.Id;
        oActivity1.NPD_Project_Name__c = projName.id;
        oActivity1 .Position__c = 1;
        oActivity1 .SerialNo__c = 'AR-0101001001';
        oActivity1 .Active__c = true;       
        oActivity1.NPD_Project_Name__c = projName.id;
        oActivity1 .Type__c = 'Sub-Activity'; 
        
        
       // oActivity1.Line_Item_Approval_Required__c = true;       
        insert oActivity1;
        
        // NPD checklist 
        NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist1.Approval_Status__c        =    'Dropped';
        ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
        insert ochecklist1;
        
        // NPD checklist 
        NPD_Checklist__c ochecklist2          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist2.Approval_Status__c        =    'Approved';
        ochecklist2.NPD_Activity_Chklist__c   =    oActivity1.Id;
        insert ochecklist2;
        
        NPD_Activity__c oActivity3=  new NPD_Activity__c ();
        oActivity3.Name__c = 'Briefing to OSD';
        oActivity3.Type__c = 'Activity';
        oActivity3.Actual_Start_Date__c = system.today();
        oActivity3.Planned_Lead_Time__c = 10;
        oActivity3.Status__c = 'In Progress';
        oActivity3.No_of_Designs__c = 2;
        oActivity3.Approval_Status__c = 'None';
        oActivity3.Market__c = 'Domestic';
        oActivity3.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity3.Approval_Required__c = true;
        oActivity3.NPD_Stage__c = oStage2.Id;
        oActivity3.NPD_Project_Items__c = oProjItem.Id;
        oActivity3.Line_Item_Approval_Required__c = true;
        //oActivity3.Position__c = 1;
        //oActivity3.SerialNo__c = 'AR-0101001';
        oActivity3.Active__c = true;
        oActivity3.NPD_Project_Name__c = projName.id;
        oActivity3.Approval_Status__c = 'Approved';
        //oActivity3.NPD_Project_Name__c = projName.id;
        oActivity3.WhenToBeAcive__c = 'ISD';
        // oActivity3.Checklist_Columns__c = 'Activity Reference';
        //oActivity3.Mandatory_Fields__c= 'Activity Reference';
        //oActivity3.Checklist_Columns__c = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        oActivity3.Columns_to_Copy__c = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        oActivity3.Auto_Generated__c = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        insert oActivity3;
        
        NPD_Activity__c   DummyActivity                = NPD_TestUtilityClass.getNPDActivity('Activity');
        //DummyActivity.NPD_Project_Items__c             = productDesignerTemplate.id;
        //DummyActivity.CopiedFrom__c                    = designNoTemplate.id;
        DummyActivity.NPD_Project_Name__c              = projName.id;
        DummyActivity.Approval_Status__c = 'Pending';
        DummyActivity.Line_Item_Approval_Required__c = true;
        DummyActivity.name__c                          = 'Dummy Activity';
        DummyActivity.Checklist_Columns__c             = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Columns_to_Copy__c               = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Auto_Generated__c                = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        insert DummyActivity;
        
        NPD_Checklist__c ochecklist3 =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        ochecklist3.Approval_Status__c =    'Approved';
        ochecklist3.NPD_Activity_Chklist__c=    oActivity3.Id;
        insert ochecklist3;
        
        task tk = new Task();
        user uu1=[select id,name from user limit 1];
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id; 
        tk.ownerid = uu1.id;       
        insert tk;
                
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = ostage2.Id;
        insert at;
        
        //Error
        Attachment at1 = new Attachment ();
        at1.name = 'XXtest1.jpj';
        at1.Body = Blob.valueOf('ghfhjfjhggjh');
        at1.parentid = oStage1.id;
        insert at1;
        
        Note nt = new Note();
        nt.title = 'XX1';
        nt.parentid = ostage2.Id;
        
        insert nt;
        
        NPD_Checklist__History checkhis = new NPD_Checklist__History();
        checkhis .Field = 'Approval_Status__c';
        checkhis.parentId = ochecklist3.id;
        insert checkhis;
        
        ApexPages.currentPage().getParameters().put('proID', projName.id);
        test.startTest();
        NPD_ProjectDetailViewController_New np = new NPD_ProjectDetailViewController_New();                       
        
        np.prepareMapForStageAndActivities();
        np.newProject();           
        List<NPD_Stage__c> lstNPDStage = new List<NPD_Stage__c>();
        //lstNPDStage.add(oStage1);
        lstNPDStage.add(oStage2);
        np.childId = oStage2.Id;
        np.parentID= oStage1.Id;
        
        np.prepareMapForStageAndActivities();
        //np.subStageMap.put(oStage1.Id,lstNPDStage);   

        

     //   np.childid = oStage2.id;
     //   np.parentid = oStage1.id;
    //    np.processActiveDeactiveForSubstage();
        
        
        //np.approvalitems();
        //np.cancelUpload();
        ApexPages.currentPage().getParameters().put('relatedListType', 'Task');
        ApexPages.currentPage().getParameters().put('relatedListType', 'Note');
        ApexPages.currentPage().getParameters().put('relatedListType', 'Attachment');
        ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c');
        np.prepareFieldListForStage();    
        np.relatedListType = 'Attachment';
        np.rowNum = 0;      
        //np.deleteTask();
        
        //np.relatedListType = 'Note';
        //np.rowNum = 0;      
        //np.deleteTask();
        
        np.ChildId = oStage2.Id;
        //np.EditRecord();
        np.prepareWrapper(np.ChildId);        
        np.prepareFieldListForStage();
        np.childId = oStage1.Id;
        np.prepareFieldListForStage();
        //np.editActivity();            
        //np.editStage();
        //np.createTask();
        ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c'); 
        //np.relatedListType='NPD_Checklist__c'; 
        
        np.rowNum = 0;
        np.relatedListType = 'NPD_Checklist__c';
        np.saveIndividualTask();
        //np.createNote();
        
        //np.relatedListType = 'Task';
       
        //np.editTask();
        //np.relatedListType = 'Note';
        //np.editTask();
       
        for(Attachment att : [SELECT id,name,parentid,isprivate,Description, Createdbyid FROM Attachment where parentid=: ostage2.Id  ]) {
            wrapperinst2.ate = att ;
            np.attWrapperStageList.add(wrapperinst2);
        }
        np.rowNum = 0;
        np.relatedListType = 'Attachment';
        //np.editTask();
       
       NPD_ProjectDetailViewController_New.taskWrapper tskwrp = new NPD_ProjectDetailViewController_New.taskWrapper();
       
       List<NPD_ProjectDetailViewController_New.taskWrapper > wrpLst = new List<NPD_ProjectDetailViewController_New.taskWrapper>();
       tskwrp.isEdit = false;
       
       task tk19 = new Task();
       tk19.Subject = 'XXtest1';
       tk19.WhatId = oStage2.Id;        
       insert tk19;
       
       tskwrp.tsk = tk19;
       wrpLst.add(tskwrp);
       np.taskWrapperStageList.addAll(wrpLst);
       np.rowNum = 0;
       np.relatedListType = 'Task';       
       //np.cancelTask();
       
       NPD_ProjectDetailViewController_New.taskWrapper tskwrp1 = new NPD_ProjectDetailViewController_New.taskWrapper();
       
       List<NPD_ProjectDetailViewController_New.taskWrapper > wrpLst1 = new List<NPD_ProjectDetailViewController_New.taskWrapper>();
       tskwrp1.isEdit = false;
       
       
       
       np.taskWrapperStageList.add(tskwrp1);
       np.rowNum = 0;
       np.relatedListType = 'Note';   
           
        //np.cancelTask();
        
        np.relatedListType = null;
        
        
        //np.getIsCheckLists();
        String ob = 'No_of_Designs__c!!!';        
        np.prepareWrapper(ob );       
        np.prepareFieldsForTable(ob);            
        np.getIsNotes();
        np.childId = oActivity1.id;       
        np.editActivity();
        np.queryToUpdateMapForSubActivity();
        np.queryToUpdateMapForActivity();          
        np.getSubmitCheckVisible();
        np.strErrorMsg = 'Error Message';
        //np.imageURL = '/resource/1449139555000/TitanLogo';
        tk.Subject = 'dhgfhjfhjgjhgjgjh';
        upsert tk;       
        np.saveIndividualTask();
       // test.StartTest(); 
        np.displayupdatedAtivity();
       
        np.displayupdatedSubAtivity();                                   
        np.approvalMethod();
        np.approvalitems();
        np.submitChecklist();
        np.ChildId = oActivity1.Id;
        
        
   /*     
    User mike = new User();
    mike.Username= 'mike3456.white@company.com';
    mike.Email = 'mike3456.white@company.com';
    mike.Lastname = 'mike'; mike.Firstname = 'white';
    mike.Alias = 'mwhite';
    mike.CommunityNickname = 'mwhite01';
    mike.UserRole = [ select id from userrole where id ='00Ef0000000G3BF' ];
    mike.ProfileId = [ select id from profile where id = '00e300000018x77' ].id;
    mike.CurrencyIsoCode = 'USD';
    mike.TimeZoneSidKey = 'GMT';
    mike.LocaleSidKey = 'en_US';
    mike.EmailEncodingKey = 'ISO-8859-1'; mike.LanguageLocaleKey = 'en_US';
    insert mike;
    
    
    
    NPD_Master__c  nm1=new NPD_Master__c();
    nm1.name='testingtask';
    nm1.SalesforceUser__c=mike.id;
    nm1.UserID__c='testing@gmail.com';
    insert nm1; 
    
    Task T1 = new Task();
    T1.Type = 'Email';
    T1.Description = 'testing npd titan'; //string
    T1.OwnerId = mike.id; //user id
    T1.WhatId = nm1.id; //record id
    T1.tempuser__c=nm1.name;
     insert T1;

     list<task> tt=new list<task>();
     tt.add(t1);*/
        
         integer rowNum11;  
        NPD_ProjectDetailViewController_New npdvc= new NPD_ProjectDetailViewController_New();
        string relatedListType11='NPD_Checklist__c';
    
         NPD_Checklist__c ochecklist11          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
            insert ochecklist11;
        
        /*NPD_Master__c master=new NPD_Master__c();
        nm1.name='roshi';*/
        
        sobject sobj =new NPD_Checklist__c();
        
        NPDChkboxDynamicApproval  ap= new NPDChkboxDynamicApproval ();
        //ap.ApprovalMethod(oActivity1.Id,'Submission');
        //NPDChkboxDynamicApproval.MultiApprover(ochecklist3.Id,'Submission');
        //NPDChkboxDynamicApproval.ApprovalDone(np.childId);
        np.submitChecklist(); 
       // np.createCheckList();
       // np.prepareFieldsForTable(oActivity3.Checklist_Columns__c);
        
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinstcheck= new NPD_ProjectDetailViewController_New.checkListWrapper();
        wrapperinstcheck.sobj = oActivity3;
        
        //public map <string,string>  autoStagemap = new map<string,string>();
        np.autoStageMap.put(oStage1.name__c,oStage1.Id);
        np.autostring = oStage1.name__c;
        np.autoActivitymap.put(oActivity1.name__c,oActivity1.Id);
        //np.getRecord();
        np.autostring = oActivity1.name__c;
        //np.getRecord();
        np.prepareFieldListForActivity(); 
        np.queryToUpdateMapForActivity(); 
        np.displayupdatedAtivity();        
        np.event = '';
        np.childId = oActivity3.Id;
        //np.editActivity();  
        //np.redirectPopup1();
        np.nolinehistory = 'xxtest'; 
        //np.nolinehistory = 'xxtest'; 
        delete tk;
        delete at1;
        delete nt;
        
        np.deleteTask();
        np.closePopup1();
        //np.rowNum11 = 0;
        //np.lineitemapprovalhistory();
        //np.showPopup1();
        np.createCheckList();
        np.saveIndividualTask();
        np.getHomePage();
        
        npd_master__c nmc1=new npd_master__c();
        nmc1.name='npdtitantesting';
        insert nmc1;
        
        string projectId;
        ApexPages.currentPage().getParameters().put('projectId','fe45rfdg4565');
        
        //np.storeProjectId();
        
        if(projectId== null)
        {
        projectId = 'fe45rfdg45650'; 
        }
        
        npd_master__c npdmaster1= new npd_master__c();
         npdmaster1.name='fe45rfdg4995';
         npdmaster1.type__c='projectid';
        insert npdmaster1;
        
        npd_master__c npdmaster = [select id,name,type__c from npd_master__c where type__c='projectid' and id=:npdmaster1.id limit 1];
            npdmaster.name=projectId;
            update npdmaster;
        
        npd_master__c getProjectId = [select id,name,type__c from npd_master__c where type__c='projectid' limit 1];
        projectId=getProjectId.name;
        
        system.assertequals(projectId,npdmaster.name);
        np.storeProjectId();
        test.stopTest() ;           
       
       NPD_ProjectDetailViewController_New npdvc1= new NPD_ProjectDetailViewController_New();
       //npdvc1.prepareMapForStageAndActivities();
       
       NPD_ProjectDetailViewController_New.checkListWrapper wrapList = new NPD_ProjectDetailViewController_New.checkListWrapper();
       wrapList.isEdit = false;
       wrapList.sobj = new NPD_Checklist__c();
       list<NPD_ProjectDetailViewController_New.checkListWrapper> chckLst;
       chckLst= new list<NPD_ProjectDetailViewController_New.checkListWrapper>();
       chckLst.add(wrapList);
       
      // npdvc1.prepareFieldListForStage();
       //npdvc1.dynamicSobjWrapperMap.put('NPD_Checklist__c',chckLst);
       //catch(Exception e){system.debug('test class exception '+e.getMessage());}
       npdvc1.rowNum = 0;
       npdvc1.CheckId1 = ochecklist3.Id;
       
       npdvc1.lineitemapprovalhistory();
       npdvc1.ShowPopup1();
       
       
    }  
    
    /*
    static TestMethod void saveIndividualTasktesting()
    {
    User mike = new User();
    mike.Username= 'mike.white@company.com';
    mike.Email = 'mike.white@company.com';
    mike.Lastname = 'mike'; mike.Firstname = 'white';
    mike.Alias = 'mwhite';
    mike.CommunityNickname = 'mwhite01';
    mike.UserRole = [ select id from userrole where id ='00Ee0000000LhpB' ];
    mike.Profile = [ select id from profile where id = '00ee0000000Hfng' ];
    mike.CurrencyIsoCode = 'USD';
    mike.TimeZoneSidKey = 'GMT';
    mike.LocaleSidKey = 'en_US';
    mike.EmailEncodingKey = 'ISO-8859-1'; mike.LanguageLocaleKey = 'en_US';
    insert mike;
    
    
    
    NPD_Master__c  nm1=new NPD_Master__c();
    nm1.name='testingtask';
    nm1.SalesforceUser__c=mike.id;
    nm1.UserID__c='testing@gmail.com';
    insert nm1; 
    
    Task T1 = new Task();
    T1.Type = 'Email';
    T1.Description = 'testing npd titan'; //string
    T1.OwnerId = mike.id; //user id
    T1.WhatId = nm1.id; //record id
    T1.tempuser__c=nm1.name;
     insert T1;

     list<task> tt=new list<task>();
     tt.add(t1);
     
     
     
    NPD_ProjectDetailViewController_New npdvc= new NPD_ProjectDetailViewController_New();
    string relatedListType11='NPD_Checklist__c';
    
     NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert ochecklist1;
    
    //npdvc.CheckId1 = ochecklist1.id;
    npdvc.CheckId1=string.valueOf(ochecklist1.id);

    npdvc.rowNum11 = 0;
    //npdc.dynamicrecord = '';
    npdvc.displayPopup1=false;
    
    npdvc.saveIndividualTask();
    npdvc.lineitemapprovalhistory();
    npdvc.redirectPopup1();
    npdvc.closePopup1();
    
    
    
    
    npdvc.showPopup1();
    
    
    NPD_Master__c n1=[select id,SalesforceUser__c,UserID__c,ownerid from NPD_Master__c where name=:t1.tempuser__c  limit 1];
    
    system.assertequals(1,tt.size());
    }

   */ 
   
    
     
   
 /*   private static testmethod void wrappercoverage()
    {
    
    NPD_ProjectDetailViewController_New npdN1= new NPD_ProjectDetailViewController_New();
    
    
    NPD_ProjectDetailViewController_New.appHistoryWrap apphis= new NPD_ProjectDetailViewController_New.appHistoryWrap();
    apphis.cdate=date.today();                //Date.valueOf('12/27/2013');
    apphis.username='Roshi Rai';
    apphis.action='Approved';

    }   */
    
    
    
    //Cloned by Dheeraj
    static testMethod void testNPD_ProjectDetailViewController_New1Clone() {     
        //string currentactivityid='testcover';
        NPD_ProjectDetailViewController_New.WrapperForFieldSet wrapperinst= new  NPD_ProjectDetailViewController_New.WrapperForFieldSet('No_of_Designs__c!!!',TRUE,FALSE);              
        NPD_ProjectDetailViewController_New.checkListWrapper wrapperinst1= new NPD_ProjectDetailViewController_New.checkListWrapper();
        NPD_ProjectDetailViewController_New.attachWrapper wrapperinst2 = new NPD_ProjectDetailViewController_New.attachWrapper();
        NPD_ProjectDetailViewController_New.noteWrapper wrapperInst3 = new NPD_ProjectDetailViewController_New.noteWrapper();
        NPD_ProjectDetailViewController_New.taskWrapper wrapperInst4 = new NPD_ProjectDetailViewController_New.taskWrapper();     
        
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        insert masterST;
        
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        insert masterSM;
        
        NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.id,'Component Route', masterST.Id, masterSM.id);      
        insert npdProject;
        
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        oProjItem.Field_Set__c = 'No_of_Designs__c';
        insert oProjItem;
        
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;           
        
        NPD_Activity__c  activitynpd = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd.Type__c = 'Activity';
        activitynpd.NPD_Project_Name__c = npdProject.Id;
        activitynpd.NPD_Project_Items__c = oProjItem.Id;        
        insert activitynpd ;
        
        NPD_Activity__c  activitynpd1 = new NPD_Activity__c(); //NPD_TestUtilityClass.getNPDActivity('Activity');
        activitynpd1.Type__c = 'Sub-Activity';
        activitynpd1.NPD_Project_Name__c = npdProject.Id;
        activitynpd1.Active__c = true;             
        insert activitynpd1 ;
        
        NPD_Project_Name__c npdprojectname = new NPD_Project_Name__c();
        npdprojectname.id = npdProject.Id;
        update npdprojectname ;       
        
        ApexPages.currentPage().getParameters().put('proID', npdProject.id);     
        
        //Inserting into Account to call accountList method
        Account a = new Account();
        a.name = 'Test Account';
        insert a;
        
        NPD_Stage__c  npdStage = new NPD_Stage__c ();      
        npdStage.NPD_Project_Name__c = npdProject.Id;      
        npdStage.Name__c        =    'Marketing Brief/Concept';
        npdStage.Type__c = 'Stage';      
        npdStage.Marketing_brief_concept_reference_number__c    =    'MAR900';
        npdStage.Sub_Brand1__c                                  =    'Son';
        npdStage.Market__c                                      =    'ISD';
        npdStage.Source__c                                      =    'Dom';
        insert npdStage; 
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        oStage1.NPD_Project_Name__c = npdProject.Id;              
        oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage1.Sub_Brand1__c                                  =    'Son';
        oStage1.Market__c                                      =    'ISD';
        oStage1.Source__c                                      =    'Dom';
        oStage1.Active__c = true;
        oStage1.Type__c = 'stage';
        oStage1.Planned_Start_Date__c= system.today();
        oStage1.Planned_lead_time__c= 4;
        oStage1.Position__c= 1;
        oStage1.PredecessorSerialNo__c= null;
        oStage1.SerialNo__c        =    'AR-01';
        oStage1.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage1;
        
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.brand1__c='Titan';
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
        oStage2.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage2;
        
        NPD_Activity__c oActivity =  new NPD_Activity__c();
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
        oActivity.Active__c = false;
        oActivity.Type__c = 'Activity';
        oActivity.PredecessorSerialNo__c= '';
        // oActivity.NPD_Project_Name__c =projName.id ;
        insert oActivity;        
        
        NPD_ProjectDetailViewController_New  np = new NPD_ProjectDetailViewController_New ();
       // np.currentactivityid='testcover';
        np.getAccountList();
        np.ParentId = oStage1.Id;
        np.ChildId = oStage2.Id;
        np.prepareMapForStageAndActivities();
        
        np.ParentId = oActivity.Id;
        np.ChildId = oStage2.Id;
        np.processActiveDeactiveForSubActivity();
        
        
        

        //np.taskWrapper.Subject = 'ghcghchgc'; 
        task tk = new Task();
        tk.Subject = 'XXtest1';
        tk.WhatId = oStage2.Id;        
        insert tk;
        
        np.saveIndividualTask();
        np.childId = oStage2.Id;
        np.prepareFieldListForStage();            
        np.editStage();
        
        np.childId = oStage2.Id;  
        Attachment at = new Attachment ();
        at.name = 'XXtest1.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = np.childId;
        insert at;  
        np.getIsAttachment();
        np.createAttachment(); 
        ApexPages.currentPage().getParameters().put('relatedListType', 'NPD_Checklist__c'); 
        ApexPages.currentPage().getParameters().put('relatedListType', 'Attachment');
        at.Body =null;
        upsert at;
        np.saveIndividualTask(); 
        np.upload(); 
        np.cancelUpload();  
          
        np.childId=oStage2.id;
        np.parentID=oStage1.id;
        list<npd_stage__c> npdStg01= new list<npd_stage__c>{oStage2};
        np.subStageMap.put(oStage1.Id,npdStg01);
        
        np.isRecHidden= true;
        np.showHideSubStage();  
        
        
        np.isRecHidden= false;
        np.showHideSubStage();  
        
        
        //Starts
        NPD_Stage__c oStage19                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage19.Type__c                      =    'Stage';
        oStage19.NPD_Project_Name__c = npdProject.Id;              
        oStage19.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage19.Sub_Brand1__c                                  =    'Son';
        oStage19.Market__c                                      =    'ISD';
        oStage19.Source__c                                      =    'Dom';
        oStage19.Active__c = true;
        oStage19.Type__c = 'stage';
        oStage19.Planned_Start_Date__c= system.today();
        oStage19.Planned_lead_time__c= 4;
        oStage19.Position__c= 1;
        oStage19.PredecessorSerialNo__c= null;
        oStage19.SerialNo__c        =    'AR-01';
        //oStage1.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage19;
        
        
        NPD_Stage__c oStage199                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage199.Type__c                      =    'Activity';
        oStage199.NPD_Project_Name__c = npdProject.Id;              
        oStage199.Marketing_brief_concept_reference_number__c    =    'MAR900';
        oStage199.Sub_Brand1__c                                  =    'Son';
        oStage199.Market__c                                      =    'ISD';
        oStage199.Source__c                                      =    'Dom';
        oStage199.Active__c = true;
        oStage199.Type__c = 'Activity';
        oStage199.Planned_Start_Date__c= system.today();
        oStage199.Planned_lead_time__c= 4;
        oStage199.Position__c= 1;
        oStage199.PredecessorSerialNo__c= null;
        oStage199.SerialNo__c        =    'AR-01';
        oStage199.brand1__c = 'Test brand';
        //oStage1.Optional_Sub_Stages__c = 'r1:##r2:##'; 
        insert oStage199;
        
        
        np.record = oActivity;
        np.editActivity();
        np.ValidateCheckList(oActivity);
        np.childId = oActivity.Id;
        //np.approvalItems();
        //np.childId=oStage2.id;
        np.childId='';
        np.parentID=oStage19.id;
        list<npd_stage__c> npdStg019= new list<npd_stage__c>{oStage2};
        np.subStageMap.put(oStage19.Id,npdStg019);
        
        np.isRecHidden= true;
        np.showHideSubStage();  
        
        
        np.isRecHidden= false;
        np.showHideSubStage();  
        
        //Ends
        
        
        
        
        
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
        System.currentPageReference().getParameters().put('pageRef',(sfdcURL+'/003/e?retURL=%2F003%'));
        np.childId=oStage2.id;
        np.parentID=oStage1.id;
        
        
        np.ParentId = activitynpd.Id;
        np.ChildId = activitynpd1.Id;
        
        list<npd_activity__c> npdact1= new list<npd_activity__c>{activitynpd1};
        np.subActivityMap.put(activitynpd.Id,npdact1);
        //np.showHideSubStage(); 
        
        
        np.processActiveDeactiveForSubActivity();
        
        
        
        np.ParentId = activitynpd.Id;
       np.ChildId = activitynpd1.Id;
        
        list<npd_activity__c> npdact11= new list<npd_activity__c>{activitynpd1};
        np.subActivityMap.put(activitynpd.Id,npdact11);
        
        
        np.processActiveDeactiveSubActivity();
        
        
       np.childid = oStage2.id;
        np.parentid = oStage1.id;
        
        list<npd_stage__c> npdstg1 =  new list<npd_stage__c>{oStage2};
        
        np.subStageMap.put(np.parentid,npdstg1);
        
        np.processActiveDeactiveForSubstage();
        
        
        
        
        
         np.ParentId = oStage1.Id;
       np.ChildId = activitynpd1.Id;
        
        list<npd_activity__c> npdact12= new list<npd_activity__c>{activitynpd1};
        np.ActivityMap.put(oStage1.Id,npdact12);
        
        np.processActiveDeactiveForActivity();
        
        
        
           
            PageReference testPage = Page.NPD_DetailView_Page;
               Test.setCurrentPage(testPage);
               Test.StartTest();
            np.ParentId = oStage1.Id;
            np.ChildId = activitynpd1.Id;
            list<npd_activity__c> npdact13= new list<npd_activity__c>{activitynpd1};
            np.activityMap.put(oStage1.Id,npdact12);
            np.isRecHidden= true;
            //np.showHideActivity();
            Test.StopTest();
            
            
            
            //PageReference testPage = Page.NPD_DetailView_Page;
            //Test.setCurrentPage(testPage);
            //Test.StartTest();
            np.ParentId = activitynpd.Id;
            np.ChildId = activitynpd1.Id;
            list<npd_activity__c> npdact14= new list<npd_activity__c>{activitynpd1};
            np.activityMap.put(activitynpd.Id,npdact14);
            np.showHideSubActivity();
            //Test.StopTest();
            
            
            np.childId=oStage2.id;
            np.parentID=oStage1.id;
            list<npd_stage__c> npdStg02= new list<npd_stage__c>{oStage2};
            np.subStageMap.put(oStage1.Id,npdStg02);
            np.isRecHidden= true;
            np.optSubStageNames.add(oStage2.name__c);
            //np.showHideSubStage();
            
            np.processActiveDeactiveSubstage();
            np.relatedListType = 'Task';
            //np.rowNum = 0;
            //np.editTask();
            
            //np.rowNum = 0;
           // np.editTask();
            np.saveIndividualTask();
            np.processActiveDeactiveSubstage();
            
            
            
            NPD_Activity__c oActivity18 =  new NPD_Activity__c();
            oActivity18.Name__c = 'Briefing to IDS';
            oActivity18.Actual_Start_Date__c = system.today();
            oActivity18.Planned_Lead_Time__c = 10;
            oActivity18.Status__c = 'In Progress';
            oActivity18.No_of_Designs__c = 2;
            oActivity18.Approval_Status__c = 'None';
            oActivity18.Market__c = 'Domestic';
            oActivity18.Marketing_Brief_Reference_No__c = 'Mar123';
            oActivity18.Approval_Required__c = true;
            oActivity18.NPD_Stage__c = oStage2.Id;
            oActivity18.NPD_Project_Items__c = oProjItem.Id;
            oActivity18.Position__c = 1;
            oActivity18.SerialNo__c = 'AR-0101001';
            oActivity18.Active__c = false;
            oActivity18.Type__c = 'Activity';
            oActivity18.PredecessorSerialNo__c= '';
            // oActivity.NPD_Project_Name__c =projName.id ;
            insert oActivity18;
            np.childId = oActivity18.Id;
            np.editRecord();        
            
            np.imageURL = null;
            np.currentactivityid = null;
            np.dynamicrecord = null;
            np.attchmentcount = null;
            np.attchmentcount = null;
            np.DisplayFieldsListMandatory = null;
            
    }
 
}