public with sharing class SkinnCollectionTemplateTriggerHandler {

    public static Boolean beforeUpdateMethodFlag = true;
    public static Boolean afterUpdateMethodFlag = true;
    public static Boolean dispErrorOnInsertFlag = true; 
    public static Boolean dispErrorRevistionDateErrorFlag = true; 
    public static Boolean revisionDateMethodFlag = true; 
    public static Boolean rollingDateCaluculationFlag = true;   
    public static Boolean updateModelRecordLaunchDateFlag = true;
    private static Skinn_Project_Launch_Date__c projectLaunchDate = Skinn_Project_Launch_Date__c.getOrgDefaults();
    private static Marketing_Stage_Launch_Date__c conditionWithDays = Marketing_Stage_Launch_Date__c.getOrgDefaults();


    public static void beforeUpdateMethod(List<Skinn_Collection_Template__c> listSkinnCollectionTempRecords){
        if(beforeUpdateMethodFlag){
            for(Skinn_Collection_Template__c each:listSkinnCollectionTempRecords){
                if(each.Actual_End_date__c!=null && each.Status__c!='Completed'){
                    System.debug('each.Actual_End_date__c!=null && each.Status__c!=');
                    each.Status__c='Completed';
                }
                if(each.R1_Start_Date__c!=null && each.R1_Status__c!='In Progress'){
                each.R1_Status__c='In Progress';
                }
                if(each.R2_Start_Date__c!=null && each.R2_Status__c!='In Progress'){
                    each.R2_Status__c='In Progress';
                }
                if(each.R3_Start_Date__c!=null && each.R3_Status__c!='In Progress'){
                    each.R3_Status__c='In Progress';
                }
                if(each.R4_Start_Date__c!=null && each.R4_Status__c!='In Progress'){
                    each.R4_Status__c='In Progress';
                }
                if(each.R5_Start_Date__c!=null && each.R5_Status__c!='In Progress'){
                    each.R5_Status__c='In Progress';
                }
                if(each.R1_End_Date__c!=null && each.R1_Status__c!='Completed'){
                each.R1_Status__c='Completed';
                }
                if(each.R2_End_Date__c!=null && each.R2_Status__c!='Completed'){
                    each.R2_Status__c='Completed';
                }
                if(each.R3_End_Date__c!=null && each.R3_Status__c!='Completed'){
                    each.R3_Status__c='Completed';
                }
                if(each.R4_End_Date__c!=null && each.R4_Status__c!='Completed'){
                    each.R4_Status__c='Completed';
                }
                if(each.R5_End_Date__c!=null && each.R5_Status__c!='Completed'){
                    each.R5_Status__c='Completed';
                }
            }
        }
    }
    //Copy End Date in tentative launch date
    public static void updateModelRecordLaunchDate(List<Skinn_Collection_Template__c> listSkinnCollectionTempRecords,Map<Id,Skinn_Collection_Template__c> mapOfOldRecords){
        System.debug('updateModelRecordLaunchDate');
        if(updateModelRecordLaunchDateFlag){
            Set<Id> modelIdwhichNeedToUpdate = new Set<Id>();
            List<Skinn_Model__c> updateModelRecordList = new List<Skinn_Model__c>();
            for(Skinn_Collection_Template__c each : listSkinnCollectionTempRecords){
                if(each.Item_Name__c == projectLaunchDate.Process_Name__c && each.Rolling_Planned_End_Date__c != mapOfOldRecords.get(each.Id).Rolling_Planned_End_Date__c && modelIdwhichNeedToUpdate.add(each.Skinn_Model__c) ){
                    updateModelRecordList.add(new Skinn_Model__c(Id = each.Skinn_Model__c, Product_Launch_Date__c = each.Rolling_Planned_End_Date__c));
                }
                if(each.Item_Name__c == conditionWithDays.Process_Name__c && modelIdwhichNeedToUpdate.add(each.Skinn_Model__c) ){
                    updateModelRecordList.add(new Skinn_Model__c(Id = each.Skinn_Model__c, Product_Launch_Date__c = each.Rolling_Planned_End_Date__c.addDays(Integer.valueOf(conditionWithDays.Lead_Time__c))));
                }
                System.debug('each.Item_Name__c'+each.Item_Name__c);
            }
            if(!updateModelRecordList.isEmpty()){
                CheckRecursive.skinnModelTriggerFlag = false;
                Database.update(updateModelRecordList);
            }
        }
    }
    public static void afterUpdateMethod(List<Skinn_Collection_Template__c> listSkinnCollectionTempRecords,Map<Id,Skinn_Collection_Template__c> mapOfOldSkinnCollTempRecords,Map<Id,Skinn_Collection_Template__c> mapOfNewRecords){
        if(afterUpdateMethodFlag){
            Set<Id> skinnCollTempIds = new Set<Id>(mapOfNewRecords.keySet());
            Set<Id> skinnColletionIds = new Set<Id>();
            Set<Id> skinnModelIds = new Set<Id>();
            Map<Id,Id> mapOfCollTempWithModel = new Map<Id,Id>();
            for(Skinn_Collection_Template__c eachRecord : listSkinnCollectionTempRecords){
                if(eachRecord.Skinn_Collection__c != null){
                    skinnColletionIds.add(eachRecord.Skinn_Collection__c);
                }
                if(eachRecord.Skinn_Model__c != null){
                    skinnModelIds.add(eachRecord.Skinn_Model__c);
                }
                if(!mapOfCollTempWithModel.containsKey(eachRecord.Id)){
                    mapOfCollTempWithModel.put(eachRecord.Id,eachRecord.Skinn_Model__c);
                }
            }
            List<Skinn_Collection_Template__c> skinnColleionTempList = [SELECT Id,Type__c,Name,Skinn_NPD_Template_Item__c,
                                                                            Skinn_Model__c ,Skinn_Collection__c,Skinn_NPD_Template_Item__r.Order_No__c,
                                                                            Skinn_NPD_Template_Item__r.Parent_Id__c,Item_Names__c,Item_Names__r.Parent_Id__c,
                                                                            Status__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Id
                                                                            FROM Skinn_Collection_Template__c where Skinn_Collection__c in:skinnColletionIds AND Skinn_Model__c in:skinnModelIds order by Skinn_NPD_Template_Item__r.Order_No__c,Skinn_Model__c ];
            Map<String,Skinn_Collection_Template__c> downwordMap = new Map<String,Skinn_Collection_Template__c>();//key: Parent Id and value: child Id
            Map<String,Skinn_Collection_Template__c> upwordMap = new Map<String,Skinn_Collection_Template__c>();//key: child Id and value: Parent Id  
            Map<Decimal,Skinn_Collection_Template__c> mapOfSubStage = new Map<Decimal,Skinn_Collection_Template__c>();
            for(Skinn_Collection_Template__c each : skinnColleionTempList){
                upwordMap.put(each.skinn_Collection__c+','+each.Skinn_Model__c+','+each.Skinn_NPD_Template_Item__c,each);
                downwordMap.put(each.skinn_Collection__c+','+each.Skinn_Model__c+','+each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id,each);
            }
            List<Skinn_Collection_Template__c> updatedRecords = new List<Skinn_Collection_Template__c>();
            for(Skinn_Collection_Template__c eachRecord : listSkinnCollectionTempRecords){
                if(eachRecord.Status__c == 'Completed' && mapOfOldSkinnCollTempRecords.get(eachRecord.Id).Status__c != 'Completed' && (eachRecord.Type__c == 'Activity' || eachRecord.Type__c == 'Sub-Stage' )){
                    String findStage = eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+eachRecord.Skinn_NPD_Template_Item__c;
                    String findSubStage = findStage;
                    while (upwordMap.get(findStage).Type__c != 'Stage') {
                        findStage = eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+upwordMap.get(findStage).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                        //findSubStage = eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+upwordMap.get(findStage).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                        if(upwordMap.get(findSubStage).Type__c != 'Sub-Stage'){
                            System.debug('upwordMap.get(findSubStage)'+upwordMap.get(findSubStage));
                            findSubStage = eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+upwordMap.get(findSubStage).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                        }
                    }
                    // if stage have many sub-stage
                    Integer countTheSubStageRecordCompleted = 0;
                    Integer countSubStageRecords = 0;
                    for(Skinn_Collection_Template__c each : skinnColleionTempList){
                        if(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id == upwordMap.get(findStage).Skinn_NPD_Template_Item__c && each.Type__c == 'Sub-Stage' ){
                            countSubStageRecords++;
                        } 
                        if(each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id == upwordMap.get(findStage).Skinn_NPD_Template_Item__c && each.Type__c == 'Sub-Stage' && each.Status__c == 'Completed'){
                            countTheSubStageRecordCompleted++;
                        }
                    }
                    System.debug('countTheSubStageRecordCompleted'+countTheSubStageRecordCompleted);
                    System.debug('countSubStageRecords'+countSubStageRecords);
                    System.debug('upwordMap.get(findSubStage)'+upwordMap.get(findSubStage));
                    System.debug(eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+eachRecord.Skinn_NPD_Template_Item__c);
                    System.debug(downwordMap.get(eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+eachRecord.Skinn_NPD_Template_Item__c));
                    if(upwordMap.get(findSubStage).Type__c == 'Sub-Stage'){
                        if(countTheSubStageRecordCompleted + 1 >= countSubStageRecords && downwordMap.get(eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+eachRecord.Skinn_NPD_Template_Item__c) == null){
                            updatedRecords.add(new Skinn_Collection_Template__c(Id = upwordMap.get(findSubStage).Id ,Actual_End_date__c = eachRecord.Actual_End_date__c, Rolling_Planned_End_Date__c = eachRecord.Actual_End_date__c));
                            updatedRecords.add(new Skinn_Collection_Template__c(Id = upwordMap.get(findStage).Id,Actual_End_date__c = eachRecord.Actual_End_date__c, Rolling_Planned_End_Date__c = eachRecord.Actual_End_date__c));
                        } else if(downwordMap.get(eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+eachRecord.Skinn_NPD_Template_Item__c) == null) {
                            updatedRecords.add(new Skinn_Collection_Template__c(Id = upwordMap.get(findSubStage).Id ,Actual_End_date__c = eachRecord.Actual_End_date__c, Rolling_Planned_End_Date__c = eachRecord.Actual_End_date__c));
                        }
                    } else {
                        if(downwordMap.get(eachRecord.Skinn_Collection__c+','+eachRecord.Skinn_Model__c+','+eachRecord.Skinn_NPD_Template_Item__c) == null){
                            updatedRecords.add(new Skinn_Collection_Template__c(Id = upwordMap.get(findStage).Id ,Actual_End_date__c = eachRecord.Actual_End_date__c, Rolling_Planned_End_Date__c = eachRecord.Actual_End_date__c));
                        }
                    }
                }
            }
            if(!updatedRecords.isEmpty()){
                afterUpdateMethodFlag = false;
                Database.update(updatedRecords);
            }
        }
    }

    public static void dispErrorOnInsert(List<Skinn_Collection_Template__c> listSkinnCollectionTempRecords,map<Id,Skinn_Collection_Template__c> oldMaplistSkinnCollectionTempRecords){
        if(dispErrorOnInsertFlag){
            for(Skinn_Collection_Template__c each : listSkinnCollectionTempRecords){
                if(each.Actual_start_date__c!=null){
                    if(oldMaplistSkinnCollectionTempRecords.get(each.Id).Actual_End_date__c==null && oldMaplistSkinnCollectionTempRecords.get(each.Id).Actual_start_date__c==null ){
                        System.debug('each.Actual_End_date__c'+each.Actual_End_date__c);
                        if(each.Actual_End_date__c!=null){
                            each.AddError('User can only fill Actual Start Date while creating the record for the first time');
                        }
                    }
                }
            }
        }
    }
    //this method put error message when user try to enter start date and end date at same time.
    public static void dispErrorRevistionDateError(List<Skinn_Collection_Template__c> listSkinnCollectionTempRecords,map<Id,Skinn_Collection_Template__c> oldMaplistSkinnCollectionTempRecords){
        if(dispErrorRevistionDateErrorFlag){
            for(Skinn_Collection_Template__c each : listSkinnCollectionTempRecords){
                if(each.R1_Start_Date__c!=null){
                    if(oldMaplistSkinnCollectionTempRecords.get(each.Id).R1_End_Date__c==null && oldMaplistSkinnCollectionTempRecords.get(each.Id).R1_Start_Date__c==null ){
                        System.debug('each.Actual_End_date__c'+each.R1_End_Date__c);
                        if(each.R1_End_Date__c!=null){
                                each.AddError('User can only fill R1 Start Date while updating the record for the first time.');
                        }
                    }
                }
                if(each.R2_Start_Date__c!=null){
                    if(oldMaplistSkinnCollectionTempRecords.get(each.Id).R2_End_Date__c==null && oldMaplistSkinnCollectionTempRecords.get(each.Id).R2_Start_Date__c==null ){
                        System.debug('each.Actual_End_date__c'+each.R2_End_Date__c);
                        if(each.R2_End_Date__c!=null){
                                each.AddError('User can only fill R2 Start Date while updating the record for the first time.');
                        }
                    }
                }
                if(each.R3_Start_Date__c!=null){
                    if(oldMaplistSkinnCollectionTempRecords.get(each.Id).R3_End_Date__c==null && oldMaplistSkinnCollectionTempRecords.get(each.Id).R3_Start_Date__c==null ){
                        System.debug('each.Actual_End_date__c'+each.R3_End_Date__c);
                        if(each.R3_End_Date__c!=null){
                                each.AddError('User can only fill R3 Start Date while updating the record for the first time.');
                        }
                    }
                }
                if(each.R4_Start_Date__c!=null){
                    if(oldMaplistSkinnCollectionTempRecords.get(each.Id).R4_End_Date__c==null && oldMaplistSkinnCollectionTempRecords.get(each.Id).R4_Start_Date__c==null ){
                        System.debug('each.Actual_End_date__c'+each.R4_End_Date__c);
                        if(each.R4_End_Date__c!=null){
                                each.AddError('User can only fill R4 Start Date while updating the record for the first time.');
                        }
                    }
                }
                if(each.R5_Start_Date__c!=null){
                    if(oldMaplistSkinnCollectionTempRecords.get(each.Id).R5_End_Date__c==null && oldMaplistSkinnCollectionTempRecords.get(each.Id).R5_Start_Date__c==null ){
                        System.debug('each.Actual_End_date__c'+each.R5_End_Date__c);
                        if(each.R5_End_Date__c!=null){
                                each.AddError('User can only fill R5 Start Date while updating the record for the first time.');
                        }
                    }
                }
            }
        }

    }
    public static Date returnUpdatedDate(Skinn_Collection_Template__c record){
        Date returnDate;
        if(record.R1_End_Date__c!=null){
            returnDate=record.R1_End_Date__c;
        }
        if(record.R2_End_Date__c!=null){
            returnDate=record.R2_End_Date__c;
        }
        if(record.R3_End_Date__c!=null){
            returnDate=record.R3_End_Date__c;
        }
        if(record.R4_End_Date__c!=null){
            returnDate=record.R4_End_Date__c;
        }
        if(record.R5_End_Date__c!=null){
            returnDate=record.R5_End_Date__c;
        }
        return returnDate;
    }
    //this method call when user revies any activity
    public static void revisionDateMethod(List<Skinn_Collection_Template__c> listSkinnCollecTempRecords,Map<Id,Skinn_Collection_Template__c> mapOldRecords,Map<Id,Skinn_Collection_Template__c> mapNewRecords){
        if(revisionDateMethodFlag){
            Set<Id> collectionIds=new Set<Id>();
            Set<Id> ModelIds=new Set<Id>();
            Map<Id,String> recordWithCollModelMap=new Map<Id,String>();
            Set<Id> recordIds=new Set<Id>();
            for(Skinn_Collection_Template__c each:listSkinnCollecTempRecords){
                if(each.Skinn_Collection__c!=null){
                    collectionIds.add(each.Skinn_Collection__c);
                }
                if(each.Skinn_Model__c!=null){
                    ModelIds.add(each.Skinn_Model__c);
                }
                if(each.Skinn_Collection__c!=null && each.Skinn_Model__c!=null && each.Id!=null){
                    recordWithCollModelMap.put(each.Id,each.Skinn_Collection__c+','+each.Skinn_Model__c);
                    recordIds.add(each.Id);
                }
            }
            List<Skinn_Collection_Template__c> skinnColleionTempList=[SELECT Id,Type__c,Name,Skinn_NPD_Template_Item__c,
                                                                            Skinn_Model__c ,Skinn_Collection__c,Skinn_NPD_Template_Item__r.Order_No__c,
                                                                            Skinn_NPD_Template_Item__r.Parent_Id__c,Item_Names__c,Item_Names__r.Parent_Id__c,
                                                                            Status__c,Skinn_NPD_Template_Item__r.Parent_Id__r.Id
                                                                            FROM Skinn_Collection_Template__c where Skinn_Collection__c in:collectionIds AND Skinn_Model__c=:ModelIds order by Skinn_NPD_Template_Item__r.Order_No__c];
            Map<String,Skinn_Collection_Template__c> downwordMap=new Map<String,Skinn_Collection_Template__c>();//key: Parent Id and value: child Id
            Map<String,Skinn_Collection_Template__c> upwordMap=new Map<String,Skinn_Collection_Template__c>();//key: child Id and value: Parent Id  
            for(Skinn_Collection_Template__c each:skinnColleionTempList){
                upwordMap.put(each.skinn_Collection__c+','+each.Skinn_Model__c+','+each.Skinn_NPD_Template_Item__c,each);
                downwordMap.put(each.skinn_Collection__c+','+each.Skinn_Model__c+','+each.Skinn_NPD_Template_Item__r.Parent_Id__r.Id,each);
            }
            String findstageId;
            String findSubStageId;
            List<Skinn_Collection_Template__c> updateRecords=new List<Skinn_Collection_Template__c>();
            for(Id each:recordIds){
                System.debug('mapNewRecords.get(each).R1_Status__c'+mapNewRecords.get(each).R1_Status__c);
                System.debug('mapNewRecords.get(each).R1_Status__c'+mapNewRecords.get(each).R2_Status__c);
                System.debug('mapNewRecords.get(each).R1_Status__c'+mapNewRecords.get(each).R3_Status__c);
                System.debug('mapNewRecords.get(each).R1_Status__c'+mapNewRecords.get(each).R4_Status__c);
                System.debug('mapNewRecords.get(each).R1_Status__c'+mapNewRecords.get(each).R5_Status__c);
                if(mapNewRecords.get(each).R1_Status__c=='Completed' || mapNewRecords.get(each).R2_Status__c=='Completed' || mapNewRecords.get(each).R3_Status__c=='Completed' || mapNewRecords.get(each).R4_Status__c=='Completed' || mapNewRecords.get(each).R5_Status__c=='Completed'){
                    if(mapNewRecords.get(each).R1_End_Date__c!=null || mapNewRecords.get(each).R2_End_Date__c!=null || mapNewRecords.get(each).R3_End_Date__c!=null || mapNewRecords.get(each).R4_End_Date__c!=null || mapNewRecords.get(each).R5_End_Date__c!=null || mapNewRecords.get(each).R1_Start_Date__c!=null || mapNewRecords.get(each).R2_Start_Date__c!=null || mapNewRecords.get(each).R3_Start_Date__c!=null || mapNewRecords.get(each).R4_Start_Date__c!=null || mapNewRecords.get(each).R5_Start_Date__c!=null){
                        findstageId=recordWithCollModelMap.get(each);
                        findstageId+=','+mapNewRecords.get(each).Skinn_NPD_Template_Item__c;
                        while (upwordMap.get(findstageId).Type__c!='Stage') {
                            findstageId=upwordMap.get(findstageId).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                            findstageId=recordWithCollModelMap.get(each)+','+findstageId;
                        }
                        if(downwordMap.get(findstageId)!=null && downwordMap.get(findstageId).Type__c=='Sub-Stage'){
                            findSubStageId=recordWithCollModelMap.get(each);
                            findSubStageId+=','+mapNewRecords.get(each).Skinn_NPD_Template_Item__c;
                            while (upwordMap.get(findSubStageId).Type__c!='Sub-Stage') {
                                findSubStageId=upwordMap.get(findSubStageId).Skinn_NPD_Template_Item__r.Parent_Id__r.Id;
                                findSubStageId=recordWithCollModelMap.get(each)+','+findSubStageId;
                            }
                        }
                        if(findSubStageId!=null){
                            if(upwordMap.get(findSubStageId).Status__c=='Completed'){
                                findSubStageId=upwordMap.get(findSubStageId).Id;
                                updateRecords.add(new Skinn_Collection_Template__c(Id=findSubStageId,Actual_End_date__c=returnUpdatedDate(mapNewRecords.get(each))));
                            }
                        }
                        if(upwordMap.get(findstageId).Status__c=='Completed'){
                            findstageId=upwordMap.get(findstageId).Id;
                            updateRecords.add(new Skinn_Collection_Template__c(Id=findstageId,Actual_End_date__c=returnUpdatedDate(mapNewRecords.get(each))));
                        }else{
                            mapNewRecords.get(each).AddError('You can\'t End revision before stage completion!!');
                        }
                    }
                }
            }
            if(!updateRecords.isEmpty()){
                update updateRecords;
            }
            System.debug(updateRecords);
        }
    }
}