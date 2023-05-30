@IsTest   
public class ScheduleAutoNumberTest{
    
    public static testMethod void testschedule() {
        Test.StartTest();
        AutoNumber__c atNum = new AutoNumber__c();
        atNum.Auto_Number__c = 67;
        atNum.Name = 'SKU_Number';
        insert atNum;
        ScheduleAutoNumber sh1 = new ScheduleAutoNumber ();
        String sch = '0 0 23 * * ?'; system.schedule('Test auto num', sch, sh1); 
        Test.stopTest(); 
    }
}