@isTest
public class QcInputComponentClassTest {
     @IsTest
    private static void testAsync() {
        QcInputComponentClass asyncTest = new QcInputComponentClass();
    }
    /*public class SaveDataWrap{
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
    
    public class SaveDataGroupWrap{
        public SaveDataGroupWrap()
        {
            parentDetail = new SaveDataWrap();
            childsDetail =new List<SaveDataWrap>();
        }
        public SaveDataWrap parentDetail;
        public List<SaveDataWrap> childsDetail ;
        
    }
    
    @isTest
    public static void testAllMethod(){
        QC_UtilitiesSupportObj testData = new QC_UtilitiesSupportObj();
        User u = testData.getAdmin();
        insert u;
        
        
        system.runAs(u){
            
            
            TriggerExecutionController__c trgExc = new TriggerExecutionController__c();
            trgExc.Name = 'Qc_Component_Lightning_Trigger';
            trgExc.TriggerIsActive__c = true ;
            insert trgExc;
            
            TriggerExecutionController__c trgExc2 = new TriggerExecutionController__c();
            trgExc2.Name = 'QC_ComponentUniqueRefTrigger';
            trgExc2.TriggerIsActive__c = false ;
            insert trgExc2;
            
            QC_Component_Prefix__c  pref = new QC_Component_Prefix__c();
            pref.Name = 'FW';
            pref.Sequence_Number__c = '0001' ;
            insert pref;
            
            QC_Component_Prefix__c  pref1 = new QC_Component_Prefix__c();
            pref1.Name = 'WH';
            pref1.Sequence_Number__c = '0001' ;
            insert pref1;
            
            QC_Component_Prefix__c  pref2 = new QC_Component_Prefix__c();
            pref2.Name = 'CA';
            pref2.Sequence_Number__c = '0001' ;
            insert pref2;
            
            QC_Condition__c qcCondition = testData.getCondition();
            insert qcCondition;
            
            QC_Components__c componentTest = testData.getqcComponent();
            insert componentTest;
            QC_Components__c componentTest1 = testData.getqcChildComponent();
            QC_Question__c questTest1 = testData.getModuleQuestion();
            QC_Question__c questTest2= testData.getCasetoStrapQuestion();
            QC_Question__c questTest3 = testData.getWatchTotalLengthinmmQuestion();
            QC_Question__c questTest4 = testData.getCrownQuestion();
            
            QC_Question__c questchildTest1 = testData.getwatchMaterialQuestion();  
            QC_Question__c questchildTest2 = testData.getConstructionQuestion();
            QC_Question__c questchildTest3 = testData.getBCFittingQuestion();
            QC_Question__c questchildTest4 = testData.getSpecialFeatureinCaseQuestion();
            QC_Question__c questchildTest5 = testData.getTypeofGlassQuestion();
            QC_Question__c questchildTest6 = testData.getGlassProfileQuestion();
            QC_Question__c questchildTest7 = testData.getGlassFittingQuestion();
            QC_Question__c questchildTest8 = testData.getProvisionForSpacerAssemblyQuestion();
            QC_Question__c questchildTest9 = testData.getPushbuttonQuestion();
            LIST<QC_Question__c> ListOfCaseQuestion = new LIST<QC_Question__c>();
            ListOfCaseQuestion.add(questchildTest1);
            ListOfCaseQuestion.add(questchildTest2);
            ListOfCaseQuestion.add(questchildTest3);
            ListOfCaseQuestion.add(questchildTest4);
            ListOfCaseQuestion.add(questchildTest5);
            ListOfCaseQuestion.add(questchildTest6);
            ListOfCaseQuestion.add(questchildTest7);
            ListOfCaseQuestion.add(questchildTest8);
            ListOfCaseQuestion.add(questchildTest9);
            ListOfCaseQuestion.add(questTest1);
            ListOfCaseQuestion.add(questTest2);
            ListOfCaseQuestion.add(questTest3);
            ListOfCaseQuestion.add(questTest4);
            insert ListOfCaseQuestion;
            
            //   QC_Input_Data__c inputTestData = testData.getInputData();
            String allRecordDetails = QcInputComponentClass.fetchallMasterData();
            String picklistMap = '[{"ObjectName":"QC_Components__c","picklistFieldName":"Final_Verdict__c","attributName":"finalVerdictList"}]';
            QcInputComponentClass.getPickListValue(picklistMap);
            QcInputComponentClass.getBrandName(componentTest.Brand__c);
            string obj= '{"attributes":{"type":"QC_Components__c","url":"/services/data/v53.0/sobjects/QC_Components__c/a1E1k000001gSQYEA2"},"Id":"a1E1k000001gSQYEA2","OwnerId":"00530000003Nll9AAC","IsDeleted":false,"Name":"Record No-54873","CurrencyIsoCode":"INR","CreatedDate":"2021-09-28T10:31:06.000+0000","CreatedById":"00530000003Nll9AAC","LastModifiedDate":"2021-09-28T10:31:06.000+0000","LastModifiedById":"00530000003Nll9AAC","SystemModstamp":"2021-09-28T10:31:06.000+0000","LastActivityDate":null,"LastViewedDate":"2021-09-28T10:31:06.000+0000","LastReferencedDate":"2021-09-28T10:31:06.000+0000","Brand__c":"a1H1k000001hGQLEA2","Brands__c":"Fastrack","Component_Status__c":"Active","Document_Status__c":"Draft","Final_Verdict__c":null,"Master_Variant__c":null,"Master__c":true,"Model__c":null,"Name__c":"Full-Watch","No_Of_Sample_Received__c":null,"PSY_Reference__c":null,"Parent__c":null,"Report_Ref_Number__c":null,"SKU_Reference__c":null,"Sample_Category__c":"New","Sample_Date__c":"2021-09-30","Sample_Department__c":"Customer Assurance(CA)","Test_Back_Ground__c":null,"Unique_Number__c":"54874","Vendor__c":"a1H1k000001hGPPEA2","Watch_variant__c":null,"Tests_Rejected__c":0,"Exception_Verdict__c":null,"IsCopied_From_Master__c":false,"IsCopied_From_ReSub__c":false,"Comment__c":null,"ChildComponentName__c":null,"General_Observation__c":null,"Is_Rejected__c":false,"Published_Date__c":null,"isTestDataCreated__c":false,"Parent_Report_Reference_Number__c":null,"WIP_Lead_time__c":-2,"Lead_Time__c":null,"Target_Lead_Time__c":5,"Time_Difference_btw_LT_TL__c":0,"approval_submitted_date__c":null,"Approval_Lead_time__c":0,"Number_of_Sunday__c":null,"Actual_lead_time__c":0,"Target_LT__c":6,"Achieved__c":100,"Sample_Received_From__c":"prabhat.p@vpcorp.com","imageurl__c":null,"imageurl2__c":null,"imageurl3__c":null,"Price__c":null,"isInputDataCreated__c":false,"Additional_email_address__c":null,"First_Rejected_Date__c":null,"First_Approval_Date__c":null,"Email_Sample_Received_From_1__c":null,"Email_Sample_Received_From_2__c":null,"Email_Sample_Received_From_3__c":null,"Number_of_holidays__c":null,"Test_update__c":null,"No_of_Holidays_Inspection__c":null,"No_of_Sunday_Inspection__c":null,"Cluster__c":"FASTR","Parent_Sample_Received_From_Email__c":null,"Test_generated__c":false,"Record_No__c":"Record No-54873"}';       
            QcInputComponentClass.fetchDependentPicklist(obj,'Brands__c','Cluster__c');
            QcInputComponentClass.fetchallMasterData();
            string str = '{"parentDetail":{"qcComp":{"sobjectType":"QC_Components__c","Master__c":true,"Name__c":"Full-Watch","Sample_Category__c":"New","Sample_Date__c":"'+String.valueOf(Date.newInstance(2021,09,30))+'","Vendor__c":"'+componentTest.Vendor__c+'","Brand__c":"'+componentTest.Brand__c+'","Brands__c":"'+componentTest.Brands__c+'","Sample_Department__c":"Assembly","Cluster__c":"FASTR","Master_Variant__c":"","Sample_Received_From__c":"prabhat.p@vpcorp.com"},"inputParam":[{"Component_No__c":"","Question__c":"'+questTest1.Id+'","Question_Name__c":"'+questTest1.Question__c+'"},{"Component_No__c":"","Question__c":"'+questTest2.Id+'","Question_Name__c":"'+questTest2.Question__c+'"},{"Component_No__c":"","Question__c":"'+questTest3.Id+'","Question_Name__c":"'+questTest3.Question__c+'"},{"Component_No__c":"","Question__c":"'+questTest4.Id+'","Question_Name__c":"'+questTest4.Question__c+'"}],"testData":[{"Id":null,"RecordTypeId":"01214000001RWq6AAG","Condition_Ref__c":"'+qcCondition.id+'","Conclusion__c":"Accept","Observation__c":"test","Comments_and_Remarks__c":"test","Specification_Input__c":"3 Kgf * 2.21m/s","UOM_Input__c":"Mass * Velocity","Test_Name__c":"IZOD Impact","isManual__c":false,"isParent__c":false,"Active__c":true}]},"childsDetail":[{"qcComp":{"sobjectType":"QC_Components__c","Master__c":true,"Name__c":"Case","Sample_Category__c":"New","Sample_Date__c":"2021-09-30","Vendor__c":"'+componentTest.Vendor__c+'","Brand__c":"'+componentTest.Brand__c+'","Brands__c":"Fastrack","Sample_Department__c":"Assembly","Cluster__c":"FASTR","Master_Variant__c":"","Sample_Received_From__c":"prabhat.p@vpcorp.com"},"inputParam":[{"Component_No__c":"","Question__c":"'+questchildTest1.Id+'","Question_Name__c":"'+questchildTest1.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest2.Id+'","Question_Name__c":"'+questchildTest2.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest3.Id+'","Question_Name__c":"'+questchildTest3.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest4.Id+'","Question_Name__c":"'+questchildTest4.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest5.Id+'","Question_Name__c":"'+questchildTest5.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest6.Id+'","Question_Name__c":"'+questchildTest6.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest7.Id+'","Question_Name__c":"'+questchildTest7.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest8.Id+'","Question_Name__c":"'+questchildTest8.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest9.Id+'","Question_Name__c":"'+questchildTest9.Question__c+'"}],"testData":[{"Id":null,"RecordTypeId":"01214000001RWq6AAG","Condition_Ref__c":"'+qcCondition.id+'","Conclusion__c":"Accept","Observation__c":"test","Comments_and_Remarks__c":"test","Specification_Input__c":"3 Kgf * 2.21m/s","UOM_Input__c":"Mass * Velocity","Test_Name__c":"IZOD Impact","isManual__c":false,"isParent__c":false,"Active__c":true}]}]}';
            String returnSavedData = QcInputComponentClass.saveNewFWOrWHComponent(str);
            SaveDataGroupWrap saveGrpRec = (SaveDataGroupWrap) JSON.deserialize(returnSavedData, SaveDataGroupWrap.class);
            
            QcInputComponentClass.getMasterVarient(componentTest.id);
            QcInputComponentClass.getMasterVarient(componentTest.Name);
            QcInputComponentClass.fetchInputData(componentTest.id);
            string str1= '{"parentDetail":{"qcComp":{"sobjectType":"QC_Components__c","Master__c":false,"Name__c":"Case","Sample_Category__c":"New"},"inputParam":[{"Component_No__c":"","Question__c":"'+questchildTest1.Id+'","Question_Name__c":"'+questchildTest1.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest2.Id+'","Question_Name__c":"'+questchildTest2.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest3.Id+'","Question_Name__c":"'+questchildTest3.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest4.Id+'","Question_Name__c":"'+questchildTest4.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest5.Id+'","Question_Name__c":"'+questchildTest5.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest6.Id+'","Question_Name__c":"'+questchildTest6.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest7.Id+'","Question_Name__c":"'+questchildTest7.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest8.Id+'","Question_Name__c":"'+questchildTest8.Question__c+'"},{"Component_No__c":"","Question__c":"'+questchildTest9.Id+'","Question_Name__c":"'+questchildTest9.Question__c+'"}],"testData":[{"Id":null,"RecordTypeId":"01214000001RWq6AAG","Condition_Ref__c":"'+qcCondition.id+'","Conclusion__c":"Accept","Observation__c":"test","Comments_and_Remarks__c":"test","Specification_Input__c":"3 Kgf * 2.21m/s","UOM_Input__c":"Mass * Velocity","Test_Name__c":"IZOD Impact","isManual__c":false,"isParent__c":false,"Active__c":true}]},"childsDetail":[]}';
            string str12 = QcInputComponentClass.saveNewWatchComponent(str1);
              SaveDataGroupWrap saveGrpRec1 = (SaveDataGroupWrap) JSON.deserialize(str12, SaveDataGroupWrap.class);
             QC_Components__c parentComp2 = saveGrpRec1.parentDetail.qcComp ;
            QC_Components__c parentComp1 = saveGrpRec.parentDetail.qcComp ;
            QC_Components__c ChildComp = saveGrpRec.childsDetail[0].qcComp;
            QcInputComponentClass.getQcComponentPack(parentComp1.id);
            QcInputComponentClass.submitForAppProcess(parentComp1.id);
            List<QC_Components__c> listComponent = new List<QC_Components__c>();
            listComponent.add(saveGrpRec.parentDetail.qcComp);
        //  QcInputComponentClass.saveChildQcCompMethod(String.valueOf(listComponent));
            
            QcInputComponentClass.saveResubmissionRecMetod(str,JSON.serialize(saveGrpRec.parentDetail.qcComp));
            QcInputComponentClass.fetchRejectedTest(JSON.serialize(parentComp1));
            QcInputComponentClass.updatePicturePath(JSON.serialize(parentComp1));
            QcInputComponentClass.saveIndividualQcComp(JSON.serialize(parentComp2));
            QcInputComponentClass.isRecordSubmitForApproval(parentComp1.id);
            
        }
    }*/
}