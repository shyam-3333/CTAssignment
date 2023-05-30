/*
    Name:QC_FullWatchReport 
    Created By:Shamsher Singh
    Created Date: 2/12/2015
    Modified By: Shamsher Singh
    Last Modified Date: 3/30/2015
    Description:
    Methods Used:
*/
public with sharing class QC_AllTestFindingSummaryReportWH{
    public QC_Components__c component            {get;set;}         //Parent component
   // public List<User> l1l2UserName                     {get;set;}         //checked by user and approved bu user
    public List<QC_Components__c> childRecords   {get;set;}         //List to hold all the child components
    public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records   
    public ID recId     {get;set;}                                  //To hold the record id   
    public String materialValue;
   // public set<id> uids{get;set;}
   // public user lst {get;set;}
   // public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}  
    
    public class DefinedParameters {    
        public String inputParam{get;set;}          //String variable to hold the input question
        public String value{get;set;}               //String variable to hold the input response
        public String color{get;set;}
        public String comment{get;set;}
    }
    
     public List<DefinedParameters> caseInputList{get;set;}
     public List<DefinedParameters> dialInputList{get;set;}
     public List<DefinedParameters> metalInputList{get;set;}
     public List<DefinedParameters> leatherInputList{get;set;}
     public List<DefinedParameters> specialInputList{get;set;}
     public List<DefinedParameters> fwInputList{get;set;}
     
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
    
    Public List<DefinedTestParam> caseTestParamListM{get;set;}        //List to hold Case Material  parameter
    Public List<DefinedTestParam> caseTestParamListP{get;set;}         // list to hold plating parameter
    Public List<DefinedTestParam> metalTestParamListM{get;set;}         // list to hold material parameter
    Public List<DefinedTestParam> metalTestParamListP{get;set;}           // list to hold plating parameter
    
    public List<QC_Components__c> allChildComponent{get;set;}                  // added by sudama for all child component
    public List<QC_Test_Data__c> allChildTestData{get;set;}                   // added by sudama for all child component test data
    public Map<string,list<QC_Test_Data__c>> mAllChildTestData{get;set;}       // added by sudama for storing key as a test name and value as list of test data
    public List<QC_Test_Data__c> parentTestData{get;set;}                   // added by sudama for all child component test data
    public Integer mSize{get;set;}
    public QC_AllTestFindingSummaryReportWH(){
        caseInputList       = new List<DefinedParameters>();
        dialInputList       = new List<DefinedParameters>();
        metalInputList      = new List<DefinedParameters>();
        leatherInputList    = new List<DefinedParameters>();
        specialInputList    = new List<DefinedParameters>();
        fwInputList         = new List<DefinedParameters>();
        
        metalTestParamListM= new List<DefinedTestParam>();
        metalTestParamListP= new List<DefinedTestParam>();
        
        caseIP    = new QC_Input_Data__c();
        dialIP    = new QC_Input_Data__c();
        leatherIP = new QC_Input_Data__c();
        metalIP   = new QC_Input_Data__c();
        spacialIP = new QC_Input_Data__c();
        quesResRecords = new List<QC_Input_Data__c>();
       // uids   = new set<id>();
       // lst   = new User();
        //lst1  = new User();
         
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
        
        caseTestParamListM      = new List<DefinedTestParam>();
        caseTestParamListP      = new List<DefinedTestParam>();
        
        set<id>allChildComp = new set<id>();
        allChildComponent = new List<QC_Components__c>();
        allChildTestData  = new List<QC_Test_Data__c>();
        mAllChildTestData = new Map<string,list<QC_Test_Data__c>>();
        parentTestData    = new List<QC_Test_Data__c>();
        mSize = 0;
        
       // l1l2UserName = new List<User>();
        recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        childRecords = new List<QC_Components__c>();
        
           
        testParamRecords = new List<QC_Test_Data__c>();  
        set<String> childId = new set<String>();
        if(recId != null){        
            try{
                //Query the component details
                component=[SELECT id,Owner.Name,Comment__c,Price__c,imageurl__c,imageurl2__c,imageurl3__c,Exception_Verdict__c,Parent_Report_Reference_Number__c,General_Observation__c,Published_Date__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:recId ]; 
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
            /*
            try{
                //Query the L1 and L2 approver name from user object.
                l1l2UserName = [SELECT id,Name,L1_Approver__r.Name,L2_Approver__r.Name FROM User WHERE Name =: component.Owner.Name];
            }catch(Exception e){
                System.debug('Exception in user Query'+e);
            }
            */
                 
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
                      if(qcList.Component_Name__r.Name__c != 'Watch-Head'){
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
          
          List<String> defindIP5 = new List<String>();   //Metal Strap- code block to add product information to list. Product information fields are defined and are static.       
                defindIP5.add('Module');
                defindIP5.add('Watch color');
                defindIP5.add('Case to Strap');
                defindIP5.add('Watch Total Length in mm');                
                defindIP5.add('Crown');
                            
                
                try{
                    if(component.Sample_Category__c != 'Competitor Products'){
                        quesResRecords = [SELECT id,Name,Comments__c,Question_Name__c,isManual__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: recID AND Question__r.Question__c IN :defindIP5 order by Component_No__r.Name__c,Question__r.order_number__c];               
                    }else{
                        quesResRecords = [SELECT id,Name,Comments__c,Question_Name__c,isManual__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: recID order by Component_No__r.Name__c,Question__r.order_number__c];               
                    }
                    materialValue = [select value__c from QC_Input_Data__c where Component_No__c  =: recID AND Question__r.Question__c ='Material'].value__c;
                }catch(Exception e){
                     System.debug('Exception in case Query'+e);
                }
                system.debug('*quesResRecords*'+quesResRecords );
                //boolean IsGlsMet = false;
                //boolean Isconstruction = false;
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
                    fwInputList.add(dpObj);
                    system.debug('**List Contains**'+metalInputList);
                }                
                defindIP5.clear();
                
      //Full watch - code block to add test parameters of full watch to list          
            //Query all the captured test findings of full watch.   
               try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
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
                
               /*
                   Case - code block to add product information to list. Product information fields are defined and are static.
                   Input parameters of Case are hardcoded because these are the only ones which are displayed in the reports.
              */
               
               List<String> defindIP = new List<String>();   //Case - code block to add product information to list. Product information fields are defined and are static.       
                defindIP.add('Construction');
                defindIP.add('BC Fitting');
                defindIP.add('BR Fitting');
                defindIP.add('Type of Glass');                
                defindIP.add('Glass Profile');            
                defindIP.add('Glass Fitting');
                /*
                    Earlier Provision For Spacer Assembly was not there in case component.  
                    Modified Date: 4-21-2015 
                    Provision For Spacer Assembly has been added to case component based on change request requirement.
                */
                defindIP.add('Provision For Spacer Assembly'); 
                // added by sudama
                defindIP.add('Add on Joints');
                defindIP.add('Special Feature in Case');
                defindIP.add('Material');
                         
                try{
                    if(component.Sample_Category__c != 'Competitor Products'){
                        quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: caseCom.id AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];               
                   }else{
                        quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: caseCom.id order by Component_No__r.Name__c,Question__r.order_number__c];               
                   }
                    materialValue = [select value__c from QC_Input_Data__c where Component_No__c  =: caseCom.id AND Question__r.Question__c ='Material'].value__c;
                }catch(Exception e){
                     System.debug('Exception in case Query'+e);
                }
                system.debug('*quesResRecords*'+quesResRecords );
                boolean IsGlsMet = false;
                boolean Isconstruction = false;
                if(!quesResRecords.isEmpty()){
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
                    //Code to apply colors based on conditions
                    if(each.Question__r.Question__c == 'glass material' && (each.Value__c == 'mineral' || each.Value__c == 'Sapphire')){ 
                        IsGlsMet = true;
                    }else if(each.Question__r.Question__c == 'Glass Profile' && (each.Value__c == 'Double Side Curved')){ 
                        IsGlsMet = true;
                    } 
                    else  if(each.Question__r.Question__c == 'BC Fitting' && each.Value__c == 'Snap' && materialValue =='Ceramic'){
                       dpObj.color = 'Red';
                    }else if (each.Question__r.Question__c == 'BC Fitting' && each.Value__c == 'Hook' && (materialValue =='Ceramic' || materialValue =='Plastic')){
                       dpObj.color = 'Red';
                    }else if (each.Question__r.Question__c == 'BC Fitting' && each.Value__c == 'Thread' && (materialValue =='Plastic' || materialValue =='Aluminium')){
                       dpObj.color = 'Red';
                    }else if(each.Question__r.Question__c == 'BR Fitting' && (each.Value__c == 'Snap' || each.Value__c == 'Thread' || each.Value__c == 'Screw')  && materialValue =='Ceramic'){
                       dpObj.color = 'Red';
                    }else if(each.Question__r.Question__c == 'Glass Fitting' && each.Value__c == 'Gasket' && IsGlsMet && IsGlsMet){
                       dpObj.color = 'Red';
                    }
                    caseInputList.add(dpObj);
                    system.debug('**List Contains**'+caseInputList);
                }   
               }             
                defindIP.clear();      
                
                
               
      // Case - code block to add test parameter information to list.                 
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: caseCom.id  AND (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Back Cover' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Crown' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
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
      
      
      // Case - code block to add test parameter information to list(Only Material )                 
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: caseCom.id  AND (Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Case Center' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Back Cover' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Bezel Ring' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Screw' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Pin' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Crown' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
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
                    caseTestParamListM.add(testParamObj);
                }
                
                 // Case - code block to add test parameter information to list(Only Plating )                 
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: caseCom.id  AND (Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Case Center' OR Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Bezel Ring') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
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
                    caseTestParamListP.add(testParamObj);
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
                
                                            
               List<String> defindIP1 = new List<String>();   //Dial - code block to add product information to list. Product information fields are defined and are static.       
                defindIP1.add('Dial No');
                defindIP1.add('Material');
                defindIP1.add('Dial Construction');
                defindIP1.add('Finishing');                
                defindIP1.add('Dial Feature');            
                
                try{
                    if(component.Sample_Category__c != 'Competitor Products'){
                        quesResRecords = [SELECT id,Name,Comments__c,Question_Name__c,isManual__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: dialCom.id AND Question__r.Question__c IN :defindIP1 order by Component_No__r.Name__c,Question__r.order_number__c];               
                    }else{
                        quesResRecords = [SELECT id,Name,Comments__c,Question_Name__c,isManual__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: dialCom.id order by Component_No__r.Name__c,Question__r.order_number__c];               
                    }
                    materialValue = [select value__c from QC_Input_Data__c where Component_No__c  =: dialCom.id AND Question__r.Question__c ='Material'].value__c;
                }catch(Exception e){
                     System.debug('Exception in case Query'+e);
                }
                system.debug('*quesResRecords*'+quesResRecords );
                //boolean IsGlsMet = false;
                //boolean Isconstruction = false;
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
                    //Code to apply colors based on conditions
                    
                    dialInputList.add(dpObj);
                    system.debug('**List Contains dialInputList**'+dialInputList);
                }                
                defindIP.clear();      
                
      // Dial - code block to add test parameter information to list. 
           
              try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: dialCom.Id  order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
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
    }//End of constructor
    }
}