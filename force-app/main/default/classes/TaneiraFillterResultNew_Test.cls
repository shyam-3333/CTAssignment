@isTest
public class TaneiraFillterResultNew_Test {
	
    public static TestMethod void taneiraFilterMethod()
    {
     	Account acc = new Account();
        acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        insert acc;
        
        list<Product__c> prodLst=new list<Product__c>();
        Product__c prd = new Product__c();
        prd.Name = 'ApprovalRequestTest1';
        prd.Product_Category_Taneira__c = 'Saree';
        prd.Cluster__c = 'BANARAS';
        prd.Taneira_Material_Weft__c = 'SILK';
        prd.Material_Wrap__c = 'SILK';
        prd.Workmanship__c = 'Ikkat';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 3;
        prd.Cost__c = 50;
        prd.Loom__c = 'Handloom';
        prd.Border_Des_Material__c = 'Only Zari';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.Account__c = acc.Id;
        prd.Sync_Date__c=System.today()-3;
        prodLst.add(prd);
        insert prodLst;
     	
        test.startTest();
            ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(prodLst);
            stdSetController.setSelected(prodLst);
             TaneiraFillterResultNew taneiraFil1 = new TaneiraFillterResultNew();
            taneiraFil1.search();
            taneiraFil1.assetClicked();
            taneiraFil1.refreshPageSize();
            taneiraFil1.getproducts();
            taneiraFil1.getItems();
            //taneiraFil1.setCon();
        test.stopTest();
    }
}