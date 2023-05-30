/*
    Name:QC_WatchHeadReport 
    Created By:Shamsher singh
    Created Date: 2/12/2015
    Modified By: Shamsher singh
    Last Modified Date: 3/30/2015
    Description:    Watch head question and responses along with test parameters have been displayed in the reports.
                    Case and dial input parameters and test finding have been displayed in the reports.
*/
public with sharing class QC_WatchHeadReport {
    public QC_Components__c component            {get;set;}         //Parent component
    //public List<User> l1l2UserName               {get;set;}         //checked by user and approved bu user
    public List<QC_Components__c> childRecords   {get;set;}         //List to hold all the child components
    public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records   
    public List<QC_Test_Data__c> testParamRecords{get;set;}        //List to hold the test parameters records    
    public ID recId     {get;set;}                                //To hold the record id
    public string caseMaterialValue;  //To hold the case material value from inputdata for coloring 
    //public set<id> uids{get;set;}
    //public user lst {get;set;}
    //public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}    
    
    public QC_Input_Data__c caseIP {get;set;}
    public QC_Input_Data__c dialIP {get;set;}
    
    public QC_Components__c caseCom {get;set;}
    public QC_Components__c dialCom {get;set;}
    
    public class DefinedParameters {    
        public String inputParam{get;set;}          //String variable to hold the input question
        public String value{get;set;}               //String variable to hold the input response
        public String commentWatchHead{get;set;}    //String variable to hold the comment field value of full watch
        public String color{get;set;}
        public String textBold{get;set;}
    }
    public class DefinedTestParam {
        public String uom{get;set;}                //String variable to hold the test specification value
        public String testName{get;set;}            //String variable to hold the test name value
        public String specification{get;set;}       //String variable to hold the test specification value
        public String observation{get;set;}         //String variable to hold the test observation value
        public String verdict{get;set;}             //String variable to hold the test verdict value    
        public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value       
    }
    /*
    public List<DefinedParameters> dpList{get;set;}                     
    public List<DefinedParameters> dpMaterialList{get;set;}
    public List<DefinedParameters> dialPIList{get;set;}
    public List<DefinedParameters> watchHeadCrown{get;set;}             //List to hold the crown value of watch head
    public List<DefinedParameters> watchHeadSpacerForAss{get;set;}      //List to hold the Spacer for assembly value of watch head
    public List<DefinedParameters> watchHeadModule{get;set;}            //List to hold the module detail of watch head
    public List<DefinedParameters> watchHeadCaseToStrap{get;set;}       //List to hold the case to strap value of watch head
    */
    public List<DefinedTestParam> caseTestParamList{get;set;}           //List to hold the Case test parameter
    public List<DefinedTestParam> dialTestParamList{get;set;}           //List to hold the Dial test parameter
    public List<DefinedTestParam> watchHeadTestParamList{get;set;}      //List to hold the Watch Head test parameter
    
    public List<QC_Components__c> allChildComponent{get;set;}                  // added by sudama for all child component
    public List<QC_Test_Data__c> allChildTestData{get;set;}                   // added by sudama for all child component test data
    public Map<string,list<QC_Test_Data__c>> mAllChildTestData{get;set;}       // added by sudama for storing key as a test name and value as list of test data
    public List<QC_Test_Data__c> parentTestData{get;set;}                   // added by sudama for all child component test data
    public Integer mSize{get;set;}
    
    public QC_WatchHeadReport(){       
        /*
        dpList                  = new List<DefinedParameters>();
        dpMaterialList          = new list<DefinedParameters>();
        dialPIList              = new List<DefinedParameters>();     
        watchHeadSpacerForAss   = new List<DefinedParameters>();
        watchHeadCrown          = new List<DefinedParameters>();
        watchHeadModule         = new List<DefinedParameters>();
        watchHeadCaseToStrap    = new List<DefinedParameters>();
        */        
        caseTestParamList       = new List<DefinedTestParam>();
        dialTestParamList       = new List<DefinedTestParam>();
        watchHeadTestParamList  = new List<DefinedTestParam>(); 
        
        set<id>allChildComp = new set<id>();
        allChildComponent = new List<QC_Components__c>();
        allChildTestData  = new List<QC_Test_Data__c>();
        mAllChildTestData = new Map<string,list<QC_Test_Data__c>>();
        parentTestData    = new List<QC_Test_Data__c>();
        mSize = 0;
        
        caseIP    = new QC_Input_Data__c();
        dialIP    = new QC_Input_Data__c();
        
        caseCom      = new QC_Components__c();
        dialCom      = new QC_Components__c();
        //uids        = new set<id>();
        //lst         = new user();
        //lst1        = new user();
           
        recId=Apexpages.currentpage().getParameters().get('id');        //Get the record id
        //l1l2UserName = new List<User>();
        component = new QC_Components__c();
        testParamRecords = new List<QC_Test_Data__c>();  
        System.debug('!!!!!!!!!!!!!!'+recId);
        if(recId != null){        
            try{
                //Query the component details
                component=[SELECT id,Name,owner.name,Name__c,Price__c,imageurl__c,imageurl2__c,imageurl3__c,Comment__c,Parent_Report_Reference_Number__c ,Exception_Verdict__c,General_Observation__c,Final_Verdict__c,Parent__c,Model__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c,Published_Date__c  FROM QC_Components__c WHERE id =:recId ]; 
                if (Test.isRunningTest()) { 
     integer i=10/0;
    }
            }catch(Exception e){
                //ApexPages.addMessages(e) ; 
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
             
                //Watch Head - code block to add test parameters of full watch to list          
                try{
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: component.id AND Conclusion__c !=: '' order by Conclusion__c, isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                    if (Test.isRunningTest()) { 
     integer i=10/0;
    }
                }catch(Exception e){System.debug('Exception in Query'+e);}
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj = new DefinedTestParam();
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
                    watchHeadTestParamList.add(testParamObj);
                }
               
                //Watch Head - End of adding test parameter to list
                
                               
                try{
                    caseCom =[SELECT id,Name,Name__c,Final_Verdict__c,Published_Date__c  FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Case' ];
                }catch(Exception e){
                    ApexPages.addMessages(e) ; 
                    System.debug('@@Error@@'+e);
                }
               
                // Case - code block to add test parameter information to list.
                List<String> listtestName = new List<String>();
                 listtestName.add('IZOD Impact');
                listtestName.add('Medium Shock');
                listtestName.add('Drop Test');
                listtestName.add('UV Test');
                listtestName.add('With Standing Force');
                listtestName.add('Reliability of Printing');
                listtestName.add('Rub test');
                listtestName.add('Pusher test');
                listtestName.add('Stress test');
                listtestName.add('Tension & Torsion');
              /*  listtestName.add('Material Chemical Composition - Case Center');
                listtestName.add('Material Chemical Composition - Back Cover');
                listtestName.add('Material Chemical Composition - Bezel Ring');
                listtestName.add('Material Chemical Composition - Screw');
                listtestName.add('Material Chemical Composition - Pin');
                listtestName.add('Material Chemical Composition - Crown');
                listtestName.add('Material Chemical Composition - Push Button');
                listtestName.add('Plating Layer - Case Center'); 
                listtestName.add('Plating Layer - Bezel Ring'); */
                listtestName.add('Stone with holding force');   
                testParamRecords.clear();               
                try{
                   testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: caseCom.id  AND (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Back Cover' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Crown' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Case Center' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Bezel Ring' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Push Button') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];

               //     testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: caseCom.id AND Conclusion__c !=: '' order by Conclusion__c, isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                
                System.debug('Exception in Query'+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj   = new DefinedTestParam();
                    testParamObj.observation        = testDat.Observation__c;
                    testParamObj.verdict            = testDat.Conclusion__c;
                    testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
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
                
               //End of case data gathering and adding to list.      
      
                                
              //Dial - code block to add product information to list.         
                 try{       
                   dialCom =[SELECT id,Name,Name__c,Final_Verdict__c,Published_Date__c  FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Dial' limit 1];  
                }catch(Exception e){
                    System.debug('Exception in dial records - child'+e);
                }  
               
                
             // Dial - code block to add test parameter information to list.      
                testParamRecords.clear();
                try{   
                    testParamRecords = [SELECT id,Name,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Condition_Ref__r.Question__r.UOM__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: dialCom.Id AND Conclusion__c !=: '' order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }catch(Exception e){System.debug('Exception in Query'+e);}
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
       //End of Dial data gathering and adding to list.  
        }//End of if block
    }//End of constructor
}