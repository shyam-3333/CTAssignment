/*********************************************************************
Class Name       : NPD_UtilityControllerTest
Type             : Test Class
Description      : This test class covers code coverage of NPD_UtilityController. 
Created By       : Keyur Modi
Created Date     : 1/12/2015
LastModifiedby   : Keyur Modi/Roshi Rai/Sudama Lokshman 
LastModifiedDate : 04/06/2017  
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/8/2019   T01     Test class issue fixing
*********************************************************************/
@isTest
private class NPD_UtilityControllerTest{
    
    static testMethod void unitTest() {
        Test.startTest(); 
        
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
        insert projName;
        
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
        oStage2.NPD_Collections__c                             = collection.Id;
        oStage2.brand1__c= 'Titan';
        insert oStage2;
        
        NPD_Activity__c oActivity1            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        // oActivity1.Name__c = 'Proto Dial Drawing Release and Receipt';
        oActivity1.Name__c = 'Watch Deposition';
        //<T01> <T01> Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity1.Actual_Start_Date__c = system.today();
oActivity1.Actual_End_Date__c=system.today().addDays(3);*/
        oActivity1.Planned_Lead_Time__c = 10;
        oActivity1.Status__c = 'Completed';
        oActivity1.NPD_Collections__c = collection.Id;
        oActivity1.No_of_Designs__c = 2;
        oActivity1.Approval_Status__c = 'Approved';
        oActivity1.Market__c = 'Domestic';
        oActivity1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity1.Approval_Required__c = true;
        oActivity1.NPD_Stage__c = oStage2.Id;
        oActivity1.NPD_Project_Items__c = oProjItem1.Id;
        oActivity1.Position__c = 1;
        oActivity1.SerialNo__c = 'AR-0101001';
        oActivity1.Active__c = true;
        oActivity1.NPD_Project_Name__c =projName.id;
        //oActivity1.NPD_Activity__c=oActivity.id;
        oActivity1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        system.debug('Activity Date '+oActivity1.Actual_Start_Date__c);
        insert oActivity1;
        
        
        //Insert NPD Activity
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity.Name__c = 'Proto Design Input';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity.Actual_Start_Date__c = system.today();
oActivity.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'Approved';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage2.Id;
        oActivity.NPD_Project_Items__c = oProjItem1.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c =projName.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity.NPD_Activity__c=oActivity1.id;
        insert oActivity;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity2            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity2.Name__c = 'Dial for Proto Mfg';
        
        /*oActivity2.Actual_Start_Date__c = system.today();
oActivity2.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity2.Planned_Lead_Time__c = 10;
        oActivity2.Status__c = 'In Progress';
        oActivity2.No_of_Designs__c = 2;
        oActivity2.Approval_Status__c = 'Approved';
        oActivity2.Market__c = 'Domestic';
        oActivity2.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity2.Approval_Required__c = true;
        oActivity2.NPD_Stage__c = oStage2.Id;
        oActivity2.NPD_Project_Items__c = oProjItem1.Id;
        oActivity2.Position__c = 1;
        oActivity2.SerialNo__c = 'AR-0101001';
        oActivity2.Active__c = true;
        oActivity2.NPD_Project_Name__c =projName.id;
        oActivity2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity2.NPD_Activity__c=oActivity1.id;
        insert oActivity2;
        
        List<id> lstId = new List<Id>();
        lstId.add(projName.id);
        List<NPD_Stage__c> stageListLeadTime = new List<NPD_Stage__c>();
        stageListLeadTime.add(oStage1);
        Set<Id> collectionId = new Set<Id>();
        collectionId.add(collection.id);
        List<NPD_Collections__c> collectionList = new List<NPD_Collections__c>();
        collectionList.add(collection);
        List<NPD_Activity__c> newListAct = new List<NPD_Activity__c> ();
        newListAct.add(oActivity);
        oActivity.Actual_End_Date__c=system.today().addDays(-1); // <T01> 
        update oActivity;
        Set<Id> setActivity = new Set<Id>();
        setActivity.add(oActivity1.Id);
        Map<id,NPD_Activity__c> oldMapAct = new Map<id,NPD_Activity__c>([SELECT id,Name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c,Status__c,No_of_Designs__c,Approval_Status__c,Active__c,Market__c,Marketing_Brief_Reference_No__c,Approval_Required__c,NPD_Stage__c,NPD_Project_Items__c,Position__c,NPD_Project_Name__c,SerialNo__c FROM NPD_Activity__c WHERE id=:oActivity.id]);
        
        List<NPD_Stage__c> newList = new List<NPD_Stage__c> ();
        newList.add(oStage2);
        /*List<NPD_Stage__c> newList1 = new List<NPD_Stage__c> ();
newList.add(oStage1);*/
        
        oStage2.Source__c ='IDS';
        update oStage2;
        set<id> stageId = new set<id>();
        stageId.add(oStage2.id);
        set<id> designerMGRId = new set<id>();
        designerMGRId.add(oStage2.design_manager_npd_master__c);
        Map<id,NPD_Stage__c> oldMap = new Map<id,NPD_Stage__c>([SELECT id,Actual_Start_Date__c,Type__c,Marketing_brief_concept_reference_number__c,Market__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,NPD_Project_Name__c,No_of_Designs__c,Source__c,Active__c  FROM NPD_Stage__c where id =:oStage2.id]); 
        Map<String,NPD_Stage__c> mapSerialNo_Stage=new   map<String,NPD_Stage__c>();
        mapSerialNo_Stage.put(oStage2.SerialNo__c,oStage2);
        NPD_UtilityController NPDUtility = new NPD_UtilityController(newList,oldMap);
        NPDUtility.afterUpdateHandler();
        NPDUtility.beforeUpdateStageHandler();
        
        NPD_UtilityController NPDUtility1 = new NPD_UtilityController(newListAct,oldMapAct);
        
        ApexPages.currentPage().getParameters().put('test','test');
        NPD_UtilityController NPDUtility2 = new NPD_UtilityController();
        //NPDUtility.afterUpdateStageHandlerForPlannedDateStage(lstId,oldMap);
        NPD_UtilityController.updatedesignmanager(stageId,designerMGRId);
        NPDUtility1.afterUpdateHandlerAct();
        NPDUtility.generateSerialNo(newList,'SerialNo__c','Actual_Start_Date__c,Type__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,NPD_Project_Name__c,No_of_Designs__c,Source__c','NPD_Stage__c','Stage__r','SubStage');
        NPD_UtilityController.fieldDefinition fld = new NPD_UtilityController.fieldDefinition('SUM','NPD_Stage__c','NPD_Stage__c');
        NPD_UtilityController.dateCalulationForStage(newList,mapSerialNo_Stage);
        NPD_UtilityController.ProtoDesignInputActivityCreation(newListAct,oldMapAct);
        NPD_UtilityController.collectionStatus(collectionId);
        NPD_UtilityController.updatecollectionvalue(collectionId,collectionList);
        //NPD_UtilityController.checkStageStatusAndActualDate(stageId,newList);
        NPD_UtilityController.plannedEndDate(String.ValueOf(oStage2.id));
        //NPD_UtilityController.dateCalulationForSubStage(newList1,oldMap, mapSerialNo_Stage);
        NPD_UtilityController.checkSubStageStatusactualdateupdate(stageId,newListAct,oldMapAct);   // added by sudama
        NPD_UtilityController.AutoupdateCaseMasterDevelopment(setActivity,newListAct);
        //    NPDUtility.SubStageLeadTimeWithComplexityInsert(stageListLeadTime);
        list<npd_activity__c> oldListAct = new list<npd_activity__c>();
        oldListAct.add(oActivity2);
        
        
        
        map<id,npd_activity__c > oldmapact1 = new map<id,npd_activity__c>();
        oldMapAct1.put(oActivity2.id,oActivity2);
        
        
        NPD_UtilityController.subActivityComletionEmail(newListAct,oldMapAct1  );    
        
        
        Test.StopTest();
    }
    
