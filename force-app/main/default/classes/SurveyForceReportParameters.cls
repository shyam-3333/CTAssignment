/*
Written by : Deepak Singh G
Written date : 02-03-2020
Description : This class loads 
1) First_reminder_sent_date__c field of opportunity with first value of SurveyReminderEmailSentDate__c
2) Number_of_reminders_sent__c with the number of times reminder sent(increments on change)
3)EmailReminderDate__c this field captures the date of SurveyReminderEmailSentDate__c.
All these fields are used in reports
*/

public class SurveyForceReportParameters {
    
    public void opportunityReminderDateParameters(list<opportunity> newList, Map<Id,Opportunity> OldMap){
        for(opportunity opp :newList){
            If(opp.SurveyReminderEmailSentDate__c != null && OldMap.get(opp.Id).SurveyReminderEmailSentDate__c == null){
                opp.First_reminder_sent_date__c = opp.SurveyReminderEmailSentDate__c;
            }
            If(opp.SurveyReminderEmailSentDate__c != OldMap.get(opp.Id).SurveyReminderEmailSentDate__c){
                if(opp.Number_of_reminders_sent__c == null){
                    opp.Number_of_reminders_sent__c = 1;
                }
                else{
                    opp.Number_of_reminders_sent__c = opp.Number_of_reminders_sent__c + 1;
                }
                
            }
        }
        
    }
    Public void visitReminderDateParameters(list<Visit__c> newList, Map<Id,Visit__c> OldMap){
        for(Visit__c v1 : newList){
            If(v1.EmailReminderStatus__c == true && v1.EmailReminderStatus__c != OldMap.get(v1.Id).EmailReminderStatus__c){
                v1.EmailReminderDate__c = System.now();
            }
        }
    } 
}