public with sharing class QC_Document_Status_Email_Package{
    public QC_Components__c component;
     //public List<User> l1l2UserName              {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}     //List to hold the input parameters
    public List<QC_Test_Data__c> testParamRecords{get;set;}     //List to hold all the test findings 
    public ID recId; 
    public ID compId{get;set;}                                  //To hold the record id   
    public List<DefinedParameters> packagingList{get;set;} 
    public List<DefinedTestParam> packagingTestParamList{get;set;}
    //public set<id> uids{get;set;}
    //public user lst {get;set;}
    //public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}

    public class DefinedTestParam {
        public String testName{get;set;}
        public String specification{get;set;}
        public String acceptanceCritaria{get;set;}
        public String uUOM{get;set;}
        public String observation{get;set;}
        public String verdict{get;set;}     
        public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value    
    }
    public class DefinedParameters {
        public String inputParam{get;set;}
        public String value{get;set;}
        public String comment{get;set;}
    }
    
     public QC_Components__c getComponent()
    {
            recId = compId;
            QC_Document_Status_Email_CompNew ();
            component=[SELECT id,Owner.Name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Component_Status__c,Name__c,Parent__c,Final_Verdict__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:compId]; 
       
        return component;
    } 
    
    public void QC_Document_Status_Email_CompNew (){
        //l1l2UserName            = new List<User>();
      //  recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        quesResRecords = new List<QC_Input_Data__c>();    
        testParamRecords = new List<QC_Test_Data__c>(); 
        packagingList = new List<DefinedParameters>();
        packagingTestParamList = new List<DefinedTestParam>();
        //uids        = new set<id>();
        //lst         = new user();
        //lst1        = new user();

        if(recId != null){
            try{
                component=[SELECT id,Owner.Name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Component_Status__c,Name__c,Parent__c,Final_Verdict__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:recId ]; 
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
            
            List<String> defindIP = new List<String>(); //Define the input parameters to be displayed in the report.
            defindIP.add('Box Type');
            defindIP.add('Gender');
            defindIP.add('Material');
            defindIP.add('Finishing'); 
            defindIP.add('Hinges');
            defindIP.add('Cladding');
            quesResRecords = [SELECT id,Name,Comments__c, Component_No__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c WHERE Component_No__c =: component.id AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];
            System.debug('@@@@Questions of the component'+quesResRecords);
            if(test.isRunningTest()){
                quesResRecords = [SELECT id,Name,Comments__c, Component_No__c,Question__r.Question__c,Value__c FROM QC_Input_Data__c ];
            }
            //Iterate through all the input parameters and add them into packagingList list to display in the page.
            for(QC_Input_Data__c each :quesResRecords) {
                DefinedParameters dpObj = new DefinedParameters();
                dpObj.inputParam        = each.Question__r.Question__c;
                dpObj.value             = each.Value__c;
                dpObj.comment           = each.Comments__c;
                packagingList.add(dpObj);   
            }//End of for block
            system.debug('packaging list --'+packagingList);                
            defindIP.clear(); 
            //Define the test findings to be displayed in the report.
            //defindIP.add('SHOCK & BUMP TEST');
            //defindIP.add('ROLL TEST');
            //defindIP.add('DROP TEST');
            testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Acceptance_Criteria__c, Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId AND (Conclusion__c !=null OR Conclusion__c !='') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
            //AND Condition_Ref__r.Question__r.Test_Name__c IN :defindIP
            System.debug('@@@@test records of the component'+testParamRecords);
            //Iterate through all the test fndings and add them into packagingTestParamList list to display in the page.
            for(QC_Test_Data__c testDat : testParamRecords){
                DefinedTestParam testParamObj   = new DefinedTestParam();
                // Added by Sanjeev Shukla for manual and default test data
                if(testDat.isManual__c){
                    testParamObj.testName           = testDat.Test_Name__c;
                    testParamObj.uUOM                = testDat.UOM_Input__c;
                    testParamObj.acceptanceCritaria = testDat.Acceptance_Criteria__c;
                    testParamObj.specification      = testDat.Specification_Input__c;
                }else{
                    testParamObj.testName           = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                    testParamObj.uUOM                = testDat.Condition_Ref__r.Question__r.UOM__c;
                    testParamObj.acceptanceCritaria = testDat.Condition_Ref__r.Question__r.Acceptance_Criteria__c;
                    testParamObj.specification      = testDat.Condition_Ref__r.Question__r.Specification__c;
                }
                testParamObj.observation        = testDat.Observation__c;
                testParamObj.verdict            = testDat.Conclusion__c;
                testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                packagingTestParamList.add(testParamObj);
            }//End of for block
            System.debug('packaging test parameter'+packagingTestParamList);
         }//End of if block
     }//End of constructor
}