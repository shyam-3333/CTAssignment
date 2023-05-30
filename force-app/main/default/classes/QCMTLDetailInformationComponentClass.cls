public class QCMTLDetailInformationComponentClass {
    public class WrapperClass{
        @AuraEnabled
        public QC_MTL_Component__c record;
        @AuraEnabled
        public List<QC_MTL_TestResponse__c> alltestResponse;
        @AuraEnabled
        public List<List<String>> allCompositionPickList;
          
    }
    @AuraEnabled
    public static boolean isRecordSubmitForApproval(Id recordId){
       // boolean val= Approval.LockResult(recordId);
        boolean returnval=Approval.isLocked(recordId);
        return returnval;
    }
    
    @AuraEnabled
    public static WrapperClass getQCMTLComponentRecord(String recordId){
        WrapperClass result=new WrapperClass();
        if(recordId!=null){
            result.record=[Select Id,Name,Department__c,Optional_Test__c,Department_PMC__c,Report_Reference_Number__c,Chemical_Composition_Elements__c,Chemical_Composition_Elements_2__c,Chemical_Composition_Elements_3__c,Chemical_Composition_Elements_4__c,
            Chemical_Composition_Elements_5__c,Component_Name__c,Chemical_Composition_ElementsObser1__c,Chemical_Composition_ElementsObser2__c,Chemical_Composition_ElementsObser3__c,Chemical_Composition_ElementsObser4__c,
            Chemical_Composition_ElementsObservation__c,Chemical_Composition_ElementsResult__c,Chemical_Composition_ElementsResult1__c,Chemical_Composition_ElementsResult2__c,Chemical_Composition_ElementsResult3__c,
            Chemical_Composition_ElementsResult4__c,Testing_Type__c,Final_Verdict__c,Remarks__c from QC_MTL_Component__c where Id=:recordId][0];
            result.allCompositionPickList=new List<List<String>>();
            result.allCompositionPickList=QC_Mtl_Plating_InputParamClass.getSchemaValue();
            result.alltestResponse=new List<QC_MTL_TestResponse__c>([Select Id,Name,Result__c,Maximum__c,Average_Value__c,Minimum__c,User_Defined_Value__c,Standard_Defined_Value__c,QC_Test_Questions_Value__r.Standard_Defined_Value__c,Plating_Testing_Type__c,QC_MTL_Test__c,QC_MTL_Test__r.IsMandatory__c from QC_MTL_TestResponse__c where QC_MTL_Component_del__c=:recordId]);
        }
        return result; 
    }
    @AuraEnabled
    public static WrapperClass savaRecord(String record,String allTests){
        WrapperClass result=new WrapperClass();
        if(record!=null && allTests!=null){
            QC_MTL_Component__c updaterecordList=(QC_MTL_Component__c)JSON.deserialize(record, QC_MTL_Component__c.class);
            List<QC_MTL_TestResponse__c> updateTestparameter=(List<QC_MTL_TestResponse__c>)JSON.deserialize(allTests, List<QC_MTL_TestResponse__c>.class);  
            result.record=updaterecordList;
            result.alltestResponse=new List<QC_MTL_TestResponse__c>(updateTestparameter);
            update updaterecordList;
            update updateTestparameter;
        }
        return result;
    }
     @AuraEnabled
    public Static ApprovalList submitForAppProcess(String RecId){
        Id ProId=userinfo.getProfileId();
        String Pname=[Select Name FROM Profile where Id=:ProId][0].Name;
        if(Pname!='MTL Manage Users'){
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        //Passing record id 
        req.setObjectId(RecId);        
        Approval.ProcessResult result = Approval.process(req);
        string approvalResult = result.getInstanceStatus();
        return getApprovalData(RecId);
        }
       return null;
    }
    @AuraEnabled  
   public static ApprovalList getApprovalData(Id recId)  
   {  
       System.debug('::::recId::: '+recId);
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
       System.debug('::::objectId ::: '+objectId);
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