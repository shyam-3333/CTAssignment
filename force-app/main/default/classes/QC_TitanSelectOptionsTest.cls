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
@isTest
private class QC_TitanSelectOptionsTest {
    
    static QC_Components__c  comp;
    static QC_Components__c  comp1;
    static list<QC_Components__c> compList;
    static list<QC_Question__c> quesList;
    static list<QC_Response__c> resList; 
    static list<QC_Question__c> testQuesList;
    static list<QC_Condition__c> quesConList;
    static list<QC_Condition__c> testConList;
    static list<QC_Input_Data__c> inputList;
    static List<QC_Test_Data__c> testDataList;
    static list<QC_Component_Prefix__c> custSettingList;
    
    static testMethod void methodInsert() { 
        
        //Inserting custom setting records 
        custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        id rtId = [select id from recordtype where developername='Brand_Details' and SobjectType='QC_Master__c'].id;
        QC_Master__c brand = new QC_Master__c();
        brand.recordtypeid = rtid;
        brand.name = 'Titan 8K-';
        insert brand;
        //Inserting parent component
        comp = QC_TestHandlerCls.getIndividComponent();
        comp.name__c= 'Full-Watch';
        comp.Master__c = true;
        comp.Brand__c = brand.id;
        //Initializing watch variant to avoid trigger validation
        comp.Watch_variant__c='test&HandFW&0809';
        insert comp;
        
        //Inserting child components
        compList = new list<QC_Components__c>();
        compList.addAll(QC_TestHandlerCls.getChildComponent());    
        for(QC_Components__c each : compList){
            each.name__c = 'Case';
            each.parent__c = comp.id;
        }
        insert compList;   
        
        //Inserting Input parameters questions
        quesList =  new list<QC_Question__c>();
        quesList.addAll(QC_TestHandlerCls.getComponentQuestions());
        insert quesList;
        
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
        
        //Inserting questions conditions with question ids
        quesConList = new list<QC_Condition__c>();     
        quesConList.addAll(QC_TestHandlerCls.getQuestionConditions());
        for(integer i=0;i<2;i++){
            quesConList[i].Question__c = quesList[i].id;
        }
        insert quesConList;
        
        //Inserting testCondtions with test question ids
        testConList = new list<QC_Condition__c>();     
        testConList.addAll(QC_TestHandlerCls.getTestConditions());
        for(integer i=0;i<2;i++){
            testConList[i].Question__c = testQuesList[i].id;
        }
        insert testConList;
        
        //Inserting Input paramerters 
        inputList = new list<QC_Input_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(integer i=0;i<5;i++){
            QC_Input_Data__c inData = new QC_Input_Data__c();
            inData.Component_No__c = comp.id;
            inData.Question__c =  quesList[i].id;
            inData.Response_Id__c = reslist[i].id;
            inputList.add(inData);
        }
        insert inputList;
        testDataList = new list<QC_Test_Data__c>();
        //inputList.addAll(QC_TestHandlerCls.getParentInputParameters());
        for(integer i=0;i<2;i++){
            
            QC_test_Data__c testData = new QC_test_Data__c();
            
            testData.Component_Name__c = comp.id;
            //testData.Condition_Ref__r.Onload__c  = false;
            testData.isManual__c = false;
            testData.Condition_Ref__c =  testConList[i].id;        
            testData.Observation__c = 'sample';
            testData.Conclusion__c = 'Reject';
            testDataList.add(testData);
            
        }
        insert testDataList; 
        
        
        
    }
    
    static testMethod void fullWatchMethod(){
        methodInsert();
        comp.Watch_variant__c = 'TestFw';
        comp.master__c = true;
        update comp;
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tso.firstSelection = 'new';
        tso.secondSelection ='Full-Watch';
        tso.component.Watch_variant__c = 'Test&&&Fw0809';
        //Component Initialization
        tso.component.Master_Variant__c = comp.id;
        tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        //Selecting childs for perticular component
        tso.componentFullWatch  = new list<String>{'Case'};
            tso.component.Brand__c = comp.Brand__c;
        //Method Calling
        tso.getFirstAction();
        tso.getSecondAction();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.componentMaster();
        tso.submit();
        tso.updateComponents();
    }
    
