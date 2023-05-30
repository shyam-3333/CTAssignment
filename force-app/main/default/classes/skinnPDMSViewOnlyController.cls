/*
* Company : Kvp Business Solution 
* Author  : Sameer Ranjan
* Description : controller class of skinnPDMSViewOnly LWC
* History     : N/L
*/
public with sharing class skinnPDMSViewOnlyController {
    // fetch the collection records
    @AuraEnabled(cacheable=true)
    public static List<PickListClass> getcollectionRecords(){
        List<PickListClass> returnList = new List<PickListClass>();
        List<Skinn_Collection__c> listCollectionRecords = [Select Id,Name FROM Skinn_Collection__c where Collection_Status__c='Open' limit 1000];
        returnList.add(new PickListClass('--None--',''));
        for(Skinn_Collection__c eachCollection : listCollectionRecords){
            returnList.add(new PickListClass(eachCollection.Name,eachCollection.Id));
        }
        return returnList;
    }
    // fetch model records
    @AuraEnabled
    public static List<Skinn_Model__c> getModelRecords(String collectionId){
        return ([Select Id, name, Product_Launch_Date__c, Skinn_Collection__r.Tentative_Launch_Date__c FROM Skinn_Model__c where Skinn_Collection__c =:collectionId order by createdDate limit 1000]);
    }
    // fetch skinn collection template records
    @AuraEnabled
    public static List<WrapperClass> getskinnCollectiontempRecords(String collectionId,String modelId,String ownerId){
        System.debug('ownerId'+ownerId);
        List<WrapperClass> returnValue = new List<WrapperClass>();
        WrapperClass temp;
        List<Skinn_Collection_Template__c> listOfRecord = new List<Skinn_Collection_Template__c>();
        if(ownerId != ''){
            listOfRecord = [ SELECT Id,Item_Name__c,Type__c,Status__c,
                             Planned_Start_Date__c,planned_End_Date__c,
                             Actual_start_date__c,Actual_End_date__c,
                             Rolling_Planned_Start_Date__c,Rolling_Planned_End_Date__c,
                             Responsibly__r.Name
                             FROM Skinn_Collection_Template__c 
                             WHERE Skinn_Collection__c =:collectionId 
                             AND Skinn_Model__c =:modelId 
                             AND Responsibly__c =:ownerId 
                             ORDER BY Order_Number__c limit 1000];
        } else {
            listOfRecord = [ SELECT Id,Item_Name__c,Type__c,Status__c,
                             Planned_Start_Date__c,planned_End_Date__c,
                             Actual_start_date__c,Actual_End_date__c,
                             Rolling_Planned_Start_Date__c,Rolling_Planned_End_Date__c,
                             Responsibly__r.Name
                             FROM Skinn_Collection_Template__c 
                             WHERE Skinn_Collection__c =:collectionId 
                             AND Skinn_Model__c =:modelId 
                             ORDER BY Order_Number__c limit 1000];
        }
        for(Skinn_Collection_Template__c each : listOfRecord){
            system.debug('skinn collection temp -> ' + each);
            temp = new WrapperClass(formateChange(each.planned_Start_Date__c),formateChange(each.planned_End_Date__c),
                                    formateChange(each.Actual_start_date__c),formateChange(each.Actual_End_date__c),
                                    formateChange(each.Rolling_Planned_Start_Date__c),formateChange(each.Rolling_Planned_End_Date__c),
                                    each.Status__c,each.Id,each.Item_Name__c,each.Type__c,each.Responsibly__r.Name);
            if(each.Type__c == 'Activity'){
                temp.IsActivity = true;
            } else if(each.Type__c == 'Sub-Stage'){
                temp.IsSubStage = true;
            } else if(each.Type__c == 'Stage'){
                temp.IsStage = true;
            }
            if(each.Status__c == 'In Progress'){
                temp.IsInProgess = true;
            } else if(each.Status__c == 'Completed'){
                temp.IsCompleted = true;
            } else if(each.Status__c == 'Not Started'){
                temp.IsNotStarted = true;
            }
            returnValue.add(temp);
        }
        return returnValue;    
    }

    public static String formateChange(Date dateValue){
       system.debug('dateValue->'+dateValue); 
       String returnvalue = '';
       if(dateValue != null){
            //returnvalue = DateTime.newInstance(DateValue.year(),DateValue.month(),DateValue.day()).format('dd-MM-YYYY');
            //Modified By : Mutturaj Heroor
            //Modified Date:04/02/2020
           returnvalue = DateValue.day() +'-'+ DateValue.month() +'-'+ DateValue.year();
       } 
       system.debug('returnvalue->'+returnvalue); 
       return returnvalue;
    }
    class WrapperClass{
        @AuraEnabled
        public String PlannedStartDate;
        @AuraEnabled
        public String PlannedEndDate;
        @AuraEnabled
        public String ActualStartDate;
        @AuraEnabled
        public String ActualEndDate;
        @AuraEnabled
        public String RollingPlannedStartDate;
        @AuraEnabled
        public String RollingPlannedEndDate;
        @AuraEnabled
        public String ProductLauchDates;
        @AuraEnabled
        public Boolean IsProductLauchhas;
        @AuraEnabled
        public String Status;    
        @AuraEnabled
        public Id Id;
        @AuraEnabled
        public String Item_Name;
        @AuraEnabled
        public String OwnerName;
        @AuraEnabled
        public String Type;
        @AuraEnabled
        public Boolean IsActivity;
        @AuraEnabled
        public Boolean IsStage;
        @AuraEnabled
        public Boolean IsSubStage;
        @AuraEnabled
        public Boolean IsCompleted;
        @AuraEnabled
        public Boolean IsNotStarted;
        @AuraEnabled
        public Boolean IsInProgess;
        public WrapperClass(){
            System.debug('Empty');
        }
        public WrapperClass(String PlannedStartDate,String PlannedEndDate,
                            String ActualStartDate,String ActualEndDate,
                            String RollingPlannedStartDate,String RollingPlannedEndDate,
                            String Status,Id Id,String Item_Name,String Type,String OwnerName){
            this.PlannedEndDate = PlannedEndDate;
            this.PlannedStartDate = PlannedStartDate;
            this.ActualStartDate = ActualStartDate;
            this.ActualEndDate = ActualEndDate;
            this.RollingPlannedStartDate = RollingPlannedStartDate;
            this.RollingPlannedEndDate = RollingPlannedEndDate;
            this.Id = Id;
            this.Status = Status;
            this.Item_Name = Item_Name;
            this.Type = Type;
            this.OwnerName = OwnerName;
        }
        
    }

}