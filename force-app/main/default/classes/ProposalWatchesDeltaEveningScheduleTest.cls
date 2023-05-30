@isTest
public class ProposalWatchesDeltaEveningScheduleTest {
    public static testMethod void testScheduleCallout() {
    Test.startTest();
    ProposalToolWatchesDeltaEveningSchedule scheduleCallout = new ProposalToolWatchesDeltaEveningSchedule();
    String scheduleTime = '11 30 00 * * ?'; 
    system.schedule('Test Scheduler', scheduleTime, scheduleCallout); 
    Test.stopTest();
    }

}