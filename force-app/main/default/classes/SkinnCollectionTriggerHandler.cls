/*
* Company : Kvp Business Solution 
* Date    : 18-02-2019
* Author  : Sameer Ranjan
* Description : Skinn_Collection__c Trigger Handler Class 
* History : Modify the logic, Add Planned and rolling Dates calculation logic while insertion
*/
public with sharing class SkinnCollectionTriggerHandler{

    public static Boolean afterInsertFlag = true;
	
    public static void afterInsertMethod(List<Skinn_Collection__c> skinnCollectionList,Map<Id,Skinn_Collection__c> collectionMap){
        // Logic Floag
        if(afterInsertFlag){
            Marketing_Stage_Launch_Date__c conditionWithDays = Marketing_Stage_Launch_Date__c.getOrgDefaults();
            Map<Id,Date> maodelWithLaunchDate = new Map<Id,Date>();
            Date marketingLaunchDate;
            Set<Id> marketingtemplateIds = new Set<Id>();
            Set<Id> skinnCollectionIds = new Set<Id>();
            Map<Id,Id> mapOfCollectionWithTemplate = new Map<Id,Id>();
            Map<Id,Map<String,Id>> collectionWithResponsableUers = new Map<Id,Map<String,Id>>();
            List<Skinn_Model__c> modelRecord = new List<Skinn_Model__c>();
            Map<String,Id> assignedUers;
            for( Skinn_Collection__c each : skinnCollectionList){
                if(each.Id != null){
                    skinnCollectionIds.add(each.Id);
                } 
                assignedUers = new Map<String,Id>();
                assignedUers.put('Fragrance Expert',each.Fragrance_User__c);
                assignedUers.put('Marketing User',each.Marketing_User__c);
                collectionWithResponsableUers.put(each.Id,assignedUers);
                if(each.Marketing_Template__c != null){
                    marketingtemplateIds.add(each.Marketing_Template__c);
                    mapOfCollectionWithTemplate.put(each.Id,each.Marketing_Template__c);
                }
            }
            for(Id each : skinnCollectionIds){
                modelRecord.add(new Skinn_Model__c(Skinn_Collection__c = each, Name='MarketingStage'));
            }
            if(!modelRecord.isEmpty()){
                CheckRecursive.skinnModelTriggerFlag = false;
                Database.Insert(modelRecord);
            }
            Map<Id,Id> collectionWithModelMap = new Map<Id,Id>();
            for(Skinn_Model__c each : modelRecord){
                collectionWithModelMap.put(each.Skinn_Collection__c,each.Id);
            }
            List<Skinn_NPD_Template_Item__c> npdProcessRecords = [SELECT Id, Name, Item_Name__c,
                                                                  Planned_Lead_Time__c, Parent_Id__r.Order_No__c,
                                                                  Parent_Id__r.Type__c, Parent_Id__c,
                                                                  Parent_Id__r.Item_Name__c, Type__c,
                                                                  Assigned_Team__c, Order_No__c,
                                                                  Skinn_NPD_Template__c,Skinn_Model_Item__c,
                                                                  Active__c, Approval_required__c FROM Skinn_NPD_Template_Item__c where Skinn_NPD_Template__c in:marketingtemplateIds order by Skinn_NPD_Template__c,Order_No__c limit 10000];
            
            Map<String,String> mapfSkinnitemIdwithParId = new Map<String,String>();
            Map<String,String> mapofItemParentwithType = new Map<String,String>();
            Map<String,WrapperClass> downWordMap = new Map<String,WrapperClass>();
            Map<String,WrapperClass> upWordMap = new Map<String,WrapperClass>();
            Map<String,List<Skinn_NPD_Template_Item__c>> collectionWithNPDprocessRecords = new Map<String,List<Skinn_NPD_Template_Item__c>>();
            list<Skinn_NPD_Template_Item__c> heplInParperMapList;
            WrapperClass tempWrapperClass;
            for(Skinn_NPD_Template_Item__c each : npdProcessRecords){
                mapfSkinnitemIdwithParId.put(each.Id+','+each.Skinn_NPD_Template__c, String.valueOf(each.Parent_Id__c+','+each.Skinn_NPD_Template__c));
                mapofItemParentwithType.put(String.valueOf(each.Parent_Id__c+','+each.Skinn_NPD_Template__c), each.Parent_Id__r.Type__c+'->'+each.Parent_Id__r.Item_Name__c);
                tempWrapperClass = new WrapperClass();
                tempWrapperClass.skinnCollectionTempValue = new Skinn_NPD_Template_Item__c();
                tempWrapperClass.skinnCollectionTempValue = each;
                downWordMap.put(each.Order_No__c+','+each.Skinn_NPD_Template__c,tempWrapperClass);
                if(collectionWithNPDprocessRecords.containsKey(each.Skinn_NPD_Template__c)){
                    heplInParperMapList.add(each);
                }else{
                    heplInParperMapList = new List<Skinn_NPD_Template_Item__c>();
                    heplInParperMapList.add(each);
                    collectionWithNPDprocessRecords.put(each.Skinn_NPD_Template__c,heplInParperMapList);
                }
                if(!upWordMap.containsKey(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c)){
                    upWordMap.put(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c,tempWrapperClass);
                }   
            }
            Map<String,String> mapOdModelItemwithNames = new Map<String,String>();
            String stageLevel = '';
            // create level of each stage, sub-stage and activity
            for( String eachId : mapfSkinnitemIdwithParId.keySet() ){
                String each = eachId;
                while( mapfSkinnitemIdwithParId.get(each).split(',')[0] != 'null'  && mapofItemParentwithType.get(mapfSkinnitemIdwithParId.get(each)).split('->')[0] != 'Stage' ){
                    if( mapofItemParentwithType.get(mapfSkinnitemIdwithParId.get(each)).split('->')[0] == 'Sub-Stage' ){
                        stageLevel += '->'+mapofItemParentwithType.get(mapfSkinnitemIdwithParId.get(each)).split('->')[1];
                    }
                    each = mapfSkinnitemIdwithParId.get(each);
                }
                stageLevel += '->'+mapofItemParentwithType.get(mapfSkinnitemIdwithParId.get(each)).split('->')[1];
                mapOdModelItemwithNames.put(eachId, stageLevel);
                stageLevel = '';
            }
            Date startDate;
            Date endDate;
            WrapperClass temp;
            list<Date> returnDates = new List<Date>();
            List<Skinn_Collection_Template__c> recordWhileInsertion = new List<Skinn_Collection_Template__c>();
            for(Id eachCollectionId : skinnCollectionIds){
                for( Skinn_NPD_Template_Item__c each : collectionWithNPDprocessRecords.get(mapOfCollectionWithTemplate.get(eachCollectionId))){
                    // Planned and Rolling Dates Calculation
                    if(each.Order_No__c == 1){
                        startDate = Date.valueOf(System.now());
                        endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c));
                        downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = startDate;
                        downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = endDate;
                    } else {
                        if(each.Parent_Id__r.Type__c == 'Stage'){
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            returnDates = caluculateStartEndDates(temp,each,each.Parent_Id__r.Type__c);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                            
                        } else if(each.Parent_Id__r.Type__c == 'Sub-Stage') {
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            returnDates = caluculateStartEndDates(temp,each,each.Parent_Id__r.Type__c);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                        } else if(each.Parent_Id__r.Type__c == 'Activity'){
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            returnDates = caluculateStartEndDates(temp,each,each.Parent_Id__r.Type__c);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                        } else{
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            returnDates = caluculateStartEndDates(temp,each,each.Parent_Id__r.Type__c);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                        }
                    }
                    // Insert the Skinn Collection Template Records
                    recordWhileInsertion.add(new Skinn_Collection_Template__c(
                        Item_Name__c = each.Item_Name__c,
                        Hierarchy__c = mapOdModelItemwithNames.get(each.Id+','+each.Skinn_NPD_Template__c),
                        Skinn_Model__c = collectionWithModelMap.get(eachCollectionId),
                        Skinn_Collection__c = eachCollectionId,
                        Template_Name__c = collectionMap.get(eachCollectionId).Marketing_Template__c,
                        Skinn_NPD_Template_Item__c = each.Id,
                        Type__c = each.Type__c,
                        Order_Number__c = each.Order_No__c,
                        Planned_Lead_Time__c = each.Planned_Lead_Time__c,
                        Active__c = each.Active__c,
                        Item_Names__c = each.Skinn_Model_Item__c,
                        Approval_Required__c = each.Approval_Required__c,
                        planned_Start_Date__c = downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate,
                        Planned_End_Date__c = downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate,
                        Rolling_Planned_Start_Date__c = downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate,
                        Rolling_Planned_End_Date__c = downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate,
                        Responsibly__c = collectionWithResponsableUers.get(eachCollectionId).get(each.Assigned_Team__c)));
                    if(conditionWithDays.Process_Name__c == each.Item_Name__c){
                        marketingLaunchDate = downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate.addDays(Integer.valueOf(conditionWithDays.Lead_Time__c));
                        maodelWithLaunchDate.put(collectionWithModelMap.get(eachCollectionId),marketingLaunchDate);
                    }
                }
                
            }
            if( recordWhileInsertion.size() != 0){
                System.debug(recordWhileInsertion);
                Database.insert(recordWhileInsertion);
            }
            for(Skinn_Model__c eachModel : modelRecord){
                eachModel.Product_Launch_Date__c = maodelWithLaunchDate.get(eachModel.Id);
            }
            if(!modelRecord.isEmpty()){
                CheckRecursive.skinnModelTriggerFlag = false;
                update modelRecord;
            }
        }
    }

    public static List<Date> caluculateStartEndDates(WrapperClass temp,Skinn_NPD_Template_Item__c each,String parenttypeName){
            Date startDate;
            Date endDate;
            list<Date> returnDates = new list<Date>();
            if(each.Type__c == 'Stage'){
                startDate = temp.endDate;
                endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c));
            } else if(each.Type__c == 'Sub-Stage') {
                startDate = temp.startDate;
                endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c));
            } else if((each.Type__c == 'Activity')) {
                if(parenttypeName != 'Activity'){
                    startDate = temp.startDate;
                    endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c));
                } else {
                    startDate = temp.endDate+1;
                    endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c)-1);
                }
                
            } else {
                startDate = temp.endDate;
                endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c)); 
            }
            returnDates.add(startDate);
            returnDates.add(endDate);
            return returnDates;
    }
    // Wrapper Class
    public class WrapperClass {
        public Skinn_NPD_Template_Item__c skinnCollectionTempValue;

        public Date startDate;

        public Date endDate;
    }

}