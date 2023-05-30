/**
* @description       : 
* @author            : ChangeMeIn@UserSettingsUnder.SFDoc
* @group             : 
* @last modified on  : 06-16-2021
* @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
* Modifications Log 
* Ver   Date         Author                               Modification
* 1.0   06-01-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class QC_RelaibilityTestingTabCompClass {
    public QC_RelaibilityTestingTabCompClass() {}
  /*  @AuraEnabled
    public static string getCompDetail(string recdId){
        if(recdId != null){
            return QcInputComponentClass.getQcComponentPack(recdId);
        }
        Return null;
    }
    
    @AuraEnabled
    public static string saveClonedFWOrWHComponent( String cloneData ){
      //  try {
            return QcInputComponentClass.saveNewFWOrWHComponent( cloneData );
        //} catch (Exception e) {
           // throw new AuraHandledException(e.getMessage());
        //}
    }
    @AuraEnabled
    public static string getMasterVarient( string mvId ){
        //try {
            return QcInputComponentClass.getMasterVarient( mvId );
        //} catch (Exception e) {
           // throw new AuraHandledException(e.getMessage());
        //}
    }
    
    @AuraEnabled
    public static String fetchMatersTest( string compName, Id recId ){
        try {
            if( compName != null && recId != null  )
            {
                QC_components__c qcComp = [SELECT Id,Name,Name__c FROM QC_Components__c where Name__c =: compName And Parent__c =: recId LIMIT 1 ] ;
                if( qcComp.Id != null)
                {
                    return fetchQcTestData( qcComp.Id );
                }
            }
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    
    @AuraEnabled
    public static string fetchDependentPicklist( String objectDetails, String controllingField , String dependentField){
        try {
            Sobject objectInfo = (sObject) JSON.deserialize( objectDetails ,sObject.Class);
            return JSON.serialize( RetrivePicklistClass.getDependentMap( objectInfo, controllingField, dependentField ) );
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string getPickListValue(String picklistMap){
        try {
            return RetrivePicklistClass.getPickListValue( picklistMap );
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string fetchallMasterData(){
        try {
            return QcInputComponentClass.fetchallMasterData();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string fetchInputData(String qcCompId){
        try {
            return QcInputComponentClass.fetchInputData( qcCompId );
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //saveInputParamMethod is used for save the input parameter data in Qc Input Data
    @AuraEnabled
    public static void saveInputParamMethod(String inputParamList ){
        try {
            QcInputComponentClass.saveInputParamMethod(inputParamList );
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //deleteInputDataMethod is used to delete the input parameter row from Qc Input Data
    @AuraEnabled
    public static void deleteInputDataMethod( String inputDataRecstr ){
        try {
            QcInputComponentClass.deleteInputDataMethod(inputDataRecstr);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //saveChildQcCompMethod is used for updating child component whenever the parent record is updated
    @AuraEnabled
    public static void saveChildQcCompMethod( String qcCompInfoListStr ){
        try {
            if( qcCompInfoListStr != null)
            {
                QcInputComponentClass.saveChildQcCompMethod(qcCompInfoListStr);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string fetchQcTestData(string recId){
        try {
            
            if(recId != null){
                List<QC_Test_Data__c> testDataList = [SELECT Id, RecordTypeId,RecordType.Name, CreatedDate, Component_Name__c,Component_Name__r.Name__c,Condition_Ref__r.question__c, Condition_Ref__r.Question_Name__c, After_Test1__c, After_Test2__c, After_Test3__c, After_Test4__c, After_Test5__c, After_Test_Observation__c, Conclusion__c, Condition_Ref__c, Initial1__c, Initial2__c, Initial3__c, Initial4__c, Initial5__c, Initial_Test_Observation__c, Observation1__c,Observation2__c, Observation3__c, Observation4__c, Observation5__c, Observation__c, Comments_and_Remarks__c, Determined_value__c, Specification_Input__c, UOM_Input__c, Acceptance_Criteria__c, IsLast__c, Parent__c, RandomNumber__c, Test_Name__c, isManual__c, isParent__c, No_of_Samples__c,Active__c,imageurl__c FROM QC_Test_Data__c where Component_Name__c = :recId and Active__c = true];
                system.debug('testDataList'+testDataList);
                return JSON.serialize(testDataList);
            }
            return null;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string saveQcTestDataMethod(String qcTestListStr , String qcCompRec){
        try {
            if( qcCompRec != null)
            {
                QC_Components__c qcComp = (QC_Components__c) JSON.deserialize( qcCompRec , QC_Components__c.Class);
                if( qcComp != null && qcComp.Id != null )
                {
                    update qcComp;
                }
                
                List<RecordType> testRecTypeList = [SELECT Id,Name FROM RecordType WHERE SObjectType = 'QC_Test_Data__c' ];
                Map<string,RecordType> testRecTypeMap = new Map<string,RecordType>();
                for( RecordType recType : testRecTypeList ){
                    testRecTypeMap.put( recType.Name , recType );
                }
                if( qcTestListStr != null)
                {
                    TestDataWrap testDatawrapList =  (TestDataWrap)  JSON.deserialize( qcTestListStr , TestDataWrap.class);
                    if( testDatawrapList.testList.size()  > 0)
                    {
                        for(QC_Test_Data__c qcTest : testDatawrapList.testList)
                        {
                            if(qcComp.Name__c == 'Module' )
                                qcTest.RecordTypeId = testRecTypeMap.get('Module')?.Id;
                            else {
                                qcTest.RecordTypeId = testRecTypeMap.get('Others')?.Id;
                            }
                        }
                        
                        upsert( testDatawrapList.testList );
                        return JSON.serialize(testDatawrapList.testList);
                    }
                    
                }
            }
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    public class TestDataWrap{
        public List<QC_Test_Data__c> testList;
        public List<QC_Test_Data__c> testList2;
        public List<QC_Test_Data__c> testList3;
        public List<QC_Test_Data__c> testList4;
        public List<QC_Test_Data__c> testList5;
        public List<QC_Test_Data__c> testList6;
        public List<QC_Test_Data__c> testList7;
        public List<QC_Test_Data__c> testList8;
        public List<QC_Test_Data__c> testList9;
        public TestDataWrap(){  
            testList = new List<QC_Test_Data__c>();  
            testList2 = new List<QC_Test_Data__c>();
            testList3 = new List<QC_Test_Data__c>();  
            testList4 = new List<QC_Test_Data__c>();  
            testList5 = new List<QC_Test_Data__c>();
            testList6 = new List<QC_Test_Data__c>(); 
            testList7 = new List<QC_Test_Data__c>();  
            testList8 = new List<QC_Test_Data__c>();
            testList9 = new List<QC_Test_Data__c>();  
        }  
    }
    
    @AuraEnabled
    public static void deleteTestDataMethod(String testDataRecstr ){
        try {
            
            QC_Test_Data__c testRec = (QC_Test_Data__c) JSON.deserialize(testDataRecstr, QC_Test_Data__c.class);
            if( testRec.Id != null)
            {
                delete testRec;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void disableTestRec(List<Id> recIdList){
        try {
            List<QC_Test_Data__c> testList = new List<QC_Test_Data__c>(); 
            for(Id testId : recIdList ){
                QC_Test_Data__c testRec = new QC_Test_Data__c();
                testRec.Id = testId;
                testRec.Active__c = false;
                testList.add( testRec );
            }
            update testList;
        } catch (Exception e) {
            system.debug('exeception line:::::'+e.getLineNumber()+'Message::::'+e.getMessage()+'');
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public Static string submitForAppProcessTemp(String RecId1){
        return JSON.serialize(QcInputComponentClass.submitForAppProcess(RecId1));
    }
    
    @AuraEnabled
    public static boolean isRecordSubmitForApproval(Id recordId){
        boolean returnval=Approval.isLocked(recordId);
        return returnval;
    }
    
    @AuraEnabled
    public static void updatePicturePath(String rec){
        try {
            if( rec != null)
            {
                QC_Components__c qcComp = (QC_Components__c) JSON.deserialize( rec , QC_Components__c.Class);
                if(qcComp.Id != null){
                    update qcComp;
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static String saveIndividualQcComp( String qcComp){
        try {
            if( qcComp != null)
            {
                QC_Components__c qcComponent = (QC_Components__c) JSON.deserialize(qcComp,QC_Components__c.class);
                if( qcComponent.Id != null)
                    update qcComponent;
                return JSON.serialize( qcComponent );
            }
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled
    public static String fetchAllChildCompInputParam( List<String> allQcCompIdList ){
        try {
            if(! allQcCompIdList.isEmpty())
            {
                return QcInputComponentClass.fetchAllChildCompInputParam(allQcCompIdList);
            }
            return null ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
    
}