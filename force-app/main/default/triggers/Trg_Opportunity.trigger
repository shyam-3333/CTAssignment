/*
* Created by    : Praveen (Lister)
* Created on    : Nov-26-2019
* Purpose       : This trigger has the consolidated logic of the following trigger OpportunityDeliveryStatusUpdate ,OpportunitySharingRule ,RFQStudyRecordTypeChange ,TitanOpportunityTrigger ,Trigger_Create_Opportunity_Stage_History ,Trigger_Create_Project_History ,Trigger_Create_Revision_History ,Trigger_Update_Converted_Amount ,UpdateOppNumber ,UpdateOpportunityAmountonApproval ,updateTempFieldwithInitialAmt
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
trigger Trg_Opportunity on Opportunity (before insert,after insert,after update,before update) {
    if(TriggerStatus__c.getInstance(Util_Common.OPPTTRIGGER) != NULL && TriggerStatus__c.getInstance(Util_Common.OPPTTRIGGER).Active__c){
        
        string str = label.OpportunityStageWonOrLostSurveyReminder_Trigger;
        if(str == 'True'){
            OpportunityStageWonOrLostSurveyHelper.OpportunitySurvey(Trigger.new, Trigger.oldMap);
        }
        
        
        if(trigger.isBefore){
            if(trigger.isInsert || trigger.isUpdate){
                OpportunityTriggerHandler.populateOpptFields(Trigger.new,Trigger.oldmap,Trigger.newmap);
            }
            If(trigger.isUpdate){
        new Electrical_Mechanical_manager_fetch().whileUpdate(trigger.new, trigger.OldMap);
        new SurveyForceReportParameters().opportunityReminderDateParameters(trigger.new , trigger.oldMap);
                }
            if(trigger.isInsert){
        new Electrical_Mechanical_manager_fetch().whileInsert(trigger.new);
                }
        }
        if(trigger.isAfter){
            if(trigger.isInsert || trigger.isUpdate){
                OpportunityTriggerHandler.insertOpptTeam(Trigger.newmap,Trigger.oldmap);
                if(trigger.isInsert){
                    OpportunityTriggerHandler.insertProjectHist(Trigger.new);
                }
            }
        }
    if(trigger.isInsert && trigger.isAfter){
        new OpportunityShareToTeamMembers().whileInsert(trigger.new);
    }
    if(trigger.isUpdate && trigger.isAfter){
        new OpportunityShareToTeamMembers().whileUpdate(trigger.new,trigger.oldMap);
        
        // Calling FeedbackCreationClass to created Feedback report
        String LitmusCalloutTrigger_Status = label.LitmusCalloutTrigger;
        if(LitmusCalloutTrigger_Status == 'True'){
            String newOppListstr = Json.serialize(Trigger.new);
            String oldOppMapstr = Json.serialize(Trigger.oldMap);
            LitmusCalloutClass.sendFeedBackRequestToLitmus(newOppListstr, oldOppMapstr);
        }
    }
    OpportuntyTriggerHelper opp = new OpportuntyTriggerHelper();
        if((trigger.isInsert || trigger.isUpdate) && trigger.isBefore && !Recursivecheck.isOpportunityAutoUpdateOfCustomerType){
            Recursivecheck.isOpportunityAutoUpdateOfCustomerType = true;
            opp.autoUpdateOfCustomerType(trigger.new);
        }
        if(Trigger.isupdate && Trigger.isAfter){
              
             OpportunityRFQApprovalSubmissionHelper.OpportunityRFQApprovalSubmission(Trigger.new, Trigger.OldMap);
         }
    }
        
        if(Trigger.isupdate && Trigger.isAfter){
             
           
            OpportunityToFeedback op=new OpportunityToFeedback();
            
          if(!Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive){
              Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive = true;
               op.demo(Trigger.new, Trigger.oldMap);
               
               
               }
           op.updateOpportunity(trigger.new,Trigger.oldMap);
            
        }
        
    
}