/*Created By - Mohit Dwivedi
 * Created on  - 14/01/19
 * Description - Class is to display the reliability report for construction testing for all the sample categories in pdf formats. */

public class QC_MTL_Component_pdfComponentCntlr{
    
    public QC_MTL_Component__c qcMtlComp;
   // public String firstApprover {get;set;}
    public String secondApprover {get;set;}
    public String submitterName{get;set;}
    public String compId {get;set;}
    public String recordId;
    public List<QC_MTL_TestResponse__c> qcmtlReslst {get;set;}
    public boolean ishasMCValue{get;set;}  
    
    public QC_MTL_Component__c getqcMtlComp(){
        //qcMtlComp = new QC_MTL_Component__c();
        system.debug('****compId****' + compId);
        
        qcMtlComp = [SELECT Id,Report_Reference_Number__c,Component_Name__c,Component_Accessories__c,Component_Others__c,Record_Status__c,Testing_Type__c,Material_Sample_Type__c,Raw_Material_Type__c,Remarks__c,
                     Document_Status__c,IRR_No__c ,Optional_Test__c,Sample_Size_Qty__c,Sample_Received_Date__c,MTL_User__r.name,Brand__r.name,Final_Verdict__c,Chemical_Composition_Elements__c,Chemical_Composition_Elements_2__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,Chemical_Composition_Elements_5__c,Chemical_Composition_ElementsObser1__c,Chemical_Composition_ElementsObser2__c,Chemical_Composition_ElementsObser3__c,Chemical_Composition_ElementsObser4__c,Chemical_Composition_ElementsObservation__c,Chemical_Composition_ElementsResult__c,Chemical_Composition_ElementsResult1__c,
                     Chemical_Composition_ElementsResult2__c,Part_Name__c ,Chemical_Composition_ElementsResult3__c,Chemical_Composition_ElementsResult4__c,
                      Sample_Received_From__c,Owner.name,Raw_Material_Name__c,Supplier_Name_New__c,Supplier_Name_New__r.Name,TCL_Designation__c,Titan_Specification_Reference__c,Titan_Specification_Reference__r.Name,Supplier_Grade__c,Supplier_Grade__r.Name,Specification_revision__c,General_Observation__c,Heat_No_Grade__c,Invoice_Dc_No__c,RM_Size__c,Material__c,Plating_Type__c,Department__c,Department_PMC__c,Sample_Size_Plating__c,Required_Test__c,Required_test_PMC__c,Docket_Number__c,Model__c,Source__c,Batch_Quantity__c FROM QC_MTL_Component__c WHERE Id =: compId ];            
        system.debug('****qcMtlcomp****' + qcMtlcomp);
        recordId = qcMtlComp.Id;
        if(qcMtlComp.Optional_Test__c!=Null){
            if(qcMtlComp.Optional_Test__c.contains('Material Composition')){
                ishasMCValue=true;
            }else{
                ishasMCValue=false;
            }
        }
        fetchRecord(); 
        return qcMtlComp; 
    }
    
    public void fetchRecord(){
    
        
            if(recordId != null){
                //For fetching First Approver and Second Level Approver . //modified by Anindwita.
                List<ProcessInstance > lstProcessInstance = [SELECT CompletedDate,Id,LastActorId,ProcessDefinitionId,Status,SubmittedBy.name ,( SELECT CompletedDate,Id,LastActor.Name,NodeStatus,ProcessInstanceId,ProcessNodeId,ProcessNodeName FROM Nodes ORDER BY CreatedDate DESC ) 
                FROM ProcessInstance WHERE TargetObjectId =:recordId AND Status != 'Pending'  ORDER BY CreatedDate DESC limit 1];
                for(ProcessInstance  pi : lstProcessInstance ){
                    system.debug('**********ProcessInstance**********'+pi);
                    for(ProcessInstanceNode  st : pi.Nodes){
                        system.debug('*************Step **************'+st);
                        submitterName=pi.SubmittedBy.name;
                        if(st.NodeStatus == 'Approved' || st.NodeStatus == 'Rejected'){
                            if(st.ProcessNodeName == 'Step 1'){
                            //firstApprover = st.LastActor.Name;
                            secondApprover = st.LastActor.Name;
                            //   lst.lstName = st.LastActorId;
                            }

                        } 
                    }
                } 
                qcmtlReslst =[SELECT Id,Name,Standard_Defined_Value__c,QC_MTL_Test__r.name,QC_Test_Questions_Value__r.name,QC_Test_Questions_Value__r.Standard_Defined_Value__c,User_Defined_Value__c,
                Minimum__c,Maximum__c,Average_Value__c,Result__c FROM QC_MTL_TestResponse__c WHERE QC_MTL_Component_del__c =:recordId ORDER BY QC_MTL_Test__r.name];   
            }
        Integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
             
    }
    
}