    static testMethod void reSubmissionMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        comp.Report_Ref_Number__c='FW/099876/14-15';
        comp.master__c = true;
        update comp;
        tso.firstSelection = 'Re-Submission';
        tso.secondSelection ='Full-Watch';
        tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        tso.component.Brand__c = comp.Brand__c;
        system.debug('********comp*********'+comp);
        //Method Calling
        tso.getFirstAction();
        tso.getSecondAction();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant();              
        tso.submit();
        tso.updateComponents();
        tso.reSubmission();       
        //Resubmission the record with report ref number              
        comp.Report_Ref_Number__c='FW/099976[a]/14-15';
        comp.master__c = true;
        update comp;
        tso.master = new Qc_Master__c(FullWatch_Lookup__c =comp.id);
        system.debug('**********'+tso.component); 
        tso.componentMaster();    
        tso.reSubmission();   
    } 
    
    static testMethod void inidComponentMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Case';
        //tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        //Method Calling
        tso.getFirstAction();
        tso.getSecondAction();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.componentMaster(); 
        tso.submit();           
    } 
    
    static testMethod void inidCompDailMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Dail';              
        //Method Calling
        tso.componentMaster();        
        tso.submit();           
    } 
    static testMethod void inidCompMetalStrapMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Metal-Strap';              
        //Method Calling
        tso.componentMaster();        
        tso.submit();           
    } 
    
    static testMethod void inidCompLeatherStrapMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Leather-Strap';              
        //Method Calling
        tso.componentMaster();        
        tso.submit();           
    } 
    
    static testMethod void inidCompModuleMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Module';              
        //Method Calling
        tso.componentMaster();        
        tso.submit();           
    } 
    static testMethod void inidCompBatteryMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Battery';              
        //Method Calling
        tso.componentMaster();        
        tso.submit();           
    } 
    
    static testMethod void inidCompPackagingMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Component';
        tso.componentPicklist = 'Pakaging';              
        //Method Calling
        tso.componentMaster();        
        tso.submit();           
    } 
    static testMethod void componentMasterMethod(){
        comp1=new  QC_Components__c  ();
        methodInsert();
        comp.Watch_variant__c = 'Sample';
        upsert comp;
        comp1.name__c= 'Full-Watch';
        comp1.master_variant__c= comp.id;
        comp1.Brand__c = comp.Brand__c;
        upsert comp1;      
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tso.firstSelection = 'New';
        tso.secondSelection ='Full-Watch';
        //Component Initialization
        
        tso.master = new Qc_Master__c(Fullwatch_lookup__c = comp.id);
        tso.master.Master_FullWatch__c=comp.id;
        tso.component.master_variant__c = comp.id;
        tso.component.Brand__c = comp.Brand__c;
        //Selecting childs for perticular component
        tso.componentFullWatch  = new list<String>{'Case'};
            //Method Calling
            tso.componentMaster();  
    }
    static testMethod void componentMasterMethod1(){
        comp1=new  QC_Components__c  ();
        methodInsert();
        comp.Watch_variant__c = 'Sample';
        comp.Name__c='Watch-Head';
        upsert comp;
        comp1.name__c= 'Watch-Head';
        comp1.master_variant__c= comp.id;
        comp1.Brand__c = comp.Brand__c;
        upsert comp1;      
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Head';
        //Component Initialization
        
        tso.master = new Qc_Master__c(WatchHead_lookup__c = comp.id);
        tso.master.Master_WatchHead__c=comp.id;
        tso.component.master_variant__c = comp.id;
        //Selecting childs for perticular component
        //tso.componentWatchHead.add('test');
        tso.component.Brand__c = comp.Brand__c;
        tso.componentWatchHead = new list<String>{'Case'};
            
            //Method Calling
            tso.componentMaster();  
    }
    static testMethod void watchHeadMethod(){
        methodInsert();
        //Initializing watch variant to avoid trigger validation
        comp.Watch_variant__c = 'TestWH';
        //Making comp as master record
        comp.master__c = true;
        update comp;
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tso.firstSelection = 'new';
        tso.secondSelection ='Watch-Head';
        tso.component.Brand__c = comp.Brand__c;
        //Component Initialization
        tso.component.Master_Variant__c = comp.id;
        tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        //Selecting childs for perticular component
        tso.componentWatchHead  = new list<String>{'Case'};
            //Method Calling
            tso.getFirstAction();
        tso.getSecondAction();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.componentMaster();
        tso.submit();
        tso.updateComponents();
        tso.reSubmission();        
        tso.deepCloneFullWatchHead();
        tso.deepCloneWatchComponent(); 
        tso.retrieveComponent();   
        tso.selectCondition(); 
        tso.cloneInputData();
        tso.cloneTestData();     
        tso.cloneChildComponents();
        tso.cloneComp();          
        tso.cloneInputParameter(); 
        tso.cloneTestParameter();
    }
    
    static testMethod void reSubmissionMethod1(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions();       
        
        id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
        system.assert(savedCompId != null);
        
        tso.firstSelection = 'Re-Submission';
        tso.secondSelection ='Full-Watch';
        tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        tso.component.Brand__c = comp.Brand__c;
        //Method Calling
        tso.getFirstAction();
        tso.getSecondAction();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.componentMaster();
        tso.submit();
        tso.updateComponents();
        tso.reSubmission();       
        tso.deepCloneFullWatchHead();
        tso.deepCloneWatchComponent(); 
        tso.retrieveComponent();   
        tso.selectCondition(); 
        tso.cloneInputData();
        tso.cloneTestData();     
        tso.cloneChildComponents();
        tso.cloneComp();          
        tso.cloneInputParameter(); 
        tso.cloneTestParameter();
        
        tso.firstSelection  = 'Re-Submission';
        tso.secondSelection = 'Full-Watch';
        tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        //tso.componentMaster();
        tso.reSubmission();   
    } 
    
    static testMethod void masterVariantMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Head';     
        tso.component.Master_Variant__c = comp.id;
        tso.component.Brand__c = comp.Brand__c;
        tso.master = new Qc_Master__c(FullWatch_Lookup__c = comp.id);
        tso.componentWatchHead  = new list<String>{'Case'};
            tso.submit();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.updateComponents();
        tso.reSubmission();        
        tso.deepCloneFullWatchHead();
        tso.deepCloneWatchComponent(); 
        tso.retrieveComponent();   
        tso.selectCondition(); 
        tso.cloneInputData();
        tso.cloneTestData();     
        tso.cloneChildComponents();
        tso.cloneComp();          
        tso.cloneInputParameter(); 
        tso.cloneTestParameter(); 
    }
    /**********************************************************************************************************************************************/
    //added on 08/11/2016 for test class coverage
    static testMethod void insertComponentMethod(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        tso.firstSelection = 'Competitor Products';
        tso.secondSelection ='Watch-Head';     
        tso.component.Brand__c = comp.Brand__c;
        tso.componentWatchHead  = new list<String>{'Case'};
            tso.submit();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.updateComponents();
        tso.reSubmission();        
        tso.deepCloneFullWatchHead();
        tso.deepCloneWatchComponent(); 
        tso.retrieveComponent();   
        tso.selectCondition();  
        tso.cloneInputData();
        tso.cloneTestData();     
        tso.cloneChildComponents();
        tso.cloneComp();          
        tso.cloneInputParameter(); 
        tso.cloneTestParameter(); 
    }
    static testMethod void insertComponentErrorMsg1(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Head';
        tso.submit();
        tso.compPicVal();
        tso.componentMaster(); 
    }    
    static testMethod void insertComponentErrorMsg2(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        tso.firstSelection = 'Re-submission';
        tso.secondSelection ='Watch-Head';
        tso.submit();
        tso.compPicVal();
        tso.componentMaster(); 
        tso.reSubmission();
        tso.retrieveComponent();        
    }   
    static testMethod void insertComponentMethod2(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        tso.firstSelection = 'New';
        tso.secondSelection ='Watch-Head';     
        tso.component.Brand__c = comp.Brand__c;
        tso.componentWatchHead  = new list<String>{'Case'};
            tso.submit();
        tso.compPicVal();
        tso.componentMaster();        
        tso.markMasterVariant(); 
        tso.updateComponents();
        tso.reSubmission();        
        tso.deepCloneFullWatchHead();
        tso.deepCloneWatchComponent(); 
        tso.retrieveComponent();   
        tso.selectCondition(); 
        tso.cloneInputData();
        tso.cloneTestData();     
        tso.cloneChildComponents();
        tso.cloneComp();          
        tso.cloneInputParameter(); 
        tso.cloneTestParameter(); 
    }
    static testMethod void insertComponentMethod3(){
        methodInsert();
        /*  list<QC_Test_Data__c> testParamParentComp= new list<QC_Test_Data__c>();
for(integer i=0;i<5;i++){
QC_Test_Data__c inData = new QC_Test_Data__c();
inData.Component_No__c = comp.id;
inData.Question__c =  quesList[i].id;
inData.Response_Id__c = reslist[i].id;
testParamParentComp.add(inData);
}
insert testParamParentComp;*/
        // QC_Components__c fullwatchComponent=null;
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        // tso.fullwatchComponent=null;
        tso.firstSelection = 'New';
        tso.secondSelection ='Full-Watch'; 
        tso.master = new Qc_Master__c(Fullwatch_lookup__c = comp.id);
        tso.master.Master_FullWatch__c=comp.id;
        tso.component.master_variant__c = comp.id;
        tso.component.Brand__c = comp.Brand__c;
        tso.component.Component_Status__c='Obsolete';
        //Selecting childs for perticular component
        tso.componentFullWatch  = new list<String>{'Case'};
            //Method Calling
            tso.componentMaster();      
        tso.submit();
        tso.compPicVal();     
        tso.markMasterVariant(); 
        tso.updateComponents();
        tso.reSubmission();        
        tso.deepCloneFullWatchHead();
        tso.deepCloneWatchComponent(); 
        tso.retrieveComponent();   
        tso.selectCondition();
        //   tso.selectCondition1();
        tso.cloneInputData();
        tso.cloneTestData();     
        tso.cloneChildComponents();
        tso.cloneComp();          
        tso.cloneInputParameter(); 
        tso.cloneTestParameter(); 
    }  
    static testMethod void updateComponentMethod3(){
        methodInsert();
        QC_TitanSelectOptions tso = new QC_TitanSelectOptions(); 
        tso.firstSelection = 'Update';
        tso.secondSelection ='Full-Head'; 
        tso.master = new Qc_Master__c(Fullwatch_lookup__c = comp.id);
        tso.master.Master_FullWatch__c=comp.id;
        tso.component.master_variant__c = comp.id;
        tso.component.Brand__c = comp.Brand__c;
        //Selecting childs for perticular component
        tso.componentFullWatch  = new list<String>{'Case'};
        //Method Calling
       	tso.componentMaster();      
        tso.submit();
        tso.compPicVal();     
        tso.markMasterVariant(); 
        tso.updateComponents();
        
    }  
}