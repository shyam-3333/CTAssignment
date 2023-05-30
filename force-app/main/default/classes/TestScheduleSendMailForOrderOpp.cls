@isTest
public class TestScheduleSendMailForOrderOpp{
  @isTest public static void unitTest(){
      ScheduleSendMailForOrderOpp  ssmo=new ScheduleSendMailForOrderOpp();
      SchedulableContext scon;
      ssmo.execute(scon);
  }
}