/******************************************************************************************
* Created By : Vinoth Kumar A
* Created on : 11/2/2020
* Description: Approval should be submitted automatically for the stage Qualified-RFQ study.
* Trigger Name: OpportunityTrigger
* Test Class: 
* **********************************************************************************************/
public class OpportunityRFQApprovalSubmissionHelper {
    public static void OpportunityRFQApprovalSubmission(List<Opportunity> OppList, Map<id,Opportunity> OldOppMap){
        set<id> oppIds = new set<id>();
        for(opportunity opp :OppList){
            oppIds.add(opp.Id);
        }
        boolean executeQuery = false;
        Map<Id,List<ProcessInstance>> ProcessInstanceMap = new Map<Id,List<ProcessInstance>>();
        Set<Id> oppIdSet = new Set<Id>();
        for(Opportunity opp : OppList){                         //Preliminary Opportunity
            oppIdSet.add(opp.Id);
            If(Opp.StageName == 'Qualified-RFQ study' && Opp.StageName != OldOppMap.get(Opp.Id).StageName){
                executeQuery = true;
            }
        }
        if(executeQuery){
            for(ProcessInstance prcInst :[SELECT Id, TargetObjectId FROM ProcessInstance WHERE TargetObjectId =:oppIdSet AND Status = 'Pending'])
            {
                if(ProcessInstanceMap.containsKey(prcInst.TargetObjectId)){
                    ProcessInstanceMap.get(prcInst.TargetObjectId).add(prcInst);
                }else{
                    ProcessInstanceMap.put( prcInst.TargetObjectId ,new List<ProcessInstance>{prcInst} );
                }
            }
        }
        
        system.debug('In approval trigger');
        for(Opportunity opp : OppList){
            system.debug((Opp.StageName == 'Qualified-RFQ study' && Opp.StageName != OldOppMap.get(Opp.Id).StageName));
            If(Opp.StageName == 'Qualified-RFQ study' && Opp.StageName != OldOppMap.get(Opp.Id).StageName){
                Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                approvalRequest.setComments('Opportunity Submitted for approval');
                approvalRequest.setObjectId(Opp.Id);
                system.debug('ProcessInstanceMap==>'+ProcessInstanceMap);
                /*list<ProcessInstance> existingApprovals = [SELECT Id, TargetObjectId
FROM ProcessInstance 
WHERE TargetObjectId =: Opp.Id
AND Status = 'Pending'];*/
                list<ProcessInstance> existingApprovals = new list<ProcessInstance>();
                if(!ProcessInstanceMap.isEmpty()){
                    existingApprovals = ProcessInstanceMap.get(Opp.Id);
                }
                system.debug('deeepbug');
                if(existingApprovals.isEmpty() ||  existingApprovals.size() < 1){
                    Approval.ProcessResult ApprovalResult = Approval.Process(approvalRequest);
                }
                
                
                //System.debug('Opportunity submitted for approval successfully: '+approvalResult.isSuccess()+'---' + ApprovalResult.errors);
            }
        }
    }
}