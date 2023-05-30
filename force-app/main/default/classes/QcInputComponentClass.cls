/**
 * @description       : 
 * @author            : Mutturaj Heroor
 * @group             : 
 * @last modified on  : 06-16-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-22-2021   Mutturaj Heroor                      Initial Version
**/
public class QcInputComponentClass {
     public QcInputComponentClass() {}
    
   /* @AuraEnabled
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
    

    // getBrandName is used to Fetch Name Of the Brand From Qc Master object
    @AuraEnabled
    public static string getBrandName(string brandId){
        try {
            if( brandId != null )
            {
                // if (Schema.sObjectType.QC_Master__c.fields.Name.isAccessible()) {
                //     return null;
                // }
                QC_Master__c brand = [SELECT id,Name FROM QC_Master__c where id =: brandId ];
                system.debug(brand);
                 return brand.Name;
            }else{
                return null ;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string getMasterVarient( string mvId ){
        try {
            if( mvId != null )
            {
                return [SELECT Name FROM QC_Components__c where Id =: mvId Limit 1].Name ;
            }
            return null;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // fetchallMasterData is used for fetching all the Master which used in Qc Application
    @AuraEnabled
    public static String fetchallMasterData(){
        try {
            List<QC_Master__c> qcMasterList = [SELECT Id,Name,RecordTypeId,RecordType.Name FROM QC_Master__c];
            List<QC_Question__c> qcQuestionList = [SELECT Acceptance_Criteria__c,Comment_Required__c,Competitor_Products__c,Component_Type__c,Id,IsNumeric__c,Name,Onload__c,Order_Number__c,Question_Unique_No__c,Question__c,RecordTypeId,RecordType.Name,Response_Required__c,Specification__c,Test_Name__c,Type__c,UOM__c FROM QC_Question__c Order By Order_Number__c];
            List<QC_Response__c> qcResponseList = [SELECT Component_Type__c,Id,Name,Order_Number__c,Question_Name__c,Question__r.Name,Question__c,Response__c,Res_Unique_No__c FROM QC_Response__c Order By Order_Number__c];
            List<QC_Condition__c>  qcConditonList = [SELECT Action__c,Brand__c,Brand__r.Name,Component_Type__c,Dependent_Response_Text__c,Dependent_Response__c,Dependent_Response__r.Name,Id,IsEditableUOMSPEC__c,isVisible__c,Multiple_Responses__c,MultiSkip__c,Name,Onload__c,Order_Number__c,Question_Name__c,Question__c,Question__r.Question__c,Question__r.Component_Type__c,RecordTypeId,RecordType.Name,Response_Text__c,Response__c, Response__r.Name,Response__r.Response__c,Response__r.Question__c,Type_of_Module__c, Question__r.UOM__c,Question__r.Test_Name__c,Question__r.Specification__c FROM QC_Condition__c Order By Order_Number__c];
            
            List<MasterWrapClass> returnObjectLists = new List<MasterWrapClass>();
            MasterWrapClass mwrap1 = new MasterWrapClass();
            mwrap1.sobjectType = 'QC_Master__c';
            mwrap1.sobjectList = qcMasterList;
            returnObjectLists.add(mwrap1);

            MasterWrapClass mwrap2 = new MasterWrapClass();
            mwrap2.sobjectType = 'QC_Question__c';
            mwrap2.sobjectList = qcQuestionList;
            returnObjectLists.add(mwrap2);

            MasterWrapClass mwrap3 = new MasterWrapClass();
            mwrap3.sobjectType = 'QC_Response__c';
            mwrap3.sobjectList = qcResponseList;
            returnObjectLists.add(mwrap3);

            MasterWrapClass mwrap4 = new MasterWrapClass();
            mwrap4.sobjectType = 'QC_Condition__c';
            mwrap4.sobjectList = qcConditonList;
            returnObjectLists.add(mwrap4);
            system.debug(returnObjectLists);

            return JSON.serialize( returnObjectLists );
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class MasterWrapClass{
        public string sobjectType;
        public List<sObject> sobjectList ;
    }

    // saveNewFWOrWHComponent method is Used for Creating new Components with all Parent and chid component
    @AuraEnabled
    public static String saveNewFWOrWHComponent( String newFWOrWHData ){
        try {
            system.debug('newFWOrWHData' + newFWOrWHData);
            if( newFWOrWHData != null )
            {
                SaveDataGroupWrap saveGrpRec = (SaveDataGroupWrap) JSON.deserialize(newFWOrWHData, SaveDataGroupWrap.class);
                SaveDataGroupWrap returnsaveGrpRec = new SaveDataGroupWrap();
                QC_Components__c parentComp = saveGrpRec.parentDetail.qcComp ;
                System.debug('test component --->>'+ parentComp );
                parentComp.Component_Status__c = 'Active';
                parentComp.Document_Status__c = 'Draft' ;
                System.debug('test component --->>'+ parentComp );
                insert parentComp;
                returnsaveGrpRec.parentDetail.qcComp = parentComp ;

                    List<QC_Input_Data__c> qcInputDataList = saveGrpRec.parentDetail.inputParam;
                    for( QC_Input_Data__c qcInput : qcInputDataList )
                    {
                        qcInput.Component_No__c = parentComp.Id;
                        qcInput.Id = null;
                        System.debug( qcInput );
                    }


                    if( qcInputDataList.size() > 0 )
                    {
                        insert qcInputDataList;
                        System.debug('Name-> '+ parentComp.Name);
                        returnsaveGrpRec.parentDetail.inputParam = qcInputDataList;
                    }


                    List<QC_Test_Data__c> qcTestDataList = saveGrpRec.parentDetail.testData;
                    if( qcTestDataList != null )
                    {
                        for( QC_Test_Data__c qcTest : qcTestDataList )
                        {
                            qcTest.Component_Name__c = parentComp.Id;
                            qcTest.Id = null;
                            System.debug( qcTest );
                        }
                        
                        
                        if( qcTestDataList.size() > 0 )
                        {
                            insert qcTestDataList;
                            System.debug('Name-> '+ parentComp.Name);
                            if(qcTestDataList != null){
                            returnsaveGrpRec.parentDetail.testData = qcTestDataList;
                            }
                        }
                    }
                    
                    List<QC_Components__c> childQcCompList = new List<QC_Components__c>();
                    List<QC_Input_Data__c> childAllQcInputParmList = new List<QC_Input_Data__c>();
                    List<QC_Test_Data__c> childAllQcTestDataList = new List<QC_Test_Data__c>();
                
                	QC_Components__c childComp;
                    for( SaveDataWrap saveDt : saveGrpRec.childsDetail )
                    {
                        childComp = saveDt.qcComp ;
                        childComp.Parent__c = parentComp.Id;
                        childComp.Component_Status__c = 'Active';
                        childComp.Document_Status__c = 'Draft' ;
                        childQcCompList.add( childComp );
                    }
                
                	
                    if( childQcCompList.size() > 0 )
                    {
                        insert childQcCompList;
                        
                        List<SaveDataWrap> sdWrapList = new List<SaveDataWrap>();
                        for( SaveDataWrap saveDt : saveGrpRec.childsDetail )
                        {
                            childComp = saveDt.qcComp ;
                            List<QC_Input_Data__c> childInputparamList = saveDt.inputParam ;
                            for( QC_Input_Data__c qcChildInput : childInputparamList )
                            {
                                qcChildInput.Component_No__c = childComp.Id;
                                qcChildInput.Id = null ;
                                System.debug( qcChildInput );
                            }
                            
                            SaveDataWrap sdWrap = new SaveDataWrap();
                            sdWrap.qcComp = childComp;
                            sdWrap.inputParam = childInputparamList;

                            List<QC_Test_Data__c> childTestDataList = saveDt.testData ;
                            if( childTestDataList != null)
                            {
                                for( QC_Test_Data__c qcChildTest : childTestDataList )
                                {
                                    qcChildTest.Component_Name__c = childComp.Id;
                                    qcChildTest.Id = null ;
                                    System.debug( qcChildTest );
                                }
                                sdWrap.testData = childTestDataList;
                                childAllQcTestDataList.addAll( childTestDataList );
                            }
                            
                            sdWrapList.add( sdWrap );
                            
                            childAllQcInputParmList.addAll( childInputparamList );
                            
                        }
                        
                        if( childAllQcInputParmList.size() > 0 )
                        {
                            insert childAllQcInputParmList;
                            returnsaveGrpRec.childsDetail.addAll( sdWrapList );
                            
                        }

                        if( childAllQcTestDataList.size() > 0 )
                        {
                            insert childAllQcTestDataList;
                            returnsaveGrpRec.childsDetail.addAll( sdWrapList );
                            
                        }
                    }
                    system.debug('ParantId -> '+ returnsaveGrpRec.parentDetail.qcComp.Id );
                return getQcComponentPack(returnsaveGrpRec.parentDetail.qcComp.Id);
            }
            return null ;
        } catch (Exception e) {
            System.debug('test1' + e.getCause());
            System.debug('test1' + e.getLineNumber());
            System.debug('test1' + e.getStackTraceString());
            throw new AuraHandledException(e.getMessage());
            
        }
    }

    public class SaveDataGroupWrap{
         public SaveDataGroupWrap()
        {
            parentDetail = new SaveDataWrap();
            childsDetail =new List<SaveDataWrap>();
        }
        public SaveDataWrap parentDetail;
        public List<SaveDataWrap> childsDetail ;
      
    }

    public class SaveDataWrap{
        public QC_Components__c qcComp;
        public List<QC_Input_Data__c> inputParam;
        public List<QC_Test_Data__c> testData;
        public SaveDataWrap()
        {
            qcComp = new QC_Components__c();
            inputParam = new List<QC_Input_Data__c>();
            testData = new List<QC_Test_Data__c>();
        }
    }

    // saveNewWatchComponent method is used for creating the indivisual Component
    @AuraEnabled
    public static String saveNewWatchComponent( String newWatchComponentData ){
         try {
            System.debug('newWatchComponentData' + newWatchComponentData);
            if( newWatchComponentData != null )
            {
                SaveDataGroupWrap saveGrpRec = (SaveDataGroupWrap) JSON.deserialize(newWatchComponentData, SaveDataGroupWrap.class);
                SaveDataGroupWrap returnsaveGrpRec = new SaveDataGroupWrap();
                QC_Components__c parentComp = saveGrpRec.parentDetail.qcComp ;
                parentComp.Component_Status__c = 'Active';
                parentComp.Document_Status__c = 'Draft' ;
                
                insert parentComp;
                returnsaveGrpRec.parentDetail.qcComp = parentComp ;

                List<QC_Input_Data__c> qcInputDataList = saveGrpRec.parentDetail.inputParam;
                for( QC_Input_Data__c qcInput : qcInputDataList )
                {
                    qcInput.Component_No__c = parentComp.Id;
                    qcInput.Id = null;
                    System.debug( qcInput );
                }


                if( qcInputDataList.size() > 0 )
                {
                    insert qcInputDataList;
                    returnsaveGrpRec.parentDetail.inputParam = qcInputDataList;
                }


                List<QC_Test_Data__c> qcTestDataList = saveGrpRec.parentDetail.testData;
                System.debug('qcTestDataList' + qcTestDataList);
                if( qcTestDataList != null )
                {
                    for( QC_Test_Data__c qcTest : qcTestDataList )
                    {
                        qcTest.Component_Name__c = parentComp.Id;
                        qcTest.Id = null;
                        System.debug( qcTest );
                    }
                    
                    
                    if( qcTestDataList.size() > 0 )
                    {
                        insert qcTestDataList;
                        System.debug('Name-> '+ parentComp.Name);
                        returnsaveGrpRec.parentDetail.testData = qcTestDataList;
                    }
                         
                }
                   
                System.debug(saveGrpRec.parentDetail.qcComp.Id);
                return getQcComponentPack(saveGrpRec.parentDetail.qcComp.Id);
            }
            return null;
         } catch (Exception e) {  
             System.debug('test1' + e.getCause());
            System.debug('test1' + e.getLineNumber());
            System.debug('test1' + e.getStackTraceString());
             throw new AuraHandledException(e.getMessage());
         }
    }

        
    // saveResubmissionRecMetod is used for Creating Resubmission component
    @AuraEnabled
    public static String saveResubmissionRecMetod( String resubRecStr, String parentRecstring ){
        try {
            QC_Components__c parentRec = (QC_Components__c) JSON.deserialize(parentRecstring, QC_Components__c.class);
            System.debug('parentRec -> '+ parentRec);
            if(parentRec.Id != null )
            {
                // if (Schema.sObjectType.QC_Components__c.fields.Name.isUpdateable()) {
                //     return null;
                // }
                update parentRec;

                SaveDataGroupWrap saveGrpRec = (SaveDataGroupWrap) JSON.deserialize(resubRecStr, SaveDataGroupWrap.class);
                SaveDataGroupWrap returnsaveGrpRec = new SaveDataGroupWrap();
                QC_Components__c parentComp = saveGrpRec.parentDetail.qcComp ;
                System.debug('resubparentRec -> '+ parentComp);
                parentComp.Component_Status__c = 'Active';
                parentComp.Document_Status__c = 'Draft' ;
                insert parentComp;
                returnsaveGrpRec.parentDetail.qcComp = parentComp ;

                    List<QC_Input_Data__c> qcInputDataList = saveGrpRec.parentDetail.inputParam;
                    for( QC_Input_Data__c qcInput : qcInputDataList )
                    {
                        qcInput.Component_No__c = parentComp.Id;
                        qcInput.Id = null;
                        System.debug( qcInput );
                    }


                    if( qcInputDataList.size() > 0 )
                    {
                        insert qcInputDataList;
                        System.debug('Name-> '+ parentComp.Name);
                        returnsaveGrpRec.parentDetail.inputParam = qcInputDataList;
                    }


                    List<QC_Test_Data__c> qcTestDataList = saveGrpRec.parentDetail.testData;
                    if( qcTestDataList != null )
                    {
                        for( QC_Test_Data__c qcTest : qcTestDataList )
                        {
                            qcTest.Component_Name__c = parentComp.Id;
                            qcTest.Id = null;
                            System.debug( qcTest );
                        }
                        
                        
                        if( qcTestDataList.size() > 0 )
                        {
                            insert qcTestDataList;
                            System.debug('Name-> '+ parentComp.Name);
                            returnsaveGrpRec.parentDetail.testData = qcTestDataList;
                        }
                    }
                    
                    List<QC_Components__c> childQcCompList = new List<QC_Components__c>();
                    List<QC_Input_Data__c> childAllQcInputParmList = new List<QC_Input_Data__c>();
                    List<QC_Test_Data__c> childAllQcTestDataList = new List<QC_Test_Data__c>();
                
                    
                    for( SaveDataWrap saveDt : saveGrpRec.childsDetail )
                    {
                        QC_Components__c childComp = new QC_Components__c(); 
                        childComp = saveDt.qcComp ;
                        childComp.Parent__c = parentComp.Id;
                        childComp.Component_Status__c = 'Active';
                        childComp.Document_Status__c = 'Draft' ;
                        childQcCompList.add( childComp );
                    }
                
                    
                    if( childQcCompList.size() > 0 )
                    {
                        insert childQcCompList;
                        
                        List<SaveDataWrap> sdWrapList = new List<SaveDataWrap>();
                        for( SaveDataWrap saveDt : saveGrpRec.childsDetail )
                        {
                            QC_Components__c childComp = new QC_Components__c(); 
                            childComp = saveDt.qcComp ;
                            List<QC_Input_Data__c> childInputparamList = saveDt.inputParam ;
                            for( QC_Input_Data__c qcChildInput : childInputparamList )
                            {
                                qcChildInput.Component_No__c = childComp.Id;
                                qcChildInput.Id = null ;
                                System.debug( qcChildInput );
                            }
                            
                            SaveDataWrap sdWrap = new SaveDataWrap();
                            sdWrap.qcComp = childComp;
                            sdWrap.inputParam = childInputparamList;

                            List<QC_Test_Data__c> childTestDataList = saveDt.testData ;
                            if( childTestDataList != null )
                            {
                                for( QC_Test_Data__c qcChildTest : childTestDataList )
                                {
                                    qcChildTest.Component_Name__c = childComp.Id;
                                    qcChildTest.Id = null ;
                                    System.debug( qcChildTest );
                                }

                                sdWrap.testData = childTestDataList;
                                childAllQcTestDataList.addAll( childTestDataList );
                            }
                            

                            
                            sdWrapList.add( sdWrap );
                            
                            childAllQcInputParmList.addAll( childInputparamList );
                            
                        }
                        
                        if( childAllQcInputParmList.size() > 0 )
                        {
                            insert childAllQcInputParmList;
                            returnsaveGrpRec.childsDetail =  sdWrapList ;
                            
                        }

                        if( childAllQcTestDataList.size() > 0 )
                        {
                            insert childAllQcTestDataList;
                            returnsaveGrpRec.childsDetail = sdWrapList ;
                            
                        }
                    }
                    system.debug('ParantId -> '+ returnsaveGrpRec.parentDetail.qcComp.Id );
                return getQcComponentPack(returnsaveGrpRec.parentDetail.qcComp.Id);
            }
            return null;
        } catch (Exception e) {
            system.debug(e.getStackTraceString());
                system.debug(e.getLineNumber());
                system.debug(e.getStackTraceString());
                system.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    //fetchInputData method us used for fetchinf the Input parameter data from Qc input data for perticular component
    @AuraEnabled
    public static string fetchInputData(String qcCompId ){  
        try {
            System.debug( qcCompId );
            if( qcCompId != null )
            {
                List<sObject> inputParamList = [SELECT Id, comments__c, Name, Question__c, Question__r.Question__c, Question__r.Type__c,Question__r.Response_Required__c,Component_No__c,Component_No__r.name__c,Question_Name__c,Response_Id__c,Value__c,Multiple_Response_Ids__c,Question__r.Question_Unique_No__c,Question__r.Order_Number__c,isManual__c FROM QC_Input_Data__c where Component_No__c =: qcCompId Order By Question__r.Question__c,isManual__c ASC ];
                return JSON.serialize( inputParamList );
            }
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //saveInputParamMethod is used for save the input parameter data in Qc Input Data
    @AuraEnabled
    public static void saveInputParamMethod( String inputParamList ){
        try {
            InputDataWrap ipmList = (InputDataWrap)  JSON.deserialize( inputParamList , InputDataWrap.class);
            if( ipmList.inputDataList.size()  > 0)
                upsert( ipmList.inputDataList );
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class InputDataWrap{
        Public List<QC_Input_Data__c> inputDataList;
    }

    //deleteInputDataMethod is used to delete the input parameter row from Qc Input Data
   @AuraEnabled
    public static void deleteInputDataMethod( String inputDataRecstr ){
        try {

            QC_Input_Data__c inputParamRec = (QC_Input_Data__c) JSON.deserialize(inputDataRecstr, QC_Input_Data__c.class);
            if( inputParamRec.Id != null)
            {
                delete inputParamRec;
            }
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
                QcCompInfoWrap qcList = (QcCompInfoWrap)  JSON.deserialize( qcCompInfoListStr , QcCompInfoWrap.class);
                if( qcList.qcCompList.size()  > 0)
                    update( qcList.qcCompList );
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class QcCompInfoWrap{
        Public List<QC_Components__c> qcCompList;
    }
    
    //getQcComponentPack method is for fetching the all parent , child and all its input parameter data
    @AuraEnabled
    public static String getQcComponentPack( String recId ){
        try {
            if(recId != null )
            {
                QC_Components__c qcWatchComp = [ SELECT Id ,Name , Name__c, Parent__c,Vendor__c,PSY_Reference__c,Model__c,Report_Ref_Number__c,
                Component_Status__c, Watch_variant__c,Brand__c,Brands__c , Document_Status__c, No_Of_Sample_Received__c, Test_Back_Ground__c,
                Sample_Date__c, Sample_Category__c, Sample_Department__c, Master_Variant__c, Sample_Received_From__c, Cluster__c, Additional_email_address__c,imageurl__c,imageurl2__c,imageurl3__c,
                Master__c, SKU_Reference__c, General_Observation__c ,Test_generated__c,IsCopied_From_Master__c,Final_Verdict__c,Parent_Report_Reference_Number__c,
                (  SELECT Id ,Name , Name__c, Parent__c,Vendor__c,PSY_Reference__c,Model__c,Report_Ref_Number__c,IsCopied_From_Master__c,Parent_Report_Reference_Number__c,
                Component_Status__c, Watch_variant__c,Brand__c,Brands__c , Document_Status__c, No_Of_Sample_Received__c, Test_Back_Ground__c,Final_Verdict__c,
                Sample_Date__c, Sample_Category__c, Sample_Department__c, Master_Variant__c, Sample_Received_From__c, Cluster__c, Additional_email_address__c,imageurl__c,imageurl2__c,imageurl3__c,
                Master__c, SKU_Reference__c, General_Observation__c,Test_generated__c FROM Component__r   )
                 FROM QC_Components__c where Id = : recId Limit 1] ;
                 
                List<QC_Components__c> qcCompList = new List<QC_Components__c>();
                qcCompList.add(  qcWatchComp  );
                qcCompList.addAll(  qcWatchComp.Component__r );
                Set<Id> sQcCompId = new Set<Id>();
                sQcCompId.add( qcWatchComp.Id );
                Map<Id,QC_Components__c> mQcComp = new Map<Id,QC_Components__c>();
                mQcComp.put( qcWatchComp.Id , qcWatchComp );
                for( QC_Components__c qcChildComp : qcWatchComp.Component__r )
                {
                    sQcCompId.add( qcChildComp.Id );
                    if( !mQcComp.containsKey( qcChildComp.Id ))
                    {
                        mQcComp.put( qcChildComp.Id , qcChildComp );
                    }
                }

                Map<Id,List<QC_Input_Data__c>> mQcInputData = new Map<Id,List<QC_Input_Data__c>>();
                List<QC_Input_Data__c> qcInputList = new List<QC_Input_Data__c>();
                for(QC_Input_Data__c qcInput : [SELECT Id,comments__c,Name,Question__c,Question_Name__c,Question__r.Question__c,Question__r.Type__c,Question__r.Question_Unique_No__c,Question__r.Response_Required__c,Component_No__c,Component_No__r.Parent__c,Component_No__r.name__c,Response_Id__c,Value__c,Multiple_Response_Ids__c FROM QC_Input_Data__c where Component_No__c =: sQcCompId ])
                {
                    if( mQcInputData.containsKey( qcInput.Component_No__c ))
                    {
                        mQcInputData.get( qcInput.Component_No__c ).add( qcInput );
                    }
                    else{
                        mQcInputData.put( qcInput.Component_No__c , new List<QC_Input_Data__c>{ qcInput } );
                    }
                    qcInputList.add( qcInput );
                }
                
                Map<Id,List<QC_Test_Data__c>> mQcTestData = new Map<Id,List<QC_Test_Data__c>>();
                List<QC_Test_Data__c> qcTestList = new List<QC_Test_Data__c>();
                for(QC_Test_Data__c qcTest : [SELECT Id, RecordTypeId,RecordType.Name, CreatedDate, Component_Name__c,Component_Name__r.Name__c,Condition_Ref__r.question__c, Condition_Ref__r.Question_Name__c, After_Test1__c, After_Test2__c, After_Test3__c, After_Test4__c, After_Test5__c, After_Test_Observation__c, Conclusion__c, Condition_Ref__c, Initial1__c, Initial2__c, Initial4__c, Initial5__c, Initial_Test_Observation__c, Observation2__c, Observation3__c, Observation4__c, Observation5__c, Observation__c, Comments_and_Remarks__c, Determined_value__c, Specification_Input__c, UOM_Input__c, Acceptance_Criteria__c, IsLast__c, Parent__c, RandomNumber__c, Test_Name__c, isManual__c, isParent__c, No_of_Samples__c,Active__c,imageurl__c FROM QC_Test_Data__c where Component_Name__c = :sQcCompId and Active__c = true ])
                {
                    if( mQcTestData.containsKey( qcTest.Component_Name__c ))
                    {
                        mQcTestData.get( qcTest.Component_Name__c ).add( qcTest );
                    }
                    else{
                        mQcTestData.put( qcTest.Component_Name__c , new List<QC_Test_Data__c>{ qcTest } );
                    }
                    qcTestList.add( qcTest );
                }
                SaveDataGroupWrap saveData = new SaveDataGroupWrap();
           
                for( Id qcCompId : mQcComp.keyset() )
                {
                    SaveDataWrap sdWrap ;
                    if(mQcComp.containsKey(qcCompId)){
                        if( mQcComp.get(qcCompId).Parent__c == null )
                        {
                            sdWrap = new SaveDataWrap();
                            sdWrap.qcComp = mQcComp.get(qcCompId) ;
                            sdWrap.inputParam = mQcInputData.get( qcCompId );
                            sdWrap.testData = mQcTestData.get( qcCompId );
                            saveData.parentDetail = sdWrap;
                        }
                        else{
                            sdWrap = new SaveDataWrap();
                            sdWrap.qcComp = mQcComp.get(qcCompId) ;
                            sdWrap.inputParam = mQcInputData.get( qcCompId );
                            sdWrap.testData = mQcTestData.get( qcCompId );
                            saveData.childsDetail.add(sdWrap);
                        }
                    }
					
                }                
                return JSON.serialize( saveData );
            } 
            return null;

        } catch (Exception e) {
            System.debug('Exception-> ' + e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public Static ApprovalList submitForAppProcess(String RecId){
        //Id ProId=userinfo.getProfileId();
       // String Pname=[Select Name FROM Profile where Id=:ProId][0].Name;
       // System.debug('Pname -> ' + Pname);
        //if(Pname=='System Administrator'){
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        //Passing record id 
        System.debug('RecId==>'+RecId);
        req.setObjectId(RecId);        
        Approval.ProcessResult result = Approval.process(req);
        string approvalResult = result.getInstanceStatus();
        return getApprovalData(RecId);
        //}
       //return null;
    }

   @AuraEnabled  
   public static ApprovalList getApprovalData(Id recId)  
   {  
       System.debug('::::recId::: '+recId);
     Id recordId = recId;  
     ApprovalList approvalResultForObject = new ApprovalList();  
     List<ApprovalStepWrapper> aSW = new List<ApprovalStepWrapper>();  
     String recallApprovalProcessLink;  
     Boolean isSubmitForApproval = true;  
     for(ProcessInstance pI: getProcessHistory(recordId).values())  
     {  
       Map<Id,List<ProcessInstanceHistory>> mapOfProcessNodeIdAndProcessInstanceHistory = new Map<Id,List<ProcessInstanceHistory>>();  
       Set<Id> processNodeId= new Set<Id>();  
       for(ProcessInstanceHistory sWI:pI.StepsAndWorkitems)  
       {  
         if(processNodeId.size() ==0)  
           processNodeId.add(sWI.ProcessNodeId);  
         else if(processNodeId.size()>0 && processNodeId.contains(sWI.ProcessNodeId)!= NULL)  
           processNodeId.add(sWI.ProcessNodeId);  
       }  
       for(Id pNId: processNodeId)  
       {  
         ApprovalStepWrapper aSWr = new ApprovalStepWrapper();  
         for(ProcessInstanceHistory sWI:pI.StepsAndWorkitems)  
         {  
           if(sWI.processNodeId == pNID)  
           {  
             aSWr.listOfSteps.add(new ApprovalHistoryWrap(sWI.CreatedDate, sWI.OriginalActor.Name, sWI.StepStatus,sWI.Actor.Name));  
           }  
           if(sWI.StepStatus == 'Pending')  
           {  
             isSubmitForApproval = false;  
           }  
         }  
         aSW.add(aSWr);  
       }  
     }  
     approvalResultForObject.approvals = aSW;  
     approvalResultForObject.recordId = recordId;  
     approvalResultForObject.isSubmitForApproval = isSubmitForApproval;  
     system.debug('asw'+aSW);  
     return approvalResultForObject;  
   }  
  
   // * This method queries the processinstance and workitem for the record  
   // * Parameter: Record ID   
   // * Returns: Map of all processinstance related to the record id  
     
   @AuraEnabled  
   public static Map<Id,ProcessInstance> getProcessHistory(Id objectId)  
   {  
       System.debug('::::objectId ::: '+objectId);
     return new Map<Id,ProcessInstance>([SELECT Id, (SELECT ID, ProcessNodeId,  
                             StepStatus,Comments,TargetObjectId,ActorId,CreatedById,IsDeleted,IsPending  
                             ,OriginalActorId,ProcessInstanceId,RemindersSent,CreatedDate, Actor.Name,  
                             OriginalActor.Name , ProcessNode.Name FROM StepsAndWorkitems order by CreatedDate DESC )   
                       FROM ProcessInstance where TargetObjectId =:objectId order by CreatedDate DESC]);  
   }  
   
   // Wrapper class  
     
   public class ApprovalStepWrapper{  
     @AuraEnabled  
     public List<ApprovalHistoryWrap> listOfSteps {get;set;}  
     public ApprovalStepWrapper(){  
       listOfSteps = new List<ApprovalHistoryWrap>();  
     }  
   }  
          
    // Wrapper class  
   
   public class ApprovalHistoryWrap  
   {  
     @AuraEnabled  
     public Date createdDate {get;set;}  
     @AuraEnabled  
     public string actorName {get;set;}  
     @AuraEnabled  
     public string steps {get;set;}  
     @AuraEnabled  
     public string assignedTo {get;set;}  
     public ApprovalHistoryWrap(DateTime crDate, string name, string stp, string actor)  
     {  
       createdDate = crDate.date();  
       actorName = name;  
       steps = stp;  
       assignedTo = actor;  
     }  
   }  
     
    // Wrapper class  
     
   public class ApprovalList  
   {   
     @AuraEnabled  
     public List<ApprovalStepWrapper> approvals {get;set;}  
     @AuraEnabled    
     public Boolean isSubmitForApproval {get;set;}  
     @AuraEnabled  
     public Id recordId {get;set;}  
     public ApprovalList(){  
       approvals = new List<ApprovalStepWrapper>();  
       isSubmitForApproval = true;  
     }  
   } 

   @AuraEnabled
    public static boolean isRecordSubmitForApproval(Id recordId){
       // boolean val= Approval.LockResult(recordId);
        boolean returnval=Approval.isLocked(recordId);
        return returnval;
    }

    @AuraEnabled
    public static string fetchRejectedTest(string rec){
        try {
            if(rec != null){
                QC_Components__c qcComp = (QC_Components__c) JSON.deserialize( rec , QC_Components__c.class );

                if( qcComp.Parent__c == null)
                {
                    List<QC_Test_Data__c> testDataList = [SELECT Id, RecordTypeId,RecordType.Name, CreatedDate, Component_Name__c,Component_Name__r.Name__c,Component_Name__r.Report_Ref_Number__c,Condition_Ref__r.question__c, Condition_Ref__r.Question_Name__c, After_Test1__c, After_Test2__c, After_Test3__c, After_Test4__c, After_Test5__c, After_Test_Observation__c, Conclusion__c, Condition_Ref__c, Initial1__c, Initial2__c, Initial4__c, Initial5__c, Initial_Test_Observation__c, Observation2__c, Observation3__c, Observation4__c, Observation5__c, Observation__c, Comments_and_Remarks__c, Determined_value__c, Specification_Input__c, UOM_Input__c, Acceptance_Criteria__c, IsLast__c, Parent__c, RandomNumber__c, Test_Name__c, isManual__c, isParent__c, No_of_Samples__c,Active__c,imageurl__c FROM QC_Test_Data__c where Component_Name__r.Report_Ref_Number__c = :qcComp.Parent_Report_Reference_Number__c and Active__c = true and Conclusion__c = 'Reject'];
                    return JSON.serialize(testDataList);
                }else{
                    QC_Components__c parent = [ SELECT Id,Parent__r.Parent_Report_Reference_Number__c FROM QC_Components__c where Id =: qcComp.Id  ];
                    QC_Components__c child  = [ SELECT Id, Name, Name__c, Parent__c,Report_Ref_Number__c, Parent_Report_Reference_Number__c,Parent__r.Report_Ref_Number__c FROM QC_Components__c where Name__c =: qcComp.Name__c and Parent__r.Report_Ref_Number__c =: parent.parent__r.Parent_Report_Reference_Number__c  LIMIT 1 ];
                    System.debug( '-parent-'+ parent);
                    System.debug( '-child-'+ child);
                    List<QC_Test_Data__c> testDataList = [SELECT Id, RecordTypeId,RecordType.Name, CreatedDate, Component_Name__c,Component_Name__r.Name__c,Component_Name__r.Report_Ref_Number__c,Condition_Ref__r.question__c, Condition_Ref__r.Question_Name__c, After_Test1__c, After_Test2__c, After_Test3__c, After_Test4__c, After_Test5__c, After_Test_Observation__c, Conclusion__c, Condition_Ref__c, Initial1__c, Initial2__c, Initial4__c, Initial5__c, Initial_Test_Observation__c, Observation2__c, Observation3__c, Observation4__c, Observation5__c, Observation__c, Comments_and_Remarks__c, Determined_value__c, Specification_Input__c, UOM_Input__c, Acceptance_Criteria__c, IsLast__c, Parent__c, RandomNumber__c, Test_Name__c, isManual__c, isParent__c, No_of_Samples__c,Active__c,imageurl__c FROM QC_Test_Data__c where Component_Name__c = :child.Id and Active__c = true and Conclusion__c = 'Reject'];
                    return JSON.serialize(testDataList);
                }
                 
            }
            return null;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
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
    public static String fetchAllChildCompInputParam( List<String> allQcCompIdList ){
        try {
            if(! allQcCompIdList.isEmpty())
            {
                System.System.debug('test'+ allQcCompIdList);
                Map<Id ,String> mapOfChildCompInputParam = new Map<Id, String>();
                for( String qcCompId : allQcCompIdList )
                {
                    mapOfChildCompInputParam.put( qcCompId , fetchInputData(qcCompId));
                }
                if(! mapOfChildCompInputParam.isEmpty())
                {
                    return JSON.serialize( mapOfChildCompInputParam );
                }
            }
            return null ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void saveIndividualQcComp( String qcComp){
        try {
            if( qcComp != null)
            {
                QC_Components__c qcComponent = (QC_Components__c) JSON.deserialize(qcComp,QC_Components__c.class);
                if( qcComponent.Id != null)
                    update qcComponent;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
}