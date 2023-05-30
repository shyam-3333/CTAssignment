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
private class QC_Document_Status_Email_Comp_WHTest{
    static QC_Components__c masterComp;
    static QC_Components__c compCase;
    static QC_Components__c compDial;
    
    @testsetup static void commonData(){
        //Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
    }
    
    static testMethod void myUnitTest() {
         //Inserting parent record
        masterComp = new QC_Components__c(Name__c='Watch-Head',Sample_Category__c = 'Re-submission',Watch_variant__c='fastrack',No_Of_Sample_Received__c=4);
        insert masterComp;
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        QC_Question__c quesWH1 = new QC_Question__c(Question__c= 'Module',Component_Type__c='Watch-Head',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesWH1;
        QC_Response__c res1= new QC_Response__c(Question__c =quesWH1.id ,Response__c ='Digital',Order_Number__c=10);        
        insert res1;
         QC_Input_Data__c inputWH1 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesWH1.id,Value__c='Digital');
        insert inputWH1; 
        QC_Condition__c conditionWH1 = new QC_Condition__c(Question__c=quesWH1.id,Response__c=res1.id);
        insert conditionWH1;
        QC_Test_Data__c testListWH1= new QC_Test_Data__c(Condition_Ref__c=conditionWH1.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListWH1;
        
        QC_Question__c quesWH3 = new QC_Question__c(Question__c= 'Crown',Component_Type__c='Watch-Head',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesWH3;
        QC_Response__c res3 = new QC_Response__c(Question__c =quesWH3.id ,Response__c ='D Type',Order_Number__c=10);        
        insert res3;
        QC_Input_Data__c inputWH3 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesWH3.id,Value__c='D Type');
        insert inputWH3;
        QC_Condition__c conditionWH3 = new QC_Condition__c(Question__c=quesWH3.id,Response__c=res3.id);
        insert conditionWH3;
        QC_Test_Data__c testListWH3= new QC_Test_Data__c(Condition_Ref__c=conditionWH3.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListWH3;
        
        QC_Question__c quesWH4 = new QC_Question__c(Question__c= 'Provision For Spacer Assembly',Component_Type__c='Full-Watch',Order_Number__c = 10,Onload__c= true,recordtypeid = rtid);
        insert quesWH4;
        QC_Response__c res4 = new QC_Response__c(Question__c =quesWH4.id ,Response__c ='fsdafdsfsd',Order_Number__c=10);        
        insert res4;
        QC_Input_Data__c inputWH4 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesWH4.id,Value__c='sdsdsds');
        insert inputWH4;
        QC_Condition__c conditionWH4 = new QC_Condition__c(Question__c=quesWH4.id,Response__c=res4.id);
        insert conditionWH4;
        QC_Test_Data__c testListWH4= new QC_Test_Data__c(Condition_Ref__c=conditionWH4.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListWH4;
        
        
        //Inserting the child components
        compCase = new QC_Components__c(Parent__c=masterComp.id,Name__c='Case',Watch_variant__c='fastrack');
        insert compCase;
        compDial = new QC_Components__c(Parent__c=masterComp.id,Name__c='Dial',Watch_variant__c='fastrack');
        insert compDial; 
        
        /*
            Inserting Case
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
       */
       //Inserting Case questions
        list<QC_Input_Data__c> inputList = new list<QC_Input_Data__c>();
       QC_Question__c quesCase = new QC_Question__c(Question__c= 'Material',Component_Type__c='Case',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCase;
       QC_Question__c quesCaseBR = new QC_Question__c(Question__c= 'BR Fitting',Component_Type__c='Case',Order_Number__c = 20,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCaseBR;
       QC_Question__c quesCaseBC = new QC_Question__c(Question__c= 'BC Fitting',Component_Type__c='Case',Order_Number__c = 30,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCaseBC;
       QC_Question__c quesCaseGlass = new QC_Question__c(Question__c= 'Glass Fitting',Component_Type__c='Case',Order_Number__c = 40,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCaseGlass; 
       
       QC_Question__c quesCS1 = new QC_Question__c(Question__c='Material Chemical Composition - Case Center',Onload__c= true,Order_Number__c = 50,Component_Type__c='Case',recordtypeid = rtid);
       insert quesCS1;
       QC_Input_Data__c resC1 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS1.id,Value__c='dsfsdfds');
       inputList.add(resC1);
        
       QC_Question__c quesCS2 = new QC_Question__c(Question__c='Material Chemical Composition - Back Cover',Onload__c= true,Order_Number__c = 60,Component_Type__c='Case',recordtypeid = rtid);
       insert quesCS2;
       QC_Input_Data__c resC2 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS2.id,Value__c='dsfsdfds');
       inputList.add(resC2);
       
       QC_Question__c quesCS3 = new QC_Question__c(Question__c='Material Chemical Composition - Bezel Ring',Onload__c= true,Order_Number__c = 70,Component_Type__c='Case',recordtypeid = rtid);
       insert quesCS3;
       QC_Input_Data__c resC3 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS3.id,Value__c='dsfsdfds');
       inputList.add(resC3);
       
       QC_Question__c quesCS4 = new QC_Question__c(Question__c='Decorative Ring',Component_Type__c='Case',Onload__c= true,Order_Number__c = 80,recordtypeid = rtid);
       insert quesCS4;
       QC_Input_Data__c resC4 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS4.id,Value__c='dsfsdfds');
       inputList.add(resC4);
       
       QC_Question__c quesCS5 = new QC_Question__c(Question__c='Push Button',Component_Type__c='Case',Onload__c= true,Order_Number__c = 90,recordtypeid = rtid);
       insert quesCS5;
       QC_Input_Data__c resC5 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS5.id,Value__c='dsfsdfds');
       inputList.add(resC5);
       
       QC_Question__c quesCS6 = new QC_Question__c(Question__c= 'Material Chemical Composition - Screw',Onload__c= true,Order_Number__c = 100,Component_Type__c='Case',recordtypeid = rtid);  
       insert quesCS6;
       QC_Input_Data__c resC6 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS6.id,Value__c='dsfsdfds');
       inputList.add(resC6);
       
       QC_Question__c quesCS7 = new QC_Question__c(Question__c='Material Chemical Composition - Crown',Onload__c= true,Order_Number__c = 110,Component_Type__c='Case',recordtypeid = rtid);      
       insert quesCS7;
       QC_Input_Data__c resC7 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS7.id,Value__c='dsfsdfds');
       inputList.add(resC7);
       
