@isTest
public class RTWschedulerTest {
    public static testmethod void  verifyData(){
        list<RTW_Product__c> prodList = new list<RTW_Product__c>();
        // TriggerExecutionController__c ta = new TriggerExecutionController__c();
        // ta.name = 'ProductSuggestedMRPHelper';
        // ta.TriggerIsActive__c = false;
        //insert ta;
        
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c ='8762921827' ;
        acc.Mail_ID__c = 'Muttu@gmail.com';
        insert acc;
        
        
        //delete prodList;
        
        new RTWpriceupdate().loadDataExcel();
        new RTWclassificationdata().loadDataExcel();
        
        //Test.StartTest();
        RTW_Product__c prd = new RTW_Product__c();
        prd.Name = 'RTW1';
        prd.Product__c = 'Saree';
        prd.PO_Number__c = 575757;
        prd.Base_Colour__c = 'red';
        prd.Collection__c = 'SILK';
        prd.Craft__c = 'Ikkat';
        prd.MRP_Pc__c = 2000;
        prd.Buyers_Cost__c = 2000;
        prd.Quantity__c = 50;
        prd.Season__c='Contrast Border';
        prd.Gender__c='Female';
        prd.Pricing_date__c = system.now();
        prd.Total_Costs__c=5900;
        prodList.add(prd);
        
        RTW_Product__c prd1 = new RTW_Product__c();
        prd1.Name = 'RTW1';
        prd1.Product__c = 'Saree';
        prd1.PO_Number__c = 575757;
        prd1.Base_Colour__c = 'red';
        prd1.Collection__c = 'SILK';
        prd1.Craft__c = 'Ikkat';
        prd1.MRP_Pc__c = 2000;
        prd1.Buyers_Cost__c = 2000;
        prd1.Quantity__c = 50;
        prd1.Season__c='Contrast Border';
        prd1.Gender__c='Female';
        prd1.Pricing_date__c = system.now();
        prd1.Total_Costs__c=5900;
        prodList.add(prd1);
        //insert prodList;
        RTW_Product__c prd2 = new RTW_Product__c();
        prd2.Name = 'RTW1';
        prd2.Product__c = 'Saree';
        prd2.PO_Number__c = 575757;
        prd2.Base_Colour__c = 'red';
        prd2.Collection__c = 'SILK';
        prd2.Craft__c = 'Ikkat';
        prd2.MRP_Pc__c = 2000;
        prd2.Buyers_Cost__c = 2000;
        prd2.Quantity__c = 50;
        prd2.Season__c='Contrast Border';
        prd2.Gender__c='Female';
        prd2.Pricing_date__c = system.now();
        prd2.Total_Costs__c=5900;
        prodList.add(prd2);
        insert prodList;
        Test.startTest();
        RTWemailscheduler sh1 = new RTWemailscheduler(); 
        sh1.sendmail();
        sh1.nullemail();
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, sh1);
        Test.stopTest();
        
    }
}