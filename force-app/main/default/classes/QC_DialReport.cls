/*
    Name:                   QC_CaseReport 
    Created By:             Shamsher Singh
    Created Date:           30/03/2015
    Modified By:            Shamsher Singh
    Modified Description-1: Included CommentsandRemarks field in query and inner class to be displayed in reports.                     
    Last Modified Date:     1. 4-21-2015
                            
    Description:
    Methods Used:
*/
public with sharing class QC_DialReport {
    public QC_Components__c component            {get;set;}         //Parent component
    //public list<User> l1l2UserName                     {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records  
    public ID recId     {get;set;}    
    public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records 
   public ProcessInstance lstProcessInstance {get;set;}     
   public ProcessInstanceStep lstStepsInstance{get;set;}   
    //public user lst {get;set;}
    //public user lst1 {get;set;}
   //public set<id> uids{get;set;}    
   public String firstActorName {get;set;} 
    public String secondActorName {get;set;}
                       
    public class DefinedParameters {    
        public String inputParam{get;set;}          //String variable to hold the input question
        public String value{get;set;}               //String variable to hold the input response
        
    }
    public class DefinedTestParam {
        public String testName{get;set;}            //String variable to hold the test name value
        public String uom{get;set;}
        public String specification{get;set;}       //String variable to hold the test specification value
        public String observation{get;set;}         //String variable to hold the test observation value
        public String verdict{get;set;}             //String variable to hold the test verdict value   
        public String commentAndRemarks{get;set;}   //Comments and remark value to capture in test finding      
    }
    public List<DefinedParameters> dialDialNo{get;set;}
    public List<DefinedTestParam> dialTestParamList{get;set;}           //List to hold the dial test parameter    
    public QC_DialReport(){
        dialTestParamList   = new List<DefinedTestParam>();
        //l1l2UserName = new list<User>();
        lstStepsInstance  = new ProcessInstanceStep();
        lstProcessInstance = new ProcessInstance();
        dialDialNo  = new List<DefinedParameters>();
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
                //Query the component details
                component=[SELECT id,Owner.Name,Price__c,imageurl__c,imageurl2__c,imageurl3__c,General_Observation__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,Published_Date__c  FROM QC_Components__c WHERE id =:recId ]; 
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
         
         
            
       //Dial - code block to add Dial no into list and display in report
                List<String> defindIP = new List<String>();
                defindIP.add('Dial No');
                try{
                    quesResRecords = [SELECT id,Name,Component_No__c,Question__r.order_number__c,Question__r.Question__c,Component_No__r.Name__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c  =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];
                }catch(Exception e){
                     System.debug('@@Error@@'+e);
                }
                for(QC_Input_Data__c each :quesResRecords) {
                    DefinedParameters dpObj = new DefinedParameters();
                    dpObj.inputParam        = each.Question__r.Question__c;
                    dpObj.value             = each.Value__c;
                    dialDialNo.add(dpObj);
                }
                defindIP.clear();
      // Dial - code block to add test parameter information to list. 
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId and Conclusion__c!=''];
                    
                }catch(Exception e){
                    System.debug('@@Error@@'+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj   = new DefinedTestParam();
                    // Added by Sanjeev Shukla for manual and default test data
                    if(testDat.isManual__c){
                        testParamObj.testName       = testDat.Test_Name__c;    // for manual test data
                        testParamObj.uom            = testDat.UOM_Input__c;   // for manual test data
                        testParamObj.specification  = testDat.Specification_Input__c;  // for manual test data
                    }else{
                        testParamObj.testName       = testDat.Condition_Ref__r.Question__r.Test_Name__c; // for default test data
                        testParamObj.uom            = testDat.Condition_Ref__r.Question__r.UOM__c; // for default test data
                        testParamObj.specification  = testDat.Condition_Ref__r.Question__r.Specification__c; // for default  test data
                    }
                    testParamObj.observation        = testDat.Observation__c;
                    testParamObj.verdict            = testDat.Conclusion__c;
                    testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                    dialTestParamList.add(testParamObj);
                }                
      //End of Dial data gathering and adding to list.     
        }
    }
}