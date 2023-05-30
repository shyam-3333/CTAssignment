@isTest
private class GenericLogicClassTest {
    @isTest private static void GenericLogic(){
       /* QC_Access_Master__c ACAM =  new QC_Access_Master__c();
        ACAM.Name = 'Test Name';
        ACAM.CurrencyIsoCode = 'INR';
        ACAM.Titan_Spec_Status__c = 'Active';
        insert ACAM;*/
        GenericLogicClass.getPickListValue('QC_Access_Master__c','Titan_Spec_Status__c');
        QC_MTL_Component__c Qcmtl = new QC_MTL_Component__c();
        Qcmtl.Supplier_Name__c = 'vinoth';
        insert Qcmtl;
        GenericLogicClass.getDependentMap(Qcmtl, 'Department__c', 'Required_Test__c');
    }
}