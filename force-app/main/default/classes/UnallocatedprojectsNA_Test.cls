@isTest
private class UnallocatedprojectsNA_Test{
  static testMethod void myUnitTest1() {
      system.Test.startTest();
           UnallocatedprojectsNA lcr = new UnallocatedprojectsNA();
           String chron = '0 0 12 * * ?';        
           system.schedule('test',chron,  lcr);
      system.Test.stopTest(); 
    }
}