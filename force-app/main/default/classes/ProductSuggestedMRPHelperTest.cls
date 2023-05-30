@isTest
public class ProductSuggestedMRPHelperTest {
    //@isTest(SeeAllData=true)
    @isTest
    public static void ProductSuggestedMRPHelperMethod(){
        
        List<Product__c> prodList= new List<Product__c>();
        
        Account acc = new Account();
        acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        //acc.Category__c = 'Master Weaver';
        insert acc;
        
        List<Cost_band__c> costBandList = new List<Cost_band__c>();
        Cost_band__c cb = new Cost_band__c();
        cb.Name = '1';
        cb.combinedKey__c = 'TEST1TEST1TEST1';
        cb.Min__c = 5;
        cb.Max__c = 10;
        cb.Band__c = 'AA';
        costBandList.add(cb);
        
        Cost_band__c cb1 = new Cost_band__c();
        cb1.Name = '2';
        cb1.combinedKey__c = 'TESDEFAULTTES';
        cb1.Min__c = 15;
        cb1.Max__c = 20;
        cb1.Band__c = 'BB';
        costBandList.add(cb1);
        
        Cost_band__c cb3 = new Cost_band__c();
        cb3.Name = '4';
        cb3.combinedKey__c = 'ABCABCDEFAULT';
        cb3.Min__c = 25;
        cb3.Max__c = 30;
        cb3.Band__c = 'CC';
        costBandList.add(cb3);
        
        Cost_band__c cb4 = new Cost_band__c();
        cb4.Name = '5';
        cb4.combinedKey__c = 'XYZDEFAULTDEFAULT';
        cb4.Min__c = 35;
        cb4.Max__c = 40;
        cb4.Band__c = 'DD';
        costBandList.add(cb4);
        
        Cost_band__c cb5 = new Cost_band__c();
        cb5.Name = '6';
        cb5.combinedKey__c = 'VIRATKOHLITES';
        cb5.Min__c = 45;
        cb5.Max__c = 50;
        cb5.Band__c = 'ZZ';
        costBandList.add(cb5);
        
          Cost_band__c cb6 = new Cost_band__c();
        cb6.Name = '7';
        cb6.combinedKey__c = 'ABCDFLKGAAA';
        cb6.Min__c = 55;
        cb6.Max__c = 60;
        cb6.Band__c = 'YY';
        costBandList.add(cb6);
        
        insert costBandList;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        
        Multiplier_value__c mv = new Multiplier_value__c();
        mv.Name = '1';
        mv.Concatenation__c = 'TEST1NULLTEST1EXTEST1AA';
        mv.Multiplier__c = 1.440;
        MultiplierList.add(mv);
        
        Multiplier_value__c mv1 = new Multiplier_value__c();
        mv1.Name = '2';
        mv1.Concatenation__c = 'TESNULLTESTIKTEST12DEFAULT';  //TESNULLTESTIKTEST12BB
        mv1.Multiplier__c = 1.440;
        MultiplierList.add(mv1);
        
        Multiplier_value__c mv2 = new Multiplier_value__c();
        mv2.Name = '3';
        mv2.Concatenation__c = 'ABCNULLABCIKKATDEFAULTCC'; 
        mv2.Multiplier__c = 1.440;
        MultiplierList.add(mv2);
        
        Multiplier_value__c mv3 = new Multiplier_value__c();
        mv3.Name = '4';
        mv3.Concatenation__c = 'XYZNULLSIIKKATDEFAULTDEFAULT'; 
        mv3.Multiplier__c = 1.440;
        MultiplierList.add(mv3);
        
         Multiplier_value__c mv4 = new Multiplier_value__c();
        mv4.Name = '5';
        mv4.Concatenation__c = 'TEST1NULLTEST1DEFAULTTEST1AA'; 
        mv4.Multiplier__c = 1.440;
        MultiplierList.add(mv4);
        
         Multiplier_value__c mv5 = new Multiplier_value__c();
        mv5.Name = '6';
        mv5.Concatenation__c = 'TESNULLTESTDEFAULTTEST12DEFAULT'; 
        mv5.Multiplier__c = 1.440;
        MultiplierList.add(mv5);
        
         Multiplier_value__c mv6 = new Multiplier_value__c();
        mv6.Name = '7';
        mv6.Concatenation__c = 'ABCNULLABCDEFAULTDEFAULTCC'; 
        mv6.Multiplier__c = 1.440;
        MultiplierList.add(mv6);

         Multiplier_value__c mv7 = new Multiplier_value__c();
        mv7.Name = '8';
        mv7.Concatenation__c = 'XYZWNULLSIDEFAULTDEFAULTDEFAULT'; 
        mv7.Multiplier__c = 1.440;
        MultiplierList.add(mv7);
        
         Multiplier_value__c mv8 = new Multiplier_value__c();
        mv8.Name = '9';
        mv8.Concatenation__c = 'TEST1NULLDEFAULTEXADFTEST1NULL'; 
        mv8.Multiplier__c = 1.440;
        MultiplierList.add(mv8);
        
        Multiplier_value__c mv9 = new Multiplier_value__c();
        mv9.Name = '10';
        mv9.Concatenation__c = 'VIRATNULLDEFAULTISRKTEST12DEFAULT'; 
        mv9.Multiplier__c = 1.440;
        MultiplierList.add(mv9);
        
        Multiplier_value__c mv10 = new Multiplier_value__c();
        mv10.Name = '11';
        mv10.Concatenation__c = 'ABCDFNULLDEFAULTIKKATRTDEFAULTYY'; 
        mv10.Multiplier__c = 1.440;
        MultiplierList.add(mv10);

        
        insert MultiplierList;
        
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
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.Account__c = acc.Id;
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
        
        
        Product__c prd1 = new Product__c();
        
        prd1.Name = 'ApprovalRequestTest1';
        prd1.Product_Category_Taneira__c = 'Saree';
        prd1.Cluster__c = 'TES';
        prd1.Taneira_Material_Weft__c = 'TEST';
        prd1.Material_Wrap__c = 'TEST';
        prd1.Workmanship__c = 'IK';
        prd1.Cost_Band__c = 'A(0-2)';            
        prd1.Quantity__c = 3;
        prd1.Cost__c = 16;
        prd1.Border_Pattern__c='Contrast Border';
        prd1.Body_Pattern__c='Medium Buta';
        prd1.Loom__c = 'Handloom';
        prd1.PO_Number__c='324324';
        prd1.Proc_Type__c = 'Value Added';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.Account__c = acc.Id;
        prd1.Pallu_Pattern__c='Contrast Pallu';
        prd1.Suggested_MRP__c=454;
        prd1.Comments__c='Testq432';
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
        prd1.Occasion__c = 'TES';
        prd1.Zari_Type__c = 'TEST12';
        //prodList.add(prd);
        insert prd1 ;
        
        Product__c prd2 = new Product__c();
        
        prd2.Name = 'ApprovalRequestTest1';
        prd2.Product_Category_Taneira__c = 'Saree';
        prd2.Cluster__c = 'ABC';                      //ABCNULLABCIKKATDEFAULTCC 
        // prd2.Fabric__c = 'SILK';
        prd2.Taneira_Material_Weft__c = 'ABC';
        prd2.Material_Wrap__c = 'ABC';
        prd2.Workmanship__c = 'Ikkat';
        prd2.Cost_Band__c = 'A(0-2)';
        prd2.Quantity__c = 3;
        prd2.Cost__c = 26;
        prd2.Border_Pattern__c='Contrast Border';
        prd2.Body_Pattern__c='Medium Buta';
        prd2.Loom__c = 'Handloom';
        prd2.PO_Number__c='324324';
        prd2.Proc_Type__c = 'Value Added';
        prd2.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd2.Account__c = acc.Id;
        prd2.Pallu_Pattern__c='Contrast Pallu';
        prd2.Suggested_MRP__c=26;
        prd2.Comments__c='Testq432';
        prd2.Sync_Date__c=System.today();
        prd2.Created_From__c = 'Offline App';
        prd2.Collection_Update__c = 'test';
        prd2.Body_Pattern_Update__c = 'Solid';
        prd2.Body_Des_Element_Update__c = 'Temple';
        prd2.Body_Des_Material_Update__c = 'Only Zari';
        prd2.Body_Des_Density_Update__c = 'Dense';
        prd2.Border_Pattern_Update__c = 'Contrast Border';
        prd2.Border_Des_Material_Update__c = 'Only Zari';
        prd2.Border_Size_Update__c = 'No Border';
        prd2.Pallu_Pattern_Update__c = 'No Pallu';
        prd2.Pallu_Design_Update__c = 'Solid';
        prd2.Pallu_Des_Material_Update__c = 'Only Zari';
        prd2.Pallu_Des_Density_Update__c = 'Dense';
        prd2.Pallu_Size_Update__c = 'Small';
        prd2.Border_Des_Element_Update__c = 'Temple';
        prd2.Occasion_Update__c = 'Formal';
        prd2.Design_Story_Update__c = 'Korvai';
        prd2.Story_1_Update__c = 'Bengal';
        prd2.PO_Number__c = 'test';
        prd2.Occasion__c = 'adads';
        
        //prodList.add(prd);
        insert prd2 ;
        
        Product__c prd3 = new Product__c();
        
        prd3.Name = 'ApprovalRequestTest1';
        prd3.Product_Category_Taneira__c = 'Saree';
        prd3.Cluster__c = 'XYZ';
        prd3.Taneira_Material_Weft__c = 'SI';
        prd3.Material_Wrap__c = 'SI';
        prd3.Workmanship__c = 'Ikkat';                      //XYZNULLSIIKKATDEFAULTDEFAULT
        prd3.Cost_Band__c = 'A(0-2)';
        prd3.Quantity__c = 3;
        prd3.Cost__c = 36;
        prd3.Border_Pattern__c='Contrast Border';
        prd3.Body_Pattern__c='Medium Buta';
        prd3.Loom__c = 'Handloom';
        prd3.PO_Number__c='324324';
        prd3.Proc_Type__c = 'Value Added';
        prd3.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd3.Account__c = acc.Id;
        prd3.Pallu_Pattern__c='Contrast Pallu';
        prd3.Suggested_MRP__c=454;
        prd3.Comments__c='Testq432';
        prd3.Sync_Date__c=System.today();
        prd3.Created_From__c = 'Offline App';
        prd3.Collection_Update__c = 'test';
        prd3.Body_Pattern_Update__c = 'Solid';
        prd3.Body_Des_Element_Update__c = 'Temple';
        prd3.Body_Des_Material_Update__c = 'Only Zari';
        prd3.Body_Des_Density_Update__c = 'Dense';
        prd3.Border_Pattern_Update__c = 'Contrast Border';
        prd3.Border_Des_Material_Update__c = 'Only Zari';
        prd3.Border_Size_Update__c = 'No Border';
        prd3.Pallu_Pattern_Update__c = 'No Pallu';
        prd3.Pallu_Design_Update__c = 'Solid';
        prd3.Pallu_Des_Material_Update__c = 'Only Zari';
        prd3.Pallu_Des_Density_Update__c = 'Dense';
        prd3.Pallu_Size_Update__c = 'Small';
        prd3.Border_Des_Element_Update__c = 'Temple';
        prd3.Occasion_Update__c = 'Formal';
        prd3.Design_Story_Update__c = 'Korvai';
        prd3.Story_1_Update__c = 'Bengal';
        prd3.PO_Number__c = 'test';
        prd3.Occasion__c = 'e5rd';
        //prodList.add(prd);
        insert prd3 ;
        
         Product__c prd4 = new Product__c();
        
        prd4.Name = 'ApprovalRequestTest1';
        prd4.Product_Category_Taneira__c = 'Saree';
        prd4.Cluster__c = 'TEST1';
        prd4.Taneira_Material_Weft__c = 'TEST1';    //TEST1NULLTEST1DEFAULTTEST1AA
        prd4.Material_Wrap__c = 'TEST1';
        prd4.Workmanship__c = 'EXADF';
        prd4.Cost_Band__c = 'A(0-2)';
        prd4.Quantity__c = 3;
        prd4.Cost__c = 6;
        prd4.Border_Pattern__c='Contrast Border';
        prd4.Body_Pattern__c='Medium Buta';
        prd4.Loom__c = 'Handloom';
        prd4.PO_Number__c='324324';
        prd4.Proc_Type__c = 'Value Added';
        prd4.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd4.Account__c = acc.Id;
        prd4.Pallu_Pattern__c='Contrast Pallu';
        prd4.Suggested_MRP__c=6;
        prd4.Comments__c='Testq432';
        prd4.Sync_Date__c=System.today();
        prd4.Created_From__c = 'Offline App';
        prd4.Collection_Update__c = 'test';
        prd4.Body_Pattern_Update__c = 'Solid';
        prd4.Body_Des_Element_Update__c = 'Temple';
        prd4.Body_Des_Material_Update__c = 'Only Zari';
        prd4.Body_Des_Density_Update__c = 'Dense';
        prd4.Border_Pattern_Update__c = 'Contrast Border';
        prd4.Border_Des_Material_Update__c = 'Only Zari';
        prd4.Border_Size_Update__c = 'No Border';
        prd4.Pallu_Pattern_Update__c = 'No Pallu';
        prd4.Pallu_Design_Update__c = 'Solid';
        prd4.Pallu_Des_Material_Update__c = 'Only Zari';
        prd4.Pallu_Des_Density_Update__c = 'Dense';
        prd4.Pallu_Size_Update__c = 'Small';
        prd4.Border_Des_Element_Update__c = 'Temple';
        prd4.Occasion_Update__c = 'Formal';
        prd4.Design_Story_Update__c = 'Korvai';
        prd4.Story_1_Update__c = 'Bengal';
        prd4.PO_Number__c = 'test';
        prd4.Occasion__c = 'TEST1';
        prd4.Zari_Type__c = 'TEST1';
        //prodList.add(prd4);
        insert prd4 ;
        
        
        Product__c prd5 = new Product__c();
        
        prd5.Name = 'ApprovalRequestTest1';
        prd5.Product_Category_Taneira__c = 'Saree';
        prd5.Cluster__c = 'TES';
        prd5.Taneira_Material_Weft__c = 'TEST';
        prd5.Material_Wrap__c = 'TEST';
        prd5.Workmanship__c = 'IsrK';
        prd5.Cost_Band__c = 'A(0-2)';            
        prd5.Quantity__c = 3;
        prd5.Cost__c = 16;                                  //TESNULLTESTDEFAULTTEST12DEFAULT
        prd5.Border_Pattern__c='Contrast Border';
        prd5.Body_Pattern__c='Medium Buta';
        prd5.Loom__c = 'Handloom';
        prd5.PO_Number__c='324324';
        prd5.Proc_Type__c = 'Value Added';
        prd5.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd5.Account__c = acc.Id;
        prd5.Pallu_Pattern__c='Contrast Pallu';
        prd5.Suggested_MRP__c=454;
        prd5.Comments__c='Testq432';
        prd5.Sync_Date__c=System.today();
        prd5.Created_From__c = 'Offline App';
        prd5.Collection_Update__c = 'test';
        prd5.Body_Pattern_Update__c = 'Solid';
        prd5.Body_Des_Element_Update__c = 'Temple';
        prd5.Body_Des_Material_Update__c = 'Only Zari';
        prd5.Body_Des_Density_Update__c = 'Dense';
        prd5.Border_Pattern_Update__c = 'Contrast Border';
        prd5.Border_Des_Material_Update__c = 'Only Zari';
        prd5.Border_Size_Update__c = 'No Border';
        prd5.Pallu_Pattern_Update__c = 'No Pallu';
        prd5.Pallu_Design_Update__c = 'Solid';
        prd5.Pallu_Des_Material_Update__c = 'Only Zari';
        prd5.Pallu_Des_Density_Update__c = 'Dense';
        prd5.Pallu_Size_Update__c = 'Small';
        prd5.Border_Des_Element_Update__c = 'Temple';
        prd5.Occasion_Update__c = 'Formal';
        prd5.Design_Story_Update__c = 'Korvai';
        prd5.Story_1_Update__c = 'Bengal';
        prd5.PO_Number__c = 'test';
        prd5.Occasion__c = 'TES';
        prd5.Zari_Type__c = 'TEST12';
        //prodList.add(prd);
        insert prd5 ;
        
        Product__c prd6 = new Product__c();
        
        prd6.Name = 'ApprovalRequestTest1';
        prd6.Product_Category_Taneira__c = 'Saree';
        prd6.Cluster__c = 'ABC';                      //ABCNULLABCDEFAULTDEFAULTCC
        // prd6.Fabric__c = 'SILK';
        prd6.Taneira_Material_Weft__c = 'ABC';
        prd6.Material_Wrap__c = 'ABC';
        prd6.Workmanship__c = 'Ikkatrt';
        prd6.Cost_Band__c = 'A(0-2)';
        prd6.Quantity__c = 3;
        prd6.Cost__c = 26;
        prd6.Border_Pattern__c='Contrast Border';
        prd6.Body_Pattern__c='Medium Buta';
        prd6.Loom__c = 'Handloom';
        prd6.PO_Number__c='324324';
        prd6.Proc_Type__c = 'Value Added';
        prd6.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd6.Account__c = acc.Id;
        prd6.Pallu_Pattern__c='Contrast Pallu';
        prd6.Suggested_MRP__c=26;
        prd6.Comments__c='Testq432';
        prd6.Sync_Date__c=System.today();
        prd6.Created_From__c = 'Offline App';
        prd6.Collection_Update__c = 'test';
        prd6.Body_Pattern_Update__c = 'Solid';
        prd6.Body_Des_Element_Update__c = 'Temple';
        prd6.Body_Des_Material_Update__c = 'Only Zari';
        prd6.Body_Des_Density_Update__c = 'Dense';
        prd6.Border_Pattern_Update__c = 'Contrast Border';
        prd6.Border_Des_Material_Update__c = 'Only Zari';
        prd6.Border_Size_Update__c = 'No Border';
        prd6.Pallu_Pattern_Update__c = 'No Pallu';
        prd6.Pallu_Design_Update__c = 'Solid';
        prd6.Pallu_Des_Material_Update__c = 'Only Zari';
        prd6.Pallu_Des_Density_Update__c = 'Dense';
        prd6.Pallu_Size_Update__c = 'Small';
        prd6.Border_Des_Element_Update__c = 'Temple';
        prd6.Occasion_Update__c = 'Formal';
        prd6.Design_Story_Update__c = 'Korvai';
        prd6.Story_1_Update__c = 'Bengal';
        prd6.PO_Number__c = 'test';
        prd6.Occasion__c = 'adads';
         prd6.Zari_Type__c = 'ryhdt';
        
        //prodList.add(prd);
        insert prd6 ;
        
        Product__c prd7 = new Product__c();
        
        prd7.Name = 'ApprovalRequestTest1';
        prd7.Product_Category_Taneira__c = 'Saree';
        prd7.Cluster__c = 'XYZW';
        prd7.Taneira_Material_Weft__c = 'SI';
        prd7.Material_Wrap__c = 'SI';
        prd7.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd7.Cost_Band__c = 'A(0-2)';
        prd7.Quantity__c = 3;
        prd7.Cost__c = 36;
        prd7.Border_Pattern__c='Contrast Border';
        prd7.Body_Pattern__c='Medium Buta';
        prd7.Loom__c = 'Handloom';
        prd7.PO_Number__c='324324';
        prd7.Proc_Type__c = 'Value Added';
        prd7.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd7.Account__c = acc.Id;
        prd7.Pallu_Pattern__c='Contrast Pallu';
        prd7.Suggested_MRP__c=454;
        prd7.Comments__c='Testq432';
        prd7.Sync_Date__c=System.today();
        prd7.Created_From__c = 'Offline App';
        prd7.Collection_Update__c = 'test';
        prd7.Body_Pattern_Update__c = 'Solid';
        prd7.Body_Des_Element_Update__c = 'Temple';
        prd7.Body_Des_Material_Update__c = 'Only Zari';
        prd7.Body_Des_Density_Update__c = 'Dense';
        prd7.Border_Pattern_Update__c = 'Contrast Border';
        prd7.Border_Des_Material_Update__c = 'Only Zari';
        prd7.Border_Size_Update__c = 'No Border';
        prd7.Pallu_Pattern_Update__c = 'No Pallu';
        prd7.Pallu_Design_Update__c = 'Solid';
        prd7.Pallu_Des_Material_Update__c = 'Only Zari';
        prd7.Pallu_Des_Density_Update__c = 'Dense';
        prd7.Pallu_Size_Update__c = 'Small';
        prd7.Border_Des_Element_Update__c = 'Temple';
        prd7.Occasion_Update__c = 'Formal';
        prd7.Design_Story_Update__c = 'Korvai';
        prd7.Story_1_Update__c = 'Bengal';
        prd7.PO_Number__c = 'test';
        prd7.Occasion__c = 'e5rd';
         prd7.Zari_Type__c = 'wterter';
        //prodList.add(prd);
        insert prd7 ;
        
               Product__c prd8 = new Product__c();
        
        prd8.Name = 'ApprovalRequestTest1';
        prd8.Product_Category_Taneira__c = 'Saree';
        prd8.Cluster__c = 'TEST1';
        prd8.Taneira_Material_Weft__c = 'rger';    //TEST1NULLDEFAULTEXADFTEST1NULL
        prd8.Material_Wrap__c = 'rgrfgd';
        prd8.Workmanship__c = 'EXADF';
        prd8.Cost_Band__c = 'A(0-2)';
        prd8.Quantity__c = 3;
        prd8.Cost__c = 6;
        prd8.Border_Pattern__c='Contrast Border';
        prd8.Body_Pattern__c='Medium Buta';
        prd8.Loom__c = 'Handloom';
        prd8.PO_Number__c='324324';
        prd8.Proc_Type__c = 'Value Added';
        prd8.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd8.Account__c = acc.Id;
        prd8.Pallu_Pattern__c='Contrast Pallu';
        prd8.Suggested_MRP__c=6;
        prd8.Comments__c='Testq432';
        prd8.Sync_Date__c=System.today();
        prd8.Created_From__c = 'Offline App';
        prd8.Collection_Update__c = 'test';
        prd8.Body_Pattern_Update__c = 'Solid';
        prd8.Body_Des_Element_Update__c = 'Temple';
        prd8.Body_Des_Material_Update__c = 'Only Zari';
        prd8.Body_Des_Density_Update__c = 'Dense';
        prd8.Border_Pattern_Update__c = 'Contrast Border';
        prd8.Border_Des_Material_Update__c = 'Only Zari';
        prd8.Border_Size_Update__c = 'No Border';
        prd8.Pallu_Pattern_Update__c = 'No Pallu';
        prd8.Pallu_Design_Update__c = 'Solid';
        prd8.Pallu_Des_Material_Update__c = 'Only Zari';
        prd8.Pallu_Des_Density_Update__c = 'Dense';
        prd8.Pallu_Size_Update__c = 'Small';
        prd8.Border_Des_Element_Update__c = 'Temple';
        prd8.Occasion_Update__c = 'Formal';
        prd8.Design_Story_Update__c = 'Korvai';
        prd8.Story_1_Update__c = 'Bengal';
        prd8.PO_Number__c = 'test';
        prd8.Occasion__c = 'TEST1';
        prd8.Zari_Type__c = 'TEST1';
        //prodList.add(prd8);
        insert prd8 ;
        
        
        Product__c prd9 = new Product__c();
        
        prd9.Name = 'ApprovalRequestTest1';
        prd9.Product_Category_Taneira__c = 'Saree';
        prd9.Cluster__c = 'VIRAT';
        prd9.Taneira_Material_Weft__c = 'KOHLI';
        prd9.Material_Wrap__c = 'KOHLI';
        prd9.Workmanship__c = 'IsrK';
        prd9.Cost_Band__c = 'A(0-2)';            
        prd9.Quantity__c = 3;
        prd9.Cost__c = 46;                                  //VIRATNULLDEFAULTISRKTEST12DEFAULT
        prd9.Border_Pattern__c='Contrast Border';
        prd9.Body_Pattern__c='Medium Buta';
        prd9.Loom__c = 'Handloom';
        prd9.PO_Number__c='324324';
        prd9.Proc_Type__c = 'Value Added';
        prd9.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd9.Account__c = acc.Id;
        prd9.Pallu_Pattern__c='Contrast Pallu';
        prd9.Suggested_MRP__c=454;
        prd9.Comments__c='Testq432';
        prd9.Sync_Date__c=System.today();
        prd9.Created_From__c = 'Offline App';
        prd9.Collection_Update__c = 'test';
        prd9.Body_Pattern_Update__c = 'Solid';
        prd9.Body_Des_Element_Update__c = 'Temple';
        prd9.Body_Des_Material_Update__c = 'Only Zari';
        prd9.Body_Des_Density_Update__c = 'Dense';
        prd9.Border_Pattern_Update__c = 'Contrast Border';
        prd9.Border_Des_Material_Update__c = 'Only Zari';
        prd9.Border_Size_Update__c = 'No Border';
        prd9.Pallu_Pattern_Update__c = 'No Pallu';
        prd9.Pallu_Design_Update__c = 'Solid';
        prd9.Pallu_Des_Material_Update__c = 'Only Zari';
        prd9.Pallu_Des_Density_Update__c = 'Dense';
        prd9.Pallu_Size_Update__c = 'Small';
        prd9.Border_Des_Element_Update__c = 'Temple';
        prd9.Occasion_Update__c = 'Formal';
        prd9.Design_Story_Update__c = 'Korvai';
        prd9.Story_1_Update__c = 'Bengal';
        prd9.PO_Number__c = 'test';
        prd9.Occasion__c = 'TES';
        prd9.Zari_Type__c = 'TEST12';
        //prodList.add(prd);
        insert prd9 ;
        
        Product__c prd10 = new Product__c();
        
        prd10.Name = 'ApprovalRequestTest1';
        prd10.Product_Category_Taneira__c = 'Saree';
        prd10.Cluster__c = 'ABCDF';                      //ABCDFNULLDEFAULTIKKATRTDEFAULTYY
        // prd10.Fabric__c = 'SILK';
        prd10.Taneira_Material_Weft__c = 'LKG';               //ABCDFLKGAAA adads
        prd10.Material_Wrap__c = 'LKG';
        prd10.Workmanship__c = 'Ikkatrt';
        prd10.Cost_Band__c = 'A(0-2)';
        prd10.Quantity__c = 3;
        prd10.Cost__c = 56;
        prd10.Border_Pattern__c='Contrast Border';
        prd10.Body_Pattern__c='Medium Buta';
        prd10.Loom__c = 'Handloom';
        prd10.PO_Number__c='324324';
        prd10.Proc_Type__c = 'Value Added';
        prd10.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd10.Account__c = acc.Id;
        prd10.Pallu_Pattern__c='Contrast Pallu';
        prd10.Suggested_MRP__c=26;
        prd10.Comments__c='Testq432';
        prd10.Sync_Date__c=System.today();
        prd10.Created_From__c = 'Offline App';
        prd10.Collection_Update__c = 'test';
        prd10.Body_Pattern_Update__c = 'Solid';
        prd10.Body_Des_Element_Update__c = 'Temple';
        prd10.Body_Des_Material_Update__c = 'Only Zari';
        prd10.Body_Des_Density_Update__c = 'Dense';
        prd10.Border_Pattern_Update__c = 'Contrast Border';
        prd10.Border_Des_Material_Update__c = 'Only Zari';
        prd10.Border_Size_Update__c = 'No Border';
        prd10.Pallu_Pattern_Update__c = 'No Pallu';
        prd10.Pallu_Design_Update__c = 'Solid';
        prd10.Pallu_Des_Material_Update__c = 'Only Zari';
        prd10.Pallu_Des_Density_Update__c = 'Dense';
        prd10.Pallu_Size_Update__c = 'Small';
        prd10.Border_Des_Element_Update__c = 'Temple';
        prd10.Occasion_Update__c = 'Formal';
        prd10.Design_Story_Update__c = 'Korvai';
        prd10.Story_1_Update__c = 'Bengal';
        prd10.PO_Number__c = 'test';
        prd10.Occasion__c = 'AAA';
         prd10.Zari_Type__c = 'reyruryy';
        
        //prodList.add(prd);
        insert prd10 ;
        
        Product__c prd11 = new Product__c();
        
        prd11.Name = 'ApprovalRequestTest1';
        prd11.Product_Category_Taneira__c = 'Saree';
        prd11.Cluster__c = 'XYZWA';
        prd11.Taneira_Material_Weft__c = 'SI';
        prd11.Material_Wrap__c = 'SI';
        prd11.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd11.Cost_Band__c = 'A(0-2)';
        prd11.Quantity__c = 3;
        prd11.Cost__c = 36;
        prd11.Border_Pattern__c='Contrast Border';
        prd11.Body_Pattern__c='Medium Buta';
        prd11.Loom__c = 'Handloom';
        prd11.PO_Number__c='324324';
        prd11.Proc_Type__c = 'Value Added';
        prd11.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd11.Account__c = acc.Id;
        prd11.Pallu_Pattern__c='Contrast Pallu';
        prd11.Suggested_MRP__c=454;
        prd11.Comments__c='Testq432';
        prd11.Sync_Date__c=System.today();
        prd11.Created_From__c = 'Offline App';
        prd11.Collection_Update__c = 'test';
        prd11.Body_Pattern_Update__c = 'Solid';
        prd11.Body_Des_Element_Update__c = 'Temple';
        prd11.Body_Des_Material_Update__c = 'Only Zari';
        prd11.Body_Des_Density_Update__c = 'Dense';
        prd11.Border_Pattern_Update__c = 'Contrast Border';
        prd11.Border_Des_Material_Update__c = 'Only Zari';
        prd11.Border_Size_Update__c = 'No Border';
        prd11.Pallu_Pattern_Update__c = 'No Pallu';
        prd11.Pallu_Design_Update__c = 'Solid';
        prd11.Pallu_Des_Material_Update__c = 'Only Zari';
        prd11.Pallu_Des_Density_Update__c = 'Dense';
        prd11.Pallu_Size_Update__c = 'Small';
        prd11.Border_Des_Element_Update__c = 'Temple';
        prd11.Occasion_Update__c = 'Formal';
        prd11.Design_Story_Update__c = 'Korvai';
        prd11.Story_1_Update__c = 'Bengal';
        prd11.PO_Number__c = 'test';
        prd11.Occasion__c = 'e5rd';
         prd11.Zari_Type__c = 'wterter';
        //prodList.add(prd);
        insert prd11 ;
    }
    
}