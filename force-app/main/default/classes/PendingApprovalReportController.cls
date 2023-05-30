/********************************************************************************
Created by: Vinoth Kumar A
Created on: 15/03/2019
Description: Generating report of the pending approval process
**************************************************************/

public class PendingApprovalReportController {
    public class wrapperClass{
        public String Status {get; set;}
        public String ComponentNumber {get; set;}
        public String ReportReferalNumber {get; set;}
        public String SKUReference {get; set;}
        public String AssignedUser {get; set;}
        public String SubmitDate {get; set;}
        public String ObjectName {get; set;}
        public String ReportReferalId{get; set;}
        public String ReportObject {get; set;}
        public string selectedName {get; set;}
    }
    public List<wrapperclass> wrapList{get;set;}
    public string selectedName{get;set;}
    public List<selectoption> listNameSel {get;set;}
    public PendingApprovalReportController(){
        wrapList = new List<wrapperclass>();
        listNameSel = new List<selectOption>();
        listNameSel.add(new selectOption('-None-','-None-'));
        listNameSel.add(new selectOption('All','All'));
        for(user usr: [SELECT name FROM user WHERE profile.name LIKE '%Quality%']){
            listNameSel.add(new selectOption(usr.name,usr.name)); 
        } 
    }
    
   /* public string getselectedName(){
        return selectedName;
    }
    public void setselectedName(String s) {
        selectedName = s;
    }   */
    
    public void wrapLists() {
        wrapList.clear();
        map<id, ProcessInstanceWorkitem > approvalMap = new map<id, ProcessInstanceWorkitem >();
        List<ProcessInstanceWorkitem > QCList = new List<ProcessInstanceWorkitem >();
        if(selectedName.contains('All')){
            QCList = [SELECT ProcessInstance.status, ProcessInstanceid, ProcessInstance.TargetObjectId, ProcessInstance.createddate,
                      OriginalActor.name FROM ProcessInstanceWorkitem WHERE ProcessInstance.status = 'pending'];  
        } else {
            QCList = [SELECT ProcessInstance.status, ProcessInstanceid, ProcessInstance.TargetObjectId, ProcessInstance.createddate, 
                      OriginalActor.name FROM ProcessInstanceWorkitem WHERE ProcessInstance.status = 'pending' AND OriginalActor.name =:selectedName ];
        }
        SYSTEM.DEBUG(QClIST);

        for(ProcessInstanceWorkitem pi : QCList){
            approvalMap.put(pi.ProcessInstance.TargetObjectId,pi);
        }
        Integer i = approvalMap.size();
        system.debug(i+'------------------------');
        for(QC_Components__c Qc : [SELECT ID, Report_Ref_Number__c, Name, Name__c,SKU_Reference__c FROM QC_Components__c 
                                   WHERE ID in:approvalMap.keySet()]){
                                       wrapperclass wrapObj = new wrapperclass();
                                       wrapObj.status = approvalMap.get(Qc.ID).ProcessInstance.status;
                                       wrapObj.ComponentNumber = Qc.Name;
                                       wrapObj.ObjectName = (String.valueOf(Qc.id.getSObjectType()).split('__')[0]).replace('_',' ');
                                       wrapObj.ReportReferalNumber = String.valueOf(Qc.Report_Ref_Number__c);
                                       wrapObj.ReportReferalId =String.valueOf(Qc.ID);
                                       wrapObj.ReportObject = String.valueOf(Qc.id.getSObjectType()).split('__')[0];
                                       wrapObj.SKUReference = Qc.SKU_Reference__c;
                                       wrapObj.AssignedUser = approvalMap.get(Qc.ID).OriginalActor.name;
                                       wrapObj.SubmitDate = String.valueOf(approvalMap.get(Qc.ID).ProcessInstance.createddate);
                                       wrapList.add(wrapObj);
                                       system.debug('referal id:'+wrapObj.ReportReferalId);
                                   }
    }
    
    
}