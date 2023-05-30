@isTest
public class scheduleIndentToOracleTest{

    static testMethod void testScheduleIndentToOracle(){
        Test.StartTest();  
        scheduleIndentToOracle obj = new scheduleIndentToOracle();
        String sch = '0 0 23 * * ?'; system.schedule('Test Territory Check', sch, obj);
        Test.stopTest();
    }
}