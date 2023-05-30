/*
    Name:                       QC_BatteryReportTest 
    Created By:                 Shamsher Singh
    Created Date:               10/04/2015
    Modified By:
    Last Modified Date:
    Description:                
    Methods Used:
*/
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
private class QC_Document_Status_Email_BatteryTest{

   static QC_Components__c  comp;
   
   @testsetup static void commonData(){
      //Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
    }
    static testMethod void myUnitTest() {
        
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Battery',Watch_variant__c='fastrack222');
        insert comp;
        //Inserting Input parameters questions
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        
        QC_Question__c ques = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Initial Capacity ( n:10)',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
      
        ques = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Visual Inspection',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
        ques = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Non-Defective Battery',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
        ques = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= '1 Year Storage condition (n:10)',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
        ques = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= '2 Year Storage condition (n:10)',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
         ques = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= '3 Year Storage condition (n:10)',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
       //inserting question responses
        QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='Low Drain',Order_Number__c=10);        
        insert res;
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='Low Drain');
     insert inputMaterial;
          
     QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id);
     insert condition;
         
     //Insert test parameter record
     QC_Test_Data__c testParam = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
     insert testParam;
     
        
        QC_Document_Status_Email_Battery qcBatteryRep       = new QC_Document_Status_Email_Battery();
        qcBatteryRep.compId = comp.Id;
        qcBatteryRep.getComponent();   
        
        QC_Document_Status_Email_Battery.DefinedParameters  dp   = new QC_Document_Status_Email_Battery.DefinedParameters();
        dp.inputParam     = 'input param';
        dp.value       = 'value';
        QC_Document_Status_Email_Battery.DefinedTestParam  dtp    = new QC_Document_Status_Email_Battery.DefinedTestParam();
        dtp.observation      = 'onservation';
        dtp.spec        = 'kksaddsa';
        dtp.uUOM        = 'uom';
        dtp.specification    = 'specification';
        dtp.testName      = 'Initial Capacity ( n:10)';
        dtp.verdict        = 'verdict';
        dtp.acceptanceCritaria   = 'Acceptance Criteria';
        dtp.conclusion      = 'conclusion';
     
    }
    static testMethod void myUnitTest1() {
      
      list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Battery',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
     id rtIdTest = [select id from recordtype where developername='Test' and SobjectType='QC_Question__c'].id;
      QC_Question__c quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Initial Capacity ( n:10)',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
         quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Visual Inspection',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
        
        quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Non-Defective Battery',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
         quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Visual Inspection',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
        QC_Response__c res = new QC_Response__c(Question__c =quesTest.id ,Order_Number__c=10);        
        insert res; 
        
        QC_Input_Data__c inputTest = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =quesTest.id,Value__c='jdklsfjdsnjfds');
     insert inputTest;
     
     id rtIdTestCond = [select id from recordtype where developername='Test_Condition' and SobjectType='QC_Condition__c'].id;
     
     QC_Condition__c conditionTest = new QC_Condition__c(Question__c=quesTest.id,Response__c =res.id,recordtypeid = rtIdTestCond);
     insert conditionTest;
     
     QC_Test_Data__c testRec = new QC_Test_Data__c(Condition_Ref__c=conditionTest.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
     insert testRec;

        
        QC_Document_Status_Email_Battery qcBatteryRep= new QC_Document_Status_Email_Battery();
             qcBatteryRep.compId = comp.Id;
        qcBatteryRep.getComponent();   
        QC_Document_Status_Email_Battery.DefinedParameters  dp   = new QC_Document_Status_Email_Battery.DefinedParameters();
        dp.inputParam     = 'input param';
        dp.value       = 'value';
        QC_Document_Status_Email_Battery.DefinedTestParam  dtp    = new QC_Document_Status_Email_Battery.DefinedTestParam();
        dtp.observation      = 'onservation';
        dtp.spec        = 'kksaddsa';
        dtp.uUOM        = 'uom';
        dtp.specification    = 'specification';
        dtp.testName      = '1 Year Storage condition (n:10)';
        dtp.verdict        = 'verdict';
        dtp.acceptanceCritaria   = 'Acceptance Criteria';
        dtp.conclusion      = 'conclusion';
     
    }
    
     static testMethod void myUnitTest2() {
      
      list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Battery',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
     id rtIdTest = [select id from recordtype where developername='Test' and SobjectType='QC_Question__c'].id;
      QC_Question__c quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Initial Capacity ( n:10)',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
         quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Visual Inspection',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
        
        quesTest = new QC_Question__c(Question__c= 'Battery Code.(SKU)',Test_Name__c= 'Non-Defective Battery',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtIdTest);
        insert quesTest;
       
        QC_Response__c res = new QC_Response__c(Question__c =quesTest.id ,Order_Number__c=10);        
        insert res; 
        
        QC_Input_Data__c inputTest = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =quesTest.id,Value__c='jdklsfjdsnjfds');
     insert inputTest;
     
     id rtIdTestCond = [select id from recordtype where developername='Test_Condition' and SobjectType='QC_Condition__c'].id;
     
     QC_Condition__c conditionTest = new QC_Condition__c(Question__c=quesTest.id,Response__c =res.id,recordtypeid = rtIdTestCond);
     insert conditionTest;
     
     QC_Test_Data__c testRec = new QC_Test_Data__c(Condition_Ref__c=conditionTest.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
     insert testRec;

      
        
        QC_Document_Status_Email_Battery qcBatteryRep = new QC_Document_Status_Email_Battery();
           qcBatteryRep.compId = comp.Id;
        qcBatteryRep.getComponent();   
        
        QC_Document_Status_Email_Battery.DefinedParameters  dp   = new QC_Document_Status_Email_Battery.DefinedParameters();
        dp.inputParam     = 'input param';
        dp.value       = 'value';
        QC_Document_Status_Email_Battery.DefinedTestParam  dtp    = new QC_Document_Status_Email_Battery.DefinedTestParam();
        dtp.observation      = 'onservation';
        dtp.spec        = 'kksaddsa';
        dtp.uUOM        = 'uom';
        dtp.specification    = 'specification';
        dtp.testName      = '1 Year Storage condition (n:10)';
        dtp.verdict        = 'verdict';
        dtp.acceptanceCritaria   = 'Acceptance Criteria';
        dtp.conclusion      = 'conclusion';
     
    }
}