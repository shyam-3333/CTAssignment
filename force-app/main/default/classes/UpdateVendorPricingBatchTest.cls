@isTest
public class UpdateVendorPricingBatchTest {
    
    testmethod static void createData(){
        List<vendor__c> accList = new List<vendor__c>();
        
        UpdateVendorPricingField__c uVend1= new UpdateVendorPricingField__c();
        uVend1.Name='1';
        uVend1.Vendor_Type__c='AGGREGATOR';
        uVend1.Pricing_Type_Code__c='C';
        insert uVend1;
        UpdateVendorPricingField__c uVend2= new UpdateVendorPricingField__c();
        uVend2.Name='2';
        uVend2.Vendor_Type__c='MASTER WEAVER';
        uVend2.Pricing_Type_Code__c='B';
        insert uVend2;
        UpdateVendorPricingField__c uVend3= new UpdateVendorPricingField__c();
        uVend3.Name='3';
        uVend3.Vendor_Type__c='DESIGNER';
        uVend3.Pricing_Type_Code__c='D';
        insert uVend3; 
        
        vendor__c acc = new vendor__c();
        acc.Name ='Test Acc1';
        acc.Phone_No__c ='9890909090';
        acc.Email_Id_Vendor__c ='test@fake.com';
        //acc.RecordTypeId =Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Category__c ='Master Weaver';
        accList.add(acc);
        vendor__c acc1 = new vendor__c();
        acc1.Name='Test Acc2';
        acc1.Phone_No__c ='9890900000';
        acc1.Email_Id_Vendor__c ='test11@fake.com';
        //acc1.RecordTypeId =Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Category__c ='Weaver';
        accList.add(acc1);
        insert accList;
        
       
        
        
        test.startTest();
        UpdateVendorPricingFieldBatch obj = new UpdateVendorPricingFieldBatch();
        Database.executeBatch(obj);
        test.stopTest();

    }
}