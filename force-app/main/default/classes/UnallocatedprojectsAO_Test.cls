@isTest
private class UnallocatedprojectsAO_Test{
  static testMethod void myUnitTest1() {
      system.Test.startTest();
           UnallocatedprojectsAO lcr = new UnallocatedprojectsAO();
           String chron = '0 0 13 * * ?';        
           system.schedule('test',chron,  lcr);
      system.Test.stopTest(); 
    }
}