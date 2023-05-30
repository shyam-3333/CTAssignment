@isTest
public class ProposalWatchesDeltaMorningScheduleTest {
    public static testMethod void testScheduleCallout() {
    Test.startTest();
    ProposalToolWatchesDeltaMorningSchedule scheduleCallout = new ProposalToolWatchesDeltaMorningSchedule();
    String scheduleTime = '11 30 00 * * ?'; 
    system.schedule('Test Scheduler', scheduleTime, scheduleCallout); 
    Test.stopTest();
    }
}