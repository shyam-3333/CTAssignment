global class ScheduleSendMailForOrderOpp implements Schedulable {
   global void execute(SchedulableContext sc) {
      Titan_SendMailForOrdenWonOpp b = new Titan_SendMailForOrdenWonOpp(); 
      database.executebatch(b);
   }
}