    static testMethod void unitTest1() {
        Test.startTest(); 
        
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        //Insert NPD Project Item
        NPD_Project_Items__c oProjItem      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        oProjItem1.Parent_Id__c              =    oProjItem.id;
        insert oProjItem1;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'In Progress';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        
        insert oStage1;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Stage';
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'In Progress';
        oStage2.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c                             =    0;
        oStage2.Position__c                                    =    2;
        oStage2.SerialNo__c                                    =    'AR-0101';
        oStage2.Planned_Lead_Time__c                           =    10;
        oStage2.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage2.Phase__c                                       =    'Design';
        oStage2.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage2.NPD_Project_Name__c                            =    projName.id;
        oStage2.No_of_Designs__c                               =    2;
        oStage2.Source__c                                      =    'OSD';
        oStage2.PredecessorSerialNo__c                         =    'AR-0101';
        oStage2.brand1__c= 'Titan';
        insert oStage2;
        
        NPD_Stage__c oStage3                                 =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage3.Actual_Start_Date__c                             =    System.today();
        oStage3.Actual_End_Date__c                           =    System.today();
        oStage3.Type__c                                        =    'Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar1231';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStae2.NPD_Stage__c                                   =    oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0102';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage2.PredecessorSerialNo__c                         =    'AR-0101';
        oStage3.Source__c                                      =    'OSD';
        insert oStage3;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity.Name__c = 'Proto Dial Drawing Release and Receipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity.Actual_Start_Date__c = system.today();
oActivity.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'Approved';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage1.Id;
        oActivity.NPD_Project_Items__c = oProjItem1.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c =projName.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        insert oActivity;
        
        List<NPD_Project_Items__c> projItemLst = new List<NPD_Project_Items__c>();
        projItemLst.add(oProjItem1); 
        List<id> lstId = new List<Id>();
        lstId.add(projName.id);
        List<NPD_Activity__c> newListAct = new List<NPD_Activity__c> ();
        newListAct.add(oActivity);
        oActivity.Actual_End_Date__c=system.today().addDays(-1);//<T01>
        update oActivity;
        Map<id,NPD_Activity__c> oldMapAct = new Map<id,NPD_Activity__c>([SELECT id,Name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c,Status__c,No_of_Designs__c,Approval_Status__c,Active__c,Market__c,Marketing_Brief_Reference_No__c,Approval_Required__c,NPD_Stage__c,NPD_Project_Items__c,Position__c,NPD_Project_Name__c,SerialNo__c FROM NPD_Activity__c WHERE id=:oActivity.id]);
        
        List<NPD_Stage__c> newList = new List<NPD_Stage__c> ();
        newList.add(oStage2);
        oStage2.Source__c ='IDS';
        update oStage2;
        Map<id,NPD_Stage__c> oldMap = new Map<id,NPD_Stage__c>([SELECT id,Actual_Start_Date__c,Type__c,Marketing_brief_concept_reference_number__c,Market__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,NPD_Project_Name__c,No_of_Designs__c,Source__c  FROM NPD_Stage__c where id =:oStage2.id]); 
        Map<String,NPD_Stage__c> mapSerialNo_Stage=new   map<String,NPD_Stage__c>();
        mapSerialNo_Stage.put(oStage2.SerialNo__c,oStage2);
        
        Map<String,NPD_Stage__c> mapSerialNo_Stage1=new   map<String,NPD_Stage__c>();
        mapSerialNo_Stage1.put(oStage3.SerialNo__c,oStage3);
        
        NPD_UtilityController NPDUtility = new NPD_UtilityController(newList,oldMap);
        NPD_UtilityController NPDUtility1 = new NPD_UtilityController(newListAct,oldMapAct);
        
        ApexPages.currentPage().getParameters().put('test','test');
        NPD_UtilityController NPDUtility2 = new NPD_UtilityController();
        
        NPDUtility.generateSerialNo(newListAct,'SerialNo__c','id,Name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c,Status__c,No_of_Designs__c,Approval_Status__c,Active__c,Market__c,NPD_Project_Items__c,Position__c,NPD_Project_Name__c,SerialNo__c','NPD_Activity__c','NPD_Activity__r','Activity');
        NPD_UtilityController.fieldDefinition fld = new NPD_UtilityController.fieldDefinition('SUM','NPD_Stage__c','NPD_Stage__c');
        NPD_UtilityController.dateCalulationForStage(newList,mapSerialNo_Stage1);
        list<NPD_UtilityController.fieldDefinition> fieldDefinitions =  new list<NPD_UtilityController.fieldDefinition> {
            new NPD_UtilityController.fieldDefinition('SUM', 'Lead_Time__c', 'Lead_Time__c') };
                NPD_UtilityController.rollUpLeadTime(fieldDefinitions,projItemLst, 'NPD_Project_Items__c', 'Parent_Id__c','NPD_Project_Items__c', 'and item_Type__c =\'Sub-stage\'');
        Test.StopTest();
    }
    static testMethod void unitTest3() {
        Test.startTest(); 
        
        
        
        //Insert Checklist
        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        insert checklist;
        //T01
        List<NPD_Master__c> listNPDMaster = new List<NPD_Master__c>();
        //Insert NPD MAster for strap type 
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.Name ='Test1';
        //insert masterST;
        listNPDMaster.add(masterST);
        
        
        //Insert NPD MAster for Case Material
        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
         masterCM.Name ='Test2';
        listNPDMaster.add(masterCM);
        //insert masterCM;
        
        //Insert NPD MAster for strap material 
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
         masterSM.Name ='Test3';
        listNPDMaster.add(masterSM);
        //insert masterSM;
        system.debug('listNPDMaster '+listNPDMaster);
        insert listNPDMaster;
        
        //Insert Project Name 
        NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(checklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);   
        insert projName;
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        //Insert NPD Project Item
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        insert oProjItem1;
        
        //Insert NPD Email
        NPD_Email__c oEmail = new NPD_Email__c();
        oEmail.name = 'Test';
        oEmail.Act_Name__c='Test';
        oEmail.Brand__c='Test';
        //oEmail.NPD_Activity__c = oActivity.id;
        oEmail.NPD_Project_Items__c = oProjItem1.id;
        //oEmail.ownerAssnmnt__c
        oEmail.Source__c='Test';
        oEmail.Type__c='Successor';
        insert oEmail;
        
        List<NPD_Stage__c> listNPDStage = new List<NPD_Stage__c>();
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    System.today();
        oStage1.Type__c                                        =    'Sub-Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'Not Started';  // by sudama In Progress to not started
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage1.R1_ASD__c                                      =    System.today();
        oStage1.R1_AED__c                                      =    System.today();
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        //insert oStage1;
        listNPDStage.add(oStage1);
        
        NPD_Stage__c oStageR1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStageR1.Actual_Start_Date__c                           =    System.today();
        oStageR1.Type__c                                        =    'Sub-Stage';
        oStageR1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStageR1.Market__c                                      =    'Domestic';
        oStageR1.Status__c                                      =    'Completed R1';
        oStageR1.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStageR1.R1_ASD__c                                      =    System.today();
        oStageR1.R1_AED__c                                      =    System.today();
        oStageR1.Planned_Start_Date__c                          =    System.today();
        oStageR1.Total_Lead_Time__c                             =    0;
        oStageR1.Position__c                                    =    1;
        oStageR1.SerialNo__c                                    =    'AR-0101';
        oStageR1.Planned_Lead_Time__c                           =    10;
        oStageR1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStageR1.Phase__c                                       =    'Design';
        oStageR1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStageR1.NPD_Project_Name__c                            =    projName.id;
        oStageR1.No_of_Designs__c                               =    2;
        oStageR1.Source__c                                      =    'OSD';
        //insert oStageR1;
        listNPDStage.add(oStageR1);
        
        NPD_Stage__c oStage12                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage12.Actual_Start_Date__c                           =    System.today();
        oStage12.Type__c                                        =    'Sub-Stage';
        oStage12.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage12.Market__c                                      =    'Domestic';
        oStage12.Status__c                                      =    'Completed';
        oStage12.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage12.NPD_Stage__c                                   =    oStage1.Id;
        oStage12.Planned_Start_Date__c                          =    System.today();
        oStage12.Total_Lead_Time__c                             =    0;
        oStage12.Position__c                                    =    1;
        oStage12.SerialNo__c                                    =    'AR-0101';
        oStage12.Planned_Lead_Time__c                           =    10;
        oStage12.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage12.Phase__c                                       =    'Design';
        oStage12.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage12.NPD_Project_Name__c                            =    projName.id;
        oStage12.No_of_Designs__c                               =    2;
        oStage12.Source__c                                      =    'OSD';
        //insert oStage12;
        listNPDStage.add(oStage12);
        
        NPD_Stage__c oStage13                =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage13.Actual_Start_Date__c                           =    System.today();
        oStage13.Type__c                                        =    'Sub-Stage';
        oStage13.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage13.Market__c                                      =    'Domestic';
        oStage13.Status__c                                      =    'In Progress';
        oStage13.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage13.NPD_Stage__c                                   =    oStage1.Id;
        oStage13.Planned_Start_Date__c                          =    System.today();
        oStage13.Total_Lead_Time__c                             =    0;
        oStage13.Position__c                                    =    1;
        oStage13.SerialNo__c                                    =    'AR-0101';
        oStage13.Planned_Lead_Time__c                           =    10;
        oStage13.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage13.Phase__c                                       =    'Design';
        oStage13.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage13.NPD_Project_Name__c                            =    projName.id;
        oStage13.No_of_Designs__c                               =    2;
        oStage13.Source__c                                      =    'OSD';
        //insert oStage13;
        listNPDStage.add(oStage13);
        
        //Insert NPD Stage    
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Stage';
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'In Progress';
        oStage2.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c                             =    0;
        oStage2.Position__c                                    =    2;
        oStage2.SerialNo__c                                    =    'AR-0101';
        oStage2.Planned_Lead_Time__c                           =    10;
        oStage2.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage2.Phase__c                                       =    'Design';
        oStage2.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage2.NPD_Project_Name__c                            =    projName.id;
        oStage2.No_of_Designs__c                               =    2;
        oStage2.Source__c                                      =    'OSD';
        oStage2.PredecessorSerialNo__c                         =    'AR-0101';
        oStage2.Planned_Start_Date__c                          =    System.Today();
        oStage2.brand1__c= 'Titan';
        //insert oStage2;
        listNPDStage.add(oStage2);
        
        
        
        //Insert NPD Activity
        List<NPD_Activity__c> listNPDActivity = new List<NPD_Activity__c>();
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'Proto Dial Drawing Release and Receipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity.Actual_Start_Date__c = system.today();
oActivity.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStageR1.Id;
        oActivity.NPD_Project_Items__c = oProjItem1.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c =projName.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity.NPD_Email__c =oEmail.id;
        //insert oActivity;
        listNPDActivity.add(oActivity);
        
        NPD_Activity__c oActivityR1            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivityR1.Name__c = 'Proto Dial Drawing Release and Receipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivityR1.Actual_Start_Date__c = system.today();
oActivityR1.Actual_End_Date__c=system.today().addDays(2);*/
        oActivityR1.Planned_Lead_Time__c = 10;
        oActivityR1.Status__c = 'Not Started';   // changed status Completed R1 to Not Started by sudama
        oActivityR1.No_of_Designs__c = 2;
        oActivityR1.Approval_Status__c = 'None';
        oActivityR1.Market__c = 'Domestic';
        oActivityR1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivityR1.Approval_Required__c = true;
        oActivityR1.NPD_Stage__c = oStage1.Id;
        oActivityR1.NPD_Project_Items__c = oProjItem1.Id;
        oActivityR1.Position__c = 1;
        oActivityR1.SerialNo__c = 'AR-0101001';
        oActivityR1.Active__c = true;
        oActivityR1.NPD_Project_Name__c =projName.id;
        oActivityR1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivityR1.NPD_Email__c =oEmail.id;
        //insert oActivityR1;
        listNPDActivity.add(oActivityR1);
        
        NPD_Activity__c oActivity1            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity1.Name__c = 'Proto Dial Drawing Release and Receipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity1.Actual_Start_Date__c = system.today();
oActivity1.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity1.Planned_Lead_Time__c = 10;
        oActivity1.Status__c = 'Completed';
        oActivity1.No_of_Designs__c = 2;
        oActivity1.Approval_Status__c = 'None';
        oActivity1.Market__c = 'Domestic';
        oActivity1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity1.Approval_Required__c = true;
        oActivity1.NPD_Stage__c = oStage12.Id;
        oActivity1.NPD_Project_Items__c = oProjItem1.Id;
        oActivity1.Position__c = 1;
        oActivity1.SerialNo__c = 'AR-0101001';
        oActivity1.Active__c = true;
        oActivity1.NPD_Project_Name__c =projName.id;
        oActivity1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity1.NPD_Email__c =oEmail.id;
        //insert oActivity1;
         listNPDActivity.add(oActivity1);
		insert listNPDActivity;        
        
        List<NPD_Email__c> listNPDEmail = new List<NPD_Email__c>();
        //Insert NPD Email
        NPD_Email__c oEmail1 = new NPD_Email__c();
        oEmail1.name = 'Test';
        oEmail1.Act_Name__c='Test';
        oEmail1.Brand__c='Test';
        oEmail1.NPD_Activity__c = oActivity.id;
        oEmail1.NPD_Project_Items__c = oProjItem1.id;
        //oEmail1.ownerAssnmnt__c
        oEmail1.Source__c='Test';
        oEmail1.Type__c='Owner';
       // insert oEmail1;
       listNPDEmail.add(oEmail1);
        
        //Insert NPD Email
        NPD_Email__c oEmail2 = new NPD_Email__c();
        oEmail2.name = 'Test';
        oEmail2.Act_Name__c='Test';
        oEmail2.Brand__c='Test';
        oEmail2.NPD_Activity__c = oActivity.id;
        oEmail2.NPD_Project_Items__c = oProjItem1.id;
        //oEmail2.ownerAssnmnt__c
        oEmail2.Source__c='Test';
        oEmail2.Type__c='Role';
        //insert oEmail2;
        listNPDEmail.add(oEmail2);
        
        //Insert NPD Email
        NPD_Email__c oEmail3 = new NPD_Email__c();
        oEmail3.name = 'Test';
        oEmail3.Act_Name__c='Test';
        oEmail3.Brand__c='Test';
        oEmail3.NPD_Activity__c = oActivity.id;
        oEmail3.NPD_Project_Items__c = oProjItem1.id;
        //oEmail3.ownerAssnmnt__c
        oEmail3.Source__c='Test';
        oEmail3.Type__c='Team';
        //insert oEmail3;
        listNPDEmail.add(oEmail3);
        
        //Insert NPD Email
        NPD_Email__c oEmail4 = new NPD_Email__c();
        oEmail4.name = 'Test';
        oEmail4.Act_Name__c='Test';
        oEmail4.Brand__c='Test';
        oEmail4.NPD_Activity__c = oActivity.id;
        oEmail4.NPD_Project_Items__c = oProjItem1.id;
        //oEmail4.ownerAssnmnt__c
        oEmail4.Source__c='Test';
        oEmail4.Type__c='BrandOwner';
        //insert oEmail4;
        listNPDEmail.add(oEmail4);
        
        //Insert NPD Email
        NPD_Email__c oEmail5 = new NPD_Email__c();
        oEmail5.name = 'Test';
        oEmail5.Act_Name__c='Test';
        oEmail5.Brand__c='Test';
        oEmail5.NPD_Activity__c = oActivity.id;
        oEmail5.NPD_Project_Items__c = oProjItem1.id;
        //oEmail5.ownerAssnmnt__c
        oEmail5.Source__c='Test';
        oEmail5.Type__c='TeamLeader';
        //insert oEmail5;
        listNPDEmail.add(oEmail5);
        
        //Insert NPD Email
        NPD_Email__c oEmail6 = new NPD_Email__c();
        oEmail6.name = 'Test';
        oEmail6.Act_Name__c='Test';
        oEmail6.Brand__c='Test';
        oEmail6.NPD_Activity__c = oActivity.id;
        oEmail6.NPD_Project_Items__c = oProjItem1.id;
        //oEmail6.ownerAssnmnt__c
        oEmail6.Source__c='Test';
        oEmail6.Type__c='ProjectOwner';
        //insert oEmail6;
         listNPDEmail.add(oEmail6);
        
        List<id> lstId = new List<Id>();
        lstId.add(projName.id);
        set<id> setProjId = new set<Id>();
        setProjId.add(projName.id);
        set<id> setProjItemId = new Set<id>();
        setProjItemId.add(oProjItem1.id);
        List<NPD_Activity__c> newListAct = new List<NPD_Activity__c> ();
        newListAct.add(oActivity);
        
        List<NPD_Activity__c> newListActR1 = new List<NPD_Activity__c> ();
        newListActR1.add(oActivityR1);
        
        oActivity.Actual_End_Date__c=system.today().addDays(3);
        try{
            update oActivity;
        }
        catch(exception act1)
        {
            system.debug(act1);
        }
        Map<id,NPD_Activity__c> oldMapAct = new Map<id,NPD_Activity__c>([SELECT id,Name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c,Status__c,No_of_Designs__c,Approval_Status__c,Active__c,Market__c,Marketing_Brief_Reference_No__c,Approval_Required__c,NPD_Stage__c,NPD_Project_Items__c,Position__c,NPD_Project_Name__c,SerialNo__c FROM NPD_Activity__c WHERE id=:oActivity.id]);
        
        List<NPD_Stage__c> newList = new List<NPD_Stage__c> ();
        newList.add(oStage2);
        oStage2.Source__c ='IDS';
        //  update oStage2;   hide by sudama
        set<id> stageId = new set<id>();
        stageId.add(oStage1.id);
        String StageActiveDeactive = oStage1.id;
        set<id> stageIdR1 = new set<id>();
        stageIdR1.add(oStageR1.id);
        NPD_UtilityController.ActivateDeactivateStage(StageActiveDeactive);
        set<id> stageId13 = new set<id>();
        stageId13.add(oStage13.NPD_Stage__c);
        
        set<id> ActivityId = new set<id>();
        ActivityId.add(oActivity.id); 
        Map<id,NPD_Stage__c> oldMap = new Map<id,NPD_Stage__c>([SELECT id,Actual_Start_Date__c,Type__c,Marketing_brief_concept_reference_number__c,Market__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,NPD_Project_Name__c,No_of_Designs__c,Source__c  FROM NPD_Stage__c where id =:oStage2.id]); 
        Map<String,NPD_Stage__c> mapSerialNo_Stage=new   map<String,NPD_Stage__c>();
        mapSerialNo_Stage.put(oStage2.SerialNo__c,oStage2);
        NPD_UtilityController NPDUtility = new NPD_UtilityController(newList,oldMap);
        NPD_UtilityController NPDUtility1 = new NPD_UtilityController(newListAct,oldMapAct);
        
        ApexPages.currentPage().getParameters().put('test','test');
        NPD_UtilityController NPDUtility2 = new NPD_UtilityController();
        
        user ps = [select id,name from user where  username Like '%Admin%' LIMIT 1];
        set<id> lstUser = new set<id>();
        lstUser.add(ps.id);
        id temp = [SELECT id FROM EmailTemplate WHERE Name = 'Activity Completed Email Template' LIMIT 1].ID; 
        id whatid = [SELECT id FROM NPD_Activity__c WHERE id=:oActivity.id].ID; 
        
        // NPD_UtilityController.dateCalulationForSubStage(newList,oldMap, mapSerialNo_Stage);
        //  NPD_UtilityController.checkSubStageStatusActualDatesR1(stageIdR1,newListActR1);
        try{
            NPD_UtilityController.checkStageStatusNotStarted(stageId,newList,oldMap);
            NPD_UtilityController.checkSubStageStatusNotStarted(stageId,newListAct,oldMapAct);
            NPD_UtilityController.checkSubStageStatusInprogress(stageId,newListAct,oldMapAct);
            NPD_UtilityController.afterUpdateSubStageHandlerForStartDate(newList,oldMap);
            NPD_UtilityController.afterUpdateStageHandlerForPlannedDateStage(lstId ,oldMap);
        }Catch(Exception e){
        }
        
        // NPD_UtilityController.AutoupdateActivity(stageId);
        //NPD_UtilityController.AutoupdateActivityPilotLotManufacturing(stageId);
        // NPD_UtilityController.EmailOnActivityCompletion(ActivityId,setProjId,setProjItemId);
        // NPD_UtilityController.ownerAssingmentforActivity(ActivityId,setProjId,setProjItemId);
        NPD_UtilityController.EmailOnActivityCompletion11(lstUser,temp,whatid);
        //stageId.clear();
        stageId.add(oStage12.Id);
        try{
            NPD_UtilityController.ActivateDeactivateStage(stageId);
            NPD_UtilityController.ActivateDeactivateStage(stageId13);
            
        }Catch(Exception e){}
        
        
        Test.StopTest();
    }
    static testMethod void unitTest4() {
        Test.startTest(); 
        
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        //Insert NPD Project Item
        NPD_Project_Items__c oProjItem      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        oProjItem1.Parent_Id__c              =    oProjItem.id;
        insert oProjItem1;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    null;
        oStage1.Actual_End_Date__c                             =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'In Progress';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-01';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        oStage1.Active__c                                      =    true;
        
        insert oStage1;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Actual_End_Date__c                             =    System.today();
        oStage2.Type__c                                        =    'Stage';
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'In Progress';
        oStage2.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c                             =    0;
        oStage2.Position__c                                    =    2;
        oStage2.SerialNo__c                                    =    'AR-0102';
        oStage2.Planned_Lead_Time__c                           =    10;
        oStage2.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage2.Phase__c                                       =    'Design';
        oStage2.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage2.NPD_Project_Name__c                            =    projName.id;
        oStage2.No_of_Designs__c                               =    2;
        oStage2.Source__c                                      =    'OSD';
        oStage2.PredecessorSerialNo__c                         =    'AR-0101';
        insert oStage2;
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Actual_End_Date__c                             =    System.today();
        oStage3.Type__c                                        =    'Sub-Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =    oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0101001';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today().addDays(1);
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Source__c                                      =    'OSD';
        oStage3.Active__c                                      =    true;
        
        insert oStage3;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage4                                   =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage4.Actual_Start_Date__c                           =    System.today();
        oStage4.Actual_End_Date__c                             =    System.today();
        oStage4.Type__c                                        =    'Sub-Stage';
        oStage4.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage4.Market__c                                      =    'Domestic';
        oStage4.Status__c                                      =    'In Progress';
        oStage4.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage4.NPD_Stage__c                                   =    oStage1.Id;
        oStage4.Planned_Start_Date__c                          =    System.today();
        oStage4.Total_Lead_Time__c                             =    0;
        oStage4.Position__c                                    =    2;
        oStage4.SerialNo__c                                    =    'AR-0102002';
        oStage4.Planned_Lead_Time__c                           =    10;
        oStage4.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage4.Phase__c                                       =    'Design';
        oStage4.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage4.NPD_Project_Name__c                            =    projName.id;
        oStage4.No_of_Designs__c                               =    2;
        oStage4.Source__c                                      =    'OSD';
        oStage4.PredecessorSerialNo__c                         =    'AR-0101001';
        oStage4.Active__c                                      =    true;
        insert oStage4;
        
        NPD_Stage__c oStage45                                   =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage45.Actual_Start_Date__c                           =    System.today();
        oStage45.Actual_End_Date__c                             =    System.today();
        oStage45.Type__c                                        =    'Sub-Stage';
        oStage45.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage45.Market__c                                      =    'Domestic';
        oStage45.Status__c                                      =    'In Progress';
        oStage45.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage45.NPD_Stage__c                                   =    oStage1.Id;
        oStage45.Planned_Start_Date__c                          =    System.today();
        oStage45.Total_Lead_Time__c                             =    0;
        oStage45.Position__c                                    =    2;
        oStage45.SerialNo__c                                    =    'AR-0102002';
        oStage45.Planned_Lead_Time__c                           =    10;
        oStage45.Planned_End_Date__c                            =    System.today().adddays(1);
        oStage45.Phase__c                                       =    'Design';
        oStage45.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage45.NPD_Project_Name__c                            =    projName.id;
        oStage45.No_of_Designs__c                               =    2;
        oStage45.Source__c                                      =    'OSD';
        oStage45.PredecessorSerialNo__c                         =    'AR-0101001';
        oStage45.Active__c                                      =    true;
        insert oStage45;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'Proto Design - Release';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity.Actual_Start_Date__c = system.today();
oActivity.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity.R1_ASD__c = System.Today();
        oActivity.R1_AED__c = System.Today();
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage3.Id;
        oActivity.NPD_Project_Items__c = oProjItem1.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c =projName.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity;
        
        //Insert NPD Activity
        NPD_Activity__c oActivityR1            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivityR1.Name__c = 'Proto Design - Release';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivityR1.Actual_Start_Date__c = system.today();
oActivityR1.Actual_End_Date__c=system.today().addDays(2);*/
        oActivityR1.R1_ASD__c = System.Today();
        oActivityR1.R1_AED__c = System.Today();
        oActivityR1.R2_ASD__c = System.Today();
        oActivityR1.R2_AED__c = System.Today();
        oActivityR1.Planned_Lead_Time__c = 10;
        oActivityR1.Status__c = 'Completed R1';
        oActivityR1.No_of_Designs__c = 2;
        oActivityR1.Approval_Status__c = 'None';
        oActivityR1.Market__c = 'Domestic';
        oActivityR1.Approval_Required__c = true;
        oActivityR1.NPD_Stage__c = oStage3.Id;
        oActivityR1.NPD_Project_Items__c = oProjItem1.Id;
        oActivityR1.Position__c = 1;
        oActivityR1.SerialNo__c = 'AR-0101001';
        oActivityR1.Active__c = true;
        oActivityR1.NPD_Project_Name__c =projName.id;
        oActivityR1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivityR1;
        
        NPD_Activity__c oActivityR11            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivityR11.Name__c = 'Proto Design - Release';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivityR11.Actual_Start_Date__c = system.today();
oActivityR11.Actual_End_Date__c=system.today().addDays(2);*/
        oActivityR11.R1_ASD__c = System.Today();
        oActivityR11.R1_AED__c = System.Today();
        oActivityR11.R2_ASD__c = System.Today();
        oActivityR11.R2_AED__c = System.Today();
        oActivityR11.Planned_Lead_Time__c = 10;
        oActivityR11.Status__c = 'In Progress R1';
        oActivityR11.No_of_Designs__c = 2;
        oActivityR11.Approval_Status__c = 'None';
        oActivityR11.Market__c = 'Domestic';
        oActivityR11.Approval_Required__c = true;
        oActivityR11.NPD_Stage__c = oStage3.Id;
        oActivityR11.NPD_Project_Items__c = oProjItem1.Id;
        oActivityR11.Position__c = 1;
        oActivityR11.SerialNo__c = 'AR-0101001';
        oActivityR11.Active__c = true;
        oActivityR11.NPD_Project_Name__c =projName.id;
        oActivityR11.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivityR11;
        
        NPD_Activity__c oActivityR2            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivityR2.Name__c = 'Proto Design - Release';
        /* oActivityR2.Actual_Start_Date__c = system.today();
oActivityR2.Actual_End_Date__c=system.today().addDays(2);*/
        oActivityR2.R1_ASD__c = System.Today();
        oActivityR2.R1_AED__c = System.Today();
        oActivityR2.R2_ASD__c = System.Today();
        oActivityR2.R2_AED__c = System.Today();
        oActivityR2.Planned_Lead_Time__c = 10;
        oActivityR2.Status__c = 'Completed R2';
        oActivityR2.No_of_Designs__c = 2;
        oActivityR2.Approval_Status__c = 'None';
        oActivityR2.Market__c = 'Domestic';
        oActivityR2.Approval_Required__c = true;
        oActivityR2.NPD_Stage__c = oStage3.Id;
        oActivityR2.NPD_Project_Items__c = oProjItem1.Id;
        oActivityR2.Position__c = 1;
        oActivityR2.SerialNo__c = 'AR-0101001';
        oActivityR2.Active__c = true;
        oActivityR2.NPD_Project_Name__c =projName.id;
        oActivityR2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivityR2;
        
        NPD_Activity__c oActivityR22           =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivityR22.Name__c = 'Proto Design - Release';
        //<T01> <T01> Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivityR22.Actual_Start_Date__c = system.today();
oActivityR22.Actual_End_Date__c=system.today().addDays(2);*/
        oActivityR22.R1_ASD__c = System.Today();
        oActivityR22.R1_AED__c = System.Today();
        oActivityR22.R2_ASD__c = System.Today();
        oActivityR22.R2_AED__c = System.Today();
        oActivityR22.Planned_Lead_Time__c = 10;
        oActivityR22.Status__c = 'In Progress R2';
        oActivityR22.No_of_Designs__c = 2;
        oActivityR22.Approval_Status__c = 'None';
        oActivityR22.Approval_Required__c = true;
        oActivityR22.NPD_Stage__c = oStage3.Id;
        oActivityR22.NPD_Project_Items__c = oProjItem1.Id;
        oActivityR22.Position__c = 1;
        oActivityR22.SerialNo__c = 'AR-0101001';
        oActivityR22.Active__c = true;
        oActivityR22.NPD_Project_Name__c =projName.id;
        oActivityR22.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivityR22;
        
        
        
        NPD_Activity__c oActivity1            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity1.Name__c = 'Glass for Proto Mfg';
        /*oActivity1.Actual_Start_Date__c = system.today();
oActivity1.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity1.Planned_Lead_Time__c = 10;
        oActivity1.Status__c = 'In Progress';
        oActivity1.No_of_Designs__c = 2;
        oActivity1.Approval_Status__c = 'None';
        oActivity1.Market__c = 'Domestic';
        oActivity1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity1.Approval_Required__c = true;
        oActivity1.NPD_Stage__c = oStage3.Id;
        oActivity1.NPD_Project_Items__c = oProjItem1.Id;
        oActivity1.Position__c = 1;
        oActivity1.SerialNo__c = 'AR-0101001';
        oActivity1.Active__c = true;
        oActivity1.NPD_Project_Name__c =projName.id;
        oActivity1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity1;
        
        NPD_Activity__c oActivity2            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity2.Name__c = 'Pilot Lot Manufacturing - Press';
        //<T01> <T01> Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /* oActivity2.Actual_Start_Date__c = system.today();
oActivity2.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity2.Planned_Lead_Time__c = 10;
        oActivity2.Status__c = 'In Progress';
        oActivity2.No_of_Designs__c = 2;
        oActivity2.Approval_Status__c = 'None';
        oActivity2.Market__c = 'Domestic';
        oActivity2.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity2.Approval_Required__c = true;
        oActivity2.NPD_Stage__c = oStage3.Id;
        oActivity2.NPD_Project_Items__c = oProjItem1.Id;
        oActivity2.Position__c = 1;
        oActivity2.SerialNo__c = 'AR-0101001';
        oActivity2.Active__c = true;
        oActivity2.NPD_Project_Name__c =projName.id;
        oActivity2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity2;
        
        NPD_Activity__c oActivity3            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity3.Name__c = 'Pilot Lot Manufacturing - Polishing';
        //<T01> <T01> Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /* oActivity3.Actual_Start_Date__c = system.today();
oActivity3.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity3.Planned_Lead_Time__c = 10;
        oActivity3.Status__c = 'In Progress';
        oActivity3.No_of_Designs__c = 2;
        oActivity3.Approval_Status__c = 'None';
        oActivity3.Market__c = 'Domestic';
        oActivity3.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity3.Approval_Required__c = true;
        oActivity3.NPD_Stage__c = oStage3.Id;
        oActivity3.NPD_Project_Items__c = oProjItem1.Id;
        oActivity3.Position__c = 1;
        oActivity3.SerialNo__c = 'AR-0101001';
        oActivity3.Active__c = true;
        oActivity3.NPD_Project_Name__c =projName.id;
        oActivity3.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity3;
        
        
        List<NPD_Stage__c> lstSubStg = new List<NPD_Stage__c>();
        lstSubStg.add(oStage3);
        //lstStg.add(oStage2);
        
        Set<id> ststgId =new set<id>();
        ststgId.add(oStage1.Id);
        
        
        Set<id> stSubstgId =new set<id>();
        stSubstgId.add(oStage3.Id);
        
        List<NPD_Stage__c> lstStg = new List<NPD_Stage__c>();
        lstStg.add(oStage1);
        lstStg.add(oStage2);
        
        List<NPD_Stage__c> lstStg1 = new List<NPD_Stage__c>();
        lstStg.add(oStage4);
        
        List<NPD_Activity__c> lstAct = new List<NPD_Activity__c>();
        lstAct.add(oActivity);
        
        List<NPD_Activity__c> lstActR1 = new List<NPD_Activity__c>();
        lstActR1.add(oActivityR1);
        
        List<NPD_Activity__c> lstActR11 = new List<NPD_Activity__c>();
        lstActR11.add(oActivityR11);
        
        List<NPD_Activity__c> lstActR2 = new List<NPD_Activity__c>();
        lstActR2.add(oActivityR1);
        
        List<NPD_Activity__c> lstActR22 = new List<NPD_Activity__c>();
        lstActR22.add(oActivityR11);
        //lstAct.add(oStage2);
        
        map<String,NPD_Stage__c> mapSerialNo_Stage = new map<String,NPD_Stage__c>();
        map<id,NPD_Stage__c> mapID_Stage = new map<id,NPD_Stage__c>();
        mapID_Stage.put(oStage1.Id,oStage1);
        map<String,NPD_Stage__c> mapSerialNo_SubStage = new map<String,NPD_Stage__c>();
        mapSerialNo_SubStage.put(oStage3.SerialNo__c,oStage3);
        NPD_UtilityController.dateCalulationForStage(lstStg,mapSerialNo_Stage);
        //    NPD_UtilityController.checkStageStatusAndActualDate(ststgId,lstSubStg);   hide by sudama
        NPD_UtilityController.checkSubStageStatusActualDates(stSubstgId,lstAct);
        NPD_UtilityController.checkSubStageStatusActualDatesR1(stSubstgId,lstActR1);
        NPD_UtilityController.checkSubStageStatusActualDatesR1(stSubstgId,lstActR11);
        NPD_UtilityController.checkSubStageStatusActualDatesR2(stSubstgId,lstActR2);
        NPD_UtilityController.checkSubStageStatusActualDatesR2(stSubstgId,lstActR22);
        NPD_UtilityController.GetValueFromParam('Activity');
        //NPD_UtilityController.AutoupdateActivity(stSubstgId);
        //NPD_UtilityController.AutoupdateActivityPilotLotManufacturing(stSubstgId);
        NPD_UtilityController.dateCalulationForSubStage(lstStg1,mapID_Stage,mapSerialNo_SubStage);
        Test.StopTest();
    }
    
    static testMethod void unitTest5() {
        Test.startTest(); 
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        //Insert NPD Project Item
        NPD_Project_Items__c oProjItem      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        oProjItem1.Parent_Id__c              =    oProjItem.id;
        insert oProjItem1;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    null;
        oStage1.Actual_End_Date__c                             =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'Completed';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        oStage1.Active__c                                      =    false;
        
        insert oStage1;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Actual_End_Date__c                             =    System.today();
        oStage2.Type__c                                        =    'Stage';
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'Completed';
        oStage2.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c                             =    0;
        oStage2.Position__c                                    =    2;
        oStage2.SerialNo__c                                    =    'AR-0102';
        oStage2.Planned_Lead_Time__c                           =    10;
        oStage2.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage2.Phase__c                                       =    'Design';
        oStage2.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage2.NPD_Project_Name__c                            =    projName.id;
        oStage2.No_of_Designs__c                               =    2;
        oStage2.Source__c                                      =    'OSD';
        oStage2.PredecessorSerialNo__c                         =    'AR-0101';
        insert oStage2;
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Actual_End_Date__c                             =    System.today();
        oStage3.Type__c                                        =    'Sub-Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'Completed';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =    oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0101';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today();
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Source__c                                      =    'OSD';
        oStage3.Active__c                                      =    true;
        
        insert oStage3;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage4                                   =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage4.Actual_Start_Date__c                           =    System.today();
        oStage4.Actual_End_Date__c                             =    System.today();
        oStage4.Type__c                                        =    'Sub-Stage';
        oStage4.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage4.Market__c                                      =    'Domestic';
        oStage4.Status__c                                      =    'Completed';
        oStage4.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage4.NPD_Stage__c                                   =    oStage1.Id;
        oStage4.Planned_Start_Date__c                          =    System.today();
        oStage4.Total_Lead_Time__c                             =    0;
        oStage4.Position__c                                    =    2;
        oStage4.SerialNo__c                                    =    'AR-0102';
        oStage4.Planned_Lead_Time__c                           =    10;
        oStage4.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage4.Phase__c                                       =    'Design';
        oStage4.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage4.NPD_Project_Name__c                            =    projName.id;
        oStage4.No_of_Designs__c                               =    2;
        oStage4.Source__c                                      =    'OSD';
        oStage4.PredecessorSerialNo__c                         =    'AR-0101';
        oStage4.Active__c                                      =    true;
        insert oStage4;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'PB/PM Release , Approval  and Recipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity     
        /*oActivity.Actual_Start_Date__c = null;
oActivity.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'Completed';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage3.Id;
        oActivity.NPD_Project_Items__c = oProjItem1.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c =projName.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity;
        
        
        NPD_Activity__c oActivity1            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity1.Name__c = 'Hands for Proto Mfg';
        /*oActivity1.Actual_Start_Date__c = system.today();
oActivity1.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity1.Planned_Lead_Time__c = 10;
        oActivity1.Status__c = 'Completed';
        oActivity1.No_of_Designs__c = 2;
        oActivity1.Approval_Status__c = 'None';
        oActivity1.Market__c = 'Domestic';
        oActivity1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity1.Approval_Required__c = true;
        oActivity1.NPD_Stage__c = oStage3.Id;
        oActivity1.NPD_Project_Items__c = oProjItem1.Id;
        oActivity1.Position__c = 1;
        oActivity1.SerialNo__c = 'AR-0101001';
        oActivity1.Active__c = true;
        oActivity1.NPD_Project_Name__c =projName.id;
        oActivity1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity1;
        
        NPD_Activity__c oActivity2            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity2.Name__c = 'Pilot Lot Manufacturing - Press';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity2.Actual_Start_Date__c = system.today();
oActivity2.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity2.Planned_Lead_Time__c = 10;
        oActivity2.Status__c = 'Completed';
        oActivity2.No_of_Designs__c = 2;
        oActivity2.Approval_Status__c = 'None';
        oActivity2.Market__c = 'Domestic';
        oActivity2.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity2.Approval_Required__c = true;
        oActivity2.NPD_Stage__c = oStage3.Id;
        oActivity2.NPD_Project_Items__c = oProjItem1.Id;
        oActivity2.Position__c = 1;
        oActivity2.SerialNo__c = 'AR-0101001';
        oActivity2.Active__c = true;
        oActivity2.NPD_Project_Name__c =projName.id;
        oActivity2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity2;
        
        NPD_Activity__c oActivity3            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity3.Name__c = 'Pilot Lot Manufacturing - Polishing';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity     
        /* oActivity3.Actual_Start_Date__c = system.today();
oActivity3.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity3.Planned_Lead_Time__c = 10;
        oActivity3.Status__c = 'Completed';
        oActivity3.No_of_Designs__c = 2;
        oActivity3.Approval_Status__c = 'None';
        oActivity3.Market__c = 'Domestic';
        oActivity3.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity3.Approval_Required__c = true;
        oActivity3.NPD_Stage__c = oStage3.Id;
        oActivity3.NPD_Project_Items__c = oProjItem1.Id;
        oActivity3.Position__c = 1;
        oActivity3.SerialNo__c = 'AR-0101001';
        oActivity3.Active__c = true;
        oActivity3.NPD_Project_Name__c =projName.id;
        oActivity3.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity3;
        
        List<NPD_Stage__c> lstSubStg = new List<NPD_Stage__c>();
        lstSubStg.add(oStage3);
        //lstStg.add(oStage2);
        
        Set<id> ststgId =new set<id>();
        ststgId.add(oStage1.Id);
        
        
        Set<id> stSubstgId =new set<id>();
        stSubstgId.add(oStage3.Id);
        
        List<NPD_Stage__c> lstStg = new List<NPD_Stage__c>();
        lstStg.add(oStage1);
        lstStg.add(oStage2);
        
        List<NPD_Stage__c> lstStg1 = new List<NPD_Stage__c>();
        lstStg1.add(oStage4);
        
        List<NPD_Activity__c> lstAct = new List<NPD_Activity__c>();
        lstAct.add(oActivity);
        
        
        //lstAct.add(oStage2);
        
        map<id,NPD_Activity__c> mapAct =new map<id,NPD_Activity__c>();
        mapAct.put(oActivity.id,oActivity); 
        map<String,NPD_Stage__c> mapSerialNo_Stage = new map<String,NPD_Stage__c>();
        map<id,NPD_Stage__c> mapID_Stage = new map<id,NPD_Stage__c>();
        mapID_Stage.put(oStage1.Id,oStage1);
        map<String,NPD_Stage__c> mapSerialNo_SubStage = new map<String,NPD_Stage__c>();
        mapSerialNo_SubStage.put(oStage4.SerialNo__c,oStage3);
        NPD_UtilityController NPDUtility1 = new NPD_UtilityController(lstAct,mapAct);
        NPDUtility1.afterUpdateHandlerAct();
        //   NPD_UtilityController.checkStageStatusAndActualDate(ststgId,lstSubStg);   hide by sudama
        NPD_UtilityController.checkSubStageStatusActualDates(stSubstgId,lstAct);
        NPD_UtilityController.checkSubStageStatusNotStarted(stSubstgId,lstAct,mapAct);
        NPD_UtilityController.dateCalulationForSubStage(lstStg1,mapID_Stage,mapSerialNo_SubStage);
        
        
    }
    
    
    static testMethod void unitTest6() {
        Test.startTest(); 
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        //Insert NPD Project Item
        NPD_Project_Items__c oProjItem      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        oProjItem1.Parent_Id__c              =    oProjItem.id;
        insert oProjItem1;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    null;
        oStage1.Actual_End_Date__c                             =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'Completed';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        oStage1.Active__c                                      =    false;
        
        insert oStage1;
        
        
        
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Actual_End_Date__c                             =    System.today();
        oStage3.Type__c                                        =    'Sub-Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =    oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0101';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today();
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Source__c                                      =    'OSD';
        oStage3.Active__c                                      =    true;
        
        insert oStage3;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage4                                   =    NPD_TestUtilityClass.getNPDStage('Design');
        oStage4.Actual_Start_Date__c                           =    System.today();
        oStage4.Actual_End_Date__c                             =    System.today();
        oStage4.Type__c                                        =    'Sub-Stage';
        oStage4.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage4.Market__c                                      =    'Domestic';
        oStage4.Status__c                                      =    'In Progress';
        oStage4.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage4.NPD_Stage__c                                   =    oStage1.Id;
        oStage4.Planned_Start_Date__c                          =    System.today();
        oStage4.Total_Lead_Time__c                             =    0;
        oStage4.Position__c                                    =    2;
        oStage4.SerialNo__c                                    =    'AR-0102';
        oStage4.Planned_Lead_Time__c                           =    10;
        oStage4.Planned_End_Date__c                            =    System.today().adddays(1);
        oStage4.Phase__c                                       =    'Design';
        oStage4.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage4.NPD_Project_Name__c                            =    projName.id;
        oStage4.No_of_Designs__c                               =    2;
        oStage4.Source__c                                      =    'OSD';
        oStage4.PredecessorSerialNo__c                         =    'AR-0101';
        oStage4.Active__c                                      =    true;
        insert oStage4;
        
        
        List<NPD_Stage__c> lstSubStg = new List<NPD_Stage__c>();
        lstSubStg.add(oStage3);
        //lstStg.add(oStage2);
        
        Set<id> ststgId =new set<id>();
        ststgId.add(oStage1.Id);
        
        
        Set<id> stSubstgId =new set<id>();
        stSubstgId.add(oStage3.Id);
        
        List<NPD_Stage__c> lstStg = new List<NPD_Stage__c>();
        lstStg.add(oStage1);
        //lstStg.add(oStage2);
        
        List<NPD_Stage__c> lstStg1 = new List<NPD_Stage__c>();
        lstStg1.add(oStage4);
        
        //List<NPD_Activity__c> lstAct = new List<NPD_Activity__c>();
        // lstAct.add(oActivity);
        
        
        //lstAct.add(oStage2);
        
        //map<id,NPD_Activity__c> mapAct =new map<id,NPD_Activity__c>();
        // mapAct.put(oActivity.id,oActivity); 
        map<String,NPD_Stage__c> mapSerialNo_Stage = new map<String,NPD_Stage__c>();
        map<id,NPD_Stage__c> mapID_Stage = new map<id,NPD_Stage__c>();
        mapID_Stage.put(oStage1.Id,oStage1);
        map<String,NPD_Stage__c> mapSerialNo_SubStage = new map<String,NPD_Stage__c>();
        mapSerialNo_SubStage.put(oStage4.PredecessorSerialNo__c,oStage3);
        
        NPD_UtilityController.dateCalulationForSubStage(lstStg1,mapID_Stage,mapSerialNo_SubStage);
        
        
    }
    
    
    static testMethod void unitTest7() {
        Test.startTest(); 
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        
        insert oProjItem1;
        
        NPD_Email__c oEmail = new NPD_Email__c();
        oEmail.name = 'Pilot Lot Manufacturing - Press';
        oEmail.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail.NPD_Project_Items__c = oProjItem1.id;
        oEmail.Type__c='Successor';
        insert oEmail;
        
        NPD_Stage__c oStage1                 =                      NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    null;
        oStage1.Actual_End_Date__c                             =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'Completed';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    NULL;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        oStage1.Active__c                                      =    false;
        oStage1.NPD_Email__c                                  =    oEmail.id;
        insert oStage1;
        
        
        
        
        NPD_Stage__c oStage3                 =    NPD_TestUtilityClass.getNPDStage('Test1');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Actual_End_Date__c                             =    System.today();
        oStage3.Type__c                                        =    'Sub-Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =     oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0101';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today();
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Source__c                                      =    'OSD';
        oStage3.Active__c                                      =    true;
        
        insert oStage3;
        
        NPD_Email__c oEmail1 = new NPD_Email__c();
        oEmail1.name = 'Pilot Lot Manufacturing - Press';
        oEmail1.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail1.NPD_Project_Items__c = oProjItem1.id;
        oEmail1.Type__c='Successor';
        insert oEmail1;
        
        NPD_Email__c oEmail2 = new NPD_Email__c();
        oEmail2.name = 'Pilot Lot Manufacturing - Press';
        oEmail2.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail2.NPD_Project_Items__c = oProjItem1.id;
        oEmail2.Type__c='Owner';
        insert oEmail2;
        
        NPD_Email__c oEmail3 = new NPD_Email__c();
        oEmail3.name = 'Pilot Lot Manufacturing - Press';
        oEmail3.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail3.NPD_Project_Items__c = oProjItem1.id;
        oEmail3.Type__c='Role';
        insert oEmail3;
        
        NPD_Email__c oEmail4 = new NPD_Email__c();
        oEmail4.name = 'Pilot Lot Manufacturing - Press';
        oEmail4.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail4.NPD_Project_Items__c = oProjItem1.id;
        oEmail4.Type__c='Brand&Role';
        insert oEmail4;
        
        NPD_Email__c oEmail5 = new NPD_Email__c();
        oEmail5.name = 'Pilot Lot Manufacturing - Press';
        oEmail5.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail5.NPD_Project_Items__c = oProjItem1.id;
        oEmail5.Type__c='BrandSource&Role';
        insert oEmail5;
        
        NPD_Email__c oEmail6 = new NPD_Email__c();
        oEmail6.name = 'Pilot Lot Manufacturing - Press';
        oEmail6.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail6.NPD_Project_Items__c = oProjItem1.id;
        oEmail6.Type__c='Team';
        insert oEmail6;
        
        NPD_Email__c oEmail7 = new NPD_Email__c();
        oEmail7.name = 'Pilot Lot Manufacturing - Press';
        oEmail7.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail7.NPD_Project_Items__c = oProjItem1.id;
        oEmail7.Type__c='BrandOwner';
        insert oEmail7;
        
        NPD_Email__c oEmail8 = new NPD_Email__c();
        oEmail8.name = 'Pilot Lot Manufacturing - Press';
        oEmail8.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail8.NPD_Project_Items__c = oProjItem1.id;
        oEmail8.Type__c='SourceOwner';
        insert oEmail8;
        
        NPD_Email__c oEmail9 = new NPD_Email__c();
        oEmail9.name = 'Pilot Lot Manufacturing - Press';
        oEmail9.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail9.NPD_Project_Items__c = oProjItem1.id;
        oEmail9.Type__c='Activityowner';
        insert oEmail9;
        
        NPD_Email__c oEmail71 = new NPD_Email__c();
        oEmail71.name = 'Pilot Lot Manufacturing - Press';
        oEmail71.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail71.NPD_Project_Items__c = oProjItem1.id;
        oEmail71.Type__c='ProjectOwner';
        insert oEmail71;
        
        NPD_Email__c oEmail91 = new NPD_Email__c();
        oEmail91.name = 'Pilot Lot Manufacturing - Press';
        oEmail91.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail91.NPD_Project_Items__c = oProjItem1.id;
        oEmail91.Type__c='TeamLeader';
        insert oEmail91;
        
        NPD_Activity__c oActivity2            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity2.Name__c = 'Pilot Lot Manufacturing - Press';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity     
        /*oActivity2.Actual_Start_Date__c = system.today();
oActivity2.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity2.Planned_Lead_Time__c = 10;
        oActivity2.Status__c = 'Completed';
        oActivity2.No_of_Designs__c = 2;
        oActivity2.Approval_Status__c = 'None';
        oActivity2.Market__c = 'Domestic';
        oActivity2.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity2.Approval_Required__c = true;
        oActivity2.NPD_Stage__c = oStage3.Id;
        oActivity2.NPD_Project_Items__c = oProjItem1.Id;
        oActivity2.Position__c = 1;
        oActivity2.SerialNo__c = 'AR-0101001';
        oActivity2.Active__c = true;
        oActivity2.NPD_Project_Name__c =projName.id;
        oActivity2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity2;
        
        
        NPD_Activity__c oActivity3            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity3.Name__c = 'Pilot Lot Manufacturing - Polishing';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity3.Actual_Start_Date__c = system.today();
oActivity3.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity3.Planned_Lead_Time__c = 10;
        oActivity3.Status__c = 'Completed';
        oActivity3.No_of_Designs__c = 2;
        oActivity3.Approval_Status__c = 'None';
        oActivity3.Market__c = 'Domestic';
        oActivity3.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity3.Approval_Required__c = true;
        oActivity3.NPD_Stage__c = oStage3.Id;
        oActivity3.NPD_Project_Items__c = oProjItem1.Id;
        oActivity3.Position__c = 1;
        oActivity3.SerialNo__c = 'AR-0101001';
        oActivity3.Active__c = true;
        oActivity3.NPD_Project_Name__c =projName.id;
        oActivity3.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity3;
        
        
        List<NPD_Stage__c> lstSubStg = new List<NPD_Stage__c>();
        lstSubStg.add(oStage3);
        //lstStg.add(oStage2);
        
        Set<id> ststgId =new set<id>();
        ststgId.add(oStage1.Id);
        set<id> stActId = new set<id>();
        stActId.add(oActivity3.id);
        set<id> setProjId = new set<Id>();
        setProjId.add(projName.id);
        
        set<id> setProjItemId = new Set<id>();
        setProjItemId.add(oProjItem1.id);
        
        Set<id> stSubstgId =new set<id>();
        stSubstgId.add(oStage3.Id);
        
        List<NPD_Stage__c> lstStg = new List<NPD_Stage__c>();
        lstStg.add(oStage1);
        //lstStg.add(oStage2);
        
        List<NPD_Stage__c> lstStg1 = new List<NPD_Stage__c>();
        //lstStg1.add(oStage4);
        
        
        map<String,NPD_Stage__c> mapSerialNo_Stage = new map<String,NPD_Stage__c>();
        map<id,NPD_Stage__c> mapID_Stage = new map<id,NPD_Stage__c>();
        mapID_Stage.put(oStage1.Id,oStage1);
        
        
        //NPD_UtilityController.dateCalulationForSubStage(lstStg1,mapID_Stage,mapSerialNo_SubStage);
        NPD_UtilityController.AutoupdateActivity(stSubstgId);
        //     NPD_UtilityController.AutoupdateActivityPilotLotManufacturing(stSubstgId);
        NPD_UtilityController.EmailOnActivityCompletion(stActId,setProjId,setProjItemId);
        NPD_UtilityController.ownerAssingmentforActivity(stActId,setProjId,setProjItemId);
        //NPD_UtilityController.ownerAssingmentforstage(ststgId,setProjId,setProjItemId);
        
    }
    
    
    
    
    
    
    static testMethod void unitTest8() {
        Test.startTest(); 
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        
        insert oProjItem1;
        
        NPD_Email__c oEmail = new NPD_Email__c();
        oEmail.name = 'System.today();';
        oEmail.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail.NPD_Project_Items__c = oProjItem1.id;
        oEmail.Type__c='Owner';
        insert oEmail;
        
        NPD_Stage__c oStage1                 =                      NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    System.today();
        oStage1.Actual_End_Date__c                             =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'Completed';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    NULL;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        oStage1.Active__c                                      =    false;
        oStage1.NPD_Email__c                                  =    oEmail.id;
        insert oStage1;
        
        
        
        
        NPD_Stage__c oStage3                                   =    NPD_TestUtilityClass.getNPDStage('Test1');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Actual_End_Date__c                             =    System.today();
        oStage3.Type__c                                        =    'Sub-Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =     oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0101';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today();
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Source__c                                      =    'OSD';
        oStage3.Active__c                                      =    true;
        
        insert oStage3;
        
        
        NPD_Activity__c oActivity3            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity3.Name__c = 'Act1';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity3.Actual_Start_Date__c = system.today();
oActivity3.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity3.Planned_Lead_Time__c = 10;
        oActivity3.Status__c = 'In Progress';
        oActivity3.No_of_Designs__c = 2;
        oActivity3.Approval_Status__c = 'None';
        oActivity3.Market__c = 'Domestic';
        oActivity3.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity3.Approval_Required__c = true;
        oActivity3.NPD_Stage__c = oStage3.Id;
        oActivity3.NPD_Project_Items__c = oProjItem1.Id;
        oActivity3.Position__c = 1;
        oActivity3.SerialNo__c = 'AR-0101001';
        oActivity3.Active__c = true;
        oActivity3.NPD_Project_Name__c =projName.id;
        oActivity3.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //oActivity.NPD_Email__c =oEmail.id;
        insert oActivity3;
        
        NPD_Email__c oEmail1 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail1.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail1.NPD_Project_Items__c = oProjItem1.id;
        oEmail1.Type__c='Successor';
        insert oEmail1;
        
        NPD_Email__c oEmail2 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail2.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail2.NPD_Project_Items__c = oProjItem1.id;
        oEmail2.Type__c='Owner';
        insert oEmail2;
        
        NPD_Email__c oEmail3 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail3.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail3.NPD_Project_Items__c = oProjItem1.id;
        oEmail3.Type__c='Role';
        insert oEmail3;
        
        NPD_Email__c oEmail4 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail4.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail4.NPD_Project_Items__c = oProjItem1.id;
        oEmail4.Type__c='Brand&Role';
        insert oEmail4;
        
        NPD_Email__c oEmail5 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail5.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail5.NPD_Project_Items__c = oProjItem1.id;
        oEmail5.Type__c='BrandSource&Role';
        insert oEmail5;
        
        NPD_Email__c oEmail6 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail6.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail6.NPD_Project_Items__c = oProjItem1.id;
        oEmail6.Type__c='Team';
        insert oEmail6;
        
        NPD_Email__c oEmail7 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail7.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail7.NPD_Project_Items__c = oProjItem1.id;
        oEmail7.Type__c='BrandOwner';
        insert oEmail7;
        
        NPD_Email__c oEmail8 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail8.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail8.NPD_Project_Items__c = oProjItem1.id;
        oEmail8.Type__c='SourceOwner';
        insert oEmail8;
        
        NPD_Email__c oEmail9 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail9.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail9.NPD_Project_Items__c = oProjItem1.id;
        oEmail9.Type__c='Activityowner';
        insert oEmail9;
        
        NPD_Email__c oEmail71 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail71.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail71.NPD_Project_Items__c = oProjItem1.id;
        oEmail71.Type__c='ProjectOwner';
        insert oEmail71;
        
        NPD_Email__c oEmail91 = new NPD_Email__c();
        oEmail1.name = 'Concept Finalization';
        oEmail91.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail91.NPD_Project_Items__c = oProjItem1.id;
        oEmail91.Type__c='TeamLeader';
        insert oEmail91;
        
        
        
        
        List<NPD_Stage__c> lstSubStg = new List<NPD_Stage__c>();
        lstSubStg.add(oStage3);
        //lstStg.add(oStage2);
        
        Set<id> ststgId =new set<id>();
        ststgId.add(oStage1.Id);
        
        set<id> setProjId = new set<Id>();
        setProjId.add(projName.id);
        
        set<id> setProjItemId = new Set<id>();
        setProjItemId.add(oProjItem1.id);
        
        Set<id> stSubstgId =new set<id>();
        stSubstgId.add(oStage3.Id);
        
        List<NPD_Stage__c> lstStg = new List<NPD_Stage__c>();
        lstStg.add(oStage1);
        //lstStg.add(oStage2);
        
        List<NPD_Stage__c> lstStg1 = new List<NPD_Stage__c>();
        //lstStg1.add(oStage4);
        
        
        map<String,NPD_Stage__c> mapSerialNo_Stage = new map<String,NPD_Stage__c>();
        map<id,NPD_Stage__c> mapID_Stage = new map<id,NPD_Stage__c>();  
        mapID_Stage.put(oStage1.Id,oStage1);
        map<id,NPD_Stage__c> mapofSubstage= new map<id,NPD_Stage__c>();
        mapofSubstage.put(oStage3.Id,oStage3);
        
        NPD_UtilityController.ownerAssingmentforstage(ststgId,setProjId,setProjItemId);
        NPD_UtilityController.updateleadtimeonActivity(stSubstgId,mapofSubstage);
        Test.StopTest();
    }
    
    
    
    //Cloned by Dheeraj
    static testMethod void unitTest9() {
        Test.startTest(); 
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        //Insert NPD Template
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
        
        
        NPD_Project_Items__c oProjItem1      =    NPD_TestUtilityClass.getProjItemForStage('Marketing stage','Stage',oProjTemp.Id);
        
        insert oProjItem1;
        
        
        
        NPD_Stage__c oStage1                 =                      NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Actual_Start_Date__c                           =    System.today();
        oStage1.Actual_End_Date__c                             =    System.today();
        oStage1.Type__c                                        =    'Stage';
        oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage1.Market__c                                      =    'Domestic';
        oStage1.Status__c                                      =    'Completed';
        oStage1.NPD_Project_Items__c                           =    oProjItem1.Id;
        //oStage2.NPD_Stage__c                                   =    NULL;
        oStage1.Planned_Start_Date__c                          =    System.today();
        oStage1.Total_Lead_Time__c                             =    0;
        oStage1.Position__c                                    =    1;
        oStage1.SerialNo__c                                    =    'AR-0101';
        oStage1.Planned_Lead_Time__c                           =    10;
        oStage1.Planned_End_Date__c                            =    System.today().addYears(1);
        oStage1.Phase__c                                       =    'Design';
        oStage1.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage1.NPD_Project_Name__c                            =    projName.id;
        oStage1.No_of_Designs__c                               =    2;
        oStage1.Source__c                                      =    'OSD';
        oStage1.Active__c                                      =    false;
        //oStage1.NPD_Email__c                                  =    oEmail.id;
        oStage1.Brand1__c = 'Test brand';
        insert oStage1;
        
        NPD_Stage__c oStage3                                   =    NPD_TestUtilityClass.getNPDStage('Test1');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Actual_End_Date__c                             =    System.today();
        oStage3.Type__c                                        =    'Sub-Stage';
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =     oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    0;
        oStage3.Position__c                                    =    1;
        oStage3.SerialNo__c                                    =    'AR-0101';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today();
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Source__c                                      =    'OSD';
        oStage3.Active__c                                      =    true;
        //oStage3.NPD_Email__c                                  =    oEmail.id;
        oStage3.Brand1__c = 'Test brand';
        insert oStage3;
        
        
        NPD_Email__c oEmail = new NPD_Email__c();
        oEmail.name = 'System.today();';
        oEmail.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail.NPD_Project_Items__c = oProjItem1.id;
        //oEmail.NPD_Stage__c = oStage1.Id;
        oEmail.Type__c = 'Owner';
        oEmail.Brand__c = 'Test brand';
        insert oEmail;
        
        NPD_Email__c oEmail1 = new NPD_Email__c();
        oEmail1.name = 'System.today();';
        oEmail1.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail1.NPD_Project_Items__c = oProjItem1.id;
        oEmail1.Type__c = 'BrandOwner';
        //oEmail1.NPD_Stage__c = oStage1.Id;
        oEmail1.Brand__c = 'Test brand';
        insert oEmail1;
        
        
        NPD_Email__c oEmail2 = new NPD_Email__c();
        oEmail2.name = 'System.today();';
        oEmail2.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail2.NPD_Project_Items__c = oProjItem1.id;
        oEmail2.Type__c = 'ProjectOwner';
        //oEmail1.NPD_Stage__c = oStage1.Id;
        oEmail2.Brand__c = 'Test brand';
        insert oEmail2;
        
        NPD_Email__c oEmail4 = new NPD_Email__c();
        oEmail4.name = 'System.today()';
        oEmail4.Act_Name__c='Pilot Lot Manufacturing - Polishing';
        oEmail4.NPD_Project_Items__c = oProjItem1.id;
        oEmail4.Type__c = 'SourceOwner';
        oEmail4.Source__c = 'OSD';
        //oEmail1.NPD_Stage__c = oStage1.Id;
        oEmail4.Brand__c = 'Test brand';
        insert oEmail4;
        /*

NPD_Stage__c oStage4                                   =    NPD_TestUtilityClass.getNPDStage('Test1');
oStage4.Actual_Start_Date__c                           =    System.today();
oStage4.Actual_End_Date__c                             =    System.today();
oStage4.Type__c                                        =    'Sub-Stage';
oStage4.Marketing_brief_concept_reference_number__c    =    'Mar123';
oStage4.Market__c                                      =    'Domestic';
oStage4.Status__c                                      =    'In Progress';
oStage4.NPD_Project_Items__c                           =    oProjItem1.Id;
oStage4.NPD_Stage__c                                   =     oStage1.Id;
oStage4.Planned_Start_Date__c                          =    System.today();
oStage4.Total_Lead_Time__c                             =    0;
oStage4.Position__c                                    =    1;
oStage4.SerialNo__c                                    =    'AR-0101';
oStage4.Planned_Lead_Time__c                           =    10;
oStage4.Planned_End_Date__c                            =    System.today();
oStage4.Phase__c                                       =    'Design';
oStage4.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
oStage4.NPD_Project_Name__c                            =    projName.id;
oStage4.No_of_Designs__c                               =    2;
oStage4.Source__c                                      =    'OSD';
oStage4.Active__c                                      =    true;

insert oStage4;


NPD_Email__c oEmail = new NPD_Email__c();
oEmail.name = 'System.today();';
oEmail.Act_Name__c='Pilot Lot Manufacturing - Polishing';
oEmail.NPD_Project_Items__c = oProjItem1.id;
oEmail.NPD_Stage__c = oStage4.Id;
oEmail.Type__c = 'BrandOwner';
oEmail.Brand__c = 'Test brand';
insert oEmail;

NPD_Email__c oEmail11 = new NPD_Email__c();
oEmail11.name = 'System.today();';
oEmail11.Act_Name__c='Pilot Lot Manufacturing - Polishing';
oEmail11.NPD_Project_Items__c = oProjItem1.id;
oEmail11.Type__c = 'BrandOwner';
oEmail1.NPD_Stage__c = oStage4.Id;
oEmail1.Brand__c = 'Test brand';
insert oEmail1;
*/
        
        Set<id> ststgId =new set<id>();
        ststgId.add(oStage1.Id);
        //ststgId.add(oStage4.Id);
        
        set<id> setProjId = new set<Id>();
        setProjId.add(projName.id);
        
        set<id> setProjItemId = new Set<id>();
        setProjItemId.add(oProjItem1.id);
        
        
        NPD_UtilityController.ownerAssingmentforstage(ststgId,setProjId,setProjItemId);
        Test.StopTest();
        
    }
    
