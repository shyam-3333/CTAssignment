/*
* Company : Kvp Business Solution 
* Author  : Sameer Ranjan
* Description : controller class of SkinnNPD_marketingBriefComponent
* History     : N/L
*/
public with sharing class SkinnNPD_PickListController {
    
    //code for collection picklist
    public static List<PickListClass> getPickListValue(){
        List<PickListClass> returnNameAsPicklist = new List<PickListClass>();
        List<Skinn_Collection__c> skinListCol = [SELECT Id,Name,Marketing_Template__c,
                                                        Project_Template__c,Tentative_Launch_Date__c
                                                        FROM Skinn_Collection__c 
                                                        WHERE Collection_Status__c = 'Open' 
                                                        LIMIT 10000];
        returnNameAsPicklist.add(new PickListClass('--None--',''));
        for(Skinn_Collection__c eachcol :skinListCol){
            returnNameAsPicklist.add(new PickListClass(eachcol.Name,eachcol.Id+','+eachcol.Marketing_Template__c+','+eachcol.Project_Template__c+','+eachcol.Tentative_Launch_Date__c+','+eachcol.Name));
        }
        return returnNameAsPicklist;
    } 
    
    
    //code for the Ownership
    @AuraEnabled
    public static List<PickListClass> getSelectOwner(){
        List<PickListClass> returnOwnerAsPicklist = new List<PickListClass>();
        List<Common_User__c> teamMembers = [SELECT Id,Name 
                                                   FROM Common_User__c 
                                                   WHERE Team__c=:userInfo.getUserId() LIMIT 10000];
        Id profileId=userInfo.getProfileId();
        Boolean isAdminUser = false;
        String profileName = [SELECT Name 
                                     FROM Profile 
                                     WHERE Id =: profileId 
                                     LIMIT 1][0].Name;
        if(profileName == 'System Administrator'){
            isAdminUser = true;
        }
        if(isAdminUser){
            teamMembers = [SELECT Id,Name FROM Common_User__c limit 1000];
        }
        returnOwnerAsPicklist.add(new PickListClass('--None--',''));
        for(Common_User__c skinncolUser :teamMembers){
            returnOwnerAsPicklist.add(new PickListClass(skinncolUser.Name,skinncolUser.Id));
        }
        return returnOwnerAsPicklist;
    }
    //retrive all users
    @AuraEnabled
    public static List<PickListClass> getTaskuser(){
        List<PickListClass> returnOwnerAsPicklist = new List<PickListClass>();
        List<Common_User__c> teamMembers = [SELECT Id,Name FROM Common_User__c limit 1000];
        returnOwnerAsPicklist.add(new PickListClass('--None--',''));
        for(Common_User__c skinncolUser : teamMembers){
            returnOwnerAsPicklist.add(new PickListClass(skinncolUser.Name,skinncolUser.Id));
        }
        return returnOwnerAsPicklist;
    }
    //code for Type
    @AuraEnabled
    public static List<PickListClass> getselectType() {
        List<PickListClass> skinnType = new List < PickListClass > ();
        skinnType.add(new PickListClass('--None--', ''));
        skinnType.add(new PickListClass('Stage', 'Stage/Sub-stage'));
        skinnType.add(new PickListClass('Activity', 'Activity/Sub-Activity'));
        return skinnType;
    }
    
    @AuraEnabled
    public static SkinnNPD_PickListControllerWrapperclass getNameValues(){
        SkinnNPD_PickListControllerWrapperclass returnResult = new SkinnNPD_PickListControllerWrapperclass();
        returnResult.collectionNameList = new List<PickListClass>();
        returnResult.collectionNameList = SkinnNPD_PickListController.getPickListValue();
        returnResult.masterOwnerList = SkinnNPD_PickListController.getSelectOwner();
        returnResult.collectionSelectTypeList = SkinnNPD_PickListController.getselectType();
        returnResult.subjectTaskPickList = GenericLogicClass.getPickListValue('Task','Subject');
        returnResult.statusTaskPickList = GenericLogicClass.getPickListValue('Task','Status');
        returnResult.priorityToTaskPickList = GenericLogicClass.getPickListValue('Task','Priority');
        returnResult.revisionActivationPickListVal = GenericLogicClass.getPickListValue('Skinn_Collection_Template__c', 'Revision_status__c');
        returnResult.taskUserList = SkinnNPD_PickListController.getTaskuser();
        return returnResult;
    }
    //get model list
    @AuraEnabled
    public static list<Skinn_Model__c > fetchModelNames(String selectedCollectionId){
        List<Skinn_Model__c> modelsLst = [SELECT Id, Name FROM Skinn_Model__c WHERE Skinn_Collection__c = :selectedCollectionId ORDER By CreatedDate ASC];
        return modelsLst;
    }
    //get stage, sub-stage and activity item info
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass> fetchMSStageItems (String selectedCollectionId , String templateId,String userId,string modelId){
        List<Skinn_Collection_Template__c> skinnCollectionTempLst = [SELECT Id,Comments_Remarks__c,IsRevisionInProgress__c,
                                                                          Revision_status__c,R1Approved__c,R2Approved__c,
                                                                          R3Approved__c,R4Approved__c,R5Approved__c,Approval_Status__c,
                                                                          R1_Start_Date__c,Approval_Count__c,R1_End_Date__c,R2_Start_Date__c,
                                                                          Approval_required__c,R2_End_Date__c,R3_Start_Date__c,R3_End_Date__c,
                                                                          R4_Start_Date__c,R4_End_Date__c,R5_Start_Date__c,R5_End_Date__c,
                                                                          Status__c,R1_Status__c,R2_Status__c,R3_Status__c,R4_Status__c,R5_Status__c,
                                                                          Skinn_Model__c,planned_Lead_Time__c,planned_Start_Date__c,planned_End_Date__c,
                                                                          Rolling_Planned_Start_Date__c,Rolling_Planned_End_Date__c,
                                                                          Actual_start_date__c,Actual_End_date__c,Actual_Lead_Time__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Id,
                                                                          Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                                          Skinn_NPD_Template_Item__r.Skinn_Model_Item__c,Type__c,Skinn_NPD_Template_Item__c,
                                                                          Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Item_Name__c,
                                                                          Template_Name__r.Name,Order_Number__c,Hierarchy__c,Responsibly__r.Name,Active__c,
                                                                          Skinn_Model__r.Product_Launch_Date__c,
                                                                          (SELECT Id,parentId,Name from Attachments limit 1000),
                                                                          (SELECT Id,Subject,WhatId,Status,Priority,User_Info__c,User_Info__r.Id,ActivityDate,Description FROM Tasks limit 1000),
                                                                          (SELECT Id,parentId,title,Body FROM Notes limit 1000) 
                                                                          FROM Skinn_Collection_Template__c 
                                                                          WHERE Skinn_Collection__c = :selectedCollectionId 
                                                                          AND Template_Name__c = :templateId 
                                                                          AND Responsibly__c=:userId
                                                                          AND Skinn_Model__c=:modelId 
                                                                          ORDER BY Order_Number__c ASC limit 10000];
        Set<Id> skinnCollTempIds = new Set<Id>();
        
        for(Skinn_Collection_Template__c each : skinnCollectionTempLst){
            if(each.Id != NULL){
                skinnCollTempIds.add(each.Id);
            }
        }
        Map<Id,ProcessInstance> mapHishtryRecords = new Map<Id,ProcessInstance>([SELECT Id,TargetObjectId, 
                                                                                (SELECT ID, ProcessNodeId,  
                                                                                StepStatus,Comments,TargetObjectId,ActorId,CreatedById,IsDeleted,IsPending,
                                                                                OriginalActorId,ProcessInstanceId,RemindersSent,CreatedDate, Actor.Name,  
                                                                                OriginalActor.Name , ProcessNode.Name 
                                                                                FROM StepsAndWorkitems ORDER BY TargetObjectId )   
                                                                                FROM ProcessInstance where TargetObjectId in:skinnCollTempIds 
                                                                                ORDER BY TargetObjectId]);
        Map<Id,List<ProcessInstanceHistory>> mapOfProcessNodeIdAndProcessInstanceHistory = new Map<Id,List<ProcessInstanceHistory>>();
        List<ProcessInstanceHistory> tempPHOb;
        for(ProcessInstance each : mapHishtryRecords.values()){
            for(ProcessInstanceHistory each1 : each.StepsAndWorkitems){
                if(mapOfProcessNodeIdAndProcessInstanceHistory.containsKey(each.TargetObjectId)){
                    tempPHOb.add(each1);
                }else{
                    tempPHOb = new List<ProcessInstanceHistory>();
                    tempPHOb.add(each1);
                    mapOfProcessNodeIdAndProcessInstanceHistory.put(each.TargetObjectId,tempPHOb);
                }
            }
        }
        List<SkinnNPD_PickListControllerWrapperclass> returnResut = new List<SkinnNPD_PickListControllerWrapperclass>();
        SkinnNPD_PickListControllerWrapperclass tempWrappClass;
        for(Skinn_Collection_Template__c each:skinnCollectionTempLst){
            tempWrappClass = new SkinnNPD_PickListControllerWrapperclass();
            tempWrappClass.stageStatus = each.Status__c;
            tempWrappClass.modelId = each.Skinn_Model__c;
            tempWrappClass.selectedCollectionTemplateId = each.Id;
            tempWrappClass.type = each.Type__c;
            tempWrappClass.skinnNPDTemplateItemId = each.Skinn_NPD_Template_Item__c;
            tempWrappClass.stageActivityName = each.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
            tempWrappClass.parentName = each.Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Item_Name__c;
            tempWrappClass.orderNumber = String.valueOf(each.Order_Number__c);
            tempWrappClass.plannedLeadTime = String.valueOf(each.planned_Lead_Time__c);
            tempWrappClass.plannedStartDate = each.planned_Start_Date__c;
            tempWrappClass.plannedEndDate = each.planned_End_Date__c;
            tempWrappClass.rollingStartDate = each.Rolling_Planned_Start_Date__c;
            tempWrappClass.rollingEndDate = each.Rolling_Planned_End_Date__c;
            tempWrappClass.actualStartDate = each.Actual_start_date__c;
            tempWrappClass.actualEndDate = each.Actual_End_date__c;
            tempWrappClass.actualLeadTime = each.Actual_Lead_Time__c;
            tempWrappClass.skinnStageId = each.Id;
            tempWrappClass.attachmentList = each.Attachments;
            tempWrappClass.listNotes = each.Notes;
            tempWrappClass.taskList = each.Tasks;
            tempWrappClass.levelHierarchy = each.Hierarchy__c;
            tempWrappClass.commentRemark = each.Comments_Remarks__c;
            tempWrappClass.ownerName = each.Responsibly__r.Name;
            tempWrappClass.isStepActive = each.Active__c;
            tempWrappClass.revisionStatus = each.Revision_status__c;
            tempWrappClass.R1StartDate = each.R1_Start_Date__c;
            tempWrappClass.R1EndtDate = each.R1_End_Date__c;
            tempWrappClass.R2StartDate = each.R2_Start_Date__c;
            tempWrappClass.R2EndtDate = each.R2_End_Date__c;
            tempWrappClass.R3StartDate = each.R3_Start_Date__c;
            tempWrappClass.R3EndtDate = each.R3_End_Date__c;
            tempWrappClass.R4StartDate = each.R4_Start_Date__c;
            tempWrappClass.R4EndtDate = each.R4_End_Date__c;
            tempWrappClass.R5StartDate = each.R5_Start_Date__c;
            tempWrappClass.R5EndtDate = each.R5_End_Date__c;
            tempWrappClass.R1Status = each.R1_Status__c;
            tempWrappClass.R2Status = each.R2_Status__c;
            tempWrappClass.R3Status = each.R3_Status__c;
            tempWrappClass.R4Status = each.R4_Status__c;
            tempWrappClass.R5Status = each.R5_Status__c;
            tempWrappClass.approvalRequired = each.Approval_required__c;
            tempWrappClass.approStatus = each.Approval_Status__c;
            tempWrappClass.isRecordLock = Approval.isLocked(each.Id);
            tempWrappClass.processHitry = mapOfProcessNodeIdAndProcessInstanceHistory.get(each.Id);
            tempWrappClass.IsRevisionInPro = each.IsRevisionInProgress__c;
            tempWrappClass.approvalCount = each.Approval_Count__c;
            tempWrappClass.r1Approval = each.R1Approved__c;
            tempWrappClass.r2Approval = each.R2Approved__c;
            tempWrappClass.r3Approval = each.R3Approved__c;
            tempWrappClass.r4Approval = each.R4Approved__c;
            tempWrappClass.r5Approval = each.R5Approved__c;
            tempWrappClass.skinnCollectionRecordType = each.Type__c;
            tempWrappClass.skinnItemParentId = each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
            tempWrappClass.productLaunchDate = each.Skinn_Model__r.Product_Launch_Date__c;
            returnResut.add(tempWrappClass);
        }
        return returnResut;
    }
    // check who is responsible user of current actiity
    public static Boolean checkResponsiblyUser(string currentResponsibly,String actuaLoginUser){
        //return (currentResponsibly==actuaLoginUser);
        return true;
    }
    // this method use for undo acitivity status
    public static Boolean afterUpdateMethodCall(Skinn_Collection_Template__c currentStep){
        Boolean returnvalue=true;
        //g('currentStep.Skinn_Collection__c'+currentStep.Skinn_Collection__c);
        List<Skinn_Collection_Template__c> getCollectionInfo = [SELECT Id,Skinn_Collection__c 
                                                                FROM Skinn_Collection_Template__c 
                                                                WHERE Id =: currentStep.Id];
        System.debug('getCollectionInfo[0].Skinn_Collection__c'+getCollectionInfo[0].Skinn_Collection__c);
        Skinn_Model__c marketingStageModel = [SELECT Id,Name
                                              FROM Skinn_Model__c 
                                              WHERE Skinn_Collection__c =:getCollectionInfo[0].Skinn_Collection__c
                                              AND Name = 'MarketingStage' limit 1];
        System.debug('marketingStageModel'+marketingStageModel);
        List<Skinn_Collection_Template__c> listOfSkinnCollectionTempRecords = [SELECT Status__c,Type__c,Id,Name,Active__c,
                                                                                      Skinn_NPD_Template_Item__c,
                                                                                      Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Item_Name__c,
                                                                                      Skinn_NPD_Template_Item__r.Parent_Id__c,
                                                                                      Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                                                      Skinn_Collection__c,Item_Names__r.Name,Item_Names__r.Parent_Id__r.Type__c,
                                                                                      Item_Names__r.Parent_Id__c,Item_Names__r.Type__c 
                                                                                      FROM  Skinn_Collection_Template__c
                                                                                      WHERE SKinn_Model__c=:currentStep.SKinn_Model__c 
                                                                                      OR SKinn_Model__c=:marketingStageModel.Id];
        Map<Id,Skinn_Collection_Template__c> mapofCollectionTemp = new Map<Id,Skinn_Collection_Template__c>();
        Map<Id,Skinn_Collection_Template__c> mapOfSkinnCollectionTempRecord = new Map<Id,Skinn_Collection_Template__c>();
        for(Skinn_Collection_Template__c each : listOfSkinnCollectionTempRecords){
            if(each.Skinn_NPD_Template_Item__c != null){
                mapOfSkinnCollectionTempRecord.put(each.Skinn_NPD_Template_Item__c,each);
            }
            mapofCollectionTemp.put(each.Id,each);
        }
        Id parentId = mapofCollectionTemp.get(currentStep.Id).Skinn_NPD_Template_Item__r.Parent_Id__c;
        while (!mapOfSkinnCollectionTempRecord.get(parentId).Active__c) {
            parentId = mapOfSkinnCollectionTempRecord.get(parentId).Skinn_NPD_Template_Item__r.Parent_Id__c;
        }
        parentId = mapOfSkinnCollectionTempRecord.get(parentId).Id;
        if(mapofCollectionTemp.get(parentId).Type__c=='Sub-Stage'){
            Id subStageId = parentId;
            Id stageId = mapofCollectionTemp.get(parentId).Skinn_NPD_Template_Item__r.Parent_Id__c;
            Id StageParentId = mapOfSkinnCollectionTempRecord.get(stageId).Skinn_NPD_Template_Item__r.Parent_Id__c;
            stageId = mapOfSkinnCollectionTempRecord.get(stageId).Id;
            SET<Id> subStageIds = new SET<Id>();
            subStageIds.add(subStageId);
            subStageIds.add(stageId);
            List<Skinn_Collection_Template__c> isHasStage = [SELECT Id,planned_Start_Date__c,
                                                                    Planned_Lead_Time__c,planned_End_Date__c,
                                                                    Actual_start_date__c,Type__c,Status__c 
                                                                    FROM Skinn_Collection_Template__c 
                                                                    WHERE Id in:subStageIds 
                                                                    AND Status__c=:'Not Started'];
            if(marketingStageModel.Id == currentStep.SKinn_Model__c){
                if(StageParentId == NULL || mapOfSkinnCollectionTempRecord.get(StageParentId).Status__c == 'Completed'){
                    for(Skinn_Collection_Template__c each : isHasStage){
                        each.Actual_start_date__c = currentStep.Actual_start_date__c;
                        each.Status__c = 'In Progress';
                    }
                    Database.update(isHasStage);
                }else{
                    returnvalue = false;
                }
            }else{
                List<Skinn_Collection_Template__c> allMarkeSatgeRecord = [SELECT Id,Status__c 
                                                                          FROM Skinn_Collection_Template__c 
                                                                          WHERE Skinn_Model__c =: marketingStageModel.Id and Active__c = true];
                Boolean IsAllComp = true;
                for(Skinn_Collection_Template__c each : allMarkeSatgeRecord){
                    if(each.Status__c != 'Completed'){
                        IsAllComp = false;
                    }
                }
                if(!IsAllComp){
                    returnvalue = false;
                }else{
                    if(StageParentId == NULL || mapOfSkinnCollectionTempRecord.get(StageParentId) == NULL ||  mapOfSkinnCollectionTempRecord.get(StageParentId).Status__c == 'Completed'){
                        for(Skinn_Collection_Template__c each : isHasStage){
                            each.Actual_start_date__c = currentStep.Actual_start_date__c;
                            each.Status__c = 'In Progress';
                        }
                        Database.update(isHasStage);
                    }else{
                        returnvalue = false;
                    }
                }
                
            }
            
        }
        if(mapofCollectionTemp.get(parentId).Type__c == 'Stage'){
            Id stageId = mapofCollectionTemp.get(parentId).Skinn_NPD_Template_Item__r.Parent_Id__c;
            SET<Id> subStageIds = new SET<Id>();
            stageId = mapOfSkinnCollectionTempRecord.get(stageId).Id;
            subStageIds.add(parentId);
            List<Skinn_Collection_Template__c> isHasStage = [SELECT Id,planned_Start_Date__c,
                                                                    Planned_Lead_Time__c,planned_End_Date__c,
                                                                    Actual_start_date__c,Type__c,Status__c 
                                                                    FROM Skinn_Collection_Template__c 
                                                                    WHERE Id in:subStageIds AND Status__c=:'Not Started'];
            if(stageId == NULL || mapofCollectionTemp.get(stageId).Status__c == 'Completed'){
                for(Skinn_Collection_Template__c each : isHasStage){
                    //each.planned_Start_Date__c=System.today();
                    //each.planned_End_Date__c=System.today()+integer.valueOf(each.Planned_Lead_Time__c)-1;
                    each.Actual_start_date__c=currentStep.Actual_start_date__c;
                    each.Status__c='In Progress';
                }
                Database.update(isHasStage);
            }else{
                returnvalue=false;
            }
        }
        return returnvalue;
    }
    //this method validate order of activity completion
    public static Boolean validateParentStageStatus(Skinn_Collection_Template__c currentStep){
        Boolean returnvalue;
        List<Skinn_Collection_Template__c> listOfSkinnCollectionTempRecords = [SELECT Status__c, Type__c, Id, Name,
                                                                                      Active__c, Skinn_NPD_Template_Item__c,
                                                                                      Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Item_Name__c,
                                                                                      Skinn_NPD_Template_Item__r.Parent_Id__c,
                                                                                      Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                                                      Skinn_Collection__c, Item_Names__r.Name, Item_Names__r.Parent_Id__r.Type__c,
                                                                                      Item_Names__r.Parent_Id__c, Item_Names__r.Type__c 
                                                                                      FROM  Skinn_Collection_Template__c 
                                                                                      WHERE SKinn_Model__c =: currentStep.SKinn_Model__c];
        Map<Id,Skinn_Collection_Template__c> mapofCollectionTemp = new Map<Id,Skinn_Collection_Template__c>();
        Map<Id,Skinn_Collection_Template__c> mapOfSkinnCollectionTempRecord = new Map<Id,Skinn_Collection_Template__c>();
        for(Skinn_Collection_Template__c each : listOfSkinnCollectionTempRecords){
            if(each.Skinn_NPD_Template_Item__c != null){
                mapOfSkinnCollectionTempRecord.put(each.Skinn_NPD_Template_Item__c,each);
            }
            mapofCollectionTemp.put(each.Id,each);
        }
        Id parentId = mapofCollectionTemp.get(currentStep.Id).Skinn_NPD_Template_Item__r.Parent_Id__c;
        while (!mapOfSkinnCollectionTempRecord.get(parentId).Active__c) {
            parentId=mapOfSkinnCollectionTempRecord.get(parentId).Skinn_NPD_Template_Item__r.Parent_Id__c;
        }
        parentId = mapOfSkinnCollectionTempRecord.get(mapOfSkinnCollectionTempRecord.get(parentId).Skinn_NPD_Template_Item__c).Id;
        System.debug('parentIdparentIdparentIdparentId'+parentId);
        List<Skinn_Collection_Template__c> validateSkinnStage = [SELECT Id,Name,Status__c
                                                                 FROM Skinn_Collection_Template__c 
                                                                 WHERE Id =: parentId];
        System.debug('mapofCollectionTemp.get(parentId).Type__c ='+mapofCollectionTemp.get(parentId).Type__c);
        returnvalue = validateSkinnStage.size() >0 ? (mapofCollectionTemp.get(parentId).Type__c == 'Activity' ? (validateSkinnStage[0].Status__c == 'Completed' ? true : false) :true) :false;
        System.debug('true...................'+returnvalue);
        return returnvalue;
    }
    //save record into Skinn Collection Template Object
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass> saveStageActRecord(List<String> JsonStringList,String collectionId,String userId,String templateId){
        SkinnNPD_PickListControllerWrapperclass attaFileObject = new SkinnNPD_PickListControllerWrapperclass();
        SkinnNPD_PickListControllerWrapperclass notesFileObject = new SkinnNPD_PickListControllerWrapperclass();
        Skinn_Collection_Template__c record = new Skinn_Collection_Template__c();
        System.debug('JsonStringList[0]'+JsonStringList[0]);
        if(JsonStringList[0] != null){
            record = (Skinn_Collection_Template__c)JSON.deserialize( JsonStringList[0], Skinn_Collection_Template__c.class);
            If(record.Actual_start_date__c!=null){
                record.Status__c='In Progress';
            }
        }
        try{
            if(record != null && record.Actual_start_date__c != null){
                Skinn_Collection_Template__c currentCollectionTempRecord = [SELECT Id,Name,Skinn_NPD_Template_Item__r.Parent_Id__c,
                                                                                   Skinn_NPD_Template_Item__c,Skinn_Collection__c,
                                                                                   Skinn_Collection__r.Name,Item_Names__r.Parent_Id__c,
                                                                                   Responsibly__r.Team__c,Responsibly__c 
                                                                                   FROM Skinn_Collection_Template__c 
                                                                                   WHERE Id=:record.Id limit 1];
                if(currentCollectionTempRecord.Skinn_NPD_Template_Item__r.Parent_Id__c!=null){
                    if(validateParentStageStatus(record)){
                        Database.update(record);
                        if(!afterUpdateMethodCall(record)){
                            record.Status__c = 'Not Started ';
                            record.Actual_start_date__c = NULL;
                            Database.update(record);
                            SkinnNPD_PickListControllerWrapperclass verifyUser = new SkinnNPD_PickListControllerWrapperclass();
                            verifyUser.valideUser = false;
                            System.debug('Frist One');
                            verifyUser.errorMessage = 'Previous step is not completed Yet!';
                            List<SkinnNPD_PickListControllerWrapperclass> notAuthorize = new List<SkinnNPD_PickListControllerWrapperclass>();
                            notAuthorize.add(verifyUser);
                            notAuthorize.addAll(fetchMSStageItems(collectionId,templateId,userId,string.valueOf(record.Skinn_Model__c)));
                            return notAuthorize;
                        }else{
                            record.Status__c = 'In Progress';
                            System.debug('record'+record.Skinn_NPD_Template_Item__r.Parent_Id__r.Id);
                            Database.update(record);
                            rollingDateCaluculation(record);
                        }
                    }
                    else{
                        SkinnNPD_PickListControllerWrapperclass verifyUser = new SkinnNPD_PickListControllerWrapperclass();
                        verifyUser.valideUser = false;
                        System.debug('Frist24165 One');
                        verifyUser.errorMessage = 'Previous step is not completed Yet!';
                        List<SkinnNPD_PickListControllerWrapperclass> notAuthorize = new List<SkinnNPD_PickListControllerWrapperclass>();
                        notAuthorize.add(verifyUser);
                        notAuthorize.addAll(fetchMSStageItems(collectionId,templateId,userId,string.valueOf(record.Skinn_Model__c)));
                        return notAuthorize;
                    }
                }
            }
            emailNotification(record.Id);
            return fetchMSStageItems(collectionId,templateId,userId,string.valueOf(record.Skinn_Model__c));
        }catch(Exception E){
            SkinnNPD_PickListControllerWrapperclass verifyUser=new SkinnNPD_PickListControllerWrapperclass();
            verifyUser.valideUser=false;
            System.debug('E'+E);
            System.debug('Exception Line'+E.getLineNumber());
            if(E.getMessage().split(',').size()>=2){
                verifyUser.errorMessage=E.getMessage().split(',')[1].split(':')[0];
            }
            else{
                verifyUser.errorMessage=E.getMessage();
            }
            List<SkinnNPD_PickListControllerWrapperclass> notAuthorize=new List<SkinnNPD_PickListControllerWrapperclass>();
            notAuthorize.add(verifyUser);
            notAuthorize.addAll(fetchMSStageItems(collectionId,templateId,userId,string.valueOf(record.Skinn_Model__c)));
            return notAuthorize;
        }
    }

    private static void rollingDateCaluculation(Skinn_Collection_Template__c record){
        System.debug('record'+record.Skinn_NPD_Template_Item__r.Parent_Id__r.Id);
        if( (record.Type__c == 'Activity' || record.Type__c == 'Sub-Stage') && record.Revision_status__c == null){
            // Fatch All Record of collection
            Skinn_Project_Launch_Date__c projectLaunchDateCustomSetting = Skinn_Project_Launch_Date__c.getOrgDefaults();
            Skinn_Import_Model_Type__c ifModelPMSImportCustomSetting = Skinn_Import_Model_Type__c.getOrgDefaults();
            Map<Id ,Skinn_Collection_Template__c> maplistSkinnCollTempRecords = new Map<Id ,Skinn_Collection_Template__c>([SELECT Id, Skinn_Model__c, Skinn_Model__r.Name, Status__c, Item_Name__c,
                                                                                                                                    Order_Number__c, Skinn_Collection__c, Type__c, IsStageStartDateRolling__c, 
                                                                                                                                    Rolling_Planned_Start_Date__c,Rolling_Planned_End_Date__c,
                                                                                                                                    Actual_start_date__c, Actual_End_date__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Id,
                                                                                                                                    Skinn_Model__r.Product_Launch_Date__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Type__c,
                                                                                                                                    Skinn_NPD_Template_Item__c
                                                                                                                                    FROM Skinn_Collection_Template__c 
                                                                                                                                    WHERE Skinn_Model__c =:record.Skinn_Model__c
                                                                                                                                    ORDER BY Skinn_Model__c, Order_Number__c 
                                                                                                                                    LIMIT 10000]);
            
            Set<Id> skinnModelIds = new Set<Id>();
            List<Skinn_Model__c> updateModelRecordsForLaunchDate = new List<Skinn_Model__c> ();
            Map<String,Skinn_Collection_Template__c> downwordMap = new Map<String,Skinn_Collection_Template__c>();//key: Parent Id and value: child Id
            Map<String,Skinn_Collection_Template__c> upwordMap = new Map<String,Skinn_Collection_Template__c>();//key: child Id and value: Parent Id  
            Set<Id> allStageIds = new Set<Id>();
            Map<Id,Id> modelWithStageId = new Map<Id,Id>();
            for(Skinn_Collection_Template__c each : maplistSkinnCollTempRecords.values()){
                if(each.Type__c=='Stage'){
                    if(!modelWithStageId.containsKey(each.Skinn_Model__c)){
                        modelWithStageId.put(each.Skinn_Model__c,each.Id);
                    }
                    skinnModelIds.add(each.Skinn_Model__c);
                }
                if(each.Type__c=='Stage'){
                    allStageIds.add(each.Id);
                }
                upwordMap.put(each.skinn_Collection__c+','+each.Skinn_Model__c+','+each.Skinn_NPD_Template_Item__c,each);
                downwordMap.put(each.skinn_Collection__c+','+each.Skinn_Model__c+','+each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id,each);      
            }
            List<Skinn_Collection_Template__c> listUpdatedRecords = new List<Skinn_Collection_Template__c>();
            String recordkey = record.Skinn_Collection__c+','+record.Skinn_Model__c+','+record.Skinn_NPD_Template_Item__c;
            Skinn_Collection_Template__c temVar = new Skinn_Collection_Template__c();
            while(downwordMap.get(recordkey) != null){
                temVar = downwordMap.get(recordkey);
                recordkey = temVar.Skinn_Collection__c+','+temVar.Skinn_Model__c+','+temVar.Skinn_NPD_Template_Item__c;
                listUpdatedRecords.add(temVar);
            }
            String findStageRecord = record.Skinn_Collection__c+','+record.Skinn_Model__c+','+maplistSkinnCollTempRecords.get(record.Id).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
            String findSubStageRecord = findStageRecord;
            while(upwordMap.get(findStageRecord).Type__c != 'Stage'){
                temVar = upwordMap.get(findStageRecord);
                findStageRecord = temVar.Skinn_Collection__c+','+temVar.Skinn_Model__c+','+temVar.Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                if(upwordMap.get(findSubStageRecord).Type__c != 'Sub-Stage'){
                    temVar = upwordMap.get(findSubStageRecord);
                    findSubStageRecord = temVar.Skinn_Collection__c+','+temVar.Skinn_Model__c+','+temVar.Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                }
            }
            if(maplistSkinnCollTempRecords.get(record.Id).Skinn_Model__r.Name == 'MarketingStage'){
                for(Id eachId : allStageIds){
                    if(maplistSkinnCollTempRecords.containsKey(eachId) && (maplistSkinnCollTempRecords.get(upwordMap.get(findStageRecord).Id).Order_Number__c < maplistSkinnCollTempRecords.get(eachId).Order_Number__c )){
                       listUpdatedRecords.add(maplistSkinnCollTempRecords.get(eachId));
                    }
                } 
            } else {
                for(Id eachId : allStageIds){
                    if(maplistSkinnCollTempRecords.get(eachId).Skinn_Model__c == maplistSkinnCollTempRecords.get(record.Id).Skinn_Model__c && (maplistSkinnCollTempRecords.containsKey(eachId) && (maplistSkinnCollTempRecords.get(upwordMap.get(findStageRecord).Id).Order_Number__c < maplistSkinnCollTempRecords.get(eachId).Order_Number__c ))){
                        listUpdatedRecords.add(maplistSkinnCollTempRecords.get(eachId));
                    }
                }
            }
            Date actualStartDate = record.Actual_start_date__c;
            Date actualEndDate = record.Actual_End_date__c;
            Date rollingStartDate = record.Rolling_Planned_Start_Date__c;
            Date rollingEndDate = record.Rolling_Planned_End_Date__c;
            Integer datemargin;

            if(actualStartDate != null && actualEndDate == null){
                datemargin = rollingStartDate.daysBetween(actualStartDate) ;
                record.Rolling_Planned_Start_Date__c = record.Actual_start_date__c;
                record.Rolling_Planned_End_Date__c = record.Rolling_Planned_End_Date__c.addDays(datemargin);                    
                for(Skinn_Collection_Template__c each : listUpdatedRecords){
                        each.Rolling_Planned_Start_Date__c = each.Rolling_Planned_Start_Date__c.addDays(datemargin);
                        each.Rolling_Planned_End_Date__c = each.Rolling_Planned_End_Date__c.addDays(datemargin);
                }
                if(upwordMap.get(findStageRecord) != null){
                    if(maplistSkinnCollTempRecords.get(record.Id).Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Type__c == 'Stage' || maplistSkinnCollTempRecords.get(record.Id).Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Type__c =='Sub-Stage'){
                        if(!upwordMap.get(findStageRecord).IsStageStartDateRolling__c){
                            upwordMap.get(findStageRecord).Rolling_Planned_Start_Date__c = actualStartDate;
                            upwordMap.get(findStageRecord).IsStageStartDateRolling__c = true;
                        }
                        upwordMap.get(findStageRecord).Rolling_Planned_End_Date__c = upwordMap.get(findStageRecord).Rolling_Planned_End_Date__c.addDays(datemargin);
                    } else {
                        upwordMap.get(findStageRecord).Rolling_Planned_End_Date__c = upwordMap.get(findStageRecord).Rolling_Planned_End_Date__c.addDays(datemargin);
                    }
                    listUpdatedRecords.add(upwordMap.get(findStageRecord));
                }
                if( record.Type__c !='Sub-Stage' && upwordMap.get(findSubStageRecord) != null && upwordMap.get(findSubStageRecord).Type__c =='Sub-Stage'){
                    if(maplistSkinnCollTempRecords.get(record.Id).Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Type__c == 'Stage' || maplistSkinnCollTempRecords.get(record.Id).Skinn_NPD_Template_Item__r.Parent_Id__r.Skinn_Model_Item__r.Type__c =='Sub-Stage'){
                        upwordMap.get(findSubStageRecord).Rolling_Planned_Start_Date__c = actualStartDate;
                        upwordMap.get(findSubStageRecord).Rolling_Planned_End_Date__c = upwordMap.get(findSubStageRecord).Rolling_Planned_End_Date__c.addDays(datemargin);
                    } else {
                        upwordMap.get(findSubStageRecord).Rolling_Planned_End_Date__c = upwordMap.get(findSubStageRecord).Rolling_Planned_End_Date__c.addDays(datemargin);
                    }
                    listUpdatedRecords.add(upwordMap.get(findSubStageRecord));
                }
                listUpdatedRecords.add(record);
            } else if(actualStartDate != null && actualEndDate != null) {
                datemargin = rollingEndDate.daysBetween(actualEndDate);
                record.Rolling_Planned_End_Date__c = record.Rolling_Planned_End_Date__c.addDays(datemargin); 
                if(upwordMap.get(findStageRecord) != null && upwordMap.get(findStageRecord).Status__c != 'Completed'){
                    listUpdatedRecords.add(upwordMap.get(findStageRecord));
                }
                if(upwordMap.get(findSubStageRecord) != null && upwordMap.get(findSubStageRecord).Type__c =='Sub-Stage' && upwordMap.get(findSubStageRecord).Status__c != 'Completed'){
                    listUpdatedRecords.add(upwordMap.get(findSubStageRecord));
                }                          
                for(Skinn_Collection_Template__c each : listUpdatedRecords){
                    if(each.Type__c == 'Activity'){
                        each.Rolling_Planned_Start_Date__c = each.Rolling_Planned_Start_Date__c.addDays(datemargin);
                        each.Rolling_Planned_End_Date__c = each.Rolling_Planned_End_Date__c.addDays(datemargin);
                    } else if(each.Type__c == 'Sub-Stage' || each.Type__c=='Stage') {
                        each.Rolling_Planned_End_Date__c = each.Rolling_Planned_End_Date__c.addDays(datemargin);
                    }
                }
                listUpdatedRecords.add(record);
            }
            if(!listUpdatedRecords.isEmpty() && datemargin != 0){
                System.debug('listUpdatedRecords'+listUpdatedRecords);
                //CheckRecursive.skinnCollectionTemplateTriggerFlag = false;
                Database.update(listUpdatedRecords);
            }
        }
    }
    //deactivate activity method
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass> deactivateCollectionTemp(String collTempId,String userId,String skinnCollTempId,String templateId,String modelId){
        Skinn_Collection_Template__c desableRecord=[SELECT Id,Active__c,Name FROM Skinn_Collection_Template__c where Id=:collTempId limit 1];
        desableRecord.Active__c=false;
        update desableRecord;
        return fetchMSStageItems(skinnCollTempId,templateId,userId,modelId);
    }
    //this method use to alert to respective responsible user after completion of activity
    public static void emailNotification(Id recordId){
        if(recordId!=null){
            Skinn_Collection_Template__c recordInfo = [SELECT Id,Skinn_Collection__c,
                                                              Responsibly__r.User_Email__c,
                                                              Responsibly__r.Name,
                                                              Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                              Skinn_NPD_Template_Item__c,Template_Name__c,Skinn_Model__c,Status__c
                                                              FROM Skinn_Collection_Template__c 
                                                              WHERE Id=:recordId 
                                                              LIMIT 1];
            if(recordInfo.Status__c=='Completed'){
                List<Skinn_Collection_Template__c> listSkinnCollTempRecords = [SELECT Id,Type__c,Responsibly__r.User_Email__c,
                                                                               Responsibly__r.Name,Skinn_Collection__c,
                                                                               Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                                               Template_Name__c,Skinn_NPD_Template_Item__c,
                                                                               Skinn_NPD_Template_Item__r.Parent_Id__r.Id 
                                                                               FROM Skinn_Collection_Template__c 
                                                                               WHERE  Skinn_Collection__c =: recordInfo.Skinn_Collection__c 
                                                                               AND Template_Name__c =: recordInfo.Template_Name__c 
                                                                               AND Skinn_Model__c =: recordInfo.Skinn_Model__c];
                Map<Id,Skinn_Collection_Template__c> downwordMap=new Map<Id,Skinn_Collection_Template__c>();//key: Parent Id and value: child Id
                Map<Id,Skinn_Collection_Template__c> upwordMap=new Map<Id,Skinn_Collection_Template__c>();//key: child Id and value: Parent Id
                for(Skinn_Collection_Template__c each : listSkinnCollTempRecords){
                    upwordMap.put(each.Skinn_NPD_Template_Item__c,each);
                    downwordMap.put(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id,each);
                }
                //find next activity
                if(downwordMap.get(recordInfo.Skinn_NPD_Template_Item__c)!=null){
                    System.debug('recordInfo.Responsibly__r.User_Email__c'+recordInfo.Responsibly__r.User_Email__c);
                    emailAlert(recordInfo.Responsibly__r.User_Email__c,recordInfo.Responsibly__r.Name,recordInfo.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,'Completed');
                    emailAlert(downwordMap.get(recordInfo.Skinn_NPD_Template_Item__c).Responsibly__r.User_Email__c,downwordMap.get(recordInfo.Skinn_NPD_Template_Item__c).Responsibly__r.Name,downwordMap.get(recordInfo.Skinn_NPD_Template_Item__c).Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,'this task assign to you');
                }else{
                    Id currentId=recordInfo.Skinn_NPD_Template_Item__c;
                    if(upwordMap.get(currentId) != null){
                        while (upwordMap.get(currentId).Type__c!='Sub-Stage') {
                            currentId=upwordMap.get(currentId).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                        }
                        emailAlert(recordInfo.Responsibly__r.User_Email__c,recordInfo.Responsibly__r.Name,recordInfo.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,'Completed');
                        emailAlert(upwordMap.get(currentId).Responsibly__r.User_Email__c,upwordMap.get(currentId).Responsibly__r.Name,upwordMap.get(currentId).Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,'Completed');
                    }
                }
            }
        }
    }
    // email send logic
    public static void emailAlert(String toAddresses,String Name,String taskName,String status){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddressesarray = new String[] {''+toAddresses}; 
        mail.setToAddresses(toAddressesarray);
        mail.setSenderDisplayName('Status Update');
        mail.setSubject('Alert');
        mail.setHtmlBody('Hi ' + Name +'  <br> Task Name:'+taskName+
                         '<br> status:'+status);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    // get successor information
    @AuraEnabled
    public static SkinnNPD_PickListControllerWrapperclass successorInfoMethod(String currentRecordId,String collectionId){
        SkinnNPD_PickListControllerWrapperclass returnValue = new SkinnNPD_PickListControllerWrapperclass();
        Skinn_Collection_Template__c record = [SELECT Id,Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                    Skinn_NPD_Template_Item__r.Parent_Id__r.Id,Responsibly__r.User_Email__c,
                                                    Skinn_Model__c,Skinn_NPD_Template_Item__c,Template_Name__c,
                                                    Responsibly__c,Type__c,Approval_Required__c,
                                                    Approval_Status__c 
                                                    FROM Skinn_Collection_Template__c 
                                                    WHERE Id =: currentRecordId 
                                                    AND Skinn_Collection__c =: collectionId
                                                    LIMIT 1];
        Skinn_Collection_Template__c marketingStageInfo = [SELECT Id,Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                                  Skinn_NPD_Template_Item__r.Parent_Id__r.Id,Responsibly__r.User_Email__c,
                                                                  Skinn_Model__c,Skinn_NPD_Template_Item__c,Template_Name__c,
                                                                  Responsibly__c,Type__c,Approval_Required__c,Approval_Status__c 
                                                                  FROM Skinn_Collection_Template__c 
                                                                  WHERE Skinn_Collection__c =: collectionId 
                                                                  AND Skinn_Model__r.Name = 'MarketingStage'
                                                                  LIMIT 1];
        List<Skinn_Collection_Template__c> recordList = [SELECT Id,Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c,
                                                                Skinn_NPD_Template_Item__r.Parent_Id__r.Id,Responsibly__r.User_Email__c,
                                                                Skinn_NPD_Template_Item__c,Template_Name__c,Responsibly__c,Type__c,
                                                                Approval_Required__c,Approval_Status__c 
                                                                FROM Skinn_Collection_Template__c 
                                                                WHERE Skinn_Collection__c =: collectionId 
                                                                AND (Skinn_Model__c =: record.Skinn_Model__c OR Skinn_Model__c =: marketingStageInfo.Skinn_Model__c)];
        Map<Id,Skinn_Collection_Template__c> upwordMap = new Map<Id,Skinn_Collection_Template__c>();
        Map<Id,Skinn_Collection_Template__c> downwordMap = new Map<Id,Skinn_Collection_Template__c>();//key: Parent Id and value: child Id
        Id currentId = record.Skinn_NPD_Template_Item__c;
        for(Skinn_Collection_Template__c each : recordList){
            upwordMap.put(each.Skinn_NPD_Template_Item__c,each);
            downwordMap.put(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id,each);
        }
        while ( upwordMap.get(currentId)!=null && upwordMap.get(currentId).Type__c != 'Stage') {
            currentId = upwordMap.get(currentId).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
        }
        if(downwordMap.get(record.Skinn_NPD_Template_Item__c) == null){
            returnValue.stageInformation = upwordMap.get(currentId);
            returnValue.successorName = 'NULL';
            returnValue.successorRelatedTo = record.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c == null?'NULL':record.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
            returnValue.successorEmail = 'NULL';
        }else{
            returnValue.stageInformation = upwordMap.get(currentId);
            returnValue.successorName = downwordMap.get(record.Skinn_NPD_Template_Item__c).Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c==null?'NULL':downwordMap.get(record.Skinn_NPD_Template_Item__c).Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
            returnValue.successorRelatedTo = record.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c==null?'NULL':record.Skinn_NPD_Template_Item__r.Skinn_Model_Item__r.Item_Name__c;
            returnValue.successorEmail = downwordMap.get(record.Skinn_NPD_Template_Item__c).Responsibly__r.User_Email__c==null?'NULL':downwordMap.get(record.Skinn_NPD_Template_Item__c).Responsibly__r.User_Email__c;
        }
        return returnValue;
    }
    //method for add task
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass> addTaskMethodCall(Task taskJSON){
        Skinn_Collection_Template__c recordInfo = [SELECT Id,Skinn_Model__c,Skinn_Collection__c,
                                                          Template_Name__c,Responsibly__c 
                                                          FROM Skinn_Collection_Template__c 
                                                          WHERE Id =: taskJSON.WhatId 
                                                          LIMIT 1];
        try{
            taskJSON.OwnerId=UserInfo.getUserId();
            Database.insert(taskJSON);
            return fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c));
        }catch(Exception E){
            SkinnNPD_PickListControllerWrapperclass verifyUser=new SkinnNPD_PickListControllerWrapperclass();
            verifyUser.valideUser=false;
            if(E.getMessage().split(',').size()>=2){
                verifyUser.errorMessage=E.getMessage().split(',')[1].split(':')[0];
            }
            else{
                verifyUser.errorMessage=E.getMessage();
            }
            List<SkinnNPD_PickListControllerWrapperclass> notAuthorize = new List<SkinnNPD_PickListControllerWrapperclass>();
            notAuthorize.add(verifyUser);
            notAuthorize.addAll(fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c)));
            return notAuthorize;
        }
    }
    // add note in current record
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass>  addNoteMethod(Note noteSObject){
        //taskJSON.OwnerId=UserInfo.getUserId();
        Skinn_Collection_Template__c recordInfo = [SELECT Id,Skinn_Model__c,Skinn_Collection__c,
                                                          Template_Name__c,Responsibly__c 
                                                          FROM Skinn_Collection_Template__c 
                                                          WHERE Id=:noteSObject.parentId LIMIT 1];
        try{
            Database.insert(noteSObject);
            return fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c));
        }catch(Exception E){
            SkinnNPD_PickListControllerWrapperclass verifyUser=new SkinnNPD_PickListControllerWrapperclass();
            verifyUser.valideUser=false;
            if(E.getMessage().split(',').size()>=2){
                verifyUser.errorMessage = E.getMessage().split(',')[1].split(':')[0];
            }
            else{
                verifyUser.errorMessage = E.getMessage();
            }
            List<SkinnNPD_PickListControllerWrapperclass> notAuthorize = new List<SkinnNPD_PickListControllerWrapperclass>();
            notAuthorize.add(verifyUser);
            notAuthorize.addAll(fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c)));
            return notAuthorize;
        }
    }
    
    //Submit for approval method
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass> submitForAppProcess(String RecId){
        Skinn_Collection_Template__c recordInfo = [SELECT Id,Skinn_Model__c,Skinn_Collection__c,
                                                          Template_Name__c,Responsibly__c 
                                                          FROM Skinn_Collection_Template__c 
                                                          WHERE Id=:RecId
                                                          LIMIT 1];
        try{
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(RecId);        
            Approval.ProcessResult result = Approval.process(req);
            string approvalResult = result.getInstanceStatus();
            return fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c));
        }catch(Exception E){
            SkinnNPD_PickListControllerWrapperclass verifyUser = new SkinnNPD_PickListControllerWrapperclass();
            verifyUser.valideUser=false;
            if(E.getMessage().split(',').size()>=2){
                verifyUser.errorMessage = E.getMessage().split(',')[1].split(':')[0];
            }
            else{
                verifyUser.errorMessage = E.getMessage();
            }
            List<SkinnNPD_PickListControllerWrapperclass> notAuthorize=new List<SkinnNPD_PickListControllerWrapperclass>();
            notAuthorize.add(verifyUser);
            notAuthorize.addAll(fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c)));
            return notAuthorize;
        }
    }
    //add attachment on current record
    @AuraEnabled
    public static List<SkinnNPD_PickListControllerWrapperclass> saveAttcFile(String attachFiel,String  recordId){
        Skinn_Collection_Template__c recordInfo = [SELECT Id,Skinn_Model__c,Skinn_Collection__c,
                                                          Template_Name__c,Responsibly__c 
                                                          FROM Skinn_Collection_Template__c 
                                                          WHERE Id=:recordId 
                                                          LIMIT 1];
        try{ 
            SkinnNPD_PickListControllerWrapperclass  attaFileObject = (SkinnNPD_PickListControllerWrapperclass)JSON.deserialize(attachFiel, SkinnNPD_PickListControllerWrapperclass.class);
            Attachment insertAttachFile = new Attachment();
            if(attaFileObject.baseDate != null){
                insertAttachFile.parentId = recordId;
                insertAttachFile.Body = EncodingUtil.base64Decode(attaFileObject.baseDate);
                insertAttachFile.Name = attaFileObject.filename;
                insertAttachFile.ContentType = attaFileObject.contentType;
                if(insertAttachFile != null){
                    Database.insert(insertAttachFile);
                }
            }
            return fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c));
        }
        catch(Exception E){
            SkinnNPD_PickListControllerWrapperclass verifyUser = new SkinnNPD_PickListControllerWrapperclass();
            verifyUser.valideUser = false;
            if(E.getMessage().split(',').size() >= 2){
                verifyUser.errorMessage = E.getMessage().split(',')[1].split(':')[0];
            }
            else{
                verifyUser.errorMessage = E.getMessage();
            }
            List<SkinnNPD_PickListControllerWrapperclass> notAuthorize = new List<SkinnNPD_PickListControllerWrapperclass>();
            notAuthorize.add(verifyUser);
            notAuthorize.addAll(fetchMSStageItems(String.valueOf(recordInfo.Skinn_Collection__c),String.valueOf(recordInfo.Template_Name__c),String.valueOf(recordInfo.Responsibly__c),String.valueOf(recordInfo.Skinn_Model__c)));
            return notAuthorize;
        }
    }
    
}