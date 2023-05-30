/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 21/06/2019
* Description: If the visit type is 'by customer' an email should be sent to the visit owner to send survey to the respective customer.
*******************************************************************************/
trigger VisitOwnerEmailReminder on Visit__c (after insert, before insert, before update) {
    if(Trigger.isAfter && Trigger.isInsert && Label.VisitOwnerEmailReminderCustomLabel == 'True'){
        VisitOwnerEmailReminder_Helper.VisitOwnerEmailReminderMethod(Trigger.new);
    }
    If(trigger.isBefore && trigger.isUpdate){
        new SurveyForceReportParameters().visitReminderDateParameters(trigger.new , trigger.oldMap);
    }
}