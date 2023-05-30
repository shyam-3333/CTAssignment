/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class QC_ReSubmissionTest { 
	 
    static testMethod void myUnitTest() {
         QC_Components__c  compMaster = new  QC_Components__c(Name__c = 'Full Watch',master__c=true);
         insert compMaster;
         QC_Components__c  compChild = new  QC_Components__c(Name__c = 'Full Watch',Master_Variant__c=compMaster.id);
         insert compChild;
         QC_ReSubmission qcr = new QC_ReSubmission();
        QC_ReSubmission.parentComponentData(compMaster, compMaster.id);
        
    }
    static testMethod void myUnitTest1() {
         QC_Components__c  compMaster = new  QC_Components__c(Name__c = 'Full Watch');
         insert compMaster;
         QC_Components__c  compChild = new  QC_Components__c(Name__c = 'Full Watch',Master__c=true,parent__c=compMaster.id);
         insert compChild;
         QC_Components__c  compChild1 = new  QC_Components__c(Name__c = 'Case',parent__c=compChild.id,Final_Verdict__c = 'Reject',IsCopied_From_Master__c = true);
         insert compChild1;
         QC_Input_Data__c input = new QC_Input_Data__c(Component_No__c=compChild1.id);
         insert input;
         QC_Test_Data__c  test = new QC_Test_Data__c(Component_Name__c=compChild1.id);
         insert test;
        QC_ReSubmission.copyInputTestData(compChild1, 'Case');
    }
}