/*
* Company : Kvp Business Solution 
* Date    : 18-02-2019
* Author  : Sameer Ranjan
* Description : Skinn_Model__c Trigger Handler Class 
* History : Modify the logic, Add Planned and rolling Dates calculation logic while insertion and updation of model record
*/
public with sharing class SkinnModelTriggerHandler {
    
    // logic flag
    public static Boolean insertUpdateTriggerFlag = true;
    //If Packaging Material Source is Import
    private static Map<Id,Boolean> mapOfModelIdWithModelIsPackagingMaterialSourceIsImport = new Map<Id,Boolean>();
    private static Skinn_Import_Model_Type__c ifModelPMSImportCustomSetting = Skinn_Import_Model_Type__c.getOrgDefaults();
    private static Skinn_Project_Launch_Date__c projectLaunchDate = Skinn_Project_Launch_Date__c.getOrgDefaults();
    
    // After inser and update logic
    public static Void afterInsertUpdateMethod(List<Skinn_Model__c> listModelRecord,Map<Id,Skinn_Model__c> newMapSkinnModel){
        if(insertUpdateTriggerFlag){
            List<String> skinnModelIds = new List<String>();
            List<String> skinnCollectionStrings = new List<String>();
            List<Id> projectTemplateIds = new List<Id>();
            List<Id> marketingTemplateIds = new List<Id>();
            Map<String,Map<String,Id>> collectionWithResponsableUers = new Map<String,Map<String,Id>>();
            Map<Id,Id> mapofModelWithCollection = new Map<Id,Id>();
            Map<String,Id> mapofCollectionWithTemaplate = new Map<String,Id>();
            Map<String,Id> assignedUers;
            for(Skinn_Model__c eachRecord : listModelRecord){
                if(eachRecord.CountCollTempRecords__c == 0 && eachRecord.Name != 'MarketingStage' && eachRecord.Project_Template_Id__c != null && eachRecord.Marketing_Template_Id__c != null ){
                    skinnModelIds.add(eachRecord.Id);
                    skinnCollectionStrings.add(eachRecord.Skinn_Collection__c);
                    projectTemplateIds.add(eachRecord.Project_Template_Id__c);
                    mapofModelWithCollection.put(eachRecord.Id,eachRecord.Skinn_Collection__c);
                    mapofCollectionWithTemaplate.put(eachRecord.Id+','+eachRecord.Skinn_Collection__c,eachRecord.Project_Template_Id__c);
                    marketingTemplateIds.add(eachRecord.Marketing_Template_Id__c);
                    assignedUers = new Map<String,String>();
                    assignedUers.put('Fragrance Expert', eachRecord.Fragrance_User__c);
                    assignedUers.put('Marketing User', eachRecord.Marketing_User__c);
                    assignedUers.put('NPD Packaging', eachRecord.NPD_Packaging_User__c);
                    assignedUers.put('Sourcing', eachRecord.Sourcing_User__c);
                    assignedUers.put('QA', eachRecord.QA_User__c);
                    collectionWithResponsableUers.put(eachRecord.Id+','+eachRecord.Skinn_Collection__c,assignedUers);
                    // If model record Packaging Material Source is import
                    mapOfModelIdWithModelIsPackagingMaterialSourceIsImport.put(eachRecord.Id , isPackageingMateSourceImport(eachRecord.Packaging_Material_Source__c));
                }
            }
            // find the marketing stage end date
            List<Skinn_Collection_Template__c> marketingStagelastDateRecords = [SELECT Id, planned_End_Date__c,Skinn_Collection__c
                                                                                FROM Skinn_Collection_Template__c 
                                                                                WHERE Type__c ='Stage' 
                                                                                AND (Skinn_Collection__c in :skinnCollectionStrings) 
                                                                                AND (Template_Name__c in :marketingTemplateIds ) 
                                                                                LIMIT 10000];
            Map<Id,Date> mapOfCollectionWithMarketetingDate = new Map<Id,Date>();
            for( Skinn_Collection_Template__c eachRecord : marketingStagelastDateRecords ){
                if(!mapOfCollectionWithMarketetingDate.containsKey(eachRecord.Skinn_Collection__c)){
                    mapOfCollectionWithMarketetingDate.put(eachRecord.Skinn_Collection__c,eachRecord.planned_End_Date__c);
                } 
            }
            // Query the all Project Template NPD Process flow records
            List<Skinn_NPD_Template_Item__c> npdProcessRecords = [SELECT Id, Name, Item_Name__c,
                                                                  Planned_Lead_Time__c, Parent_Id__r.Order_No__c,
                                                                  Parent_Id__r.Type__c, Parent_Id__c,
                                                                  Parent_Id__r.Item_Name__c, Type__c,
                                                                  Assigned_Team__c, Order_No__c,
                                                                  Skinn_NPD_Template__c,Skinn_Model_Item__c,
                                                                  Active__c, Approval_required__c FROM Skinn_NPD_Template_Item__c where Skinn_NPD_Template__c in:projectTemplateIds order by Skinn_NPD_Template__c,Order_No__c limit 10000];
            
            Map<String,String> mapfSkinnitemStringwithParString = new Map<String,String>();
            Map<String,String> mapofItemParentwithType = new Map<String,String>();
            Map<String,WrapperClass> downWordMap = new Map<String,WrapperClass>();
            Map<String,WrapperClass> upWordMap = new Map<String,WrapperClass>();
            Map<String,List<Skinn_NPD_Template_Item__c>> collectionWithNPDprocessRecords = new Map<String,List<Skinn_NPD_Template_Item__c>>();
            list<Skinn_NPD_Template_Item__c> heplInParperMapList;
            WrapperClass tempWrapperClass;
            System.debug(npdProcessRecords.size());
            // find item depth of each stage, sub-stage and activity records
            for(Skinn_NPD_Template_Item__c each : npdProcessRecords){
                mapfSkinnitemStringwithParString.put(each.Id+','+each.Skinn_NPD_Template__c, String.valueOf(each.Parent_Id__c+','+each.Skinn_NPD_Template__c));
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
            // create arrow level of each stage, sub-stage and activity
            for( String eachString : mapfSkinnitemStringwithParString.keySet() ){
                String each = eachString;
                while( mapfSkinnitemStringwithParString.get(each).split(',')[0] != 'null'  && mapofItemParentwithType.get(mapfSkinnitemStringwithParString.get(each)).split('->')[0] != 'Stage' ){
                    if( mapofItemParentwithType.get(mapfSkinnitemStringwithParString.get(each)).split('->')[0] == 'Sub-Stage' ){
                        stageLevel += '->'+mapofItemParentwithType.get(mapfSkinnitemStringwithParString.get(each)).split('->')[1];
                    }
                    each = mapfSkinnitemStringwithParString.get(each);
                }
                stageLevel += '->'+mapofItemParentwithType.get(mapfSkinnitemStringwithParString.get(each)).split('->')[1];
                mapOdModelItemwithNames.put( eachString, stageLevel );
                stageLevel = '';
            }
            Date startDate;
            Date endDate;
            WrapperClass temp;
            List<Skinn_Collection_Template__c> recordWhileInsertion = new List<Skinn_Collection_Template__c>();
            Integer firstInteger;
            Boolean findFirstStage = true;
            Map<Id,Date> mapOfModelWithlastActivityRecord = new Map<Id,Date>();
            // Prepare the Model with NPD Process records for insertion
            for(String eachModelId : skinnModelIds){
                for( Skinn_NPD_Template_Item__c each : collectionWithNPDprocessRecords.get(mapofCollectionWithTemaplate.get(eachModelId+','+mapofModelWithCollection.get(eachModelId)))){
                    // Planned and Rolling Dates Calculation
                    if(each.Type__c =='Stage' && findFirstStage){
                        firstInteger = Integer.valueOf(each.Order_No__c);
                        findFirstStage = false;
                    }
                    if(each.Order_No__c == firstInteger){
                        if(mapOfCollectionWithMarketetingDate.get(mapofModelWithCollection.get(eachModelId)) > Date.valueOf(System.now())){
                            startDate = mapOfCollectionWithMarketetingDate.get(mapofModelWithCollection.get(eachModelId))+1;
                        } else {
                            startDate = Date.valueOf(System.now());
                        }
                        endDate = startDate.addDays(Integer.valueOf(each.Planned_Lead_Time__c));
                        downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = startDate;
                        downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = endDate;
                    } else {
                        if(each.Parent_Id__r.Type__c == 'Stage'){
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            temp.skinnCollectionTempValue = new Skinn_NPD_Template_Item__c();
                            temp.skinnCollectionTempValue = each;
                            list<Date> returnDates = caluculateStartEndDates(temp,each.Parent_Id__r.Type__c,eachModelId);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                            
                        } else if(each.Parent_Id__r.Type__c == 'Sub-Stage') {
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            temp.skinnCollectionTempValue = new Skinn_NPD_Template_Item__c();
                            temp.skinnCollectionTempValue = each;
                            list<Date> returnDates = caluculateStartEndDates(temp,each.Parent_Id__r.Type__c,eachModelId);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                        } else if(each.Parent_Id__r.Type__c == 'Activity'){
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            temp.skinnCollectionTempValue = new Skinn_NPD_Template_Item__c();
                            temp.skinnCollectionTempValue = each;
                            list<Date> returnDates = caluculateStartEndDates(temp,each.Parent_Id__r.Type__c,eachModelId);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                        } else {
                            temp = new WrapperClass();
                            temp = downWordMap.get(each.Parent_Id__r.Order_No__c+','+each.Skinn_NPD_Template__c);
                            temp.skinnCollectionTempValue = new Skinn_NPD_Template_Item__c();
                            temp.skinnCollectionTempValue = each;
                            list<Date> returnDates = caluculateStartEndDates(temp,each.Parent_Id__r.Type__c,eachModelId);
                            if(downWordMap.containsKey(each.Order_No__c+','+each.Skinn_NPD_Template__c)){
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).startDate = returnDates[0];
                                downWordMap.get(each.Order_No__c+','+each.Skinn_NPD_Template__c).endDate = returnDates[1];
                            }
                        }
                    }
                    
                    //Prepare the Skinn Collection Template Records
                    recordWhileInsertion.add(new Skinn_Collection_Template__c(
                        Item_Name__c = each.Item_Name__c,
                        Hierarchy__c = mapOdModelItemwithNames.get(each.Id+','+each.Skinn_NPD_Template__c),
                        Skinn_Model__c = eachModelId,
                        Skinn_Collection__c = mapofModelWithCollection.get(eachModelId),
                        Template_Name__c = mapofCollectionWithTemaplate.get(eachModelId+','+mapofModelWithCollection.get(eachModelId)),
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
                        Responsibly__c = collectionWithResponsableUers.get(eachModelId+','+mapofModelWithCollection.get(eachModelId)).get(each.Assigned_Team__c)));
                }
            }
            List<Skinn_Model__c> updateModelRecords = new List<Skinn_Model__c>();
            for(Skinn_Collection_Template__c each : recordWhileInsertion){
                if(each.Item_Name__c == projectLaunchDate.Process_Name__c){
                    mapOfModelWithlastActivityRecord.put(each.Skinn_Model__c,each.Rolling_Planned_End_Date__c);
                }
            }
            for(Skinn_Model__c each : listModelRecord){
                updateModelRecords.add(new Skinn_Model__c(Id = each.Id,Product_Launch_Date__c = mapOfModelWithlastActivityRecord.get(each.Id)));
            }
            if( recordWhileInsertion.size() != 0){
                CheckRecursive.skinnCollectionTemplateTriggerFlag = false;
                System.debug(recordWhileInsertion);
                Database.insert(recordWhileInsertion);
            }
            if(!updateModelRecords.isEmpty()){
                CheckRecursive.skinnModelTriggerFlag = false;
                Database.update(updateModelRecords);
            }
        }
    }
    private static Boolean isPackageingMateSourceImport(String packagingMatSource){
        if(packagingMatSource == 'Import'){
            return true;
        }
        return false;
    }
    // Common logic for calaculating Planned and Rolling Dates
    public static List<Date> caluculateStartEndDates(WrapperClass temp, String parenttypeName, String eachModelId){
        Date startDate;
        Date endDate;
        list<Date> returnDates = new list<Date>();
        if(temp.skinnCollectionTempValue.Type__c == 'Stage'){
            startDate = temp.endDate+1;
            endDate = startDate.addDays(Integer.valueOf(temp.skinnCollectionTempValue.Planned_Lead_Time__c)); 
        } else if(temp.skinnCollectionTempValue.Type__c == 'Sub-Stage') {
            startDate = temp.startDate;
            endDate = startDate.addDays(Integer.valueOf(temp.skinnCollectionTempValue.Planned_Lead_Time__c));
        } else if((temp.skinnCollectionTempValue.Type__c == 'Activity')) {
            if(mapOfModelIdWithModelIsPackagingMaterialSourceIsImport.get(eachModelId) && temp.skinnCollectionTempValue.Order_No__c == ifModelPMSImportCustomSetting.Activity_Order_Number__c){
                temp.skinnCollectionTempValue.Planned_Lead_Time__c = temp.skinnCollectionTempValue.Planned_Lead_Time__c + ifModelPMSImportCustomSetting.Added_Number_Of_Days__c;
            }
            if(parenttypeName != 'Activity'){
                startDate = temp.startDate;
                endDate = startDate.addDays(Integer.valueOf(temp.skinnCollectionTempValue.Planned_Lead_Time__c));
            } else {
                startDate = temp.endDate+1;
                endDate = startDate.addDays(Integer.valueOf(temp.skinnCollectionTempValue.Planned_Lead_Time__c)-1);
            }
            
        } else {
            startDate = temp.endDate;
            endDate = startDate.addDays(Integer.valueOf(temp.skinnCollectionTempValue.Planned_Lead_Time__c)); 
        }
        returnDates.add(startDate);
        returnDates.add(endDate);
        return returnDates;
    }
    
    public class WrapperClass {
        public Skinn_NPD_Template_Item__c skinnCollectionTempValue; 
        
        public Date startDate; // variable for calculating planned and rolling dates
        
        public Date endDate; // variable for calculating planned and rolling dates
    }
}