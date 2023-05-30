public class ApprovalComponentController {  
       /*  
       * This method will be called by the helper function  
       * Parameter: recordId  
       * Returns: instance of wrapper class  
       */  
   @AuraEnabled  
   public static ApprovalList getApprovalData(Id recId)  
   {  
     Id recordId = recId;  
     ApprovalList approvalResultForObject = new ApprovalList();  
     List<ApprovalStepWrapper> aSW = new List<ApprovalStepWrapper>();  
     String recallApprovalProcessLink;  
     Boolean isSubmitForApproval = true;  
     for(ProcessInstance pI: getProcessHistory(recordId).values())  
     {  
       Map<Id,List<ProcessInstanceHistory>> mapOfProcessNodeIdAndProcessInstanceHistory = new Map<Id,List<ProcessInstanceHistory>>();  
       Set<Id> processNodeId= new Set<Id>();  
       for(ProcessInstanceHistory sWI:pI.StepsAndWorkitems)  
       {  
         if(processNodeId.size() ==0)  
           processNodeId.add(sWI.ProcessNodeId);  
         else if(processNodeId.size()>0 && processNodeId.contains(sWI.ProcessNodeId)!= NULL)  
           processNodeId.add(sWI.ProcessNodeId);  
       }  
       for(Id pNId: processNodeId)  
       {  
         ApprovalStepWrapper aSWr = new ApprovalStepWrapper();  
         for(ProcessInstanceHistory sWI:pI.StepsAndWorkitems)  
         {  
           if(sWI.processNodeId == pNID)  
           {  
             aSWr.listOfSteps.add(new ApprovalHistoryWrap(sWI.CreatedDate, sWI.OriginalActor.Name, sWI.StepStatus,sWI.Actor.Name));  
           }  
           if(sWI.StepStatus == 'Pending')  
           {  
             isSubmitForApproval = false;  
           }  
         }  
         aSW.add(aSWr);  
       }  
     }  
     approvalResultForObject.approvals = aSW;  
     approvalResultForObject.recordId = recordId;  
     approvalResultForObject.isSubmitForApproval = isSubmitForApproval;  
     system.debug('asw'+aSW);  
     return approvalResultForObject;  
   }  
   /*  
    * This method queries the processinstance and workitem for the record  
    * Parameter: Record ID   
    * Returns: Map of all processinstance related to the record id  
    */  
   @AuraEnabled  
   public static Map<Id,ProcessInstance> getProcessHistory(Id objectId)  
   {  
     return new Map<Id,ProcessInstance>([SELECT Id, (SELECT ID, ProcessNodeId,  
                             StepStatus,Comments,TargetObjectId,ActorId,CreatedById,IsDeleted,IsPending  
                             ,OriginalActorId,ProcessInstanceId,RemindersSent,CreatedDate, Actor.Name,  
                             OriginalActor.Name , ProcessNode.Name FROM StepsAndWorkitems order by CreatedDate DESC )   
                       FROM ProcessInstance where TargetObjectId =:objectId order by CreatedDate DESC]);  
   }  
   /*  
    * Wrapper class  
    */  
   public class ApprovalStepWrapper{  
     @AuraEnabled  
     public List<ApprovalHistoryWrap> listOfSteps {get;set;}  
     public ApprovalStepWrapper(){  
       listOfSteps = new List<ApprovalHistoryWrap>();  
     }  
   }  
        /*  
    * Wrapper class  
    */  
   public class ApprovalHistoryWrap  
   {  
     @AuraEnabled  
     public Date createdDate {get;set;}  
     @AuraEnabled  
     public string actorName {get;set;}  
     @AuraEnabled  
     public string steps {get;set;}  
     @AuraEnabled  
     public string assignedTo {get;set;}  
     public ApprovalHistoryWrap(DateTime crDate, string name, string stp, string actor)  
     {  
       createdDate = crDate.date();  
       actorName = name;  
       steps = stp;  
       assignedTo = actor;  
     }  
   }  
   /*  
    * Wrapper class  
    */  
   public class ApprovalList  
   {   
     @AuraEnabled  
     public List<ApprovalStepWrapper> approvals {get;set;}  
     @AuraEnabled    
     public Boolean isSubmitForApproval {get;set;}  
     @AuraEnabled  
     public Id recordId {get;set;}  
     public ApprovalList(){  
       approvals = new List<ApprovalStepWrapper>();  
       isSubmitForApproval = true;  
     }  
   }  
 }