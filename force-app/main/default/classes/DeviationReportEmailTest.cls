@isTest
public class DeviationReportEmailTest {
    
    public static testmethod void  verifyData(){
        list<product__c> prodList = new list<product__c>();
        
        
        TriggerExecutionController__c ta = new TriggerExecutionController__c();
        ta.name = 'ProductSuggestedMRPHelper';
        ta.TriggerIsActive__c = false;
        insert ta;
        
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c ='8762921827' ;
        acc.Mail_ID__c = 'Muttu@gmail.com';
        insert acc;
        
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
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
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
        prd.Pricing_date__c = datetime.now().addHours(-5);
        prodList.add(prd);
        
        Product__c prd1 = new Product__c();
        prd1.Name = 'ApprovalRequestTest2';
        prd1.Pricing_date__c = datetime.now().addHours(-5);
        prd1.Product_Category_Taneira__c = 'Saree';
        prd1.Cluster__c = 'BANARAS';
        prd1.Taneira_Material_Weft__c = 'SILK';
        prd1.Material_Wrap__c = 'SILK';
        prd1.Workmanship__c = 'Ikkat';
        prd1.Cost_Band__c = 'A(0-2)';
        prd1.Quantity__c = 3;
        prd1.Cost__c = 50;
        prd1.Loom__c = 'Handloom';
        prd1.Proc_Type__c = 'Value Added';
        prd1.Border_Pattern__c='Contrast Border';
        prd1.Body_Pattern__c='Medium Buta';
        prd1.PO_Number__c='6564645';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.vendor_custom__c = acc.Id;
        prd1.Pallu_Pattern__c='Contrast Pallu';
        prd1.Suggested_MRP__c=5454;
        prd1.Comments__c='Resyusd423342';
        //prd1.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd1.Sync_Date__c=System.today();
        prd1.Created_From__c = 'Offline App';
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prodList.add(prd1);
        insert prodList;
        
       
        Test.StartTest();
        DeviationReportEmail sh1 = new DeviationReportEmail();      
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, sh1);
        
        Test.stopTest();
    }
}