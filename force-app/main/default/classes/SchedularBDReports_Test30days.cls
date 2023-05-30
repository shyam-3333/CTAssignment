@isTest
private class SchedularBDReports_Test30days{
  static testMethod void myUnitTest1() {
      system.Test.startTest();
           SchedularBDReports30days lcr = new SchedularBDReports30days();
           String chron = '0 0 23 * * ?';        
           system.schedule('test',chron,  lcr);
      system.Test.stopTest(); 
    }
}