       //Inserting Case response
       QC_Response__c resCase = new QC_Response__c(Question__c =quesCase.id ,Response__c ='Material',Order_Number__c=10);        
        insert resCase;
        
        //Inserting input data - case       
       
        QC_Input_Data__c inputMaterialCase = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCase.id,Value__c='Ceramic');
        inputList.add(inputMaterialCase);
        QC_Input_Data__c inputBCCase = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCaseBC.id,Value__c='Hook');
        inputList.add(inputBCCase);
        
        QC_Input_Data__c inputBCCase1 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCaseBC.id,Value__c='Thread');
        inputList.add(inputBCCase1);
        
        QC_Input_Data__c inputBRCase = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCaseBR.id,Value__c='Snap');
        inputList.add(inputBRCase);
        
        QC_Input_Data__c inputGlassCase = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCaseBR.id,Value__c='Gasket');
        inputList.add(inputGlassCase);
        insert inputList;
        
        QC_Input_Data__c sampleCase = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCaseBR.id,Value__c='Gasket');
        insert sampleCase;
        //Insert Condition record - case
        QC_Condition__c conditionCase = new QC_Condition__c(Question__c=quesCase.id,Response__c=resCase.id);
        insert conditionCase;
        //Insert test parameter record - case
        QC_Test_Data__c testListCase = new QC_Test_Data__c(Condition_Ref__c=conditionCase.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='False');
        insert testListCase;
        
        /*
            Inserting Dial
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesDial = new QC_Question__c(Question__c= 'Dial Feature',Component_Type__c='Dial',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesDial;
       //inserting question responses
        QC_Response__c resDial = new QC_Response__c(Question__c =quesDial.id ,Response__c ='Material',Order_Number__c=10);        
        insert resDial;
         //Insert input parameters
        QC_Input_Data__c inputMaterialDial = new QC_Input_Data__c(Component_No__c=compDial.id,Question__c =quesDial.id,Value__c='Brass');
        insert inputMaterialDial;
        
        QC_Condition__c conditionDial = new QC_Condition__c(Question__c=quesDial.id,Response__c=resDial.id);
        insert conditionDial;
        
        //Insert test parameter record
        QC_Test_Data__c testListDial = new QC_Test_Data__c(Condition_Ref__c=conditionDial.id,Component_Name__c=compDial.id,Observation__c='shkfbkhsb',Conclusion__c='Reject');
        insert testListDial;
        
   
        
        QC_Document_Status_Email_Comp_WH qcFullWatchRep           = new QC_Document_Status_Email_Comp_WH();
         qcFullWatchRep.compId = masterComp.Id;
        qcFullWatchRep.getComponent();  
        
        QC_Document_Status_Email_Comp_WH.DefinedParameters  dp    = new QC_Document_Status_Email_Comp_WH.DefinedParameters();
        dp.color            = 'Blue';
        dp.inputParam       = 'input param';
        dp.value            = 'value';
    //    dp.commentWatchHead = 'sdfsadsa';
        QC_Document_Status_Email_Comp_WH.DefinedTestParam dtp     = new QC_Document_Status_Email_Comp_WH.DefinedTestParam();
        dtp.observation     = 'onservation';
        dtp.specification   = 'specification';
        dtp.testName        = 'test name';
        dtp.verdict         = 'verdict';
     //   new QC_Document_Status_Email_Comp_WH().getComponent();
     	QC_Document_Status_Email_Comp_WH testC= new QC_Document_Status_Email_Comp_WH();
        testC.testcover();
    }
}