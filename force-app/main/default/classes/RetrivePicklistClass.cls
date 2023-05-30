/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-03-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   06-01-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class RetrivePicklistClass {
    
      public RetrivePicklistClass() {} 
    
   /* //this method for getting the controlling and dependent values fo the given fields
    public static Map<String,List<String>> getDependentMap(sObject objDetail, string contrfieldApiName,string depfieldApiName) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType == null){
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            //finalValues.put(contrfieldApiName,objResults);
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
        // objResults.get(depfieldApiName).sort();
        //finalValues.put(contrfieldApiName,objResults);
        
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
    
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }


    // fetch the picklist values
    public class PicklistWrapClass
    {
        public string objectName;
        public string picklistFieldName;
        public list<string> picklistValues; 
        public string attributeName;
    }

    // getPickListValue method is used for fetching all requested picklist values from schema at a time
    
    public static String getPickListValue(String picklistMap ){
        try {
            List<PicklistWrapClass>  picklistWrapList= (List<PicklistWrapClass>) JSON.deserialize(picklistMap,List<PicklistWrapClass>.class);
            if( picklistWrapList.size() > 0 )
            {
                for(PicklistWrapClass  picklistWrap : picklistWrapList )
                {
                    string objectApiName = picklistWrap.objectName ;
                    string pickListFieldApiName = picklistWrap.picklistFieldName ;
                    system.debug('fieldName==>'+pickListFieldApiName);
                    List<String> returnValueList = new List<String>();
                    Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectApiName); //From the Object Api name retrieving the SObject
                    Sobject objectName = targetType.newSObject();
                    Schema.sObjectType sobjectType = objectName.getSObjectType(); //grab the sobject that was passed
                    Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe(); //describe the sobject
                    Map<String, Schema.SObjectField> fieldMap = sobjectDescribe.fields.getMap(); //get a map of fields for the passed sobject
                    List<Schema.PicklistEntry> schemaPickListValues = fieldMap.get(pickListFieldApiName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
                    for (Schema.PicklistEntry var :schemaPickListValues) {
                        returnValueList.add(var.getValue());
                    }
                    picklistWrap.picklistValues = returnValueList;
                }
            }
            return JSON.serialize( picklistWrapList );

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
}