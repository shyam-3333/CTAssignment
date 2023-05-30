/*
 * Company : Kvp Business Solution 
* Date    : 10/1/2019
* Author  : Sameer Ranjan
* Description : Controller Class of QC_Mtl_Plating_InputParam.cmp Component
* History     : N/L 
*/
public class QC_Mtl_Plating_InputParamClass {
    //This Method Return the Map of dependent PickList (Department and Plating Type PickList) 
   
    @AuraEnabled  
    public static Map<String,List<String>> getDependentOptionsImplements(string objApiName , string contrfieldApiName , string depfieldApiName){
       return QC_MTL_InputForm_Class.getDependentOptionsImplements(objApiName, contrfieldApiName, depfieldApiName);
    }
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
    @AuraEnabled
    public static List<String> getOptionTestValues(){
        return QC_MTL_InputForm_Class.getOptionTestValues();
    }
    @AuraEnabled
    public static recordInfo fetchRecordInfo(sObject Info){
        QC_MTL_Component__c obj1 = (QC_MTL_Component__c) Info;
        List<QC_MTL_Component__c> returnResult = new list<QC_MTL_Component__c>();
        if(obj1 != null){
            returnResult=[SELECT ID,Name,Optional_Test__c,Document_Status__c,Record_Status__c,Sample_Size_Qty__c,Testing_Type__c,Material_Sample_Type__c,Sample_Received_Date__c,
                       Final_Verdict__c,Sample_Received_From__c,MTL_User__c,Department__c,MTL_User__r.Name,Brand__c,Brand__r.Name,Specification_revision__c,Supplier_Name__c,Invoice_Dc_No__c,RM_Size__c,
                        Heat_No_Grade__c,Titan_Specification_Reference__c,Titan_Specification_Reference__r.Name,Part_Name__c,Source__c,Model__c,Docket_Number__c,Supply_Quantity__c,Batch_Quantity__c,
                        Supplier_Grade__c,Supplier_Grade__r.Name,Material__c,Plating_Type__c,Required_Test__c,Sample_Size_Plating__c,Component_Name__c,Chemical_Composition_Elements__c,
                        Chemical_Composition_Elements_2__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,Chemical_Composition_Elements_5__c,Chemical_Composition_ElementsObser1__c,Chemical_Composition_ElementsObser2__c,
                        Chemical_Composition_ElementsObser3__c,Chemical_Composition_ElementsObser4__c,Chemical_Composition_ElementsObservation__c,Chemical_Composition_ElementsResult__c,Remarks__c,
                        Chemical_Composition_ElementsResult1__c,Actual_Department_Name__c,Supplier_Name_New__c,Plater_Name__c,Plater_Name__r.Name,Supplier_Name_New__r.Name,Department_PMC__c,Required_test_PMC__c,Chemical_Composition_ElementsResult2__c,Chemical_Composition_ElementsResult3__c,Chemical_Composition_ElementsResult4__c,General_Observation__c,Component_Accessories__c,Component_Others__c FROM QC_MTL_Component__c WHERE Id =:obj1.Id];
        }
                System.debug('returnResult--'+returnResult);
        recordInfo returnresultObject=new recordInfo();
        returnresultObject.records=new List<QC_MTL_Component__c>(returnResult);
        returnresultObject.getplatingValues=new List<platingValues>();
        platingValues option;
        if(returnresultObject.records[0].Optional_Test__c!=null){
          for(string SelectedValue: returnresultObject.records[0].Optional_Test__c.split(',')){
            option=new platingValues();
            option.label=SelectedValue;
            option.value=SelectedValue;
            returnresultObject.getplatingValues.add(option);
        }  
        }
        
       // returnresultObject.getplatingValues=getOptionalTestValues();
        return returnresultObject;
    }
    public class recordInfo{
        @AuraEnabled
        public List<QC_MTL_Component__c> records;
        @AuraEnabled
        public List<platingValues> getplatingValues;
    }
    @AuraEnabled
    public static ReturnWrapperClass saveRecordMethod(QC_MTL_Component__c recordInfo,List<QC_MTL_TestResponse__c> mandatoryTest,String newTest,String optionalTest,string regularTest){
        system.debug(recordInfo.Plater_Name__c);
        update recordInfo;
        system.debug('recordInfo : '+recordInfo.Plater_Name__c);
        insert mandatoryTest;
        System.debug('optionalTest:::'+optionalTest);
       System.debug('regularTest:::'+regularTest);
        system.debug('mandatoryTest'+mandatoryTest);
        List<wrapperClass> newTestRecords=(List<wrapperClass>)System.JSON.deserialize(newTest, List<wrapperClass>.class);
        //System.debug('optionalTestList::::'+optionalTestList);
        //System.debug('regularTestList:::::'+regularTestList);
        List<QC_MTL_Test__c> insertValue=new List<QC_MTL_Test__c>();
        for(wrapperClass var : newTestRecords){
            if(var.testName!=null && var.testName!=''){
                insertValue.add(new QC_MTL_Test__c(Name=var.testName));
            }
        }
        insert insertValue;
        
        Map<Id,QC_MTL_TestResponse__c> mapOfResponse=new Map<Id,QC_MTL_TestResponse__c>();
        Set<Id> idOfNewTest=new Set<Id>();
        for(QC_MTL_Test__c var : insertValue){
            if(var.id!=null){
                idOfNewTest.add(var.Id);
            }
        }
        integer i=0;
        for(Id var : idOfNewTest){
            mapOfResponse.put(var,(new QC_MTL_TestResponse__c(Name=newTestRecords[i].testName,User_Defined_Value__c=newTestRecords[i].userInput,Result__c=newTestRecords[i].testVerdict,QC_MTL_Component_del__c=recordInfo.Id,Standard_Defined_Value__c=newTestRecords[i].standardDefinedValue,Minimum__c=newTestRecords[i].minValue,Maximum__c=newTestRecords[i].maxValue)));
            i++;
        }
        map<id,QC_Test_Questions_Value__c> mapOfTestQuestion=new map<id,QC_Test_Questions_Value__c>();
        integer j=0;
        for(Id var : idOfNewTest){
            mapOfTestQuestion.put(var,(new QC_Test_Questions_Value__c(name='Test'+j,Standard_Defined_Value__c=newTestRecords[j].standardDefinedValue,QC_MTL_Test__c=var)));
            j++;
        }
        insert mapOfTestQuestion.values();
        List<QC_MTL_TestResponse__c> insertResponseValue=new List<QC_MTL_TestResponse__c>();
        QC_MTL_TestResponse__c insertTestresponse;
        for(Id var : idOfNewTest){
            insertTestresponse=new QC_MTL_TestResponse__c();
            insertTestresponse=mapOfResponse.get(var);
            insertTestresponse.QC_Test_Questions_Value__c=mapOfTestQuestion.get(var).Id;
            insertTestresponse.QC_MTL_Test__c=var;
            insertTestresponse.Standard_Defined_Value__c=mapOfTestQuestion.get(var).Standard_Defined_Value__c;
            insertTestresponse.Minimum__c=mapOfResponse.get(var).Minimum__c;
            insertTestresponse.Maximum__c=mapOfResponse.get(var).Maximum__c;
            insertResponseValue.add(insertTestresponse);
        }
        insert insertResponseValue;
        List<QC_MTL_TestResponse__c> allTestResponseList=new List<QC_MTL_TestResponse__c>();
        allTestResponseList.addAll(mandatoryTest);
        allTestResponseList.addAll(insertResponseValue);
        List<wrapperClass> returnList=new List<wrapperClass>();
        //wrapperClass returnValue;
        Set<Id> alltestResponseId=new Set<Id>();
        for(QC_MTL_TestResponse__c var:allTestResponseList){
            alltestResponseId.add(var.Id);
        }
        List<QC_MTL_TestResponse__c> allTestResponseListQuery=[Select QC_Test_Questions_Value__c,QC_MTL_Test__c,Minimum__c,Maximum__c,QC_Test_Questions_Value__r.Standard_Defined_Value__c,QC_MTL_Test__r.Name,QC_MTL_Component_del__c,User_Defined_Value__c,Result__c,QC_MTL_Test__r.IsMandatory__c,Id From QC_MTL_TestResponse__c where Id in :alltestResponseId order by QC_MTL_Test__r.IsMandatory__c desc];
        for(QC_MTL_TestResponse__c var : allTestResponseListQuery){
            returnList.add(new wrapperClass(var.QC_Test_Questions_Value__c,var.QC_MTL_Test__c,var.QC_Test_Questions_Value__r.Standard_Defined_Value__c,var.QC_MTL_Test__r.Name,var.QC_MTL_Component_del__c,var.User_Defined_Value__c,var.Result__c,var.QC_MTL_Test__r.IsMandatory__c,var.Id,var.Minimum__c,var.Maximum__c));
        }
        List<wrapperClass> optionalTestList=(List<wrapperClass>)System.JSON.deserialize(optionalTest, List<wrapperClass>.class);
        List<wrapperClass> regularTestList=(List<wrapperClass>)System.JSON.deserialize(regularTest, List<wrapperClass>.class);
        List<QC_MTL_TestResponse__c> insertoptionalTestList=new List<QC_MTL_TestResponse__c>();
        List<QC_MTL_TestResponse__c> insertregularTestList=new List<QC_MTL_TestResponse__c>();
        
        for(wrapperClass var : optionalTestList){
            if(var.testVerdict!=null)
            insertoptionalTestList.add(new QC_MTL_TestResponse__c(Result__c=var.testVerdict,User_Defined_Value__c=var.userInput,Name=var.testName,QC_MTL_Component_del__c=recordInfo.Id,Standard_Defined_Value__c=var.standardDefinedValue,Plating_Testing_Type__c='Optional'));
        }
        for(wrapperClass var : regularTestList){
            if(var.testVerdict!=null)
            insertregularTestList.add(new QC_MTL_TestResponse__c(Result__c=var.testVerdict,User_Defined_Value__c=var.userInput,Name=var.testName,QC_MTL_Component_del__c=recordInfo.Id,Standard_Defined_Value__c=var.standardDefinedValue,Plating_Testing_Type__c='Regular'));
        }
        insert insertoptionalTestList;
        insert insertregularTestList;
        integer x=0,y=0;
        for(QC_MTL_TestResponse__c var : insertoptionalTestList){
            optionalTestList[x].QCMTLTestResponseId=var.Id;
            x++;
        }
        for(QC_MTL_TestResponse__c var : insertregularTestList){
            regularTestList[y].QCMTLTestResponseId=var.Id;
            y++;
        }
        ReturnWrapperClass returnLists=new ReturnWrapperClass();
        returnLists.optionalTests=new List<wrapperClass>();
        returnLists.optionalTests=optionalTestList;
        returnLists.regularTestLists=new List<wrapperClass>();
        returnLists.regularTestLists=regularTestList;
        returnLists.TestLists=new List<wrapperClass>();
        returnLists.TestLists=returnList;
        
        return returnLists;
    }
    @AuraEnabled
    public static List<wrapperClass> getTestParameter(QC_Access_Master__c titanspecNumber,String QCMtlComponentId,Integer sampleSize,String DepartTName){
        system.debug('where candition:::::::::::'+titanspecNumber);
        List<QC_MTL_Test__c> testParameters=[Select Id,Name from QC_MTL_Test__c where Titan_Specification__c =:titanspecNumber.Id];
        System.debug('return Result'+testParameters);
        set<Id> TestIds=new set<Id>();
        for(QC_MTL_Test__c var :testParameters){
            TestIds.add(var.Id);
        }
        Boolean minMaxDisabled;
        if(DepartTName=='QC Appearance' || DepartTName=='IDI' || DepartTName=='Vendor Plating'){
            sampleSize=1;
            minMaxDisabled=false;
        }
        else{
            minMaxDisabled=true;
        }
        if(DepartTName=='Customer Assurance' || DepartTName == 'Case IQF'){
            sampleSize = 3;
        }
        List<QC_Test_Questions_Value__c> testparList=[Select id,name,QC_MTL_Test__r.Name,Minimum__c,Maximum__c,QC_MTL_Test__r.IsMandatory__c,Standard_Defined_Value__c,QC_MTL_Test__c From QC_Test_Questions_Value__c where QC_MTL_Test__c in :TestIds order by QC_MTL_Test__r.IsMandatory__c desc];
        system.debug('testparList ::::::::::::'+testparList);
       //return testParameters;
        List<wrapperClass> returnRecordList=new List<wrapperClass>();
        wrapperClass returnRecord;      
        for(QC_Test_Questions_Value__c var:testparList){
            for(Integer x=0;x<sampleSize;x++) {
            returnRecord=new wrapperClass(var.id,var.QC_MTL_Test__c,var.Standard_Defined_Value__c,var.QC_MTL_Test__r.Name,QCMtlComponentId,'','None',var.QC_MTL_Test__r.IsMandatory__c,'',var.Minimum__c,var.Maximum__c,minMaxDisabled);
            returnRecordList.add(returnRecord);
            }
        }
        system.debug('returnRecord:::::::'+returnRecord);
        return returnRecordList;
    }
    @AuraEnabled
    public static ReturnWrapperClass updateTestParameter(QC_MTL_Component__c recordInfo,String getUpdateRecords,String newTest,string optionalTest,string regularTest,List<string> deletePreviousResponse){
        system.debug('deletePreviousResponse'+deletePreviousResponse);
        if(deletePreviousResponse.size()>0){
            List<QC_MTL_TestResponse__c> deleteResponse=new List<QC_MTL_TestResponse__c>();
            for(String responsId:deletePreviousResponse){
                deleteResponse.add(new QC_MTL_TestResponse__c(Id=responsId));
            }
            database.delete(deleteResponse);
        }
        system.debug(recordInfo.Plater_Name__c);
        update recordInfo;
        List<wrapperClass> recordObject=(List<wrapperClass>)System.JSON.deserialize(getUpdateRecords,List<wrapperClass>.class);
        System.debug('recordObject::::::::'+recordObject);
        List<QC_MTL_TestResponse__c> updateTestRecordList=new List<QC_MTL_TestResponse__c>();
        //QC_MTL_TestResponse__c updateRecord;
        for(wrapperClass var : recordObject){
            if(var.QCMTLTestResponseId!='' || var.QCMTLTestResponseId!=null)
            updateTestRecordList.add(new QC_MTL_TestResponse__c(Id=var.QCMTLTestResponseId,Result__c=var.testVerdict,User_Defined_Value__c=var.userInput,Minimum__c=var.minValue,Maximum__c=var.maxValue));
        }
        database.update(updateTestRecordList);
        List<wrapperClass> newTestRecords=(List<wrapperClass>)System.JSON.deserialize(newTest, List<wrapperClass>.class);
        List<QC_MTL_Test__c> insertValue=new List<QC_MTL_Test__c>();
        for(wrapperClass var : newTestRecords){
            if(var.testName!=null && var.testName!=''){
                insertValue.add(new QC_MTL_Test__c(Name=var.testName));
            }
        }
        insert insertValue;
        Map<Id,QC_MTL_TestResponse__c> mapOfResponse=new Map<Id,QC_MTL_TestResponse__c>();
        Set<Id> idOfNewTest=new Set<Id>();
        for(QC_MTL_Test__c var : insertValue){
            if(var.id!=null){
                idOfNewTest.add(var.Id);
            }
        }
        integer i=0;
        for(Id var : idOfNewTest){
            mapOfResponse.put(var,(new QC_MTL_TestResponse__c(Name=newTestRecords[i].testName,User_Defined_Value__c=newTestRecords[i].userInput,Result__c=newTestRecords[i].testVerdict,QC_MTL_Component_del__c=recordInfo.Id,Minimum__c=newTestRecords[i].minValue,Maximum__c=newTestRecords[i].maxValue)));
            i++;
        }
        map<id,QC_Test_Questions_Value__c> mapOfTestQuestion=new map<id,QC_Test_Questions_Value__c>();
        integer j=0;
        for(Id var : idOfNewTest){
            mapOfTestQuestion.put(var,(new QC_Test_Questions_Value__c(name='Test'+j,Standard_Defined_Value__c=newTestRecords[j].standardDefinedValue,QC_MTL_Test__c=var)));
            j++;
        }
        insert mapOfTestQuestion.values();
        List<QC_MTL_TestResponse__c> insertResponseValue=new List<QC_MTL_TestResponse__c>();
        QC_MTL_TestResponse__c insertTestresponse;
        for(Id var : idOfNewTest){
            insertTestresponse=new QC_MTL_TestResponse__c();
            insertTestresponse=mapOfResponse.get(var);
            insertTestresponse.QC_Test_Questions_Value__c=mapOfTestQuestion.get(var).Id;
            insertTestresponse.QC_MTL_Test__c=var;
            insertTestresponse.Standard_Defined_Value__c=mapOfTestQuestion.get(var).Standard_Defined_Value__c;
            insertResponseValue.add(insertTestresponse);
        }
        insert insertResponseValue;
        List<QC_MTL_TestResponse__c> allTestResponseList=new List<QC_MTL_TestResponse__c>();
        allTestResponseList.addAll(updateTestRecordList);
        allTestResponseList.addAll(insertResponseValue);
        List<wrapperClass> returnList=new List<wrapperClass>();
        //wrapperClass returnValue;
        Set<Id> alltestResponseId=new Set<Id>();
        for(QC_MTL_TestResponse__c var:allTestResponseList){
            alltestResponseId.add(var.Id);
        }
        List<QC_MTL_TestResponse__c> allTestResponseListQuery=[Select QC_Test_Questions_Value__c,Minimum__c,Maximum__c,QC_MTL_Test__c,QC_Test_Questions_Value__r.Standard_Defined_Value__c,QC_MTL_Test__r.Name,QC_MTL_Component_del__c,User_Defined_Value__c,Result__c,QC_MTL_Test__r.IsMandatory__c,Id From QC_MTL_TestResponse__c where Id in :alltestResponseId order by QC_MTL_Test__r.IsMandatory__c desc];
        for(QC_MTL_TestResponse__c var : allTestResponseListQuery){
            returnList.add(new wrapperClass(var.QC_Test_Questions_Value__c,var.QC_MTL_Test__c,var.QC_Test_Questions_Value__r.Standard_Defined_Value__c,var.QC_MTL_Test__r.Name,var.QC_MTL_Component_del__c,var.User_Defined_Value__c,var.Result__c,var.QC_MTL_Test__r.IsMandatory__c,var.Id,var.Minimum__c,var.Maximum__c));
        }
        List<wrapperClass> optionalTestList=(List<wrapperClass>)System.JSON.deserialize(optionalTest, List<wrapperClass>.class);
        List<wrapperClass> regularTestList=(List<wrapperClass>)System.JSON.deserialize(regularTest, List<wrapperClass>.class);
        List<QC_MTL_TestResponse__c> insertoptionalTestList=new List<QC_MTL_TestResponse__c>();
        List<QC_MTL_TestResponse__c> insertregularTestList=new List<QC_MTL_TestResponse__c>();
        System.debug('optionalTestList::::'+optionalTestList);
        System.debug('regularTestList::::'+regularTestList);
        
        for(wrapperClass var : optionalTestList){
            if(var.testVerdict!=null)
            insertoptionalTestList.add(new QC_MTL_TestResponse__c(Id=var.QCMTLTestResponseId,Result__c=var.testVerdict,User_Defined_Value__c=var.userInput,Name=var.testName,QC_MTL_Component_del__c=recordInfo.Id));
        }
        for(wrapperClass var : regularTestList){
            if(var.testVerdict!=null)
            insertregularTestList.add(new QC_MTL_TestResponse__c(Id=var.QCMTLTestResponseId,Result__c=var.testVerdict,User_Defined_Value__c=var.userInput,Name=var.testName,QC_MTL_Component_del__c=recordInfo.Id));
        }
        System.debug('insertoptionalTestList:::'+insertoptionalTestList);
        system.debug('insertregularTestList::::'+insertregularTestList);
        if(insertoptionalTestList.size()!=0){
        update insertoptionalTestList;
        
        }
        if(insertregularTestList.size()!=0){
            update insertregularTestList;
        }
        integer x=0,y=0;
        for(QC_MTL_TestResponse__c var : insertoptionalTestList){
            optionalTestList[x].QCMTLTestResponseId=var.Id;
            x++;
        }
        for(QC_MTL_TestResponse__c var : insertregularTestList){
            regularTestList[y].QCMTLTestResponseId=var.Id;
            y++;
        }
        ReturnWrapperClass returnLists=new ReturnWrapperClass();
        returnLists.optionalTests=new List<wrapperClass>();
        returnLists.optionalTests=optionalTestList;
        returnLists.regularTestLists=new List<wrapperClass>();
        returnLists.regularTestLists=regularTestList;
        returnLists.TestLists=new List<wrapperClass>();
        returnLists.TestLists=returnList;
        
        return returnLists;
    }
    class platingValues{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
    }
    @AuraEnabled
    public static List<platingValues> getOptionalTestValues(){
       List<platingValues> ListPlatingType=new List<platingValues>();//This list store all pick value of "Chemical_Composition_Elements__c" field whick object "QC_MTL_Component__c".
        
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('QC_MTL_Component__c');//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> optionalTestPickListValues = field_map.get('Optional_Test__c').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        platingValues option;
        for (Schema.PicklistEntry var : optionalTestPickListValues) {
            option=new platingValues();
            option.label=var.getValue();
            option.value=var.getValue();
            ListPlatingType.add(option);
        }
        System.debug('ListPlatingType:::::::::::::'+ListPlatingType);
        return ListPlatingType;
    }
    @AuraEnabled
    public static List<String> getRegularTestCSValues(){
        List<String> returnResult=new List<String>();
        List<Regular_Test__c> CustomSettingAllValue = Regular_Test__c.getall().values();
        for(Regular_Test__c var : CustomSettingAllValue){
            returnResult.add(var.DepartmentPlatingTestWithRegular__c);
        }
        System.debug(returnResult);
        
        return returnResult;
    }
    @AuraEnabled
    public static List<wrapperClass> getOldTestResponseRecords(string recordId){
         List<wrapperClass> result=new  List<wrapperClass>();
        wrapperClass resultOb;
        List<QC_MTL_TestResponse__c> allTestResponseList=[Select Standard_Defined_Value__c,Maximum__c,Minimum__c,Plating_Testing_Type__c,Name,QC_MTL_Component_del__r.Titan_Specification_Reference__r.Name,User_Defined_Value__c,Result__c,QC_MTL_Test__r.IsMandatory__c,Id From QC_MTL_TestResponse__c where QC_MTL_Component_del__c=:recordId order by QC_MTL_Test__r.IsMandatory__c desc ];
       // List<QC_MTL_Component__c> materialCompositionPickList=[Select Chemical_Composition_Elements__c,Chemical_Composition_Elements_2__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,Chemical_Composition_Elements_5__c From QC_MTL_Component__c where id=:recordId];
        for(QC_MTL_TestResponse__c var : allTestResponseList){
            resultOb=new wrapperClass();
            resultOb.userInput=var.User_Defined_Value__c;
            resultOb.testVerdict=var.Result__c;
            resultOb.testName=var.Name;
            resultOb.standardDefinedValue=var.Standard_Defined_Value__c;
            resultOb.IsmandatoryTest=var.QC_MTL_Test__r.IsMandatory__c;
            resultOb.QCMTLTestResponseId=var.Id;
            resultOb.PlatingTestType=var.Plating_Testing_Type__c;
            resultOb.minValue=var.Minimum__c;
            resultOb.maxValue=var.Maximum__c;
            result.add(resultOb);
          }
        return result;
    }
    @AuraEnabled
    public static void deleteTestResponse(string recordId){
        if(recordId!=null)
        delete([Select Id From QC_MTL_TestResponse__c where QC_MTL_Component_del__c=:recordId]);
    }
    public class ReturnWrapperClass{
        @AuraEnabled
        public List<wrapperClass> optionalTests;
        @AuraEnabled
        public List<wrapperClass> regularTestLists;
        @AuraEnabled
        public List<wrapperClass> TestLists;
    }
    public class wrapperClass{
        @AuraEnabled
        public String qcMTLQuestionRecordId;
        @AuraEnabled
        public String userInput;
        @AuraEnabled 
        public String testVerdict;
        @AuraEnabled
        public String testRecordId;
        @AuraEnabled
        public String standardDefinedValue;
        @AuraEnabled
        public String testName;
        @AuraEnabled
        public String QCMTLComponent;
        @AuraEnabled 
        public boolean IsmandatoryTest;
        @AuraEnabled
        public String QCMTLTestResponseId;
        @AuraEnabled
        public String PlatingTestType;
        @AuraEnabled
        public Decimal minValue;
        @AuraEnabled
        public Decimal maxValue;
        @AuraEnabled
        public Boolean minMaxDisabled;
        wrapperClass(){
            
        }
        wrapperClass(String qcMTLQuestionRecordId,String testRecordId,String standardDefinedValue,String testName,String QCMTLComponent,String userInput,String testVerdict,boolean IsmandatoryTest,String QCMTLTestResponseId,Decimal minValue,Decimal maxValue){
            this.qcMTLQuestionRecordId=qcMTLQuestionRecordId;
            this.testRecordId=testRecordId;
            this.standardDefinedValue=standardDefinedValue;
            this.testName=testName;
            this.QCMTLComponent=QCMTLComponent;
            this.userInput=userInput;
            this.testVerdict=testVerdict;
            this.IsmandatoryTest=IsmandatoryTest;
            this.QCMTLTestResponseId=QCMTLTestResponseId;
            this.minValue=minValue;
            this.maxValue=maxValue;
        }
        wrapperClass(String qcMTLQuestionRecordId,String testRecordId,String standardDefinedValue,String testName,String QCMTLComponent,String userInput,String testVerdict,boolean IsmandatoryTest,String QCMTLTestResponseId,Decimal minValue,Decimal maxValue,Boolean minMaxDisabled){
            this.qcMTLQuestionRecordId=qcMTLQuestionRecordId;
            this.testRecordId=testRecordId;
            this.standardDefinedValue=standardDefinedValue;
            this.testName=testName;
            this.QCMTLComponent=QCMTLComponent;
            this.userInput=userInput;
            this.testVerdict=testVerdict;
            this.IsmandatoryTest=IsmandatoryTest;
            this.QCMTLTestResponseId=QCMTLTestResponseId;
            this.minValue=minValue;
            this.maxValue=maxValue;
            this.minMaxDisabled=minMaxDisabled;
        }
    }
     @AuraEnabled
    public static list<QC_Access_Master__c> specRevisionValue(String titanSpecificationId){
        list<QC_Access_Master__c> specRevLst = new list<QC_Access_Master__c>();
        specRevLst = [SELECT Id,Specification_Revision__c,TCL_Designation__c FROM QC_Access_Master__c WHERE Id =:titanSpecificationId];
        return specRevLst;
        
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
}