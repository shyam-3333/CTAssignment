@isTest
public class BatchToUpdateTaneiraProductsTest {

    @isTest
    Public static void testmethod1()
    {
        vendor__c acc = new vendor__c();
        acc.Name = 'TestClass1';
        acc.Mail_ID__c = 'Muttu@gmail.com';
        acc.Mobile_Phone__c ='8123559020';
        insert acc;
        
        Product__c prd = new Product__c();
        
        prd.Name = 'ApprovalRequestTest1';
        prd.Product_Category_Taneira__c = 'Saree';
        prd.Cluster__c = 'TEST1';
        prd.Taneira_Material_Weft__c = 'TEST1';
        prd.Material_Wrap__c = 'TEST1';
        prd.Workmanship__c = 'EX';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 3;
        prd.Cost__c = 6;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Outsourced Design';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=6;
        prd.Comments__c='Testq432';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Occasion__c = 'TEST1';
        prd.Zari_Type__c = 'TEST1';
        //prodList.add(prd);
        insert prd ;
        
        
BatchToUpdateTaneiraProducts prodBatch = new BatchToUpdateTaneiraProducts();
database.executeBatch(prodBatch, 200);
    }
}