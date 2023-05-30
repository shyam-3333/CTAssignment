public with sharing class QC_componentCompareCtlr {
            public id ids1{get;set;}
            public id ids2{get;set;}
            public id ids3{get;set;}
            public id ids4{get;set;}
            public id ids5{get;set;}
            public List<id> listId{get;set;}
            public String IdString{get;set;}
            public id comId1{get;set;}
            public id comId2{get;set;}
            public id comId3{get;set;}
            public id comId4{get;set;}
            public id comId5{get;set;}
            public integer size{get;set;}
            
            public Map<String,DefinedTestParam>       allFWTestData{get;set;}
            public List<DefinedTestParam>             allFWTestDataC{get;set;}
            public Map<String,DefinedTestParam>       allCaseTestData{get;set;}
            public List<DefinedTestParam>             allCaseTestDataC{get;set;}
            public Map<String,DefinedTestParam>       allCaseTestDataP{get;set;}   // for plating layer
            public List<DefinedTestParam>             allCaseTestDataPC{get;set;}   // for plating layer
            public Map<String,DefinedTestParam>       allCaseTestDataM{get;set;}   //  for metal Strap
            public List<DefinedTestParam>             allCaseTestDataMC{get;set;}   //  for metal Strap

            public Map<String,DefinedTestParam>       allDialTestData{get;set;}
            public List<DefinedTestParam>             allDialTestDataC{get;set;}
            public Map<String,DefinedTestParam>       allMatalTestData{get;set;}
            public List<DefinedTestParam>             allMatalTestDataC{get;set;}
            public Map<String,DefinedTestParam>       allMatalTestDataM{get;set;}
            public List<DefinedTestParam>             allMatalTestDataMC{get;set;}
            public Map<String,DefinedTestParam>       allMatalTestDataP{get;set;}
            public List<DefinedTestParam>             allMatalTestDataPC{get;set;}
            public Map<String,DefinedTestParam>       allLeatherTestData{get;set;}
            public List<DefinedTestParam>             allLeatherTestDataC{get;set;}
            public Map<String,DefinedTestParam>       allSpecialTestData{get;set;}
            public List<DefinedTestParam>             allSpecialTestDataC{get;set;}
            public Map<String,DefinedTestParam>       allPackageTestData{get;set;}
            public List<DefinedTestParam>             allPackageTestDataC{get;set;}


            public List<DefinedTestParam> FWTestParameter1{get;set;}     
            public List<DefinedTestParam> FWTestParameter2{get;set;}
            public List<DefinedTestParam> FWTestParameter3{get;set;}
            public List<DefinedTestParam> FWTestParameter4{get;set;}
            public List<DefinedTestParam> FWTestParameter5{get;set;}
            
            public List<DefinedTestParam> CaseTestParameter1{get;set;}    // for case test parameter excluding Metal and Plating
            public List<DefinedTestParam> CaseTestParameter2{get;set;}
            public List<DefinedTestParam> CaseTestParameter3{get;set;}
            public List<DefinedTestParam> CaseTestParameter4{get;set;}
            public List<DefinedTestParam> CaseTestParameter5{get;set;}
            
            public List<DefinedTestParam> CaseTestParameterP1{get;set;}     // for case Plating layer  test parameter
            public List<DefinedTestParam> CaseTestParameterP2{get;set;}
            public List<DefinedTestParam> CaseTestParameterP3{get;set;}
            public List<DefinedTestParam> CaseTestParameterP4{get;set;}
            public List<DefinedTestParam> CaseTestParameterP5{get;set;}
            
            public List<DefinedTestParam> CaseTestParameterM1{get;set;}    //  for metal plating layer test parameter for case
            public List<DefinedTestParam> CaseTestParameterM2{get;set;}
            public List<DefinedTestParam> CaseTestParameterM3{get;set;}
            public List<DefinedTestParam> CaseTestParameterM4{get;set;}
            public List<DefinedTestParam> CaseTestParameterM5{get;set;}
            
            public List<DefinedTestParam> DialTestParameter1{get;set;}    // for Dial test parameter 
            public List<DefinedTestParam> DialTestParameter2{get;set;}
            public List<DefinedTestParam> DialTestParameter3{get;set;}
            public List<DefinedTestParam> DialTestParameter4{get;set;}
            public List<DefinedTestParam> DialTestParameter5{get;set;}
            
            public List<DefinedTestParam> MatalTestParameter1{get;set;}    // for metal test parameter excluding Metal and Plating
            public List<DefinedTestParam> MatalTestParameter2{get;set;}
            public List<DefinedTestParam> MatalTestParameter3{get;set;}
            public List<DefinedTestParam> MatalTestParameter4{get;set;}
            public List<DefinedTestParam> MatalTestParameter5{get;set;}
            
            public List<DefinedTestParam> MatalTestParameterM1{get;set;}     // for metal meterial Plating layer  test parameter
            public List<DefinedTestParam> MatalTestParameterM2{get;set;}
            public List<DefinedTestParam> MatalTestParameterM3{get;set;}
            public List<DefinedTestParam> MatalTestParameterM4{get;set;}
            public List<DefinedTestParam> MatalTestParameterM5{get;set;}
            
            public List<DefinedTestParam> MatalTestParameterP1{get;set;}    //  for  metal metal plating layer test parameter
            public List<DefinedTestParam> MatalTestParameterP2{get;set;}
            public List<DefinedTestParam> MatalTestParameterP3{get;set;}
            public List<DefinedTestParam> MatalTestParameterP4{get;set;}
            public List<DefinedTestParam> MatalTestParameterP5{get;set;}
            
            public List<DefinedTestParam> leatherTestParameter1{get;set;}    // for Leather test parameter 
            public List<DefinedTestParam> leatherTestParameter2{get;set;}
            public List<DefinedTestParam> leatherTestParameter3{get;set;}
            public List<DefinedTestParam> leatherTestParameter4{get;set;}
            public List<DefinedTestParam> leatherTestParameter5{get;set;}
            
            public List<DefinedTestParam> specialTestParameter1{get;set;}    // for special test parameter
            public List<DefinedTestParam> specialTestParameter2{get;set;}
            public List<DefinedTestParam> specialTestParameter3{get;set;}
            public List<DefinedTestParam> specialTestParameter4{get;set;}
            public List<DefinedTestParam> specialTestParameter5{get;set;}
            
            public List<DefinedTestParam> packageParameter1{get;set;}    // for special test parameter
            public List<DefinedTestParam> packageParameter2{get;set;}
            public List<DefinedTestParam> packageParameter3{get;set;}
            public List<DefinedTestParam> packageParameter4{get;set;}
            public List<DefinedTestParam> packageParameter5{get;set;}


            public set<String> allFWQuestion{get;set;}
            public set<String> allCaseQuestion{get;set;}
            public set<String> allDialQuestion{get;set;}
            public set<String> allMetalQuestion{get;set;}
            public set<String> allLeatherQuestion{get;set;}
            public set<String> allSpecialQuestion{get;set;}
            public set<String> allPackageQuestion{get;set;} 
            public set<String> allModuleQuestion{get;set;} 
            public set<String> allBatteryQuestion{get;set;} 


            public List<String> FWQuestion1{get;set;}
            public List<String> FWQuestion2{get;set;}
            public List<String> FWQuestion3{get;set;}
            public List<String> FWQuestion4{get;set;}
            public List<String> FWQuestion5{get;set;}

            public List<String> CaseQuestion1{get;set;}
            public List<String> CaseQuestion2{get;set;}
            public List<String> CaseQuestion3{get;set;}
            public List<String> CaseQuestion4{get;set;}
            public List<String> CaseQuestion5{get;set;}

            public List<String> DialQuestion1{get;set;}
            public List<String> DialQuestion2{get;set;}
            public List<String> DialQuestion3{get;set;}
            public List<String> DialQuestion4{get;set;}
            public List<String> DialQuestion5{get;set;}
            
            public List<String> MetalQuestion1{get;set;}
            public List<String> MetalQuestion2{get;set;}
            public List<String> MetalQuestion3{get;set;}
            public List<String> MetalQuestion4{get;set;}
            public List<String> MetalQuestion5{get;set;}
            
            public List<String> LeatherQuestion1{get;set;}
            public List<String> LeatherQuestion2{get;set;}
            public List<String> LeatherQuestion3{get;set;}
            public List<String> LeatherQuestion4{get;set;}
            public List<String> LeatherQuestion5{get;set;}
            
            public List<String> SpecialQuestion1{get;set;}
            public List<String> SpecialQuestion2{get;set;}
            public List<String> SpecialQuestion3{get;set;}
            public List<String> SpecialQuestion4{get;set;}
            public List<String> SpecialQuestion5{get;set;}
            
             public List<String> packageQuestion1{get;set;}
            public List<String> packageQuestion2{get;set;}
            public List<String> packageQuestion3{get;set;}
            public List<String> packageQuestion4{get;set;}
            public List<String> packageQuestion5{get;set;}
            
            public List<String> moduleQuestion1{get;set;}
            public List<String> moduleQuestion2{get;set;}
            public List<String> moduleQuestion3{get;set;}
            public List<String> moduleQuestion4{get;set;}
            public List<String> moduleQuestion5{get;set;}
            
             public List<String> battreyQuestion1{get;set;}
            public List<String> battreyQuestion2{get;set;}
            public List<String> battreyQuestion3{get;set;}
            public List<String> battreyQuestion4{get;set;}
            public List<String> battreyQuestion5{get;set;}
          
          public Integer rowLenghtSize{get;set;}
          public QC_Master__c Master1       {get;set;}     // store id of QC COmponent
          public QC_Master__c Master2       {get;set;}
          public QC_Master__c Master3       {get;set;}
          public QC_Master__c Master4       {get;set;}
          public QC_Master__c Master5       {get;set;}
          public Boolean clickDownload              {get;set;}
          public List<String> reportReferenceNo    {get;set;}
          public List<QC_Components__c> component {get;set;}         //Parent component
          public QC_Components__c component1{get;set;}   // component1
          public QC_Components__c component2{get;set;}   // component2
          public QC_Components__c component3{get;set;}   // component3
          public QC_Components__c component4{get;set;}   // compunent4
          public QC_Components__c component5{get;set;}    // component5

          public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records of component
          public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records   
         
          
          public class DefinedParameters {    
                public String inputParam{get;set;}          //String variable to hold the input question
                public String value{get;set;}               //String variable to hold the input response
                public String color{get;set;}
                public String comment{get;set;}
                public String referenceNo{get;set;}
          }
          public class DefinedTestParam {
                public String uom{get;set;}                //String variable to hold the test specification value
                public String spec{get;set;}                //String variable to hold the test specification value
                public String testName{get;set;}            //String variable to hold the test name value
                public String specification{get;set;}       //String variable to hold the test specification value
                public String observation{get;set;}         //String variable to hold the test observation value
                public String verdict{get;set;}             //String variable to hold the test verdict value     
                public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value   
                public String reportref{get;set;}
         }   

          public List<DefinedParameters> caseInputList1{get;set;}
          public List<DefinedParameters> caseInputList2{get;set;}
          public List<DefinedParameters> caseInputList3{get;set;}
          public List<DefinedParameters> caseInputList4{get;set;}
          public List<DefinedParameters> caseInputList5{get;set;}

          public List<DefinedParameters> dialInputList1{get;set;}
          public List<DefinedParameters> dialInputList2{get;set;}
          public List<DefinedParameters> dialInputList3{get;set;}
          public List<DefinedParameters> dialInputList4{get;set;}
          public List<DefinedParameters> dialInputList5{get;set;}

          public List<DefinedParameters> metalInputList1{get;set;}
          public List<DefinedParameters> metalInputList2{get;set;}
          public List<DefinedParameters> metalInputList3{get;set;}
          public List<DefinedParameters> metalInputList4{get;set;}
          public List<DefinedParameters> metalInputList5{get;set;}

          public List<DefinedParameters> leatherInputList1{get;set;}
          public List<DefinedParameters> leatherInputList2{get;set;}
          public List<DefinedParameters> leatherInputList3{get;set;}
          public List<DefinedParameters> leatherInputList4{get;set;}
          public List<DefinedParameters> leatherInputList5{get;set;}

          public List<DefinedParameters> specialInputList1{get;set;}
          public List<DefinedParameters> specialInputList2{get;set;}
          public List<DefinedParameters> specialInputList3{get;set;}
          public List<DefinedParameters> specialInputList4{get;set;}
          public List<DefinedParameters> specialInputList5{get;set;}
          
          public List<DefinedParameters> packageInputList1{get;set;}
          public List<DefinedParameters> packageInputList2{get;set;}
          public List<DefinedParameters> packageInputList3{get;set;}
          public List<DefinedParameters> packageInputList4{get;set;}
          public List<DefinedParameters> packageInputList5{get;set;}
          
          public List<DefinedParameters> ModuleInputList1{get;set;}
          public List<DefinedParameters> ModuleInputList2{get;set;}
          public List<DefinedParameters> ModuleInputList3{get;set;}
          public List<DefinedParameters> ModuleInputList4{get;set;}
          public List<DefinedParameters> ModuleInputList5{get;set;}
          
          public List<DefinedParameters> BatteryInputList1{get;set;}
          public List<DefinedParameters> BatteryInputList2{get;set;}
          public List<DefinedParameters> BatteryInputList3{get;set;}
          public List<DefinedParameters> BatteryInputList4{get;set;}
          public List<DefinedParameters> BatteryInputList5{get;set;}
          
          

          public List<DefinedParameters> fwInputList1{get;set;}
          public List<DefinedParameters> fwInputList2{get;set;}
          public List<DefinedParameters> fwInputList3{get;set;}
          public List<DefinedParameters> fwInputList4{get;set;}
          public List<DefinedParameters> fwInputList5{get;set;}

          
           public List<DefinedTestParam> caseTestParamList1{get;set;}           //List to hold the Case test parameter
           public List<DefinedTestParam> caseTestParamList2{get;set;}           //List to hold the Case test parameter
           public List<DefinedTestParam> caseTestParamList3{get;set;}           //List to hold the Case test parameter
           public List<DefinedTestParam> caseTestParamList4{get;set;}           //List to hold the Case test parameter
           public List<DefinedTestParam> caseTestParamList5{get;set;}           //List to hold the Case test parameter

           public List<DefinedTestParam> dialTestParamList1{get;set;}           //List to hold the Dial test parameter
           public List<DefinedTestParam> dialTestParamList2{get;set;}           //List to hold the Dial test parameter
           public List<DefinedTestParam> dialTestParamList3{get;set;}           //List to hold the Dial test parameter
           public List<DefinedTestParam> dialTestParamList4{get;set;}           //List to hold the Dial test parameter
           public List<DefinedTestParam> dialTestParamList5{get;set;}           //List to hold the Dial test parameter

           public List<DefinedTestParam> leatherTestParamList1{get;set;}        //List to hold the Leather Strap test parameter
           public List<DefinedTestParam> leatherTestParamList2{get;set;}        //List to hold the Leather Strap test parameter
           public List<DefinedTestParam> leatherTestParamList3{get;set;}        //List to hold the Leather Strap test parameter
           public List<DefinedTestParam> leatherTestParamList4{get;set;}        //List to hold the Leather Strap test parameter
           public List<DefinedTestParam> leatherTestParamList5{get;set;}        //List to hold the Leather Strap test parameter

           public List<DefinedTestParam> specialStrapTestParam1{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> specialStrapTestParam2{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> specialStrapTestParam3{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> specialStrapTestParam4{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> specialStrapTestParam5{get;set;}       //List to hold the Special Strap test parameter
           
           public List<DefinedTestParam> packageTestParam1{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> packageTestParam2{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> packageTestParam3{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> packageTestParam4{get;set;}       //List to hold the Special Strap test parameter
           public List<DefinedTestParam> packageTestParam5{get;set;}       //List to hold the Special Strap test parameter

           
           
           public List<DefinedTestParam> metalTestParamList1{get;set;}          //List to hold the Metal Strap test parameter
           public List<DefinedTestParam> metalTestParamList2{get;set;}          //List to hold the Metal Strap test parameter
           public List<DefinedTestParam> metalTestParamList3{get;set;}          //List to hold the Metal Strap test parameter
           public List<DefinedTestParam> metalTestParamList4{get;set;}          //List to hold the Metal Strap test parameter
           public List<DefinedTestParam> metalTestParamList5{get;set;}          //List to hold the Metal Strap test parameter

           public list<DefinedTestParam> fullWatchTestParamList1{get;set;}      //List to hold the Full Watch test parameter    
           public list<DefinedTestParam> fullWatchTestParamList2{get;set;}      //List to hold the Full Watch test parameter 
           public list<DefinedTestParam> fullWatchTestParamList3{get;set;}      //List to hold the Full Watch test parameter    
           public list<DefinedTestParam> fullWatchTestParamList4{get;set;}      //List to hold the Full Watch test parameter    
           public list<DefinedTestParam> fullWatchTestParamList5{get;set;}      //List to hold the Full Watch test parameter    
           
           Public List<DefinedTestParam> caseTestParamListM1{get;set;}        //List to hold Case Material  parameter
           Public List<DefinedTestParam> caseTestParamListM2{get;set;}        //List to hold Case Material  parameter
           Public List<DefinedTestParam> caseTestParamListM3{get;set;}        //List to hold Case Material  parameter
           Public List<DefinedTestParam> caseTestParamListM4{get;set;}        //List to hold Case Material  parameter
           Public List<DefinedTestParam> caseTestParamListM5{get;set;}        //List to hold Case Material  parameter

           Public List<DefinedTestParam> caseTestParamListP1{get;set;}         // list to hold plating parameter
           Public List<DefinedTestParam> caseTestParamListP2{get;set;}         // list to hold plating parameter
           Public List<DefinedTestParam> caseTestParamListP3{get;set;}         // list to hold plating parameter
           Public List<DefinedTestParam> caseTestParamListP4{get;set;}         // list to hold plating parameter
           Public List<DefinedTestParam> caseTestParamListP5{get;set;}         // list to hold plating parameter

           Public List<DefinedTestParam> metalTestParamListM1{get;set;}         // list to hold material parameter
           Public List<DefinedTestParam> metalTestParamListM2{get;set;}         // list to hold material parameter
           Public List<DefinedTestParam> metalTestParamListM3{get;set;}         // list to hold material parameter
           Public List<DefinedTestParam> metalTestParamListM4{get;set;}         // list to hold material parameter
           Public List<DefinedTestParam> metalTestParamListM5{get;set;}         // list to hold material parameter

           Public List<DefinedTestParam> metalTestParamListP1{get;set;}           // list to hold plating parameter 
           Public List<DefinedTestParam> metalTestParamListP2{get;set;}           // list to hold plating parameter 
           Public List<DefinedTestParam> metalTestParamListP3{get;set;}           // list to hold plating parameter 
           Public List<DefinedTestParam> metalTestParamListP4{get;set;}           // list to hold plating parameter 
           Public List<DefinedTestParam> metalTestParamListP5{get;set;}           // list to hold plating parameter 

           public List<QC_Components__c> caseCom {get;set;}
           public LIst<QC_Components__c> dialCom {get;set;}
           public List<QC_Components__c> leatherCom {get;set;}
           public List<QC_Components__c> metalCom {get;set;}
           public List<QC_Components__c> spacialCom {get;set;}
           public List<QC_Components__c> packageCom {get;set;}
           public List<QC_Components__c> batteryCom {get;set;}
           public List<QC_Components__c> moduleCom {get;set;}

          public QC_componentCompareCtlr () {
                    size=0;
            listId = new List<id>();
            System.debug('Inside constructor');
            System.debug('+++++++++++++'+listId);
            
            allFWTestData       = new Map<String,DefinedTestParam>();       // for all FW test parameter
            allFWTestDataC      = new List<DefinedTestParam>();
            allCaseTestData     = new Map<String,DefinedTestParam>();     // for all case test parameter excluding metarial and plating
            allCaseTestDataC    = new List<DefinedTestParam>();
            allCaseTestDataP    = new Map<String,DefinedTestParam>();    // for all case test parameter for only plating layer        
            allCaseTestDataPC   = new List<DefinedTestParam>();
            allCaseTestDataM    = new Map<String,DefinedTestParam>();    //  for all case test parameter for only metal strap layer
            allCaseTestDataMC   = new List<DefinedTestParam>();
            allDialTestData     = new Map<String,DefinedTestParam>();     // for all dial test parameter
            allDialTestDataC    = new List<DefinedTestParam>();
            allMatalTestData    = new Map<String,DefinedTestParam>();    //  for all metal test parameter excluding material and plating
            allMatalTestDataC   = new List<DefinedTestParam>();
            allMatalTestDataM   = new Map<String,DefinedTestParam>();   // for all metal parameter for only material 
            allMatalTestDataMC  = new list<DefinedTestParam>();
            allMatalTestDataP   = new Map<String,DefinedTestParam>();   // metal test parameter for only Plating layer
            allMatalTestDataPC  = new list<DefinedTestParam>();
            allLeatherTestData  = new Map<String,DefinedTestParam>();   // leather  all test parameter strap parameter 
            allLeatherTestDataC = new List<DefinedTestParam>();
            allSpecialTestData  = new Map<String,DefinedTestParam>();    // special strap all test parameter
            allSpecialTestDataC = new List<DefinedTestParam>();
            allPackageTestData  = new Map<String,DefinedTestParam>();    // special strap all test parameter
            allPackageTestDataC = new List<DefinedTestParam>();

            FWTestParameter1= new List<DefinedTestParam>();
            FWTestParameter2= new List<DefinedTestParam>();
            FWTestParameter3= new List<DefinedTestParam>();
            FWTestParameter4= new List<DefinedTestParam>();
            FWTestParameter5= new List<DefinedTestParam>();
            
            CaseTestParameter1= new List<DefinedTestParam>();
            CaseTestParameter2= new List<DefinedTestParam>();
            CaseTestParameter3= new List<DefinedTestParam>();
            CaseTestParameter4= new List<DefinedTestParam>();
            CaseTestParameter5= new List<DefinedTestParam>();
            
            CaseTestParameterP1= new List<DefinedTestParam>();
            CaseTestParameterP2= new List<DefinedTestParam>();
            CaseTestParameterP3= new List<DefinedTestParam>();
            CaseTestParameterP4= new List<DefinedTestParam>();
            CaseTestParameterP5= new List<DefinedTestParam>();
            
            CaseTestParameterM1= new List<DefinedTestParam>();
            CaseTestParameterM2= new List<DefinedTestParam>();
            CaseTestParameterM3= new List<DefinedTestParam>();
            CaseTestParameterM4= new List<DefinedTestParam>();
            CaseTestParameterM5= new List<DefinedTestParam>();
            
            DialTestParameter1= new List<DefinedTestParam>();   // display dial test parameter 
            DialTestParameter2= new List<DefinedTestParam>();
            DialTestParameter3= new List<DefinedTestParam>();
            DialTestParameter4= new List<DefinedTestParam>();
            DialTestParameter5= new List<DefinedTestParam>();
            
            MatalTestParameter1= new List<DefinedTestParam>();   // display metal test parameter 
            MatalTestParameter2= new List<DefinedTestParam>();
            MatalTestParameter3= new List<DefinedTestParam>();
            MatalTestParameter4= new List<DefinedTestParam>();
            MatalTestParameter5= new List<DefinedTestParam>();
            
            MatalTestParameterM1= new List<DefinedTestParam>();   // display metal test parameter  for only material layer
            MatalTestParameterM2= new List<DefinedTestParam>();
            MatalTestParameterM3= new List<DefinedTestParam>();
            MatalTestParameterM4= new List<DefinedTestParam>();
            MatalTestParameterM5= new List<DefinedTestParam>();
            
            MatalTestParameterP1= new List<DefinedTestParam>();   // display metal test parameter for only plating layer
            MatalTestParameterP2= new List<DefinedTestParam>();
            MatalTestParameterP3= new List<DefinedTestParam>();
            MatalTestParameterP4= new List<DefinedTestParam>();
            MatalTestParameterP5= new List<DefinedTestParam>();
            
            leatherTestParameter1= new List<DefinedTestParam>();   // display leather strap test parameter
            leatherTestParameter2= new List<DefinedTestParam>();
            leatherTestParameter3= new List<DefinedTestParam>();
            leatherTestParameter4= new List<DefinedTestParam>(); 
            leatherTestParameter5= new List<DefinedTestParam>();
            
            specialTestParameter1= new List<DefinedTestParam>();   // display Special Strap test parameter
            specialTestParameter2= new List<DefinedTestParam>();
            specialTestParameter3= new List<DefinedTestParam>();
            specialTestParameter4= new List<DefinedTestParam>();
            specialTestParameter5= new List<DefinedTestParam>();
            
            packageParameter1= new List<DefinedTestParam>();   // display Special Strap test parameter
            packageParameter2= new List<DefinedTestParam>();
            packageParameter3= new List<DefinedTestParam>();
            packageParameter4= new List<DefinedTestParam>();
            packageParameter5= new List<DefinedTestParam>();
            
        
             allFWQuestion = new Set<String>();
             allCaseQuestion = new Set<String>();
             allDialQuestion = new Set<String>();
             allMetalQuestion = new Set<String>();
             allLeatherQuestion = new Set<String>();
             allSpecialQuestion = new Set<String>();
             allPackageQuestion = new Set<String>();
             allModuleQuestion = new Set<String>();
             allBatteryQuestion = new Set<String>();

             FWQuestion1 = new List<String>();
             FWQuestion2 = new List<String>();
             FWQuestion3 = new List<String>();
             FWQuestion4 = new List<String>();
             FWQuestion5 = new List<String>();
             
             CaseQuestion1 = new List<String>();
             CaseQuestion2 = new List<String>();
             CaseQuestion3 = new List<String>();
             CaseQuestion4 = new List<String>();
             CaseQuestion5 = new List<String>();
             
             DialQuestion1 = new List<String>();
             DialQuestion2 = new List<String>();
             DialQuestion3 = new List<String>();
             DialQuestion4 = new List<String>();
             DialQuestion5 = new List<String>();
             
             MetalQuestion1 = new List<String>();
             MetalQuestion2 = new List<String>();
             MetalQuestion3 = new List<String>();
             MetalQuestion4 = new List<String>();
             MetalQuestion5 = new List<String>();
             
             LeatherQuestion1 = new List<String>();
             LeatherQuestion2 = new List<String>();
             LeatherQuestion3 = new List<String>();      
             LeatherQuestion4 = new List<String>();
             LeatherQuestion5 = new List<String>();
             
             SpecialQuestion1 = new List<String>();
             SpecialQuestion2 = new List<String>();
             SpecialQuestion3 = new List<String>();
             SpecialQuestion4 = new List<String>();
             SpecialQuestion5 = new List<String>();
             
             packageQuestion1 = new List<String>();
             packageQuestion2 = new List<String>();
             packageQuestion3 = new List<String>();
             packageQuestion4 = new List<String>();
             packageQuestion5 = new List<String>();
             
             moduleQuestion1 = new List<String>();
             moduleQuestion2 = new List<String>();
             moduleQuestion3 = new List<String>();
             moduleQuestion4 = new List<String>();
             moduleQuestion5 = new List<String>();
             
              battreyQuestion1 = new List<String>();
             battreyQuestion2 = new List<String>();
             battreyQuestion3 = new List<String>();
             battreyQuestion4 = new List<String>();
             battreyQuestion5 = new List<String>();
             
            Master1                 = new QC_Master__c();
            Master2                 = new QC_Master__c();
            Master3                 = new QC_Master__c();
            Master4                 = new QC_Master__c();
            Master5                 = new QC_Master__c();
            reportReferenceNo       = new List<String>();
            component               = new List<QC_Components__c>();
            component1               = new QC_Components__c();
            component2               = new QC_Components__c();
            component3               = new QC_Components__c();
            component4               = new QC_Components__c();
            component5               = new QC_Components__c();

            quesResRecords          = new List<QC_Input_Data__c>();
            testParamRecords = new List<QC_Test_Data__c>();  

            caseInputList1           = new List<DefinedParameters>();
            caseInputList2           = new List<DefinedParameters>();
            caseInputList3           = new List<DefinedParameters>();
            caseInputList4           = new List<DefinedParameters>();
            caseInputList5           = new List<DefinedParameters>();

            dialInputList1           = new List<DefinedParameters>();
            dialInputList2           = new List<DefinedParameters>();
            dialInputList3           = new List<DefinedParameters>();
            dialInputList4           = new List<DefinedParameters>();
            dialInputList5           = new List<DefinedParameters>();

            metalInputList1          = new List<DefinedParameters>();
            metalInputList2          = new List<DefinedParameters>();
            metalInputList3          = new List<DefinedParameters>();
            metalInputList4          = new List<DefinedParameters>();
            metalInputList5          = new List<DefinedParameters>();
                                                                             
            leatherInputList1        = new List<DefinedParameters>();
            leatherInputList2        = new List<DefinedParameters>();
            leatherInputList3        = new List<DefinedParameters>();
            leatherInputList4        = new List<DefinedParameters>();
            leatherInputList5        = new List<DefinedParameters>();

            packageInputList1        = new List<DefinedParameters>();
            packageInputList2        = new List<DefinedParameters>();
            packageInputList3        = new List<DefinedParameters>();
            packageInputList4        = new List<DefinedParameters>();
            packageInputList5        = new List<DefinedParameters>();
            
            ModuleInputList1        = new List<DefinedParameters>();
            ModuleInputList2        = new List<DefinedParameters>();
            ModuleInputList3        = new List<DefinedParameters>();
            ModuleInputList4        = new List<DefinedParameters>();
            ModuleInputList5        = new List<DefinedParameters>();

            BatteryInputList1        = new List<DefinedParameters>();
            BatteryInputList2        = new List<DefinedParameters>();
            BatteryInputList3        = new List<DefinedParameters>();
            BatteryInputList4        = new List<DefinedParameters>();
            BatteryInputList5        = new List<DefinedParameters>();

            specialInputList1        = new List<DefinedParameters>();
            specialInputList2        = new List<DefinedParameters>();
            specialInputList3        = new List<DefinedParameters>();
            specialInputList4        = new List<DefinedParameters>();
            specialInputList5        = new List<DefinedParameters>();


            fwInputList1             = new List <DefinedParameters>();       
            fwInputList2             = new List <DefinedParameters>();
            fwInputList3             = new List <DefinedParameters>();
            fwInputList4             = new List <DefinedParameters>();
            fwInputList5             = new List <DefinedParameters>();

            caseTestParamList1       = new List<DefinedTestParam>();
            caseTestParamList2       = new List<DefinedTestParam>();
            caseTestParamList3       = new List<DefinedTestParam>();
            caseTestParamList4       = new List<DefinedTestParam>();
            caseTestParamList5       = new List<DefinedTestParam>();

            dialTestParamList1       = new List<DefinedTestParam>();
            dialTestParamList2       = new List<DefinedTestParam>();
            dialTestParamList3       = new List<DefinedTestParam>();
            dialTestParamList4       = new List<DefinedTestParam>();
            dialTestParamList5       = new List<DefinedTestParam>();

            leatherTestParamList1    = new List<DefinedTestParam>();
            leatherTestParamList2    = new List<DefinedTestParam>();
            leatherTestParamList3    = new List<DefinedTestParam>();
            leatherTestParamList4    = new List<DefinedTestParam>();
            leatherTestParamList5    = new List<DefinedTestParam>();
            
            metalTestParamList1      = new List<DefinedTestParam>();
            metalTestParamList2      = new List<DefinedTestParam>(); 
            metalTestParamList3      = new List<DefinedTestParam>(); 
            metalTestParamList4      = new List<DefinedTestParam>(); 
            metalTestParamList5      = new List<DefinedTestParam>(); 
            
            fullWatchTestParamList1  = new list<DefinedTestParam>(); 
            fullWatchTestParamList2  = new list<DefinedTestParam>(); 
            fullWatchTestParamList3  = new list<DefinedTestParam>(); 
            fullWatchTestParamList4  = new List<DefinedTestParam>(); 
            fullWatchTestParamList5  = new List<DefinedTestParam>(); 

            specialStrapTestParam1   = new List<DefinedTestParam>();  
            specialStrapTestParam2   = new List<DefinedTestParam>();   
            specialStrapTestParam3   = new List<DefinedTestParam>();   
            specialStrapTestParam4   = new List<DefinedTestParam>();   
            specialStrapTestParam5   = new List<DefinedTestParam>();   
            
            packageTestParam1   = new List<DefinedTestParam>();  
            packageTestParam2   = new List<DefinedTestParam>();   
            packageTestParam3   = new List<DefinedTestParam>();   
            packageTestParam4   = new List<DefinedTestParam>();   
            packageTestParam5   = new List<DefinedTestParam>();   
            
            caseTestParamListM1      = new List<DefinedTestParam>();
            caseTestParamListM2      = new List<DefinedTestParam>();
            caseTestParamListM3      = new List<DefinedTestParam>();
            caseTestParamListM4      = new List<DefinedTestParam>();
            caseTestParamListM5      = new List<DefinedTestParam>();

            caseTestParamListP1      = new List<DefinedTestParam>();
            caseTestParamListP2      = new List<DefinedTestParam>();
            caseTestParamListP3      = new List<DefinedTestParam>();
            caseTestParamListP4      = new List<DefinedTestParam>();
            caseTestParamListP5      = new List<DefinedTestParam>();

            metalTestParamListM1      = new List<DefinedTestParam>();
            metalTestParamListM2      = new List<DefinedTestParam>();
            metalTestParamListM3      = new List<DefinedTestParam>();
            metalTestParamListM4      = new List<DefinedTestParam>();
            metalTestParamListM5      = new List<DefinedTestParam>();

            metalTestParamListP1     = new List<DefinedTestParam>();
            metalTestParamListP2     = new List<DefinedTestParam>();
            metalTestParamListP3     = new List<DefinedTestParam>();
            metalTestParamListP4     = new List<DefinedTestParam>();
            metalTestParamListP5     = new List<DefinedTestParam>();

            
            caseCom      = new List<QC_Components__c>();
            dialCom      = new List<QC_Components__c>();
            leatherCom   = new List<QC_Components__c>();
            metalCom     = new List<QC_Components__c>();
            spacialCom   = new List<QC_Components__c>();
            packageCom   = new List<QC_Components__c>();
            batteryCom   = new List<QC_Components__c>();
            moduleCom    = new List<QC_Components__c>();
          }
          public PageReference  ClickToDownload(){
               System.debug('+++++++++++++++++++id1+++++++++++++++++'+ids1);
               System.debug('+++++++++++++++++++id2+++++++++++++++++'+ids2);
               System.debug('+++++++++++++++++++id3+++++++++++++++++'+ids3);
               System.debug('+++++++++++++++++++id4+++++++++++++++++'+ids4);
               System.debug('+++++++++++++++++++id5+++++++++++++++++'+ids5);
               String ids11;
               String ids22;
               String ids33;
               String ids44;
               String ids55;
                ids11 = String.valueOf(ids1);
                ids22 = String.valueOf(ids2);
                ids33 = String.valueOf(ids3);
                ids44 = String.valueOf(ids4);
                ids55 = String.valueOf(ids5);
               
              PageReference  pr = null;
              if(ids55.length() > 1 && ids44.length() > 1 && ids33.length() > 1 && ids22.length() > 1 && ids11.length() > 1){
                    pr = new pageReference('/apex/QC_componentCompareExcel?id1='+ids11+'&id2=' +ids22+'&id3=' +ids33+'&id4=' +ids44+'&id5=' +ids55);
              }
              else if(ids44.length() > 1 && ids33.length() > 1 && ids22.length() > 1 && ids11.length() > 1){
                    pr = new pageReference('/apex/QC_componentCompareExcel?id1='+ids11+'&id2=' +ids22+'&id3=' +ids33+'&id4=' +ids44);
              }
              else if(ids33.length() > 1 && ids22.length() > 1 && ids11.length() > 1){
                    pr = new pageReference('/apex/QC_componentCompareExcel?id1='+ids11+'&id2=' +ids22+'&id3=' +ids33);
              }    
              else if(ids22.length() > 1 && ids11.length() > 1){
                    pr = new pageReference('/apex/QC_componentCompareExcel?id1='+ids11+'&id2=' +ids22);
              }
              else{
                    pr = new pageReference('/apex/QC_componentCompareExcel?id1='+ids11);
              }  
        //    pr = new pageReference('/apex/QC_componentCompareExcel?id1='+ids1+'&id2=' +ids2+'&id3=' +ids3+'&id4=' +ids4+'&id5=' +ids5);
              pr.setredirect(true);
              return pr;
          }

            public void compare(){
            size=0;
             //  List<id> listId = new List<id>();
               map<id,id> mCaseId = new map<id,id>();
               map<id,id> mDialId = new map<id,id>();
               map<id,id> mMetalId = new map<id,id>();
               map<id,id> mLeatherId = new map<id,id>();
            //   map<id,id> mSpecialId = new map<id,id>();

               pageReference pr = null;
               system.debug('--------Master1.Master_Variant__c------' + Master1.Master_Variant__c);
                ids1 =Master1.Master_Variant__c;  // 1st component master Id
                ids2 =Master2.Master_Variant__c;  // 1st component master Id
                ids3 =Master3.Master_Variant__c;  // 1st component master Id
                ids4 =Master4.Master_Variant__c;  // 1st component master Id
                ids5 =Master5.Master_Variant__c;  // 1st component master Id
                 comId1         = Apexpages.currentpage().getParameters().get('id1');
                 comId2         = Apexpages.currentpage().getParameters().get('id2');
                 comId3         = Apexpages.currentpage().getParameters().get('id3');
                 comId4         = Apexpages.currentpage().getParameters().get('id4');
                 comId5         = Apexpages.currentpage().getParameters().get('id5');

                if(comId1 != null){
                    ids1 = comId1;
                    System.debug('+++++++++++compId++++++++++++++++++'+ids1);
                }
                if(comId2 != null){
                    ids2 = comId2;
                    System.debug('+++++++++++compId++++++++++++++++++'+ids2);
                }
                if(comId3 != null){
                    ids3 = comId3;
                    System.debug('+++++++++++compId++++++++++++++++++'+ids3);
                }     
                if(comId4 != null){
                ids4 = comId4;
                    System.debug('+++++++++++compId++++++++++++++++++'+ids4);
                }   
                if(comId5 != null){
                    ids5 = comId5;
                    System.debug('+++++++++++compId++++++++++++++++++'+ids5);
                }

               if(ids1 != null){     
                    listId.add(ids1);
               }
               if(ids2 != null){     
                    listId.add(ids2);
               }
               if(ids3 != null){     
                    listId.add(ids3);
               }
               if(ids4 != null){     
                    listId.add(ids4);
               }
               if(ids5 != null){     
                    listId.add(ids5);
               }
             
                               // full watch start
                    try{
                        //Query the component details
                        rowLenghtSize = listId.size() + 1;
                        component=[SELECT id,Owner.Name,Parent_Report_Reference_Number__c,imageurl__c,Brand__c,Price__c,Sample_Category__c,Comment__c,Vendor__c,CreatedDate,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id in:listId]; 
                        for(QC_Components__c comp :  component){
                            if(comp.Report_Ref_Number__c != null){
                                reportReferenceNo.add(comp.Report_Ref_Number__c);
                            }
                        }
                     component1=[SELECT id,Owner.Name,Parent_Report_Reference_Number__c,imageurl__c,Brand__c,Price__c,Sample_Category__c,Comment__c,Vendor__c,CreatedDate,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =: ids1]; 
                     component2=[SELECT id,Owner.Name,Parent_Report_Reference_Number__c,imageurl__c,Brand__c,Price__c,Sample_Category__c,Comment__c,Vendor__c,CreatedDate,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =: ids2]; 
                     component3=[SELECT id,Owner.Name,Parent_Report_Reference_Number__c,imageurl__c,Brand__c,Price__c,Sample_Category__c,Comment__c,Vendor__c,CreatedDate,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =: ids3]; 
                     component4=[SELECT id,Owner.Name,Parent_Report_Reference_Number__c,imageurl__c,Brand__c,Price__c,Sample_Category__c,Comment__c,Vendor__c,CreatedDate,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =: ids4]; 
                     component5=[SELECT id,Owner.Name,Parent_Report_Reference_Number__c,imageurl__c,Brand__c,Price__c,Sample_Category__c,Comment__c,Vendor__c,CreatedDate,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =: ids5]; 

                    }catch(Exception e){
                       System.debug('Exception in component records - parent'+e);
                        } 
                    try{
                            quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__c,Value__c,Question__c,Component_No__r.Report_Ref_Number__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  in: listId AND (Component_No__r.Name__c = 'Full-Watch' OR Component_No__r.Name__c = 'Watch-Head') order by Component_No__r.Name__c,Question__r.order_number__c];               
                            for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allFWQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allFWQuestion.add(ip.Question__r.Question__c);
                                }
                            }
                        }catch(Exception e){
                             System.debug('Exception in case Query'+e);
                        }
                    for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(each.Component_No__c == ids1){
                                fwInputList1.add(dpObj);
                            }
                            if(each.Component_No__c == ids2){
                                fwInputList2.add(dpObj);
                            }
                            if(each.Component_No__c == ids3){
                                fwInputList3.add(dpObj);
                            }
                            if(each.Component_No__c == ids4){
                                fwInputList4.add(dpObj);
                            }
                            if(each.Component_No__c == ids5){
                                fwInputList5.add(dpObj);
                            }
                    }
                    size = quesResRecords.size();
                    if(fwInputList1.size() != 0){
                        for(String str : allFWQuestion){
                            Boolean display = False;
                            if(str != null){
                                for(DefinedParameters dp : fwInputList1){
                                    if(str.equals(dp.inputParam))
                                    {   
                                        display = True;
                                        if(dp.value != null){
                                           FWQuestion1.add(dp.value);
                                        }
                                        else
                                        FWQuestion1.add('');
                                    }
                                }
                                if(display == False)
                                    FWQuestion1.add('');
                            }
                        }
                    }
                    if(fwInputList2.size() != 0){
                        for(String str : allFWQuestion){
                            Boolean display = False;
                            if(str != null){
                                for(DefinedParameters dp : fwInputList2){
                                    if(str.equals(dp.inputParam))
                                    {   
                                        System.debug('+++++++++++++str++++++++++++'+str);
                                        System.debug('+++++++++++++dp.inputParam++++++++++++'+dp.inputParam); 
                                        display = True;
                                        if(dp.value != null){
                                           FWQuestion2.add(dp.value);
                                        }
                                        else
                                        FWQuestion2.add('');
                                    }
                                }
                                if(display == False)
                                    FWQuestion2.add('');
                            }
                        }
                    }
                    if(fwInputList3.size() != 0){
                        for(String str : allFWQuestion){
                            Boolean display = False;
                            if(str != null){
                                for(DefinedParameters dp : fwInputList3){
                                    if(str.equals(dp.inputParam))
                                    {   
                                        display = True;
                                        if(dp.value != null){
                                           FWQuestion3.add(dp.value);
                                        }
                                        else
                                        FWQuestion3.add('');
                                    }
                                }
                                if(display == False)
                                    FWQuestion3.add('');
                            }
                        }
                    }
                    if(fwInputList4.size() != 0){
                        for(String str : allFWQuestion){
                            Boolean display = False;
                            if(str != null){
                                for(DefinedParameters dp : fwInputList4){
                                    if(str.equals(dp.inputParam))
                                    {   
                                        display = True;
                                        if(dp.value != null){
                                           FWQuestion4.add(dp.value);
                                        }
                                        else
                                        FWQuestion4.add('');
                                    }
                                }
                                if(display == False)
                                    FWQuestion4.add('');
                            }
                        }
                    }
                    if(fwInputList5.size() != 0)
                    {
                        for(String str : allFWQuestion){
                            Boolean display = False;
                            if(str != null){
                                for(DefinedParameters dp : fwInputList5){
                                    if(str.equals(dp.inputParam))
                                    {   
                                        display = True;
                                        if(dp.value != null){
                                           FWQuestion5.add(dp.value);
                                        }
                                        else
                                        FWQuestion5.add('');
                                    }
                                }
                                if(display == False)
                                    FWQuestion5.add('');
                            }
                        }
                    }
                    //Query all the captured test findings of full watch.   
                    try{
                        testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c,Component_Name__r.Report_Ref_Number__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: listId AND (Component_Name__r.Name__c = 'Full-Watch' OR Component_Name__r.Name__c = 'Watch-Head') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                    }
                    catch(Exception e){
                        System.debug('Exception in case Query'+e);
                    }
                    for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;
                                testParamObj.uom            = testDat.UOM_Input__c;
                                testParamObj.specification  = testDat.Specification_Input__c;
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                            }                
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            testParamObj.reportref          = testDat.Component_Name__r.Report_Ref_Number__c;
                            
                            if(testParamObj.TestName != null){
                                allFWTestData.put(testParamObj.TestName,testParamObj);
                            }
                            
                            if(testDat.Component_Name__c == ids1){
                                fullWatchTestParamList1.add(testParamObj);
                            }
                            if(testDat.Component_Name__c == ids2){
                                fullWatchTestParamList2.add(testParamObj);
                            }
                            if(testDat.Component_Name__c == ids3){
                                fullWatchTestParamList3.add(testParamObj);
                            }
                            if(testDat.Component_Name__c == ids4){
                                fullWatchTestParamList4.add(testParamObj);
                            }
                            if(testDat.Component_Name__c == ids5){
                                fullWatchTestParamList5.add(testParamObj);
                            }
                    }
                    if(!allFWTestData.isEmpty()){
                        allFWTestDataC.addAll(allFWTestData.values());
                    }
                    if(fullWatchTestParamList1.size() != 0){
                        for(DefinedTestParam str : allFWTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : fullWatchTestParamList1){
                                if(str.TestName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    FWTestParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                FWTestParameter1.add(tp);
                            }
                        }
                    }
                    if(fullWatchTestParamList2.size() != 0){
                        for(DefinedTestParam str : allFWTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : fullWatchTestParamList2){
                                if(str.TestName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    FWTestParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                FWTestParameter2.add(tp);
                            }
                        }
                    }
                    if(fullWatchTestParamList3.size() != 0){
                        for(DefinedTestParam str : allFWTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : fullWatchTestParamList3){
                                if(str.TestName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    FWTestParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                FWTestParameter3.add(tp);
                            }
                        }
                    }
                    if(fullWatchTestParamList4.size() != 0){
                        for(DefinedTestParam str : allFWTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : fullWatchTestParamList4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    FWTestParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                FWTestParameter4.add(tp);
                            }
                        }
                    }
                    if(fullWatchTestParamList5.size() != 0){
                        for(DefinedTestParam str : allFWTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : fullWatchTestParamList5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    FWTestParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                FWTestParameter5.add(tp);
                            }
                        }
                    }
        // case block start
                     try{
                            caseCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Case' ];
                            for(QC_Components__c comp : caseCom){
                                if(comp.id != null){
                                     if(comp.Parent__c != null){
                                            mCaseId.put(comp.id,comp.Parent__c);
                                     }
                                     else{
                                            mCaseId.put(comp.id,comp.id);
                                     }
                                }                            
                            }
                            quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__c,Value__c,Question__c,Component_No__r.Report_Ref_Number__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  in: mCaseId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                             for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allCaseQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allCaseQuestion.add(ip.Question__r.Question__c);
                                }
                            }
                        }catch(Exception e){
                            System.debug('Exception in case records - child'+e);
                        }
                     for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(!mCaseId.isEmpty() && mCaseId.get(each.Component_No__c) == ids1){
                                caseInputList1.add(dpObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(each.Component_No__c) == ids2){
                                caseInputList2.add(dpObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(each.Component_No__c) == ids3){
                                caseInputList3.add(dpObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(each.Component_No__c) == ids4){
                                caseInputList4.add(dpObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(each.Component_No__c) == ids5){
                                caseInputList5.add(dpObj);
                            }
                    }
                    System.debug('+++++++++++++allCaseQuestion++++++++++++++++++++++'+allCaseQuestion);
                        if(caseInputList1.size() != 0){
                        for(String str : allCaseQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : caseInputList1){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       CaseQuestion1.add(dp.value);
                                    }
                                    else
                                    CaseQuestion1.add('');
                                }
                            }
                            if(display == False)
                                CaseQuestion1.add('');
                        }
                    }
                    if(caseInputList2.size() != 0){
                        for(String str : allCaseQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : caseInputList2){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       CaseQuestion2.add(dp.value);
                                    }
                                    else
                                    CaseQuestion2.add('');
                                }
                            }
                            if(display == False)
                                CaseQuestion2.add('');
                        }
                    }
                    if(caseInputList3.size() != 0){
                        for(String str : allCaseQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : caseInputList3){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       CaseQuestion3.add(dp.value);
                                    }
                                    else
                                    CaseQuestion3.add('');
                                }
                            }
                            if(display == False)
                                CaseQuestion3.add('');
                        }
                    }
                    if(caseInputList4.size() != 0){
                        for(String str : allCaseQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : caseInputList4){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       CaseQuestion4.add(dp.value);
                                    }
                                    else
                                    CaseQuestion4.add('');
                                }
                            }
                            if(display == False)
                                CaseQuestion4.add('');
                        }
                    }
                    if(caseInputList5.size() != 0)
                    {
                        for(String str : allCaseQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : caseInputList5){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       CaseQuestion5.add(dp.value);
                                    }
                                    else
                                    CaseQuestion5.add('');
                                }
                            }
                            if(display == False)
                                CaseQuestion5.add('');
                        }
                    }   
                     System.debug('+++++++++++++++++FWQuestion4++++++++++++++++++++++++'+FWQuestion1);
                     System.debug('+++++++++++++++++FWQuestion4++++++++++++++++++++++++'+FWQuestion2);
                     System.debug('+++++++++++++++++FWQuestion4++++++++++++++++++++++++'+FWQuestion3);
                     System.debug('+++++++++++++++++FWQuestion4++++++++++++++++++++++++'+FWQuestion4);
                     System.debug('+++++++++++++++++FWQuestion4++++++++++++++++++++++++'+FWQuestion5);

                     testParamRecords.clear();
                    try{
                            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mCaseId.keyset()  AND (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Back Cover' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Crown' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                            
                        }
                        catch(Exception e){  
                          System.debug('Exception in component records - parent'+e);        
                    }
                    for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;
                                testParamObj.uom            = testDat.UOM_Input__c;
                                testParamObj.specification  = testDat.Specification_Input__c;
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allCaseTestData.put(testParamObj.TestName,testParamObj);
                            }
                            
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids1){
                            caseTestParamList1.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids2){
                            caseTestParamList2.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids3){
                            caseTestParamList3.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids4){
                            caseTestParamList4.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids5){
                            caseTestParamList5.add(testParamObj);
                            }
                    }
                    if(!allCaseTestData.isEmpty()){
                        allCaseTestDataC.addAll(allCaseTestData.values());
                    }
                    if(caseTestParamList1.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamList1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameter1.add(tp);
                            }
                        }
                    }
                    if(caseTestParamList2.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamList2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameter2.add(tp);
                            }
                        }
                    }
                    if(caseTestParamList3.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamList3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameter3.add(tp);
                            }
                        }
                    }
                    if(caseTestParamList4.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamList4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameter4.add(tp);
                            }
                        }
                    }
                    if(caseTestParamList5.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamList5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameter5.add(tp);
                            }
                        }
                    }
                    
        // Case - code block to add test parameter information to list(Only Material )                 
                        testParamRecords.clear();
                        try{
                            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mCaseId.keyset()  AND (Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Case Center' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Back Cover' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Bezel Ring' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Screw' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Pin' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Crown' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                        }
                        catch(Exception e){
                            System.debug('Exception in test param records - Case'+e);
                        }
                        for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;
                                testParamObj.uom            = testDat.UOM_Input__c;
                                testParamObj.specification  = testDat.Specification_Input__c;
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allCaseTestDataM.put(testParamObj.TestName,testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids1){
                            caseTestParamListM1.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids2){
                            caseTestParamListM2.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids3){
                            caseTestParamListM3.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids4){
                            caseTestParamListM4.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids5){
                            caseTestParamListM5.add(testParamObj);
                            }
                        }
                        if(!allCaseTestDataM.isEmpty()){
                            allCaseTestDataMC.addAll(allCaseTestDataM.values());
                        }
                        
                    if(caseTestParamListM1.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListM1){
                                if(str.TestName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterM1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterM1.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListM2.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListM2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterM2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterM2.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListM3.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListM3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterM3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterM3.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListM4.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListM4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterM4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterM4.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListM5.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListM5){
                                if(str.TestName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterM5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterM5.add(tp);
                            }
                        }
                    }
                    
                        
        // Case - code block to add test parameter information to list(Only Plating )                 
                        testParamRecords.clear();
                        try{
                            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mCaseId.keyset()  AND (Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Case Center' OR Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Bezel Ring') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                        }
                        catch(Exception e){
                            //ApexPages.addMessages(e) ; 
                            System.debug('Exception in test param records - Case'+e);
                        }
                        for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            // Added by Sanjeev Shukla for manual and default test data
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;
                                testParamObj.uom            = testDat.UOM_Input__c;
                                testParamObj.specification  = testDat.Specification_Input__c;
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allCaseTestDataP.put(testParamObj.TestName,testParamObj);
                            }
                            
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids1){
                            caseTestParamListP1.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids2){
                            caseTestParamListP2.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids3){
                            caseTestParamListP3.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids4){
                            caseTestParamListP4.add(testParamObj);
                            }
                            if(!mCaseId.isEmpty() && mCaseId.get(testDat.Component_Name__c) == ids5){
                            caseTestParamListP5.add(testParamObj);
                            }
                        }
                    if(!allCaseTestDataP.isEmpty()){
                        allCaseTestDataPC.addAll(allCaseTestDataP.values());
                    }
                    if(caseTestParamListP1.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListP1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterP1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterP1.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListP2.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListP2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterP2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterP2.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListP3.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListP3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterP3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterP3.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListP4.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListP4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterP4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterP4.add(tp);
                            }
                        }
                    }
                    if(caseTestParamListP5.size() != 0){
                        for(DefinedTestParam str : allCaseTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : caseTestParamListP5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    CaseTestParameterP5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                CaseTestParameterP5.add(tp);
                            }
                        }
                    }
                    
                        
        // start Dial block     
                        try{       
                           dialCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId)AND Name__c = 'Dial' ]; 
                            for(QC_Components__c comp : dialCom){
                                if(comp.id != null){
                                    if(comp.Parent__c != null){
                                        mDialId.put(comp.id,comp.Parent__c);
                                    }
                                    else{
                                        mDialId.put(comp.id,comp.id);
                                    }
                                }
                            }
                           quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__c,Value__c,Question__c,Component_No__r.Report_Ref_Number__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  in: mDialId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                            for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allDialQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allDialQuestion.add(ip.Question__r.Question__c);
                                }
                            }
                       }catch(Exception e){
                            System.debug('Exception in dial records - child'+e);
                         }                 
                        system.debug('*quesResRecords*'+quesResRecords );
                        for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(!mDialId.isEmpty() && mDialId.get(each.Component_No__c) == ids1){
                                dialInputList1.add(dpObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(each.Component_No__c) == ids2){
                                dialInputList2.add(dpObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(each.Component_No__c) == ids3){
                                dialInputList3.add(dpObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(each.Component_No__c) == ids4){
                                dialInputList4.add(dpObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(each.Component_No__c) == ids5){
                                dialInputList5.add(dpObj);
                            }
                        } 
                    if(dialInputList1.size() != 0){
                        for(String str : allDialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : dialInputList1){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       DialQuestion1.add(dp.value);
                                    }
                                    else
                                    DialQuestion1.add('');
                                }
                            }
                            if(display == False)
                                DialQuestion1.add('');
                        }
                    }
                    if(dialInputList2.size() != 0){
                        for(String str : allDialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : dialInputList2){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       DialQuestion2.add(dp.value);
                                    }
                                    else
                                    DialQuestion2.add('');
                                }
                            }
                            if(display == False)
                                DialQuestion2.add('');
                        }
                    }
                    if(dialInputList3.size() != 0){
                        for(String str : allDialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : dialInputList3){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       DialQuestion3.add(dp.value);
                                    }
                                    else
                                    DialQuestion3.add('');
                                }
                            }
                            if(display == False)
                                DialQuestion3.add('');
                        }
                    }
                    if(dialInputList4.size() != 0){
                        for(String str : allDialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : dialInputList4){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       DialQuestion4.add(dp.value);
                                    }
                                    else
                                    DialQuestion4.add('');
                                }
                            }
                            if(display == False)
                                DialQuestion4.add('');
                        }
                    }
                    if(dialInputList5.size() != 0)
                    {
                        for(String str : allDialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : dialInputList5){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       DialQuestion5.add(dp.value);
                                    }
                                    else
                                    DialQuestion5.add('');
                                }
                            }
                            if(display == False)
                                DialQuestion5.add('');
                        }
                    }   
        // Dial - code block to add test parameter information to list.         
                        try{
                            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mDialId.keyset()  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                        }                      
                        catch(Exception e){
                            ApexPages.addMessages(e) ; 
                            System.debug('Exception in test param records - Dial'+e);
                        }
                        for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;
                                testParamObj.uom            = testDat.UOM_Input__c;
                                testParamObj.specification  = testDat.Specification_Input__c;
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allDialTestData.put(testParamObj.TestName,testParamObj);
                            }
                            
                            if(!mDialId.isEmpty() && mDialId.get(testDat.Component_Name__c) == ids1){
                                dialTestParamList1.add(testParamObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(testDat.Component_Name__c) == ids2){
                                dialTestParamList2.add(testParamObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(testDat.Component_Name__c) == ids3){
                                dialTestParamList3.add(testParamObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(testDat.Component_Name__c) == ids4){
                                dialTestParamList4.add(testParamObj);
                            }
                            if(!mDialId.isEmpty() && mDialId.get(testDat.Component_Name__c) == ids5){
                                dialTestParamList5.add(testParamObj);
                            }
                        }
                        
                    if(!allDialTestData.isEmpty()){
                        allDialTestDataC.addAll(allDialTestData.values());
                    }
                    if(dialTestParamList1.size() != 0){
                        for(DefinedTestParam str : allDialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : dialTestParamList1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    DialTestParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                DialTestParameter1.add(tp);
                            }
                        }
                    }
                    if(dialTestParamList2.size() != 0){
                        for(DefinedTestParam str : allDialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : dialTestParamList2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    DialTestParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                DialTestParameter2.add(tp);
                            }
                        }
                    }
                    if(dialTestParamList3.size() != 0){
                        for(DefinedTestParam str : allDialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : dialTestParamList3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    DialTestParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                DialTestParameter3.add(tp);
                            }
                        }
                    }
                    if(dialTestParamList4.size() != 0){
                        for(DefinedTestParam str : allDialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : dialTestParamList4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    DialTestParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                DialTestParameter4.add(tp);
                            }
                        }
                    }
                    if(dialTestParamList5.size() != 0){
                        for(DefinedTestParam str : allDialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : dialTestParamList5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    DialTestParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                DialTestParameter5.add(tp);
                            }
                        }
                    }
        // Metal Strap - code block to add product information to list.    
                        try{                                 
                            metalCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Metal-Strap' ];
                            for(QC_Components__c comp : metalCom){
                                if(comp.id != null){
                                    if(comp.Parent__c != null){
                                        mMetalId.put(comp.id,comp.Parent__c);
                                    }
                                    else{
                                        mMetalId.put(comp.id,comp.id);
                                    }
                                }
                            }
                            quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__r.Report_Ref_Number__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  in: mMetalId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                            for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allMetalQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allMetalQuestion.add(ip.Question__r.Question__c);
                                }
                            }
                         }catch(Exception e){
                             System.debug('Exception in Metal Strap records - child'+e);
                          }
                        for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(!mMetalId.isEmpty() && mMetalId.get(each.Component_No__c) == ids1){
                                metalInputList1.add(dpObj);
                            }
                            if(!mMetalId.isEmpty() && mMetalId.get(each.Component_No__c) == ids2){
                                metalInputList2.add(dpObj);
                            }
                            if(!mMetalId.isEmpty() && mMetalId.get(each.Component_No__c) == ids3){
                                metalInputList3.add(dpObj);
                            }
                            if(!mMetalId.isEmpty() && mMetalId.get(each.Component_No__c) == ids4){
                                metalInputList4.add(dpObj);
                            }
                            if(!mMetalId.isEmpty() && mMetalId.get(each.Component_No__c) == ids5){
                                metalInputList5.add(dpObj);
                            }
                        } 
                    if(metalInputList1.size() != 0){
                        for(String str : allMetalQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : metalInputList1){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       MetalQuestion1.add(dp.value);
                                    }
                                    else
                                    MetalQuestion1.add('');
                                }
                            }
                            if(display == False)
                                MetalQuestion1.add('');
                        }
                    }
                    if(metalInputList2.size() != 0){
                        for(String str : allMetalQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : metalInputList2){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       MetalQuestion2.add(dp.value);
                                    }
                                    else
                                    MetalQuestion2.add('');
                                }
                            }
                            if(display == False)
                                MetalQuestion2.add('');
                        }
                    }
                    if(metalInputList3.size() != 0){
                        for(String str : allMetalQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : metalInputList3){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       MetalQuestion3.add(dp.value);
                                    }
                                    else
                                    MetalQuestion3.add('');
                                }
                            }
                            if(display == False)
                                MetalQuestion3.add('');
                        }
                    }
                    if(metalInputList4.size() != 0){
                        for(String str : allMetalQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : metalInputList4){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       MetalQuestion4.add(dp.value);
                                    }
                                    else
                                    MetalQuestion4.add('');
                                }
                            }
                            if(display == False)
                                MetalQuestion4.add('');
                        }
                    }
                    if(metalInputList5.size() != 0)
                    {
                        for(String str : allMetalQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : metalInputList5){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       MetalQuestion5.add(dp.value);
                                    }
                                    else
                                    MetalQuestion5.add('');
                                }
                            }
                            if(display == False)
                                MetalQuestion5.add('');
                        }
                    }   
        //Metal Strap - code block to add test parameter information to list(only Material).                
                            testParamRecords.clear();
                            try{
                                testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mMetalId.keyset() and (Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Strap' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Pin' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Clasp / Buckle' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Screw') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                           }
                            catch(Exception e){
                                System.debug('Exception in test param records - Dial'+e);
                            }
                            for(QC_Test_Data__c testDat : testParamRecords){
                                DefinedTestParam testParamObj       = new DefinedTestParam();
                                if(testDat.isManual__c){
                                    testParamObj.testName       = testDat.Test_Name__c;
                                    testParamObj.uom            = testDat.UOM_Input__c;
                                    testParamObj.specification  = testDat.Specification_Input__c;
                                }else{
                                    testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                    testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                    testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                                }
                                testParamObj.observation            = testDat.Observation__c;
                                testParamObj.verdict                = testDat.Conclusion__c;
                                testParamObj.commentAndRemarks      = testDat.Comments_and_Remarks__c;
                                
                            if(testParamObj.TestName != null){
                                allMatalTestDataM.put(testParamObj.TestName,testParamObj);
                            }

                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids1){
                                    metalTestParamListM1.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids2){
                                    metalTestParamListM2.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids3){
                                    metalTestParamListM3.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids4){
                                    metalTestParamListM4.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids5){
                                    metalTestParamListM5.add(testParamObj);
                                }
                            }
                            
                    if(!allMatalTestDataM.isEmpty()){
                        allMatalTestDataMC.addAll(allMatalTestDataM.values());
                    }
                    if(metalTestParamListM1.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListM1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterM1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterM1.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListM2.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListM2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterM2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterM2.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListM3.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListM3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterM3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterM3.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListM4.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListM4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterM4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterM4.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListM5.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataMC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListM5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterM5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterM5.add(tp);
                            }
                        }
                    }
                            
        // Metal Strap - code block to add test parameter information to list(only Plating). 
                        
                            testParamRecords.clear();
                            try{
                                testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mMetalId.keyset() and (Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Strap') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                            }
                            catch(Exception e){
                                System.debug('Exception in test param records - Dial'+e);
                            }
                            for(QC_Test_Data__c testDat : testParamRecords){
                                DefinedTestParam testParamObj       = new DefinedTestParam();
                                if(testDat.isManual__c){
                                    testParamObj.testName       = testDat.Test_Name__c;
                                    testParamObj.uom            = testDat.UOM_Input__c;
                                    testParamObj.specification  = testDat.Specification_Input__c;
                                }else{
                                    testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                    testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                    testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                                }
                                testParamObj.observation            = testDat.Observation__c;
                                testParamObj.verdict                = testDat.Conclusion__c;
                                testParamObj.commentAndRemarks      = testDat.Comments_and_Remarks__c;
                                
                            if(testParamObj.TestName != null){
                                allMatalTestDataP.put(testParamObj.TestName,testParamObj);
                            }

                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids1){
                                    metalTestParamListP1.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids2){
                                    metalTestParamListP2.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids3){
                                    metalTestParamListP3.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids4){
                                    metalTestParamListP4.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids5){
                                    metalTestParamListP5.add(testParamObj);
                                }
                            }
                            
                    if(!allMatalTestDataP.isEmpty()){
                        allMatalTestDataPC.addAll(allMatalTestDataP.values());
                    }
                    if(metalTestParamListP1.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListP1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterP1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterP1.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListP2.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListP2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterP2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterP2.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListP3.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListP3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterP3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterP3.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListP4.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListP4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterP4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterP4.add(tp);
                            }
                        }
                    }
                    if(metalTestParamListP5.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataPC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamListP5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameterP5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameterP5.add(tp);
                            }
                        }
                    }
                            testParamRecords.clear();
                            try{
                                testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mMetalId.keyset() and (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Strap' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Clasp / Buckle' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Strap') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                            }
                            catch(Exception e){
                                System.debug('Exception in test param records - Dial'+e);
                            }
                            for(QC_Test_Data__c testDat : testParamRecords){
                                DefinedTestParam testParamObj       = new DefinedTestParam();
                                if(testDat.isManual__c){
                                    testParamObj.testName       = testDat.Test_Name__c;
                                    testParamObj.uom            = testDat.UOM_Input__c;
                                    testParamObj.specification  = testDat.Specification_Input__c;
                                }else{
                                    testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                                    testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;
                                    testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;
                                }
                                testParamObj.observation            = testDat.Observation__c;
                                testParamObj.verdict                = testDat.Conclusion__c;
                                testParamObj.commentAndRemarks      = testDat.Comments_and_Remarks__c;
                                
                            if(testParamObj.TestName != null){
                                allMatalTestData.put(testParamObj.TestName,testParamObj);
                            }
                                
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids1){
                                    metalTestParamList1.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids2){
                                    metalTestParamList2.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids3){
                                    metalTestParamList3.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids4){
                                    metalTestParamList4.add(testParamObj);
                                }
                                if(!mMetalId.isEmpty() && mMetalId.get(testDat.Component_Name__c) == ids5){
                                    metalTestParamList5.add(testParamObj);
                                }
                            }
                            
                    if(!allMatalTestData.isEmpty()){
                        allMatalTestDataC.addAll(allMatalTestData.values());
                    }
                    if(metalTestParamList1.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamList1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameter1.add(tp);
                            }
                        }
                    }
                    if(metalTestParamList2.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamList2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameter2.add(tp);
                            }
                        }
                    }
                    if(metalTestParamList3.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamList3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameter3.add(tp);
                            }
                        }
                    }
                    if(metalTestParamList4.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamList4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameter4.add(tp);
                            }
                        }
                    }
                    if(metalTestParamList5.size() != 0){
                        for(DefinedTestParam str : allMatalTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : metalTestParamList5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    MatalTestParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                MatalTestParameter5.add(tp);
                            }
                        }
                    }
                                           
        //  Leather Strap - code block to add product information to list.          
                        try{
                            leatherCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Leather-Strap'  ];
                            for(QC_Components__c comp : leatherCom){
                                if(comp.id != null){
                                    if(comp.Parent__c != null){
                                        mLeatherId.put(comp.id,comp.Parent__c);
                                    }
                                    else{
                                        mLeatherId.put(comp.id,comp.id);
                                    }
                                }
                            }
                        }catch(Exception e){
                            System.debug('Exception in Leather Strap records - Leather Strap'+e);
                        }              
                        try{
                            quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__r.Report_Ref_Number__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: mLeatherId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                            for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allLeatherQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allLeatherQuestion.add(ip.Question__r.Question__c);
                                }
                            }
                      }catch(Exception e){
                             System.debug('Exception in case Query'+e);
                        }
                        for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(!mLeatherId.isEmpty() && mLeatherId.get(each.Component_No__c) == ids1){
                                leatherInputList1.add(dpObj);
                            }
                            if(!mLeatherId.isEmpty() && mLeatherId.get(each.Component_No__c) == ids2){
                                leatherInputList2.add(dpObj);
                            }
                            if(!mLeatherId.isEmpty() && mLeatherId.get(each.Component_No__c) == ids3){
                                leatherInputList3.add(dpObj);
                            }
                            if(!mLeatherId.isEmpty() && mLeatherId.get(each.Component_No__c) == ids4){
                                leatherInputList4.add(dpObj);
                            }
                            if(!mLeatherId.isEmpty() && mLeatherId.get(each.Component_No__c) == ids5){
                                leatherInputList5.add(dpObj);
                            }
                        }
                    if(leatherInputList1.size() != 0){
                        for(String str : allLeatherQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : leatherInputList1){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       LeatherQuestion1.add(dp.value);
                                    }
                                    else
                                    LeatherQuestion1.add('');
                                }
                            }
                            if(display == False)
                                LeatherQuestion1.add('');
                        }
                    }
                    if(leatherInputList2.size() != 0){
                        for(String str : allLeatherQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : leatherInputList2){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       LeatherQuestion2.add(dp.value);
                                    }
                                    else
                                    LeatherQuestion2.add('');
                                }
                            }
                            if(display == False)
                                LeatherQuestion2.add('');
                        }
                    }
                    if(leatherInputList3.size() != 0){
                        for(String str : allLeatherQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : leatherInputList3){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       LeatherQuestion3.add(dp.value);
                                    }
                                    else
                                    LeatherQuestion3.add('');
                                }
                            }
                            if(display == False)
                                LeatherQuestion3.add('');
                        }
                    }
                    if(leatherInputList4.size() != 0){
                        for(String str : allLeatherQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : leatherInputList4){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       LeatherQuestion4.add(dp.value);
                                    }
                                    else
                                    LeatherQuestion4.add('');
                                }
                            }
                            if(display == False)
                                LeatherQuestion4.add('');
                        }
                    }
                    if(leatherInputList5.size() != 0)
                    {
                        for(String str : allLeatherQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : leatherInputList5){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       LeatherQuestion5.add(dp.value);
                                    }
                                    else
                                    LeatherQuestion5.add('');
                                }
                            }
                            if(display == False)
                                LeatherQuestion5.add('');
                        }
                    }   
                        try{
                            testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c in: mLeatherId.keyset() order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                        }
                        catch(Exception e){
                            System.debug('Exception in test param Query - Leather-Strap '+e);
                        }
                        for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;     // for manual test data
                                testParamObj.uom            = testDat.UOM_Input__c;     // for manual test data
                                testParamObj.specification  = testDat.Specification_Input__c;   // for manual test data
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;    // for default test data
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;      // for default test data
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;  // for default test data
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allLeatherTestData.put(testParamObj.TestName,testParamObj);
                            }
                            
                            if(!mLeatherId.isEmpty() && mLeatherId.get(testDat.Component_Name__c) == ids1){
                                    leatherTestParamList1.add(testParamObj);
                                }
                                if(!mLeatherId.isEmpty() && mLeatherId.get(testDat.Component_Name__c) == ids2){
                                    leatherTestParamList2.add(testParamObj);
                                }
                                if(!mLeatherId.isEmpty() && mLeatherId.get(testDat.Component_Name__c) == ids3){
                                    leatherTestParamList3.add(testParamObj);
                                }
                                if(!mLeatherId.isEmpty() && mLeatherId.get(testDat.Component_Name__c) == ids4){
                                    leatherTestParamList4.add(testParamObj);
                                }
                                if(!mLeatherId.isEmpty() && mLeatherId.get(testDat.Component_Name__c) == ids5){
                                    leatherTestParamList5.add(testParamObj);
                                }
                        }
                        
                    if(!allLeatherTestData.isEmpty()){
                        allLeatherTestDataC.addAll(allLeatherTestData.values());
                    }
                    if(leatherTestParamList1.size() != 0){
                        for(DefinedTestParam str : allLeatherTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : leatherTestParamList1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    leatherTestParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                leatherTestParameter1.add(tp);
                            }
                        }
                    }
                    if(leatherTestParamList2.size() != 0){
                        for(DefinedTestParam str : allLeatherTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : leatherTestParamList2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    leatherTestParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                leatherTestParameter2.add(tp);
                            }
                        }
                    }
                    if(leatherTestParamList3.size() != 0){
                        for(DefinedTestParam str : allLeatherTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : leatherTestParamList3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    leatherTestParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                leatherTestParameter3.add(tp);
                            }
                        }
                    }
                    if(leatherTestParamList4.size() != 0){
                        for(DefinedTestParam str : allLeatherTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : leatherTestParamList4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    leatherTestParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                leatherTestParameter4.add(tp);
                            }
                        }
                    }
                    if(leatherTestParamList5.size() != 0){
                        for(DefinedTestParam str : allLeatherTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : leatherTestParamList5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    leatherTestParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                leatherTestParameter5.add(tp);
                            }
                        }
                    }
           
                 //     return new pageReference('/apex/QC_componentCompareExcel');
               compare1();
            }
            public void compare1()
            {
                    map<id,id> mSpecialId = new map<id,id>();
                    map<id,id> mPackageId = new map<id,id>();
                    map<id,id> mBatteryId = new map<id,id>();
                    map<id,id> mModuleId = new map<id,id>();

                    

                        // End of Leather Strap data gathering and adding to list. 
                        try{
                            spacialCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Special-Strap' ];
                            for(QC_Components__c comp : spacialCom){
                                if(comp.id != null){
                                    if(comp.Parent__c != null){
                                        mSpecialId.put(comp.id,comp.Parent__c);
                                    }
                                    else{
                                        mSpecialId.put(comp.id,comp.id);
                                    }
                                }
                            }
                            quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__r.Report_Ref_Number__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: mSpecialId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                            for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allSpecialQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allSpecialQuestion.add(ip.Question__r.Question__c);
                                }
                                
                            }
                        }catch(Exception e){
                            System.debug('Exception in Special-Strap records - Special-Strap'+e);
                        }                
                        for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(!mSpecialId.isEmpty() && mSpecialId.get(each.Component_No__c) == ids1){
                                specialInputList1.add(dpObj);
                            }
                            if(!mSpecialId.isEmpty() && mSpecialId.get(each.Component_No__c) == ids2){
                                specialInputList2.add(dpObj);
                            }
                            if(!mSpecialId.isEmpty() && mSpecialId.get(each.Component_No__c) == ids3){
                                specialInputList3.add(dpObj);
                            }
                            if(!mSpecialId.isEmpty() && mSpecialId.get(each.Component_No__c) == ids4){
                                specialInputList4.add(dpObj);
                            }
                            if(!mSpecialId.isEmpty() && mSpecialId.get(each.Component_No__c) == ids5){
                                specialInputList5.add(dpObj);
                            }
                        } 

                    if(specialInputList1.size() != 0){
                        for(String str : allSpecialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : specialInputList1){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       SpecialQuestion1.add(dp.value);
                                    }
                                    else
                                    SpecialQuestion1.add('');
                                }
                            }
                            if(display == False)
                                SpecialQuestion1.add('');
                        }
                    }
                    if(specialInputList2.size() != 0){
                        for(String str : allSpecialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : specialInputList2){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       SpecialQuestion2.add(dp.value);
                                    }
                                    else
                                    SpecialQuestion2.add('');
                                }
                            }
                            if(display == False)
                                SpecialQuestion2.add('');
                        }
                    }
                    if(specialInputList3.size() != 0){
                        for(String str : allSpecialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : specialInputList3){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       SpecialQuestion3.add(dp.value);
                                    }
                                    else
                                    SpecialQuestion3.add('');
                                }
                            }
                            if(display == False)
                                SpecialQuestion3.add('');
                        }
                    }
                    if(specialInputList4.size() != 0){
                        for(String str : allSpecialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : specialInputList4){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       SpecialQuestion4.add(dp.value);
                                    }
                                    else
                                    SpecialQuestion4.add('');
                                }
                            }
                            if(display == False)
                                SpecialQuestion4.add('');
                        }
                    }
                    if(specialInputList5.size() != 0)
                    {
                        for(String str : allSpecialQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : specialInputList5){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       SpecialQuestion5.add(dp.value);
                                    }
                                    else
                                    SpecialQuestion5.add('');
                                }
                            }
                            if(display == False)
                                SpecialQuestion5.add('');
                        }
                    }   
                        try{
                            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c =: mSpecialId.keyset()  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                        }
                        catch(Exception e){
                            System.debug('Exception in test param Query - special strap'+e);
                        }
                        for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;   // for manual test data
                                testParamObj.uom            = testDat.UOM_Input__c;   // for manual test data
                                testParamObj.specification  = testDat.Specification_Input__c;   // for manual test data
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;   // for default test data
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;    // for default test data
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;  // for default test data
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allSpecialTestData.put(testParamObj.TestName,testParamObj);
                            }
                            
                                if(!mSpecialId.isEmpty() && mSpecialId.get(testDat.Component_Name__c) == ids1){
                                    specialStrapTestParam1.add(testParamObj);
                                }
                                if(!mSpecialId.isEmpty() && mSpecialId.get(testDat.Component_Name__c) == ids2){
                                    specialStrapTestParam2.add(testParamObj);
                                }
                                if(!mSpecialId.isEmpty() && mSpecialId.get(testDat.Component_Name__c) == ids3){
                                    specialStrapTestParam3.add(testParamObj);
                                }
                                if(!mSpecialId.isEmpty() && mSpecialId.get(testDat.Component_Name__c) == ids4){
                                    specialStrapTestParam4.add(testParamObj);
                                }
                                if(!mSpecialId.isEmpty() && mSpecialId.get(testDat.Component_Name__c) == ids5){
                                    specialStrapTestParam5.add(testParamObj);
                                }
                        }
                    if(!allSpecialTestData.isEmpty()){
                        allSpecialTestDataC.addAll(allSpecialTestData.values());
                    }
                    if(specialStrapTestParam1.size() != 0){
                        for(DefinedTestParam str : allSpecialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : specialStrapTestParam1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    specialTestParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                specialTestParameter1.add(tp);
                            }
                        }
                    }
                    if(specialStrapTestParam2.size() != 0){
                        for(DefinedTestParam str : allSpecialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : specialStrapTestParam2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    specialTestParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                specialTestParameter2.add(tp);
                            }
                        }
                    }
                    if(specialStrapTestParam3.size() != 0){
                        for(DefinedTestParam str : allSpecialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : specialStrapTestParam3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    specialTestParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                specialTestParameter3.add(tp);
                            }
                        }
                    }
                    if(specialStrapTestParam4.size() != 0){
                        for(DefinedTestParam str : allSpecialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : specialStrapTestParam4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    specialTestParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                specialTestParameter4.add(tp);
                            }
                        }
                    }
                    if(specialStrapTestParam5.size() != 0){
                        for(DefinedTestParam str : allSpecialTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : specialStrapTestParam5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    specialTestParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                specialTestParameter5.add(tp);
                            }
                        }
                    }
        // package component strat
                        try{
                            packageCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Packaging' ];
                            for(QC_Components__c comp : packageCom){
                                if(comp.id != null){
                                    if(comp.Parent__c != null){
                                        mPackageId.put(comp.id,comp.Parent__c);
                                    }
                                    else
                                    mPackageId.put(comp.id,comp.id);        
                                }
                            }
                            quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__r.Report_Ref_Number__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: mPackageId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                            for(QC_Input_Data__c ip : quesResRecords){
                                if(ip.isManual__c){
                                    allPackageQuestion.add(ip.Question_Name__c);
                                }
                                else{
                                    allPackageQuestion.add(ip.Question__r.Question__c);
                                }
                                
                            }
                        }catch(Exception e){
                            System.debug('Exception in Special-Strap records - Special-Strap'+e);
                        }                
                        for(QC_Input_Data__c each :quesResRecords) {
                            DefinedParameters dpObj = new DefinedParameters();
                            if(each.isManual__c){
                                dpObj.inputParam = each.Question_Name__c;
                            }
                            else{
                                dpObj.inputParam = each.Question__r.Question__c;
                            }
                            dpObj.value = each.Value__c;
                            dpObj.comment = each.Comments__c;
                            dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                            if(!mPackageId.isEmpty() && mPackageId.get(each.Component_No__c) == ids1){
                                packageInputList1.add(dpObj);
                            }
                            if(!mPackageId.isEmpty() && mPackageId.get(each.Component_No__c) == ids2){
                                packageInputList2.add(dpObj);
                            }
                            if(!mPackageId.isEmpty() && mPackageId.get(each.Component_No__c) == ids3){
                                packageInputList3.add(dpObj);
                            }
                            if(!mPackageId.isEmpty() && mPackageId.get(each.Component_No__c) == ids4){
                                packageInputList4.add(dpObj);
                            }
                            if(!mPackageId.isEmpty() && mPackageId.get(each.Component_No__c) == ids5){
                                packageInputList5.add(dpObj);
                            }
                        } 

                    if(packageInputList1.size() != 0){
                        for(String str : allPackageQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : packageInputList1){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       packageQuestion1.add(dp.value);
                                    }
                                    else
                                    packageQuestion1.add('');
                                }
                            }
                            if(display == False)
                                packageQuestion1.add('');
                        }
                    }
                    if(packageInputList2.size() != 0){
                        for(String str : allPackageQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : packageInputList2){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       packageQuestion2.add(dp.value);
                                    }
                                    else
                                    packageQuestion2.add('');
                                }
                            }
                            if(display == False)
                                packageQuestion2.add('');
                        }
                    }
                    if(packageInputList3.size() != 0){
                        for(String str : allPackageQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : packageInputList3){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       packageQuestion3.add(dp.value);
                                    }
                                    else
                                    packageQuestion3.add('');
                                }
                            }
                            if(display == False)
                                packageQuestion3.add('');
                        }
                    }
                    if(packageInputList4.size() != 0){
                        for(String str : allPackageQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : packageInputList4){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       packageQuestion4.add(dp.value);
                                    }
                                    else
                                    packageQuestion4.add('');
                                }
                            }
                            if(display == False)
                                packageQuestion4.add('');
                        }
                    }
                    if(packageInputList5.size() != 0)
                    {
                        for(String str : allPackageQuestion){
                            Boolean display = False;
                            for(DefinedParameters dp : packageInputList5){
                                if(str.equals(dp.inputParam))
                                {   
                                    display = True;
                                    if(dp.value != null){
                                       packageQuestion5.add(dp.value);
                                    }
                                    else
                                    packageQuestion5.add('');
                                }
                            }
                            if(display == False)
                                packageQuestion5.add('');
                        }
                    }   
                        try{
                            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='' OR Conclusion__c!='NA') AND Component_Name__c =: mPackageId.keyset()  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                        }
                        catch(Exception e){
                            System.debug('Exception in test param Query - special strap'+e);
                        }
                        for(QC_Test_Data__c testDat : testParamRecords){
                            DefinedTestParam testParamObj   = new DefinedTestParam();
                            if(testDat.isManual__c){
                                testParamObj.testName       = testDat.Test_Name__c;   // for manual test data
                                testParamObj.uom            = testDat.UOM_Input__c;   // for manual test data
                                testParamObj.specification  = testDat.Specification_Input__c;   // for manual test data
                            }else{
                                testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c;   // for default test data
                                testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c;    // for default test data
                                testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c;  // for default test data
                            }
                            testParamObj.observation        = testDat.Observation__c;
                            testParamObj.verdict            = testDat.Conclusion__c;
                            testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                            
                            if(testParamObj.TestName != null){
                                allPackageTestData.put(testParamObj.TestName,testParamObj);
                            }
                            
                                if(!mPackageId.isEmpty() && mPackageId.get(testDat.Component_Name__c) == ids1){
                                    packageTestParam1.add(testParamObj);
                                }
                                if(!mPackageId.isEmpty() && mPackageId.get(testDat.Component_Name__c) == ids2){
                                    packageTestParam2.add(testParamObj);
                                }
                                if(!mPackageId.isEmpty() && mPackageId.get(testDat.Component_Name__c) == ids3){
                                    packageTestParam3.add(testParamObj);
                                }
                                if(!mPackageId.isEmpty() && mPackageId.get(testDat.Component_Name__c) == ids4){
                                    packageTestParam4.add(testParamObj);
                                }
                                if(!mPackageId.isEmpty() && mPackageId.get(testDat.Component_Name__c) == ids5){
                                    packageTestParam5.add(testParamObj);
                                }
                        }
                    if(!allPackageTestData.isEmpty()){
                        allPackageTestDataC.addAll(allPackageTestData.values());
                    }
                    if(packageTestParam1.size() != 0){
                        for(DefinedTestParam str : allPackageTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : packageTestParam1){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    packageParameter1.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                packageParameter1.add(tp);
                            }
                        }
                    }
                    if(packageTestParam2.size() != 0){
                        for(DefinedTestParam str : allPackageTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : packageTestParam2){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    packageParameter2.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                packageParameter2.add(tp);
                            }
                        }
                    }
                    if(packageTestParam3.size() != 0){
                        for(DefinedTestParam str : allPackageTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : packageTestParam3){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    packageParameter3.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                packageParameter3.add(tp);
                            }
                        }
                    }
                    if(packageTestParam4.size() != 0){
                        for(DefinedTestParam str : allPackageTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : packageTestParam4){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == '' ){
                                       dtp.observation = '';
                                    }
                                    packageParameter4.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                packageParameter4.add(tp);
                            }
                        }
                    }
                    if(packageTestParam5.size() != 0){
                        for(DefinedTestParam str : allPackageTestDataC){
                            Boolean display = False;
                            for(DefinedTestParam dtp : packageTestParam5){
                                if(str.testName.equals(dtp.TestName))
                                {  
                                    display = True;
                                    if(dtp.observation == ''){
                                       dtp.observation = '';
                                    }
                                    packageParameter5.add(dtp);
                                }
                            }
                            if(display == False){
                                DefinedTestParam tp   = new DefinedTestParam();
                                tp.TestName           = '';
                                tp.observation        = '';
                                tp.verdict            = '';
                                tp.commentAndRemarks  = '';
                                tp.uom                = '';
                                tp.specification      = '';
                                packageParameter5.add(tp);
                            }
                        }
                    }
                // battery component strat
                    try{
                        batteryCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Battery' ];
                        for(QC_Components__c comp : batteryCom){
                            if(comp.Parent__c != null){
                                 mBatteryId.put(comp.id,comp.Parent__c);        
                            }
                            else{
                                mBatteryId.put(comp.id,comp.id);        
                            }
                        }
                        quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__r.Report_Ref_Number__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: mBatteryId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                        for(QC_Input_Data__c ip : quesResRecords){
                            if(ip.isManual__c){
                                allBatteryQuestion.add(ip.Question_Name__c);
                            }
                            else{
                                allBatteryQuestion.add(ip.Question__r.Question__c);
                            }
                            
                        }
                    }catch(Exception e){
                        System.debug('Exception in Special-Strap records - Special-Strap'+e);
                    }                
                    for(QC_Input_Data__c each :quesResRecords) {
                        DefinedParameters dpObj = new DefinedParameters();
                        if(each.isManual__c){
                            dpObj.inputParam = each.Question_Name__c;
                        }
                        else{
                            dpObj.inputParam = each.Question__r.Question__c;
                        }
                        dpObj.value = each.Value__c;
                        dpObj.comment = each.Comments__c;
                        dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                        if(!mBatteryId.isEmpty() && mBatteryId.get(each.Component_No__c) == ids1){
                            BatteryInputList1.add(dpObj);
                        }
                        if(!mBatteryId.isEmpty() && mBatteryId.get(each.Component_No__c) == ids2){
                            BatteryInputList2.add(dpObj);
                        }
                        if(!mBatteryId.isEmpty() && mBatteryId.get(each.Component_No__c) == ids3){
                            BatteryInputList3.add(dpObj);
                        }
                        if(!mBatteryId.isEmpty() && mBatteryId.get(each.Component_No__c) == ids4){
                            BatteryInputList4.add(dpObj);
                        }
                        if(!mBatteryId.isEmpty() && mBatteryId.get(each.Component_No__c) == ids5){
                            BatteryInputList5.add(dpObj);
                        }
                    } 

                if(BatteryInputList1.size() != 0){
                    for(String str : allBatteryQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : BatteryInputList1){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   battreyQuestion1.add(dp.value);
                                }
                                else
                                battreyQuestion1.add('');
                            }
                        }
                        if(display == False)
                            battreyQuestion1.add('');
                    }
                }
                if(BatteryInputList2.size() != 0){
                    for(String str : allBatteryQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : BatteryInputList2){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   battreyQuestion2.add(dp.value);
                                }
                                else
                                battreyQuestion2.add('');
                            }
                        }
                        if(display == False)
                            battreyQuestion2.add('');
                    }
                }
                if(BatteryInputList3.size() != 0){
                    for(String str : allBatteryQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : BatteryInputList3){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   battreyQuestion3.add(dp.value);
                                }
                                else
                                battreyQuestion3.add('');
                            }
                        }
                        if(display == False)
                            battreyQuestion3.add('');
                    }
                }
                if(BatteryInputList4.size() != 0){
                    for(String str : allBatteryQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : BatteryInputList4){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   battreyQuestion4.add(dp.value);
                                }
                                else
                                battreyQuestion4.add('');
                            }
                        }
                        if(display == False)
                            battreyQuestion4.add('');
                    }
                }
                if(BatteryInputList5.size() != 0)
                {
                    for(String str : allBatteryQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : BatteryInputList5){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   battreyQuestion5.add(dp.value);
                                }
                                else
                                battreyQuestion5.add('');
                            }
                        }
                        if(display == False)
                            battreyQuestion5.add('');
                    }
                } 
            // module component strat
                    try{
                        moduleCom =[SELECT id,Name,Name__c,Final_Verdict__c,Parent__c FROM QC_Components__c WHERE (Parent__c in: listId OR ID in:listId) AND Name__c = 'Module' ];
                        for(QC_Components__c comp : moduleCom){
                            if(comp.Parent__c != null){
                                 mModuleId.put(comp.id,comp.Parent__c);        
                            }
                            else{
                                mModuleId.put(comp.id,comp.id);        
                            }
                        }
                        quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__r.Report_Ref_Number__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: mModuleId.keyset() order by Component_No__r.Name__c,Question__r.order_number__c];               
                        for(QC_Input_Data__c ip : quesResRecords){
                            if(ip.isManual__c){
                                allModuleQuestion.add(ip.Question_Name__c);
                            }
                            else{
                                allModuleQuestion.add(ip.Question__r.Question__c);
                            }
                            
                        }
                    }catch(Exception e){
                        System.debug('Exception in Special-Strap records - Special-Strap'+e);
                    }                
                    for(QC_Input_Data__c each :quesResRecords) {
                        DefinedParameters dpObj = new DefinedParameters();
                        if(each.isManual__c){
                            dpObj.inputParam = each.Question_Name__c;
                        }
                        else{
                            dpObj.inputParam = each.Question__r.Question__c;
                        }
                        dpObj.value = each.Value__c;
                        dpObj.comment = each.Comments__c;
                        dpObj.referenceNo = each.Component_No__r.Report_Ref_Number__c;
                        if(!mModuleId.isEmpty() && mModuleId.get(each.Component_No__c) == ids1){
                            ModuleInputList1.add(dpObj);
                        }
                        if(!mModuleId.isEmpty() && mModuleId.get(each.Component_No__c) == ids2){
                            ModuleInputList2.add(dpObj);
                        }
                        if(!mModuleId.isEmpty() && mModuleId.get(each.Component_No__c) == ids3){
                            ModuleInputList3.add(dpObj);
                        }
                        if(!mModuleId.isEmpty() && mModuleId.get(each.Component_No__c) == ids4){
                            ModuleInputList4.add(dpObj);
                        }
                        if(!mModuleId.isEmpty() && mModuleId.get(each.Component_No__c) == ids5){
                            ModuleInputList5.add(dpObj);
                        }
                    } 

                if(ModuleInputList1.size() != 0){
                    for(String str : allModuleQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : ModuleInputList1){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   moduleQuestion1.add(dp.value);
                                }
                                else
                                moduleQuestion1.add('');
                            }
                        }
                        if(display == False)
                            moduleQuestion1.add('');
                    }
                }
                if(ModuleInputList2.size() != 0){
                    for(String str : allModuleQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : ModuleInputList2){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   moduleQuestion2.add(dp.value);
                                }
                                else
                                moduleQuestion2.add('');
                            }
                        }
                        if(display == False)
                            moduleQuestion2.add('');
                    }
                }
                if(ModuleInputList3.size() != 0){
                    for(String str : allModuleQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : ModuleInputList3){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   moduleQuestion3.add(dp.value);
                                }
                                else
                                moduleQuestion3.add('');
                            }
                        }
                        if(display == False)
                            moduleQuestion3.add('');
                    }
                }
                if(ModuleInputList4.size() != 0){
                    for(String str : allModuleQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : ModuleInputList4){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   moduleQuestion4.add(dp.value);
                                }
                                else
                                moduleQuestion4.add('');
                            }
                        }
                        if(display == False)
                            moduleQuestion4.add('');
                    }
                }
                if(ModuleInputList5.size() != 0)
                {
                    for(String str : allModuleQuestion){
                        Boolean display = False;
                        for(DefinedParameters dp : ModuleInputList5){
                            if(str.equals(dp.inputParam))
                            {   
                                display = True;
                                if(dp.value != null){
                                   moduleQuestion5.add(dp.value);
                                }
                                else
                                moduleQuestion5.add('');
                            }
                        }
                        if(display == False)
                            moduleQuestion5.add('');
                    }
                }   
            }
        }