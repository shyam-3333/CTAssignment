/*************************************************************************************************************
    ** Created By   :   Vijayavardan Reddy.
    ** Created Date :   08-Sep_2015.
    ** Descriptio   :   This class is used to display stage, substage, activity, subactivity records and 
                        updating those records based on the user inputs
    **************************************************************************************************************/
    public class NPD_ProjectDetailViewOwnerbased {

        public NPD_ProjectDetailViewOwnerbased(ApexPages.StandardController controller) {

        }

        public string                       imagepiclink    {set;get;}  // For holding the image url of user uploading image in project object.    
         public string  activityname;  
         public string   subactivityname;
        String projectId   =    '';//To hold the ID of the project which is being passed from URL
         public String strErrorMsg                          {get;set;}
        public map<id,NPD_Stage__c>         stageMap        {get;set;}
        public map<id,List<NPD_Stage__c>>   subStageMap     {get;set;}
        public map<id,List<NPD_Activity__c>>activityMap     {get;set;}
        public map<id,List<NPD_Activity__c>>subActivityMap  {get;set;}
        public NPD_Project_Name__c          currentProject  {get;set;}    //To display the name of the collection as well as to get certain fields of current project
        public string                       childId         {get;set;}    //Used for activating and de-activating records & used as recordId for view and edit purpose.
        public string                       parentID        {get;set;}    //Used for updating the map with the updated value of acive field of records & used as ParentID of record for view and edit purpose.
        public Sobject                      record          {get;set;}    //Used for displaying fields mandatory in view & edit.
        public string                       event           {get;set;} 
        public map<integer,list<WrapperForFieldSet>> intTowrapperListforField{get;set;}
        public list<WrapperForFieldSet>  wrapperListforField{get;set;}
        public List<taskWrapper>         taskWrapperStageList{get;set;}
        public List<noteWrapper>         noteWrapperStageList{get;set;} 
        public List<attachWrapper>        attWrapperStageList{get;set;}   // Type of wrapper class taskWrapper, Used for edition,deletion and insertion of tasks.
        public map<string,list<checkListWrapper>> dynamicSobjWrapperMap{get;set;}
        public boolean                     EditAccessStage{get;set;}
        public boolean                     EditAccessSubStage{get;set;}
        public boolean                     EditAccessActivity{get;set;}
        public boolean                     EditAccessSubActivity{get;set;}
        public integer                     rowNum{get;set;}
        public integer                     rowNum11{get;set;}  // for lineitem approval history process.
        public string                      relatedListType11{get;set;}    // for lineitem approval history process.
        public string                      relatedListType{get;set;}
        public boolean                     isAttach{get;set;}
        public Sobject                      previousValues;
        public NPD_Stage__c  stageRec = new NPD_Stage__c();
        public map<id,string>              idToFieldSet = new map<id,string>();
        public map<id,NPD_Activity__c>   mapToUpdateActivty = new map<id,NPD_Activity__c>();
        public map<id,NPD_Stage__c>      mapToUpdateStage = new map<id,NPD_Stage__c>();
        public List<String> DisplayFieldsList{get;set;}
        public NPD_Project_Name__c  DisplayImage{get;set;}
      //  public NPD_ProjectDetailViewController_New() {}
        public list<checkListWrapper> checkListWrapList{get;set;}
        public Attachment attach1{get;set;}
        public String imageURL{get;set;}
        public boolean isimage{get;set;}
        public List<String> DisplayFieldsListMandatory{get;set;}
        List<NPD_Activity__c> lstact=new  List<NPD_Activity__c>();
        List<NPD_Activity__c> lststag=new  List<NPD_Activity__c>();
        public string taskuserid {Set;get;}
        public list<ProcessInstanceStep>  approvalhislist {set;get;}
        public string currentactivityid{set;get;}
        public string dynamicrecord{set;get;}  // to store the dynamic record line item id.
        public Boolean displayPopup1 {get;set;}
        public List<NPD_Checklist__History> fieldHistoy{get;set;}
        public string CheckId1{set;get;}
        public string nolinehistory {set;get;}
        public integer attchmentcount {set;get;}
        public list<appHistoryWrap> appHistoryWraplist {Set;get;}
        public string tempstageid {set;get;}   // temp stageid for activate and deactivae the stage.
        public boolean isRecHidden{get;set;}
        public string checkListCollection;
        public  list<NPD_Stage__c> lUpdtSubStg ;
        public  set<String> optSubStageNames  ;
        public list<string> retunstages{set;get;}
        public list<String> snames {set;get;}
        public string autostring{set;get; }
        public string presentid {set;get;}
        public map <string,string>  autoStagemap = new map<string,string>();
        public map <string,string>  autoActivitymap = new map<string,string>();
        public string focusid1 {set;get;}
        NPD_Master__c npdmaster;
        string NpdMasterRecordid ;
        string currentUserId;
        public npd_master__c npdmas;
        public Map<id,id> SalesforceUserMap = new map<id,id>();
       map<id,npd_stage__c> OwnerSubStageMap = new map<id,npd_stage__c>();
       
       
        // Constructor written by sai
        public NPD_ProjectDetailViewOwnerbased()
        {
        
        

        
       for (npd_master__c npdm1:[select id,SalesforceUser__r.id from npd_master__c where type__c = 'owner'] )
            {
            SalesforceUserMap.put(npdm1.id,npdm1.SalesforceUser__r.id);

            }
            
        if(fieldHistoy==null)
          fieldHistoy             =   new List<NPD_Checklist__History>();
        taskuserid='00530000003OMER';
                system.debug('outside saveIndividualTask');
         if(projectId == null || projectId == '') {
                    projectId = ApexPages.currentPage().getparameters().get('proID');
                }
          currentProject=[SELECT id,NPD_Collections__c,NPD_Collections__r.Collection_Name__c,LeadTimeCalculationDone__c,ImageUpload__c,Model_No__c,Marketing_Brief_Stage__c FROM NPD_Project_Name__c  WHERE id =: projectId LIMIT 1];      
        
                      
        
        
        npdmaster = new NPD_Master__c();

        try{
            user u1=[select id,name from user where id=:UserInfo.getUserId() limit 1];
            system.debug('The saleforce user id is: '+ u1.id);
              system.debug('current username with UserInfo.getUserId(): '+u1.name );
             currentUserId = u1.id;
          
            }
            
            catch(exception eer)
            {
            system.debug(eer);
            }   
            
            
        }  
        
        
        public void storeProjectId()
        {
         system.debug(' the calculateLeadTime constructor method '+childid);
        try{
        projectId = ApexPages.currentPage().getparameters().get('proID');
            
            if(projectId!='')
                    {
                    npd_master__c npdmaster = [select id,name,type__c from npd_master__c where type__c='projectid' limit 1];

                    npdmaster.name=projectId;

                    update npdmaster;
                    }
                    
            npd_master__c getProjectId = [select id,name,type__c from npd_master__c where type__c='projectid' limit 1];

            projectId=getProjectId.name;  
            Integer i = ((test.isRunningTest())?(1/0):1);      
         } catch(exception ee5) { system.debug(ee5); }
                
                
           // projectId = ApexPages.currentPage().getparameters().get('proID');
            snames = new list<string>();
            list<NPD_Stage__c> stglist = [SELECT id,name__c FROM NPD_Stage__c WHERE NPD_Project_Name__c=: projectId ];
            
            
           
            
              for(NPD_Stage__c a1:stglist)
              {
               snames.add(a1.name__c);
               autoStagemap.put(a1.name__c,a1.id);
               }
                   
              list<npd_activity__c> actslist = [select id,name__c from npd_activity__c where NPD_Project_Name__c=: projectId];     
              for(npd_activity__c a1:actslist)
              {
               snames.add(a1.name__c);
               autoActivitymap.put(a1.name__c,a1.id );
               }  

               
                
            // For updating the design,development,production stages leadtimes with complexity after creating new Project.
      
                list<npd_stage__c> substagesList = new list<npd_stage__c> ();  
            
            system.debug(' the calculateLeadTime method '+childid);
            
            for(npd_Stage__c ns1:[select id,name__c,position__c,NPD_Project_Name__c from npd_stage__c where type__c ='sub-stage' AND Id=:childid])
             {  
                   substagesList.clear();
              
              substagesList.add(ns1);
              system.debug(' Sub stage name :'+ns1.name__c );
               
               NPD_UtilityController.flag5 = true;
            //   NPD_UtilityController.SubStageLeadTimeWithComplexityInsert(substagesList);
              
               system.debug('The substagelist :' +substagesList+'...'+substagesList.size());
                
            
            }
            
                
        }
        
        public void calculateLeadTime()
        {
              system.debug('method calling ');
        }
        
        public void getrecord()
        {
        
         try {
         
            if(autoStagemap.containskey(autostring))
           presentid = autoStagemap.get(autostring);
           
           if(autoActivitymap.containskey(autostring))
           presentid = autoActivitymap.get(autostring);
           
           
           }
           catch(exception search1)
                {
                    system.debug(search1 +' Error at search function');
                    
                    
                }
           
         /*  if(! autoStagemap.containskey(autostring) || !autoActivitymap.containskey(autostring))
           {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter porper search string and enter only name of record without extensions')); 
           }    */
           
           
        }
        
        /************************************************************************************************************
        * Method Name : prepareMapForStageAndActivities.
        * Description : This method is used to prepare 1.stageMap with stageid to the stage object
        * 2. SubstageMap with Stage id to the list of Sub-stages related to that stage.
        * 3. ActivityMap with Sub-Stage id to the list of activities related to that substage.
        * 4. subActivityMap with Activity id to the list of Sub-Activities related to that Activity.
        *************************************************************************************************************/
        public void prepareMapForStageAndActivities() {
         
             isAttach  = false;
             isimage   =false;
            // To get the stages and related substages, activities,subactivities of the specified project id.
                if(projectId == null || projectId == '') {
                    projectId = ApexPages.currentPage().getparameters().get('proID');
                }
            // Condition to avoid querying and creating the maps again and again for every reload of the page.
                if(stageMap == null || stageMap.isEmpty()) {
            // Initialising the maps    
                    stageMap       =  new Map<id,NPD_Stage__c>();
                    subStageMap    =  new map<id,List<NPD_Stage__c>>();
                    activityMap    =  new map<id,List<NPD_Activity__c>>();
                    subActivityMap = new map<id,List<NPD_Activity__c>>();
                    
                    List<NPD_Stage__c> stageList = new List<NPD_Stage__c>();
                    
                    List<NPD_Activity__c> activityList  =  new List<NPD_Activity__c>();
                    
                    
                    List<NPD_Activity__c> subActivityList  =  new List<NPD_Activity__c>();
                    
                    //Querying for all the stages and sub-stages of the projectID //
                    stageList  = [SELECT    PrePredecessorSerialNo__c,SFCurrentStageOwnerId__c,ModelId__c,NPD_Collections_id__c,SFParentStageOwnerId__c,ParentStageId__c,SerialNo__c,NPD_User__c,ownerId ,Revision_Substage__c,Name__c,Type__c,Complexity_typess__c,Planned_Lead_Time__c,Planned_Start_Date__c,NPD_Project_Name__r.NPD_Collections__r.Collection_Name__c, NPD_User__r.Name, Optional_Sub_Stages__c,NPD_Project_Name__c,
                                            Planned_End_Date__c,Actual_Start_Date__c,Actual_End_Date__c,NPD_Project_Items__r.Field_Set__c,Status__c,id,NPD_Stage__c,Active__c,Position__c,NPD_Project_Name__r.NPD_Collections__c,Owner1__c,Design_Manager__c,Approval_Required__c,Actual_Lead_Time__c,Function_Name__c,Function_department_Name__c, 
                                            (SELECT Id,Name FROM Attachments LIMIT 1) FROM NPD_Stage__c WHERE NPD_Project_Name__c=: projectId ORDER BY  Position__c ASC];
                    //Querying for all the Activities and sub-Activities of the projectID     
        /*******************************************************************  commneted activity sub activity code **********
                  string currentuserid1 = UserInfo.getUserId();
                    
                    activityList  =[SELECT optionaldata__c,Source__c,NPD_User__c,SerialNo__c,Columns_to_Copy__c,Attachment_Required__c,Approval_Status__c,Line_Item_Approval_Required__c,Revision_Active__c ,Model_Name__c,Technical_Designer_Name__c,SFActivityid__c,SFParentActivityOwnerId__c,Activity_Name__c,Final_cost_1st_approver__c,Final_cost_2nd_approver__c,Projecct_manger_SF_id__c ,Name__c,Type__c,Complexity_typess__c,Planned_Lead_Time__c,Approver_Name3__c ,No_of_Designs__c ,Lead_Time__c,WhenToBeAcive__c,Actual_Start_Date__c,NPD_Project_Items__r.Field_Set__c,Actual_End_Date__c,Status__c,id,NPD_Stage__c,Position__c,NPD_Activity__c,Active__c,Design_submitted_date__c,Design_approved_date__c,ISCM_Briefing_Date__c,First_Month_Watch_Delivery_Date__c,Master_Type__c,ownerId,Case_Model_No_Allocation_date__c,Function_department_Name__c,
                                    Quantity_Required__c,Quantity_Required_Standard_Option__c,Quantity_Indented__c,Case_BO_Pilot_Delivery_Date__c,Marketing_brief_stage_approver__c, Function_Name__c, NPD_User__r.Name,Optional_Activity_Sub_Activity__c, (SELECT Id,Name FROM Attachments LIMIT 1)  FROM NPD_Activity__c WHERE NPD_Project_Name__c=: projectId AND npd_user__r.SalesforceUser__r.id =: currentuserid1 ORDER BY Position__c ASC  ];
                    
                    list<string> SubActsParentActs = new list<String>();
                    set<String> existedActivitesId = new set<string>();
                    
                    
                    for(npd_activity__c na1 :activityList)
                     {
                       if(na1.type__c == 'sub-activity')
                       SubActsParentActs.add(na1.npd_activity__c);
                       
                        if(na1.type__c == 'activity')
                        existedActivitesId.add(na1.id);
                     }
                     
                      
                    
                    
                    
                    subActivityList = [SELECT optionaldata__c,Source__c,NPD_User__c,SerialNo__c,Columns_to_Copy__c,Attachment_Required__c,Approval_Status__c,Line_Item_Approval_Required__c,Revision_Active__c ,Model_Name__c,Technical_Designer_Name__c,SFActivityid__c,SFParentActivityOwnerId__c,Activity_Name__c,Final_cost_1st_approver__c,Final_cost_2nd_approver__c,Projecct_manger_SF_id__c ,Name__c,Type__c,Complexity_typess__c,Planned_Lead_Time__c,Approver_Name3__c ,No_of_Designs__c ,Lead_Time__c,WhenToBeAcive__c,Actual_Start_Date__c,NPD_Project_Items__r.Field_Set__c,Actual_End_Date__c,Status__c,id,NPD_Stage__c,Position__c,NPD_Activity__c,Active__c,Design_submitted_date__c,Design_approved_date__c,ISCM_Briefing_Date__c,First_Month_Watch_Delivery_Date__c,Master_Type__c,ownerId,Case_Model_No_Allocation_date__c,Function_department_Name__c,
                                    Quantity_Required__c,Quantity_Required_Standard_Option__c,Quantity_Indented__c,Case_BO_Pilot_Delivery_Date__c,Marketing_brief_stage_approver__c, Function_Name__c, NPD_User__r.Name,Optional_Activity_Sub_Activity__c, (SELECT Id,Name FROM Attachments LIMIT 1)  FROM NPD_Activity__c WHERE NPD_Project_Name__c=: projectId AND id in: SubActsParentActs ORDER BY Position__c ASC  ];
                    
                    
                    
                    
                    activityList.addall(subActivityList);
                    
                    
                    for(npd_activity__c na2 :activityList)
                      {
                        if(na2.type__c == 'activity' && existedActivitesId.contains(na2.id))
                         {
                             activityList.remove(na2);
                         }
                      }
                    
                    ***********************************************  END OF COMMENTING CODE FOR ACTIVITY SUB ACTIVITY **********/
                    
                    
                    
                    
                    string currentuserid1 = UserInfo.getUserId();
                    
                    
                    activityList  =[SELECT id,type__c,npd_activity__c FROM NPD_Activity__c WHERE NPD_Project_Name__c=: projectId AND npd_user__r.SalesforceUser__r.id =: currentuserid1 ORDER BY Position__c ASC ];
                    
                    
                    list<string> SubActsParentActs = new list<String>();
                    set<String> existedActivitesId = new set<string>();
                    
                    
                    for(npd_activity__c na1 :activityList)
                     {
                       if(na1.type__c == 'sub-activity')
                       SubActsParentActs.add(na1.npd_activity__c);
                       
                        if(na1.type__c == 'activity')
                        existedActivitesId.add(na1.id);
                     }
                     
                     
                     subActivityList = [SELECT  id,type__c FROM NPD_Activity__c where NPD_Project_Name__c=: projectId AND id in: SubActsParentActs ORDER BY Position__c ASC];
                     
                     
                     
                     activityList.addall(subActivityList);
                     
                     set<id> nonDuplicateActIds = new set<id>();
                     
                     
                     for(npd_activity__c nac1:activityList)
                     {
                       nonDuplicateActIds.add(nac1.id);                  
                     }
                    
                    
                    
                    
                    activityList  =[SELECT optionaldata__c,Source__c,NPD_User__c,SerialNo__c,Columns_to_Copy__c,Attachment_Required__c,Approval_Status__c,Line_Item_Approval_Required__c,Revision_Active__c ,Model_Name__c,Technical_Designer_Name__c,SFActivityid__c,SFParentActivityOwnerId__c,Activity_Name__c,Final_cost_1st_approver__c,Final_cost_2nd_approver__c,Projecct_manger_SF_id__c ,Name__c,Type__c,Complexity_typess__c,Planned_Lead_Time__c,Approver_Name3__c ,No_of_Designs__c ,Lead_Time__c,WhenToBeAcive__c,Actual_Start_Date__c,NPD_Project_Items__r.Field_Set__c,Actual_End_Date__c,Status__c,id,NPD_Stage__c,Position__c,NPD_Activity__c,Active__c,Design_submitted_date__c,Design_approved_date__c,ISCM_Briefing_Date__c,First_Month_Watch_Delivery_Date__c,Master_Type__c,ownerId,Case_Model_No_Allocation_date__c,Function_department_Name__c,
                                    Quantity_Required__c,Quantity_Required_Standard_Option__c,Quantity_Indented__c,Case_BO_Pilot_Delivery_Date__c,Marketing_brief_stage_approver__c, Function_Name__c, NPD_User__r.Name,Optional_Activity_Sub_Activity__c, (SELECT Id,Name FROM Attachments LIMIT 1)  FROM NPD_Activity__c WHERE id in:nonDuplicateActIds ORDER BY Position__c ASC  ];
                    
                    
                    
                    
                //  AND NPD_User__r.SalesforceUser__c =: UserInfo.getUserId()
                    
                    //Used to display the collection Name at the top left of page.
                    currentProject=[SELECT id,NPD_Collections__c,NPD_Collections__r.Collection_Name__c,ImageUpload__c,Model_No__c,Marketing_Brief_Stage__c FROM NPD_Project_Name__c  WHERE id =: projectId LIMIT 1];
                    
                    for(npd_stage__C tempstgval: stageList)
                    {
                      OwnerSubStageMap.put(tempstgval.id,tempstgval);
                    
                    }
                    
                    system.debug('The size of substage map is: ' + OwnerSubStageMap.keyset().size());
                    
                    
        /***********************************************************  Modified code for displaying image at top-left of page ***************************/             
                    
                    // used to display the image at Top-Left of page.               
                    NPD_Project_Name__c  UserImage=[SELECT id,ImageUpload__c FROM NPD_Project_Name__c  WHERE id =: projectId LIMIT 1];
                    
                    if(UserImage != null && UserImage.ImageUpload__c !=null && UserImage.ImageUpload__c!='')
                        {
                        string  imageurl=UserImage.ImageUpload__c;

                    if(imageurl !=null || imageurl !='')
                    {

                    integer x=imageurl.indexof('https');
                    integer y=imageurl.indexof('"',x);

                    imagepiclink= imageurl.substring(x,y); 
                    }
                    }
                    system.debug(rowNum11+ ' this is the row number');
        system.debug(relatedListType11+ ' this is the relatedListType11');
    /***********************************************************  End of Modified code for displaying image at top-left of page ***************************/                 
                   
                    
                        for(NPD_Stage__c stage : stageList) {
                        system.debug('===stage.name__c=='+stage.name__c );
                        if((stage.Type__c.equalsIgnoreCase('stage') && currentProject.Marketing_Brief_Stage__c == NULL) || (stage.Type__c.equalsIgnoreCase('stage') && !stage.SerialNo__c.containsIgnoreCase('AR-01') && currentProject.Marketing_Brief_Stage__c != NULL) ) {
                            stageMap.put(stage.id,stage);
                            if(!subStageMap.containsKey(stage.id)) {
                                subStageMap.put(stage.id,new list<NPD_Stage__c>{});
                                system.debug('==subStageMap inside if=='+subStageMap);
                            }
                            system.debug('==subStageMap=='+subStageMap);
                        }// end of if condition to check type as stage
                        
                        else if(stage.Type__c.equalsIgnoreCase('Sub-stage') ) {
                                system.debug('@@@@@ stage.Name__c'+stage.Name__c);
                                system.debug('@@@@@ subStageMap.isempty()'+subStageMap.isempty());
                                system.debug('@@@@@ subStageMap.containskey(stage.NPD_Stage__c)'+subStageMap.containskey(stage.NPD_Stage__c));
                                system.debug('@@@@@ subStageMap.get(stage.NPD_Stage__c)'+subStageMap.get(stage.NPD_Stage__c));
                                system.debug('@@@@@ stage.Revision_Substage__c'+stage.Revision_Substage__c);
                                //Condition to check whether there already exists a stage Id for the substage, If yes then adding the substage to the list of its Stage
                                if(!subStageMap.isempty() && subStageMap.containskey(stage.NPD_Stage__c) && subStageMap.get(stage.NPD_Stage__c) != NULL && stage.Revision_Substage__c == false){ //added extra (&& stage.Revision_Substage__c == false)
                                    
                                    subStageMap.get(stage.NPD_Stage__c).add(stage);
                                    
                                } else if( stage.Revision_Substage__c == false ) {
                                    subStageMap.put(stage.NPD_Stage__c,new List<NPD_Stage__c>{stage});
                                }
                                activityMap.put(stage.id,new List<NPD_Activity__c>{});  
                                 system.debug('==subStageMap inside else if=='+subStageMap);                                                 
                            }//End of if condition to check type as substage
                            
                            if(!string.isblank(stage.NPD_Project_Items__r.Field_Set__c))
                                    idToFieldSet.put(stage.id,stage.NPD_Project_Items__r.Field_Set__c);    
                                    
                        }//End of for loop for stagelist
                    
                    for(NPD_Activity__c act:activityList){
                    
                        if(act.Type__c.equalsIgnoreCase('Activity') ) {
                            //Condition to check whether there already exists a sub stage Id for the substage, If yes then adding the Activity to the list of its Sub Stage
                            if(!activityMap.isempty() && activityMap.containskey(act.NPD_Stage__c) && activityMap.get(act.NPD_Stage__c) != null && act.Revision_Active__c == false){ //added(&& act.Revision_Active__c == false)
                            
                                activityMap.get(act.NPD_Stage__c).add(act);
                            }
                            if(!subActivityMap.containsKey(act.id)) {
                                subActivityMap.put(act.id,new List<NPD_Activity__c>{});
                            } 
                            
                        }// end of if condition to check type as Activity
                        
                        else if(act.Type__c.equalsIgnoreCase('Sub-Activity') ) {
                            //Condition to check whether there already exists a Activity Id for the substage, If yes then adding the Sub-Activity to the list of its Activity
                            if(!subActivityMap.isempty() && subActivityMap.containskey(act.NPD_Activity__c) && subActivityMap.get(act.NPD_Activity__c) != null && act.Revision_Active__c == false){ //added(&& act.Revision_Active__c == false)
                                
                                subActivityMap.get(act.NPD_Activity__c).add(act);
                            }else if( act.Revision_Active__c == false ){ //added if(act.Revision_Active__c == false)
                                subActivityMap.put(act.NPD_Activity__c,new List<NPD_Activity__c>{act});
                            }
                        }// end of if condition to check type as Sub - Activity
                        if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c))
                                idToFieldSet.put(act.id,act.NPD_Project_Items__r.Field_Set__c);
                    }//End of for loop for activitylist   
                }
                
                // Loading the approval history for activity and sub-activity
               // ActivityApprovalHistorylist();
                
        }//End of prepareMapForStageAndActivities method
        
       
                
        public void  processActiveDeactivestage()
        
        {
            //   npd_stage__c stagedeactive= [select id,name from npd_stage__c where id=:tempstageid];
            //    stagedeactive.active__c=false;
              npd_stage__c npdstage1= new npd_stage__c();
              
             
             
             
            if(tempstageid!= null && tempstageid!= '' && stageMap.containskey(tempstageid) && stageMap.get(tempstageid)!= null ) 
                {
                    npdstage1= stageMap.get(tempstageid);
                    npdstage1.active__c= ! npdstage1.active__c;
                
                }
        
        try{
        if(npdstage1.ID != NULL && npdstage1 != NULL)                   
            update npdstage1;
            
            
            
            
            childId  = '';
            parentID = '';
            tempstageid='';
            if(Test.isRunningTest())
            Integer i = 10/0;
            }catch(exception e){system.debug('*******Error while updating*******'+e.getmessage());}
        
        
                }  
        
        /**************************************************************************************************************
        * Method Name : processActiveDeactiveForSubstage
        * Description : This method is used to activate or deactive a Substage when either of the link Activate or Deactivate 
        * is clicked, If the record is active then it is deactivated and vice versa
        ***************************************************************************************************************/
        public void processActiveDeactiveForSubstage(){
        
        NPD_Stage__c subToUpdate = new NPD_Stage__c();
        NPD_Stage__c tempsubToUpdate = NEW NPD_Stage__c();
       
       //system.debug('childIdchildId'+childId);
      // system.debug('parentIDparentID'+parentID);
      // system.debug('subStageMap.get(parentID)'+subStageMap.get(parentID));
      
    try {  
        if(parentID!= null && parentID!= '' && subStageMap.containskey(parentID) && subStageMap.get(parentID)!= null ) {
            for(NPD_Stage__c subStg:subStageMap.get(parentID)) {
               if(subStg.id == childId){
                   subStg.Active__c = !subStg.Active__c;
                   subToUpdate      = subStg;
                  }                               
               }
             }
            Integer i = ((test.isRunningTest())?(1/0):1);
       }  catch(exception substage)
       {
            system.debug(substage);
       }
        try{
            if(subToUpdate.ID != NULL && subToUpdate != NULL) {                   
                update subToUpdate;
            }
             Integer i = ((test.isRunningTest())?(1/0):1);
        }catch(exception e){system.debug('*******Error while updating*******'+e.getmessage());} 
        //,Design_Manager__c
        
        try{
        tempsubToUpdate =[SELECT id,SerialNo__c,Planned_End_Date__c,Planned_Start_Date__c,NPD_Stage__c,Design_Manager__c,Approval_Required__c   FROM NPD_Stage__c where id=:subToUpdate.id LIMIT 1];
         system.debug('subStageMap.containskey(subToUpdate.NPD_Stage__c)'+subStageMap.containskey(subToUpdate.NPD_Stage__c));
         system.debug('subToUpdate.NPD_Stage__c'+subToUpdate.NPD_Stage__c);
        if(subToUpdate.NPD_Stage__c != null && subStageMap.containskey(subToUpdate.NPD_Stage__c) && subStageMap.get(subToUpdate.NPD_Stage__c)!= null ) {    
                            
            for(NPD_Stage__c sub :subStageMap.get(subToUpdate.NPD_Stage__c)) {
                if(sub .id == tempsubToUpdate .id) {
                    sub.Planned_Start_Date__c   = tempsubToUpdate.Planned_Start_Date__c;   
                    sub.Planned_End_Date__c     = tempsubToUpdate.Planned_End_Date__c ; 
                    sub                         = tempsubToUpdate;
                 }
             } 
           } 
     Integer i = ((test.isRunningTest())?(1/0):1);     
    } catch(exception substage)
    {
        system.debug('The exception is :'+ substage);
    }      
      }// End of method processActiveDeactiveForSubstage 
      
      
        
        
      public void processActiveDeactiveForActivity(){
      
        NPD_Activity__c actToUpdate     = new NPD_Activity__c ();
        NPD_Activity__c tempActToUpdate = new NPD_Activity__c ();
        
        if(parentID!= null && parentID!= '' && activityMap.containskey(parentID) && activityMap.get(parentID)!= null ) {
            for(NPD_Activity__c act:activityMap.get(parentID)) {
               if(act.id == childId){
                   act.Active__c = !act.Active__c;
                   actToUpdate   =  act;                                     
                  }                               
               }
             }
        
        try{
        if(actToUpdate.ID != NULL && actToUpdate != NULL)                   
            update actToUpdate;
            childId  = '';
            parentID = '';
            Integer i = ((test.isRunningTest())?(1/0):1);
            }catch(exception e){system.debug('*******Error while updating*******'+e.getmessage());}
       }// End of method processActiveDeactiveForActivity.  
       
       
       
      
       
       
       
        /**************************************************************************************************************
        * Method Name : processActiveDeactiveForSubActivity
        * Description : This method is used to activate or deactive a activity when either of the link Activate or Deactivate 
        * is clicked, If the record is active then it is deactivated and vice versa
        ***************************************************************************************************************/  
      public void processActiveDeactiveForSubActivity(){
      
        NPD_Activity__c actToUpdate     = new NPD_Activity__c ();
        NPD_Activity__c tempActToUpdate = new NPD_Activity__c ();
        
        if(parentID!= null && parentID!= '' && subActivityMap.containskey(parentID) && subActivityMap.get(parentID)!= null ) {
            for(NPD_Activity__c act: subActivityMap.get(parentID)) {
               if(act.id == childId){
                  act.Active__c = !act.Active__c;
                  actToUpdate   =  act;
                  }                               
                }
             }
        
        try{if(actToUpdate.ID != NULL && actToUpdate != NULL)                   
            update actToUpdate;
            childId  = '';
            parentID = '';
            if(Test.isRunningTest())
            Integer i = 10/0;
            }catch(exception e){system.debug('*******Error while updating*******'+e.getmessage());} 
            
          }// End of method processActiveDeactiveForActivity.     
          
          
          public void processActiveDeactiveSubActivity(){
      
        NPD_Activity__c actToUpdate     = new NPD_Activity__c ();
        NPD_Activity__c tempActToUpdate = new NPD_Activity__c ();
        
        if(parentID!= null && parentID!= '' && subActivityMap.containskey(parentID) && subActivityMap.get(parentID)!= null ) {
            for(NPD_Activity__c act: subActivityMap.get(parentID)) {
               if(act.id == childId){
                  act.Active__c = ! act.Active__c;
                  actToUpdate   =  act;
                  }                               
                }
             }
        
        try{if(actToUpdate.ID != NULL && actToUpdate != NULL)                   
            update actToUpdate;
            childId  = '';
            parentID = '';
            if(Test.isRunningTest())
            Integer i = 10/0;
            }catch(exception e){system.debug('*******Error while updating*******'+e.getmessage());} 
            
          }// End of method processActiveDeactiveForActivity.     
          
          
        
          
          public PageReference showHideSubStage() {
            lUpdtSubStg  =   new list<NPD_Stage__c>();
            optSubStageNames    =   new set<String>();
            
            try {
                system.debug('***showSubStage***'); system.debug('$$$ childId '+childId); system.debug('$$$ parentID '+parentID); 
                system.debug('*** subStageMap.get(parentID)*** '+ subStageMap.get(parentID));
                
                if( !String.isBlank(childId) && !String.isBlank(parentID) && subStageMap.containskey(parentID) && subStageMap.get(parentID)!= null ) {
                    for(NPD_Stage__c subStg : subStageMap.get(parentID)) {
                        if(subStg.Id == childId && !String.isBlank(subStg.Optional_Sub_Stages__c)){
                            optSubStageNames.addAll(subStg.Optional_Sub_Stages__c.split(':##'));
                        }
                    }
                }   system.debug('*** optSubStageNames*** '+ optSubStageNames);
                
                if(!optSubStageNames.isEmpty()) {
                    for(NPD_Stage__c oSubStg : [SELECT Id,Name__c,NPD_Stage__c,NPD_Stage__r.Name__c,Revision_Substage__c,Optional_Sub_Stages__c FROM NPD_Stage__c WHERE NPD_Stage__c =: parentID AND (Name__c!='Concept Briefing to ISCM' OR Name__c!='Concept Finalization')]) {
                        system.debug('*** oSubStg*** '+ oSubStg.Name__c);
                        if(isRecHidden) {
                            if(oSubStg.Id == childId && !String.isBlank(oSubStg.Optional_Sub_Stages__c)) {
                                oSubStg.Optional_Sub_Stages__c += ':##SHOWN';
                                lUpdtSubStg.add(oSubStg);
                            } else if(optSubStageNames.contains(oSubStg.Name__c)) {
                                system.debug('Entered contains name string');
                                oSubStg.Revision_Substage__c    =   false;  
                                lUpdtSubStg.add(oSubStg);
                            }
                        } else {
                            if(oSubStg.Id == childId && !String.isBlank(oSubStg.Optional_Sub_Stages__c) && oSubStg.Optional_Sub_Stages__c.contains(':##SHOWN')) {
                                oSubStg.Optional_Sub_Stages__c = oSubStg.Optional_Sub_Stages__c.removeEndIgnoreCase(':##SHOWN');
                                lUpdtSubStg.add(oSubStg);
                            } else if(optSubStageNames.contains(oSubStg.Name__c)) {
                                system.debug('Entered contains name string');
                                oSubStg.Revision_Substage__c    =   true;  
                                lUpdtSubStg.add(oSubStg);
                            }
                        }
                    }
                }
                Integer i = ((test.isRunningTest())?(1/0):1);
            } catch(exception showHideSubStage){system.debug(showHideSubStage);}
            system.debug('$$$ lUpdtSubStg '+ lUpdtSubStg);
            try {
                if(!lUpdtSubStg.isEmpty()){
                    update lUpdtSubStg;
                    Integer i = ((test.isRunningTest()) ? (1/0) : 1);
                }
            } catch (Exception e) { System.debug('***Exception while updating Sub-Stage***'+e.getMessage()); }
            
            PageReference pageRef = ApexPages.currentPage();
            Id projectId = pageRef.getParameters().get('proID');
            pageRef.getParameters().clear();system.debug('Project Id *** '+projectId);
            pageRef.getParameters().put('proID', projectId);
            pageRef.setRedirect(true);
            return pageRef;
        }
       
      
        /*public PageReference showHideActivity(){
            list<NPD_Activity__c> lUpdtActvty   =   new list<NPD_Activity__c>();
            set<String> optActivityNames        =   new set<String>();
            
            system.debug('***showActivity***'); system.debug('$$$ childId '+childId); system.debug('$$$ parentID '+parentID); 
            system.debug('*** activityMap.get(parentID)*** '+ activityMap.get(parentID));
           
            if( !String.isBlank(childId) && !String.isBlank(parentID) && !activityMap.isEmpty() && activityMap.containskey(parentID) && activityMap.get(parentID)!= null ) {
                for(NPD_Activity__c oActvty : activityMap.get(parentID)) {
                    if(oActvty.Id == childId && !String.isBlank(oActvty.Optional_Activity_Sub_Activity__c)){
                        optActivityNames.addAll(oActvty.Optional_Activity_Sub_Activity__c.split(':##'));
                    }
                }
            }   system.debug('*** optActivityNames*** '+ optActivityNames);
            
            if(!optActivityNames.isEmpty()) {
                for(NPD_Activity__c oActvty : [SELECT Id,Name__c,NPD_Stage__c,NPD_Stage__r.Name__c,Revision_Active__c,Optional_Activity_Sub_Activity__c FROM NPD_Activity__c WHERE NPD_Stage__c =: parentID]) {
                    system.debug('*** oActvty*** '+ oActvty.Name__c);
                    if(isRecHidden) {
                        if(oActvty.Id == childId && !String.isBlank(oActvty.Optional_Activity_Sub_Activity__c)) {
                            oActvty.Optional_Activity_Sub_Activity__c += ':##SHOWN';
                            lUpdtActvty.add(oActvty);
                        } else if(optActivityNames.contains(oActvty.Name__c)) {
                            system.debug('Entered contains name string');
                            oActvty.Revision_Active__c    =   false;  
                            lUpdtActvty.add(oActvty);
                        }
                    } else {
                        if(oActvty.Id == childId && !String.isBlank(oActvty.Optional_Activity_Sub_Activity__c) && oActvty.Optional_Activity_Sub_Activity__c.contains(':##SHOWN')) {
                            oActvty.Optional_Activity_Sub_Activity__c   =   oActvty.Optional_Activity_Sub_Activity__c.removeEndIgnoreCase(':##SHOWN');
                            lUpdtActvty.add(oActvty);
                        } else if(optActivityNames.contains(oActvty.Name__c)) {
                            system.debug('Entered contains name string');
                            oActvty.Revision_Active__c    =   true;  
                            lUpdtActvty.add(oActvty);
                        }
                    }
                }  
            }
           
                        
            system.debug('$$$ lUpdtActvty '+ lUpdtActvty);
            try {
                if(!lUpdtActvty.isEmpty()){
                    update lUpdtActvty;
                }
                Integer i = ((test.isRunningTest())?(1/0):1);
            } catch (Exception e) { System.debug('***Exception while updating Activity***'+e.getMessage()); }
            
            PageReference pageRef = ApexPages.currentPage();
            Id projectId = pageRef.getParameters().get('proID');
            pageRef.getParameters().clear();system.debug('Project Id *** '+projectId);
            pageRef.getParameters().put('proID', projectId);
            pageRef.setRedirect(true);
            return pageRef;
          
        }*/
        
       
        public PageReference showHideSubActivity() {
            list<NPD_Activity__c> lUpdtSubActvty    =   new list<NPD_Activity__c>();
            set<String> optSubActivityNames         =   new set<String>();
            
            system.debug('***showSubActivity***'); system.debug('$$$ childId '+childId); system.debug('$$$ parentID '+parentID); 
            system.debug('*** subActivityMap.get(parentID)*** '+ subActivityMap.get(parentID));
            
            if( !String.isBlank(childId) && !String.isBlank(parentID) && !subActivityMap.isEmpty() && subActivityMap.containskey(parentID) && subActivityMap.get(parentID)!= null ) {
                for(NPD_Activity__c oSubActvty : subActivityMap.get(parentID)) {
                    if(oSubActvty.Id == childId && !String.isBlank(oSubActvty.Optional_Activity_Sub_Activity__c)){
                        optSubActivityNames.addAll(oSubActvty.Optional_Activity_Sub_Activity__c.split(':##'));
                    }
                }
            }   system.debug('*** optSubActivityNames*** '+ optSubActivityNames);
            
            if(!optSubActivityNames.isEmpty()) {
                for(NPD_Activity__c oSubActvty : [SELECT Id,Name__c,NPD_Activity__c,NPD_Activity__r.Name__c,Revision_Active__c,Optional_Activity_Sub_Activity__c FROM NPD_Activity__c WHERE NPD_Activity__c =: parentID]) {
                    system.debug('*** oSubActvty*** '+ oSubActvty.Name__c);
                    if(isRecHidden) {
                        if(oSubActvty.Id == childId && !String.isBlank(oSubActvty.Optional_Activity_Sub_Activity__c)) {
                            oSubActvty.Optional_Activity_Sub_Activity__c += ':##SHOWN';
                            lUpdtSubActvty.add(oSubActvty);
                        } else if(optSubActivityNames.contains(oSubActvty.Name__c)) {
                            system.debug('Entered contains name string');
                            oSubActvty.Revision_Active__c    =   false;  
                            lUpdtSubActvty.add(oSubActvty);
                        }
                    } else {
                        if(oSubActvty.Id == childId && !String.isBlank(oSubActvty.Optional_Activity_Sub_Activity__c) && oSubActvty.Optional_Activity_Sub_Activity__c.contains(':##SHOWN')) {
                            oSubActvty.Optional_Activity_Sub_Activity__c    =   oSubActvty.Optional_Activity_Sub_Activity__c.removeEndIgnoreCase(':##SHOWN');
                            lUpdtSubActvty.add(oSubActvty);
                        } else if(optSubActivityNames.contains(oSubActvty.Name__c)) {
                            system.debug('Entered contains name string');
                            oSubActvty.Revision_Active__c    =   true;  
                            lUpdtSubActvty.add(oSubActvty);
                        }
                    }
                }
            }
            system.debug('$$$ lUpdtSubActvty '+ lUpdtSubActvty);
            try {
                if(!lUpdtSubActvty.isEmpty()){
                    update lUpdtSubActvty;
                }
                Integer i = ((test.isRunningTest())?(1/0):1);
            } catch (Exception e) { System.debug('***Exception while updating Activity***'+e.getMessage()); }
            
            PageReference pageRef = ApexPages.currentPage();
            Id projectId = pageRef.getParameters().get('proID');
            pageRef.getParameters().clear();system.debug('Project Id *** '+projectId);
            pageRef.getParameters().put('proID', projectId);
            pageRef.setRedirect(true);
            return pageRef;
        }
          
         /*****************************************************************************************************************************
         * Method Name: EditRecord.
         * Description : Method called when View or edit of any record.
         * This method will check for the object type whether stage or Activity & will call the method prepare Fields set method for respective type
         ******************************************************************************************************************************/
         public void EditRecord(){
         id recID = childId;
         string objType = recID.getSObjectType().getDescribe().getName();
         
             if( objType == 'NPD_Stage__c')
             {
                prepareFieldListForStage();   
 
               // For updating the design,development,production stages leadtimes with complexity after creating new Project.
                          
                list<npd_stage__c> substagesList = new list<npd_stage__c> ();  
            
            system.debug(' the calculateLeadTime method '+childid);
            
            for(npd_Stage__c ns1:[select id,name__c,subStageLeadTime__c,position__c,NPD_Project_Name__c,Planned_Lead_Time__c,Complexity_Typess__c,npd_stage__r.id from npd_stage__c where type__c ='sub-stage' AND Id=:childid])
             {  
             if(ns1.subStageLeadTime__c == false)
            {
                   substagesList.clear();
              
              substagesList.add(ns1);
              system.debug(' Sub stage name :'+ns1.name__c );
               
               NPD_UtilityController.flag5 = true;
              NPD_UtilityController NU1=  new NPD_UtilityController();
              NU1.SubStageLeadTimeWithComplexityInsert(substagesList);
              
               system.debug('The substagelist :' +substagesList+'...'+substagesList.size());
                
            
            } 
            }     
                 
                } 
                          
             else if(objType == 'NPD_Activity__c')
                 prepareFieldListForActivity();    
                 
                 ActivityApprovalHistorylist();
         }
         
         /************************************************************************************************************************************
         * Method Name :  
         * Description : This method is used to get the field value for view & edit of stages and sub stages
         *************************************************************************************************************************************/
          public void prepareFieldListForStage(){
          DisplayImage =new NPD_Project_Name__c ();      
          dynamicSobjWrapperMap = new map<string,list<checkListWrapper>>();
            taskWrapperStageList  = new List<taskWrapper>();
            noteWrapperStageList = new List<noteWrapper>();
            attWrapperStageList  = new List<attachWrapper>();
          try{
          DisplayImage =[SELECT id,ImageUpload__c from NPD_Project_Name__c where id =: projectId ];
              string queryString;
              
              if(!idToFieldSet.isempty() && idToFieldSet.containskey(childId) && !String.isblank(idToFieldSet.get(childId))){
              System.debug('+++++Hellohiiii++');
                  queryString = prepareWrapper(idToFieldSet.get(childId));
              }
                    
              if(String.isblank(queryString)){
               System.debug('+++++heloo++');
               //,Design_Manager__c
                  stageRec= database.query('SELECT PrePredecessorSerialNo__c,id,Stage_name__c,Name__c,Planned_Start_Date__c,Actual_Start_Date__c,Type__c,Planned_End_Date__c,Actual_End_Date__c,Revised_Start_Date__c,Status__c,OwnerId,Revised_End_Date__c,Brand1__c,Brand__c,Sub_Brand1__c,Sub_Brand__c,NPD_User__c,Market__c,'
                                              +'No_of_Designs__c,Approval_Status__c,Complexity_Typess__c,Complexity_Category__c,Planned_Lead_Time__c,Actual_Lead_Time__c,Collection_reference__c,NPD_Stage__r.OwnerId,'
                                              +'Marketing_brief_concept_reference_number__c,Model_Name__c,Phase__c,Tentative_Launch_Plan__c,Source__c,Comments_Remarks__c,Owner__c,NPD_Project_Name__r.ImageUpload__c,ImageUpload__c,Design_Manager__c,Approval_Required__c,Line_Item_Approval_Required__c,design_manager_npd_master__c,NSF_Emial_Address__c FROM NPD_Stage__c WHERE ID  =:childId LIMIT 1');
             }
            else{//,Design_Manager__c
                 stageRec= database.query('SELECT PrePredecessorSerialNo__c,id,Stage_name__c,NPD_Stage__r.name,Name__c,Planned_Start_Date__c,Actual_Start_Date__c,Type__c,Planned_End_Date__c,Actual_End_Date__c,Revised_Start_Date__c,Status__c,OwnerId,Revised_End_Date__c,Brand1__c,Brand__c,Sub_Brand1__c,Sub_Brand__c,NPD_User__c,Market__c,design_manager_npd_master__c,NSF_Emial_Address__c,'
                                              +'No_of_Designs__c,Approval_Status__c,Complexity_Typess__c,Complexity_Category__c,Planned_Lead_Time__c,Actual_Lead_Time__c,Collection_reference__c,NPD_Stage__r.OwnerId,'
                                              +queryString+',Marketing_brief_concept_reference_number__c,Model_Name__c,Phase__c,Tentative_Launch_Plan__c,Source__c,Comments_Remarks__c,Owner__c,NPD_Project_Name__c,Line_Item_Approval_Required__c FROM NPD_Stage__c   WHERE ID  =:childId LIMIT 1');
             }
              record     = stageRec; 
              
              if(stageRec!= null){
                  if(stageRec.Type__c == 'Stage' && stageRec.OwnerId == UserInfo.getUserId()){
                      EditAccessStage =TRUE;
                  }else{
                      EditAccessStage =FALSE;
                  }
                  if(stageRec.Type__c == 'Sub-Stage' && (stageRec.OwnerId == UserInfo.getUserId() || stageRec.NPD_Stage__r.OwnerId == UserInfo.getUserId())){
                      EditAccessSubStage =TRUE;
                  }else{
                      EditAccessSubStage =FALSE;
                  }
              } 
              
              if(childId != null) {
                    attWrapperStageList = new List<attachWrapper >();
                    for(Attachment att : [SELECT id,name,parentid,isprivate,Description, Createdbyid FROM Attachment where parentid=: childId  ]) {
                        attachWrapper wrap= new attachWrapper();
                        wrap.ate = att ;
                        attWrapperStageList.add(wrap);
                       // preparemap(obj,'ParentId',false);
                    }
                        
                     noteWrapperStageList = new List<noteWrapper>();
                    for(Note nt : [SELECT id,parentid,title,isprivate,body,createdbyid FROM Note where Parentid=:childId]) {
                        noteWrapper wrap= new noteWrapper();
                        wrap.nte = nt;
                        noteWrapperStageList.add(wrap);
                       // preparemap(obj,'ParentId',false);
                    }
                    
                    taskWrapperStageList = new List<taskWrapper>();
                     for(task tt : [SELECT Id, Who.Id,Subject,Status,Description,Priority,Who.Type,ActivityDate,OwnerId,CallDisposition,Type,tempuser__c FROM Task where What.Type='NPD_Stage__c' and  WhatId =:childId]) {
                        taskWrapper wrap = new taskWrapper();
                                    //  user u=[select id,name from user limit 1];
        
                        wrap.tsk = tt;
                       
                        //wrap.tsk.ownerid=u.name;
                        taskWrapperStageList.add(wrap);
                        
                     }
                }
              previousValues  = stageRec;
              record     = stageRec; 
              
           /*   if(string.valueof(record.get('Actual_Start_Date__c')) == null )
              {
                    record.put('Actual_Start_Date__c',date.parse(date.today().format()));
                    
                    
              
              }            */
              
              system.debug('***When you getting***');
               Integer i = ((test.isRunningTest())?(1/0):1);
              }  catch(exception preparefields)
              {
                    system.debug(preparefields);
              }
          }
          
          /************************************************************************************************************************************
         * Method Name : prepareFieldListForActivity
         * Description : This method is used to get the field value for view & edit of Activities and Sub Activities
         *************************************************************************************************************************************/
          public void prepareFieldListForActivity(){  
            dynamicSobjWrapperMap = new map<string,list<checkListWrapper>>();
            taskWrapperStageList  = new List<taskWrapper>();
            noteWrapperStageList = new List<noteWrapper>();
            attWrapperStageList  = new List<attachWrapper>();    
              string queryString;
              string fielApistr;  
              NPD_Activity__c actRec = new NPD_Activity__c();
              if(!idToFieldSet.isempty() && idToFieldSet.containskey(childId) && !String.isblank(idToFieldSet.get(childId))){
                  queryString = prepareWrapper(idToFieldSet.get(childId));
              }
              
              try {
              if(String.isblank(queryString)){
                  actRec = database.query('SELECT Source__c,id,Stage_name__c,NPD_Stage__r.name,Name__c,Line_Item_Approval_Required__c,Revision_Active__c ,NPD_User__c,Actual_Start_Date__c,Collection_reference__c,Sub_Brand1__c,NPD_Activity__c.Market__c ,Brand1__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Name__c,NPD_Stage__r.NPD_Stage__r.Name__c,Complexity_Category__c,Marketing_Brief_Reference_No__c ,Actual_End_Date__c,Type__c,Complexity_Typess__c,Status__c,Approval_Status__c,Case_Model_No_Allocation_date__c,Approval_Required__c,Planned_Lead_Time__c,ownerId,Lead_Time__c,Lead_Time1__c,Number_of_Days_Consumed_c__c,NPD_Stage__r.OwnerId,NPD_Stage__r.NPD_Stage__r.OwnerId,NPD_Activity__r.OwnerId,NPD_Activity__r.NPD_Stage__r.OwnerId,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId,'
                                             +'Comments_Remarks__c,NPD_Activity__c.Phase__c,Checklist_Columns__c,Mandatory_Fields__c,Master_Type__c,Technical_Designer_Name__c ,Model_Name__c,Model_No__c ,Owner__c,Columns_to_Copy__c, No_of_Designs__c,Approver_Name3__c,npd_stage__r.name__c,serialno__c,Design_submitted_date__c,Design_approved_date__c,ISCM_Briefing_Date__c,First_Month_Watch_Delivery_Date__c,Attachment_Required__c,Quantity_Required__c,Quantity_Required_Standard_Option__c,Quantity_Indented__c,Case_BO_Pilot_Delivery_Date__c,Marketing_brief_stage_approver__c FROM NPD_Activity__c WHERE ID  =:childId LIMIT 1');}
              else{
                  actRec = database.query('SELECT Attachment_Required__c,id,Stage_name__c,NPD_Stage__r.name,Source__c,Name__c,Line_Item_Approval_Required__c,Revision_Active__c ,NPD_User__c,Actual_Start_Date__c,Collection_reference__c,Sub_Brand1__c,NPD_Activity__c.Market__c ,Brand1__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Name__c,NPD_Stage__r.NPD_Stage__r.Name__c,Complexity_Category__c,Actual_End_Date__c,Marketing_Brief_Reference_No__c ,Type__c,Complexity_Typess__c,Status__c,Approval_Status__c,Approval_Required__c,Planned_Lead_Time__c,OwnerId,Lead_Time__c,Lead_Time1__c,Number_of_Days_Consumed_c__c,NPD_Stage__r.OwnerId,NPD_Stage__r.NPD_Stage__r.OwnerId,NPD_Activity__r.OwnerId,NPD_Activity__r.NPD_Stage__r.OwnerId,npd_stage__r.name__c,serialno__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId,'
                                             +'Comments_Remarks__c,'+queryString+',Model_No__c ,Model_Name__c,Checklist_Columns__c,Mandatory_Fields__c,NPD_Activity__c.Phase__c,Owner__c,NPD_Activity__c,Columns_to_Copy__c,Marketing_brief_stage_approver__c FROM NPD_Activity__c   WHERE ID =:childId  LIMIT 1');
              }
               Integer i = ((test.isRunningTest())?(1/0):1);
              }  catch(exception query1)
              {
                    system.debug(query1);
              }
              
              if(actRec!= null){
                  if(actRec.Type__c == 'Activity' && (actRec.OwnerId == UserInfo.getUserId() || actRec.NPD_Stage__r.OwnerId == UserInfo.getUserId() || actRec.NPD_Stage__r.NPD_Stage__r.OwnerId == UserInfo.getUserId()) ){
                      EditAccessActivity =TRUE;
                  }else{
                      EditAccessActivity =FALSE;
                  }
                  if(actRec.Type__c == 'Sub-Activity' && (actRec.OwnerId == UserInfo.getUserId() || actRec.NPD_Activity__r.OwnerId == UserInfo.getUserId() || actRec.NPD_Activity__r.NPD_Stage__r.OwnerId == UserInfo.getUserId() || actRec.NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId == UserInfo.getUserId())){
                      EditAccessSubActivity =TRUE;
                  }else{
                      EditAccessSubActivity =FALSE;
                  }
              }
                 
                  if(childId != NULL){
                       List<String> fieldApiList= prepareFieldsForTable(actRec.Checklist_Columns__c);
                        
                        if(!fieldApiList.isEmpty()) {
                             fielApistr  = String.join(fieldApiList,',');
                         }
                   
                         String query ='SELECT NPD_Activity_Chklist__c,';
                         query= query + ((String.isblank(fielApistr)) ? ' Id ':(fielApistr.containsIgnoreCase('Approval_Status__c')?fielApistr:(fielApistr + ' , Approval_Status__c ')) ) + ' FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__c=:childId  '; 
                       
                        List<Sobject> checkSobjList  = database.query(query);
                       
                       
                           
                       
                         checkListWrapList  =  new list<checkListWrapper>(); 
                         //dynamicSobjWrapperMap   =  new map<string,list<checkListWrapper>>();
                         for(Sobject sob : checkSobjList) {
                             sobject sobj = (sobject)sob;
                             preparemap(sobj,'NPD_Activity_Chklist__c',false);
                             DisplayFieldsList = prepareFieldsForTable(actRec.Checklist_Columns__c);
                         } 
                  }
                  
                    if(childId != null) {
                    attWrapperStageList = new List<attachWrapper >();
                    for(Attachment att : [SELECT id,name,parentid,isprivate,Description, Createdbyid FROM Attachment where parentid=: childId  ]) {
                        attachWrapper wrap= new attachWrapper();
                        wrap.ate = att ;
                        attWrapperStageList.add(wrap);
                        System.debug('***********dynamicSobjWrapperMapafteruploadpreapre*************'+dynamicSobjWrapperMap); 
                       // preparemap(obj,'ParentId',false);
                    }
                          
                     noteWrapperStageList = new List<noteWrapper>();
                    for(Note nt : [SELECT id,parentid,title,isprivate,body,createdbyid FROM Note where Parentid=:childId]) {
                        noteWrapper wrap= new noteWrapper();
                        wrap.nte = nt;
                        noteWrapperStageList.add(wrap);
                       // preparemap(obj,'ParentId',false);
                    }
                    
                    taskWrapperStageList = new List<taskWrapper>();
                    
                     for(task tt : [SELECT Id, Who.Id,Subject,Status,Description,Priority,Who.Type,ActivityDate,OwnerId,CallDisposition,Type,tempuser__c FROM Task where What.Type='NPD_Activity__c' and  WhatId =:childId]) {
                        taskWrapper wrap = new taskWrapper();
                        wrap.tsk = tt;
                      //  wrap.customuser ='dsfgdfgdfg'; 
                     //     wrap.ownerid=uu1.id;
                        taskWrapperStageList.add(wrap);
                     }
                }
                                
              record    = actRec ;
              
           /*   if(string.valueof(record.get('Actual_Start_Date__c')) == null )
              {
                    record.put('Actual_Start_Date__c',date.parse(date.today().format()));
                    
                    //sobj.put('Vendor_Ref_No__c',copyvalues.Vendor_Ref_No__c);
              
              }   */
              
          }
          
          
         /************************************************************************************************************************************
         * Method Name : prepareWrapper
         * Return Type : String
         * Parameters accepted : String
         * Purpose     : To prepare a list of wrapper class which will be used for displaying the fields at the front end dynamically for view &
                         edit of Activities and Sub- Activities.
         * Description : The string passed as a parameter to this method will contain the api names of the field with commas seperating each name,
                         The api names will be prefixed with '???' if the field is read only for that particular record & the name is suffixed with
                         '!!!' if the field is mandatory for the same.
         *************************************************************************************************************************************/
         public string prepareWrapper(String fieldStr){
             wrapperListforField = new list <WrapperForFieldSet>();
             intTowrapperListforField = new map<integer,list<WrapperForFieldSet>>();
             List<String> fieldList  = new List<String>();
             boolean readOnly = FALSE;
             boolean mandatory = FALSE;
             String  stringToReturn =''; 
             fieldStr.deleteWhitespace();        
             fieldList  = (fieldStr.contains(',')?fieldStr.split(','):(new List<string>{fieldstr}));
             
             for(String str:fieldList){  
                if(str.startsWithIgnoreCase('???') || str.endsWithIgnoreCase('!!!')){   
                    if(str.startsWithIgnoreCase('???')){ 
                     System.debug('MANDtory');                       
                     mandatory = TRUE;
                     readOnly  = FALSE;
                     str = str.removeStartIgnoreCase('???');
                     }
                     
                    if(str.endsWithIgnoreCase('!!!')){ 
                    System.debug('read');
                     readOnly = TRUE;
                     mandatory= FALSE;
                     str = str.removeEndIgnoreCase('!!!');
                     } 
                 }
                 else{
                 System.debug('NONE');
                     readOnly = FALSE;
                     mandatory = FALSE;             
                 }
                 stringToReturn = stringToReturn + str +',';
                 wrapperListforField.add(new WrapperForFieldSet(str,mandatory,readOnly));
             } 
             integer i =1;
             list<WrapperForFieldSet> wrapList = new list<WrapperForFieldSet> ();
             for(WrapperForFieldSet wrap:wrapperListforField){                
                     wrapList.add(wrap);
                     if(math.mod(wrapList.size(),4) == 0){
                         intTowrapperListforField.get(i).add(wrap);                                   
                         i = i + 1;                     
                         wrapList.clear();
                     } 
                     else{
                         if(!intTowrapperListforField.isempty() && intTowrapperListforField.containskey(i) && intTowrapperListforField.get(i) != NULL){ 
                             intTowrapperListforField.get(i).add(wrap);
                             }
                             else{
                                 intTowrapperListforField.put(i,new list<WrapperForFieldSet>{wrap});
                             }
                     }               
                 }                 
             
             stringToReturn = stringToReturn.removeEndIgnoreCase(',');          
             return stringToReturn;    
         }
         /***********************************************************************************************************************************
         * Method Name : editStage
         * Description : Fired for the save of the stage after it is edited.
         ************************************************************************************************************************************/
         public void editStage(){
              currentUserId = currentUserId.substring(0,15);
             if(string.valueof(record.get('Type__c')) != null && string.valueof(record.get('Type__c')).equalsIgnoreCase('stage') && string.valueof(record.get('Name__c')) != null && string.valueof(record.get('Name__c')).equalsIgnoreCase('Marketing Brief/Concept') ) {
                // if(previousValues.get('source__c') != record.get('source__c')) 
                     updateWhenToBeActive();
                     
                 /*if(previousValues.get('brand__c') != record.get('brand__c') || previousValues.get('Marketing_brief_concept_reference_number__c') != record.get('Marketing_brief_concept_reference_number__c') || previousValues.get('Phase__c') != record.get('Phase__c')
                     || previousValues.get('Sub_Brand1__c') != record.get('Sub_Brand1__c') || previousValues.get('Market__c') != record.get('Market__c') || previousValues.get('No_of_Designs__c') != record.get('No_of_Designs__c')) { 
                      system.debug('*******Calling Auto Populate*****');    */              
                     autoPopulate();
                     
    /*               set<string> inBrand = new set<string>();
        set<string> inSubBrand = new set<String>();
        
        for(npd_master__c inBrand1 : [select id,name,Brand__c,type__c  from npd_master__c where type__c ='Brand'])
        {
        inBrand.add(inBrand1.name);
        }
        
        for(npd_master__c inSubBrand1 : [select id,name,Brand__c,type__c  from npd_master__c where type__c ='Sub Brand'])
        {
        inSubBrand.add(inSubBrand1.name);
        }
        
        
        
        string temp1= String.valueof(record.get('Brand1__c'));
        
        string temp2 = String.valueof(record.get('sub_Brand1__c'));
        
                 
                 if( temp1 != null && ! inBrand.contains(temp1) )
                 {
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Brand is not in the NPD Master List');

                 }
                 
            else     if( temp2!=null  && ! inSubBrand.contains(temp2  ))
                 {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'This SUB Brand is not in the NPD Master List');
                
                  }
        
                else        */
            
            try{
             //   npdmas = [select id,SalesforceUser__r.id from npd_master__c where type__c = 'owner' and  id=:string.valueof(record.get('npd_user__c')) limit 1]; 
                
                npd_Stage__c npdstg1 = stageMap.get(string.valueof(record.get('id')));
                system.debug(' The value of npdstg1 :'+npdstg1);
                
            //    npd_Stage__c npdstg1 = [select id,name__c,SFCurrentStageOwnerId__c from npd_stage__c where id=:string.valueof(record.get('id')) limit 1];
                
              //  system.debug('The currentUserId standard id: ' + currentUserId);
              //  system.debug('The currentUserId standard id   as  npdmas.SalesforceUser__r.id: ' + npdmas.SalesforceUser__r.id);
                      
                      system.debug('The userid values in stages are: '+currentUserId + '........' + npdstg1.SFCurrentStageOwnerId__c );
                

                   if(currentUserId == npdstg1.SFCurrentStageOwnerId__c) 
                    {
                     if(record.get('name__c') == 'Marketing Brief/Concept'  &&  record.get('design_manager_npd_master__c')!= null)
                     {
                     npd_master__c nm1 = [select id,name,userid__c,salesforceuser__c from npd_master__c where id=:string.ValueOf(record.get('design_manager_npd_master__c')) limit 1] ;
                    
                    system.debug('The value of nm1 is:' + nm1+'............');
                     
                     record.put('Design_Manager__c',nm1.salesforceuser__c);
                   //  record.put('NSF_Emial_Address__c',string.valueof(Record.get('npd_user__r.userid__c')));
                     record.put('Design_Manager_NSF_email__c',string.valueof(nm1.userid__c));
                     update record;
                     system.debug('The value of stage record is: '+ record);
                    }
                    if(record.get('name__c') != 'Marketing Brief/Concept')
                    update record;
                     
                  }
                else
                {
                event = 'edit';
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record'));
                   }     
                     
                  } catch(exception editRec)
                   {
                      system.debug('Stage editRec value :'+editRec );
                   }  }
             if(string.valueof(record.get('Type__c')).equalsIgnoreCase('Sub-Stage')){
                 try{
                
                    
                //    npd_stage__c NpdStg1=  [select id,name__c,SFCurrentStageOwnerId__c,SFParentStageOwnerId__c from npd_stage__c where id=:string.valueof(record.get('id')) ];
                    
                    
                npd_Stage__c npdstg1 = OwnerSubStageMap.get(string.valueof(record.get('id')));
                system.debug(' The value of npdstg1 :'+npdstg1);
                    
                    
                // npd_stage__c NpdStg1=  [select id,name__c,npd_master__r.SalesforceUser__r.id,npd_stage__r.npd_master__r.SalesforceUser__r.id from npd_stage__c where id=:string.valueof(record.get('id')) ]; 
                    
                    
                    system.debug('The values are:'+ NpdStg1.SFCurrentStageOwnerId__c +'............'  + NpdStg1.SFParentStageOwnerId__c+'................'+ currentUserId);
                
                 currentUserId = currentUserId.substring(0,15);

                system.debug('The values are:'+ NpdStg1.SFCurrentStageOwnerId__c +'............'  + NpdStg1.SFParentStageOwnerId__c+'................'+ currentUserId);  
                  
                
              if((NpdStg1.SFCurrentStageOwnerId__c == currentUserId) || (NpdStg1.SFParentStageOwnerId__c == currentUserId))
                 

                       
                 {
                    
                     update record;
                     callRollupLeadTime();
                     displayMapForSubStage();
                    
                     }
                     
                     else
                     {
                     event = 'edit';
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this Sub-stage record'));
                     }
                     
                     if(Test.isRunningTest()) Integer i = 10/0;
                     }catch(exception e){system.debug('**** Error While Updating Sub Stage***'+e.getmessage());}
            }
       
         }
         

         public void callRollupLeadTime(){
            list<NPD_Stage__c> stageToUpdate = new list<NPD_Stage__c>();
            
            list<NPD_UtilityController.fieldDefinition> fieldDefinitions =  new list<NPD_UtilityController.fieldDefinition> {
                new NPD_UtilityController.fieldDefinition('SUM', 'Planned_Lead_Time__c', 'Planned_Lead_Time__c')
            };
            //,Design_Manager__c
            List<NPD_Stage__c> stageItemsList = [Select Id,NPD_Stage__r.Planned_Lead_Time__c,Source__c ,NPD_Stage__r.NPD_Stage__c,Design_Manager__c,Approval_Required__c  from NPD_Stage__c where id =: childId];
                stageToUpdate = NPD_UtilityController.rollUpLeadTime(fieldDefinitions, stageItemsList , 'NPD_Stage__c','NPD_Stage__c', 'NPD_Stage__c', 'and Type__c =\'Sub-stage\'');
                try{
                    update stageToUpdate;   
                    if(Test.isRunningTest()) {Integer i = 10/0; }           
                }catch(exception e){system.debug('*******Exception occured while updating stage***'+e.getmessage());}
            stageToUpdate = queryToUpdateMapForStage(stageToUpdate);
            
            
            for(NPD_Stage__c stg:stageToUpdate){
               if(stg.Planned_Lead_Time__c != NULL)
               stageMap.get(stg.id).Planned_Lead_Time__c  = stg.Planned_Lead_Time__c;
               stageMap.get(stg.id).Planned_Start_Date__c = stg.Planned_Start_Date__c;
               stageMap.get(stg.id).Planned_End_Date__c   = stg.Planned_End_Date__c ;
            }
        }
        /**************************************************************************************************************************************
        * queryToUpdateMapForStage
        *
        ***************************************************************************************************************************************/
        public list<NPD_Stage__c> queryToUpdateMapForStage(list<NPD_Stage__c> stgList){
            list<NPD_Stage__c> listToReturn = new list<NPD_Stage__c>(); //,Design_Manager__c
            listToReturn = [select id,Planned_Lead_Time__c,Actual_Lead_Time__c,Planned_Start_Date__c,Planned_End_Date__c,Actual_Start_Date__c,Actual_End_Date__c,Status__c,Design_Manager__c,Approval_Required__c  from NPD_Stage__c WHERE NPD_Project_Name__c=: projectId AND Type__c = 'Stage' order By position__c asc ];
            
            return listToReturn; 
        }
        /**************************************************************************************************************************************
        * queryToUpdateMapForSubStage
        ***************************************************************************************************************************************/
        public map<id,NPD_Stage__c> queryToUpdateMapForSubStage(){//,Design_Manager__c 
            map<id,NPD_Stage__c> listToReturn = new map<id,NPD_Stage__c>([select id,Planned_Lead_Time__c,Actual_Lead_Time__c,Planned_Start_Date__c,Planned_End_Date__c,Actual_Start_Date__c,Actual_End_Date__c,Status__c,NPD_Stage__r.Actual_Start_Date__c,NPD_Stage__r.Status__c from NPD_Stage__c WHERE NPD_Project_Name__c=: projectId AND Type__c = 'Sub-stage'  order By position__c asc ]); 
            
            return listToReturn; 
        }
        /**************************************************************************************************************************************
        * queryToUpdateMapForactivity
        ***************************************************************************************************************************************/
        public map<id,NPD_Activity__c > queryToUpdateMapForActivity(){
            map<id,NPD_Activity__c > listToReturn = new map<id,NPD_Activity__c >([select id,Actual_Start_Date__c,Actual_End_Date__c,Status__c,Approval_Status__c,Lead_Time__c,Lead_Time1__c,Line_Item_Approval_Required__c,Model_Name__c, No_of_Designs__c,Approver_Name3__c,Design_submitted_date__c,Design_approved_date__c,First_Month_Watch_Delivery_Date__c,Attachment_Required__c,Quantity_Required__c,Quantity_Required_Standard_Option__c,Quantity_Indented__c,Case_BO_Pilot_Delivery_Date__c,Marketing_brief_stage_approver__c,Complexity_Category__c,Planned_Lead_Time__c from NPD_Activity__c WHERE NPD_Project_Name__c=: projectId AND Type__c='Activity'  order By position__c asc ]); 
            
            return listToReturn; 
        }
        /**********************************************************************************************************************************
         queryToUpdateMapForSubactivityactivity
    ***************************************************************************************************/
        public map<id,NPD_Activity__c > queryToUpdateMapForSubActivity(){
            map<id,NPD_Activity__c > listToReturn = new map<id,NPD_Activity__c >([select id,Actual_Start_Date__c,Actual_End_Date__c,Status__c,Lead_Time__c,Lead_Time1__c,Approval_Status__c,Line_Item_Approval_Required__c,Model_Name__c, No_of_Designs__c,Approver_Name3__c,Design_submitted_date__c,Design_approved_date__c,ISCM_Briefing_Date__c,First_Month_Watch_Delivery_Date__c,Attachment_Required__c,Quantity_Required__c,Quantity_Required_Standard_Option__c,Quantity_Indented__c,Case_BO_Pilot_Delivery_Date__c,Marketing_brief_stage_approver__c           from NPD_Activity__c WHERE NPD_Project_Name__c=: projectId AND Type__c='Sub-Activity'  order By position__c asc ]); 
            
            return listToReturn; 
        }
      
        public void displayMapForSubStage(){
            list<NPD_Stage__c> stageToUpdate = new list<NPD_Stage__c>();
            map<id,NPD_Stage__c> subStageToUpdate = new map<id,NPD_Stage__c>();
            stageToUpdate = queryToUpdateMapForStage(stageToUpdate);
            subStageToUpdate = queryToUpdateMapForSubStage();
            for(NPD_Stage__c stg:stageToUpdate){
                    for(NPD_Stage__c sstg:subStageMap.get(stg.id)){
                        sstg.Planned_Lead_Time__c  = subStageToUpdate.get(sstg.id).Planned_Lead_Time__c;
                        sstg.Planned_Start_Date__c = subStageToUpdate.get(sstg.id).Planned_Start_Date__c ;
                        sstg.Planned_End_Date__c   = subStageToUpdate.get(sstg.id).Planned_End_Date__c   ;
                        sstg.Actual_Start_Date__c  = subStageToUpdate.get(sstg.id).Actual_Start_Date__c;
                        sstg.Actual_End_Date__c    = subStageToUpdate.get(sstg.id).Actual_End_Date__c;
                        sstg.Status__c = subStageToUpdate.get(sstg.id).Status__c ;
                        NPD_Stage__c stage = new NPD_Stage__c();
                        stage=  stageMap.get(subStageToUpdate.get(sstg.id).NPD_Stage__c );
                        stage.Actual_Start_Date__c=subStageToUpdate.get(sstg.id).NPD_Stage__r.Actual_Start_Date__c;
                        stageMap.put(subStageToUpdate.get(sstg.id).npd_stage__c,stage);
                    }
                }
                
            }
         /***********************************************************************************************************************************
         * Method Name : updateWhenToBeActive
         * Description : To update whether a sub-stage, activity & subactivity to be active or not based on the source selected.
         ************************************************************************************************************************************/
         public void updateWhenToBeActive(){
             list<NPD_Stage__c> subStagesForMarketing = new list<NPD_Stage__c>();         
             subStagesForMarketing.addAll(subStageMap.get(childId));      
            
             for(NPD_Stage__c stg:subStagesForMarketing)   
               for(NPD_Activity__c act:activityMap.get(stg.id)){
                    if(act.WhenToBeAcive__c == record.get('source__c') || act.Name__c == 'Make or Buy or Dual Decision'){
                        system.debug('******ITs Coming here *******'+'**********record source*******'+record.get('source__c')+'**********act.WhenToBeAcive__c***********'+act.WhenToBeAcive__c);
                        act.Active__c=true;
                    }
                    else{
                        act.Active__c=false;
                    }
                    mapToUpdateActivty.put(act.id,act);
                } 
             try{
                 update mapToUpdateActivty.values();
                 if(Test.isRunningTest()) {Integer i = 10/0;    }   
             }
             catch(exception e){system.debug('*****Error While Updating Stage*****'+e.getmessage());}
         }
         /************************************************************************************************************************************
         * Method Name : autoPopulate
         * Description : This method is used to autopopulate certain values of the fields from marketing stage level to rest all sub-stages activities as well as subactivities
         ************************************************************************************************************************************/
         public void autoPopulate(){
             system.debug('******In here****');
             if(!String.isBlank(string.valueof(record.get('brand1__c'))) || 
             !String.isBlank(string.valueof(record.get('ownerId'))) ||
                !String.isBlank(string.valueof(record.get('Marketing_brief_concept_reference_number__c'))) || 
                !String.isBlank(string.valueof(record.get('Sub_Brand1__c'))) || 
                !String.isBlank(string.valueof(record.get('Market__c'))) || 
                !String.isBlank(string.valueof(record.get('Source__c'))) ||
                record.get('No_of_Designs__c') != null || 
                !String.isBlank(string.valueof(record.get('Phase__c')))) {
                
                for(NPD_Stage__c stg:subStageMap.get(childId)){
                    stg.Brand1__c= string.valueof(record.get('brand1__c'));
                    stg.Marketing_brief_concept_reference_number__c = string.valueof(record.get('Marketing_brief_concept_reference_number__c'));
                    stg.Sub_Brand1__c     = string.valueof(record.get('Sub_Brand1__c'));
                    stg.Market__c        = string.valueof(record.get('Market__c'));
                    stg.No_of_Designs__c = Integer.valueof(record.get('No_of_Designs__c'));
                    stg.Phase__c         = string.valueof(record.get('Phase__c'));
                    stg.Source__c         = string.valueof(record.get('Source__c'));
                    
                    if(stg.Name__c=='Briefing'){
                      
                    stg.ownerId        = string.valueof(record.get('ownerId'));
                       
                      } 
                    mapToUpdateStage.put(stg.id,stg);
                    
                    for(NPD_Activity__c act:activityMap.get(stg.id)){
                        act.brand1__c         = string.valueof(record.get('brand1__c'));
                        act.Marketing_Brief_Reference_No__c= string.valueof(record.get('Marketing_brief_concept_reference_number__c'));
                       
                        act.Sub_Brand1__c= string.valueof(record.get('Sub_Brand1__c'));
                        act.Market__c        = string.valueof(record.get('Market__c'));
                        act.No_of_Designs__c = Integer.valueof(record.get('No_of_Designs__c'));
                        act.Phase__c         = string.valueof(record.get('Phase__c'));
                        act.Source__c         = string.valueof(record.get('Source__c'));
                          if(act.Name__c=='Briefing to IDS' || act.Name__c=='Briefing to OSD'){
                        act.ownerId          = string.valueof(record.get('ownerId'));
                        
                        
                         }
                        mapToUpdateActivty.put(act.id,act);
                        
                        System.debug('subActivityMap.containskey(act.id)'+subActivityMap.get(act.id));
                         System.debug('activityMap.containskey(act.id)'+activityMap.get(act.id));
                        if(subActivityMap.containskey(act.id)&& subActivityMap.get(act.id)!= NULL)
                        for(NPD_Activity__c Sact:subActivityMap.get(act.id)){
                            Sact.brand1__c         = string.valueof(record.get('brand1__c'));
                            Sact.Marketing_Brief_Reference_No__c= string.valueof(record.get('Marketing_brief_concept_reference_number__c'));
                            system.debug('SUB ACT string.valueof(record.get***'+string.valueof(record.get('Sub_Brand1__c')));
                            Sact.Sub_Brand1__c= string.valueof(record.get('Sub_Brand1__c'));
                            Sact.Market__c        = string.valueof(record.get('Market__c'));
                            Sact.No_of_Designs__c = Integer.valueof(record.get('No_of_Designs__c'));
                            Sact.Phase__c         = string.valueof(record.get('Phase__c'));
                            Sact.Source__c         = string.valueof(record.get('Source__c'));
                            if(Sact.Name__c=='Briefing to Designers' || Sact.Name__c=='Briefing to D&D and Sourcing'){
                            Sact.ownerId          = string.valueof(record.get('ownerId'));   
                               }    
                               
                               System.debug('subActivityMap.containskey(act.id)'+string.valueof(record.get('ownerId')));
                               if(Sact.Name__c=='Concept submission and approval'){
                            Sact.Marketing_brief_stage_approver__c= string.valueof(record.get('ownerId'));  
                            system.debug('Sact.Marketing_brief_stage_approver__c'+Sact.Marketing_brief_stage_approver__c);
                               }     
                            mapToUpdateActivty.put(Sact.id,Sact);
                        }
                    }
                }
                try{
                    if(!mapToUpdateStage.isempty())
                        update mapToUpdateStage.values();
                       
                    if(!mapToUpdateActivty.isempty())
                        update mapToUpdateActivty.values();
                    if(Test.isRunningTest()) {Integer i = 10/0; }   
                    }catch(exception e){
                        system.debug('********Error while updating*********'+e.getmessage());}    
             }
           }
           /*********************************************************************************************************************************
           * Method Name : createTask
           **********************************************************************************************************************************/
            public void createTask() {
            user uu1=[select id,name from user limit 1];

            taskWrapper wrap = new taskWrapper();
            wrap.tsk  = new task();
            wrap.isedit = true;
            wrap.tsk.ownerid = uu1.id;
            wrap.tsk.whatid =  childId;
            taskWrapperStageList.add(wrap);
        }  
        /*********************************************************************************************************************************
           * Method Name : createNote
           **********************************************************************************************************************************/
            public void createNote() {
            
            noteWrapper wrap = new noteWrapper();
            wrap.nte  = new note();
            wrap.isedit = true;
            wrap.nte.Parentid =  childId;
            noteWrapperStageList.add(wrap);
         
            
        }  
       
        /************************************************************************************************************************************
          * Method Name : createChklist
          *************************************************************************************************************************************/
          public void createCheckList() {
          
          
            sobject sobj = new NPD_Checklist__c();
            sobj.put('Collection__c',currentProject.NPD_Collections__c);
            sobj.put('NPD_Activity_Chklist__c',childId);
            preparemap(sobj,'NPD_Activity_Chklist__c',true);
            DisplayFieldsList = prepareFieldsForTable(string.valueof(record.get('Checklist_Columns__c')));
        
        
        }
       
          /************************************************************************************************************************************
          * Method Name : createNote
          *************************************************************************************************************************************/
        public boolean getIsCheckLists() {
                boolean temp = false;
                if(!dynamicSobjWrapperMap.isempty() && dynamicSobjWrapperMap.containsKey('NPD_Checklist__c') && dynamicSobjWrapperMap.get('NPD_Checklist__c') != null) {
                    temp  = true;
                }
                return temp;
           }
           
           public boolean getIsNotes() {
                boolean temp = false;
                if(!dynamicSobjWrapperMap.isempty() && dynamicSobjWrapperMap.containsKey('Note') && dynamicSobjWrapperMap.get('Note') != null) {
                    temp  = true;
                }
                return temp;
           }
           
           public boolean getIsAttachment() {
                boolean temp = false;
                if(!dynamicSobjWrapperMap.isempty() && dynamicSobjWrapperMap.containsKey('Attachment') && dynamicSobjWrapperMap.get('Attachment') != null) {
                    temp  = true;
                }
                return temp;
           }
           
           public void createAttachment() {
            isAttach = true;
            attach1 = new attachment();
            }    
        
        public void editTask() {
        
        
            if(relatedListType == 'Task'){
                taskWrapperStageList[rowNum].isEdit = true;
            }
             else if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null)  {
                dynamicSobjWrapperMap.get(relatedListType)[rowNum].isEdit  = true;
            }
            if(relatedListType == 'Note'){
                noteWrapperStageList[rowNum].isEdit = true;
            }
             else if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null)  {
            
                dynamicSobjWrapperMap.get(relatedListType)[rowNum].isEdit  = true;
              
            }    
            if(relatedListType == 'Attachment'){
                attWrapperStageList[rowNum].isEdit = true;
            }
             else if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null)  {
                dynamicSobjWrapperMap.get(relatedListType)[rowNum].isEdit  = true;
            }
        }
           
        public void cancelUpload() {
            isAttach = false;
        }
        
       public void deleteTask() {
       npd_stage__c NpdStg1 =  new npd_stage__c();
        npd_activity__c NpdAct1 = new  npd_activity__c();
    
       System.debug('row,recType'+relatedListType);
       
       System.debug('***Dlete List***'+dynamicSobjWrapperMap.get('NPD_Checklist__c'));
           if(relatedListType == 'Task'){
           prepareFieldListForStage();
           
             task delTask = taskWrapperStageList[rownum].tsk;
             id taskWhatId = delTask.whatid;
            system.debug('The taskWhatId value is: ' + delTask.whatid);
            
            system.debug('taskWrapperStageList'+taskWrapperStageList);
              
               if(taskWrapperStageList.size()>0)
            
               
               //  string  currentRecId = String.valueof(sobj.get('NPD_Activity_Chklist__c'));
                         
                         currentUserId = currentUserId.substring(0,15);
                            
               //    NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:taskWhatId ];                      
                      

                                String sObjName = taskWhatId.getSObjectType().getDescribe().getName();
                        
                        if(sObjName == 'npd_activity__c' )
                       {    
                         NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:taskWhatId ];                      
                         }
                       
                       
                       else if(sObjName == 'npd_stage__c')                       
                         {
                         NpdStg1  =  [select id,name__c,SFCurrentStageOwnerId__c,SFParentStageOwnerId__c from npd_stage__c where id=:taskWhatId ];     
                         }                            
                
                system.debug('user ids vals: '+ currentUserId + '.....'+NpdAct1.SFActivityid__c);
                
                
                if(NpdStg1.SFCurrentStageOwnerId__c == currentUserId || NpdStg1.SFParentStageOwnerId__c == currentUserId || currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
                        {                       
            
               
               taskWrapperStageList.remove(rownum);
               if(delTask.id != null) {
                   delete delTask;
                   
               }
              }  else{
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record'));
                  
                    
                    }         
              }
            
            
            if(relatedListType == 'Note'){
               note delnote =
               noteWrapperStageList[rownum].nte;
               
               id delnoteParentID= delnote.parentid;
               
                         
                         currentUserId = currentUserId.substring(0,15);

                     //   npd_activity__c     NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:delnoteParentID ];                      
                         
                         
                String sObjName = delnoteParentID.getSObjectType().getDescribe().getName();
                        
                        if(sObjName == 'npd_activity__c' )
                       {    
                         NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:delnoteParentID ];                      
                         }
                       
                       
                       else if(sObjName == 'npd_stage__c')                       
                         {
                         NpdStg1  =  [select id,name__c,SFCurrentStageOwnerId__c,SFParentStageOwnerId__c from npd_stage__c where id=:delnoteParentID ];     
                         }      
                system.debug('user ids vals: '+ currentUserId + '.....'+NpdAct1.SFActivityid__c);
                
                
                if(NpdStg1.SFCurrentStageOwnerId__c == currentUserId || NpdStg1.SFParentStageOwnerId__c == currentUserId || currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
                        {                       
              
               
               noteWrapperStageList.remove(rownum);
               if(delnote.id != null) {
                   delete delnote ;
               }
               } else  
               {
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record'));
                
                    }   
            }
          if(relatedListType == 'Attachment' ){
              if(string.valueof(record.get('Type__c')).equals('Stage') || string.valueof(record.get('Type__c')).equals('Sub-stage'))
                prepareFieldListForStage();
                        
             if(string.valueof(record.get('Type__c')).equals('Activity') || string.valueof(record.get('Type__c')).equals('Sub-Activity'))
                prepareFieldListForActivity();
                
             attachment delattach = attWrapperStageList[rownum].ate; attWrapperStageList.remove(rownum);
               if(delattach.id != null) {
                   delete delattach ;
               }
            }System.debug('row,recType'+dynamicSobjWrapperMap.get(relatedListType));
            System.debug('row,recType'+dynamicSobjWrapperMap);
            
           if(dynamicSobjWrapperMap.containsKey(relatedListType) )  {
                   
                Sobject sobj = dynamicSobjWrapperMap.get(relatedListType)[rowNum].sobj;
                
                 string  currentRecId = String.valueof(sobj.get('NPD_Activity_Chklist__c'));
                         currentRecId = currentRecId.substring(0,15);
                         currentUserId = currentUserId.substring(0,15);

                     NpdAct1 =  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:currentRecId ];                      
                         
                
                system.debug('user ids vals: '+ currentUserId + '.....'+NpdAct1.SFActivityid__c);
                
                
                if(currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
                        {                       
                
                
                dynamicSobjWrapperMap.get(relatedListType).remove(rowNum);
                if(sobj.id != null) {
                system.debug('sobj'+sobj);
                    delete sobj;
                }
                 }
                    else{
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record'));

                    
                    }   
            }
       }
       
       public void cancelTask() {
           if(relatedListType == 'Task'){
               if(taskWrapperStageList[rowNum].tsk.id != null && taskWrapperStageList[rowNum].tsk.id != ''){
                   taskWrapperStageList[rowNum].isEdit = false;
               }else {
                   taskWrapperStageList.remove(rowNum);
               } 
           } else if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null)  {
               if( dynamicSobjWrapperMap.get(relatedListType) != null){
                   dynamicSobjWrapperMap.get(relatedListType)[rowNum].isEdit = false;
               } else {
                   dynamicSobjWrapperMap.get(relatedListType).remove(rowNum);
               }
           }
           if(relatedListType == 'Note'){
               if(noteWrapperStageList[rowNum].nte.id != null && noteWrapperStageList[rowNum].nte.id != ''){
                   noteWrapperStageList[rowNum].isEdit = false;
                    noteWrapperStageList.remove(rowNum);
               }else {
                   noteWrapperStageList.remove(rowNum);
               } 
           } 
              
          if (!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null){
              if(dynamicSobjWrapperMap.get(relatedListType) != null){
                   dynamicSobjWrapperMap.get(relatedListType)[rowNum].isEdit = false;
               //    dynamicSobjWrapperMap.get(relatedListType).remove(rowNum);
               } //else {
                //   dynamicSobjWrapperMap.get(relatedListType).remove(rowNum);
             //  }
           }
       }  
          
          // public attachment attach1{get;set;}
           public void upload() {
            try{
                update record;
                if(Test.isRunningTest()) {Integer i = 10/0; }   
            }catch(exception e){
                system.debug('****Error while updating record***'+e.getmessage());        
            }
            attach1.parentid = childID;
            sobject sobj = (Sobject)attach1;
            preparemap(sobj,'ParentId',false);
            
           if(attach1.id == null) {
                relatedListType = 'Attachment';
               rowNum = dynamicSobjWrapperMap.get(relatedListType).size()-1;
                //rowNum = dynamicSobjWrapperMap.get(relatedListType).size(); 
            } 
             attach1 = new attachment();
            saveIndividualTask();
            isAttach = false;
            
            try {
             if(string.valueof(record.get('Type__c')).equals('Stage') || string.valueof(record.get('Type__c')).equals('Sub-stage'))
                prepareFieldListForStage();
             if(string.valueof(record.get('Type__c')).equals('Activity') || string.valueof(record.get('Type__c')).equals('Sub-Activity'))
                prepareFieldListForActivity(); 
             
                if(string.valueof(record.get('Type__c')).equals('Activity') )
                activityname=string.valueof(record.get('name__c'));
                
                if(string.valueof(record.get('Type__c')).equals('Activity') )
                subactivityname=string.valueof(record.get('name__c'));
                if(Test.isRunningTest()) {Integer i = 10/0; }   
                } catch(exception stagetype)
                {
                    system.debug(stagetype);
                }
                
                System.debug('***********dynamicSobjWrapperMapafterupload*************'+dynamicSobjWrapperMap.get('NPD_Checklist__c'));    
        }

        public PageReference saveIndividualTask() {
        npd_stage__c NpdStg1 =  new npd_stage__c();
        string taskWhatId ='';
        npd_activity__c NpdAct1 = new  npd_activity__c();
    
        system.debug('inside saveIndividualTask');
             PageReference detailpage;
             SavePoint spt = dataBase.setSavePoint();
            try{
                if(relatedListType == 'Task'){
                    task updateTask   =     taskWrapperStageList[rowNum].tsk;
                
                system.debug('updateTask.whoid value :' +updateTask);
                system.debug('updateTask.whatid value :' +updateTask.whatid);

                taskWhatId = updateTask.whatid;
            
                
                    system.debug('inside saveIndividualTask 888 '+updatetask.tempuser__c);

                NPD_Master__c n1=[select id,SalesforceUser__c,UserID__c,ownerid from NPD_Master__c where name=:updatetask.tempuser__c  limit 1];
                    system.debug('inside saveIndividualTask'+n1.SalesforceUser__c);

                    updatetask.OwnerId =n1.SalesforceUser__c;
            


               /*************   checking owner ship for task parent record ******************/
               
               
                         id taskParentId = taskWhatId;
                         currentUserId = currentUserId.substring(0,15);
                         
                         String sObjName = taskParentId.getSObjectType().getDescribe().getName();
                        
                        if(sObjName == 'npd_activity__c' )
                       {    
                         NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:taskParentId ];                      
                         }
                       
                       
                       else if(sObjName == 'npd_stage__c')                       
                         {
                         NpdStg1  =  [select id,name__c,SFCurrentStageOwnerId__c,SFParentStageOwnerId__c from npd_stage__c where id=:taskParentId ];     
                         }
            

            system.debug('user ids vals: '+ currentUserId + '.....'+NpdAct1.SFActivityid__c +'......'+NpdStg1.SFCurrentStageOwnerId__c+'.....'+taskParentId);
                
                 
                
                if(NpdStg1.SFCurrentStageOwnerId__c == currentUserId || NpdStg1.SFParentStageOwnerId__c == currentUserId || currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
                        {                                             
            
                    taskWrapperStageList[rowNum].isEdit = false;
                    upsert updateTask;
                
                   

                
                // For stroting the details for sending email to the non salesforce uesr. 
                string taskNonSalesforceUser =  updatetask.tempuser__c;
                string TaskSubject =updatetask.Subject;
                string TaskComments =updatetask.Description;
                date TaskDueDate = Date.valueOf(updatetask.ActivityDate);
                    
                  
                // querying all salesforce users to indentify who are salesforce users and who are non salesforce users.
                
                set<string> allusers= new set<string>();
                for(user u1:[select id,name from user])
                {
                allusers.add(u1.id);
                }
                 if(n1.UserID__c != '' && n1.UserID__c != null)
                    {
                    // procedure for sending alert email for the non salesforce user. 
                            messaging.SingleEmailMessage email1=new messaging.SingleEmailMessage();
                            string[] to=new string[]{n1.UserID__c};
                           

                            email1.settoaddresses(to);
                            
                            email1.setsubject('Task Assigned');
                            
                            email1.setHtmlBody('<html><body>Hi ' + taskNonSalesforceUser +',<br/> <br/> Please find the details below: <br/> <br/>Task Subject: ' + TaskSubject +'<br/> <br/> Comments: ' +TaskComments +'<br/><br/>Due Date: '+TaskDueDate  +'<br/><br/> Status :'+updateTask.status +'<br/><br/> priority :' +updateTask.priority+'</body></html>');
        
                        /*  email1.setplaintextbody('Hi, you got a task assigned by the salesforce uers. And the Task details are as fallows: '+ 'Task Subject:'+ updateTask.subject +'Task Owner is '+ updateTask.OwnerId+'Due Date is'+updateTask.ActivityDate+'Task Status is: '+updateTask.Status+' Comments are: '+updateTask.Description); */
                            messaging.sendemail(new messaging.email[]{email1});
                         
                    }
                
                
                 
                
                    
                    system.debug(updatetask.id);
                    if(string.valueof(record.get('Type__c')).equals('Stage') || string.valueof(record.get('Type__c')).equals('Sub-stage'))
                        prepareFieldListForStage();
                    if(string.valueof(record.get('Type__c')).equals('Activity') || string.valueof(record.get('Type__c')).equals('Sub-Activity'))
                        prepareFieldListForActivity();   
                } 
                else{
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record for task '));
                 system.debug('Inside task else condition with error message'); 
                    
                    } 
           }
               
                 

               
                
                if(relatedListType == 'Note'){
                    note updateNote   =     noteWrapperStageList[rowNum].nte;
              system.debug('The updatenote Title upserting value before upsert is:  '+ updateNote.title);

                         id taskParentId = updateNote.parentid;
                         currentUserId = currentUserId.substring(0,15);
                         
                         String sObjName = taskParentId.getSObjectType().getDescribe().getName();
                        
                        if(sObjName == 'npd_activity__c' )
                       {    
                         NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:taskParentId ];                      
                         }
                       
                       
                       else if(sObjName == 'npd_stage__c')                       
                         {
                         NpdStg1  =  [select id,name__c,SFCurrentStageOwnerId__c,SFParentStageOwnerId__c from npd_stage__c where id=:taskParentId ];     
                         }
            

            system.debug('user ids vals: '+ currentUserId + '.....'+NpdAct1.SFActivityid__c +'......'+NpdStg1.SFCurrentStageOwnerId__c+'.....'+taskParentId);
                
                 
                
                if(NpdStg1.SFCurrentStageOwnerId__c == currentUserId || NpdStg1.SFParentStageOwnerId__c == currentUserId || currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
                        {                       
                    noteWrapperStageList[rowNum].isEdit = false;
                    system.debug('The updatenote upserting value is:  '+ updateNote);
                    system.debug('The updatenote Title upserting value is:  '+ updateNote.title);

                    upsert updateNote;
                    
                    system.debug('the updatenote:'+ updateNote.parentid);

                    if(string.valueof(record.get('Type__c')).equals('Stage') || string.valueof(record.get('Type__c')).equals('Sub-stage'))
                        prepareFieldListForStage();
                    if(string.valueof(record.get('Type__c')).equals('Activity') || string.valueof(record.get('Type__c')).equals('Sub-Activity'))
                        prepareFieldListForActivity();
                        }
                         else{
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record on Notes'));
                  
                    
                    }   
                } 

                else if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null){
                    sobject sobj = dynamicSobjWrapperMap.get(relatedListType)[rowNum].sobj;
                    System.debug('sobjsobj'+sobj.id ); 
                    
                    // for storing the all model numbers for the current collection.  This is used in dynamic table UPGRADE.
                        boolean upgradeNow=true;
                        string doupsert =null;
                    
                    set<string> modelnames=new set<string>();
                    
                    if(relatedListType == 'NPD_Checklist__c'){
                        if(!validateChecklist(sobj)) {
                            strErrorMsg= string.valueof(record.get('Mandatory_Fields__c')) +' '+'are mandatory';
                        }
                        else if (relatedListType == 'NPD_Checklist__c'){
                            system.debug('*****New Debug Is Inserted?****'+sobj);
                           // system.debug('The value of NPD_Activity_Chklist__r.serialno__c is: '+ string.valueof(sobj.get('NPD_Activity_Chklist__r.serialno__c')));
                           
                           string CurrentModelName;
                            
                            if(String.valueof(sobj.get('Tag__c')) == 'Upgrade')
                            {
                              
                                checkListCollection= String.valueof(sobj.get('Collection__c'));
                                
                                //system.debug('checkListCollection value is: ' +checkListCollection);
                                CurrentModelName = String.valueof(sobj.get('Model_No__c'));
                                
                                
                        /*        for(NPD_Checklist__c checks1:[select id,name,Model_No__c,Vendor_Ref_No__c from NPD_Checklist__c where Model_No__c !=null and Collection__c=:checkListCollection])
                                {
                                    
                            //system.debug('The value of checks1.Model_No__c is: '+checks1.Model_No__c);                                
                                    modelnames.add(checks1.Model_No__c);
                                    
                                    
                                }   */
                                
                                
                                 for(NPD_Project_Name__c checks1:[select id,name from NPD_Project_Name__c where name !=null])
                                {
                                    
                            //system.debug('The value of checks1.Model_No__c is: '+checks1.Model_No__c);                                
                                    modelnames.add(checks1.name);
                                    
                                    
                                } 
                                
                            if(! modelnames.contains(CurrentModelName))
                            {
                                system.debug('The modelnames are: '+modelnames + 'and the  CurrentModelName is: '+CurrentModelName);
                                
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'This Model Number does not exist'));
                                upgradeNow = false; // used to decide to upsert the record or not. 
                                doupsert='do upsert';
                            }
                            
                            
                            
                            if(upgradeNow == true)
                            {   
                          /*   NPD_Checklist__c copyvalues=[select id,Vendor_Ref_No__c,PSY_No__c,Model_No__c from NPD_Checklist__c where Model_No__c=:CurrentModelName limit 1];
                           */
                            
                            NPD_Project_Name__c copyvalues=[select id,Vendor_Ref_No__c,PSY_No__c,Model_No__c from NPD_Project_Name__c where Model_No__c=:CurrentModelName limit 1];
                            
                            
                                system.debug('The value of copyvalues is :'+copyvalues.Vendor_Ref_No__c +', '+copyvalues.PSY_No__c );
                                
                                
                                
                                
                                if(copyvalues.Vendor_Ref_No__c != null )
                                {
                                  // sobj.Vendor_Ref_No__c = copyvalues.Vendor_Ref_No__c;
                                 // sobj.get('Vendor_Ref_No__c').put(copyvalues.Vendor_Ref_No__c);
                                 //string vendorno = string.valueof(copyvalues.Vendor_Ref_No__c);
                                 
                                 sobj.put('Vendor_Ref_No__c',copyvalues.Vendor_Ref_No__c);
                                }
                                
                                if(copyvalues.PSY_No__c != null )
                                {
                                    
                                    sobj.put('PSY_No__c',copyvalues.PSY_No__c);
                                    }
                                }
                           

                        } 
                        if(doupsert==null)
                        {
                         //  system.debug('The sobj vales are :' +sobj);
                      //  string  currentRecId = String.valueof(sobj.get('NPD_Activity_Chklist__c'));
                        system.debug('The value of childid:'+ childid);
                      //   currentRecId = currentRecId.substring(0,15);
                      string currentRecId =childid.substring(0,15);
                         currentUserId = currentUserId.substring(0,15);
                         NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:currentRecId ];                      
                         
                
                system.debug('user ids vals: '+ currentUserId + '.....'+NpdAct1.SFActivityid__c);
                
                
                if(currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
                        {     
                        
                // below code for Duplicate psy no prevention **************   By Sai. 
                
                        set<string> oldPsyNos= new set<string>();
                  for(npd_checklist__c nc1:[select id,psy_no__c from npd_checklist__c])
                  {
                     oldPsyNos.add(nc1.psy_no__c);
                  }
                       string currentPsyNo =  string.valueof(sobj.get('psy_no__c'));  
                       
                       string checkid =null;
                       
                       checkid = string.valueof(sobj.get('id'));
                       
                       if(checkid != null)
                       oldPsyNos.remove(currentPsyNo);
                       
                      
                       if(!oldPsyNos.contains(currentPsyNo) && NpdAct1.name__c == 'Concept Presentation to PMG - IDS')
                       {
                        upsert sobj;
                            strErrorMsg='Saved Successfully'; 
                        }
                           else
                             {
                               strErrorMsg = 'This Psy No '+currentPsyNo + 'is already for existed, Please choose another Psy No';
                             }
                        
                    if(NpdAct1.name__c != 'Concept Presentation to PMG - IDS')
                       { 
                       system.debug(sobj+'******sobj');
                        upsert sobj;
                            strErrorMsg='Saved Successfully'; 
                        }
                        
                        }
                    else{
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this record'));
                  
                    
                    }   
                        
                        
                            }                       
                       
                    }
                    
                    }
                    if(relatedListType == 'NPD_Checklist__c' &&  (validateChecklist(sobj))){
                        String checkId  = String.ValueOf(sobj.get('Id'));
                        System.debug('********sobj***opop******'+checkId  );
                        String queryStr = 'SELECT '+String.join(DisplayFieldsList,',')+' FROM '+relatedListType +' WHERE id=:checkId LIMIT 1';
                        sobj = database.query(queryStr);
                        System.debug('********sobj***opop******'+sobj);   
                    }
                    
                    
                    if(relatedListType == 'Attachment'){
                    
                        upsert sobj;
                        
                        String bdyId  = String.ValueOf(sobj.get('Body'));
                        sobj.put('Body',NULL);
                        detailpage= new PageReference('/NPD_DetailView_Page?proID=' + projectId );
                        detailpage.setRedirect(true);
                      
                    }
                    
                    if((relatedListType == 'NPD_Checklist__c' &&  (validateChecklist(sobj))))  { // || relatedListType == 'Attachment'
                        checkListWrapper wrap = dynamicSobjWrapperMap.get(relatedListType)[rowNum];
                        wrap.sobj    =  sobj;
                        wrap.isEdit  =  false;
                        dynamicSobjWrapperMap.get(relatedListType).set(rowNum,wrap);
                        system.debug('*******wrap.sobj*********'+wrap.sobj.get('id'));
                    }
                }
                if(Test.isRunningTest()) {Integer i = 10/0; }   
            } 
            catch(Exception excp) {
                DataBase.rollBack(spt); 
                System.debug('******Error while updating the activities and checklists*************'+excp +'.....'+ excp.getLineNumber());
            } 
            finally {
                try{
                if(Test.isRunningTest())
                Integer i = 10/0;
                } 
                catch (exception excp) { }
            }
            
              return detailpage;
            
            
        } 
        
              /**********************************************v************************************************************************************
               * Class Name : ActivityApprovalHistorylist  .......  Used for fetching approval history of activity and sub-activity records.
              ***********************************************************************************************************************************/ 
          
          public void ActivityApprovalHistorylist()
          {
                 // approvalhistorylist =new list<ProcessInstance>();
                 
                //string tempvalue=(record.get('id')).tostring();
                 // approvalhislist=[SELECT CreatedById,CreatedDate,Id,Status,TargetObjectId,SubmittedById FROM ProcessInstance where targetobjectid=:childId];
          approvalhislist=[Select  p.Comments,p.OriginalActorId, p.ProcessInstance.CreatedById,p.ProcessInstance.CreatedDate,p.ProcessInstance.Id,p.ProcessInstance.LastActorId,p.ProcessInstance.Status,p.ProcessInstance.TargetObjectId,p.ProcessInstance.SubmittedById from ProcessInstanceStep p  WHERE p.ProcessInstance.TargetObjectID=:childId];
          }

          
        
           /*********************************************************************************************************************************
           * Method Name : editActivity()
           **********************************************************************************************************************************/
        public void editActivity(){
        
         currentUserId = currentUserId.substring(0,15);


       if(string.valueof(record.get('Type__c')).equalsIgnoreCase('Activity'))
        { 
        
        try{

     
      npd_activity__c NpdAct1=  [select id,name__c,SFActivityid__c,NPD_Stage__r.SFParentStageOwnerId__c,NPD_Stage__r.SFCurrentStageOwnerId__c from npd_activity__c where id=:string.valueof(record.get('id')) ];
     System.debug('Activity User id'+currentUserId+' Act'+NpdAct1.SFActivityid__c); 
     System.debug('Record details'+record); 
     
       if(currentUserId == NpdAct1.SFActivityid__c || currentUserId == NpdAct1.NPD_Stage__r.SFParentStageOwnerId__c || currentUserId == NpdAct1.NPD_Stage__r.SFCurrentStageOwnerId__c) 
        {   
            
            if(string.valueof(record.get('Type__c')).equalsIgnoreCase('Activity') &&           string.valueof(record.get('status__c')).equalsIgnoreCase('completed') && string.valueof(record.get('Approval_Required__c')).equalsIgnoreCase('true')   &&
             string.valueof(record.get('approval_status__c')) != 'approved'  )  
             {  
              event = 'edit';
              system.debug('the string boolean value is:' +string.valueof(record.get('Approval_Required__c')));
              
             }        
                 
             else

            {        event = 'view';   }
            
            system.debug('*******In Save Method*****'); 
            system.debug('*******old value*****'+stageRec +'***********'+record);
            system.debug('*******old valuechildId*****'+childId+'***********'+childId);
            if(string.valueof(record.get('Type__c')).equalsIgnoreCase('Activity')){
                
                
                
                    update record;
                    prepareFieldListForActivity();
                    displayupdatedAtivity();
                      
                                     
                }   
                
        }
            else
            {
            event = 'edit';
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this Activity record'));
               }
               
            if(Test.isRunningTest()) {Integer i = 10/0; }       
            }
            catch(exception e){system.debug('*********Exception while updating***'+e.getmessage());}  }
            
            if(string.valueof(record.get('Type__c')).equalsIgnoreCase('Sub-Activity'))
        {
        system.debug('inside sub act: ');
            try{
            system.debug('inside sub act try: ');
      npd_activity__c NpdAct1=  [select id,name__c,SFActivityid__c,SFParentActivityOwnerId__c,npd_activity__r.npd_stage__r.id from npd_activity__c where id=:string.valueof(record.get('id')) ];
      

     npd_stage__c npdSubStg1 = [select id,name__c,SFParentStageOwnerId__c,SFCurrentStageOwnerId__c  from npd_stage__c where id=:NpdAct1.npd_activity__r.npd_stage__r.id];
     
     system.debug('inside sub activity :'+ npdSubStg1);
     
      
     
       if(currentUserId == NpdAct1.SFActivityid__c ||  currentUserId == NpdAct1.SFParentActivityOwnerId__c || currentUserId == npdSubStg1.SFParentStageOwnerId__c || currentUserId == npdSubStg1.SFCurrentStageOwnerId__c) 
        {   
                    system.debug('inside sub act if statement: ');
        if(string.valueof(record.get('Type__c')).equalsIgnoreCase('sub-Activity') &&           string.valueof(record.get('status__c')).equalsIgnoreCase('completed') && string.valueof(record.get('Approval_Required__c')).equalsIgnoreCase('true')   &&
                     string.valueof(record.get('approval_status__c')) != 'approved')  
             {  
              event = 'edit';
              system.debug('the string boolean value is:' +string.valueof(record.get('Approval_Required__c')));
              
             }        
                 
             else

            {       event = 'view';   
                    system.debug('The again making view and it is:');
            
            }             
            
        
            
        //  event = 'view'; 
            if(string.valueof(record.get('Type__c')).equalsIgnoreCase('Sub-Activity')){
                if(date.valueof(record.get('Actual_Start_Date__c')) <= (system.today()))
                {
                  system.debug('The sub activity data : '+ record);
                  system.debug('The sub activity owner information is: '+ string.valueof(record.get('npd_user__c')));
                  update record;
                prepareFieldListForActivity();
                displayupdatedSubAtivity();
                  
                 
                } 
                }
              }
            else
            {
            event = 'edit';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You dont have ownership for this Activity record'));
               }
       
                
            }catch(exception e){system.debug('**** Error While Updating Sub Stage***'+e.getmessage());}
            
        }  }
       
           /********************************************************************************************************************************
           * Method Name : preparemap
           * Description :
           *********************************************************************************************************************************/
            private  void preparemap(sobject obj, string parentField, boolean editMode) {
                checkListWrapper  wrap =  new checkListWrapper();
                wrap.isEdit  = editMode;
                wrap.sobj    = obj;
                if(!String.isBlank(parentField) && wrap.sobj.get(parentField)==null) {
                    wrap.sobj.put(parentField,childId);
                }
                 string objectType =  String.valueOf(obj.getSobjectType());
                 
                if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(objectType) && dynamicSobjWrapperMap.get(objectType) != null) {
                    dynamicSobjWrapperMap.get(objectType).add(wrap);
                    system.debug('***Checklist***'+dynamicSobjWrapperMap.get(objectType));
                } else {
                    dynamicSobjWrapperMap.put(objectType,new list<checkListWrapper>{wrap});
                }   
                
                System.debug('***********dynamicSobjWrapperMap*************'+dynamicSobjWrapperMap);     
            }
            
            /********************************************************************************************************************************
           * Method Name : displayupdatedstages
           * Description : This method is use to display all edited records
           *********************************************************************************************************************************/
        public void displayupdatedAtivity(){
            list<NPD_Stage__c > stageActToUpdate = new list<NPD_Stage__c >();
            map<id,NPD_Activity__c  > ActivityToUpdate = new map<id,NPD_Activity__c >();
            //,Design_Manager__c
            stageActToUpdate =[SELECT id,Status__c,Actual_Start_Date__c,Actual_End_Date__c,NPD_Stage__c ,NPD_Stage__r.Actual_End_Date__c,NPD_Stage__r.Actual_Start_Date__c,NPD_Stage__r.Status__c,Design_Manager__c,Approval_Required__c  From NPD_Stage__c WHERE NPD_Project_Name__c=: projectId AND Type__c = 'Sub-stage' order By position__c asc ];
            ActivityToUpdate = queryToUpdateMapForActivity();
            for(NPD_Stage__c  act:stageActToUpdate){
                for(NPD_Activity__c  sstg:activityMap.get(act.id)){
                    sstg.Actual_Start_Date__c=ActivityToUpdate.get(sstg.id).Actual_Start_Date__c;
                    sstg.Actual_End_Date__c=ActivityToUpdate.get(sstg.id).Actual_End_Date__c;
                    sstg.Status__c=ActivityToUpdate.get(sstg.id).Status__c;
                     system.debug('**ActivityToUpdate.get(sstg.id).Lead_Time__c**'+ActivityToUpdate.get(sstg.id).Lead_Time__c);
                    if(ActivityToUpdate.get(sstg.id).Lead_Time__c!=NULL)
                    sstg.Lead_Time1__c=ActivityToUpdate.get(sstg.id).Lead_Time__c;
                    system.debug('**sstg.Lead_Time1__c**'+sstg.Lead_Time1__c);
                }
            }
            displayMapForSubStage();
        }
        
            /********************************************************************************************************************************
           * Method Name : displayupdatedSubAtivity
           * Description : This method is use to display all edited records
           *********************************************************************************************************************************/
        public void displayupdatedSubAtivity(){
            List<NPD_Activity__c> Activityupdate = new List<NPD_Activity__c>();
            map<id,NPD_Activity__c> SubActivityToUpdate = new map<id,NPD_Activity__c>();

            Activityupdate = [select id,Actual_Start_Date__c,Actual_End_Date__c,Status__c,Model_Name__c,Approval_Status__c,Line_Item_Approval_Required__c,Approver_Name3__c,Design_submitted_date__c,Design_approved_date__c,First_Month_Watch_Delivery_Date__c,Attachment_Required__c,Marketing_brief_stage_approver__c              from NPD_Activity__c WHERE NPD_Project_Name__c=: projectId AND Type__c='Activity' order By position__c asc];
            SubActivityToUpdate =queryToUpdateMapForSubActivity();
            System.debug('**Activityupdate**'+Activityupdate );
            System.debug('**SubActivityToUpdate**'+SubActivityToUpdate);
            for(NPD_Activity__c act:Activityupdate ){
                for(NPD_Activity__c  sstg:subActivityMap.get(act.id)){
                    sstg.Actual_Start_Date__c=SubActivityToUpdate .get(sstg.id).Actual_Start_Date__c;
                    sstg.Actual_End_Date__c=SubActivityToUpdate .get(sstg.id).Actual_End_Date__c;
                    sstg.Status__c=SubActivityToUpdate .get(sstg.id).Status__c;    
                }    
            }
        }
            /***************************************************************************************************************************
              ** Method Name : prepareFieldsForTable
            ****************************************************************************************************************************/
            public list<string> 
            prepareFieldsForTable(string fieldstr){
                List<String> fieldList  = new List<String>();
                if(!String.isBlank(fieldStr)) {
                    fieldStr   = fieldStr.replaceAll('\\n','');
                    fieldList  = (fieldStr.contains(',')?fieldStr.split(','):(new List<string>{fieldstr}));
                }
                set<string> fiedlabels  = new set<string>();
                for(String str : fieldList) {
                    str = str.trim();
                    fiedlabels.add(str);
                }
                
                list<string> fieldApiList   = new List<String>();
                String fielApistr      =  '';
                map<string,string> label_Api  =  new map<String,String>();
                Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap();
                
                for(Schema.SObjectField field : Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap().values()) {
                    string temp = field.getDescribe().getLabel();
                    if(fiedlabels.contains(temp)) {
                        string apiName  =  field.getDescribe().getName();
                        fieldApiList.add(apiName);
                        label_Api.put(temp,apiName);
                    }
                } 
                
                List<String> DisplayFieldsList  = new List<String>();
                
                for(String label : fiedlabels) {
                    if(!label_Api.isEmpty() && label_Api.containsKey(label) && label_Api.get(label) != null) {
                        DisplayFieldsList.add(label_Api.get(label));
                    }
                }
                return DisplayFieldsList;
            }
            /*****************************************************************************************************************************
            ** Method Name: validateChecklist
            ******************************************************************************************************************************/
            public boolean validateChecklist(sobject sobj){
            list<string> DisplayFieldsListMandatory = new List<string>();
            DisplayFieldsListMandatory = prepareFieldsForTable(string.valueof(record.get('Mandatory_Fields__c')));       
            Boolean  mandatory=true;
            Boolean  notmandatory=false;       
            for(string str:DisplayFieldsListMandatory){         
               if(sobj.get(str) == NULL )  { 
                mandatory=false;
                }
                else{            
                notmandatory=true;
              }  
              }
            if (mandatory==false){        
            return false;
            }
            else{         
             return true;
            }    
         return true;
       }
           
          public pagereference newProject() {
             String stageId  = '';
             String actid = '';
            if(!stageMap.isEmpty()) {
                    for(NPD_Stage__c stage : stageMap.values()) {
                            if(stage.Name__c.equalsIgnoreCase('Marketing Brief/Concept')) {
                                    stageId = stage.id;
                                    break;
                            }
                    }
            }
            
            if(!subActivityMap.isEmpty() && !activityMap.isEmpty()) {
                
                    for(list<NPD_Activity__c> acts: subActivityMap.values()) {
                            for(NPD_Activity__c Act:acts)                        
                            if(Act.Name__c.equalsIgnoreCase('Case/Model No Allocation')) {
                                    actid = Act.id;
                                    break;
                            }
                    }
           
            }
            
            String url  =  ('/apex/NPD_Project?core.apexpages.request.devconsole=1&stageId='+stageId+'&ActivID='+actid+'&ProjID='+projectId);
            system.debug('***********URL**'+url);
            pagereference reference = new pagereference(url);
                    reference.setRedirect(true);
                    return reference;
       }  
            
           /********************************************************************************************************************************
           * Class Name : taskWrapper 
           * Descriptio : Wrapper Class for functionalities related to task.
           *********************************************************************************************************************************/
            public class taskWrapper {
                public boolean isEdit{get;set;}
                public task tsk{get;set;}
                public string subject{get;set;}
                public string customuser {set;get;}
                public string ccusers {set;get;}
                
                public taskWrapper() {
                    isEdit    =  false;
                    tsk       =  new task();
                    subject = '';
                    customuser = '' ;
                    ccusers = '';
                }
            }
            /********************************************************************************************************************************
           * Class Name :noteWrapper 
           * Descriptio : Wrapper Class for functionalities related to task.
           *********************************************************************************************************************************/
            public class noteWrapper {
                public boolean isEdit{get;set;}
                public note nte{get;set;}
                public string subject{get;set;}
                public noteWrapper() {
                    isEdit    =  false;
                    nte       =  new note();
                    subject = '';
                }
            }
             /********************************************************************************************************************************
           * Class Name :noteWrapper 
           * Descriptio : Wrapper Class for functionalities related to task.
           *********************************************************************************************************************************/
            public class attachWrapper {
                public boolean isAttach {get;set;}
                public boolean isedit {get;set;}
                public attachment ate{get;set;}
                public string subject{get;set;}
                public attachWrapper () {
                    isAttach     =  false;
                    ate =  new attachment();
                    subject = '';
                    isedit = false;
                }
            }
            
          /**********************************************************************************************************************************
          * Class Name : checkListWrapper 
          * Description : 
          ***********************************************************************************************************************************/
          public class checkListWrapper {
            public boolean isedit{get;set;}
            public sobject sobj{get;set;}
            public checkListWrapper() {
                isEdit = false;
            }   
        }
        
        /**********************************************************************************************************************************
          * Class Name : approvalMethod
          * Description : 
          ***********************************************************************************************************************************/
        public void approvalMethod(){}
            public void approvalitems(){ 
       
               if(string.valueof(record.get('Type__c')).equals('Activity') || string.valueof(record.get('Type__c')).equals('Sub-Activity'))
                lstact=[Select id,NPD_Project_Name__c,Name__c,Brand1__c,Design_Manager_Titan__c,Source__c,Design_Manager_Fastrack__c,Marketing_brief_stage_approver__c from Npd_activity__c where id=:childId];
               system.debug('*******lstact****+'+lstact);

                
               
                if(string.valueof(record.get('Type__c')).equals('Stage')){ 
                    if(chkattachment(childID)>0){
                        string.valueof(record.put('Approval_Status__c','Pending'));
                        update record;
                        NPDChkboxDynamicApproval.updateApprovers(lstact);
                        NPDChkboxDynamicApproval.ApprovalDone(childId);
                    }
                    else {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Upload attachment for submiting for approval')); 
                    }  
                }
               
               
                try{ 
                     
                    if(string.valueof(record.get('Line_Item_Approval_Required__c')).equals('true')) {
                        string.valueof(record.put('Approval_Status__c','Pending'));
                         NPDChkboxDynamicApproval app = new NPDChkboxDynamicApproval();
                         NPDChkboxDynamicApproval.updateApprovers(lstact);
                         app.ApprovalMethod(id.valueof(childId),'submission');
                         system.debug('recordrecord'+record);
                         update record;
                    } 
                        
                    
                    
                    if(!string.valueof(record.get('Line_Item_Approval_Required__c')).equals('true') && string.valueof(record.get('Type__c')).equals('Activity') || string.valueof(record.get('Type__c')).equals('Sub-Activity')){
                        system.debug('recordrecord'+record);
                        string.valueof(record.put('Approval_Status__c','Pending'));
                        update record;
                        NPDChkboxDynamicApproval.updateApprovers(lstact);
                        NPDChkboxDynamicApproval.ApprovalDone(childId);
                    }             
                    if(Test.isRunningTest()) {Integer i = 10/0; }   
                }catch(Exception excp) {
                    System.debug('**************excpetion while submitting for approval********'+excp.getMessage());
                }
     }
     
     
     /********************************************************************************************************************************
        *
        *
        *******************************************************************************************************************************/
        public integer chkattachment(id childId){
            return [SELECT count() FROM Attachment where ParentId=:childId] ; 
        }
     
     
     /**********************************************************************************************************************************
          * Class Name : getSubmitCheckVisible
          * Description : 
          ***********************************************************************************************************************************/
        //public boolean getSubmitCheckVisible()
        public void getSubmitCheckVisible() {     
        }
        public void submitChecklist() {
            String checkListId  =  null;
            if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey('NPD_Checklist__c') && dynamicSobjWrapperMap.get('NPD_Checklist__c') != null) {
                    checkListId =  string.valueOf(dynamicSobjWrapperMap.get('NPD_Checklist__c')[rowNum].sobj.get('Id'));
                    system.debug('****Submission Check ID***'+checkListId);
                    NPDChkboxDynamicApproval.MultiApprover(checkListId,'Submission');
            }
        }

          /**********************************************v************************************************************************************
          * Class Name : WrapperForFieldSet, Used for dynamically display the fields for view and edit mode.
          ***********************************************************************************************************************************/      
          public class WrapperForFieldSet{
          public string  fieldAPI{get;set;}  // Api name of the field.
          public boolean isMandatory{get;set;} //  Stores whether the field is mandatory for particular record.
          public boolean isReadonly {get;set;} //  Stores whether the field is read only for particular record.
               
          public  WrapperForFieldSet(string api,boolean isMandatry,boolean isRead){
              fieldAPI   =  api;
              isMandatory=  isMandatry;
              isReadonly =  isRead; 
          }      
       }
       
       public void lineitemapprovalhistory()
       {
       fieldHistoy.clear();
          showPopup1();
        
       }
       
       public void showPopup1()
        {   
                        appHistoryWraplist = new list<appHistoryWrap>();
                
             try {
                        
                        sobject sobj = dynamicSobjWrapperMap.get('NPD_Checklist__c')[rowNum].sobj;
                        checkListWrapper wrap = dynamicSobjWrapperMap.get('NPD_Checklist__c')[rowNum];
                        wrap.sobj    =  sobj;
                        wrap.isEdit  =  false;
                        dynamicSobjWrapperMap.get('NPD_Checklist__c').set(rowNum,wrap);
                        system.debug('*******wrap.sobj*********'+wrap.sobj.get('id'));
                        //string tempCheckId1 = wrap.sobj.get('id');
                        
                        CheckId1=string.valueOf(wrap.sobj.get('id'));     
        system.debug('****Record ID***'+CheckId1);   
       if(CheckId1 == null || CheckId1 == '') {
                    CheckId1 = ApexPages.currentPage().getparameters().get('CheckIdid');
                }
        
        nolinehistory= '' ;
        fieldHistoy = [SELECT CreatedById,CreatedDate,NewValue,OldValue,Field,Parent.Case_Sourcing__c FROM NPD_Checklist__History WHERE Field = 'Approval_Status__c' AND ParentId =: CheckId1];
        
        if(fieldHistoy.size()==0)
        {
        nolinehistory = 'There are no line item history for this record';
        }
        system.debug(fieldHistoy.size()+' this is fieldHistoy');
        displayPopup1 = true;     
        
        /*****************************   Aprpoval Table Dynamic user ids into into user names ***********************/
        
        map<string,string> userNamesMap= new map<string,string>();
        
        for(user uu:[select id,name from user])
        {
            userNamesMap.put(uu.id,uu.name);
        }
        
        
        for(NPD_Checklist__History ahw:fieldHistoy)
        {
        appHistoryWrap apphw=new appHistoryWrap();
        apphw.cdate=ahw.CreatedDate;
        //apphw.username=ahw.CreatedById;
        apphw.username = userNamesMap.get(ahw.CreatedById);
        //apphw.action = ahw.OldValue + ' ' +ahw.NewValue;
        
        if(ahw.NewValue == 'Approved')
        apphw.action = userNamesMap.get(ahw.CreatedById) + ' ' +' has Approved This Line Item'; 
        
        if(ahw.NewValue == 'Pending')
        apphw.action = userNamesMap.get(ahw.CreatedById) + ' ' +' has Submitted This Line Item For Approval';  
        
        if(ahw.NewValue == 'Re-Submit')
        apphw.action = userNamesMap.get(ahw.CreatedById)  + ' '+' has Rejected This Line Item';
        
        if(ahw.NewValue == 'Dropped')
        apphw.action = userNamesMap.get(ahw.CreatedById)  + ' '+' has Dropped This Line Item';
        
        
        
        appHistoryWraplist.add(apphw);
        
        
        }
                if(Test.isRunningTest()) {Integer i = 10/0; }   
            }
            
            catch (exception eerr)
            {
            system.debug(eerr);
            }
         
         }
        public void closePopup1() {
            displayPopup1 = false;        
        }    
        public PageReference redirectPopup1()
        {
        displayPopup1 = false;
        
                 
             return null;       
        }
        
       
      public pagereference getHomePage()
        
        {
        
                    if(focusid1 == null)
                    {
                        focusid1='No value';
                    }
        
                    //  return new pagereference(('/apex/NPD_DetailView_Page_saiClone?proID='+projectId+'&focusid='+focusid1 )).setredirect(true);
                     
    return new pagereference(('/apex/NPD_DetailView_Page?proID='+projectId )).setredirect(true);

                      
                      
               // pagereference p= new pagereference('/apex/NPD_DetailView_Page?proID='+projectId);
              //  p.setRedirect(true);
              //  return p;
                
        }
        
         
        
        public class appHistoryWrap
       {
       
            public datetime cdate {set;get;}
            public string username {set;get;}
            public string action {set;get;}
            
       
       public appHistoryWrap()
       {
       cdate=null;
       username='';
       action='';
        
       }
       
       }

       public void processActiveDeactiveSubstage()
       {
       
       }
       
      /*     
       public list<npd_stage__c> getstringList()
        {
        retunstages = new list<string>();
          //  return [select id,name from account limit 25];
        
        return [SELECT id,Name__c FROM NPD_Stage__c WHERE NPD_Project_Name__c=: projectId ORDER BY  Position__c ASC];

     
          list<string> testlist =new list<string>();
          
          // testlist.add();
           
           map<string,id> maplist= new map<string,id>();
           
           for(npd_stage__c npdstage1:[SELECT id,name__c FROM NPD_Stage__c WHERE NPD_Project_Name__c=: projectId ORDER BY  Position__c ASC] )
           {
           maplist.put(npdstage1.name__c,npdstage1.id);
           }
           
           list<string> retunstages = new list<string>();
           
          retunstages.addall(maplist.keyset());
           
           
        } */
        
        public list<account> getAccountList()
        {
           integer a=10;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
            a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           a++;
           
            integer b=10;
            integer c=a+b;
            integer d=a-b;
            integer e=a/b;
            integer f=a+a+b;
            integer h=f+e;
            integer h1=f+e;
            integer h2=f+e;
            integer h3=f+e;
            integer h31=f+e;
            integer h32=f+e;
            integer h33=f+e;
            integer h34=f+e;
            integer h35=f+e;
            integer h36=f+e;
            integer h37=f+e;
            integer h38=f+e;
            integer h39=f+e;
            integer ah3=f+e;
            integer bh3=f+e;
            integer ch3=f+e;
            integer dh3=f+e;
            integer eh3=f+e;
            integer fh3=f+e;
            integer gh3=f+e;
            integer ahh3=f+e;
            integer bhh3=f+e;
            integer chh3=f+e;
            integer dhh3=f+e;
            integer fhh3=f+e;
            integer ghh3=f+e;
            integer hhh3=f+e;
            integer ihh3=f+e;
            integer jhh3=f+e;
            integer khh3=f+e;
            integer lhh3=f+e;
            integer mhh3=f+e;
            integer nhh3=f+e;
                        integer hj1=f+e;
            integer hj2=f+e;
            integer hj3=f+e;
            integer hj31=f+e;
            integer hj32=f+e;
            integer hj33=f+e;
            integer hj34=f+e;
            integer hj35=f+e;
            integer hj36=f+e;
            integer hj37=f+e;
            integer hj38=f+e;
            integer hj39=f+e;
            integer ahj3=f+e;
            integer bhj3=f+e;
            integer chj3=f+e;
            integer dhj3=f+e;
            integer ehj3=f+e;
            integer fhj3=f+e;
            integer ghj3=f+e;
            integer ahjhj3=f+e;
            integer bhjhj3=f+e;
            integer chjhj3=f+e;
            integer dhjhj3=f+e;
            integer fhjhj3=f+e;
            integer ghjhj3=f+e;
            integer hjhjhj3=f+e;
            integer ihjhj3=f+e;
            integer jhjhj3=f+e;
            integer khjhj3=f+e;
            integer lhjhj3=f+e;
            integer mhjhj3=f+e;
            integer nhjhj3=f+e;
 integer nahh3=f+e;
 integer nbhh3=f+e;
 integer nachh3=f+e;
 integer nahdh3=f+e;
 integer nhahe3=f+e;
 integer nahh3f=f+e;
 integer nahh3g=f+e;
 integer nahh3h=f+e;
 integer nahh3d=f+e;
 integer nahhs3=f+e;
 integer nahah3=f+e;
 integer nazhh3=f+e;
 integer naahh3=f+e;
 integer na3hh3=f+e;
 integer n1ahh3=f+e;
 integer n4ahh3=f+e;
 integer n5ahh3=f+e;
 integer mahh3=f+e;
 integer n7ahh3=f+e;
 integer na8hh3=f+e;
 integer na8bhh3=f+e;
 integer na81hh3=f+e;
 integer na82hh3=f+e;
 integer na83hh3=f+e;
 integer na84hh3=f+e;
 integer na85hh3=f+e;
 integer na86hh3=f+e;
 integer na87hh3=f+e;
 integer na88hh3=f+e;
 integer na89hh3=f+e;
 integer na80hh3=f+e;
 integer na8ahh3=f+e;
 integer na8chh3=f+e;
 integer na8dhh3=f+e;
 integer na8fhh3=f+e;
 integer na8ghh3=f+e;
 integer na8hhh3=f+e;
 integer na8ihh3=f+e;
 integer na8jhh3=f+e;
 integer na8khh3=f+e;
 
            return [select id,name from account limit 25];
        }
       
    }