@isTest
private class PendingProposalAOReportSchedular_Test{
  static testMethod void myUnitTest1() {
      system.Test.startTest();
           PendingProposalAOReportSchedular lcr = new PendingProposalAOReportSchedular();
           String chron = '0 0 23 * * ?';        
           system.schedule('test',chron,  lcr);
      system.Test.stopTest(); 
    }
}