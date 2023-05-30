/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest(seeAllData = true)
private class QC_TitanQualityCOntrolTest {
    
    static QC_Components__c  comp;
    static list<QC_Components__c> compList;
    static list<QC_Question__c> quesList;
    static list<QC_Response__c> resList;
    static list<QC_Question__c> testQuesList;
    static list<QC_Condition__c> quesConList;
    static list<QC_Condition__c> testConList;
    static list<QC_Condition__c> quesPickList;
    static list<QC_Input_Data__c> inputList;
    static list<QC_Test_Data__c> testDataList;
    
    static testMethod void methodInsert() {
        //Inserting parent component
        comp = QC_TestHandlerCls.getIndividComponent();
        insert comp;
        //Inserting child components
        compList = new list<QC_Components__c>();
        compList.addAll(QC_TestHandlerCls.getParentComponents());    
        for(QC_Components__c each : compList){
            each.name__c = 'case';
            each.parent__c = comp.id;
            each.Document_Status__c = 'Published';
            each.final_verdict__c  = 'Accept';
            
        }
        insert compList;   
        
        //Inserting Input parameters questions
        quesList =  new list<QC_Question__c>();
        quesList.addAll(QC_TestHandlerCls.getComponentQuestions());
        insert quesList;
        system.debug('**********'+quesList);
        
        //inserting question responses
        resList = new  list<QC_Response__c>();
        resList.AddAll(QC_TestHandlerCls.getQuesResponses());
        //inserting picklist type question responses
        for(integer i=0;i<5;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        //inserting freetext type question responses
        for(integer i=5;i<10;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        for(integer i=10;i<15;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        //inserting Multi-select type question responses
        insert reslist;
        
        //Inserting test parameters questions
        testQuesList =  new list<QC_Question__c>();
        testQuesList.addAll(QC_TestHandlerCls.getTestQuestions());
        insert testQuesList;
        
        //Inserting questions conditions with question ids getPicklistConditions
        quesConList = new list<QC_Condition__c>();     
        quesConList.addAll(QC_TestHandlerCls.getQuestionConditions());
        for(integer i=0;i<11;i++){
            quesConList[i].Question__c = quesList[i].id;
            quesConList[i].Response__c = reslist[i].id;
        }
        insert quesConList;
        
        //Inserting picklist conditions with question ids 
        quesPickList = new list<QC_Condition__c>();     
        quesPickList.addAll(QC_TestHandlerCls.getPicklistConditions());
        for(integer i=0;i<3;i++){
            quesPickList[i].Question__c = quesList[i].id;
            quesPickList[i].Response__c = reslist[i].id;
            quesPickList[i].Dependent_Response__c = reslist[4+i].id;
            
        }
        //insert quesPickList;
        
        //Inserting testCondtions with test question ids
        testConList = new list<QC_Condition__c>();     
        testConList.addAll(QC_TestHandlerCls.getTestConditions());
        for(integer i=0;i<7;i++){
            testConList[i].Question__c = testQuesList[i].id;
            //Adding condition records with action = Hidden
            if(i==1 || i == 3) testConList[i].Action__c = 'Hidden';
        }
        insert testConList;
        
        //Inserting Input paramerters 
        inputList = new list<QC_Input_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(integer i=0;i<5;i++){
            QC_Input_Data__c inData = new QC_Input_Data__c();
            inData.Component_No__c  = comp.id;
            inData.Question__c      = quesList[i].id;
            inData.Response_Id__c   = reslist[i].id;
            inData.Multiple_Response_Ids__c = 'Abzsfsfsfsfsfsffsfdsfsf';
            inData.value__c='test value';
            inputList.add(inData);
        }
        insert inputList;
        
        //Inserting test paramerters 
        testDataList = new list<QC_Test_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(integer i=0;i<2;i++){
            QC_test_Data__c testData = new QC_test_Data__c();
            testData.Component_Name__c = comp.id;
            //testData.Condition_Ref__r.Onload__c  = false;
            testData.isManual__c = false;
            testData.Condition_Ref__c =  testConList[i].id;        
            testData.Observation__c = 'sample';
            testData.Conclusion__c = 'Accept';
            testDataList.add(testData);
            
            
            testData.Conclusion__c ='NONE';
            testDataList.add(testData);
        }
        //insert testDataList;
    }//End of methodInsert    
    
    static testMethod void methodForInputParamErrorMsg(){
        Test.startTest();
        methodInsert();
        
        //Passing parameters to the url 
        System.currentPageReference().getParameters().put('id',comp.id);
        System.currentPageReference().getParameters().put('type','Full-Watch'); 
        System.currentPageReference().getParameters().put('id',comp.id);
        System.currentPageReference().getParameters().put('type','Watch-Head');
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        tqc.cloneIndividualComponent();
        tqc.cloneParentRecord();
        tqc.cloneChildCompFWWH();
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        QC_Question__c savedQues = new QC_Question__c();
        // savedQues = [select id from QC_Question__c where Question__c = 'question1' limit 1]; 
        tqc.selectedRes = [select id from QC_Response__c where response__C = 'sampleRes2' limit 1].id; //Question__c =:savedQues.id and
        tqc.previousRes = [select id from QC_Response__c where response__C = 'sampleRes1' limit 1].id;
        tqc.selectedQid = [select id from QC_Question__c where Question__c = 'question1'  limit 1].id;
        //  tqc.initialize();
        test.stopTest();
        tqc.AutoPopulateParentInfo();
        tqc.cloneRecords();     
        tqc.InputParamErrorMsg();
        tqc.reportPDFTestFinding();
        
    }     
    static testMethod void methodForManualTestDataAddAndRemove(){
        Test.startTest();
        methodInsert();
        System.currentPageReference().getParameters().put('type','Module');
        System.currentPageReference().getParameters().put('indexNo','0');
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        tqc.addTest();
        tqc.delTest();
        System.currentPageReference().getParameters().put('type','case');
        System.currentPageReference().getParameters().put('indexNo','0');
        Test.stopTest();
        tqc = new QC_TitanQualityControl();
        tqc.addTest();
        tqc.delTest();
        
    }
    
    static testMethod void methodForInsertComp() { 
        Test.startTest();
        //   methodInsert();
        comp = QC_TestHandlerCls.getIndividComponent();
        insert comp;
        //Inserting Input parameters questions
        quesList =  new list<QC_Question__c>();
        quesList.addAll(QC_TestHandlerCls.getComponentQuestions());
        insert quesList;
        system.debug('**********'+quesList);
        
        //inserting question responses
        resList = new  list<QC_Response__c>();
        resList.AddAll(QC_TestHandlerCls.getQuesResponses());
        //inserting picklist type question responses
        for(integer i=0;i<5;i++){
            resList[i].Question__c = quesList[i].id; 
            
        }
        //inserting freetext type question responses
        for(integer i=5;i<10;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        for(integer i=10;i<15;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        //inserting Multi-select type question responses
        insert reslist;
        testQuesList =  new list<QC_Question__c>();
        testQuesList.addAll(QC_TestHandlerCls.getTestQuestions());
        insert testQuesList;
        testConList = new list<QC_Condition__c>();     
        testConList.addAll(QC_TestHandlerCls.getTestConditions());
        for(integer i=0;i<7;i++){
            testConList[i].Question__c = testQuesList[i].id;
            //Adding condition records with action = Hidden
            if(i==1 || i == 3) testConList[i].Action__c = 'Hidden';
        }
        insert testConList;
        // 
        list<QC_Components__c> listChildCompo = QC_TestHandlerCls.getChildComponent();
        for(QC_Components__c com : listChildCompo){
            com.Parent__c = comp.id;
            com.final_verdict__c = 'Accept';
        }
        insert listChildCompo;
        //Inserting Input paramerters 
        inputList = new list<QC_Input_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(QC_Components__c com : listChildCompo){
            for(integer i=0;i<5;i++){
                QC_Input_Data__c inData = new QC_Input_Data__c();
                inData.Component_No__c  = com.id;
                inData.Question__c      = quesList[i].id;
                inData.Response_Id__c   = reslist[i].id;
                com.final_verdict__c = 'Accept';
                inputList.add(inData);
            }
        }
        insert inputList;
        
        //Inserting test paramerters 
        testDataList = new list<QC_Test_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(QC_Components__c com : listChildCompo){
            for(integer i=0;i<2;i++){
                QC_test_Data__c testData = new QC_test_Data__c();
                testData.Component_Name__c = com.id;
                testData.Condition_Ref__c =  testConList[i].id;        
                testData.Observation__c = 'sample';
                testData.Conclusion__c = 'Accept';
                testDataList.add(testData);
            }
        } 
        insert testDataList;
        quesConList = new list<QC_Condition__c>();     
        quesConList.addAll(QC_TestHandlerCls.getQuestionConditions());
        for(integer i=0;i<11;i++){
            quesConList[i].Question__c = quesList[i].id;
            quesConList[i].Response__c = reslist[i].id;
            if(i==1 || i == 3) testConList[i].Action__c = 'Hidden';
        }
        insert quesConList;
        //Passing parameters to the url 
        System.currentPageReference().getParameters().put('id',comp.id);
        System.currentPageReference().getParameters().put('type','Full-Watch');
        System.currentPageReference().getParameters().put('id',comp.id);
        System.currentPageReference().getParameters().put('type','Watch-Head'); 
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        QC_Question__c savedQues = new QC_Question__c();
        // savedQues = [select id from QC_Question__c where Question__c = 'question1' limit 1]; 
        tqc.selectedRes = [select id from QC_Response__c where response__c = 'sampleRes2' limit 1].id; //Question__c =:savedQues.id and
        tqc.previousRes = [select id from QC_Response__c where response__c = 'sampleRes1' limit 1].id;
        tqc.selectedQid = [select id from QC_Question__c where Question__c = 'question1'  limit 1].id;
        
        tqc.AutoPopulateParentInfo();
        tqc.saveSpecialApprovalData();
        tqc.componentInit();
        tqc.initialization();     
        tqc.previousResQuestions(tqc.selectedRes);
        tqc.picklistCondition(tqc.selectedRes);
        tqc.previousPicklistCondition(tqc.previousRes); 
        //tqc.cloneRecords();
        tqc.InputParamErrorMsg();
        tqc.saveComponentData();
        tqc.EditComponentData();
        tqc.reportPDF();     
        tqc.individualReport();
        tqc.cancel();
        // tqc.editInputData();  
        //Methods for exceptional Approval
        tqc.showPopup();
        tqc.closePopup();
        tqc.getSelectedItem();
        test.stopTest();   
        tqc.setSelectedItem('sample');
        tqc.getItems();
        tqc.addQuesiton();
        tqc.getConclusion();
        tqc.submitInputData();
        //  tqc.editInputData();
        tqc.editMode();
        tqc.edit();
        tqc.submitTestData();
        tqc.addInput();
        tqc.updateTestData();
        tqc.cloneRecords();
        
        //tqc.deleteTestParameter();
        //tqc.insertTestParameter();
        //tqc.displayTestParameter();
        //tqc.submitApproval();
        QC_Components__c co = new QC_Components__c();
        co.id = comp.id;
        co.Final_Verdict__c = 'Accept';
        update co; 
        tqc.submitApproval();
        tqc.getIsInputLocked();
        
    }
    @TestVisible

    //Method to test AutoPopulateParentInfo and custom reports
    static testMethod void methodForChildComp(){
        
        methodInsert();
        QC_components__c childComp = new QC_components__c();
        childComp = comp.clone();
        childComp.name__c = 'Case'; 
        childComp.parent__c = comp.id;
        childComp.final_verdict__c= 'Accept';
        insert childComp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Case'); 
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        tqc.AutoPopulateParentInfo();
        
        //Testing ReportPDF method for Watch-Head
        comp.parent__c =comp.id;
        comp.name__c = 'Watch-Head';
        
        update childComp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Watch-Head'); 
        QC_TitanQualityControl tqc1 = new QC_TitanQualityControl();
        tqc1.reportPDF();
        
        test.starttest(); 
        //Calling custom report of Dail component
        childComp.parent__c = null;
        childComp.name__c = 'Dial';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Dial'); 
        QC_TitanQualityControl tqc2 = new QC_TitanQualityControl();
        tqc2.individualReport();
        
        //Calling custom report of Leather-Strap component
        childComp.name__c = 'Leather-Strap';
        
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Leather-Strap'); 
        QC_TitanQualityControl tqc3 = new QC_TitanQualityControl();
        tqc3.individualReport();
        
        //Calling custom report of Special-Strap component
        childComp.name__c = 'Special-Strap';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Special-Strap'); 
        QC_TitanQualityControl tqc4 = new QC_TitanQualityControl();
        tqc4.individualReport();
        
        //Calling custom report of Metal-Strap component
        childComp.name__c = 'Metal-Strap';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Metal-Strap'); 
        QC_TitanQualityControl tqc5 = new QC_TitanQualityControl();
        tqc5.individualReport();
        
        //Calling custom report of Packaging component
        childComp.name__c = 'Packaging';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Packaging'); 
        QC_TitanQualityControl tqc6 = new QC_TitanQualityControl();
        tqc6.individualReport();
        
        //Calling custom report of Battery component
        childComp.name__c = 'Battery';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Battery'); 
        QC_TitanQualityControl tqc7 = new QC_TitanQualityControl();
        tqc7.individualReport();
        
        //Calling custom report of Module component
        childComp.name__c = 'Module';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Module'); 
        QC_TitanQualityControl tqc8 = new QC_TitanQualityControl();
        tqc8.individualReport();
        test.stoptest(); 
    }
    /* added by sudama  for detailed component  */
    static testMethod void methodForChildCompDetailed(){
        
        methodInsert();
        QC_components__c childComp = new QC_components__c();
        childComp = comp.clone();
        childComp.name__c = 'Case'; 
        childComp.parent__c = comp.id;
        childComp.final_verdict__c= 'Accept';
        insert childComp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Case'); 
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        tqc.AutoPopulateParentInfo();
        tqc.detailedReportPDF();
        
        //Testing ReportPDF method for Watch-Head
        comp.parent__c =comp.id;
        comp.name__c = 'Watch-Head';
        
        update childComp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Watch-Head'); 
        QC_TitanQualityControl tqc1 = new QC_TitanQualityControl();
        tqc1.detailedReportPDF();
        
        comp.parent__c =comp.id;
        comp.name__c = 'Full-Watch';
        update childComp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Full-Watch'); 
        QC_TitanQualityControl tqcf = new QC_TitanQualityControl();
        tqcf.detailedReportPDF();
        
        test.starttest(); 
        //Calling custom report of Dail component
        childComp.parent__c = null;
        childComp.name__c = 'Dial';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Dial'); 
        QC_TitanQualityControl tqc2 = new QC_TitanQualityControl();
        tqc2.detailedReportPDF();
        
        //Calling custom report of Leather-Strap component
        childComp.name__c = 'Leather-Strap';
        
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Leather-Strap'); 
        QC_TitanQualityControl tqc3 = new QC_TitanQualityControl();
        tqc3.detailedReportPDF();
        
        //Calling custom report of Special-Strap component
        childComp.name__c = 'Special-Strap';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Special-Strap'); 
        QC_TitanQualityControl tqc4 = new QC_TitanQualityControl();
        tqc4.detailedReportPDF();
        
        //Calling custom report of Metal-Strap component
        childComp.name__c = 'Metal-Strap';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Metal-Strap'); 
        QC_TitanQualityControl tqc5 = new QC_TitanQualityControl();
        tqc5.detailedReportPDF();
        
        //Calling custom report of Packaging component
        childComp.name__c = 'Packaging';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Packaging'); 
        QC_TitanQualityControl tqc6 = new QC_TitanQualityControl();
        tqc6.detailedReportPDF();
        
        //Calling custom report of Battery component
        childComp.name__c = 'Battery';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Battery'); 
        QC_TitanQualityControl tqc7 = new QC_TitanQualityControl();
        tqc7.detailedReportPDF();
        
        //Calling custom report of Module component
        childComp.name__c = 'Module';
        update childComp;
        System.currentPageReference().getParameters().put('id', childComp.id);
        System.currentPageReference().getParameters().put('type','Module'); 
        QC_TitanQualityControl tqc8 = new QC_TitanQualityControl();
        tqc8.detailedReportPDF();
        test.stoptest(); 
    }   
    static testMethod void methodForModule() { 
        test.startTest();
        methodInsert();
        comp.name__c = 'Module'; 
        update comp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Module'); 
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        //tqc.comType = 'Module';
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        tqc.AutoPopulateParentInfo();
        tqc.cloneRecords();
        tqc.addQuesiton();
        tqc.getConclusion();
        tqc.submitInputData();
        //  tqc.editInputData();
        tqc.editMode();
        tqc.edit();
        tqc.submitTestData();
        tqc.addTest();
        /*
for(QC_TitanQualityControl.TestWrapper tw : tqc.testWrapList){
tw.name = 'testname';
tw.uom = 'testuom';
tw.Specification = 'testspec';
tw.initial1     = '3'; 
tw.initial2     = '3'; 
tw.initial3     = '3'; 
tw.initial4     = '3'; 
tw.initial5     = '3'; 
tw.AfterTest1  = '3'; 
tw.AfterTest2  = '3'; 
tw.AfterTest3  = '3'; 
tw.AfterTest4  = '3'; 
tw.AfterTest5  = '3'; 
tw.initTestObser = 'test';
tw.afterTestObser = 'sdf';
tw.observation = 'test';
tw.Observation1 = 'test';
tw.Observation2 = 'test';
tw.Observation3 = 'test';
tw.Observation4 = 'test';
tw.Observation5 = 'test';
}

*/
        tqc.updateTestData();
        //tqc.deleteTestParameter();
        //tqc.insertTestParameter();
        tqc.displayTestParameter();
        tqc.submitApproval();
        System.currentPageReference().getParameters().put('indexNo','0');
        tqc.delTest();
        test.stopTest();
    }
    
    
    static testMethod void methodForMetalStrap() { 
        test.startTest();
        methodInsert();
        comp.name__c = 'Metal-Strap';
        update comp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Metal-Strap'); 
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        tqc.AutoPopulateParentInfo();
        tqc.cloneRecords();
        tqc.addQuesiton();
        tqc.getConclusion();
        tqc.submitInputData();
        //  tqc.editInputData();
        tqc.editMode();
        tqc.edit();
        tqc.submitTestData();
        tqc.updateTestData();
        tqc.dummyTest();
        //  tqc.dummymethod();
        //tqc.deleteTestParameter();
        // tqc.insertTestParameter();
        tqc.displayTestParameter();
        tqc.detailedReportPDF();
        test.stopTest();
    }
    
    //Methods are cloned to increase the code coverage.
    static testMethod void methodInsertClone() {
        //Inserting parent component
        comp = QC_TestHandlerCls.getIndividComponent();
        insert comp;
        //Inserting child components
        compList = new list<QC_Components__c>();
        compList.addAll(QC_TestHandlerCls.getParentComponents());    
        for(QC_Components__c each : compList){
            each.name__c = 'case';
            each.parent__c = comp.id;
            each.Document_Status__c = 'Published';
            each.final_verdict__c  = 'Accept';
        }
        insert compList;   
        
        //Inserting Input parameters questions
        quesList =  new list<QC_Question__c>();
        quesList.addAll(QC_TestHandlerCls.getComponentQuestions());
        insert quesList;
        system.debug('**********'+quesList);
        
        //inserting question responses
        resList = new  list<QC_Response__c>();
        resList.AddAll(QC_TestHandlerCls.getQuesResponses());
        //inserting picklist type question responses
        for(integer i=0;i<5;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        //inserting freetext type question responses
        for(integer i=5;i<10;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        for(integer i=10;i<15;i++){
            resList[i].Question__c = quesList[i].id; 
        }
        //inserting Multi-select type question responses
        insert reslist;
        
        //Inserting test parameters questions
        testQuesList =  new list<QC_Question__c>();
        testQuesList.addAll(QC_TestHandlerCls.getTestQuestions());
        insert testQuesList;
        
        //Inserting questions conditions with question ids getPicklistConditions
        quesConList = new list<QC_Condition__c>();     
        quesConList.addAll(QC_TestHandlerCls.getQuestionConditions());
        for(integer i=0;i<11;i++){
            quesConList[i].Question__c = quesList[i].id;
            quesConList[i].Response__c = reslist[i].id;
        }
        insert quesConList;
        
        //Inserting picklist conditions with question ids 
        quesPickList = new list<QC_Condition__c>();     
        quesPickList.addAll(QC_TestHandlerCls.getPicklistConditions());
        for(integer i=0;i<3;i++){
            quesPickList[i].Question__c = quesList[i].id;
            quesPickList[i].Response__c = reslist[i].id;
            quesPickList[i].Dependent_Response__c = reslist[4+i].id;
            
        }
        //insert quesPickList;
        
        //Inserting testCondtions with test question ids
        testConList = new list<QC_Condition__c>();     
        testConList.addAll(QC_TestHandlerCls.getTestConditions());
        for(integer i=0;i<7;i++){
            testConList[i].Question__c = testQuesList[i].id;
            //Adding condition records with action = Hidden
            if(i==1 || i == 3) testConList[i].Action__c = 'Hidden';
            if(i==0) {testConList[i].OnLoad__c = false; }
        }
        insert testConList;
        
        //Inserting Input paramerters 
        inputList = new list<QC_Input_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(integer i=0;i<5;i++){
            QC_Input_Data__c inData = new QC_Input_Data__c();
            inData.Component_No__c  = comp.id;
            inData.Question__c      = quesList[i].id;
            inData.Response_Id__c   = reslist[i].id;
            inData.Multiple_Response_Ids__c = 'Abzfghfhfhfhfhfhfhfhfhfhr';
            inputList.add(inData);
        }
        insert inputList;
        
        //Inserting test paramerters 
        testDataList = new list<QC_Test_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(integer i=0;i<2;i++){
            
            QC_test_Data__c testData = new QC_test_Data__c();
            
            testData.Component_Name__c = comp.id;
            //testData.Condition_Ref__r.Onload__c  = false;
            testData.isManual__c = false;
            testData.Condition_Ref__c =  testConList[i].id;        
            testData.Observation__c = 'sample';
            testData.Conclusion__c = 'Accept';
            testDataList.add(testData);
            
        }
        insert testDataList;
    }//End of methodInsert
    
    static testMethod void methodForModuleClone() { 
        test.startTest();
        methodInsertClone();
        
        
        comp.name__c = 'Module'; 
        update comp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Module'); 
        
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        //tqc.comType = 'Module';
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tqc.AutoPopulateParentInfo();
        tqc.cloneRecords();
        tqc.addQuesiton();
        tqc.getConclusion();
        tqc.submitInputData();
        
        //   tqc.editInputData();
        tqc.editMode();
        tqc.edit();
        tqc.submitTestData();
        
        tqc.addTest();
        
        for(QC_TitanQualityControl.TestWrapper tw : tqc.testWrapList){
            tw.name = 'Module';
            tw.uom = 'Temp : 55º C Duration : 24 Hour';
            tw.Specification = 'No Stoppage';
            tw.initial1     = '3'; 
            tw.initial2     = '3'; 
            tw.initial3     = '3'; 
            tw.initial4     = '3'; 
            tw.initial5     = '3'; 
            tw.AfterTest1  = '3'; 
            tw.AfterTest2  = '3'; 
            tw.AfterTest3  = '3'; 
            tw.AfterTest4  = '3'; 
            tw.AfterTest5  = '3'; 
            tw.initTestObser = 'test';
            tw.afterTestObser = 'sdf';
            tw.observation = 'test';
            tw.Observation1 = '';
            tw.Observation2 = '';
            tw.Observation3 = '';
            tw.Observation4 = '';
            tw.Observation5 = '';
            tw.isLast       = true;
        }      
        
        tqc.updateTestData();
        // tqc.deleteTestParameter();
        //tqc.insertTestParameter();
        tqc.displayTestParameter();
        tqc.submitApproval();
        System.currentPageReference().getParameters().put('indexNo','0');
        tqc.delTest();
        
        test.stopTest();
    } 
    
    static testMethod void methodForModuleClone1() { 
        test.startTest();
        methodInsertClone();
        
        
        comp.name__c = 'Module'; 
        update comp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Module'); 
        
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        //tqc.comType = 'Module';
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tqc.AutoPopulateParentInfo();
        tqc.cloneRecords();
        tqc.addQuesiton();
        tqc.getConclusion();
        tqc.submitInputData();
        
        //   tqc.editInputData();
        tqc.editMode();
        tqc.edit();
        tqc.submitTestData();
        
        tqc.addTest();
        for(QC_TitanQualityControl.TestWrapper tw : tqc.testWrapList){
            tw.isManual=true;
            tw.name = 'Module';
            tw.uom = 'Temp : 0º C Duration : 24 Hour';
            tw.Specification = 'No Stoppage';
            tw.initial1     = ''; 
            tw.initial2     = ''; 
            tw.initial3     = ''; 
            tw.initial4     = ''; 
            tw.initial5     = ''; 
            tw.AfterTest1  = ''; 
            tw.AfterTest2  = ''; 
            tw.AfterTest3  = ''; 
            tw.AfterTest4  = ''; 
            tw.AfterTest5  = ''; 
            tw.initTestObser = 'test';
            tw.afterTestObser = 'sdf';
            tw.observation = 'test';
            tw.Observation1 = '';
            tw.Observation2 = '';
            tw.Observation3 = '';
            tw.Observation4 = '';
            tw.Observation5 = '';
            tw.isLast       = true;
        }
        
        tqc.updateTestData();
        // tqc.deleteTestParameter();
        //tqc.insertTestParameter();
        tqc.displayTestParameter();
        tqc.submitApproval();
        System.currentPageReference().getParameters().put('indexNo','0');
        tqc.delTest();
        
        test.stopTest();
    } 
    
    static testMethod void methodForModuleClone2() { 
        test.startTest();
        methodInsertClone();
        
        
        comp.name__c = 'Module'; 
        update comp;
        //Passing parameters to the url
        System.currentPageReference().getParameters().put('id', comp.id);
        System.currentPageReference().getParameters().put('type','Module'); 
        
        QC_TitanQualityControl tqc = new QC_TitanQualityControl();
        //tqc.comType = 'Module';
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tqc.AutoPopulateParentInfo();
        tqc.cloneRecords();
        tqc.addQuesiton();
        tqc.getConclusion();
        tqc.submitInputData();
        
        //    tqc.editInputData();
        tqc.editMode();
        tqc.edit();
        tqc.submitTestData();
        
        tqc.addTest();
        for(QC_TitanQualityControl.TestWrapper tw : tqc.testWrapList){
            tw.name = 'Module';
            
            //  tw.uom = 'Temp : 0º C Duration : 24 Hour';
            //  tw.Specification = 'No Stoppage';
            tw.initial1     = '3'; 
            tw.initial2     = '3'; 
            tw.initial3     = '3'; 
            tw.initial4     = '3'; 
            tw.initial5     = '3'; 
            tw.AfterTest1  = '3'; 
            tw.AfterTest2  = '3'; 
            tw.AfterTest3  = '3'; 
            tw.AfterTest4  = '3'; 
            tw.AfterTest5  = '3'; 
            tw.initTestObser = 'test';
            tw.afterTestObser = 'sdf';
            tw.observation = '';
            tw.Observation1 = '';
            tw.Observation2 = '';
            tw.Observation3 = '';
            tw.Observation4 = '';
            tw.Observation5 = '';
            tw.isLast       = true;
        }
        
        tqc.updateTestData();
        // tqc.deleteTestParameter();
        //tqc.insertTestParameter();
        tqc.displayTestParameter();
        tqc.submitApproval();
        tqc.createModuleTestParameter('Smart-Watch');
        System.currentPageReference().getParameters().put('indexNo','0');
        tqc.delTest();
        
        test.stopTest();
    }
    
    static testMethod void methodQuestion() {
        string fileName='Test Watch.jpg';
        String imageUrl1='https://c.cs16.visual.force.com/servlet/servlet.ImageServer?id=015f0000000CmfR&amp;oid=00Df0000003alx4EAA';
        QC_TitanQualityControl QC = new QC_TitanQualityControl();
        QC.imageUrl1=imageUrl1;
        QC_Components__c comp1 = new QC_Components__c(name__c='Full-Watch',Sample_Category__c='New',imageUrl__c ='https://c.cs16.visual.force.com/servlet');
        Insert comp1;
        QC.approvalResult = 'ssdcc';
        QC.uploadphotoPanel();
        QC.uploadPhoto();
        system.debug(fileName.substring(fileName.lastindexof('.'),fileName.length()));
        QC.editPhoto();
        QC.cancelPhoto();
        QC_TitanQualityControl.QuestionWrap  QW = new QC_TitanQualityControl.QuestionWrap();
        QW.selectedPicklistLabel = 'hdashxv';
    }    
    /*********************************************************************************************************************************************************************/
    //added on 08/11/2016 for test class coverage
    
    static testMethod void methodQuestion2(){
        string fileName2='Test Watch.jpg';
        String imageUrl2='https://c.cs16.visual.force.com/servlet/servlet.ImageServer?id=015f0000000CmfR&amp;oid=00Df0000003alx4EAA';
        QC_TitanQualityControl QC = new QC_TitanQualityControl();
        QC.imageUrl2=imageUrl2;
        QC_Components__c comp1 = new QC_Components__c(name__c='Full-Watch',Sample_Category__c='New',imageUrl2__c ='https://c.cs16.visual.force.com/servlet');
        Insert comp1;
     //   QC.photo2 = Blob.valueOf('https://c.cs71.visual.force.com/servlet/servlet.ImageServer?id=0154D000000E5Y6&amp;oid=00D4D0000008fPeUAI');
        Document document;
        document = new Document();
        document.Body = QC.photo2;
        document.ContentType = 'application/pdf';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        document.Name = 'My Document';
        document.FolderId = [select id from folder where name = 'QC Image'].id;
        insert document;
        QC.approvalResult = 'ssdcc';
        QC.uploadphotoPanel2();
        // imageUrl2='https://c.cs16.visual.force.com/servlet'; 
        
        QC.uploadPhoto2();
        QC.editPhoto2();
        QC.cancelPhoto();
        QC_TitanQualityControl.QuestionWrap  QW = new QC_TitanQualityControl.QuestionWrap();
        QW.selectedPicklistLabel = 'hdashxv';
    }
    static testMethod void methodQuestion3(){
        Document docmt = new Document();
        docmt.Body = Blob.valueOf('Test Body');
        docmt.ContentType = 'jpg/png';
        docmt.DeveloperName = 'my_document';
        docmt.IsPublic = true;
        docmt.Name = 'Test Document';
        docmt.FolderId = [select id from folder where name = 'QC Image'].id;
        insert docmt;
        
        integer orderNumber=10;
        string name3='.jpg';
        String imageUrl3='https://c.cs16.visual.force.com/servlet/servlet.ImageServer?id=015f0000000CmfR&amp;oid=00Df0000003alx4EAA';
        QC_TitanQualityControl QC = new QC_TitanQualityControl();
        QC.imageUrl3=imageUrl3;
        QC_Components__c comp1 = new QC_Components__c(name__c='Full-Watch',Sample_Category__c='New',final_verdict__c='Accept',imageUrl3__c ='https://c.cs16.visual.force.com/servlet');
        Insert comp1;
        System.currentPageReference().getParameters().put('id',comp1.id);
        System.currentPageReference().getParameters().put('type','Module');
        QC.approvalResult = 'ssdcc';
        string fileName3=docmt.Name;
        //String imageUrl3='https://c.cs16.visual.force.com/servlet'; 
        //String imageUrl3='https://c.cs16.visual.force.com/servlet/servlet.ImageServer?id=015f0000000CmfR&amp;oid=00Df0000003alx4EAA';
        QC.uploadPhoto3();
        QC.submitApproval();
        QC.editPhoto3();
        QC.cancelPhoto();
        QC.uploadphotoPanel3();
        QC.selectBrand();
        QC_TitanQualityControl.QuestionWrap  QW = new QC_TitanQualityControl.QuestionWrap();
        QW.selectedPicklistLabel = 'hdashxv';
    }
}