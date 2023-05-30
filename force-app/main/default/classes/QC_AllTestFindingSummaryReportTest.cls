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
private class QC_AllTestFindingSummaryReportTest {
    static QC_Components__c masterComp;
    static QC_Components__c compCase;
    static QC_Components__c compDial;
    static QC_Components__c compLeather; 
    static QC_Components__c compMetal;
    static QC_Components__c compSpecial;
    static QC_Components__c compBattery;
    static QC_Components__c compModule;
    static QC_Components__c compPackaging;

    
    static testMethod void myUnitTest() {
       
        List<QC_Component_Prefix__c> listCus = new List<QC_Component_Prefix__c>();
        listCus.add(new QC_Component_Prefix__c(name='BT',Sequence_Number__c='0004'));
        listCus.add(new QC_Component_Prefix__c(name='CA',Sequence_Number__c='0050'));
        listCus.add(new QC_Component_Prefix__c(name='DL',Sequence_Number__c='0041'));
        listCus.add(new QC_Component_Prefix__c(name='FMA',Sequence_Number__c='0035'));
        listCus.add(new QC_Component_Prefix__c(name='FW',Sequence_Number__c='0119'));
        listCus.add(new QC_Component_Prefix__c(name='LS',Sequence_Number__c='0022'));
        listCus.add(new QC_Component_Prefix__c(name='MS',Sequence_Number__c='0016'));
        listCus.add(new QC_Component_Prefix__c(name='PA',Sequence_Number__c='0016'));
        listCus.add(new QC_Component_Prefix__c(name='WH',Sequence_Number__c='0019'));
        insert listCus;
        //Inserting parent record
        
        masterComp = new QC_Components__c(Name__c='Full-Watch',Watch_variant__c='fastrack',Sample_Category__c = 'Re-submission' ,No_Of_Sample_Received__c=4);
        insert masterComp;
         id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
         
        QC_Question__c quesFW1 = new QC_Question__c(Question__c= 'Module',Component_Type__c='Full-Watch',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesFW1;
        QC_Response__c res1= new QC_Response__c(Question__c =quesFW1.id ,Response__c ='Digital',Order_Number__c=10);        
        insert res1;
         QC_Input_Data__c inputFW1 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesFW1.id,Value__c='Digital');
        insert inputFW1; 
        QC_Condition__c conditionFW1 = new QC_Condition__c(Question__c=quesFW1.id,Response__c=res1.id);
        insert conditionFW1;
        QC_Test_Data__c testListFW1= new QC_Test_Data__c(Condition_Ref__c=conditionFW1.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListFW1;
        
        QC_Question__c quesFW2 = new QC_Question__c(Question__c= 'Case to Strap',Component_Type__c='Full-Watch',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesFW2;
        QC_Response__c res2 = new QC_Response__c(Question__c =quesFW2.id ,Response__c ='Screw',Order_Number__c=10);        
        insert res2;
         QC_Input_Data__c inputFW2 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesFW2.id,Value__c='Screw');
        insert inputFW2;
         QC_Condition__c conditionFW2 = new QC_Condition__c(Question__c=quesFW2.id,Response__c=res2.id);
        insert conditionFW2;
        QC_Test_Data__c testListFW2= new QC_Test_Data__c(Condition_Ref__c=conditionFW2.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c =true);
        insert testListFW2;
        
        QC_Question__c quesFW3 = new QC_Question__c(Question__c= 'Crown',Component_Type__c='Full-Watch',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesFW3;
        QC_Response__c res3 = new QC_Response__c(Question__c =quesFW3.id ,Response__c ='D Type',Order_Number__c=10);        
        insert res3;
        QC_Input_Data__c inputFW3 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesFW3.id,Value__c='D Type');
        insert inputFW3;
        QC_Condition__c conditionFW3 = new QC_Condition__c(Question__c=quesFW3.id,Response__c=res3.id);
        insert conditionFW3;
        QC_Test_Data__c testListFW3= new QC_Test_Data__c(Condition_Ref__c=conditionFW3.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListFW3;
        
        QC_Question__c quesFW4 = new QC_Question__c(Question__c= 'Provision For Spacer Assembly',Component_Type__c='Full-Watch',Order_Number__c = 10,Onload__c= true,recordtypeid = rtid);
        insert quesFW4;
        QC_Response__c res4 = new QC_Response__c(Question__c =quesFW4.id ,Response__c ='fsdafdsfsd',Order_Number__c=10);        
        insert res4;
        QC_Input_Data__c inputFW4 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesFW4.id,Value__c='sdsdsds');
        insert inputFW4;
        QC_Condition__c conditionFW4 = new QC_Condition__c(Question__c=quesFW4.id,Response__c=res4.id);
        insert conditionFW4;
        QC_Test_Data__c testListFW4= new QC_Test_Data__c(Condition_Ref__c=conditionFW4.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListFW4;

        
        //Inserting all the child components
        compCase = new QC_Components__c(Parent__c=masterComp.id,Name__c='Case',Watch_variant__c='fastrack');
        insert compCase;
        compDial = new QC_Components__c(Parent__c=masterComp.id,Name__c='Dial',Watch_variant__c='fastrack');
        insert compDial;
        compLeather = new QC_Components__c(Parent__c=masterComp.id,Name__c='Leather-Strap',Watch_variant__c='fastrack');
        insert compLeather;
        compMetal = new QC_Components__c(Parent__c=masterComp.id,Name__c='Metal-Strap',Watch_variant__c='fastrack');
        insert compMetal;
        compSpecial = new QC_Components__c(Parent__c=masterComp.id,Name__c='Special-Strap',Watch_variant__c='fastrack');
        insert compSpecial;
        compBattery = new QC_Components__c(Parent__c=masterComp.id,Name__c='Battery',Watch_variant__c='fastrack');
        insert compBattery;
        compModule = new QC_Components__c(Parent__c=masterComp.id,Name__c='Module',Watch_variant__c='fastrack');
        insert compModule;
        compPackaging = new QC_Components__c(Parent__c=masterComp.id,Name__c='Packaging',Watch_variant__c='fastrack');
        insert compPackaging;
        
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
        QC_Test_Data__c testListCase = new QC_Test_Data__c(Condition_Ref__c=conditionCase.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
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
        QC_Test_Data__c testListDial = new QC_Test_Data__c(Condition_Ref__c=conditionDial.id,Component_Name__c=compDial.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListDial;
        
        /*
            Inserting Leather Strap
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
    //   if(each.Question__r.Question__c == 'Type of strap' && each.Value__c == 'Cut Edge strap - with out stritch' && (brandName =='XYLYS' || brandName =='Nebula')){
    //     (each.Question__r.Question__c == 'Catch Type' && (each.Value__c == 'Curved'  || each.Value__c == 'Integrated') && brandName =='Sonata'){    

                       
        QC_Question__c quesLeather = new QC_Question__c(Question__c= 'Type of strap',Component_Type__c='Leather-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesLeather;
        QC_Question__c quesLeather1 = new QC_Question__c(Question__c= 'Catch Type',Component_Type__c='Leather-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesLeather1;
       //inserting question responses
        QC_Response__c resLeather = new QC_Response__c(Question__c =quesLeather.id ,Response__c ='Flat',Order_Number__c=10);        
        insert resLeather;
         //Insert input parameters
        QC_Input_Data__c inputMaterialLeather = new QC_Input_Data__c(Component_No__c=compLeather.id,Question__c =quesLeather.id,Value__c='Cut Edge strap - with out stritch');
        insert inputMaterialLeather;
        
        QC_Condition__c conditionLeather = new QC_Condition__c(Question__c=quesLeather.id,Response__c=resLeather.id);
        insert conditionLeather;
        
        //Insert test parameter record
        QC_Test_Data__c testListLeather = new QC_Test_Data__c(Condition_Ref__c=conditionLeather.id,Component_Name__c=compLeather.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListLeather;
        
        /*
            Inserting Metal Strap
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesMetal = new QC_Question__c(Question__c= 'Material',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesMetal;
        QC_Response__c resMetal = new QC_Response__c(Question__c =quesMetal.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert resMetal;
        
        QC_Question__c quesMetal1 = new QC_Question__c(Question__c= 'Fixed Link Joint',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesMetal1;
        QC_Response__c resMetal1 = new QC_Response__c(Question__c =quesMetal1.id ,Response__c ='Curved',Order_Number__c=10);        
        insert resMetal1;
        
        QC_Question__c quesMetal2 = new QC_Question__c(Question__c= 'Type of Clasp',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesMetal2;
        QC_Response__c resMetal2 = new QC_Response__c(Question__c =quesMetal2.id ,Response__c ='Sliding',Order_Number__c=10);        
        insert resMetal2;
        QC_Response__c resMetal3 = new QC_Response__c(Question__c =quesMetal2.id ,Response__c ='Jewellery',Order_Number__c=10);        
        insert resMetal3;
        
         //Insert input parameters
        QC_Input_Data__c inputMaterialMetal = new QC_Input_Data__c(Component_No__c=compMetal.id,Question__c =quesMetal.id,Value__c='Ceramic');
        insert inputMaterialMetal;
        
        QC_Condition__c conditionMetal = new QC_Condition__c(Question__c=quesMetal.id,Response__c=resMetal.id);
        insert conditionMetal;
        
        //Insert test parameter record
        QC_Test_Data__c testListMetal = new QC_Test_Data__c(Condition_Ref__c=conditionMetal.id,Component_Name__c=compMetal.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListMetal;
        
        /*
            Inserting Special Strap
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
         QC_Question__c quesSpecial = new QC_Question__c(Question__c= 'Material',Component_Type__c='Special-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesSpecial;
       //inserting question responses
        QC_Response__c resSpecial = new QC_Response__c(Question__c =quesSpecial.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert resSpecial;
         //Insert input parameters
        QC_Input_Data__c inputMaterialSpecial = new QC_Input_Data__c(Component_No__c=compSpecial.id,Question__c =quesSpecial.id,Value__c='Ceramic');
        insert inputMaterialSpecial;
        
        QC_Condition__c conditionSpecial = new QC_Condition__c(Question__c=quesSpecial.id,Response__c=resSpecial.id);
        insert conditionSpecial;
        
        //Insert test parameter record
        QC_Test_Data__c testListSpecial = new QC_Test_Data__c(Condition_Ref__c=conditionSpecial.id,Component_Name__c=compSpecial.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListSpecial;
        
        /*
            Inserting Module
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesModule = new QC_Question__c(Question__c= 'Type of Module',Component_Type__c='Module',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesModule;
       //inserting question responses
        QC_Response__c resModule = new QC_Response__c(Question__c =quesModule.id ,Response__c ='Digital',Order_Number__c=10);        
        insert resModule;
         //Insert input parameters
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=compModule.id,Question__c =quesModule.id,Value__c='Digital');
        insert inputMaterial;
        
        QC_Condition__c conditionModule = new QC_Condition__c(Question__c=quesModule.id,Response__c=resModule.id);
        insert conditionModule;
        
        //Insert test parameter record
        QC_Test_Data__c testListModule = new QC_Test_Data__c(Condition_Ref__c=conditionModule.id,Component_Name__c=compModule.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListModule;
        
        /*
            Inserting Battery
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesBattery = new QC_Question__c(Question__c= 'Battery Type',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesBattery;
       //inserting question responses
        QC_Response__c resBattery = new QC_Response__c(Question__c =quesBattery.id ,Response__c ='Low Drain',Order_Number__c=10);        
        insert resBattery;
         //Insert input parameters
        QC_Input_Data__c inputMaterialBattery = new QC_Input_Data__c(Component_No__c=compBattery.id,Question__c =quesBattery.id,Value__c='Low Drain');
        insert inputMaterialBattery;
        
        QC_Condition__c conditionBattery = new QC_Condition__c(Question__c=quesBattery.id,Response__c=resBattery.id);
        insert conditionBattery;
        
        //Insert test parameter record
        QC_Test_Data__c testListBattery = new QC_Test_Data__c(Condition_Ref__c=conditionBattery.id,Component_Name__c=compBattery.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListBattery;
        
        /*
            Inserting Packaging
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesPackaging = new QC_Question__c(Question__c= 'Box Type',Component_Type__c='Packaging',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesPackaging;
       //inserting question responses
        QC_Response__c resPackaging = new QC_Response__c(Question__c =quesPackaging.id ,Response__c ='IBD',Order_Number__c=10);        
        insert resPackaging;
         //Insert input parameters
        QC_Input_Data__c inputMaterialPackaging = new QC_Input_Data__c(Component_No__c=compPackaging.id,Question__c =quesPackaging.id,Value__c='IBD');
        insert inputMaterialPackaging;
        
        QC_Condition__c conditionPackaging = new QC_Condition__c(Question__c=quesPackaging.id,Response__c=resPackaging.id);
        insert conditionPackaging;
        
        //Insert test parameter record
        QC_Test_Data__c testListPackaging = new QC_Test_Data__c(Condition_Ref__c=conditionPackaging.id,Component_Name__c=compPackaging.id,Observation__c='shkfbkhsb',Conclusion__c='Reject');
        insert testListPackaging;
        
        
        PageReference pageRef = Page.QC_AllTestFindingSummaryReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',masterComp.id);
        
        QC_AllTestFindingSummaryReport qcFullWatchRep           = new QC_AllTestFindingSummaryReport();
        qcFullWatchRep.firstActorName = 'avinash';
        qcFullWatchRep.secondActorName = 'anin';
        
        QC_AllTestFindingSummaryReport.DefinedTestParam dtp     = new QC_AllTestFindingSummaryReport.DefinedTestParam();
        dtp.observation     = 'onservation';
        dtp.UOM                = 'uom';
        dtp.specification   = 'specification';
        dtp.testName        = 'test name';
        dtp.commentAndRemarks =  'comments';
        dtp.verdict         = 'verdict';
   }
   
}