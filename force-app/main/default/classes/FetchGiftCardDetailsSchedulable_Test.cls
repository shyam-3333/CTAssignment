@isTest
public class FetchGiftCardDetailsSchedulable_Test {
    public static testMethod void testScheduleCallout() {
    Test.startTest();
    FetchGiftCardDetailsSchedulable scheduleCallout = new FetchGiftCardDetailsSchedulable();
    String scheduleTime = '0 0 2 * * ?'; 
    system.schedule('Test Scheduler', scheduleTime, scheduleCallout); 
    Test.stopTest();
    }
}