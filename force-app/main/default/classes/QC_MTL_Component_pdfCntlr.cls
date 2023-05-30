/*Created By - Mohit Dwivedi
* Created on  - 14/01/19
* Description - Class is to display the reliability report for construction testing for all the sample categories in pdf formats. */

public class QC_MTL_Component_pdfCntlr{
    
    public QC_MTL_Component__c qcMtlComp{get;set;}
    public String firstApprover {get;set;}
    public String secondApprover {get;set;}
    public String compId {get;set;}
    public String recordId;
    public List<QC_MTL_TestResponse__c> qcmtlReslst {get;set;}
   
    
    public QC_MTL_Component__c getqcMtlComp(){
        qcMtlComp = new QC_MTL_Component__c();
        compId=Apexpages.currentpage().getParameters().get('compId');
        system.debug('####compid####' +compId); 
       
        qcMtlComp = [SELECT Id,Report_Reference_Number__c,Record_Status__c,Testing_Type__c,Material_Sample_Type__c,Raw_Material_Type__c,
                     Document_Status__c,Sample_Size_Qty__c,Sample_Received_Date__c,MTL_User__r.name,Brand__r.name,Final_Verdict__c,
                     Sample_Received_From__c,Owner.name FROM QC_MTL_Component__c WHERE Id =: compId ];         
        system.debug('****qcMtlcomp****' + qcMtlcomp);
        recordId = qcMtlComp.Id;        
        FetchRecord(); 
        return qcMtlComp; 
    }
    
    public void FetchRecord(){
        
        //try{
            if(recordId != null) {
               
                //For fetching First Approver and Second Level Approver . //modified by Anindwita.
                List<ProcessInstance > lstProcessInstance = [SELECT CompletedDate,Id,LastActorId,ProcessDefinitionId,Status,SubmittedBy.name ,( SELECT CompletedDate,Id,LastActor.Name,NodeStatus,ProcessInstanceId,ProcessNodeId,ProcessNodeName FROM Nodes ORDER BY CreatedDate DESC ) 
                                                             FROM ProcessInstance WHERE TargetObjectId =:recordId AND Status != 'Pending'  ORDER BY CreatedDate DESC limit 1];
                system.debug('The log :'+lstProcessInstance);
                for(ProcessInstance  pi : lstProcessInstance ){
                    system.debug('**********ProcessInstance**********'+pi);
                   
//do something

                    for(ProcessInstanceNode  st : pi.Nodes){
                        system.debug('*************Step **************'+st);
                        if(st.NodeStatus == 'Approved' || st.NodeStatus == 'Rejected'){ 
                            if(st.ProcessNodeName == 'Step 1'){
                                firstApprover = st.LastActor.Name;
                                //   lst.lstName = st.LastActorId;
                            }
                            
                        } 
                    }
                    
                } 
                qcmtlReslst =[SELECT id,QC_MTL_Test__r.name,QC_Test_Questions_Value__r.name,User_Defined_Value__c,
                              Minimum__c,Maximum__c,Average_Value__c,Result__c FROM QC_MTL_TestResponse__c WHERE QC_MTL_Component_del__c =:recordId ORDER BY QC_MTL_Test__r.name];   
            }
          
        //}
        //catch(exception ert){
            //system.debug('The error'+ert+'.....'+ert.getLineNumber());
            /*String errorMessage = 'MyVisualforceComponent::initializeController(): error: '
                +ert.getMessage()+'\n'+ert.getStackTraceString();
            //System.debug(errorMessage);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,String.valueof(ert)));
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('MyOrg: Error During Email Rendering');
            email.setPlainTextBody(errorMessage);
            email.setSaveAsActivity(false);
            email.setToAddresses(new List<String>{'anindwita.raj@kvpcorp.com'});
            List<Messaging.SendEmailResult> sendEmailResults =
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});*/
                        
        //}
        
    }
   
    
}