    static testMethod void unitTest10() {
        //Test.startTest(); //T01
        
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
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
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
        oStage2.brand1__c= 'Titan';
        insert oStage2;
        
        //Insert NPD Stage    
        NPD_Stage__c oStage3                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage3.Actual_Start_Date__c                           =    System.today();
        oStage3.Type__c                                        =    'Stage';
        oStage3.Active__c                                      =    TRUE;
        oStage3.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage3.Market__c                                      =    'Domestic';
        oStage3.Status__c                                      =    'In Progress';
        oStage3.NPD_Project_Items__c                           =    oProjItem1.Id;
        oStage3.NPD_Stage__c                                   =    oStage1.Id;
        oStage3.Planned_Start_Date__c                          =    System.today();
        oStage3.Total_Lead_Time__c                             =    4;
        oStage3.Position__c                                    =    2;
        oStage3.SerialNo__c                                    =    'AR-0101';
        oStage3.Planned_Lead_Time__c                           =    10;
        oStage3.Planned_End_Date__c                            =    System.today().addDays(2);
        oStage3.Phase__c                                       =    'Design';
        oStage3.Tentative_Launch_Plan__c                       =    Date.newInstance(2016,11,12);
        oStage3.NPD_Project_Name__c                            =    projName.id;
        oStage3.No_of_Designs__c                               =    2;
        oStage3.Status__c                                      =    'In Progress';
        oStage3.Source__c                                      =    'OSD';
        oStage3.brand1__c= 'Titan';
        insert oStage3;
        
        NPD_Activity__c oActivity1            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity1.Name__c = 'PB/PM Release , Approval  and Recipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /* oActivity1.Actual_Start_Date__c = system.today();
oActivity1.Actual_End_Date__c=system.today().addDays(3);*/
        oActivity1.Planned_Lead_Time__c = 10;
        oActivity1.Status__c = 'Not Started';    // changes by sudama In Progress to not Stared
        oActivity1.No_of_Designs__c = 2;
        oActivity1.Approval_Status__c = 'Approved';
        oActivity1.Market__c = 'Domestic';
        oActivity1.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity1.Approval_Required__c = true;
        oActivity1.NPD_Stage__c = oStage2.Id;
        oActivity1.NPD_Project_Items__c = oProjItem1.Id;
        oActivity1.Position__c = 1;
        oActivity1.SerialNo__c = 'AR-0101001';
        oActivity1.Active__c = true;  
        oActivity1.NPD_Project_Name__c =projName.id;
        //oActivity1.NPD_Activity__c=oActivity.id;
        oActivity1.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        try{
            insert oActivity1;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Sorry! you cant de-Active this record as status is changed') ? true : false;
            System.AssertEquals(expectedExceptionThrown,false);//<T01>
        }           
        
        //Insert NPD Activity
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity.Name__c = 'Proto Dial Drawing Release and Receipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity     
        /*oActivity.Actual_Start_Date__c = system.today();
oActivity.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'Completed';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'Approved';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage3.Id;
        oActivity.NPD_Project_Items__c = oProjItem1.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        oActivity.NPD_Project_Name__c =projName.id;
        oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity.NPD_Activity__c=oActivity1.id;
        insert oActivity;
        
        NPD_Activity__c oActivity4            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity4.Name__c = 'Proto Dial Drawing Release and Receipt';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity4.Actual_Start_Date__c = system.today();
oActivity4.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity4.Planned_Lead_Time__c = 10;
        oActivity4.Status__c = 'Completed';
        oActivity4.No_of_Designs__c = 2;
        oActivity4.Approval_Status__c = 'Approved';
        oActivity4.Market__c = 'Domestic';
        oActivity4.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity4.Approval_Required__c = true;
        oActivity4.NPD_Stage__c = oStage3.Id;
        oActivity4.NPD_Project_Items__c = oProjItem1.Id;
        oActivity4.Position__c = 1;
        oActivity4.SerialNo__c = 'AR-0101001';
        oActivity4.Active__c = true;
        oActivity4.NPD_Project_Name__c =projName.id;
        oActivity4.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity4.NPD_Activity__c=oActivity1.id;
        insert oActivity4;
        
        //Insert NPD Activity
        NPD_Activity__c oActivity2            =    NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        oActivity2.Name__c = 'Hands for Proto Mfg';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity2.Actual_Start_Date__c = system.today();
oActivity2.Actual_End_Date__c=system.today().addDays(2);*/
        oActivity2.Planned_Lead_Time__c = 10;
        oActivity2.Status__c = 'In Progress';
        oActivity2.No_of_Designs__c = 2;
        oActivity2.Approval_Status__c = 'Approved';
        oActivity2.Market__c = 'Domestic';
        oActivity2.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity2.Approval_Required__c = true;
        oActivity2.NPD_Stage__c = oStage2.Id;
        oActivity2.NPD_Project_Items__c = oProjItem1.Id;
        oActivity2.Position__c = 1;
        oActivity2.SerialNo__c = 'AR-0101001';
        oActivity2.Active__c = true;
        oActivity2.NPD_Project_Name__c =projName.id;
        oActivity2.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        oActivity2.NPD_Activity__c=oActivity1.id;
        insert oActivity2;
        
        List<id> lstId = new List<Id>();
        lstId.add(projName.id);
        
        List<NPD_Activity__c> newListAct = new List<NPD_Activity__c> ();
        newListAct.add(oActivity);
        Set<Id>  subStageId = new Set<Id>();
        subStageId.add(oActivity.id);
        subStageId.add(oActivity4.id);
        
        Set<Id>  subStageId1 = new Set<Id>();
        subStageId1.add(oActivity.NPD_Stage__c);
        subStageId1.add(oActivity4.NPD_Stage__c);
        String StageIDActiveDeactive = oActivity1.id;
        Set<Id>  subStageId2 = new Set<Id>();
        subStageId2.add(oActivity2.NPD_Stage__c);
        
        oActivity.Actual_End_Date__c=system.today().addDays(-1);//<T01>
        update oActivity;
        Map<id,NPD_Activity__c> oldMapAct = new Map<id,NPD_Activity__c>([SELECT id,Name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c,Status__c,No_of_Designs__c,Approval_Status__c,Active__c,Market__c,Marketing_Brief_Reference_No__c,Approval_Required__c,NPD_Stage__c,NPD_Project_Items__c,Position__c,NPD_Project_Name__c,SerialNo__c FROM NPD_Activity__c WHERE id=:oActivity.id]);
        
        List<NPD_Stage__c> newList = new List<NPD_Stage__c> ();
        newList.add(oStage2);
        /*List<NPD_Stage__c> newList1 = new List<NPD_Stage__c> ();
newList.add(oStage1);*/
        
        oStage2.Source__c ='IDS';
        update oStage2;
        set<id> stageId = new set<id>();
        stageId.add(oStage2.id);
        Map<id,NPD_Stage__c> oldMap = new Map<id,NPD_Stage__c>([SELECT id,Actual_Start_Date__c,Type__c,Marketing_brief_concept_reference_number__c,Market__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,NPD_Project_Name__c,No_of_Designs__c,Source__c,Active__c  FROM NPD_Stage__c where id =:oStage2.id]); 
        Map<String,NPD_Stage__c> mapSerialNo_Stage=new   map<String,NPD_Stage__c>();
        mapSerialNo_Stage.put(oStage2.SerialNo__c,oStage2);
        NPD_UtilityController NPDUtility = new NPD_UtilityController(newList,oldMap);
        NPDUtility.afterUpdateHandler();
        NPDUtility.beforeUpdateStageHandler();
        
        NPD_UtilityController NPDUtility1 = new NPD_UtilityController(newListAct,oldMapAct);
        
        ApexPages.currentPage().getParameters().put('test','test');
        NPD_UtilityController NPDUtility2 = new NPD_UtilityController();
        //NPDUtility.afterUpdateStageHandlerForPlannedDateStage(lstId,oldMap);
        
        string stgcomplex='medium';
        string source = 'IDS'; 
        
        
        npd_project_name__c npdn1 = new npd_project_name__c();
        npdn1.name='testing proj';
        npdn1.Project_Complexity__c = 'Medium';
        npdn1.source__c = 'IDS';
        insert npdn1;
        
        
        
        npd_stage__c nStg22=  new npd_stage__c();
        nStg22.name__c = 'testing substage';
        nStg22.type__c = 'stage';
        nStg22.source__c='IDS';
        nStg22.npd_project_name__c = npdn1.id;
        nStg22.Planned_Lead_Time__c =20;
        nStg22.Complexity_Typess__c ='Medium';
        nStg22.position__c =1;
        nStg22.brand1__c= 'Titan';
        
        
        insert nStg22;
        
        list<npd_stage__c> listStages = new list<npd_stage__c>();
        listStages.add(nStg22);
        
        npd_stage__c nStg222=  new npd_stage__c();
        nStg222.id= nStg22.id;
        nStg222.Planned_Lead_Time__c =21;
        nStg222.Complexity_Typess__c = 'simple';
        
        update nStg222;
        
        decimal position123 = nStg222.position__c;
        
        list<npd_stage__c> substages= new list<npd_stage__c>();
        npd_stage__c n1 = new npd_stage__c();
        n1.name__c = 'testing substage';
        n1.type__c = 'sub-stage';
        n1.source__c='IDS';
        n1.npd_stage__c = nStg22.id;
        n1.npd_project_name__c = npdn1.id;
        n1.Planned_Lead_Time__c =20;
        n1.position__c = 1;
        
        insert n1;
        substages.add(n1);
        
        npd_stage__c n2 = new npd_stage__c();
        n2.name__c = 'testing substage';
        n2.type__c = 'sub-stage';
        n2.source__c='IDS';
        n2.npd_stage__c = nStg22.id;
        n2.npd_project_name__c = npdn1.id;
        n2.Planned_Lead_Time__c =20;
        n2.position__c = 2;
        
        insert n2;
        substages.add(n2);
        
        
        
        string StageId123= nStg22.id;
        
        NPD_Complexity__c nc2 = new NPD_Complexity__c();
        nc2.Name__c  = 'Medium';
        nc2.Type__c   = 'Sub-stage';
        nc2.Lead_Time_del__c = 30;      
        nc2.record_name__c  =  'testing substage';
        nc2.source__c = 'IDS';
        nc2.Record_Type__c ='Complexity Type';
        
        insert nc2;
        Test.startTest(); 
        NPDUtility1.afterUpdateHandlerAct();
        NPDUtility.generateSerialNo(newList,'SerialNo__c','Actual_Start_Date__c,Type__c,Status__c,NPD_Project_Items__c,NPD_Stage__c,Planned_Start_Date__c,Total_Lead_Time__c,Position__c,SerialNo__c,Planned_Lead_Time__c,Planned_End_Date__c,Phase__c,Tentative_Launch_Plan__c,NPD_Project_Name__c,No_of_Designs__c,Source__c','NPD_Stage__c','Stage__r','SubStage');
        NPD_UtilityController.fieldDefinition fld = new NPD_UtilityController.fieldDefinition('SUM','NPD_Stage__c','NPD_Stage__c');
        NPD_UtilityController.dateCalulationForStage(newList,mapSerialNo_Stage);
        //NPD_UtilityController.checkStageStatusAndActualDate(stageId,newList);
        NPD_UtilityController.plannedEndDate(String.ValueOf(oStage2.id));
        //NPD_UtilityController.dateCalulationForSubStage(newList1,oldMap, mapSerialNo_Stage);
        NPD_UtilityController.ActivateDeactivateActivity(subStageId1);
        NPD_UtilityController.ActivateDeactivateActivity(subStageId2);
        NPD_UtilityController.ActivateDeactivateActivity(StageIDActiveDeactive);
        NPD_UtilityController.ActivitySubActivityLeadTime(subStageId,stgcomplex,source,StageId123);
        
        //  NPD_UtilityController.SubStageLeadTimeWithComplexityInsert(substages);
        
        NPD_UtilityController nu1 =  new NPD_UtilityController();
        //   nu1.SubStageLeadTimeWithComplexityInsert(substages);              comment by sudama
        
        
        NPD_UtilityController.StageSubStageLeadTimeRecalculation(position123,npdn1.id);
        /***    try{
NPD_UtilityController.mbAutoNumberGeneration(listStages);
}   catch(exception ert1)
{
system.debug('The ert1 exp is :' + ert1);
}      ***********/  
        
        
        
        
        /************************  For testing the create new project ************************/
        
        //String todate = '06/06/2016';
        //Date dt = Date.valueOf(todate);
        
        NPD_UtilityController nc123=new NPD_UtilityController();
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
        
        Test.StopTest();//T01
    }
    
}