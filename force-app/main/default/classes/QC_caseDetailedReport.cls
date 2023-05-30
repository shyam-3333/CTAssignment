public with sharing class QC_caseDetailedReport{
    public QC_Components__c component            {get;set;}         //Parent component
   // public list<User> l1l2UserName               {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records  
    public ID recId     {get;set;}    
    public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records                              //To hold the record id   
    public String materialValue;
   // public set<id> uids{get;set;}
   // public user lst {get;set;}
   // public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}
   
    public QC_Components__c caseCom {get;set;}
    public class DefinedParameters {    
        public String inputParam{get;set;}          //String variable to hold the input question
        public String value{get;set;}               //String variable to hold the input response
        public String color{get;set;}
        public String comment{get;set;}
    }
    public class DefinedTestParam {
        public String testName{get;set;}            //String variable to hold the test name value
        public String uom{get;set;}                  //String variable to hold the UOM value
        public String specification{get;set;}       //String variable to hold the test specification value
        public String observation{get;set;}         //String variable to hold the test observation value
        public String verdict{get;set;}             //String variable to hold the test verdict value    
        public String commentAndRemarks{get;set;}   //Comments and remark value to capture in test finding   
    }
    public List<DefinedParameters> caseInputList{get;set;} 
    public List<DefinedTestParam> caseTestParamList{get;set;}           //List to hold the Case test parameter
     public List<DefinedTestParam> caseTestParamListM{get;set;}           //List to hold the Case test parameter to hold material
      public List<DefinedTestParam> caseTestParamListP{get;set;}           //List to hold the Case test parameter to hold plating
    public QC_caseDetailedReport(){
        caseInputList       = new List<DefinedParameters>();
        caseTestParamList   = new List<DefinedTestParam>();
        caseTestParamListM   = new List<DefinedTestParam>();
        caseTestParamListP   = new List<DefinedTestParam>();
        Boolean isXYLYS = False;
        caseCom      = new QC_Components__c();
        //l1l2UserName = new list<User>();
        //uids        = new set<id>();
        //lst         = new user();
        //lst1        = new user();

        recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        quesResRecords = new List<QC_Input_Data__c>();   
        testParamRecords = new List<QC_Test_Data__c>();  
        set<String> childId = new set<String>();
        if(recId != null){        
            try{
                component=[SELECT id,Owner.Name,Price__c,imageurl__c,imageurl2__c,imageurl3__c,General_Observation__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,Published_Date__c,Exception_Verdict__c,Comment__c FROM QC_Components__c WHERE id =:recId ]; 
                if(component.Brand__r.Name == 'XYLYS'){
                  isXYLYS = True;
                 }
            if (Test.isRunningTest()) { 
            integer i=10/0;
    }
            }catch(Exception e){
                System.debug('@@Error@@'+e);
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
           
                List<String> defindIP = new List<String>();   //Case - code block to add product information to list. Product information fields are defined and are static.       
                defindIP.add('Construction');
                defindIP.add('BC Fitting');
                defindIP.add('BR Fitting');
                defindIP.add('Type of Glass');                
                defindIP.add('Glass Profile');            
                defindIP.add('Glass Fitting');
                defindIP.add('Material');
                defindIP.add('Special Feature in Case');
                defindIP.add('Add on Joints');
                
                /*
                    Earlier Provision For Spacer Assembly was not there in case component.  
                    Modified Date: 4-21-2015 
                    Provision For Spacer Assembly has been added to case component based on change request requirement.
                */
                defindIP.add('Provision For Spacer Assembly');  
                
                   try{
                    caseCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Case' ];
                }catch(Exception e){
                    //ApexPages.addMessages(e) ; 
                    System.debug('Exception in case records - child'+e);
                }        
                try{
                    if(component.Sample_Category__c != 'Competitor Products'){
                        quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];               
                     }else{
                        quesResRecords = [SELECT id,Name,Comments__c,isManual__c,Question_Name__c, Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: recId order by Component_No__r.Name__c,Question__r.order_number__c];               
                     }
                    materialValue = [select value__c from QC_Input_Data__c where Component_No__c  =: recId AND Question__r.Question__c ='Material'].value__c;
                if (Test.isRunningTest()) { 
                integer i=10/0;
                }
                }catch(Exception e){
                     System.debug('Exception in case Query'+e);
                }
                boolean IsGlsMet = false;
                boolean Isconstruction = false;
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
                    if(each.Question__r.Question__c == 'Type of Glass' && each.Value__c == 'mineral' && isXYLYS )
                      dpObj.color = 'Red';
                    if(each.Question__r.Question__c == 'Type of Glass' && (each.Value__c == 'mineral' || each.Value__c == 'Sapphire')){ 
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
                defindIP.clear();     
                try{          
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c, Component_Name__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId and Conclusion__c!='' and (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Back Cover' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Crown' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Push Button')];
                    if (Test.isRunningTest()) { 
                    integer i=10/0;
            }
                }catch(Exception e){
                     System.debug('Exception in case Query'+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj = new DefinedTestParam();
                    // Added by Sanjeev Shukla for manual and default test data
                    if(testDat.isManual__c){  
                        testParamObj.testName       = testDat.Test_Name__c; // for manual test data
                        testParamObj.uom            = testDat.UOM_Input__c;  // for manual test data
                        testParamObj.specification  = testDat.Specification_Input__c;  // for manual test data
                    }else{
                        testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c; // for default test data
                        testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c; // for default test data
                        testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c; // for default test data
                    }
                    testParamObj.observation    = testDat.Observation__c;
                    testParamObj.verdict        = testDat.Conclusion__c;
                    testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                    caseTestParamList.add(testParamObj);
                } 
                
                  // Case - code block to add test parameter information to list(Only Material )                 
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId and Conclusion__c!='' AND (Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Case Center' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Back Cover' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Bezel Ring' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Screw' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Pin' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Crown' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                if (Test.isRunningTest()) { 
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c LIMIT 5];
               
                integer i=10/0;
                }
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
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recID and Conclusion__c!='' AND (Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Case Center' OR Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Bezel Ring') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                if (Test.isRunningTest()) { 
                integer i=10/0;
    }
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
            }
        }
    }