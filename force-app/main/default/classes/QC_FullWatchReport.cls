/*
    Name:QC_FullWatchReport 
    Created By:Shamsher Singh
    Created Date: 2/12/2015
    Modified By: Shamsher Singh
    Last Modified Date: 3/30/2015
    Description:
    Methods Used:
*/
public with sharing class QC_FullWatchReport{
    public QC_Components__c component            {get;set;}         //Parent component
   // public List<User> l1l2UserName                     {get;set;}         //checked by user and approved bu user
   // public set<id> uids{get;set;}
   // public user lst {get;set;}
    //public user lst1 {get;set;} 
    public List<QC_Components__c> childRecords   {get;set;}         //List to hold all the child components
    public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records   
    public ID recId     {get;set;}                                  //To hold the record id   
    public String materialValue;
    public List<QC_Components__c> allChildComponent{get;set;}                  // added by sudama for all child component
    public List<QC_Test_Data__c> allChildTestData{get;set;}                   // added by sudama for all child component test data
    public Map<string,list<QC_Test_Data__c>> mAllChildTestData{get;set;}       // added by sudama for storing key as a test name and value as list of test data
    public List<QC_Test_Data__c> parentTestData{get;set;}                   // added by sudama for all child component test data
    public Integer mSize{get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}

    
    public class DefinedParameters {    
        public String inputParam{get;set;}          //String variable to hold the input question
        public String value{get;set;}               //String variable to hold the input response
        public String color{get;set;}
        public String comment{get;set;}
    }
    /*
     public List<DefinedParameters> caseInputList{get;set;}
     public List<DefinedParameters> dialInputList{get;set;}
     public List<DefinedParameters> metalInputList{get;set;}
     public List<DefinedParameters> leatherInputList{get;set;}
     public List<DefinedParameters> specialInputList{get;set;}
     public List<DefinedParameters> fwInputList{get;set;}
     */
    public class DefinedTestParam {
        public String uom{get;set;}                //String variable to hold the test specification value
        public String spec{get;set;}                //String variable to hold the test specification value
        public String testName{get;set;}            //String variable to hold the test name value
        public String specification{get;set;}       //String variable to hold the test specification value
        public String observation{get;set;}         //String variable to hold the test observation value
        public String verdict{get;set;}             //String variable to hold the test verdict value     
        public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value    
    }   
    
    public QC_Input_Data__c caseIP {get;set;}
    public QC_Input_Data__c dialIP {get;set;}
    public QC_Input_Data__c leatherIP {get;set;}
    public QC_Input_Data__c metalIP {get;set;}
    public QC_Input_Data__c spacialIP {get;set;}
    
    public QC_Components__c caseCom {get;set;}
    public QC_Components__c dialCom {get;set;}
    public QC_Components__c leatherCom {get;set;}
    public QC_Components__c metalCom {get;set;}
    public QC_Components__c spacialCom {get;set;}
    public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records
    
    public List<DefinedTestParam> caseTestParamList{get;set;}           //List to hold the Case test parameter
    public List<DefinedTestParam> dialTestParamList{get;set;}           //List to hold the Dial test parameter
    public List<DefinedTestParam> leatherTestParamList{get;set;}        //List to hold the Leather Strap test parameter
    public List<DefinedTestParam> metalTestParamList{get;set;}          //List to hold the Metal Strap test parameter
    public List<DefinedTestParam> specialStrapTestParam{get;set;}       //List to hold the Special Strap test parameter
    public List<DefinedTestParam> fullWatchTestParamList{get;set;}      //List to hold the Full Watch test parameter
    /* sudama
    Public List<DefinedTestParam> caseTestParamListM{get;set;}        //List to hold Case Material  parameter
    Public List<DefinedTestParam> caseTestParamListP{get;set;}         // list to hold plating parameter
    Public List<DefinedTestParam> metalTestParamListM{get;set;}         // list to hold material parameter
    Public List<DefinedTestParam> metalTestParamListP{get;set;}           // list to hold plating parameter
    */
    public QC_FullWatchReport(){
/*      
      caseInputList       = new List<DefinedParameters>();
        dialInputList       = new List<DefinedParameters>();
        metalInputList      = new List<DefinedParameters>();
        leatherInputList    = new List<DefinedParameters>();
        specialInputList    = new List<DefinedParameters>();
        fwInputList         = new List<DefinedParameters>();
     */
        
        caseIP    = new QC_Input_Data__c();
        dialIP    = new QC_Input_Data__c();
        leatherIP = new QC_Input_Data__c();
        metalIP   = new QC_Input_Data__c();
        spacialIP = new QC_Input_Data__c();
         quesResRecords = new List<QC_Input_Data__c>();
         
        caseCom      = new QC_Components__c();
        dialCom      = new QC_Components__c();
        leatherCom   = new QC_Components__c();
        metalCom     = new QC_Components__c();
        spacialCom   = new QC_Components__c();
        
        caseTestParamList       = new List<DefinedTestParam>();
        dialTestParamList       = new List<DefinedTestParam>();
        leatherTestParamList    = new List<DefinedTestParam>();
        metalTestParamList      = new List<DefinedTestParam>(); 
        fullWatchTestParamList  = new List<DefinedTestParam>(); 
        specialStrapTestParam   = new List<DefinedTestParam>(); 
        
        set<id>allChildComp = new set<id>();
        allChildComponent = new List<QC_Components__c>();
        allChildTestData  = new List<QC_Test_Data__c>();
        mAllChildTestData = new Map<string,list<QC_Test_Data__c>>();
        parentTestData    = new List<QC_Test_Data__c>();
        mSize = 0;

       // l1l2UserName = new list<User>();
       // uids   = new set<id>();
       // lst   = new User();
       // lst1  = new User();
        recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        childRecords = new List<QC_Components__c>();
        
           
        testParamRecords = new List<QC_Test_Data__c>();  
        set<String> childId = new set<String>();
        if(recId != null){        
            try{
                //Query the component details
                component=[SELECT id,Owner.Name,Comment__c,Price__c,imageurl__c,imageurl2__c,imageurl3__c,CreatedDate,Parent_Report_Reference_Number__c ,Exception_Verdict__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:recId ]; 
            }catch(Exception e){
               System.debug('Exception in component records - parent'+e);
            } 
            
          //For fetching First Approver and Second Level Approver. Modified by Anindwita

           List<ProcessInstance > lstProcessInstance = [SELECT CompletedDate,Id,LastActorId,ProcessDefinitionId,Status,SubmittedBy.name ,( SELECT CompletedDate,Id,LastActor.Name,NodeStatus,ProcessInstanceId,ProcessNodeId,ProcessNodeName FROM Nodes ORDER BY CreatedDate DESC ) 
           FROM ProcessInstance WHERE TargetObjectId =:component.id AND Status != 'Pending'  ORDER BY CreatedDate DESC limit 1];
            for(ProcessInstance  pi : lstProcessInstance ){
                system.debug('**********ProcessInstance**********'+pi);
                for(ProcessInstanceNode  st : pi.Nodes){
                    system.debug('*************Step **************'+st);
                    if(st.NodeStatus == 'Approved' || st.NodeStatus == 'Rejected'){
                        if(st.ProcessNodeName == 'Step 1'){
                            firstActorName = st.LastActor.Name;
                         //   lst.lstName = st.LastActorId;
                        }
                        if(st.ProcessNodeName == 'Approval to Level 2'){
                           // lst1.Name = st.LastActor.Name;
                           secondActorName = st.LastActor.Name;
                           
                        }
                    } 
                }
                if( secondActorName == null || secondActorName == '')
                {
                    secondActorName = firstActorName;
                }
            } 
              /*l1l2UserName  = [select Name from user where Name =:firstActorName LIMIT 1];
                    system.debug('**username**'+l1l2UserName);
                    
              lst = l1l2UserName.get(0);
              
              lst1 = [SELECT Name FROM User WHERE Name =:secondActorName LIMIT 1];
           system.debug('%%USername for 1st level%%'+lst);
           system.debug('$$UserName for 2nd level$$'+lst1);
           */
        
            
            /*  approval users commend by sudama 
            
            try{
                //Query the L1 and L2 approver name from user object.
                l1l2UserName = [SELECT id,Name,L1_Approver__r.Name,L2_Approver__r.Name FROM User WHERE Name =: component.Owner.Name];
                system.debug('approval user name+++++++++++'+l1l2UserName);
            }catch(Exception e){
                System.debug('Exception in user Query'+e);
            }
            */          
       
      //Full watch - code block to add test parameters of full watch to list          
            //Query all the captured test findings of full watch.   
               try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: recId  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
               }
               catch(Exception e){
                    //ApexPages.addMessages(e) ; 
                    System.debug('Exception in test data query - Full Watch'+e);
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
                    fullWatchTestParamList.add(testParamObj);
                }
                 //childRecords.clear();
                 //childId.clear();
      //Full Watch - End of adding test parameter to list
                
                try{
                    caseCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Case' ];
                }catch(Exception e){
                    //ApexPages.addMessages(e) ; 
                    System.debug('Exception in case records - child'+e);
                }
                
            
                
               
      // Case - code block to add test parameter information to list.                 
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: caseCom.id  AND (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Back Cover' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Crown' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
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
                    caseTestParamList.add(testParamObj);
                }
                //childRecords.clear();
                //childId.clear();
      //End of case data gathering and adding to list.      
      
   
            /*
                Dial - code block to add Dial Feature data to list
                Dial Feature value is displayed in the product information section of the page. 
                This is hardcodeded because not all the Dial input parameters are displayed in the report.
            */  try{       
                   dialCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Dial' ];  
                }catch(Exception e){
                    System.debug('Exception in dial records - child'+e);
                 }        
                
           
                
      // Dial - code block to add test parameter information to list. 
           
              try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: dialCom.Id  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                    ApexPages.addMessages(e) ; 
                    System.debug('Exception in test param records - Dial'+e);
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
                    dialTestParamList.add(testParamObj);
                }                
                //childRecords.clear();
                //childId.clear();
      //End of Dial data gathering and adding to list. 
                    
      //Metal Strap - code block to add product information to list.    
              try{                                 
                metalCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Metal-Strap' ];
              }catch(Exception e){
                 //Apexpages.addMessages(e);
                 System.debug('Exception in Metal Strap records - child'+e);
              }
             
         
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: metalCom.Id and (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Strap' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Clasp / Buckle' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Strap') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                    //ApexPages.addMessages(e) ; 
                    System.debug('Exception in test param records - Dial'+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj       = new DefinedTestParam();
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
                    testParamObj.observation            = testDat.Observation__c;
                    testParamObj.verdict                = testDat.Conclusion__c;
                    testParamObj.commentAndRemarks      = testDat.Comments_and_Remarks__c;
                    metalTestParamList.add(testParamObj);
                }
                //childRecords.clear();
               // childId.clear();
              //End of Metal Strap data gathering and adding to list. 
               
              //Leather Strap - code block to add product information to list.          
                try{
                    leatherCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Leather-Strap'  ];
                }catch(Exception e){
                    System.debug('Exception in Leather Strap records - Leather Strap'+e);
                }
            
               
              /* 
                    Leather Strap - code block to add test parameter information to list.      
                  
              */      
               testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: leatherCom.id order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                    //ApexPages.addMessages(e) ; 
                    System.debug('Exception in test param Query - Leather-Strap '+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj   = new DefinedTestParam();
                    // Added by Sanjeev Shukla for manual and default test data
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
                    leatherTestParamList.add(testParamObj);
                }
                //childRecords.clear();
                //childId.clear();
      //End of Leather Strap data gathering and adding to list. 
      
      /*        Speacial Strap - adding test parameters into the list.

      */        try{
                    spacialCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Special-Strap' ];
                }catch(Exception e){
                    System.debug('Exception in Special-Strap records - Special-Strap'+e);
                }
                 
          
               
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: spacialCom.id  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                    //ApexPages.addMessages(e) ; 
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
                    specialStrapTestParam.add(testParamObj);
                }
                //childRecords.clear();
                //childId.clear();
                //Special strap - end of adding special strap test parameters
                       QC_Components__c component1 =[select id,Report_Ref_Number__c from QC_Components__c where Report_Ref_Number__c =: component.Parent_Report_Reference_Number__c LIMIT 1];
            system.debug('+++++++++++++++++++++++component++++'+component1);
           if(component.Sample_Category__c == 'Re-submission' && component.id != null){
                if(component1.id != null){
                    allChildComp.add(component1.id);
                }           
                system.debug('+++++++++++++++++++++++component++++'+component1);                    
                allChildComponent = [SELECT id,component_status__c,Report_Ref_Number__c,Sample_Category__c,Document_Status__c,Name__c,Parent__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: component1.id ];
                for(QC_Components__c  qcComp : allChildComponent){
                if(qcComp.id != null)
                    allChildComp.add(qcComp.id);
                }
                system.debug('+++++++++++++++++++++++all child++++'+allChildComponent);
                allChildTestData = [select Id,isManual__c,Component_Name__r.Name__c,Test_Name__c,Determined_value__c,Conclusion__c,Component_Name__c,Comments_and_Remarks__c,Observation__c,Condition_Ref__c,Specification_Input__c,UOM_Input__c,Condition_Ref__r.IsEditableUOMSPEC__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c from QC_Test_Data__c where Component_Name__c in: allChildComp AND Conclusion__c = 'Reject'];
              //  parentTestData   = [select Id,isManual__c,Component_Name__r.Name__c,Test_Name__c,Determined_value__c,Conclusion__c,Component_Name__c,Comments_and_Remarks__c,Observation__c,Condition_Ref__c,Specification_Input__c,UOM_Input__c,Condition_Ref__r.IsEditableUOMSPEC__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c from QC_Test_Data__c where Component_Name__c =: component1.id AND Conclusion__c = 'Reject'];              
               //  system.debug('+++++++++++++++++++++++all child test++++'+allChildTestData[0].Condition_Ref__r.Question__r.Test_Name__c);                                
                if(!allChildTestData.isEmpty()){
                    for(QC_Test_Data__c qcList : allChildTestData){
                      if(qcList.Component_Name__r.Name__c != 'Full-Watch'){
                        if(!mAllChildTestData.isEmpty() && mAllChildTestData.containsKey(qcList.Component_Name__r.Name__c) && mAllChildTestData.get(qcList.Component_Name__r.Name__c)!=null){
                            mAllChildTestData.get(qcList.Component_Name__r.Name__c).add(qcList);
                        }
                        else{
                            mAllChildTestData.put(qcList.Component_Name__r.Name__c,new list<QC_Test_Data__c>{qcList});
                        }
                        System.debug('+++++++++++++++++++mapValue'+mAllChildTestData);
                     }
                     else
                        parentTestData.add(qcList);
                    }
                    mSize = mAllChildTestData.size();
                }
                 
            } 
             
       }//End of if block
    }//End of constructor
}