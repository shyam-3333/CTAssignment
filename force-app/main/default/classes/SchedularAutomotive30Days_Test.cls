@isTest
private class SchedularAutomotive30Days_Test{
  static testMethod void myUnitTest1() {
      system.Test.startTest();
           SchedularAutomotive30Days lcr = new SchedularAutomotive30Days();
           String chron = '0 0 23 * * ?';        
           system.schedule('test',chron,  lcr);
      system.Test.stopTest(); 
    }
    
    static testMethod void myUnitTest2() {
      system.Test.startTest();
           SchedularAutomotive7Days lcr1 = new SchedularAutomotive7Days();
           String chron2 = '0 0 21 * * ?';        
           system.schedule('test1',chron2,  lcr1);
      system.Test.stopTest(); 
    }
}