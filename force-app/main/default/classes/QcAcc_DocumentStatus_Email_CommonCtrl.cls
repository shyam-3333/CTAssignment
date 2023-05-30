public class QcAcc_DocumentStatus_Email_CommonCtrl{
    public QC_Access_Component__c qcAccCompObj;
    public String firstApprover {get;set;}
    public String secondApprover {get;set;}
    public String compId {get;set;}
    public String switchTestingName {get;set;}
    public String recordId;
    
    
    public List<QC_Access_QuesResponse__c> qcAccQstnRespList {get;set;}
    
    public QC_Access_Component__c getqcAccCompObj(){
        
        qcAccCompObj=[SELECT ID,Owner.Name,Brand__r.Name,No_Of_Sample_Received__c,Document_Status__c,Final_Verdict__c,General_Observation__c,Construction_Refer_Number__r.Report_Ref_Number__c,Record_Status__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,Sample_Type__c,SKU_Reference__c,Sub_Category__c,Vendor_Reference__c,Gender__c,Vendor__r.Name FROM QC_Access_Component__c WHERE (isConstructionTesting__c = true OR isReliabilityTesting__c = true) AND Report_Ref_Number__c !=NULL AND ID =: compId  ];
        recordId = qcAccCompObj.Id;
        if(qcAccCompObj.Report_Ref_Number__c.substring(qcAccCompObj.Report_Ref_Number__c.indexOf('/')-1,qcAccCompObj.Report_Ref_Number__c.indexOf('/')) =='C'){
           switchTestingName = 'Construction Testing'; 
        }else{
           switchTestingName = 'Reliability Testing'; 
        } 
        fetchRecords();
        return qcAccCompObj;
    } 
    
    
    public void fetchRecords(){
    
    
        if(recordId != null){
         //For fetching First Approver and Second Level Approver . //modified by Anindwita.
            List<ProcessInstance > lstProcessInstance = [SELECT CompletedDate,Id,LastActorId,ProcessDefinitionId,Status,SubmittedBy.name ,( SELECT CompletedDate,Id,LastActor.Name,NodeStatus,ProcessInstanceId,ProcessNodeId,ProcessNodeName FROM Nodes ORDER BY CreatedDate DESC ) 
           FROM ProcessInstance WHERE TargetObjectId =:recordId AND Status != 'Pending'  ORDER BY CreatedDate DESC limit 1];
            for(ProcessInstance  pi : lstProcessInstance ){
                system.debug('**********ProcessInstance**********'+pi);
                for(ProcessInstanceNode  st : pi.Nodes){
                    system.debug('*************Step **************'+st);
                    if(st.NodeStatus == 'Approved' || st.NodeStatus == 'Rejected'){
                        if(st.ProcessNodeName == 'Step 1'){
                            firstApprover = st.LastActor.Name;
                         //   lst.lstName = st.LastActorId;
                        }
                        if(st.ProcessNodeName == 'Approval to Level 2'){
                           // lst1.Name = st.LastActor.Name;
                           secondApprover = st.LastActor.Name;
                           
                        }
                    } 
                }
            } 
            
        
        qcAccQstnRespList=[SELECT ID,Name,Multiple_QuesResponseId__c,Observation__c,QC_Access_Component__c,QC_Access_Condition__c,QC_Access_Questions__c,
                          Remarks__c,Response_Values__c,Verdict__c,QC_Access_Questions__r.Test_Name__c,QC_Access_Questions__r.Acceptance_Criteria__c,QC_Access_Questions__r.Product_Specification__c FROM 
                           
                          QC_Access_QuesResponse__c WHERE QC_Access_Component__c =: recordId  AND RecordTypeID =: Schema.SObjectType.QC_Access_QuesResponse__c.getRecordTypeInfosByName().get('Test Type').getRecordTypeId() AND Verdict__c != 'None'];
    }
   
    
    }
    
}