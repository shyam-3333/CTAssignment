/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 28/05/2019
* Description: If the user has taken the survey within 5 days, a reminder should be sent to the respective user on 6th day.
*******************************************************************************/
global class SurveySentReminderSchedulerClass implements schedulable{
    global void execute(SchedulableContext sc){
        Database.executeBatch(new SurveySentCustomerReminderBatchClass(),1);
        /*********************************************************************/
        Database.executeBatch(new SurveySentOppOwnerReminderBatchClass(),1);    
    } 
}