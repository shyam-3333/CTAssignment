public class QCMTLPDFReportController {
    public QC_MTL_Component__c qcMtlComp{get;set;}
    public String firstApprover {get;set;}
    public String secondApprover {get;set;}
    public String submitterName{get;set;}
    public String compId {get;set;}
    public String recordId;
    public List<QC_MTL_TestResponse__c> qcmtlReslst {get;set;}
    public String str{get;set;}
    public String updatedstr{get;set;}
    public Integer k{get;set;}
    public Integer j{get;set;}
    
    public QCMTLPDFReportController(){
        qcMtlComp = new QC_MTL_Component__c();
        compId=Apexpages.currentpage().getParameters().get('compId');
        system.debug('####compid####' +compId); 
        
        qcMtlComp = [SELECT Id,Report_Reference_Number__c,Record_Status__c,Testing_Type__c,Material_Sample_Type__c,Raw_Material_Type__c,IRR_No__c,
                     Document_Status__c,Sample_Size_Qty__c,Sample_Received_Date__c,MTL_User__r.name,Brand__r.name,Final_Verdict__c,Remarks__c,
                     Sample_Received_From__c,Owner.name,Raw_Material_Name__c,Supplier_Name_New__c,Supplier_Name_New__r.Name,TCL_Designation__c,Titan_Specification_Reference__r.Name,Titan_Specification_Reference__c,Supplier_Grade__r.Name,Supplier_Grade__c,Specification_revision__c,Plater_Name__r.Name,General_Observation__c,Heat_No_Grade__c,Invoice_Dc_No__c,RM_Size__c,Material__c,Published_Date__c FROM QC_MTL_Component__c WHERE Id =: compId ];         
        system.debug('****qcMtlcomp****' + qcMtlcomp);
        recordId = qcMtlComp.Id;        
        FetchRecord(); 
        k=23;
        j = 0;
        updatedstr='';
        if(qcMtlComp.Heat_No_Grade__c != null){
            str = qcMtlComp.Heat_No_Grade__c;
            for(Integer i=0;i<str.length();i++){ //105
                if(j<=i && i==k && k<str.length()){
                    updatedstr = updatedstr+str.substring(j,i+1)+'<br/>';
                    k=k+24;
                    j=i+1;
                }
                else if(k>=str.length()){
                    k=str.length()-1;
                }
            }   
        }
        
    }
    public void FetchRecord(){
        
        try{
            if(recordId != null) {
                
                //For fetching First Approver and Second Level Approver . //modified by Anindwita.
                List<ProcessInstance > lstProcessInstance = [SELECT CompletedDate,Id,LastActorId,ProcessDefinitionId,Status,SubmittedBy.name ,( SELECT CompletedDate,Id,LastActor.Name,NodeStatus,ProcessInstanceId,ProcessNodeId,ProcessNodeName FROM Nodes ORDER BY CreatedDate DESC ) 
                                                             FROM ProcessInstance WHERE TargetObjectId =:recordId AND Status != 'Pending'  ORDER BY CreatedDate DESC limit 1];
                system.debug('The log :'+lstProcessInstance);
                for(ProcessInstance  pi : lstProcessInstance ){
                    system.debug('**********ProcessInstance**********'+pi);
                    
                    //do something
                    submitterName=pi.SubmittedBy.name;
                    System.debug('submitterName'+submitterName);
                    for(ProcessInstanceNode  st : pi.Nodes){
                        system.debug('*************Step **************'+st);
                        if(st.NodeStatus == 'Approved' || st.NodeStatus == 'Rejected'){ 
                            if(st.ProcessNodeName == 'Step 1'){
                                //  firstApprover = st.LastActor.Name;
                                secondApprover=st.LastActor.Name;
                                System.debug('secondApprover'+secondApprover);
                                //   lst.lstName = st.LastActorId;
                            }
                            
                        } 
                    }
                    
                } 
                qcmtlReslst =[SELECT id,QC_MTL_Test__r.name,QC_Test_Questions_Value__r.name,User_Defined_Value__c,Standard_Defined_Value__c,
                              Minimum__c,Maximum__c,Average_Value__c,Result__c FROM QC_MTL_TestResponse__c WHERE QC_MTL_Component_del__c =:recordId ORDER BY QC_MTL_Test__r.name];   
            }
            
        }
        catch(exception ert){
            system.debug('The error'+ert+'.....'+ert.getLineNumber());
            /*String errorMessage = 'MyVisualforceComponent::initializeController(): error: '
+ert.getMessage()+'\n'+ert.getStackTraceString();
System.debug(errorMessage);
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,String.valueof(ert)));
Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
email.setSubject('MyOrg: Error During Email Rendering');
email.setPlainTextBody(errorMessage);
email.setSaveAsActivity(false);
email.setToAddresses(new List<String>{'anindwita.raj@kvpcorp.com'});
List<Messaging.SendEmailResult> sendEmailResults =
Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});*/
            
        }
        
    }
}