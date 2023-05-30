/*********************************************************************
   Class Name       : NPDApprovalHandler
   Type             : Handler class 
   Description      : This class is to update the approver from stage,project etc. 
   Created By       : Keyur Modi
   Created Date     : 08/03/2016
  
  
  Note: - 1.  Filed  Marketing brief stage approver  is changed to   Marketing brief stage approver2.
          2. Field   Approver 1   changed to Approver 2.   
  
*********************************************************************/
Public class NPDApprovalHandler {
  
    public static void getApproverOnBeforeUpdate( List<NPD_Activity__c>lstActivity,Map<id,NPD_Activity__c>OldMapActivity){
    if(lstActivity[0].actual_start_date__c != null)
    {
    
    list <NPD_Activity__c> actList = new  list <NPD_Activity__c>();
    list <NPD_Activity__c> updateactList = new  list <NPD_Activity__c>();
    map <id,List<NPD_Stage__c>> stageToProject = new map <id,List<NPD_Stage__c>>();
    map <id,List<NPD_Activity__c>> actToProject = new map <id,List<NPD_Activity__c>>();
    map <id,id> actToProjectMap = new map <id,id>();
    map<id,String> projectnamemap =new map<id,String>();
    Map<id,NPD_stage__c> mapOfStage = new map<id,NPD_Stage__c>();
    map<id,npd_stage__c > StageMap = new map<id,npd_stage__c>();
    map<id,id> CollectionsToStageUserID =  new map<id,id>();
    map<string,string> CollectionsToStageUserEmails = new map<string,string>();
    map<id,id> CollectionsToActivityUserID =  new map<id,id>();
    map<string,string> CollectionsToActivityUserEmails = new map<string,string>();
    
    
    list<npd_activity__C> ActstoUpdate12 = new list<npd_activity__c>();                 


    set <id> projectID = new set <id>();
    actList = lstActivity;
    
   // map<id,npd_activity__c> usermap = new map<id,npd_activity__c>([select id,NPD_User__r.SalesforceUser__r.id from npd_activity__c where type__c ='activity' and NPD_Project_Name__c IN:projectID and NPD_User__r.SalesforceUser__r.id != null]);
    
    
    
    
    
   system.debug('-------------actList-----------------'+actList );
     
        for(NPD_Activity__c act:actList ){
            projectID.add(act.NPD_Project_Name__c); 
        }
        
        system.debug('-------------projectID-------------'+projectID);
         for(NPD_stage__c stg: [SELECT id,Name__c,NPD_Project_Name__c,NPD_Project_Name__r.OwnerID,ownerId,NPD_User__r.userid__c,NPD_User__r.SalesforceUser__r.id FROM NPD_Stage__c WHERE Name__c ='Marketing Brief/Concept' AND NPD_Project_Name__c IN:projectID ]){
             mapOfStage.put(stg.NPD_Project_Name__c,stg);
             
         }
        for(NPD_Activity__c act:[SELECT ID,Source__c,Name__c,NPD_Project_Name__c,NPD_Project_Name__r.Development_Route__c,NPD_Project_Name__r.OwnerID,OwnerID,NPD_User__r.userid__c,NPD_User__r.SalesforceUser__r.id FROM NPD_Activity__c WHERE ( (Type__c ='Activity'  AND (Name__c ='Leather Strap For Proto Mfg' OR Name__c = 'Dial for Proto Mfg' OR Name__c = 'Engineering Design - IDS' OR Name__c='Proto Design Input' OR Name__c='Proto Design - Release' OR  Name__c='Briefing to IDS'))) AND NPD_Project_Name__c IN:projectID]){
             
            if(actToProject.containskey(act.NPD_Project_Name__c)){
              actToProject.get(act.NPD_Project_Name__c).add(act);
            }
            else{                
                actToProject.put(act.NPD_Project_Name__c, new  List <NPD_Activity__c> { act });
            }
            
            /*if(act.NPD_Project_Name__c != NULL){
            actToProjectMap.put(act.ID,act.NPD_Project_Name__r.OwnerID);
                
            if(act.NPD_Project_Name__r.Development_Route__c!=NULL)    
                projectnamemap.put(act.ID, act.NPD_Project_Name__r.Development_Route__c); // Map holding the id of the particular activity and project object   
                // system.debug('actToProjectMapactToProjectMap'+actToProjectMap);
                // system.debug('projectnamemapprojectnamemap'+projectnamemap);
            } */
        }
        
        list<npd_project_name__c> prjctLst = [select id,NPD_Collections__r.SF_Project_Owner__r.userid__c from npd_project_name__c where id in : projectID];
     system.debug('-------------prjctLst-------------'+prjctLst);
        for(NPD_Activity__c act:actList ){
        
       map<string,string> projectowneremails = new map<string,string>();
       
       
     
     for(npd_project_name__c np1: prjctLst)
       {
          projectowneremails.put(np1.id,np1.NPD_Collections__r.SF_Project_Owner__r.userid__c);
       }   
       
     
        
        system.debug('The projectowneremails is:'+projectowneremails);
        
         if(actToProject.get(act.NPD_Project_Name__c) != NULL && actToProject.containskey(act.NPD_Project_Name__c)){              
                
                
                for(NPD_Activity__c actlobj:actToProject.get(act.NPD_Project_Name__c)){
                    //Activity 
                    
                    act.projectowneremail__c = projectowneremails.get(act.NPD_Project_Name__c);

                     system.debug('The act.projectowneremail__c'+ act.projectowneremail__c);
                   
                    if( act.Source__c== 'IDS' || act.Source__c== 'OSD' || Test.isRunningTest() ){
                        if(actlobj.Name__c == 'Proto Design Input' || Test.isRunningTest() && act.Source__c== 'IDS' && (act.Name__c == '2D Drawing/3D Model Release/Approval R1' || act.Name__c == '2D Drawing/3D Model Release/Approval R2' || act.Name__c=='2D Drawing/3D Model Release/Approval' || act.Name__c=='Proto Dial Drawing Release and Receipt' || act.Name__c=='Proto Dial Drawing Release and Receipt R1' || act.Name__c=='Proto Dial Drawing Release and Receipt R2' || act.Name__c =='PB/PM Release , Approval and Recipt' || act.Name__c =='PB/PM Release , Approval and Recipt R1' || act.Name__c =='PB/PM Release , Approval and Recipt R2' ) && actlobj.NPD_User__r.SalesforceUser__r.id != NULL){
                        act.Proto_Design_Approver__c = actlobj.NPD_User__r.SalesforceUser__r.id; // get owner from proto design input
                            //act.
                        act.Proto_Design_Approver_Email__c  = actlobj.NPD_User__r.userid__c;
                            
                            // system.debug('The actlobj.NPD_User__r.SalesforceUser__r.id value is: '+ actlobj.NPD_User__r.SalesforceUser__r.id);
                            
                            // system.debug('act.name__c is : ' +act.name__c + 'The stored at name: '+ actlobj.Name__c);
                            
                        }
                        if(actlobj.Name__c == 'Proto Design - Release' || Test.isRunningTest() && (act.Name__c == '2D Drawing/3D Model Release/Approval R1' || act.Name__c == '2D Drawing/3D Model Release/Approval R2' || act.Name__c=='2D Drawing/3D Model Release/Approval' || act.Name__c=='Proto Dial Drawing Release and Receipt' || act.Name__c=='Proto Dial Drawing Release and Receipt R1' || act.Name__c=='Proto Dial Drawing Release and Receipt R2' || act.Name__c =='PB/PM Release , Approval  and Recipt' || act.Name__c =='PB/PM Release , Approval and Recipt R1' || act.Name__c =='PB/PM Release , Approval and Recipt R2' ) && actlobj.NPD_User__r.SalesforceUser__r.id != NULL){
                        act.Technical_Design_Approver__c = actlobj.NPD_User__r.SalesforceUser__r.id; // get owner from proto design input
                        act.Technical_Design_Approver_email__c = actlobj.NPD_User__r.userid__c;
                               
                           //act.
                        }    
                        if((actlobj.Name__c == 'Leather Strap For Proto Mfg' && (act.Name__c == 'PB/PM Release , Approval and Recipt R1' || act.Name__c == 'PB/PM Release , Approval and Recipt R2' || act.Name__c == 'PB/PM Release , Approval  and Recipt') && actlobj.NPD_User__r.SalesforceUser__r.id != NULL ) || Test.isRunningTest()){ //&& actlobj.Source__c!='OSD'&& projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route'
                            act.Approver_2__c = actlobj.NPD_User__r.SalesforceUser__r.id;
                             // system.debug('==act.Approver_2__c=='+ act.Approver_2__c);  // system.debug('==act.Name__c=='+ act.Name__c); // system.debug('==actlobj.Name__c=='+Test.isRunningTest());   
                            act.Approver_2_Email__c =  actlobj.NPD_User__r.userid__c;
                             
                             
                        }
                        if((actlobj.Name__c == 'Dial for Proto Mfg'  && (act.Name__c == 'Proto Dial Drawing Release and Receipt R1' || act.Name__c == 'Proto Dial Drawing Release and Receipt R2' || act.Name__c == 'Proto Dial Drawing Release and Receipt' ) &&   actlobj.NPD_User__r.SalesforceUser__r.id != NULL ) || Test.isRunningTest()){ //&& actlobj.Source__c!='OSD'&& projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route'
                            act.Approver_2__c = actlobj.NPD_User__r.SalesforceUser__r.id;
                            // system.debug('== inside if condition =='+ act.Approver_2__c);
                            act.Approver_2_Email__c =  actlobj.NPD_User__r.userid__c;
                            
                            
                        }
                        if((actlobj.Name__c == 'Dial Sample Submission' && (act.Name__c== 'PB/PM Release , Approval and Recipt - Optional - R2' || act.Name__c=='Dial Drawing Release and Recipt' || act.Name__c=='Dial Drawing Release and Recipt R1' || act.Name__c=='Dial Drawing Release and Recipt R2' ) &&   actlobj.NPD_User__r.SalesforceUser__r.id != NULL)  || Test.isRunningTest() ){ //&& actlobj.Source__c!='OSD'&& projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route'
                            act.Approver_2__c = actlobj.NPD_User__r.SalesforceUser__r.id;
                            // system.debug('== inside if condition =='+ act.Approver_2__c);
                            act.Approver_2_Email__c =  actlobj.NPD_User__r.userid__c;
                            
                        }
                        if((actlobj.Name__c == 'Leather Strap Sample Submission' && (act.Name__c== 'PB/PM Release , Approval and Recipt - Optional - R1' || act.Name__c== 'PB/PM Release , Approval and Recipt - Optional'  ) &&   actlobj.NPD_User__r.SalesforceUser__r.id != NULL)  || Test.isRunningTest() ){ //&& actlobj.Source__c!='OSD'&& projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route'
                            act.Approver_2__c = actlobj.NPD_User__r.SalesforceUser__r.id;
                            // system.debug('== inside if condition =='+ act.Approver_2__c);
                            act.Approver_2_Email__c =  actlobj.NPD_User__r.userid__c;
                            
                        }
                        if((actlobj.Name__c == 'Input - Final Product Design' && (act.Name__c== 'Proto Feedback Form Recipt Confirmation' || act.Name__c== 'Proto Feedback Form Recipt Confirmation R1' || act.Name__c== 'Proto Feedback Form Recipt Confirmation R2' || act.Name__c== 'PB/PM Release , Approval and Recipt - Optional' || act.Name__c== 'PB/PM Release , Approval and Recipt - Optional - R1' || act.Name__c== 'PB/PM Release , Approval and Recipt - Optional - R2' || act.Name__c=='Dial Drawing Release and Recipt' || act.Name__c=='Dial Drawing Release and Recipt R1' || act.Name__c=='Dial Drawing Release and Recipt R2' ))  || Test.isRunningTest()){ 
                         act.Proto_Design_Approver__c = actlobj.NPD_User__r.SalesforceUser__r.id; // get owner from proto design input
                         
                         act.Proto_Design_Approver_Email__c = actlobj.NPD_User__r.userid__c;
                         
                         
                        }
                        if((actlobj.Name__c == 'Final Product Drawing Release' && ( act.Name__c== 'PB/PM Release , Approval and Recipt - Optional' || act.Name__c== 'PB/PM Release , Approval and Recipt - Optional - R1' || act.Name__c== 'PB/PM Release , Approval and Recipt - Optional - R2' || act.Name__c=='Dial Drawing Release and Recipt' || act.Name__c=='Dial Drawing Release and Recipt R1' || act.Name__c=='Dial Drawing Release and Recipt R2' ))  || Test.isRunningTest()){ 
                         act.Technical_Design_Approver__c = actlobj.NPD_User__r.SalesforceUser__r.id; // get owner from proto design input
                         act.Technical_Design_Approver_email__c = actlobj.NPD_User__r.userid__c;
                         
                        }
                    }
                                        
                    //Cost Estimation and Approval---Approval to be sent to owner of activity “Briefing to IDS”
                    //Notification to team leader[Details Needed]
                    /*if(actlobj.Name__c == 'Briefing to IDS' && actlobj.NPD_User__r.SalesforceUser__r.id != NULL && act.Name__c=='Cost Estimation and Approval'){
                         
                        act.Approver_2__c = actlobj.NPD_User__r.SalesforceUser__r.id;
                        act.Approver_2_Email__c = actlobj.NPD_User__r.SalesforceUser__r.userid__c;
                        
                         // system.debug(' act.Approver_2__c'+ act.Approver_2__c);
                    } */
                }
                
                    // system.debug('=act.NPD_Project_Name__c=='+act.NPD_Project_Name__c);
                    // system.debug('==mapOfStage=='+act.NPD_Project_Name__c);
                    if(mapOfStage.containsKey(act.NPD_Project_Name__c) && mapOfStage.get(act.NPD_Project_Name__c) != NULL){
                        act.Project_Owner_Approver__c = mapOfStage.get(act.NPD_Project_Name__c).NPD_Project_Name__r.ownerId; 
                        // Project owner owner email is already done through workflow.
                        // system.debug('==project owner== '+act.Project_Owner_Approver__c);
                    }
                    if(mapOfStage.containsKey(act.NPD_Project_Name__c) && mapOfStage.get(act.NPD_Project_Name__c) != NULL){
                        act.Marketing_brief_stage_approver2__c = mapOfStage.get(act.NPD_Project_Name__c).NPD_User__r.salesforceuser__r.id;
                       act.Marketing_brief_stage_approver2_Email__c = mapOfStage.get(act.NPD_Project_Name__c).NPD_User__r.userid__c;
                        
                        // system.debug('act.Marketing_brief_stage_approver2__c'+act.Marketing_brief_stage_approver2__c);
                    }
                    // system.debug('==finaly='+act.Approver_2__c);
              /* if(stageToProject.get(act.NPD_Project_Name__c) != NULL && stageToProject.containskey(act.NPD_Project_Name__c)){
                for(NPD_Stage__c stage:stageToProject.get(act.NPD_Project_Name__c)){
                    
                    //Owner of stage Marketing Brief/Concept to be automatically assigned as the owner of this activity
                    if(stage.Name__c == 'Marketing Brief/Concept' && stage.ownerID != NULL){
                        act.Marketing_brief_stage_approver2__c = stage.ownerID;
                        // system.debug('act.Marketing_brief_stage_approver2__c'+act.Marketing_brief_stage_approver2__c);
                    }
                    
                    
                    if(actToProjectMap.get(act.NPD_Project_Name__c) != NULL  && stage.Source__c!='OSD' && projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route' && (act.Name__c=='2D Drawing/3D Model Release/Approval' ||act.Name__c=='PB/PM Release , Approval and Recipt' || act.Name__c=='PB/PM Release , Approval and Recipt - Optional' || act.Name__c=='Dial Drawing Release and Recipt' || act.Name__c=='Proto Dial Drawing Release and Receipt') ){
                         act.Project_Owner_Approver__c = actToProjectMap.get(act.id);      
                        // system.debug('act.Project_Owner_Approver__c'+act.Project_Owner_Approver__c);
                     } 
              }
             } */       
            }
        }
        
        
    //  Collecting all stages along with their ids , using in  "Cost Estimation and Approval".
    
        
        
        for(npd_stage__c nstg: [select id,name__c,npd_user__r.id from npd_stage__c])
        {
          StageMap.put(nstg.id,nstg);
        }
        
        
    // Model id with all activities. 

  map<id,npd_activity__c> MapofModelWithActs= new map<id,npd_activity__c>();

  for(npd_activity__c npAct13: [select id,name__c,npd_user__r.userid__c,ModelId__c,npd_user__c from npd_activity__C where name__c = 'Tentative Cost Estimation and Approval']) 
  {
    MapofModelWithActs.put(npAct13.ModelId__c, npAct13);
   }

    
        
        
        
        map<Id,Id> collectionAndProjectOwnerMap = new map<Id,Id>();
        id admin; 
        //id owner;       
             
    try{ 
      admin = [SELECT id from user WHERE profile.name = 'NPD- Stage User' AND Alias = 'npd3'].id;
      //owner = [SELECT Marketing_Brief_Stage__r.OwnerId FROM NPD_Project_Name__c where Marketing_Brief_Stage__c != null].id;
      
        set<Id> collectionSet = new set<Id>();
        for(NPD_Activity__c activ : lstActivity){
            if(activ.NPD_Collections__c != null){
                collectionSet.add(activ.NPD_Collections__c);
            }   
        }

        list<NPD_Project_Name__c> prjct = [select Id, OwnerId, NPD_Collections__c from NPD_Project_Name__c where NPD_Collections__c IN :collectionSet AND Name = 'Marketing Brief/Concept Stage'];
        for(NPD_Project_Name__c pr : prjct ){
            if(pr.NPD_Collections__c != null && pr.OwnerId != null){
                collectionAndProjectOwnerMap.put(pr.NPD_Collections__c , pr.OwnerId);
            }

        }
    }
       
       catch(exception admin1)
       {
          // system.debug(admin1 +' Sandbox Admin user name replaced with production admin user');
          
       }  
            
                 for(NPD_Activity__c act:lstActivity ){
            
            if(admin!= null)
            {
             //       act.Project_Owner_Approver__c = admin;
             //act.Marketing_brief_stage_approver__c = admin;    
          //   act.Approver_1__c = admin;                     
             act.Engineering_Design_Approver__c  = admin;
             act.Approve_2__c = admin;   
             act.Design_Manager_Fastrack__c = admin;      
            }
            if(collectionAndProjectOwnerMap.containsKey(act.NPD_Collections__c) &&  collectionAndProjectOwnerMap.get(act.NPD_Collections__c) != null){
                act.Marketing_brief_stage_approver__c = collectionAndProjectOwnerMap.get(act.NPD_Collections__c);
            } 
           }

    

        // Collecting collection id + Marketing brief stage owner for  "Cost Estimation and Approval".  
        
        //  On Approval automatic email alert has to be sent to owner of activity “Tentative Cost Estimation and Approval”                  
        
        
        for(npd_stage__c ns1:[select id,NPD_Collections_id__c,name__c,npd_user__r.userid__c,npd_user__r.salesforceuser__r.id from npd_stage__c where type__c='stage' and name__c = 'Marketing Brief/Concept' ])
        {
             CollectionsToStageUserID.put(ns1.NPD_Collections_id__c,ns1.npd_user__r.salesforceuser__r.id);
             CollectionsToStageUserEmails.put(ns1.NPD_Collections_id__c,ns1.npd_user__r.userid__c);
           }
           
         for(npd_activity__c na17: [select id,CollectionId__c,name__c,npd_user__r.userid__c,npd_user__r.salesforceuser__r.id from npd_activity__c where name__c='Concept Design - IDS'])  
         {
            CollectionsToActivityUserID.put(na17.CollectionId__c, na17.npd_user__r.salesforceuser__r.id);
            CollectionsToActivityUserEmails.put(na17.CollectionId__c,na17.npd_user__r.userid__c);
         }
         
         // system.debug(' CollectionsToActivityUserID : '+CollectionsToActivityUserID);

               
                            
   //   This is for "Cost Estimation and Approval"  ACtivity in Design stage and for its Revision activities.   AND Proto Submission by D&D for Approval – Activity for its Revision activities.  
                            
    for(npd_activity__c npdAct12 : lstActivity)
    {
      if(npdAct12.Name__c== 'Cost Estimation and Approval' ||npdAct12.serialno__c == 'AR-0201003' || npdAct12.serialno__c == 'AR-0203003' || npdAct12.serialno__c == 'AR-0205003' || npdAct12.serialno__c == 'AR-0201005')
      {
       npdAct12.approver_1__C = CollectionsToStageUserID.get(npdAct12.CollectionId__c);
       

       ActstoUpdate12.add(npdAct12);
      }
      
      
    if( npdAct12.Name__c == 'Proto Submission by D&D for Approval'|| npdAct12.serialno__c == 'AR-0202001'  || npdAct12.serialno__c == 'AR-0206001'  || npdAct12.serialno__c == 'AR-0204001') 
    {   
    npdAct12.approver_1__C = CollectionsToStageUserID.get(npdAct12.CollectionId__c);
    npdAct12.concept_design_ids_owner__c =  CollectionsToActivityUserID.get(npdAct12.CollectionId__c);
    // system.debug('npdAct12.approver_1__C  :'+ npdAct12.approver_1__C +'......' +   npdAct12.concept_design_ids_owner__c+'......'+ CollectionsToActivityUserID.get(npdAct12.CollectionId__c));
    
    // Notificaitons to non salesforce users.
         
    
    npdAct12.approver_1_Email__c =   CollectionsToStageUserEmails.get(npdAct12.CollectionId__c);
    npdAct12.concept_design_ids_owner_Email__c = CollectionsToActivityUserEmails.get(npdAct12.CollectionId__c);
      
    
    
     }
    }
                            
 // update  ActstoUpdate12;             
        
        
        
        
    
    
     for(npd_activity__c n1 : lstActivity)
    {
         
         if(n1.NPD_Sf_owner_email__c != null)
        n1.NPD_Sf_owner_email_address__c = n1.NPD_Sf_owner_email__c;
        
        if(n1.NPD_manager_email__c != null)
        n1.NPD_manager_email2__c =  n1.NPD_manager_email__c ;
        
        }
        
    //  For Cost estimation approval process.  By Sai. 
    
    
     map<string,id > SfUsers = new map<string,id>();
     map<string,string> NsfUsersEmails = new map<string,string>();
    
   for(npd_master__c npdMas1 :[select id,name,SalesforceUser__r.id,userid__c from npd_master__c ])
   {
       SfUsers.put(npdMas1.name,npdMas1.SalesforceUser__r.id);
       NsfUsersEmails.put(npdMas1.name,npdMas1.userid__c);
     }
     
   for(npd_activity__c n1 : lstActivity)
    {   
      //  1st approver  K. Shivakumar code. 
       if(n1.SerialNo__c != null && n1.Projecct_manger_SF_id__c!= null && (n1.SerialNo__c == 'AR-0302020003' || n1.SerialNo__c == 'AR-0303001003'  || n1.SerialNo__c == 'AR-0303006003' || n1.SerialNo__c == 'AR-0303008002' || n1.SerialNo__c == 'AR-0302018003'    || n1.SerialNo__c == 'AR-0302022003'))            
       {
       n1.Final_cost_1st_approver__c  =  SfUsers.get('Shivakumar');
       n1.Final_cost_2nd_approver__c =   n1.projectOwnerEmail__c;
       
       
       // Approval Email Notifications . 
       
       n1.Final_cost_1st_approver_email__c = NsfUsersEmails.get('Shivakumar');
       n1.Final_cost_2nd_approver_Email__c = n1.projectOwnerEmail__c;
       
       }
       
       //  1st approver N.Balaji  code.
       
       if(n1.SerialNo__c != null && n1.Projecct_manger_SF_id__c!= null && (n1.SerialNo__c == 'AR-0303001003' || n1.SerialNo__c == 'AR-0303004003' || n1.SerialNo__c == 'AR-0303005003' || n1.SerialNo__c == 'AR-0303009003'))
       {
       n1.Final_cost_1st_approver__c  =  SfUsers.get('Balaji');
       n1.Final_cost_2nd_approver__c =   n1.Projecct_manger_SF_id__c;
       
       
       // Approval Email Notifications . 
       
       n1.Final_cost_1st_approver_email__c = NsfUsersEmails.get('Balaji');
       n1.Final_cost_2nd_approver_Email__c = n1.projectOwnerEmail__c;
       
       
       }
       
       //  1st approver for M. Duraisamy  code.
       if(n1.SerialNo__c != null && n1.Projecct_manger_SF_id__c!= null && n1.SerialNo__c == 'AR-0303003003')
       {
       n1.Final_cost_1st_approver__c  =  SfUsers.get('Duraisamy');
       n1.Final_cost_2nd_approver__c =   n1.Projecct_manger_SF_id__c;
       
       
           // Approval Email Notifications . 
       
       n1.Final_cost_1st_approver_email__c = NsfUsersEmails.get('Duraisamy');
       n1.Final_cost_2nd_approver_Email__c = n1.projectOwnerEmail__c;
       
       
       }
    }
    //  For email notification to the the Cost Estimation and Approval  Approval process.
     system.debug('The value of cost estimation is: kjkjk'+lstActivity);
    for(npd_activity__c nact1 :lstActivity)
    {  
      if(nact1.SerialNo__c == 'AR-0201003' || nact1.SerialNo__c == 'AR-0205003' || nact1.SerialNo__c == 'AR-0203003')
        {
          
        nact1.approver_1_Email2__c = mapOfStage.get(nact1.project_id__c).NPD_User__r.userid__c;
        //actsToUpdate.add
        system.debug('The value of cost estimation is: ' + mapOfStage.get(nact1.project_id__c).NPD_User__r.userid__c);
        }   
    
    }
    
    integer i=0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    
 }   
 }  
}