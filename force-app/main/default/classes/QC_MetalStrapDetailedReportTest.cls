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
private class QC_MetalStrapDetailedReportTest {

    static QC_Components__c  comp;
    @testsetup static void commonData(){
      //Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
    }    
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Metal-Strap',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        
        QC_Question__c ques = new QC_Question__c(Question__c= 'Material',Component_Type__c='Metal-Strap',Test_Name__c='Material Chemical Composition - Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
        QC_Question__c ques1 = new QC_Question__c(Question__c= 'Fixed Link Joint',Component_Type__c='Metal-Strap',Test_Name__c='Material Chemical Composition - Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques1;
       //inserting question responses
       QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert res;
        QC_Response__c res1 = new QC_Response__c(Question__c =ques1.id ,Response__c ='Curved',Order_Number__c=10);        
        insert res1;
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='Ceramic');
     insert inputMaterial;
     QC_Input_Data__c inputMaterial1 = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques1.id,Value__c='Curved');
     insert inputMaterial1;
     
     QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id);
     insert condition;
     QC_Condition__c condition1 = new QC_Condition__c(Question__c=ques1.id,Response__c=res1.id);
     insert condition1;
     
     //Insert test parameter record
     QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=true);
     insert testList;
     QC_Test_Data__c testList1 = new QC_Test_Data__c(Condition_Ref__c=condition1.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=false);
     insert testList1;
     
        PageReference pageRef = Page.QC_MetalStrapDetailedReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',comp.id);
        
        QC_MetalStrapDetailedReport qcMetalStrapRep       = new QC_MetalStrapDetailedReport();
        
        QC_MetalStrapDetailedReport.DefinedParameters  dp   = new QC_MetalStrapDetailedReport.DefinedParameters();
        dp.inputParam     = 'input param';
        dp.value       = 'value';
        dp.color      = 'Red';
        QC_MetalStrapDetailedReport.DefinedTestParam  dtp    = new QC_MetalStrapDetailedReport.DefinedTestParam();
        dtp.observation    = 'onservation';
        dtp.uom        = 'uom';
        dtp.specification  = 'specification';
        dtp.testName    = 'test name';
        dtp.verdict      = 'verdict';
     
    }
       static testMethod void myUnitTest1() {
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Metal-Strap',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        
        QC_Question__c ques = new QC_Question__c(Question__c= 'Material',test_Name__c='Plating Layer - Strap',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
        QC_Question__c ques1 = new QC_Question__c(Question__c= 'Fixed Link Joint',test_Name__c='Plating Layer - Strap',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques1;
       //inserting question responses
       QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert res;
        QC_Response__c res1 = new QC_Response__c(Question__c =ques1.id ,Response__c ='Curved',Order_Number__c=10);        
        insert res1;
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='Ceramic');
        insert inputMaterial;
        QC_Input_Data__c inputMaterial1 = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques1.id,Value__c='Curved');
       insert inputMaterial1;
        
        QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id);
        insert condition;
       QC_Condition__c condition1 = new QC_Condition__c(Question__c=ques1.id,Response__c=res1.id);
       insert condition1;
        
        //Insert test parameter record
        QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=true);
        insert testList;
       QC_Test_Data__c testList1 = new QC_Test_Data__c(Condition_Ref__c=condition1.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=false);
       insert testList1;
        
        PageReference pageRef = Page.QC_MetalStrapDetailedReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',comp.id);
        
        QC_MetalStrapDetailedReport qcLeatherStrapRep           = new QC_MetalStrapDetailedReport();
        
        QC_MetalStrapDetailedReport.DefinedParameters  dp   = new QC_MetalStrapDetailedReport.DefinedParameters();
        dp.inputParam       = 'input param';
        dp.value            = 'value';
        dp.color            = 'Red';
        QC_MetalStrapDetailedReport.DefinedTestParam    dtp     = new QC_MetalStrapDetailedReport.DefinedTestParam();
        dtp.observation     = 'onservation';
        dtp.uom             = 'uom';
        dtp.specification   = 'specification';
        dtp.testName        = 'test name';
        dtp.verdict         = 'verdict';
        
    }
         static testMethod void myUnitTest2() {
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Metal-Strap',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        
        QC_Question__c ques = new QC_Question__c(Question__c= 'Material',test_Name__c='Plating Layer - Strap1',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques;
       QC_Question__c ques1 = new QC_Question__c(Question__c= 'Fixed Link Joint',test_name__c='Material Chemical Composition - Strap1',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert ques1;
       //inserting question responses
       QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert res;
        QC_Response__c res1 = new QC_Response__c(Question__c =ques1.id ,Response__c ='Curved',Order_Number__c=10);        
       insert res1;
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='Ceramic');
        insert inputMaterial;
       QC_Input_Data__c inputMaterial1 = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques1.id,Value__c='Curved');
       insert inputMaterial1;
        
        QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id);
        insert condition;
        QC_Condition__c condition1 = new QC_Condition__c(Question__c=ques1.id,Response__c=res1.id);
        insert condition1;
        
        //Insert test parameter record
        QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=true);
        insert testList;
        QC_Test_Data__c testList1 = new QC_Test_Data__c(Condition_Ref__c=condition1.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=false);
          insert testList1;
        
        PageReference pageRef = Page.QC_MetalStrapDetailedReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',comp.id);
        
        QC_MetalStrapDetailedReport qcLeatherStrapRep           = new QC_MetalStrapDetailedReport();
        
        QC_MetalStrapDetailedReport.DefinedParameters  dp   = new QC_MetalStrapDetailedReport.DefinedParameters();
        dp.inputParam       = 'input param';
        dp.value            = 'value';
        dp.color            = 'Red';
        QC_MetalStrapDetailedReport.DefinedTestParam    dtp     = new QC_MetalStrapDetailedReport.DefinedTestParam();
        dtp.observation     = 'onservation';
        dtp.uom             = 'uom';
        dtp.specification   = 'specification';
        dtp.testName        = 'test name';
        dtp.verdict         = 'verdict';
        
    }
}