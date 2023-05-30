@isTest
private class QC_componentCompareCtlrTest{
    static QC_Components__c masterComp;
    static QC_Components__c compCase;
    static QC_Components__c compDial;
    static QC_Components__c compLeather; 
    static QC_Components__c compMetal;
    static QC_Components__c compSpecial;
    static QC_Components__c compBattery;
    static QC_Components__c compModule;
    static QC_Components__c compPackaging;
    static QC_Components__c masterResubmition;
    Static QC_Components__c masterComp1;
    
 
 /*   @testsetup static void commonData(){
        //Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
    }  */
    
    static testMethod void myUnitTest() {
        List<QC_Components__c> allChildComponent = new List<QC_Components__c>();         

        //Inserting parent record
        masterComp = new QC_Components__c(Name__c='Full-Watch',Watch_variant__c='fastrack',No_Of_Sample_Received__c=4, Sample_Category__c = 'Re-submission');
            insert masterComp;
        QC_Master__c master1 = new QC_Master__c(Name='Full-Watch1',Master_Variant__c=masterComp.id);
            insert master1;
        QC_Master__c master2 = new QC_Master__c(Name='Full-Watch2',Master_Variant__c=masterComp.id);
           insert master2;
        QC_Master__c master3 = new QC_Master__c(Name='Full-Watch3',Master_Variant__c=masterComp.id);
           insert master3;
        QC_Master__c master4 = new QC_Master__c(Name='Full-Watch3',Master_Variant__c=masterComp.id);
           insert master4;
        QC_Master__c master5 = new QC_Master__c(Name='Full-Watch3',Master_Variant__c=masterComp.id);
           insert master5;
       // QC_Components__c component1 =[select id,Report_Ref_Number__c from QC_Components__c LIMIT 1];  
       
         id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        // allChildComponent.add(component1);
        QC_Question__c quesFW1 = new QC_Question__c(Question__c= 'Module',Test_Name__c ='test1',Component_Type__c='Full-Watch',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesFW1;
        QC_Response__c res1= new QC_Response__c(Question__c =quesFW1.id ,Response__c ='Digital',Order_Number__c=10);        
        insert res1;
         QC_Input_Data__c inputFW1 = new QC_Input_Data__c(Component_No__c=masterComp.id,Question__c =quesFW1.id,Value__c='Digital');
        insert inputFW1; 
        QC_Condition__c conditionFW1 = new QC_Condition__c(Question__c=quesFW1.id,Response__c=res1.id);
        insert conditionFW1;
        QC_Test_Data__c testListFW1= new QC_Test_Data__c(Condition_Ref__c=conditionFW1.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListFW1;
         QC_Test_Data__c testListFWManual= new QC_Test_Data__c(Condition_Ref__c=conditionFW1.id,Component_Name__c=masterComp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListFWManual;
        
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
       QC_Question__c quesCase = new QC_Question__c(Question__c= 'Material',Component_Type__c='Case',Test_Name__c ='test1',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCase;
       QC_Question__c quesCaseBR = new QC_Question__c(Question__c= 'BR Fitting',Component_Type__c='Case',Test_Name__c ='test1',Order_Number__c = 20,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCaseBR;
       QC_Question__c quesCaseBC = new QC_Question__c(Question__c= 'BC Fitting',Component_Type__c='Case',Test_Name__c ='test1',Order_Number__c = 30,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCaseBC;
       QC_Question__c quesCaseGlass = new QC_Question__c(Question__c= 'Glass Fitting',Component_Type__c='Case',Test_Name__c ='test1',Order_Number__c = 40,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesCaseGlass; 
       
       QC_Question__c quesCS1 = new QC_Question__c(Question__c='Material',Test_Name__c='Material Chemical Composition - Case Center',Onload__c= true,Order_Number__c = 50,Component_Type__c='Case',recordtypeid = rtid);
       insert quesCS1;
       QC_Input_Data__c resC1 = new QC_Input_Data__c(Component_No__c=compCase.id,Question__c =quesCS1.id,Value__c='dsfsdfds');
       inputList.add(resC1);
        
       QC_Question__c quesCS2 = new QC_Question__c(Question__c='Material',Test_Name__c='Plating Layer - Case Center',Onload__c= true,Order_Number__c = 60,Component_Type__c='Case',recordtypeid = rtid);
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
        
         //Inserting Case response  for matal
       QC_Response__c resCaseMatal = new QC_Response__c(Question__c =quesCS1.id ,Response__c ='Material',Order_Number__c=10);        
        insert resCaseMatal;
        
         //Inserting Case response  for plate
       QC_Response__c resCasePlate = new QC_Response__c(Question__c =quesCS2.id ,Response__c ='Material',Order_Number__c=10);        
        insert resCasePlate;
        
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
        QC_Test_Data__c testListCaseManual = new QC_Test_Data__c(Condition_Ref__c=conditionCase.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListCaseManual;  
        // for case material layer
          QC_Condition__c conditionCaseMatal = new QC_Condition__c(Question__c=quesCS1.id,Response__c=resCaseMatal.id);
        insert conditionCaseMatal;
        
         QC_Test_Data__c testListCasematerial = new QC_Test_Data__c(Condition_Ref__c=conditionCaseMatal.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListCasematerial;  
         QC_Test_Data__c testListCasematerialManual = new QC_Test_Data__c(Condition_Ref__c=conditionCaseMatal.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListCasematerialManual;  
            
        // for case plating layer
          QC_Condition__c conditionCasePlate = new QC_Condition__c(Question__c=quesCS2.id,Response__c=resCasePlate.id);
        insert conditionCasePlate;
        
         QC_Test_Data__c testListCaseplate = new QC_Test_Data__c(Condition_Ref__c=conditionCasePlate.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListCaseplate;  
        QC_Test_Data__c testListCaseplateManual = new QC_Test_Data__c(Condition_Ref__c=conditionCasePlate.id,Component_Name__c=compCase.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListCaseplateManual;         
        
        /*
            Inserting Dial
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesDial = new QC_Question__c(Question__c= 'Dial Feature',Component_Type__c='Dial',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Test_Name__c='test1',Comment_Required__c = true,recordtypeid = rtid);
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
        QC_Test_Data__c testListDialManual = new QC_Test_Data__c(Condition_Ref__c=conditionDial.id,Component_Name__c=compDial.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListDialManual;
        
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

                       
        QC_Question__c quesLeather = new QC_Question__c(Question__c= 'Type of strap',Test_Name__c='test1',Component_Type__c='Leather-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
        insert quesLeather;
        QC_Question__c quesLeather1 = new QC_Question__c(Question__c= 'Catch Type',Test_Name__c='test1',Component_Type__c='Leather-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
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
          QC_Test_Data__c testListLeatherManual = new QC_Test_Data__c(Condition_Ref__c=conditionLeather.id,Component_Name__c=compLeather.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListLeatherManual;
        
        /*
            Inserting Metal Strap
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesMetalMaretial = new QC_Question__c(Question__c= 'Material',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Test_Name__c='Material Chemical Composition - Pin',Comment_Required__c = true,recordtypeid = rtid);
        insert quesMetalMaretial;
        QC_Response__c resMetalMaterial = new QC_Response__c(Question__c =quesMetalMaretial.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert resMetalMaterial;
        
        QC_Question__c quesMetalPlate = new QC_Question__c(Question__c= 'Material',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Test_Name__c='Plating Layer - Strap',Comment_Required__c = true,recordtypeid = rtid);
        insert quesMetalPlate;
        QC_Response__c resMetalPlate = new QC_Response__c(Question__c =quesMetalPlate.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert resMetalPlate;
        
        QC_Question__c quesMetal = new QC_Question__c(Question__c= 'Material',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Test_Name__c='test',Comment_Required__c = true,recordtypeid = rtid);
        insert quesMetal;
        QC_Response__c resMetal = new QC_Response__c(Question__c =quesMetal.id ,Response__c ='Ceramic',Order_Number__c=10);        
        insert resMetal;
        
        QC_Question__c quesMetal1 = new QC_Question__c(Question__c= 'Link Construction - Fixed',Test_Name__c='Material Chemical Composition - Pin',Component_Type__c='Metal-Strap',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
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
         QC_Test_Data__c testListMetalManual = new QC_Test_Data__c(Condition_Ref__c=conditionMetal.id,Component_Name__c=compMetal.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListMetalManual;
        
        // for material matal layer
        QC_Condition__c conditionMetalMaterial = new QC_Condition__c(Question__c=quesMetalMaretial.id,Response__c=resMetalMaterial.id);
        insert conditionMetalMaterial;
        
        //Insert test parameter record
        QC_Test_Data__c testListMetalMaterial = new QC_Test_Data__c(Condition_Ref__c=conditionMetalMaterial.id,Component_Name__c=compMetal.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListMetalMaterial;
        QC_Test_Data__c testListMetalMaterialManual = new QC_Test_Data__c(Condition_Ref__c=conditionMetalMaterial.id,Component_Name__c=compMetal.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListMetalMaterialManual;
        
         // for material Plating layer
        QC_Condition__c conditionMetalPlate = new QC_Condition__c(Question__c=quesMetalPlate.id,Response__c=resMetalPlate.id);
        insert conditionMetalPlate;
        
        //Insert test parameter record
        QC_Test_Data__c testListMetalPlate = new QC_Test_Data__c(Condition_Ref__c=conditionMetalPlate.id,Component_Name__c=compMetal.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListMetalPlate;
          QC_Test_Data__c testListMetalPlate1 = new QC_Test_Data__c(Condition_Ref__c=conditionMetalPlate.id,Component_Name__c=compMetal.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListMetalPlate1;
        /*
            Inserting Special Strap
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
         QC_Question__c quesSpecial = new QC_Question__c(Question__c= 'Material',Component_Type__c='Special-Strap',Test_Name__c='test1',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
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
        QC_Test_Data__c testListSpecial = new QC_Test_Data__c(Condition_Ref__c=conditionSpecial.id,Component_Name__c=compSpecial.id,Observation__c='shkfbkhsb',Conclusion__c='Reject');
        insert testListSpecial;
        
        QC_Test_Data__c testListSpecial1 = new QC_Test_Data__c(Condition_Ref__c=conditionSpecial.id,Component_Name__c=compSpecial.id,Observation__c='shkfbkhsb',Conclusion__c='Reject', isManual__c = true);
        insert testListSpecial1;
        
        /*
            Inserting Module
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesModule = new QC_Question__c(Question__c= 'Type of Module',Test_Name__c='test1',Component_Type__c='Module',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
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
        //QC_Test_Data__c testListModule1 = new QC_Test_Data__c(Condition_Ref__c=conditionModule.id,Component_Name__c=compModule.id,Observation__c='shkfbkhsb',Conclusion__c='Accept', isManual__c = true);
        //insert testListModule1;
        
        /*
            Inserting Battery
                1. Questions
                2. Responses
                3. Condition
                4. Input Data
                5. Test Parameters.
        
        */
        QC_Question__c quesBattery = new QC_Question__c(Question__c= 'Battery Type',Test_Name__c='test1',Component_Type__c='Battery',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
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
      QC_Question__c quesPackaging = new QC_Question__c(Question__c= 'Box Type',Test_Name__c='test1',Component_Type__c='Packaging',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
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
        QC_Test_Data__c testListPackaging = new QC_Test_Data__c(Condition_Ref__c=conditionPackaging.id,Component_Name__c=compPackaging.id,Observation__c='shkfbkhsb',Conclusion__c='Accept');
        insert testListPackaging;
          QC_Test_Data__c testListPackaging1 = new QC_Test_Data__c(Condition_Ref__c=conditionPackaging.id,Component_Name__c=compPackaging.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c = true);
        insert testListPackaging1;
        
        QC_componentCompareCtlr qcFullWatchRep           = new QC_componentCompareCtlr();
        qcFullWatchRep.ids1 = masterComp.id;
        qcFullWatchRep.ids2 = masterComp.id;
        qcFullWatchRep.ids3 = masterComp.id;
        qcFullWatchRep.ids4 = masterComp.id;
        qcFullWatchRep.ids5 = masterComp.id;
        qcFullWatchRep.ClickToDownload();
            
        qcFullWatchRep.Master1 = master1;
        qcFullWatchRep.Master2 = master2;
        qcFullWatchRep.Master3 = master3;
        qcFullWatchRep.Master4 = master3;
        qcFullWatchRep.Master5 = master3;
          
        qcFullWatchRep.compare();
        QC_componentCompareCtlr.DefinedParameters  dp    = new QC_componentCompareCtlr.DefinedParameters();
        dp.color            = 'Blue';
        dp.inputParam       = 'input param';
        dp.value            = 'value';
        dp.comment          = 'comment';
        dp.referenceNo      = 'FW/0238/16-17';

        QC_componentCompareCtlr.DefinedTestParam dtp     = new QC_componentCompareCtlr.DefinedTestParam();
        dtp.observation     = 'onservation';
        dtp.spec                = 'uom';
        dtp.specification   = 'specification';
        dtp.testName        = 'test name';
        dtp.verdict         = 'verdict';
        dtp.uom     = 'test';
        dtp.commentAndRemarks= 'test1';
        dtp.reportref= 'FW/0238/16-17';

        
   }
   
}