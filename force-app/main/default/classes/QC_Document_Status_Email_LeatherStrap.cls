public with sharing class QC_Document_Status_Email_LeatherStrap{
    public QC_Components__c component;        //Parent component
    Public boolean colorID                       {get;set;}
    //public List<User> l1l2UserName                     {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records  
    public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records   
    public ID recId;    //To hold the record id   
    public ID compId{get;set;}                                  //To hold the record id   
    public string brandName;     
    //public set<id> uids{get;set;}
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
    public class DefinedTestParam {
        public String uom{get;set;}                //String variable to hold the test specification value
        public String testName{get;set;}            //String variable to hold the test name value
        public String specification{get;set;}       //String variable to hold the test specification value
        public String observation{get;set;}         //String variable to hold the test observation value
        public String verdict{get;set;}             //String variable to hold the test verdict value   
        public String commentAndRemarks{get;set;}   //Comments and remark value to capture in test finding         
    }
     public List<DefinedParameters> leatherStrapIPList{get;set;}
     public List<DefinedTestParam> leatherTestParamList{get;set;}           //List to hold the Metal Strap test parameter
     
    public QC_Components__c getComponent()
    {
            recId = compId;
            QC_Document_Status_Email_CompNew ();
            component=[SELECT id,Owner.Name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,Exception_Verdict__c,Comment__c,Published_Date__c  FROM QC_Components__c WHERE id =:compId]; 
       
        return component;
    } 
    
     public void QC_Document_Status_Email_CompNew (){
       // l1l2UserName = new List<User>();
     //   recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        quesResRecords = new List<QC_Input_Data__c>();    
        testParamRecords = new List<QC_Test_Data__c>();  
        set<String> childId = new set<String>();
        leatherStrapIPList  = new   List<DefinedParameters>();
        leatherTestParamList    = new   List<DefinedTestParam>(); 
       // uids        = new set<id>();
      //  lst         = new user();
      //  lst1        = new user();
        colorID     = false;
        if(recId != null){        
            try{
                //Query the component details
                component=[SELECT id,Owner.Name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,Exception_Verdict__c,Comment__c,Published_Date__c  FROM QC_Components__c WHERE id =:recId ]; 
            }catch(Exception e){
                 //ApexPages.addMessages(e) ; 
                System.debug('@@Error@@'+e);
            } 
            //For fetching First Approver and Second Level Approver. // modified by Anindwita
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
               List<String> defindIP = new List<String>();       //Leather Strap - code block to add product information to list.          
                defindIP.clear();
                defindIP.add('Construction Type');
                defindIP.add('Catch Size in mm');
                defindIP.add('Strap Length - Long Piece (6H)'); 
                defindIP.add('Strap Length -Short Piece (12H)');
                defindIP.add('Buckle Type');  
                defindIP.add('Gender');
              
                defindIP.add('Case to Strap');
                defindIP.add('Catch Type');
                defindIP.add('Strap Color'); 
                defindIP.add('Buckle Connector'); 
                defindIP.add('Strap Color'); 
                defindIP.add('Material Chemical Composition - Clasp / Buckle');    
                defindIP.add('Special Feature');      
                defindIP.add('Strap description'); 
                defindIP.add('Type of strap');     
                defindIP.add('Strap description');
           		defindIP.add('Top leather');
            	defindIP.add('Bottom Lining');
 
                quesResRecords.clear();
                try{
                        if(component.Sample_Category__c != 'Competitor Products'){
                            quesResRecords = [SELECT id,Name,isManual__c,Question_Name__c,Comments__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c,Response_Id__c,Response_Id__r.Response__c FROM QC_Input_Data__c WHERE Component_No__c =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];
                        }else{
                            quesResRecords = [SELECT id,Name,isManual__c,Question_Name__c,Comments__c,Component_No__c,Value__c,Question__c,Component_No__r.Name__c,Question__r.Question__c,Response_Id__c,Response_Id__r.Response__c FROM QC_Input_Data__c WHERE Component_No__c =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];
                        
                        }
                }catch(Exception e){
                    System.debug('Exception in Leather Strap Query'+e);
                }
                brandName =  component.Brand__r.Name != null ? component.Brand__r.Name : null;
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
                    leatherStrapIPList.add(dpObj);
                }
                testParamRecords.clear();
                defindIP.clear();
                /*
                 * comment
                */
                try{
                    if(![SELECT id FROM QC_Input_Data__c WHERE Component_No__c =: component.id AND Value__c = 'Oil pulled up' AND Question__r.Question__c = 'Type of strap'].isEmpty()){
                        colorID = true;
                        System.debug('********colorID *********** '+colorID );
                    }
                }catch(Exception  ex){
                
                }
                /*
                 * comment
                */
                try{
                    if(![SELECT id FROM QC_Input_Data__c WHERE Component_No__c =: component.id AND Value__c = 'Oil pulled up' AND Question__r.Question__c = 'Type of strap'].isEmpty()){
                        colorID = true;
                        System.debug('********colorID *********** '+colorID );
                    }
                }catch(Exception  ex){
                
                }
                System.debug('********colorID *********** '+colorID );
       /* 
            Leather Strap - code block to add test parameter information to list.      
      */        
                try{                  
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }catch(Exception e){
                     //ApexPages.addMessages(e) ; 
                    System.debug('Exception in test findings - leather strap'+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj = new DefinedTestParam();
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
                    testParamObj.observation = testDat.Observation__c;
                    testParamObj.verdict = testDat.Conclusion__c;
                    testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                    leatherTestParamList.add(testParamObj);
                }
      //End of Leather Strap data gathering and adding to list. 
        }
     }
}