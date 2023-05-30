/********************************************************************************
Created by: Vinoth Kumar A
Created on: 19/03/2019
Description: Test class for PendingApprovalResportController
**************************************************************/
@isTest
public class pendingApprovalReportTest {
    @isTest public static void PendingApproval(){
        
        map<id, ProcessInstanceWorkitem > approvalMap = new map<id, ProcessInstanceWorkitem >();
        user usr = [SELECT Id FROM user WHERE Profile.Name=:'Quality Control - Admin' LIMIT 1];
        List<id> usrIdList = new List<id>();
        usrIdList.add(usr.Id);
        
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        
        QC_Components__c comp = new QC_Components__c(name__c='Dial',Watch_variant__c='Fastrack', Report_Ref_Number__c = 'FW/0227/17-2', Document_Status__c='Submitted for Approval');
        insert comp;
        
        if([select count() from ProcessInstance where targetobjectid=:comp.id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approve.');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(comp.Id);
            
            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);
            
        } 
        Test.startTest();
        PendingApprovalReportController Ap = new PendingApprovalReportController();
        Ap.selectedName = 'All';
        Ap.wrapLists();
        Test.stopTest();
    }
}