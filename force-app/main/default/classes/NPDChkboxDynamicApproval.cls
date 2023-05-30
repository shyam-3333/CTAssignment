/*******************************************
** Name:-ApprovalProcess
** Description:-This class is for Dynamic Approval Process.
** Created By: Roshi Rai
** Created Date:07/04/2015
********************************************/



public with sharing class NPDChkboxDynamicApproval {
    public boolean approval;
    public boolean submission;
    public string action='';
   
    public string notificationID= '';
    public set<id> approverID = new set<id>();
    
   public static void ApprovalDone(id lstid)
    {   
        system.debug('++++++++++++++++lstid++++++++'+lstid);
        
       List<Approval.ProcessSubmitRequest> lstprocess=new List<Approval.ProcessSubmitRequest>();
    // Approval.ProcessWorkitemRequest pwr = new Approval.ProcessWorkitemRequest();
      
       Approval.ProcessSubmitRequest req1 =new Approval.ProcessSubmitRequest();
   // pwr.setWorkitemId(ids);
 
           req1.setComments('Request Submitted');
           req1.setObjectId(lstid);
           lstprocess.add(req1);
   
   // Submit the approval request
   List<Approval.ProcessResult> resultlist = Approval.process(lstprocess);
   System.debug('resultlist'+resultlist );

}
  
    
    
     public void ApprovalMethod(ID Act,string acts){
        action = acts;
        
       NPD_Activity__c activity = new NPD_Activity__c();
        
        if(action == 'submission'){
            submission = TRUE;
            approval = FALSE;
            
        }
        else if(action == 'Approved'){
            submission = FALSE;
            approval = TRUE;
        }
        else{
            submission = FALSE;
            approval = FALSE;
        }
        
        approverEmail(Act);
        sendMail(act);
        
    }
    
    public void approverEmail(id active){
        
      map<id,NPD_Activity__c> actMap = new map<id,NPD_Activity__c>([SELECT id,Name__c,Approver_1__c,Marketing_brief_stage_approver__c,Proto_Design_Approver__c,Project_Owner_Approver__c,NPD_Stage__c,NPD_Stage__r.ownerID,NPD_Project_Items__r.ownerID,NPD_Stage__r.Name__c,NPD_Stage__r.Type__c,OwnerID FROM NPD_Activity__c WHERE ID =:active]);
        
        for(NPD_Activity__c act :actMap.values()) {
          if(action == 'submission'){
                
            if(act.Name__c == 'Proto Submission by D&D for  Approval' ){
                approverID.add(act.Approver_1__c);
                //approverID.add(act.Marketing_brief_stage_approver__c);
            }
            else if(act.Name__c == 'Concept submission and approval'){
                    approverID.add(act.Marketing_brief_stage_approver__c);
            }
            else if(act.Name__c == 'Pricing Proto to PMG/Pricing release'){
                approverID.add(act.Marketing_brief_stage_approver__c);
            }
            
            else{
                approverID.add(act.Project_Owner_Approver__c);
            }
              
        }
         
            
        else if(action != 'submission'){           
                
                if(act.name__c == 'Pricing Proto to PMG/Pricing release'){
                    approverID.add(act.Approver_1__c);
                    approverID.add(act.OwnerID);
                }
            else{
                approverID.add(act.OwnerID);
            }
        }
     }
  }
    
    public void sendMail(id active){
        System.debug('********active***********'+active);
        Id RejectionTemplate;
        map<id,NPD_Activity__c> actMap = new map<id,NPD_Activity__c>([SELECT id,Approval_Email_TemplateID__c,Initial_Submission_Email_TemplateID__c,Name__c,NPD_Stage__c,NPD_Stage__r.ownerID,NPD_Project_Items__r.ownerID,NPD_Stage__r.Name__c,NPD_Stage__r.Type__c FROM NPD_Activity__c WHERE ID =:active]);
        if(approval != TRUE && submission != TRUE)
             RejectionTemplate = [SELECT ID FROM emailTemplate WHERE DeveloperName = 'NPD_Approval_Rejection' LIMIT 1].id;
        List<Messaging.SingleEmailMessage> previewEmails = new List<Messaging.SingleEmailMessage>();
        For(id s:approverID){
        user use = new user();
        use.id = s;
            
       
        Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();
        
          firstPreviewEmail.setUseSignature(false);
          firstPreviewEmail.setSaveAsActivity(false);
            if(approval == TRUE){
                firstPreviewEmail.setTemplateId(actMap.get(active).Approval_Email_TemplateID__c);
            }
            else if(submission == TRUE){
               firstPreviewEmail.setTemplateId(actMap.get(active).Initial_Submission_Email_TemplateID__c); 
            }
            else{
                firstPreviewEmail.setTemplateId(RejectionTemplate);
            }
        firstPreviewEmail.setTargetObjectId(s);
        firstPreviewEmail.setWhatId(active);
        previewEmails.add(firstPreviewEmail);
        
        }
        try {
    
             Messaging.sendEmail(previewEmails);
        }
        catch(exception e){
            system.debug('*****Exception Occured****'+e);
        }

    }
    /**************************************
     * Developed By: Mohammed Raiyan
     * Purpose: To Insert apporvers for activities and sub activities based on type
     * 
     *****************************************************************/
    public  static void updateApprovers(list <NPD_Activity__c> newlist){
        list <NPD_Activity__c> updateactList = new  list <NPD_Activity__c>();
      
      //  Below line commented and replaced by SAI ( Inproduction the profile and user alias names are differenct. )
      //  id admin = [SELECT id from user WHERE profile.name = 'System Administrator' AND Alias = 'rrai'].id;
      
      
      /* id admin;
      
      try{ 
      admin = [SELECT id from user WHERE profile.name = 'NPD- Stage User' AND Alias = 'npd3'].id;
       }
       
       catch(exception admin1)
       {
          system.debug(admin1 +' Sandbox Admin user name replaced with production admin user');
          
       } */
      
       /* list <NPD_Activity__c> actList = new  list <NPD_Activity__c>();
        list <NPD_Activity__c> updateactList = new  list <NPD_Activity__c>();
        list <NPD_Activity__c> ListToUpdate = new  list <NPD_Activity__c>();
        map <id,List<NPD_Stage__c>> stageToProject = new map <id,List<NPD_Stage__c>>();
        map <id,List<NPD_Activity__c>> actToProject = new map <id,List<NPD_Activity__c>>();
        map <id,id> actToProjectMap = new map <id,id>();
        map<id,String> projectnamemap =new map<id,String>();
        
        set <id> projectID = new set <id>();
        actList = newlist;
         
        system.debug('**********Class');
        system.debug('******Activities'+newlist);
            
        for(NPD_Activity__c act:actList ){
            
            projectID.add(act.NPD_Project_Name__c); 
            
        }
        system.debug('********Project Name'+projectID);
        // Activit Query for Approval
        for(NPD_Activity__c act:[SELECT ID,Source__c,Name__c,NPD_Project_Name__c,NPD_Project_Name__r.Development_Route__c,NPD_Project_Name__r.OwnerID,OwnerID FROM NPD_Activity__c WHERE ((Type__c ='Sub-Activity' AND(Name__c ='PB/PM Release , Approval  and Recipt - Optional')) OR (Type__c ='Activity'  AND (Name__c ='Leather Strap For Proto Mfg' OR Name__c = 'Dial for Proto Mfg' OR Name__c = 'Engineering Design - IDS' OR Name__c='Proto Design Input' OR  Name__c='Briefing to IDS'))) AND NPD_Project_Name__c IN:projectID]){
            System.debug('act.NPD_Project_Name__c'+act.NPD_Project_Name__c);
            if(act.NPD_Project_Name__c != NULL){
            actToProjectMap.put(act.ID,act.NPD_Project_Name__r.OwnerID);
                
            if(act.NPD_Project_Name__r.Development_Route__c!=NULL)    
            projectnamemap.put(act.ID, act.NPD_Project_Name__r.Development_Route__c); // Map holding the id of the particular activity and project object   
            System.debug('actToProjectMapactToProjectMap'+actToProjectMap);
            System.debug('projectnamemapprojectnamemap'+projectnamemap);
             }  
            
            
            
                
            if(actToProject.containskey(act.NPD_Project_Name__c)){
               // actToProjectMap.put(act.ID,act.NPD_Project_Name__r.OwnerID);
                actToProject.get(act.NPD_Project_Name__c).add(act);
                
            }
            else{                
                actToProject.put(act.NPD_Project_Name__c, new  List <NPD_Activity__c> { act });
            }
            
        //
      }
         //Sub Stage or stage Query for Approval
        for(NPD_Stage__c stg:[SELECT ID,Name__c,NPD_Project_Name__c,OwnerID,Source__c FROM NPD_Stage__c WHERE (Name__c ='Marketing Brief/Concept' OR Name__c = 'Concept Finalization') AND NPD_Project_Name__c IN:projectID]){
            if(stg.NPD_Project_Name__c != NULL){
            if(stageToProject.containskey(stg.NPD_Project_Name__c)){
                
                stageToProject.get(stg.NPD_Project_Name__c).add(stg);
            }
            else{                
                stageToProject.put(stg.NPD_Project_Name__c, new  List <NPD_Stage__c> { stg });
            }
        }
      }
     
           
        for(NPD_Activity__c act:actList){
            
            //Project owner of that Project assinnd to Project_Owner_Approver__c 
            
         if(actToProjectMap.get(act.NPD_Project_Name__c) != NULL act.)
                act.Project_Owner_Approver__c = actToProjectMap.get(act.id); */
            
           /* if(stageToProject.get(act.NPD_Project_Name__c) != NULL && stageToProject.containskey(act.NPD_Project_Name__c)){
                for(NPD_Stage__c stage:stageToProject.get(act.NPD_Project_Name__c)){
                    
                    //Owner of stage Marketing Brief/Concept to be automatically assigned as the owner of this activity
                    if(stage.Name__c == 'Marketing Brief/Concept' && stage.ownerID != NULL){
                        act.Marketing_brief_stage_approver__c = stage.ownerID;
                        System.debug('act.Marketing_brief_stage_approver__c'+act.Marketing_brief_stage_approver__c);
                    }
                    
                    
                    if(actToProjectMap.get(act.NPD_Project_Name__c) != NULL  && stage.Source__c!='OSD' && projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route' && (act.Name__c=='2D Drawing/3D Model Release/Approval' ||act.Name__c=='PB/PM Release , Approval and Recipt' || act.Name__c=='PB/PM Release , Approval and Recipt - Optional' || act.Name__c=='Dial Drawing Release and Recipt' || act.Name__c=='Proto Dial Drawing Release and Receipt') ){
                         act.Project_Owner_Approver__c = actToProjectMap.get(act.id);      
                        System.debug('act.Project_Owner_Approver__c'+act.Project_Owner_Approver__c);
                    }
                    
                    
                   
                    
                    
                    
                    System.debug('Out of foract.Name__c'+act.Name__c);
                    System.debug('Out of forstage.Name__c'+stage.Name__c);
                    System.debug('Out of foract.Brand1__c'+act.Brand1__c);
                    System.debug('Out of forstage.ownerID'+stage.ownerID);
                    
                    
                    
                    //If Brand is Titan/Xylys/Nebula – Approval to be sent to Mahendra (Design Manager – Titan)  AND Noitification on approval submission
                    if(stage.Name__c  == 'Concept Finalization'  && (act.Brand1__c=='Titan' || act.Brand1__c=='Nebula' ||act.Brand1__c=='Xylys' && act.Name__c == 'Briefing to IDS')  && stage.ownerID != NULL){
                        System.debug('in of for');
                        for(user use:[Select  Id,Name, UserRole.Name  from user where  UserRole.Name='Design Manager – Titan']){
                            if(use.id!=NULL){
                                
                                act.Design_Manager_Titan__c=use.id;
                                if(stage.ownerID!=NULL)
                                act.Approver_1__c = stage.ownerID;
                                system.debug(' act.Design_Manager_Titan__c'+act.Design_Manager_Titan__c);
                                system.debug(' act.act.Approver_1__c'+ act.Approver_1__c);
                                
                            }
                        }
                        
                    }
                    
                    // If Brand is Fastrack – Approval to be sent to Hemanth (Design Manager – Fastrack) AND Noitification on approval submission
                    if(stage.Name__c  == 'Concept Finalization'  && (act.Brand1__c=='Fastrack' && act.Name__c == 'Briefing to IDS')  && stage.ownerID != NULL){
                        System.debug('in of for');
                        for(user use:[Select  Id,Name, UserRole.Name  from user where  UserRole.Name='Design Manager – Fastrack']){
                            if(use.id!=NULL){
                                
                                act.Design_Manager_Fastrack__c=use.id;
                                if(stage.ownerID!=NULL)
                                act.Approver_1__c = stage.ownerID;
                                system.debug(' act.Design_Manager_Titan__c'+ use.id);
                                system.debug(' act.Design_Manager_Titan__c'+  act.Design_Manager_Titan__c);
                                
                            }
                        }
                        
                    }
                    
                    // If Brand is Sonata – Approval to be sent to Suparna (Design Manager – Sonata) AND Noitification on approval submission
                    if(stage.Name__c  == 'Concept Finalization'  && (act.Brand1__c=='Sonata' && act.Name__c == 'Briefing to IDS')  && stage.ownerID != NULL){
                        System.debug('in of for');
                        for(user use:[Select  Id,Name, UserRole.Name  from user where  UserRole.Name='Design Manager – Sonata']){
                            if(use.id!=NULL){
                                
                                act.Design_Manager_Sonata__c=use.id;
                                if(stage.ownerID!=NULL)
                                act.Approver_1__c = stage.ownerID;
                                
                                
                                system.debug(' act.Design_Manager_Sonata__c'+ use.id);
                                system.debug(' act.Design_Manager_Titan__c'+  act.Design_Manager_Sonata__c);
                            }
                        }
                        
                    }
                    
                    
                }
            }
            
            
           
            
            
            if(actToProject.get(act.NPD_Project_Name__c) != NULL && actToProject.containskey(act.NPD_Project_Name__c)){              
                
                
                for(NPD_Activity__c actlobj:actToProject.get(act.NPD_Project_Name__c)){
                    //Activity 
                    System.debug(' actlobj.Name__c'+actlobj.Name__c);
                    System.debug(' act.Name__cc'+ act.Name__c);
                    System.debug(' actlobj.ownerID'+ actlobj.ownerID);
                    if(actlobj.Name__c == 'Proto Design Input' && (act.Name__c == 'PB/PM Release , Approval  and Recipt - Optional' || act.Name__c=='2D Drawing/3D Model Release/Approval' || act.Name__c=='Proto Dial Drawing Release and Receipt' ||act.Name__c =='PB/PM Release , Approval  and Recipt' ) && actlobj.ownerID != NULL){
                        
                        act.Approve_2__c= actlobj.ownerID;    
                        System.debug(' act.Approve_2__c'+ act.Approve_2__c);
                    }
                    
                    
                    //&& stage.Source__c!='OSD' need to include Source at activity level
                    System.debug('actlobj.Source__c'+actlobj.Source__c);
                    System.debug('projectnamemap.get(act.id)'+projectnamemap.get(act.id));
                    
                    if(actlobj.Name__c == 'Leather Strap For Proto Mfg' && (act.Name__c == 'PB/PM Release , Approval  and Recipt - Optional'|| act.Name__c == 'PB/PM Release , Approval  and Recipt') && actlobj.ownerID != NULL  && actlobj.Source__c!='OSD'&& projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route' ){
                        act.Approver_1__c = actlobj.ownerID;
                         System.debug(' act.Approver_1__c'+ act.Approver_1__c);   
                    } 
                    
                    if(actlobj.Name__c == 'Dial for Proto Mfg' && (act.Name__c == 'Dial Drawing Release and Recipt' || act.Name__c == 'Proto Dial Drawing Release and Receipt' ) &&   actlobj.ownerID != NULL  && actlobj.Source__c!='OSD'&& projectnamemap.get(act.id)!=NULL && projectnamemap.get(act.id)!='Component Route' ){
                        act.Approver_1__c = actlobj.ownerID;
                       
                        
                    }
                    
                    
                    if(actlobj.Name__c == 'Engineering Design - IDS' && actlobj.ownerID != NULL){
                        
                        act.Engineering_Design_Approver__c = actlobj.ownerID;
                    } 
                    
                    system.debug('actlobj.Name__c'+actlobj.Name__c);
                    //Cost Estimation and Approval---Approval to be sent to owner of activity “Briefing to IDS”
                    //Notification to team leader[Details Needed]
                    if(actlobj.Name__c == 'Briefing to IDS' && actlobj.ownerID != NULL && act.Name__c=='Cost Estimation and Approval'){
                         
                        act.Approver_1__c = actlobj.ownerID;
                         system.debug(' act.Approver_1__c'+ act.Approver_1__c);
                    } 
                    
                   
                    
                }
            }   */
      /*   for(NPD_Activity__c act:newlist){
             act.Project_Owner_Approver__c = admin;
             act.Marketing_brief_stage_approver__c = admin; 
             act.Approver_1__c = admin; 
             act.Engineering_Design_Approver__c  = admin;
             act.Approve_2__c = admin; 
             act.Design_Manager_Fastrack__c = admin;       
            updateactList.add(act);    
        }
        
        
        if(updateactList.size()>0){
            update updateactList;
        }  */
        
    }
    
    /************************************************************************************
     * CreatedBy :Mohammed Raiyan
     * Purpose : To achieve Multilevel Approval Functionality
     * ********************************************************************************/
    
    Public static void MultiApprover(id CheckID,string Status){
        List<string> approversList = new List<string>();
        List<string> NotifierList = new List<string>();
        List<string> NotifierList2 = new List<string>();
        
        if(Status == 'Submission'){
            
            system.debug('*******Submission******');
            NPD_Checklist__c check = [SELECT id,Multi_Approvers__c,NPD_Activity_Chklist__c,Multilevel_Notification__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Approval_Status__c,Approval_Status__c,Current_Approver__c,NPD_Activity_Chklist__r.Multi_Approvers__c,NPD_Activity_Chklist__r.NPD_Project_Name__r.OwnerID FROM NPD_Checklist__c WHERE id =:CheckID LIMIT 1];
            string approverString  = check.NPD_Activity_Chklist__r.Multi_Approvers__c;
            string notification    = check.NPD_Activity_Chklist__r.Multilevel_Notification__c;
            set<id> userId = new set<id>();
            system.debug('******Approver String******'+approverString);
            if(approverString != NULL && approverString != ''){
                ApproversList = approverString.split(',');
                
               string approverDummy = '';
                for(integer i=1;i<ApproversList.size();i++){
                 approverDummy = approverDummy + ApproversList[i] +',';    
               
                 system.debug('*****Splitting Up***'+ApproversList[i]); 
                 }
                system.debug('*****DUmmyApprover'+approverDummy);
                check.Multi_Approvers__c = approverDummy; 
                
                id currentApprover = [SELECT ID,Email FROM User WHERE Email =:ApproversList[0] LIMIT 1].ID;
                id templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_1st_Mail' LIMIT 1].ID;
                check.Current_Approver__c = currentApprover;
                system.debug('***********+CurrentApprover*********'+currentApprover);
                if(check.NPD_Activity_Chklist__r.NPD_Project_Name__r.OwnerID != NULL)
                check.Project_Owner__c = check.NPD_Activity_Chklist__r.NPD_Project_Name__r.OwnerID;
                system.debug('*****Project Owner****'+check.Project_Owner__c);
                check.Approval_Submitter__c = UserInfo.getUserId();
                check.Approval_Status__c ='Pending';
                check.NPD_Activity_Chklist__r.Approval_Status__c ='Pending';
                SendMultiMail(templateID,currentApprover,check);
                SendNotification(templateID,check);                 
                
                try{
                    update check; 
                    }
                    catch(Exception e){
                        system.debug('****Exception Occured***'+e);
                    }
            }
            
        }
        
        
         if(Status == 'Approved'){
             system.debug('*****Approved Condition***');
            id templateID;
            NPD_Checklist__c check = [SELECT id,Approval_Submitter__c,NPD_Activity_Chklist__c,Multilevel_Notification__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Approval_Status__c,Approval_Status__c,Multi_Approvers__c,Project_Owner__c,Current_Approver__c,NPD_Activity_Chklist__r.Multi_Approvers__c,NPD_Activity_Chklist__r.NPD_Project_Name__r.OwnerID FROM NPD_Checklist__c WHERE id =:CheckID LIMIT 1];
            
                
            check.Approval_Submitter__c = UserInfo.getUserId(); 
                
            string approverString  = check.Multi_Approvers__c; 
                
            if(approverString != NULL && approverString != ''){
                
                ApproversList = approverString.split(',');
                system.debug('***Approver List***'+ApproversList);
                string approverDummy = '';
                for(integer i=1;i<ApproversList.size();i++){
                 approverDummy = approverDummy + ApproversList[i] +',';    
               
                 system.debug('*****Splitting Up***'+ApproversList[i]); 
                 }
                system.debug('*****DUmmyApprover'+approverDummy);
                check.Multi_Approvers__c = approverDummy; 
                
                system.debug('**** Updated Approver List**'+check.Multi_Approvers__c);
                if(ApproversList.size() == 3){  
                     system.debug('******size****'+ApproversList.size());
                    templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_3rd_Mail' LIMIT 1].ID;
                    check.Current_Approver__c = check.Project_Owner__c;                
                    SendMultiMail(templateID,check.Project_Owner__c,check);
                    SendNotification(templateID,check);
                    try{
                    update check; 
                    }
                    catch(Exception e){
                        system.debug('****Exception Occured***'+e);
                    }
                    return ;
                }
                else if(ApproversList.size() == 0){
                         system.debug('******size****'+ApproversList.size());
                         templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_6th_Mail' LIMIT 1].ID;
                         check.Approval_Status__c ='Approved';
                                         
                        SendNotification(templateID,check);
                    try{
                        update check; 
                    }
                    catch(Exception e){
                        system.debug('****Exception Occured***'+e);
                    }
                    return ;
                    
                    }
                else{  
                    system.debug('*******Current Approver[0]***'+ApproversList[0]);
                    id currentApprover = [SELECT ID,Email FROM User WHERE Email =:ApproversList[0] AND IsActive=TRUE LIMIT 1 ].ID;
                    
                    if(ApproversList.size() == 4){
                        
                         templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_2nd_Mail' LIMIT 1].ID;
                         system.debug('******size****'+ApproversList.size());
                        SendNotification(templateID,check);
                    }
                    else if(ApproversList.size() == 2){
                             system.debug('******size****'+ApproversList.size());
                          templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_4th_Mail' LIMIT 1].ID; 
                        SendNotification(templateID,check);
                    }
                    else if(ApproversList.size() == 1){
                         system.debug('******size****'+ApproversList.size());
                         templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_5th_Mail' LIMIT 1].ID;   
                        SendNotification(templateID,check);
                    }
                    
                    
                   
                  system.debug('******Template ID****'+templateID); 
                   system.debug('******Current Approver  ID****'+currentApprover);  
                    check.Current_Approver__c = currentApprover;                
                    SendMultiMail(templateID,currentApprover,check);
                try{
                    update check; 
                    }
                    catch(Exception e){
                        system.debug('****Exception Occured***'+e);
                    }
             }
           }
          
             else{
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You do not have the access to approve this item'));
             }
        }
        
        if(Status == 'Re-Submit' || Status == 'Dropped'){
            NPD_Checklist__c check = [SELECT id,Multi_Approvers__c,Multilevel_Notification__c,Approval_Status__c,Approval_Submitter__c,Current_Approver__c,NPD_Activity_Chklist__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Multi_Approvers__c,NPD_Activity_Chklist__r.NPD_Project_Name__r.OwnerID FROM NPD_Checklist__c WHERE id =:CheckID LIMIT 1];
            id userID = check.Approval_Submitter__c;            
            string approverString  = check.Multi_Approvers__c;
            ApproversList = approverString.split(',');
            id templateID;
            
             if(ApproversList.size() == 4){  
                    
                    templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_Reject_3rd_Mail' LIMIT 1].ID;
             }
            
            if(ApproversList.size() == 5){
                        
                         templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_Reject_2nd_Mail' LIMIT 1].ID;                    
                    }
                    else if(ApproversList.size() == 3){
                        
                          templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_Reject_4th_Mail' LIMIT 1].ID;                    
                    }
                    else if(ApproversList.size() == 2){
                        
                         templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_Reject_5th_Mail' LIMIT 1].ID;                    
                    }
                    
                    else if(ApproversList.size() == 1){
                        
                         templateID = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'NPD_Multi_Level_Approval_Reject_6th_Mail' LIMIT 1].ID;                    
                    }
            
            
            if(Status == 'Re-Submit'){
                check.Approval_Status__c = 'Re-Submit';
                SendMultiMail(templateID,userID,check);
                SendNotification(templateID,check);
            }
            if(Status == 'Dropped'){
                check.Approval_Status__c = 'Dropped';                
            }
            check.Multi_Approvers__c = check.NPD_Activity_Chklist__r.Multi_Approvers__c;
            try{
                    update check; 
                }
            catch(Exception e){
                        system.debug('****Exception Occured***'+e);
              }            
        }  
        
       
    }
    
    
    public static void SendNotification(id templateID,NPD_Checklist__c check){
         List<string> NotifierList = new List<string>();
         List<string> NotifierList2 = new List<string>();
         string notification    = check.NPD_Activity_Chklist__r.Multilevel_Notification__c;
         set<id> userId = new set<id>();
            
         if(notification != NULL && notification !=''){
                  NotifierList = notification.split('!');
                    string notifyDummy = '';
                    for(integer i=1;i<NotifierList.size();i++){
                        notifyDummy = notifyDummy +  NotifierList[i] +'!';
                      // check.Multilevel_Notification__c =check.Multilevel_Notification__c + NotifierList[i] +'!';                       
                        
                    }
                    check.Multilevel_Notification__c = notifyDummy;
                      for(string notify:NotifierList[0].split(',')){
                          NotifierList2.add(notify);
                          System.debug('**********Splitting First Notification****'+NotifierList2);
                          
                      }
                    system.debug('****Actual Notifier***'+NotifierList2);
                      if(NotifierList2.size()>0){
                    for(user use:[SELECT ID,Email FROM User WHERE Email IN:NotifierList2]){
                        userId.add(use.id);
                    }  
                   SendMultiNotification(templateID,userId,check);
                  }
                }
        
    }
    
    
    public static void SendMultiMail(id temp,id user,NPD_Checklist__c check){
        List<Messaging.SingleEmailMessage> previewEmails = new List<Messaging.SingleEmailMessage>();
         Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();        
        firstPreviewEmail.setUseSignature(false);
        firstPreviewEmail.setSaveAsActivity(false);           
        firstPreviewEmail.setTemplateId(temp);
        firstPreviewEmail.setTargetObjectId(user);
        firstPreviewEmail.setWhatId(check.NPD_Activity_Chklist__c);
        system.debug('****User ID For mail****'+firstPreviewEmail.TargetObjectId);
        previewEmails.add(firstPreviewEmail);        
        try {    
            system.debug('*****Mail to be sent***'+previewEmails);
             Messaging.sendEmail(previewEmails);
        }
        catch(exception e){
            system.debug('*****Exception Occured****'+e);
        }
        
    }
    
    public static void SendMultiNotification(id temp,set<id> user,NPD_Checklist__c check){
        
        List<Messaging.SingleEmailMessage> previewEmails = new List<Messaging.SingleEmailMessage>();
        for(id use:user){
         Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();        
        firstPreviewEmail.setUseSignature(false);
        firstPreviewEmail.setSaveAsActivity(false);           
        firstPreviewEmail.setTemplateId(temp);
        firstPreviewEmail.setTargetObjectId(use);
        firstPreviewEmail.setWhatId(check.NPD_Activity_Chklist__c);
        previewEmails.add(firstPreviewEmail); 
        }
        try {    
             Messaging.sendEmail(previewEmails);
        }
        catch(exception e){
            system.debug('*****Exception Occured****'+e);
        }            
    }    
}