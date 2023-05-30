public with sharing class QC_Document_Status_Email_MetalStrap{
    public QC_Components__c component;       //Parent component
    //public List<User> l1l2UserName                     {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}         //List to hold the question and answer records  
    public List<QC_Test_Data__c> testParamRecords{get;set;}         //List to hold the test parameters records   
    public string materialValue;
    public ID recId;                                 //To hold the record id  
    public ID compId{get;set;}                                  //To hold the record id    
    //public set<id> uids{get;set;}
    //public user lst {get;set;}
    //public user lst1 {get;set;}
    public String firstActorName {get;set;} 
    public String secondActorName {get;set;}
    public QC_Components__c metalCom {get;set;}

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
     public List<DefinedParameters> metalStrapIPList{get;set;}
     public List<DefinedTestParam> metalTestParamList{get;set;}         //List to hold the Metal Strap test parameter
     public List<DefinedTestParam> metalTestParamListM{get;set;}         //List to hold the Metal Strap test parameter for Material
     public List<DefinedTestParam> metalTestParamListP{get;set;}         //List to hold the Metal Strap test parameter for Plating

       public QC_Components__c getComponent()
    {
            recId = compId;
        metalCom     = new QC_Components__c();
            QC_Document_Status_Email_CompNew ();
            component=[SELECT id,Owner.Name,General_Observation__c,Component_Status__c,imageurl__c,imageurl2__c,imageurl3__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,
                          Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,
                          No_Of_Sample_Received__c,Published_Date__c  FROM QC_Components__c WHERE id =:compId];        
        return component; 
    } 
    
     public void QC_Document_Status_Email_CompNew (){
        //l1l2UserName = new List<User>();
      //  recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        quesResRecords = new List<QC_Input_Data__c>();    
        testParamRecords = new List<QC_Test_Data__c>(); 
        metalStrapIPList    = new   List<DefinedParameters>();
        metalTestParamList  = new   List<DefinedTestParam>();
         metalTestParamListP = new List<DefinedTestParam>();
        metalTestParamListM = new List<DefinedTestParam>();
        //uids        = new set<id>();
        //lst         = new user();
        //lst1        = new user();
        if(recId != null){        
            try{
                //Query the component details
                component=[SELECT id,Owner.Name,General_Observation__c,imageurl__c,imageurl2__c,imageurl3__c,Component_Status__c,Name,Name__c,Parent__c,Final_Verdict__c,Model__c,PSY_Reference__c,Sample_Category__c,
                          Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,
                          No_Of_Sample_Received__c,Published_Date__c  FROM QC_Components__c WHERE id =:recId ]; 
            }catch(Exception e){
                // ApexPages.addMessages(e) ; 
                System.debug('@@Error@@'+e);
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
           
            //Metal Strap - code block to add product information to list.
             List<String> defindIP = new List<String>();
                defindIP.clear();        
                defindIP.add('Gender');
                defindIP.add('Material');
                defindIP.add('Strap Type');
                defindIP.add('Strap Length Long Piece (6H)');                
                defindIP.add('Strap Length Long Piece (12H)');
                defindIP.add('Fixed Link Joint');
                defindIP.add('Adjustable Link Joint');
                defindIP.add('Type of Clasp');
                defindIP.add('Clasp Connector');
                defindIP.add('Special Feature in Strap');
                defindIP.add('Link Construction - Fixed');
                defindIP.add('Link Construction - Adjustable');   
                defindIP.add('Strap Length Short Piece (12H)'); 
                defindIP.add('Add on Joints');           
                quesResRecords.clear();
                try{
                    if(component.Sample_Category__c != 'Competitor Products'){
                    quesResRecords = [SELECT id,Name,Value__c,Question_Name__c,isManual__c,Comments__c,Component_No__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: recId AND Question__r.Question__c IN :defindIP order by Component_No__r.Name__c,Question__r.order_number__c];               
                    }else{
                    quesResRecords = [SELECT id,Name,Value__c,Question_Name__c,isManual__c,Comments__c,Component_No__c,Question__c,Component_No__r.Name__c,Question__r.Question__c FROM QC_Input_Data__c WHERE Component_No__c  =: recId order by Component_No__r.Name__c,Question__r.order_number__c];               
                    }
                    materialValue = [select value__c from QC_Input_Data__c where Component_No__c  =: recId AND Question__r.Question__c ='Material'].value__c;
                    metalCom =[SELECT id,Name,Name__c,Final_Verdict__c FROM QC_Components__c WHERE Parent__c =: recId AND Name__c = 'Metal-Strap' ];

                }catch(Exception e){
                    System.debug('Exception in user Query'+e);
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
                    /*if(each.Question__r.Question__c =='Material'){
                        materialValue = each.Value__c;
                    }*/
                    if((each.Question__r.Question__c == 'Fixed Link Joint' || each.Question__r.Question__c == 'Adjustable Link Joint') && (each.Value__c == 'Knurl Pin' || each.Value__c == 'Bulged Pin') && (materialValue =='Ceramic' || materialValue =='Brass Material')){
                       dpObj.color = 'Red';
                    }else if(each.Question__r.Question__c == 'Fixed Link Joint' && (each.Value__c == 'Curved'  || each.Value__c == 'Hair Pin') && materialValue =='Ceramic'){    
                       dpObj.color = 'Red';
                    }else if((each.Question__r.Question__c == 'Fixed Link Joint'  || each.Question__r.Question__c == 'Adjustable Link Joint')&& (each.Value__c == '2 Pin') && (materialValue =='Ceramic' || materialValue =='Brass Material' || materialValue == 'SS Material')){
                       dpObj.color = 'Red';
                    }else if(each.Question__r.Question__c == 'Adjustable Link Joint' && (each.Value__c == 'Hair Pin' || each.Value__c == 'Screw') && materialValue =='Ceramic' ){
                       dpObj.color = 'Red';
                    }else if(each.Question__r.Question__c == 'Type of Clasp' && (each.Value__c == 'Sliding') && (materialValue =='Ceramic' || materialValue =='Titanium')){
                       dpObj.color = 'Red';
                    }else if(each.Question__r.Question__c == 'Type of Clasp' && (each.Value__c == 'Jewellery') && materialValue =='Ceramic'){
                       dpObj.color = 'Red';
                    }
                    metalStrapIPList.add(dpObj);                    
                }            
                defindIP.clear();
            	testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: recId and (Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Strap' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Pin' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Clasp / Buckle' OR Condition_Ref__r.Question__r.Test_Name__c='Material Chemical Composition - Screw') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                    //ApexPages.addMessages(e) ; 
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
                    metalTestParamListM.add(testParamObj);
                }            
                    /*      
               Metal Strap - code block to add test parameter information to list(Plating). 
                
            */       
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: recId and (Condition_Ref__r.Question__r.Test_Name__c='Plating Layer - Strap') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }
                catch(Exception e){
                    //ApexPages.addMessages(e) ; 
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
                    metalTestParamListP.add(testParamObj);
                }
          
       //       Metal Strap - code block to add test parameter information to list. 
                testParamRecords.clear();
                try{
                    testParamRecords = [SELECT id,isManual__c, Specification_Input__c, Test_Name__c, UOM_Input__c,Comments_and_Remarks__c,Name,Condition_Ref__r.Question__r.UOM__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE (Conclusion__c!=null OR Conclusion__c!='') AND Component_Name__c =: recId and (Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Strap' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Pin' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Clasp / Buckle' AND Condition_Ref__r.Question__r.Test_Name__c!='Material Chemical Composition - Screw' AND Condition_Ref__r.Question__r.Test_Name__c!='Plating Layer - Strap') order by isManual__c, Condition_Ref__r.Onload__c DESC, Condition_Ref__r.IsEditableUOMSPEC__c];
                }catch(Exception e){
                    System.debug('Exception in user Query'+e);
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
                    metalTestParamList.add(testParamObj);
                }
        //End of Metal Strap data gathering and adding to list. 
        }
     }
}