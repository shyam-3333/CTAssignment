public with sharing class QC_BatteryDetailedReport {
   public QC_Components__c component            {get;set;}
   // public List<User> l1l2UserName               {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}     //List to hold the input parameters
    public List<QC_Test_Data__c> testParamRecords{get;set;}     //List to hold all the test findings 
    public ID recId     {get;set;}
    public List<DefinedParameters> batteryList{get;set;} 
    public List<DefinedTestParam> batteryTestParamList{get;set;}
    public List<DefinedTestParam> batteryVisualInception{get;set;}
    public List<DefinedTestParam> batteryLeakage{get;set;}
   // public set<id> uids{get;set;}
   // public user lst {get;set;}
   // public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}            
    
    public class DefinedTestParam {
        public String spec{get;set;}
        public String testName{get;set;}
        public String specification{get;set;} 
        public String acceptanceCritaria{get;set;}
        public String uUOM{get;set;}
        public String observation{get;set;}
        public String verdict{get;set;}    
        public String conclusion{get;set;} 
        public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value   
        public String determinedVal{get;set;} 
    }
    public class DefinedParameters {
        public String inputParam{get;set;}
        public String value{get;set;}
        public String comment{get;set;}
    }
    public QC_BatteryDetailedReport(){
        recId=Apexpages.currentpage().getParameters().get('id');
        component               = new QC_Components__c();
       // l1l2UserName            = new List<User>();
        quesResRecords          = new List<QC_Input_Data__c>();    
        testParamRecords        = new List<QC_Test_Data__c>(); 
        batteryList             = new List<DefinedParameters>();
        batteryTestParamList    = new List<DefinedTestParam>();
        batteryVisualInception  = new List<DefinedTestParam>();
        batteryLeakage          = new List<DefinedTestParam>();
        //uids        = new set<id>();
       // lst         = new user();
       // lst1        = new user();
        if(recId != null){
            try{
                component=[SELECT id,Name,Owner.Name,General_Observation__c,Price__c,imageurl__c,imageurl2__c,imageurl3__c,Component_Status__c,Name__c,Parent__c,Final_Verdict__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:recId ]; 
            }catch(Exception e){
                System.debug('Exception in QL'+e);
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
         
            //Define the input parameters to be displayed in the report.
            List<String> defindIP = new List<String>();
            defindIP.add('Battery Code.(SKU)');
            defindIP.add('Battery Type');
            defindIP.add('Month of Manufacturing');
            defindIP.add('Spec. Sheet Ref'); 
            defindIP.add('Capacity(mAh)');
            defindIP.add('Resistor - Spec');
            defindIP.add('Resistor - Actual');
            defindIP.add('Chemical system');
            try{
                if(component.Sample_Category__c != 'Competitor Products'){
                quesResRecords = [SELECT id,Name,Comments__c ,Component_No__c,Question_Name__c,isManual__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: component.id AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];        
                }else{
                quesResRecords = [SELECT id,Name,Comments__c,Question_Name__c,Component_No__c,isManual__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: component.id order by Component_No__r.Name__c,Question__r.order_number__c];          
                }
            }catch(Exception e){
                System.debug('Exception in battery Query'+e);
            }
            //Iterate through all the input parameters and add them into batteryList  to display in the page.
            for(QC_Input_Data__c each :quesResRecords) {
                DefinedParameters dpObj = new DefinedParameters();
                 if(each.isManual__c){
                           dpObj.inputParam = each.Question_Name__c;
                    }
                    else{
                           dpObj.inputParam = each.Question__r.Question__c;
                    }
                dpObj.value             = each.Value__c;
                dpObj.comment           = each.Comments__c;
                batteryList.add(dpObj); 
            }//End of for block               
            defindIP.clear(); 
                           
            //Define the test findings to be displayed in the report.
            defindIP.add('Initial Capacity ( n:10)');
            defindIP.add('1 Year Storage condition (n:10)');
            defindIP.add('2 Year Storage condition (n:10)');
            defindIP.add('3 Year Storage condition (n:10)');
            try{
                 testParamRecords = [SELECT id,Name,determined_Value__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: component.id AND Condition_Ref__r.Question__r.Test_Name__c IN :defindIP AND (Conclusion__c != null Or Conclusion__c != '')];
            }catch(Exception e){
                System.debug('Exception in battery Query'+e);
            }
            //Iterate through all the test fndings and add them into batteryTestParamList list to display in the page.
            for(QC_Test_Data__c testDat : testParamRecords){
                DefinedTestParam testParamObj   = new DefinedTestParam();
                testParamObj.testName           = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                testParamObj.specification      = testDat.Condition_Ref__r.Question__r.Specification__c;
                testParamObj.uUOM               = testDat.Condition_Ref__r.Question__r.UOM__c;
                testParamObj.verdict            = testDat.Conclusion__c;
                testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                testParamObj.determinedVal      = testDat.determined_Value__c;
                batteryTestParamList.add(testParamObj);
            }//End of for block
            System.debug('battery test parameter'+batteryTestParamList);
            defindIP.clear();
            testParamRecords.clear();
            
            defindIP.add('Visual Inspection');
            try{
                 testParamRecords = [SELECT id,Name,determined_Value__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: component.id AND Condition_Ref__r.Question__r.Test_Name__c IN :defindIP AND (Conclusion__c != null Or Conclusion__c != '')];
           }catch(Exception e){
                System.debug('Exception in battery Query'+e);
            }
            
            //Iterate through all the test fndings and add them into batteryTestParamList list to display in the page.
            for(QC_Test_Data__c testDat : testParamRecords){
                DefinedTestParam testParamObj   = new DefinedTestParam();
                testParamObj.testName           = testDat.Condition_Ref__r.Question__r.Test_Name__c; 
                testParamObj.conclusion         = testDat.Conclusion__c;
                testParamObj.verdict            = testDat.Observation__c;
                testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                testParamObj.determinedVal      = testDat.determined_Value__c;
                batteryVisualInception.add(testParamObj);
            }//End of for block
            defindIP.clear();
            testParamRecords.clear();
            defindIP.add('Non-Defective Battery');
            defindIP.add('Defective Battery');
            defindIP.add('Leaks');
            try{
                testParamRecords = [SELECT id,Name, determined_Value__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: component.id AND Condition_Ref__r.Question__r.Test_Name__c IN :defindIP AND (Conclusion__c != null Or Conclusion__c != '')];
            }catch(Exception e){
                System.debug('Exception in battery Query'+e);
            }
            for(QC_Test_Data__c testDat : testParamRecords){
                DefinedTestParam testParamObj   = new DefinedTestParam();
                testParamObj.testName           = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                testParamObj.specification      = testDat.Condition_Ref__r.Question__r.Specification__c;
                testParamObj.uUOM               = testDat.Condition_Ref__r.Question__r.UOM__c;
                testParamObj.acceptanceCritaria = testDat.Condition_Ref__r.Question__r.Acceptance_Criteria__c;
                testParamObj.observation        = testDat.Observation__c;
                testParamObj.verdict            = testDat.Conclusion__c;
                testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                testParamObj.determinedVal      = testDat.determined_Value__c;
                batteryLeakage.add(testParamObj);
            }//End of for block
            defindIP.clear();
            testParamRecords.clear();
         }//End of if block
     }
}