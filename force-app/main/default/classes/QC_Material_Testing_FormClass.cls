public class QC_Material_Testing_FormClass {
    //get Pick List Value when Page Load.
    @AuraEnabled
    public static List<List<String>> getSchemaValue(){
        List<String> listofMaterialSampleType=new List<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('QC_MTL_Component__c');//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get('Material_Sample_Type__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofMaterialSampleType.add('--None--');
        for (Schema.PicklistEntry a : pick_list_values) {
            listofMaterialSampleType.add(a.getValue());
        }
        List<List<String>> PickListMap=new List<List<String>>();
        PickListMap.add(listofMaterialSampleType);
        return PickListMap;
    }
    @AuraEnabled
    public static sObject getRecordInformation(String RecordId){
        sobject returnvalue=[Select Id,Name,Report_Reference_Number__c from QC_MTL_Component__c where Id=:RecordId][0];
        system.debug('Sobject return value'+returnvalue);
        return returnvalue;
    }
    
    @AuraEnabled
    public Static string submitForAppProcess(String RecId){
        
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        //Passing record id 
        req.setObjectId(RecId);        
        Approval.ProcessResult result = Approval.process(req);
        string approvalResult = result.getInstanceStatus();
        return approvalResult;
    }
    
    @AuraEnabled
    public static boolean isRecordSubmitForApproval(Id recordId){
       // boolean val= Approval.LockResult(recordId);
        system.debug('recordId'+recordId);
        boolean returnval=Approval.isLocked(recordId);
        return returnval;
    }
}