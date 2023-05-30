/**************************************************************************************************************
 * Created by: Vinoth kumar A
 * Crated on : 04/10/2019
 * Description: This trigger sends an email alert to the Opportunity/visit owner when the survey is taken by the customer.
**************************************************************************************************************/
trigger SurveyTakenEmailAlertTrigger on SurveyTaker__c (before insert, after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        SurveyTakenEmailAlertHelper.SurveyTakenEmailAlert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        SurveyTakenEmailAlertHelper.SurveyTakenTrackInSurveySent(Trigger.new);
    }
}