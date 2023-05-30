public class NPDApprovalController {
    public Id recId{get;set;}
    public id checkId{get;set;}
    public NPD_Activity__c activity{get;set;}
    public NPD_Stage__c   stage{get;set;}
    public List<Sobject> sobjList{get;set;}
    
    
    // These two maps are used to display the  table hearders and records in visual force page
    map<String,string> checklistfieldMap;
    map<id,NPD_Checklist__c> checkListMap;
    public map<string,string> displaymap{get;set;}
    public List<NPD_Checklist__History> fieldHistoy{get;set;}
    public boolean isEditMode{get;set;}
    public List<task> taskList{get;set;}
    public boolean displayPopUp{get;set;}
    public List<ProcessInstanceStep> processSteps{get;set;} 
    public list<attachment> allatts {Set;get;}
    public npd_stage__c stage1{set;get;}
    public NPD_Activity__c activity1{get;set;}
    public string projectType{set;get;}
    public boolean allowattach {set;get;}

   public string isapprove {set;get;}
   public string isdropped{set;get;}
    
    id projectNameId = null;
    

    
   
    public NPDApprovalController() {
    
    
       
        
      
        
        checkListMap            =   new map<id,NPD_Checklist__c>();
        recId                   =   ApexPages.currentPage().getParameters().get('id');
        fieldHistoy             =   new List<NPD_Checklist__History>();
        displayPopUp            =   false;
        
        activity                =   null;
        stage                   =   null;
        isEditMode              =   false;
         
        checklistfieldMap  =  new map<String,string>();
        displaymap         =  new map<String,string>();
        sobjList           =  new List<Sobject>();
        stage1     = new npd_stage__c();
        activity1  = new npd_activity__c();
        
        if(recId != null ) {
            
            String objectType = String.valueOf(recId.getSobjectType());
            String fieldStr   = returnFields(objectType);
            String query  =  'SELECT NPD_Stage__r.NPD_Collections__c,NPD_Activity__r.NPD_Project_Name__c,NPD_Collections__r.name,NPD_Activity__r.NPD_Project_Name__r.ownerid, NPD_Activity__r.NPD_Stage__c,NPD_Activity__r.Name__c,NPD_Activity__r.NPD_Stage__r.name__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c,  ';
          // String query1  = 'Select Tentative_Launch_Plan__c,id,OwnerId,NPD_Project_Name__c,Type__c,Planned_Start_Date__c,Planned_End_Date__c,Actual_Start_Date__c,Name,Actual_End_Date__c,Status__c,Line_Item_Approval_Required__c,Marketing_brief_concept_reference_number__c,Approval_Required__c,Name__c,Approval_Status__c,Brand1__c,Sub_Brand1__c,Collection_reference__c    ';
            
            String query1='Select NPD_Collections__r.name,Comments_Remarks__c,Marketing_brief_concept_reference_number__c,Source__c,Sub_Brand1__c,Phase__c,Market__c,Collection_reference__c,Brand1__c,Actual_Lead_Time__c,Revised_End_Date__c ,Revised_Start_Date__c ,NPD_User__c,ownerId,Revision_Substage__c,Name__c,Tentative_Launch_Plan__c ,Name,Type__c,Line_Item_Approval_Required__c,Approval_Status__c,Complexity_typess__c,Planned_Lead_Time__c,Planned_Start_Date__c,NPD_Project_Name__r.NPD_Collections__r.Collection_Name__c,Planned_End_Date__c,Actual_Start_Date__c,Actual_End_Date__c,NPD_Project_Items__r.Field_Set__c,Status__c,id,NPD_Stage__c,Active__c,Position__c,NPD_Project_Name__r.NPD_Collections__c,Owner1__c,Design_Manager__c,Approval_Required__c';
            
            query = query  + ((fieldStr != '' && fieldStr != null) ? fieldStr  : ' Id ');
            
            allatts = new list<attachment>();
            allatts = [select id,name,parentid,Description from attachment where parentid=:recId];
            
            try{
            
                if(objectType.equalsIgnoreCase('NPD_Activity__c')) {
                    String checkListStr   =  returnFields('NPD_Checklist__c');
                    query = query+' ,(SELECT '+checkListStr+' FROM NPD_Checklists__r) FROM ' + objectType+' WHERE Id=:recId LIMIT 1';
                    
                    activity  = (NPD_Activity__c)DataBase.query(query);
                    for(NPD_Checklist__c check : activity.NPD_Checklists__r) {
                        checkListMap.put(check.id,check);
                    }                    
                    approvalHistory(activity.id);
                                        
                    Set<String> reomoveFieldSet = new set<String>{'CreatedById','CreatedDate','CurrencyIsoCode',
                                                                  'IsDeleted','LastModifiedById','Id',
                                                                  'LastModifiedDate','OwnerId','SystemModstamp',
                                                 'Multi_Approvers__c','Current_Approver__c','Columns_to_Copy__c','Multilevel_Notification__c','Activity_Reference__c','CollectionId__c','NPD_Activity_Chklist__c','Name','Product_Designer_Email__c','ProjectId__c','Row_Number__c','Tech_Designer_Email__c','Engineering_Designer_Email__c','parent_activity_name__c'};
                    for(Sobject sobj : (List<Sobject>) activity.NPD_Checklists__r) {
                        if(!checklistfieldMap.isEmpty()){
                            for(String field : checklistfieldMap.keySet()) {
                                if(!reomoveFieldSet.contains(field) && sobj.get(field) != null  && sobj.get(field) != '') {
                              //  system.debug('The sobj vales of itterations are : '+ field);
                                
                                    displaymap.put(field,checklistfieldMap.get(field));
                                    
                                    //system.debug('Thev alue of checklistfieldMap.get(field) :'+ checklistfieldMap.get(field) );
                                }
                            }
                            
                            
                            displaymap.put('Remarks__c','Remarks');
                            
                        }
                        sobjList.add(sobj);
                        system.debug('The sobj vales are : '+ sobj);
                    }
                    
                } else if(objectType.equalsIgnoreCase('NPD_Stage__c')){
                    query = query1+' FROM ' + objectType+' WHERE Id=:recId LIMIT 1';
                    stage     = (NPD_Stage__c)DataBase.query(query);
                }
                taskList  = [SELECT Id, Who.Id, status,priority,activitydate,Subject, OwnerId,Who.Type FROM Task WHERE WhatId =:recId];
            Integer excp = (test.isRunningTest() ? (1/0) : 1);
            } catch(Exception excp) { System.debug('**********Error while gettint the curretn record*******'); }
        }
        
        
        
         // For identifying the current record is marketing stage or other stages.
         
         string objectName1 ='';
         
        objectName1 =  String.valueOf(recId.getSobjectType());
          if(objectName1.equalsIgnoreCase('NPD_Activity__c')) {
          
           npd_activity__c na1 = [select id,name__c,NPD_Project_Name__r.name from npd_activity__C where id=:recId];
           
            if(na1.NPD_Project_Name__r.name == 'Marketing Brief/Concept Stage')
            {
               projectType = 'marketingstage';
               system.debug('projectType is:'+projectType);
            }
            
            else
             {
               projectType = 'otherstage';
                system.debug('projectType is:'+projectType);
             }
          
          }
          
           if(objectName1.equalsIgnoreCase('NPD_Stage__c')) {
           
           npd_stage__c ns2 =[select id,name__c,NPD_Project_Name__r.name from npd_Stage__c where id =:recId ];
           
           if(ns2.NPD_Project_Name__r.name == 'Marketing Brief/Concept Stage')
           {
           
            if(ns2.NPD_Project_Name__r.name == 'Marketing Brief/Concept Stage')
            {
               projectType = 'marketingstage';
               system.debug('projectType is:'+projectType);
            }
            
            else
             {
               projectType = 'otherstage';
                system.debug('projectType is:'+projectType);
             }
           
           }
           
           
           }
          
        
        
    }
    
    
    private String returnFields(String objectName) {
        Map<String,Schema.SObjectField> mfields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        List<String> fieldsList   = new List<String>();
        for(Schema.SObjectField field : mfields.values()) {
            fieldsList.add(field.getDescribe().getName());
            if(objectName.equalsIgnoreCase('NPD_Checklist__c')) {
                checklistfieldMap.put(field.getDescribe().getname(),field.getDescribe().getLabel());
            }
        }
        
        String fieldStr  =  String.join(fieldsList,',');
        return fieldStr;
    }
    
    
    public void editCheckList() {
        isEditMode  = true;
    }
    
 /*    commented by sai.    public void saveCheckList() {
        



        integer count     = 0;
        for(sobject sobj : sobjList) {
            if(sobj.get('Approval_Status__c') == 'Re-Submit') {
                 activity.Approval_Status__c  = 'Re-Submit';
                 break;    
            } else if(sobj.get('Approval_Status__c') == 'Approved' && activity.Approval_Status__c != 'Approved'){
                activity.Approval_Status__c  = 'Approved';    
        activity.Status__c  = 'Completed'; 
        isapprove = 'YesApprove';
            
               // activity.Actual_End_Date__c = date.today();
            } 
            else if(sobj.get('Approval_Status__c') == 'Dropped') {
                count = count+1;
                if(count == sobjList.size()) {
                    activity.Approval_Status__c  = 'Dropped';
        activity.Status__c  = 'In Progress';

                }
            }
        }
        System.Debug('==activity.Approval_Status__c=='+activity.Approval_Status__c);
        if(activity.Approval_Status__c  == 'Approved'){
           // activity.Status__c = 'Completed';
           // activity.Actual_End_Date__c = date.today();
        }
        SavePoint spt;
        try{
            spt  =  DataBase.setSavepoint();
            
            System.debug('activityStatus__c '+activity);
            update activity;
            update sobjList;
            isEditMode = false;}Catch(Exception excp) {DataBase.rollBack(spt);System.debug('**********Error while updating the checklists*******'+excp.getMessage()); }
    }  */  
    
    
    
    
    
 public void saveCheckList() {
         boolean resubmit =false;
        
        for(sobject sobj : sobjList) {
            if(sobj.get('Approval_Status__c') == 'Re-Submit' || sobj.get('Approval_Status__c') == 'Pending')
            {
                resubmit =true;
            }
        }
        
        integer count     = 0;
        for(sobject sobj : sobjList) {
        
        if(resubmit == true)
        {   
            if(sobj.get('Approval_Status__c') == 'Re-Submit' || sobj.get('Approval_Status__c') == 'Pending') {
                 activity.Approval_Status__c  = 'Re-Submit';
                 break;   
                 
            }
        }       
            
            else if(sobj.get('Approval_Status__c') == 'Approved' && activity.Approval_Status__c != 'Approved'){
                activity.Approval_Status__c  = 'Approved';    
        //activity.Status__c  = 'Completed'; 

            
               // activity.Actual_End_Date__c = date.today();
            } 
            else if(sobj.get('Approval_Status__c') == 'Dropped') {
                count = count+1;
                if(count == sobjList.size()) {
                    activity.Approval_Status__c  = 'Dropped';
        activity.Status__c  = 'In Progress';

                }
            }
        }
        
        
        for(sobject sobj : sobjList) {

          if(sobj.get('Approval_Status__c') == 'None'  || sobj.get('Approval_Status__c') == 'Pending'  || sobj.get('Approval_Status__c') == 'Line Item Pending')  
         {
             activity.Approval_Status__c='Line Item Pending'; 
             break; 
         }
        }
        
        
        SavePoint spt;
        try{
            spt  =  DataBase.setSavepoint();
            
            System.debug('activityStatus__c '+activity);
            update activity;
            update sobjList;
            isEditMode = false;}Catch(Exception excp) {DataBase.rollBack(spt);System.debug('**********Error while updating the checklists*******'+excp.getMessage()); }
    }  
    
    
    
    
    
    public void CancelCheckList() {
        isEditMode = false;
    }
    
    public pagereference redirectDetailView() {
        if(activity.NPD_Project_Name__c != null) {
          String Url ='/apex/PDMSEditPage?proID=' + activity.NPD_Project_Name__c + '&brand=' + activity.Brand1__c+ '&coll=' + activity.NPD_Collections__r.name;
            //String Url ='/apex/NPD_DetailView_Page?proID='+activity.NPD_Project_Name__c;
            
            PageReference reference=new PageReference(url);
            reference.setRedirect(true);
            return reference;
        }
        
        return null;
        
    }
    
    
    public pagereference redirectDetailViewstage() {
        if(Stage.NPD_Project_Name__c != null) {
            //String Url ='/apex/NPD_DetailView_Page?proID='+Stage.NPD_Project_Name__c;
             String Url ='/apex/PDMSEditPage?proID=' + Stage.NPD_Project_Name__c + '&brand=' + Stage.Brand1__c+ '&coll=' + Stage.NPD_Collections__r.name;
            PageReference reference=new PageReference(url);
            reference.setRedirect(true);
            return reference;
        }
        
        return null;
        
    }
    
    
    public void ApproveRecord() {
        
        activity.Approval_Status__c  = 'Approved';
        if(activity1.Comments_Remarks__c!= null)
         activity.Comments_Remarks__c = activity1.Comments_Remarks__c;
         system.debug('activity1.Comments_Remarks__c'+activity1.Comments_Remarks__c+activity.id);
         
         try{
             npd_activity__c na1 = [select id,name__c,Comments_Remarks__c from npd_activity__c where id=:activity.id limit 1];
             if(activity1.Comments_Remarks__c!= null)
             na1.Comments_Remarks__c = activity1.Comments_Remarks__c;
             update na1;
           } catch(exception er1)
           {
             system.debug('er1 is: '+  er1);
           }
         
         
         
        // update activity; 
        approvOrReject('Approve');
        
        
        
        
        }
        
        
         public void ApproveRecordstage() {
        Stage.Approval_Status__c  = 'Approved';
        
        approvOrReject('Approve');
        
        try{    
            system.debug('stage1.Comments_Remarks__c is: ' +stage1.Comments_Remarks__c);
        npd_stage__c ns1 =[select id,name__c,Comments_Remarks__c from npd_stage__c where id=:recId];
        ns1.Comments_Remarks__c = stage1.Comments_Remarks__c;
        update ns1;
         }
         catch(exception ns1exp)
         {
          system.debug('ns1exp:' + ns1exp);
         }
        
        
        
        //Stage.Approval_Status__c  = 'Approved';
        
        
    }
    
    public void RejectRecord() {
            
            activity.Approval_Status__c  = 'Re-Submit';
            if(activity1.Comments_Remarks__c != null)
            activity.Comments_Remarks__c = activity1.Comments_Remarks__c;
            system.debug('activity1.Comments_Remarks__c'+activity1.Comments_Remarks__c+activity.id);
        //update activity; 
        
          try{
             npd_activity__c na1 = [select id,name__c,Comments_Remarks__c from npd_activity__c where id=:activity.id limit 1];
             if(activity1.Comments_Remarks__c!= null)
             na1.Comments_Remarks__c = activity1.Comments_Remarks__c;
             update na1;
           } catch(exception er1)
           {
             system.debug('er1 is: '+  er1);
           }
        
            approvOrReject('Reject');
            }
            
        
        public void RejectRecordstage() {    
            stage.Approval_Status__c  = 'Re-Submit';
            
            approvOrReject('Reject');
        try{    
            system.debug('stage1.Comments_Remarks__c is: ' +stage1.Comments_Remarks__c);
        npd_stage__c ns1 =[select id,name__c,Comments_Remarks__c from npd_stage__c where id=:recId];
        ns1.Comments_Remarks__c = stage1.Comments_Remarks__c;
        update ns1;
         }
         catch(exception ns1exp)
         {
          system.debug('ns1exp: '+ ns1exp);
         }
    }
    
    /*
    * This method will Approve the opportunity
    */
    private void approvOrReject(string action)
    {
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments(action);
        req.setAction(action);
        
        Id workItemId = getWorkItemId(recId); 
        
        if(workItemId != null)
        {
            req.setWorkitemId(workItemId);
            // Submit the request for approval
            Approval.ProcessResult result =  Approval.process(req);
        }
        
        // After approval of marketing stage then planned end date, planned start date should be the approved of marketing stage record.
    if(action == 'Approve')
    {
          date todaysDate ;
    Datetime dt =  date.today();
     
      todaysDate =  dt.date();
        
        list<npd_stage__c> nSubsToUpdate = new list<npd_Stage__c>();
        Date subStgEndDate;
        string objectName11 =  String.valueOf(recId.getSobjectType());
        if(objectName11 =='npd_stage__c')
        {
          for(npd_stage__c nstg:[select id,name__c,planned_start_date__c,planned_end_date__c,Planned_Lead_Time__c,(select id,name__c,planned_start_date__c,planned_end_date__c,Planned_Lead_Time__c,position__c from stage__r order by position__c ) from npd_stage__c where id=:recId])
          {
             for(npd_stage__c nsubStg:nstg.stage__r)
             { 
               if(nsubStg.position__c ==1)
                {
                nsubStg.planned_start_date__c = todaysDate;
                nsubStg.planned_end_date__c = todaysDate.addDays(Integer.valueOf(nsubStg.Planned_Lead_Time__c));
                
                subStgEndDate = nsubStg.planned_end_date__c;
                system.debug('The subStgEndDate is:' + subStgEndDate);
                
                nSubsToUpdate.add(nsubStg);
                }
                
                if(nsubStg.position__c ==2)
                {
                nsubStg.planned_start_date__c = subStgEndDate.addDays(1);
                nsubStg.planned_end_date__c = nsubStg.planned_start_date__c.addDays(Integer.valueOf(nsubStg.Planned_Lead_Time__c));
                nSubsToUpdate.add(nsubStg);
                }
            }
              // update Marketing stage.
              
               nstg.planned_start_date__c =  todaysDate;
               nstg.planned_end_date__c =   todaysDate.adddays(Integer.valueOf(nstg.Planned_Lead_Time__c));
               nSubsToUpdate.add(nstg);
        }
        
           update nSubsToUpdate;
        
    }
    }
    }
    
    private Id getWorkItemId(Id targetObjectId)
    {
        Id retVal = null;

        for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p
            where p.ProcessInstance.TargetObjectId =: targetObjectId])
        {
            retVal  =  workItem.Id;
        }

        return retVal;
    }
    public void approvalHistory(id recordId) {
        processSteps = [select createdbyid,ActorId,createddate, processinstance.LastActorId,StepNodeId,Comments, ProcessInstanceId, OriginalActorId, StepStatus from ProcessInstanceStep where ProcessInstance.TargetObjectId =: recordId];
    }
    
    public void viewFieldHistory() {
        displayPopUp  = true;
        fieldHistoy = [SELECT CreatedById,CreatedDate,NewValue,OldValue,Field,Parent.Case_Sourcing__c FROM NPD_Checklist__History WHERE Field = 'Approval_Status__c' AND ParentId =: CheckId];
    }
     
    public void closePopup() {
        displayPopUp   = false;
    }
    
    
    public void approveCheckList() {
    
       NPDChkboxDynamicApproval.MultiApprover(checkId,'Approved');         
    }
    
    public void rejectCheckList() {
    
    NPDChkboxDynamicApproval.MultiApprover(checkId,'Re-Submit');
    }
    
    public void droppedCheckList() {
    
    NPDChkboxDynamicApproval.MultiApprover(checkId,'Dropped');
    }
    
    
    
   public Boolean getApprovalActionsVisible() {
            
        boolean temp            =   false;
        String subactivityStr   =   'Pilot Work Order request/ Pilot Work Order Creation/Pilot assembly Completion & Feedback/Feedback closure(CAPA)/Bulk assembly clearance/Bulk Work order release';
        String activitystr      =   'Production Clearance';
        String subStageStr      =   'Watch and Component Production';
        String stageStr         =   'Production';   
        
            
        if( activity.name__c.equalsIgnoreCase(subactivityStr) && activity.NPD_Activity__r.Name__c.equalsIgnoreCase(activityStr) && activity.NPD_Activity__r.NPD_Stage__r.name__c.equalsIgnoreCase(subStageStr) && activity.NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c.equalsIgnoreCase(stageStr) ) {
                temp        =   true;
        }
                        
        return temp;
   
   }
   
    public void showAttachment()
    {
    allowattach = true;
    }
    
    public void hideAttachment()
    {
    allowattach = false;
    }
    
    public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }

  public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = recid; // the record the file is attached to
   system.debug('the recid at attachment level is :'+ recid);

    try {
      attachment.name = attachment.name +'.';
      insert attachment;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }

  
 public void demo1(){
    integer a=2;
    integer b=3;
      integer a2 = a+b;
integer a3 = a+b;
integer a4 = a+b;
integer a5 = a+b;
integer a6 = a+b;
integer a7 = a+b;
integer a8 = a+b;
integer a9 = a+b;
integer a10 = a+b;
integer a11 = a+b;
integer a12 = a+b;
integer a13 = a+b;
integer a14 = a+b;
integer a15 = a+b;
integer a16 = a+b;
integer a17 = a+b;
integer a18 = a+b;
integer a19 = a+b;
integer a20 = a+b;
integer a21 = a+b;
integer a22 = a+b;
integer a23 = a+b;
integer a24 = a+b;
integer a25 = a+b;
integer a26 = a+b;
integer a27 = a+b;
integer a28 = a+b;
integer a29 = a+b;
integer a30 = a+b;
integer a31 = a+b;
integer a32 = a+b;
integer a33 = a+b;
integer a34 = a+b;
integer a35 = a+b;
integer a36 = a+b;
integer a37 = a+b;
integer a38 = a+b;
integer a39 = a+b;
integer a40 = a+b;
integer a41 = a+b;
integer a42 = a+b;
integer a43 = a+b;
integer a44 = a+b;
integer a45 = a+b;
integer a46 = a+b;
integer a47 = a+b;
integer a48 = a+b;
integer a49 = a+b;
integer a50 = a+b;
integer a51 = a+b;
integer a52 = a+b;
integer a53 = a+b;
integer a54 = a+b;
integer a55 = a+b;
integer a56 = a+b;
integer a57 = a+b;
integer a58 = a+b;
integer a59 = a+b;
integer a60 = a+b;
integer a61 = a+b;
integer a62 = a+b;
integer a63 = a+b;
integer a64 = a+b;
integer a65 = a+b;
integer a66 = a+b;
integer a67 = a+b;
integer a68 = a+b;
integer a69 = a+b;
integer a70 = a+b;
integer a71 = a+b;
integer a72 = a+b;
integer a73 = a+b;
integer a74 = a+b;
integer a75 = a+b;
integer a76 = a+b;
integer a77 = a+b;

integer a84 = a+b;
integer a85 = a+b;
integer a86 = a+b;
integer a87 = a+b;
integer a88 = a+b;
integer a89 = a+b;
integer a90 = a+b;
integer a91 = a+b;
integer a92 = a+b;
integer a93 = a+b;
integer a94 = a+b;
integer a95 = a+b;
integer a96 = a+b;
integer a97 = a+b;
integer a98 = a+b;
integer a99 = a+b;
integer a100 = a+b;
integer a101 = a+b;
integer a102 = a+b;
integer a103 = a+b;
integer a104 = a+b;
integer a105 = a+b;
integer a106 = a+b;
integer a107 = a+b;
integer a108 = a+b;
integer a109 = a+b;
integer ewr = a+b;
integer wr = a+b;
integer a1wr01 = a+b;
integer a10e2 = a+b;
integer a10e3 = a+b;
integer a10t4 = a+b;
integer a10b5 = a+b;
integer a10g6 = a+b;
integer a1b07 = a+b;
integer a10g8 = a+b;
integer a1g09 = a+b;
integer a1gqww = a+b;
integer a1r00 = a+b;
integer a1r01 = a+b;
integer a1r02 = a+b;
integer a1r03 = a+b;
integer a1r04 = a+b;
integer a1r05 = a+b;
integer a1r06 = a+b;
integer a1r07 = a+b;
integer a1r08 = a+b;
integer a1r09 = a+b;
integer a1qwrw = a+b;

integer a1rr02 = a+b;
integer a1rr03 = a+b;
integer a10rr4 = a+b;
integer a1rr05 = a+b;
integer a1rr06 = a+b;
integer arr107 = a+b;
integer a10rr8 = a+b;
integer a10rr9 = a+b;
integer ewrrr = a+b;
integer wrrr = a+b;
integer a1wrrr01 = a+b;
integer a10err2 = a+b;
integer arr10e3 = a+b;
integer a10rrt4 = a+b;
integer arr10b5 = a+b;
integer a1rr0g6 = a+b;
integer a1brr07 = a+b;
integer arr10g8 = a+b;
integer a1rrrg09 = a+b;
integer a1gqrrww = a+b;
integer a1rrr00 = a+b;
integer a1r0rr1 = a+b;
integer a1r0rr2 = a+b;
integer a1r0rr3 = a+b;
integer a1rrr04 = a+b;
integer a1rrr05 = a+b;
integer a1r0rr6 = a+b;
integer a1r0rr7 = a+b;
integer a1r0rr8 = a+b;
integer a1rrr09 = a+b;
integer a1rrqwrw = a+b;

integer a1r22r02 = a+b;
integer a122rr03 = a+b;
integer a1220rr4 = a+b;
integer a221rr05 = a+b;

integer ar22r107 = a+b;
integer a1220rr8 = a+b;
integer a10rr229 = a+b;
integer ewr22rr = a+b;
integer wr22rr = a+b;
integer a122wrrr01 = a+b;
integer a1220err2 = a+b;
integer arr1022e3 = a+b;
integer a10r22rt4 = a+b;
integer arr10b225 = a+b;
integer a1rr022g6 = a+b;
integer a1brr2207 = a+b;
integer arr1220g8 = a+b;
integer a1rr22rg09 = a+b;
integer a1gq22rrww = a+b;
integer a1rr22r00 = a+b;
integer a1r022rr1 = a+b;
integer a1r0r22r2 = a+b;
integer a1r0r22r3 = a+b;
integer a1rrr2204 = a+b;
integer a122wrrrwe01 = a+b;
integer a1220erwer2 = a+b;
integer arr1022ee3 = a+b;
integer a10r22wrt4 = a+b;
integer arr10wb225 = a+b;
integer a1rr0ww22g6 = a+b;
integer a1brr2w207 = a+b;
integer arr1w220g8 = a+b;
integer a1rr22rg0w9 = a+b;
integer a1gwq22rrww = a+b;
integer a1rr2w2r00 = a+b;
integer a1r022rwr1 = a+b;
integer a1r0r22wr2 = a+b;
integer a1r0r2w2r3 = a+b;
integer a1rrr2w204 = a+b;
integer awe01 = a+b;
integer ba1220erwer2 = a+b;
integer barr1022ee3 = a+b;
integer ba10r22wrt4 = a+b;
integer arbr10wb225 = a+b;
integer a1rbr0ww22g6 = a+b;
integer a1brr2bw207 = a+b;
integer arr1w22b0g8 = a+b;
integer a1rr22brg0w9 = a+b;
integer a1gwqb22rrww = a+b;
integer ba1rr2w2r00 = a+b;
integer ba1r022rwr1 = a+b;
integer ba1r0r22wr2 = a+b;
integer ba1r0r2w2r3 = a+b;
integer ba1rrr2w204 = a+b;
integer a1rr22r05 = a+b;
integer a1r0r22r6 = a+b;
integer a1r0trr7 = a+b;
integer a1r0rr228 = a+b;
integer a1rrr0229 = a+b;
integer a1rrqw22rw = a+b;


    }
}