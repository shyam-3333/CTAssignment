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
private class QC_packingDetailedReportTest{

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
        comp = new QC_Components__c(name__c='Packaging',Watch_variant__c='fastrackpkg');
        insert comp;                         
        //Inserting Input parameters questions
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        QC_Question__c ques = new QC_Question__c(Question__c= 'Box Type',Component_Type__c='Packaging',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
       //inserting question responses
        QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='IBD',Order_Number__c=10);        
        insert res;
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='IBD');
     insert inputMaterial;
     QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id);
     insert condition;    
     //Insert test parameter record
     QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
     insert testList;
     
        PageReference pageRef = Page.QC_packingDetailedReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',comp.id);
        
        QC_packingDetailedReport qcLeatherStrapRep       = new QC_packingDetailedReport();
        
        QC_packingDetailedReport.DefinedParameters  dp   = new QC_packingDetailedReport.DefinedParameters();
        dp.inputParam     = 'input param';
        dp.value       = 'value';
        QC_packingDetailedReport.DefinedTestParam  dtp    = new QC_packingDetailedReport.DefinedTestParam();
        dtp.observation    = 'onservation';
        DTP.acceptanceCritaria = 'CRITERIA';
        dtp.uUOM        = 'uom';
        dtp.specification  = 'specification';
        dtp.testName    = 'test name';
        dtp.verdict      = 'verdict';   
        dtp.commentAndRemarks = 'comments and remarks';  
    }
    static testMethod void myUnitTest1() {
      
      list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Packaging',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
        id rtId = [select id from recordtype where developername='Test' and SobjectType='QC_Question__c'].id;
        QC_Question__c ques = new QC_Question__c(Question__c= 'SHOCK & BUMP TEST',Component_Type__c='Packaging',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
        QC_Question__c ques2 = new QC_Question__c(Question__c= 'ROLL TEST',Component_Type__c='Packaging',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques2;
        QC_Question__c ques3 = new QC_Question__c(Question__c= 'DROP TEST',Component_Type__c='Packaging',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques3;
        
       //inserting question responses
        QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='IBD',Order_Number__c=10);        
        insert res;
     //Query the condition Record type. 
     id rtIdTestCond = [select id from recordtype where developername='Test_Condition' and SobjectType='QC_Condition__c'].id;
     
     QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id,recordtypeid = rtIdTestCond);
     insert condition;
     
     //Insert input parameters
        //QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='IBD');
     //insert inputMaterial; 
      
     
     //Insert test parameter record
     QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
     insert testList;
          
        PageReference pageRef = Page.QC_PackagingReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',comp.id);
        
        QC_PackagingReport qcLeatherStrapRep     = new QC_PackagingReport();
        
        QC_PackagingReport.DefinedParameters  dp   = new QC_PackagingReport.DefinedParameters();
        dp.inputParam       = 'input param';
        dp.value         = 'value';
        QC_PackagingReport.DefinedTestParam  dtp    = new QC_PackagingReport.DefinedTestParam();
        dtp.observation      = 'onservation';
        DTP.acceptanceCritaria  = 'CRITERIA';
        dtp.uUOM        = 'uom';
        dtp.specification    = 'specification';
        dtp.testName      = 'test name';
        dtp.verdict        = 'verdict';
        dtp.commentAndRemarks   = 'comments and remarks';
     
    }
}