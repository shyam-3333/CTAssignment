/************************************************
* Created By: Poornapriya YN
* Description : This code schedules ResetAutoNumber class
***************************************************/
global class ScheduleAutoNumber implements Schedulable {
   global void execute(SchedulableContext SC) {
      ResetAutoNumber reset = new ResetAutoNumber(); 
      reset.autoNumberByMonth();
      
   }
}