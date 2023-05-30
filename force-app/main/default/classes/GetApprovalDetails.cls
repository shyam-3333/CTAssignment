public class GetApprovalDetails {
    public static ApprovalResponse recordTypeSetting(set<String> parentObjectIds)
    {
        
        String approvalStatus = '';
        ApprovalResponse ar = new ApprovalResponse();

        if (!parentObjectIds.isEmpty())
        {
            map<Id, ProcessInstance> latestInstance = new map<Id, ProcessInstance>();
            
            for (ProcessInstance pi : [ SELECT Id, TargetObjectId, Status, CreatedDate,
                                       (
                                           SELECT Id, ProcessInstanceId, StepStatus, Comments, CreatedDate
                                           FROM Steps
                                           ORDER BY CreatedDate DESC
                                       ),(Select Id,ActorId,StepStatus,OriginalActorId  from StepsAndWorkitems where StepStatus = 'Pending' Order by CreatedDate desc limit 2)
                                       FROM ProcessInstance
                                       WHERE TargetObjectId IN: parentObjectIds
                                       ORDER BY CreatedDate DESC LIMIT 2
                                      ])
            {
                system.debug('processInstance: ' + pi);
                system.debug('StepsAndWorkitems: ' + pi.StepsAndWorkitems);
                
                for(ProcessInstanceHistory st : pi.StepsAndWorkitems){
                    if(st.StepStatus=='Pending'){
                        //ar.originalActorId = st.OriginalActorId;
                        System.debug('Data-->'+[Select Id,Name from User where Id =:st.OriginalActorId]);
                        ar.workItemId = st.Id;
                        ar.originalActorId.add(st.OriginalActorId);
                        //break;
                        //IndentGvExcelAttachmentController.attachPDFFromQuote(quoteId,q1.Id,st.OriginalActorId);
                    }
                }

                if(pi.Status == 'Approved' ){
                    approvalStatus = 'Approved';
                }else if(pi.Status == 'Pending'){
                    approvalStatus = 'Pending';
                    break;
                }else if(pi.Status == 'Rejected'){
                    approvalStatus = 'Rejected';
                    break;
                }
            } 
        }
        ar.approvalStatus = approvalStatus;
        return ar;
        
    }
    public class ApprovalResponse{
        public String approvalStatus;
        public List<String> originalActorId;
        public String workItemId;
        public ApprovalResponse(){
            originalActorId= new List<String>();
        }

    }
}