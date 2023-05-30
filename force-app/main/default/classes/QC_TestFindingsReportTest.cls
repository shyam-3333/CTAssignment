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
private class QC_TestFindingsReportTest {

   static QC_Components__c  comp;
   
   @testsetup static void commonData(){
    	//Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
    }
    
    static testMethod void myUnitTest() {

        comp = new QC_Components__c(name__c='Dial',Watch_variant__c='Fastrack');
        insert comp;
        //Inserting Input parameters questions
        //id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        string rtId = schema.sObjectType.QC_Question__c.getRecordTypeInfosByName().get('Question').getRecordTypeId();
        QC_Question__c ques = new QC_Question__c(Question__c= 'Dial No',Component_Type__c='Dial',Order_Number__c = 10,Onload__c= false,Type__c= 'Free Text',Comment_Required__c = false,recordtypeid = rtid);
        insert ques;
        
        string testRTId = schema.sObjectType.QC_Question__c.getRecordTypeInfosByName().get('Test').getRecordTypeId(); 
        QC_Question__c testQues = new QC_Question__c(Test_Name__c = 'sample test',UOM__c = 'sample UOM', specification__c = 'sample spec', recordtypeid =  testRTId);
        insert testQues;
       //inserting question responses
        QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='xsdsds',Order_Number__c=10);        
        insert res;
        
        string testConRTId = [select id from recordtype where developername='Test_Condition' and SobjectType='QC_Condition__c'].id;
        //string testConRTId = schema.sObjectType.QC_Condition__c.getRecordTypeInfosByName().get('Test_Condition').getRecordTypeId(); 
                            // Schema.SObjectType.Pro_Container__c.getRecordTypeInfosByName().get('Packet').getRecordTypeId();
       // string quesConRTId = schema.sObjectType.QC_Condition__c.getRecordTypeInfosByName().get('Question_Condition').getRecordTypeId();
        
        QC_Condition__c tCondition = new QC_Condition__c(Question__c=testQues.id,recordtypeId = testConRTId,onload__c = true,component_type__c ='Dial');
        insert tcondition;
        
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='sdsdsdsd');
        insert inputMaterial;
        
        //Insert test parameter record
        QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c = tCondition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testList;
        
        /*list<QC_Condition__c> testParamList = [select id,Question__r.UOM__c,Question__r.Test_Name__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,
                                                   order_number__c,Response__c,action__c from QC_Condition__c 
                                                   where component_type__c ='Dial' and onload__c = true and recordtype.developerName ='Test_Condition']; 
        system.debug('*********'+testParamList);
        */
        PageReference pageRef = Page.QC_TestFindingsReport ;
        Test.setCurrentPageReference(pageRef);   
        ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport testFinding = new QC_TestFindingsReport();
        
        //To cover Leakage Test
        comp.name__c =  'Battery';
        update comp;
        testQues.Acceptance_Criteria__c = 'Leakage Test';
        update testQues;
        ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport AccCri = new QC_TestFindingsReport();
        
        //To cover General Observation block
        testQues.Acceptance_Criteria__c = null;
        testQues.test_Name__c = 'General Observation';
        update testQues;
        ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport genOb = new QC_TestFindingsReport();
        

    }
    
     static testMethod void myUnitTest2() {
        
        comp = new QC_Components__c(name__c='Battery',Watch_variant__c='Fastrack');
        insert comp;
        //Inserting Input parameters questions
        //id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        string rtId = schema.sObjectType.QC_Question__c.getRecordTypeInfosByName().get('Question').getRecordTypeId();
        QC_Question__c ques = new QC_Question__c(Question__c= 'Dial No',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Free Text',Comment_Required__c = false,recordtypeid = rtid);
        insert ques;
        
        string testRTId = schema.sObjectType.QC_Question__c.getRecordTypeInfosByName().get('Test').getRecordTypeId(); 
        QC_Question__c testQues = new QC_Question__c(Test_Name__c = 'sample test',Acceptance_Criteria__c = 'Leakage Test',UOM__c = 'sample UOM', specification__c = 'sample spec', recordtypeid =  testRTId);
        insert testQues;
       //inserting question responses
        QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='xsdsds',Order_Number__c=10);        
        insert res;
        
        string testConRTId = [select id from recordtype where developername='Test_Condition' and SobjectType='QC_Condition__c'].id;
        //string testConRTId = schema.sObjectType.QC_Condition__c.getRecordTypeInfosByName().get('Test_Condition').getRecordTypeId(); 
                            // Schema.SObjectType.Pro_Container__c.getRecordTypeInfosByName().get('Packet').getRecordTypeId();
       // string quesConRTId = schema.sObjectType.QC_Condition__c.getRecordTypeInfosByName().get('Question_Condition').getRecordTypeId();
        
        QC_Condition__c tCondition = new QC_Condition__c(Question__c=testQues.id,recordtypeId = testConRTId,onload__c = true,component_type__c ='Battery');
        insert tcondition;
        
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='sdsdsdsd');
        insert inputMaterial;
        
        //Insert test parameter record
        QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c = tCondition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testList;
        
        /*list<QC_Condition__c> testParamList = [select id,Question__r.UOM__c,Question__r.Test_Name__c,Question__r.Specification__c,Question__r.Acceptance_Criteria__c,
                                                   order_number__c,Response__c,action__c from QC_Condition__c 
                                                   where component_type__c ='Dial' and onload__c = true and recordtype.developerName ='Test_Condition']; 
        system.debug('*********'+testParamList);
        */
        PageReference pageRef = Page.QC_TestFindingsReport ;
        Test.setCurrentPageReference(pageRef);   
        ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport testFinding = new QC_TestFindingsReport();
        
        //To cover General Observation block
        testQues.Acceptance_Criteria__c = null;
        testQues.test_Name__c = 'General Observation';
        update testQues;

        ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport genOb = new QC_TestFindingsReport();
        
        
        //To cover General Observation block
        testQues.Acceptance_Criteria__c = null;
        testQues.test_Name__c = 'Visual Inspection';
        update testQues;

       // ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport visInsp = new QC_TestFindingsReport();
        
        //To cover General Observation block
        testQues.Acceptance_Criteria__c = null;
        testQues.test_Name__c = 'Final else block';
        update testQues;

        //ApexPages.currentPage().getParameters().put('id',comp.id);
        QC_TestFindingsReport elseBlc = new QC_TestFindingsReport();
        
        

    }
}