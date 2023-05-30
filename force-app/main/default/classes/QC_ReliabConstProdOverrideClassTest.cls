@isTest
private class QC_ReliabConstProdOverrideClassTest {
    @isTest
    static void testfetchConstructionData() {
        QC_Access_Component__c obj = new QC_Access_Component__c();
        insert obj;
        
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'WLC';
        custSettObj.Sequence_Number__c = '0021';
        insert custSettObj;
        
        
        QC_Access_Component__c obj1 = new QC_Access_Component__c();
        String refNo = 'WLC';
        obj1.SKU_Reference__c ='Test';
        obj1.Sample_Category__c ='Wallets';
        obj1.Sample_Type__c ='New';
        custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
        obj1.isConstructionTesting__c =True;
        obj1.Final_Verdict__c = 'Reject';
       
      
        QC_ReliabConstProdOverrideClass.saveAndDisplayDetails(obj1);
        //String s= obj1.Report_Ref_Number__c;
        QC_ReliabConstProdOverrideClass.fetchConstructionData(obj);
        
        //update obj1;
        
       QC_ReliabConstProdOverrideClass.updateComponent(obj.id,obj);
        
        

    }
}