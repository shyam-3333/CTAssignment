/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 21/06/2019
* Description: Reminder to visit owner to send survey to the respective customer.
*******************************************************************************/
global class VisitOwnerEmailReminderScheduler implements schedulable{
    global void execute(schedulableContext sc){
        Database.executeBatch( new VisitOwnerReminderBatchClass(), 1);
    }
}