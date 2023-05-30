/*
* Company : Kvp Business Solution 
* Date    : 20-12-2018
* Author  : Sameer Ranjan
* Description : Controller of QC_MTL_Testing Component.
* History     : N/L
*/
public class QC_MTL_Testing_Controller {
    //get Pick List Value when Page Load.
    @AuraEnabled
    public static List<List<String>> getSchemaValue(){
        List<String> listofTestingType=new List<String>();//This list store all pick value of "Testing_Type__c" field whick object "QC_MTL_Component__c".
        List<String> listofMaterialType=new List<String>();//This list store all pick value of "Raw_Material_Type__c" field whick object "QC_MTL_Component__c"
        List<String> listofMatSample=new List<String>();//This list store all pick value of "Material_Sample_Type__c" field whick object "IDI_Input_Form__c"
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('QC_MTL_Component__c');//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> testingTypePickListValues = field_map.get('Testing_Type__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        listofTestingType.add('--None--');
        for (Schema.PicklistEntry var : testingTypePickListValues) { 
            listofTestingType.add(var.getValue());
        }
        List<Schema.PicklistEntry> rawMaterialpicklistvalues = field_map.get('Raw_Material_Type__c').getDescribe().getPickListValues();
        listofMaterialType.add('--None--');
        for(Schema.PicklistEntry var : rawMaterialpicklistvalues){
            listofMaterialType.add(var.getValue());
        }
        List<Schema.PicklistEntry> materialSamplevalues = field_map.get('Material_Sample_Type__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
       // listofMatSample.add('--None--');
        for(Schema.PicklistEntry var : materialSamplevalues){
            listofMatSample.add(var.getValue());
        }
        List<List<String>> PickListMap=new List<List<String>>();
        PickListMap.add(listofTestingType);
        PickListMap.add(listofMaterialType);
        PickListMap.add(listofMatSample);
        return PickListMap;
    }
}