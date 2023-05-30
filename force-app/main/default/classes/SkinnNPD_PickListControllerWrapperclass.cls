/*
* Company : Kvp Business Solution 
* Author  : Sameer Ranjan
* Description : thsis class holds property which use in SkinnNPD_marketingBriefComponent class
* History     : N/L
*/
public with sharing class SkinnNPD_PickListControllerWrapperclass {
        @AuraEnabled
        public List<PickListClass> collectionNameList;
        @AuraEnabled
        public List<PickListClass> masterOwnerList;
        @AuraEnabled
        public List<PickListClass> collectionSelectTypeList;
        @AuraEnabled
        public List<PickListClass> subjectTaskPickList;
        @AuraEnabled
        public List<PickListClass> statusTaskPickList;
        @AuraEnabled
        public List<PickListClass> priorityToTaskPickList;
        @AuraEnabled
        public List<PickListClass> taskUserList;
        @AuraEnabled
        public string stageActivityName;
        @AuraEnabled
        public string stageStatus;
        @AuraEnabled
        public string selectedCollectionTemplateId;
        @AuraEnabled
        public string modelId;
        @AuraEnabled
        public string orderNumber;
        @AuraEnabled
        public string parentName;
        @AuraEnabled
        public string type;
        @AuraEnabled
        public string plannedLeadTime;
        @AuraEnabled 
        public Date plannedStartDate;
        @AuraEnabled 
        public Date plannedEndDate;
        @AuraEnabled 
        public Date rollingStartDate;
        @AuraEnabled 
        public Date rollingEndDate;
        @AuraEnabled 
        public Date actualStartDate;
        @AuraEnabled 
        public Date actualEndDate;
        @AuraEnabled 
        public Decimal actualLeadTime;
        @AuraEnabled
        public Date productLaunchDate;
        @AuraEnabled
        public Id skinnStageId ;
        public string filename;
        public string baseDate;
        public string contentType;
        @AuraEnabled
        public List<Attachment> attachmentList;
        @AuraEnabled
        public String levelHierarchy;
        @AuraEnabled
        public String commentRemark;
        @AuraEnabled
        public String noteTile;
        @AuraEnabled
        public String noteBody;
        @AuraEnabled 
        public Boolean valideUser;
        @AuraEnabled 
        public string errorMessage;
        @AuraEnabled
        public string ownerName;
        @AuraEnabled
        public Boolean isStepActive;
        @AuraEnabled
        public List<Note> listNotes;
        @AuraEnabled
        public string successorRelatedTo;
        @AuraEnabled
        public string successorName;
        @AuraEnabled
        public string successorEmail;
        @AuraEnabled
        public List<PickListClass> revisionActivationPickListVal;
        @AuraEnabled
        public List<Task> taskList;
        @AuraEnabled
        public String revisionStatus;
        @AuraEnabled
        public Date R1StartDate;
        @AuraEnabled
        public Date R1EndtDate;
        @AuraEnabled
        public Date R2StartDate;
        @AuraEnabled
        public Date R2EndtDate;
        @AuraEnabled
        public Date R3StartDate;
        @AuraEnabled
        public Date R3EndtDate;
        @AuraEnabled
        public Date R4StartDate;
        @AuraEnabled
        public Date R4EndtDate;
        @AuraEnabled
        public Date R5StartDate;
        @AuraEnabled
        public Date R5EndtDate;
        @AuraEnabled
        public String R1Status;
        @AuraEnabled
        public String R2Status;
        @AuraEnabled
        public String R3Status;
        @AuraEnabled
        public String R4Status;
        @AuraEnabled
        public String R5Status;
        @AuraEnabled
        public String skinnNPDTemplateItemId;
        @AuraEnabled
        public Boolean approvalRequired;
        @AuraEnabled
        public Boolean isRecordLock;
        @AuraEnabled
        public string approStatus;
        @AuraEnabled
        public List<ProcessInstanceHistory> processHitry;
        @AuraEnabled 
        public Skinn_Collection_Template__c stageInformation;
        @AuraEnabled
        public Boolean IsRevisionInPro;
        @AuraEnabled
        public Decimal approvalCount;
        @AuraEnabled
        public string r1Approval;
        @AuraEnabled
        public string r2Approval;
        @AuraEnabled
        public string r3Approval;
        @AuraEnabled
        public string r4Approval;
        @AuraEnabled
        public string r5Approval;
        @AuraEnabled
        public String skinnCollectionRecordType;
        @AuraEnabled
        public String skinnItemParentId; 
}