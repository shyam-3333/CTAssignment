@isTest
private class SchedularBDReports_Test{
  static testMethod void myUnitTest1() {
      system.Test.startTest();
           SchedularBDReports lcr = new SchedularBDReports();
           String chron = '0 0 23 * * ?';        
           system.schedule('test',chron,  lcr);
      system.Test.stopTest(); 
    }
}