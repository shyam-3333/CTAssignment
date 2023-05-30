/*
* Company : Kvp Business Solution 
* Date    : 14/02/2019
* Author  : Sameer Ranjan
* Description : This Class holds Generic common logic which is use in lightning component controller class
* History     : N/L 
*/
public with sharing class GenericLogicClass {

    public static Boolean skinnCollectionTemplateTriggerActive = true;
    public static Boolean skinnCollectionTriggerActive = true;
    public static Boolean skinnModelTriggerActive = true;
    
    public static List<PickListClass> getPickListValue(string objectApiName,string pickListFieldApiName){
        List<PickListClass> pickListValue=new List<PickListClass>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectApiName);//From the Object Api name retrieving the SObject
        Sobject objectName = targetType.newSObject();
        Schema.sObjectType sobjectType = objectName.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> fieldMap = sobjectDescribe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> schemaPickListValues = fieldMap.get(pickListFieldApiName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        pickListValue.add(new PickListClass('--None--',''));
        for (Schema.PicklistEntry var : schemaPickListValues) { 
            pickListValue.add(new PickListClass(var.getValue(),var.getValue()));
        }
        return pickListValue;
    }
    
    public static Map<String,List<String>> getDependentMap(sObject objDetail, string contrfieldApiName,string depfieldApiName) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        
        Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType==null){
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
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
        return objResults;
    }
    
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }

    public static void errorHandlingMethod(Exception exc){
        try{
            Exception__c excp = new Exception__c();
            excp.Exception__c = 'Message : ' + exc.getMessage() + '. LineNumber : ' + exc.getLineNumber() + '. Cause : ' +
                + exc.getCause() + '. StackTraceString : ' + exc.getStackTraceString() + '. TypeName : ' + exc.getTypeName();
            excp.OwnerId = UserInfo.getUserId();
            if(excp.Exception__c.length()>254){
                excp.Exception__c = String.valueof(excp.Exception__c).substring(0, 254);
            }
            excp.Status__c = 'Exception';
            System.debug('LineNumber:'+exc.getLineNumber()+'Message:'+exc.getMessage());
            if(Schema.sObjectType.Exception__c.isAccessible()){
                Insert excp;
            }
        } catch (Exception ex){
            System.debug('Error in GenericLogicClass class within errorHandlingMethod : '+ex.getMessage());
        }
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)){
            return '';
        }
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = BASE64CHARS.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    private static final String BASE64CHARS = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> ples) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(ples), List<PicklistEntryWrapper>.class);
    }
    
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public PicklistEntryWrapper(){system.System.debug('Empty Constructor');}
        
    }
}