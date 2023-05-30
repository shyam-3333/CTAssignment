public with sharing class QC_Document_Status_Email_Module{
    public QC_Components__c component;
    public List<QC_Input_Data__c> quesResRecords {get;set;}     //List to hold the input parameters
    //public List<User> l1l2UserName              {get;set;}         //checked by user and approved bu user
    public List<QC_Test_Data__c> testParamRecords{get;set;}     //List to hold all the test findings 
    public ID recId;   
    public ID compId{get;set;}                                  //To hold the record id   
    public List<DefinedParameters> moduleIPList{get;set;} 
    public List<DefinedParameters> moduleModuleRef{get;set;}
    public List<DefinedParameters> moduleModuleFunction{get;set;}
    public List<DefinedParameters> moduleSampleReceived{get;set;}
    public List<DefinedTestParam>  moduleTestParamList{get;set;}
    //public set<id> uids{get;set;}
   // public user lst {get;set;}
    //public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}
    public Boolean typeOfModule {get;set;}
    
    public class DefinedTestParam {
        public String testName{get;set;}
        public String specification{get;set;}
        public String uUOM{get;set;}
        public String verdict{get;set;}   
        public String  observation{get;set;} 
        public String  observation1{get;set;}
        public String  observation2{get;set;}
        public String  observation3{get;set;}
        public String  observation4{get;set;}
        public String  observation5{get;set;} 
        public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value
        public Boolean isManual {get;set;}
        public Boolean isParent {get;set;}
        public Boolean isLast   {get;set;} 
        public Boolean isVisible{get;set;} 
        public String noOfSample{get;set;}     
    }
    public class DefinedParameters {
        public String inputParam{get;set;}
        public String value{get;set;}
    }
    public QC_Components__c getComponent()
    {
            recId = compId;
            QC_Document_Status_Email_CompNew ();
            component=[SELECT id,Name,Name__c,Owner.name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Published_Date__c,Final_Verdict__c,Parent__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:compId]; 
       
        return component;
    } 
    
    public void QC_Document_Status_Email_CompNew (){
     //   recId=Apexpages.currentpage().getParameters().get('id');
        component               = new QC_Components__c();
        quesResRecords          = new List<QC_Input_Data__c>();    
        //l1l2UserName            = new List<User>();
        testParamRecords        = new List<QC_Test_Data__c>(); 
        moduleIPList            = new List<DefinedParameters>();
        moduleModuleRef         = new List<DefinedParameters>();
        moduleTestParamList     = new List<DefinedTestParam>();
        moduleSampleReceived    = new List<DefinedParameters>();
        //uids        = new set<id>();
        //lst         = new user();
        //lst1        = new user();
         if(recId != null){
            try{
                component=[SELECT id,Name,Name__c,Owner.name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Published_Date__c,Final_Verdict__c,Parent__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:recId ]; 
                System.debug('@@@@Component Details'+component);
            }catch(Exception e){
                System.debug('Exception in QL'+e);
            } 
            
            //For fetching First Approver and Second Level Approver . //modified by Anindwita.
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
           
            List<String> defindIP = new List<String>();
            defindIP.add('Module Ref');
            defindIP.add('Module Function');
            defindIP.add('Sample received as');
            defindIP.add('Type of Module');
            defindIP.add('Battery Holding');
            defindIP.add('PMH Type');
            quesResRecords = [SELECT id,Name,Component_No__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];
            for(QC_Input_Data__c each :quesResRecords) {
                DefinedParameters dpObj = new DefinedParameters();
                dpObj.inputParam        = each.Question__r.Question__c;
                dpObj.value             = each.Value__c;
                if(dpObj.value == 'Smart Watch'){
                   typeOfModule = True;
                }
                moduleModuleRef.add(dpObj); 
            }//End of for block
       //     defindIP.clear();            
            system.debug('moduleModuleRef list --'+moduleModuleRef);      
            
         //   defindIP.add('Battery Holding');
         //   defindIP.add('PMH Type');
            if(component.Sample_Category__c != 'Competitor Products'){
                quesResRecords = [SELECT id,Name,Component_No__c,isManual__c,Question_Name__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];
            }else{
                quesResRecords = [SELECT id,Name,Component_No__c,isManual__c,Question_Name__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: recId order by Component_No__r.Name__c,Question__r.order_number__c];    
            }
            for(QC_Input_Data__c each :quesResRecords) {
                DefinedParameters dpObj = new DefinedParameters();
                  if(each.isManual__c){
                           dpObj.inputParam = each.Question_Name__c;
                    }
                    else{
                           dpObj.inputParam = each.Question__r.Question__c;
                    }
                dpObj.value             = each.Value__c;
                moduleIPList.add(dpObj);    
            }//End of for block
            system.debug('module list --'+moduleIPList);                
            defindIP.clear(); 
                        
            testParamRecords = [SELECT id,Name,isManual__c,Condition_Ref__r.isVisible__c,No_of_Samples__c, Specification_Input__c, Test_Name__c, UOM_Input__c,isLast__c, isParent__c,Comments_and_Remarks__c,Observation1__c,Observation2__c,Observation3__c,Observation4__c,Observation5__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId and Conclusion__c!=null];
            System.debug('@@@@test records of the component'+testParamRecords);
            //Iterate through all the test fndings and add them into batteryTestParamList list to display in the page.
            
            for(QC_Test_Data__c testDat : testParamRecords){
                DefinedTestParam testParamObj   = new DefinedTestParam();
                // Added by Sanjeev Shukla for manual and default test data
                if(testDat.isManual__c){
                    testParamObj.isManual = true;
                    testParamObj.testName           = testDat.Test_Name__c;        //Name of the test
                    testParamObj.specification      = testDat.Specification_Input__c;    //Evaluation criteria
                    testParamObj.uUOM               = testDat.UOM_Input__c;              //UOM
                }else{
                    testParamObj.testName           = testDat.Condition_Ref__r.Question__r.Test_Name__c;        //Name of the test
                    System.debug('myTest Name='+testParamObj.testName);
                    testParamObj.specification      = testDat.Condition_Ref__r.Question__r.Specification__c;    //Evaluation criteria
                   // testParamObj.uUOM             = string.escapeSingleQuotes(testDat.Condition_Ref__r.Question__r.UOM__c);              //UOM
                    testParamObj.uUOM               = testDat.Condition_Ref__r.Question__r.UOM__c;              //UOM
                    testParamObj.isVisible          = testDat.Condition_Ref__r.isVisible__c;
                }
                testParamObj.isParent           = testDat.isParent__c;
                testParamObj.isLast             = testDat.isLast__c;
                testParamObj.verdict            = testDat.Conclusion__c;                                    //Conclusion/verdict
                testParamObj.observation        = testDat.Observation__c;
                testParamObj.observation1       = testDat.Observation1__c;              //Observation-1 after initial
                testParamObj.observation2       = testDat.Observation2__c;              //Observation-2 after initial
                testParamObj.observation3       = testDat.Observation3__c;              //Observation-3 after initial
                testParamObj.observation4       = testDat.Observation4__c;              //Observation-4 after initial
                testParamObj.observation5       = testDat.Observation5__c;              //Observation-5 after initial
                testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                testParamObj.noOfSample         = testDat.No_of_Samples__c;
                moduleTestParamList.add(testParamObj);
            }//End of for block
            System.debug('module test parameter'+moduleTestParamList);
            defindIP.clear();
            testParamRecords.clear();
         }
    }
}