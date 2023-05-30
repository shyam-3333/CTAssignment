/*
* Company : Kvp Business Solution 
* Date    : 24-12-2018
* Author  : Sameer Ranjan
* Description : Controller of QC_MTL_InputForm Component.
* History     : N/L
*/
    public class QC_MTL_InputForm_Class {
    @AuraEnabled
    public static QC_MTL_Component__c insertInfo(QC_MTL_Component__c infoData){
        System.debug('::infoData::: '+infoData);
        QC_MTL_Component__c qcMtlObject;
        try{
            //insert(infoData);
            infoData.RM_Size__c = String.valueOf(infoData.RM_Size__c);
            insert infoData;
            
                qcMtlObject = [Select Id,Report_Reference_Number__c,Record_Status__c,Document_Status__c,Supply_Quantity__c From QC_MTL_Component__c where Id = :infoData.Id];
            return qcMtlObject;       
        }
        catch(Exception e){
            return infoData;
        }
    }
    @AuraEnabled
    public static List<String> getAllRawMaterialName(){
        
        Set<String> addRecords=new Set<String>();
        List<QC_Access_Master__c> listRcords=[select Id,Raw_Material_Name__c from QC_Access_Master__c limit 1000];
        for(QC_Access_Master__c var : listRcords){
            if(var.Raw_Material_Name__c!=null)
            addRecords.add(var.Raw_Material_Name__c);
        }
        List<String> returnResult=new List<String>(addRecords);
        return returnResult;
    }
    
    @AuraEnabled
    public static QC_MTL_Component__c updateComponent(String recId,QC_MTL_Component__c infoData){
        System.debug('recId---qacIdObj'+recId+'==='+infoData);
        infoData.Id=recId;
        database.update(infoData);
        return [SELECT Id,Report_Reference_Number__c,Record_Status__c,Document_Status__c,Supply_Quantity__c FROM QC_MTL_Component__c where Id = :recId];
        
    }
    @AuraEnabled
    public static Map<String, List<String>> getDependentOptionsImplements(String objDetail, string contrfieldApiName,string depfieldApiName) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        String objectStr = objDetail; // Convert to schema.sObjectType 
        System.debug('controllingField::'+controllingField);
        System.debug('dependentField::'+dependentField);
        System.debug('objectStr::'+objectStr);
        Schema.sObjectType objType = Schema.getGlobalDescribe().get(objectStr);
        System.debug('objType'+objType);
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        
        //Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType==null){
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            system.debug('objResults::'+objResults);
            return objResults;     
        }
        
        Schema.SObjectField theField = objFieldMap.get(dependentField);
        Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
        
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        List<String> controllingValues = new List<String>();
        
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        system.debug('objResults::'+objResults);
        return objResults;
    }
    @AuraEnabled
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    @AuraEnabled
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    public static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    public class PicklistEntryWrapper{
        @AuraEnabled
        public String active {get;set;}
        @AuraEnabled
        public String defaultValue {get;set;}
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String value {get;set;}
        @AuraEnabled
        public String validFor {get;set;}
        public PicklistEntryWrapper(){            
        }
        
    }
     
   /* @AuraEnabled  
    public static Map<String,List<String>> getDependentOptionsImplements(string objApiName , string contrfieldApiName , string depfieldApiName){
         Map<String,List<String>> objResults = new Map<String,List<String>>();
        system.debug(objApiName + '##' + contrfieldApiName + '###' + depfieldApiName);
           
        String objectName = objApiName.toLowerCase();
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
       
            //get the string to sobject global map
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
         
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
            System.debug('OBJNAME NOT FOUND --.> ' + objectName);
            return null;
         }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            return objResults;
        }
        Bitset bitSetObj = new Bitset(); //it is a class named as Bitset which is being refrenced for indexing
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        //Check if picklist values exist
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            System.debug('FIELD NOT FOUND --.> ' + controllingField + ' OR ' + dependentField);
            return objResults;     
        }
        
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
         objFieldMap = null;
        List<Integer> controllingIndexes = new List<Integer>();
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            String label = ctrlentry.getLabel();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<PicklistEntryWrapper> objJsonEntries = new List<PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
               Schema.PicklistEntry depentry = depEntries[dependentIndex];
               objEntries.add(depentry);
        } 
        objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
            for (Integer idx : indexes){                
                String contrLabel = contrEntries[idx].getLabel();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
        system.debug('objResults--->' + objResults);
        return objResults;
    }*/
    @AuraEnabled
    public static List<String> getCustomSetting(){
        List<String> returnResult=new List<String>();
        List<Sample_Size_Custom_Setting__c> CustomSettingAllValue = Sample_Size_Custom_Setting__c.getall().values();
        for(Sample_Size_Custom_Setting__c var : CustomSettingAllValue){
            returnResult.add(var.Name);
        }
        System.debug(returnResult);
        
        return returnResult;
    }
    
    
    //get Pick List Value when Page Load.
    @AuraEnabled
    public static List<List<String>> getSchemaValue(){
        List<String> listofChemicalCompositionType=new List<String>();//This list store all pick value of "Chemical_Composition_Elements__c" field whick object "QC_MTL_Component__c".
        List<String> listofChemicalCompositionType2=new List<String>();//This list store all pick value of "Chemical_Composition_Elements__c" field whick object "QC_MTL_Component__c".
        List<String> listofChemicalCompositionType3=new List<String>();//This list store all pick value of "Chemical_Composition_Elements__c" field whick object "QC_MTL_Component__c".
        List<String> listofChemicalCompositionType4=new List<String>();//This list store all pick value of "Chemical_Composition_Elements__c" field whick object "QC_MTL_Component__c".
        List<String> listofChemicalCompositionType5=new List<String>();//This list store all pick value of "Chemical_Composition_Elements__c" field whick object "QC_MTL_Component__c".
        
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('QC_MTL_Component__c');//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> chemicalCompPickListValues = field_map.get('Chemical_Composition_Elements__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofChemicalCompositionType.add('--None--');
        for (Schema.PicklistEntry var : chemicalCompPickListValues) { 
            listofChemicalCompositionType.add(var.getValue());
        }
        List<Schema.PicklistEntry> chemicalComp2PickListValues = field_map.get('Chemical_Composition_Elements_2__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofChemicalCompositionType2.add('--None--');
        for (Schema.PicklistEntry var : chemicalComp2PickListValues) { 
            listofChemicalCompositionType2.add(var.getValue());
        }
        List<Schema.PicklistEntry> chemicalComp3PickListValues = field_map.get('Chemical_Composition_Elements_3__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofChemicalCompositionType3.add('--None--');
        for (Schema.PicklistEntry var : chemicalComp3PickListValues) { 
            listofChemicalCompositionType3.add(var.getValue());
        }
        List<Schema.PicklistEntry> chemicalComp4PickListValues = field_map.get('Chemical_Composition_Elements_4__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofChemicalCompositionType4.add('--None--');
        for (Schema.PicklistEntry var : chemicalComp4PickListValues) { 
            listofChemicalCompositionType4.add(var.getValue());
        }
        List<Schema.PicklistEntry> chemicalComp5PickListValues = field_map.get('Chemical_Composition_Elements_5__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofChemicalCompositionType5.add('--None--');
        for (Schema.PicklistEntry var : chemicalComp5PickListValues) { 
            listofChemicalCompositionType5.add(var.getValue());
        }
        List<List<String>> PickListMap=new List<List<String>>();
        PickListMap.add(listofChemicalCompositionType);
        PickListMap.add(listofChemicalCompositionType2);
        PickListMap.add(listofChemicalCompositionType3);
        PickListMap.add(listofChemicalCompositionType4);
        PickListMap.add(listofChemicalCompositionType5);
        return PickListMap;
    }
    
    //fetch and display the Re-Submitted Material component record for IDI users
    @AuraEnabled
    public static List<QC_MTL_Component__c> fetchMaterialReSubData(sObject reportRefId){
       System.debug('----reportRefId---->>'+reportRefId);
        QC_MTL_Component__c obj1 = (QC_MTL_Component__c) reportRefId;
        System.debug('====obj1---->>>'+obj1.Id);
        List<QC_MTL_Component__c> qcCompList= new List<QC_MTL_Component__c>();
        if(obj1 !=NULL){
            qcCompList=[SELECT ID,Name,Document_Status__c,Record_Status__c, Sample_Size_Qty__c,Testing_Type__c,Material_Sample_Type__c,Raw_Material_Type__c,Report_Reference_Number__c,Sample_Received_Date__c,
                       Final_Verdict__c,Sample_Received_From__c,MTL_User__c,MTL_User__r.Name,Brand__c,Brand__r.Name,Raw_Material_Name__c,Specification_revision__c,Supplier_Name_New__c,plater_Name__c,Supplier_Name_New__r.Name,Invoice_Dc_No__c,RM_Size__c,
                        Heat_No_Grade__c,Titan_Specification_Reference__c,Titan_Specification_Reference__r.Name,Department__c,Part_Name__c,Source__c,Model__c,Docket_Number__c,Batch_Quantity__c,
                        Supplier_Grade__c,Supplier_Grade__r.Name,Material__c,Plating_Type__c,Required_Test__c,Sample_Size_Plating__c,Component_Name__c,Chemical_Composition_Elements__c,Remarks__c,
                        Chemical_Composition_Elements_2__c,Actual_Department_Name__c,MTL_User_Email__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,Chemical_Composition_Elements_5__c,Supply_Quantity__c FROM QC_MTL_Component__c WHERE ID = :obj1.Id];
            
        }//if ends
        System.debug('----qcCompList-->>'+qcCompList);
        if(qcCompList.size()>0){
            return qcCompList;
        }
        return null;
    }//fetchMaterialData method ends
    
     @AuraEnabled
     public static QC_MTL_Component__c saveResubData(String sampleType ,sObject referenceNoObj ,QC_MTL_Component__c qacObj){
         system.debug('-------sampleType--------'+sampleType);
         system.debug('-------referenceNoObj--------'+referenceNoObj);
         system.debug('--------qacObj-------'+qacObj);
         QC_MTL_Component__c qcObj = (QC_MTL_Component__c)referenceNoObj;
         qacObj.Report_Reference_Number__c=qcObj.Report_Reference_Number__c;
         qacObj.Material_Sample_Type__c=sampleType;
         System.debug('Data:::::::::::::'+qacObj);
         try{
           if(qacObj !=NULL){
            insert qacObj;
           }
           
           if(qcObj !=NULL && qcObj.Id !=NULL){
            qcObj.Record_Status__c='Obsolete';
            update qcObj;
        }
           return [Select Id,Report_Reference_Number__c,Record_Status__c,Sample_Received_Date__c,Testing_Type__c,Sample_Received_From__c,Final_Verdict__c,Document_Status__c,Supply_Quantity__c FROM QC_MTL_Component__c WHERE ID =:qacObj.ID][0];
         }
         catch(Exception e){
           return qacObj;
         }
    }
    
    @AuraEnabled
    public static List<String> getOptionTestValues(){
        System.debug('Hello');
         List<String> returnResult=new List<String>();
        List<Optional_Test__c> CustomSettingAllValue = Optional_Test__c.getall().values();
        for(Optional_Test__c var : CustomSettingAllValue){
            returnResult.add(var.OptionalTest__c);
        }
        System.debug(returnResult.Size());
        
        return returnResult;
    }
    @AuraEnabled
    public static List<PickListClass> getPickListValue(string objectApiName, string pickListFieldApiName) {
		System.debug('objectApiName'+objectApiName);
        System.debug('pickListFieldApiName'+pickListFieldApiName);
        List<PickListClass> returnValueList = new List<PickListClass>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectApiName); //From the Object Api name retrieving the SObject
        Sobject objectName = targetType.newSObject();
        Schema.sObjectType sobjectType = objectName.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> fieldMap = sobjectDescribe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> schemaPickListValues = fieldMap.get(pickListFieldApiName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        returnValueList.add(new PickListClass('--None--',''));
        for (Schema.PicklistEntry var :schemaPickListValues) {
            returnValueList.add(new PickListClass(var.getLabel(),var.getValue()));
        }
        system.debug('Printing==>'+returnValueList);
        return returnValueList;
    }
    class PickListClass{
        @AuraEnabled
        public string label;
        @AuraEnabled
        public string value;
        PickListClass(string label,string value){
            this.label=label;
            this.value=value;
        }
    }
    
    @AuraEnabled
    public static list<QC_Access_Master__c> specRevisionValue(String titanSpecificationId){
        list<QC_Access_Master__c> specRevLst = new list<QC_Access_Master__c>();
        specRevLst = [SELECT Id,Specification_Revision__c,TCL_Designation__c FROM QC_Access_Master__c WHERE Id =:titanSpecificationId];
        return specRevLst;
        
    }
    @AuraEnabled
    public static list<Supplier_Grade__C> tclDesignationValue(String supplierGradeID){
        list<Supplier_Grade__C> retrunResult = new list<Supplier_Grade__C>();
        retrunResult = [SELECT Id,TCL_Designation__c FROM Supplier_Grade__C WHERE Id =:supplierGradeID];
        return retrunResult;
        
    }
    @AuraEnabled
    public static List<QC_Access_Master__c> suplrNameValue(String suplrNameId){
        List<QC_Access_Master__c> accMasList = new List<QC_Access_Master__c>();
        accMasList = [SELECT Id,Name FROM QC_Access_Master__c WHERE ID =: suplrNameId];
        return accMasList;
    }
    
     @AuraEnabled
    public static List<QC_Access_Master__c> PlaterNameValue(String PlaterNameId){
        List<QC_Access_Master__c> accMasList1 = new List<QC_Access_Master__c>();
        accMasList1 = [SELECT Id,Name FROM QC_Access_Master__c WHERE ID =: PlaterNameId];
        return accMasList1;
    }
   
}