@isTest
public class ProductSuggestedMRPHelperTest1 {
    //@isTest(SeeAllData=true)
    @isTest
    public static void ProductSuggestedMRPHelperMethod(){
        
        List<Product__c> prodList= new List<Product__c>();
        
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        // acc.Category__c = 'Master Weaver';
        insert acc;
        
        TriggerExecutionController__c exceTrgr= new TriggerExecutionController__c();  //from custom setting
        exceTrgr.Name='ProductSuggestedMRPHelper';
        exceTrgr.TriggerIsActive__c=true;
        insert exceTrgr;
        
        TriggerExecutionController__c exceTrgr1= new TriggerExecutionController__c();
        exceTrgr1.Name='ProdDuplicateCheck';
        exceTrgr1.TriggerIsActive__c=true;
        insert exceTrgr1;
        
        TriggerExecutionController__c exceTrgr2= new TriggerExecutionController__c();
        exceTrgr2.Name='ProductTriggerHandlerUpdate';
        exceTrgr2.TriggerIsActive__c=true;
        insert exceTrgr2;
        
        TriggerExecutionController__c exceTrgr3= new TriggerExecutionController__c();
        exceTrgr3.Name='ProductTriggerHandlerInsert';
        exceTrgr3.TriggerIsActive__c=true;
        insert exceTrgr3;
        
        List<Cost_Band_Master__c> costBandList = new List<Cost_Band_Master__c>();
        Cost_Band_Master__c cb = new Cost_Band_Master__c();
        cb.Name = '1';
        cb.combinedKey__c = 'TEST1DEFAULTDEFAULTTEST1';
        cb.Min__c = 5;
        cb.Max__c = 10;
        cb.Band__c = 'AA';
        cb.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb);
        
        Cost_Band_Master__c cb1 = new Cost_Band_Master__c();
        cb1.Name = '2';
        cb1.combinedKey__c = 'TESDEFAULTTESDEFAULT';
        cb1.Min__c = 15;
        cb1.Max__c = 20;
        cb1.Band__c = 'BB';
        cb1.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb1);
        
        Cost_Band_Master__c cb3 = new Cost_Band_Master__c();
        cb3.Name = '4';
        cb3.combinedKey__c = 'ABCDEFAULTABCRYHDT';
        cb3.Min__c = 25;
        cb3.Max__c = 30;
        cb3.Band__c = 'CC';
        cb3.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb3);
        
        Cost_Band_Master__c cb4 = new Cost_Band_Master__c();
        cb4.Name = '5';
        cb4.combinedKey__c = 'XYZDEFAULTDEFAULTDEFAULT';
        cb4.Min__c = 35;
        cb4.Max__c = 40;
        cb4.Band__c = 'DD';
        cb4.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb4);
        
        Cost_Band_Master__c cb5 = new Cost_Band_Master__c();
        cb5.Name = '6';
        cb5.combinedKey__c = 'VIRATKOHLITESDEFAULT';
        cb5.Min__c = 45;
        cb5.Max__c = 50;
        cb5.Band__c = 'ZZ';
        cb5.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb5);
        
        Cost_Band_Master__c cb6 = new Cost_Band_Master__c();
        cb6.Name = '7';
        cb6.combinedKey__c = 'ABCDFLKGAAADEFAULT';
        cb6.Min__c = 55;
        cb6.Max__c = 60;
        cb6.Band__c = 'YY';
        cb6.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb6);
        
        Cost_Band_Master__c cb7 = new Cost_Band_Master__c();
        cb7.Name = '8';
        cb7.combinedKey__c = 'BHAGALPURDEFAULTDEFAULTWTERTER';
        cb7.Min__c = 2201;
        cb7.Max__c = 4000;
        cb7.Band__c = 'YY';
        cb7.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb7);
        
        Cost_Band_Master__c cb8 = new Cost_Band_Master__c();
        cb8.Name = '9';
        cb8.combinedKey__c = 'INDOREDEFAULTDEFAULTWTERTER';
        cb8.Min__c = 0;
        cb8.Max__c = 50;
        cb8.Band__c = 'YY';
        cb8.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb8);
        
        Cost_Band_Master__c cb9 = new Cost_Band_Master__c();
        cb9.Name = '1';
        cb9.combinedKey__c = 'TEST1DEFAULTDEFAULTDEFAULT';
        cb9.Min__c = 10;
        cb9.Max__c = 15;
        cb9.Band__c = 'AB';
        cb9.Active__c = True;
        cb.Origin__c = 'Assam';
        costBandList.add(cb9);
        
        insert costBandList;
        
        List<Multiplier_Value_Master__c> MultiplierList = new List<Multiplier_Value_Master__c>();
        
        Multiplier_Value_Master__c mv = new Multiplier_Value_Master__c();
        mv.Name = '1';
        mv.Concatenation__c = 'TEST1NULLTEST1EXTEST1AA';
        mv.Multiplier__c = 1.440;
        mv.Active__c = True;
        MultiplierList.add(mv);
        
        Multiplier_Value_Master__c mv1 = new Multiplier_Value_Master__c();
        mv1.Name = '2';
        mv1.Concatenation__c = 'TESNULLTESTIKTEST12DEFAULT';  //TESNULLTESTIKTEST12BB
        mv1.Multiplier__c = 1.440;
        mv1.Active__c = True;
        MultiplierList.add(mv1);
        
        Multiplier_Value_Master__c mv2 = new Multiplier_Value_Master__c();
        mv2.Name = '3';
        mv2.Concatenation__c = 'ABCNULLABCIKKATRYHDTCC'; 
        mv2.Multiplier__c = 1.440;
        mv2.Active__c = True;
        MultiplierList.add(mv2);
        
        Multiplier_Value_Master__c mv3 = new Multiplier_Value_Master__c();
        mv3.Name = '4';
        mv3.Concatenation__c = 'XYZNULLSIIKKATDEFAULTDEFAULT'; 
        mv3.Multiplier__c = 1.440;
        mv3.Active__c = True;
        MultiplierList.add(mv3);
        
        Multiplier_Value_Master__c mv4 = new Multiplier_Value_Master__c();
        mv4.Name = '5';
        mv4.Concatenation__c = 'TEST1NULLTEST1DEFAULTTEST1AA'; 
        mv4.Multiplier__c = 1.440;
        mv4.Active__c = True;
        MultiplierList.add(mv4);
        
        Multiplier_Value_Master__c mv5 = new Multiplier_Value_Master__c();
        mv5.Name = '6';
        mv5.Concatenation__c = 'TESNULLTESTDEFAULTTEST12DEFAULT'; 
        mv5.Multiplier__c = 1.440;
        mv5.Active__c = True;
        MultiplierList.add(mv5);
        
        Multiplier_Value_Master__c mv6 = new Multiplier_Value_Master__c();
        mv6.Name = '7';
        mv6.Concatenation__c = 'ABCNULLDEFAULTDEFAULTDEFAULTCC'; 
        mv6.Multiplier__c = 1.440;
        mv6.Active__c = True;
        MultiplierList.add(mv6);
        
        Multiplier_Value_Master__c mv7 = new Multiplier_Value_Master__c();
        mv7.Name = '8';
        mv7.Concatenation__c = 'XYZWNULLSIDEFAULTDEFAULTDEFAULT'; 
        mv7.Multiplier__c = 1.440;
        mv7.Active__c = True;
        MultiplierList.add(mv7);
        
        Multiplier_Value_Master__c mv8 = new Multiplier_Value_Master__c();
        mv8.Name = '9';
        mv8.Concatenation__c = 'TEST1NULLDEFAULTEXADFTEST1NULL'; 
        mv8.Multiplier__c = 1.440;
        mv8.Active__c = True;
        MultiplierList.add(mv8);
        
        Multiplier_Value_Master__c mv9 = new Multiplier_Value_Master__c();
        mv9.Name = '10';
        mv9.Concatenation__c = 'VIRATNULLDEFAULTISRKTEST12DEFAULT'; 
        mv9.Multiplier__c = 1.440;
        mv9.Active__c = True;
        MultiplierList.add(mv9);
        
        Multiplier_Value_Master__c mv10 = new Multiplier_Value_Master__c();
        mv10.Name = '11';
        mv10.Concatenation__c = 'ABCDFNULLDEFAULTIKKATRTDEFAULTYY'; 
        mv10.Multiplier__c = 1.440;
        mv10.Active__c = True;
        MultiplierList.add(mv10);
        
        Multiplier_Value_Master__c mv11 = new Multiplier_Value_Master__c();
        mv11.Name = '12';
        mv11.Concatenation__c = 'BHAGALPURDEFAULTDEFAULTDEFAULTDEFAULTDEFAULT'; 
        mv11.Multiplier__c = 1.440;
        mv11.Active__c = True;
        MultiplierList.add(mv11);
        
        Multiplier_Value_Master__c mv12 = new Multiplier_Value_Master__c();
        mv12.Name = '13';
        mv12.Concatenation__c = 'INDOREDEFAULTDEFAULTDEFAULTDEFAULTYY';
        mv12.Multiplier__c = 1.5;
        mv12.Active__c = True;
        MultiplierList.add(mv12);
        
        Multiplier_Value_Master__c mv13 = new Multiplier_Value_Master__c();
        mv13.Name = '1';
        mv13.Concatenation__c = 'TEST1DEFAULTDEFAULTDEFAULTTEST1DEFAULT';
        mv13.Multiplier__c = 1.440;
        mv13.Active__c = True;
        MultiplierList.add(mv13);
        
        Multiplier_Value_Master__c mv14 = new Multiplier_Value_Master__c();
        mv14.Name = '15';
        mv14.Concatenation__c = 'TEST1DEFAULTDEFAULTDEFAULTTEST1AA';
        mv14.Multiplier__c = 1.2;
        mv14.Active__c = True;
        MultiplierList.add(mv14);
        
        Multiplier_Value_Master__c mv15 = new Multiplier_Value_Master__c();
        mv15.Name = '16';
        mv15.Concatenation__c = 'TEST1DEFAULTDEFAULTTEST1DEFAULTDEFAULT';
        mv15.Multiplier__c = 1.25;
        mv15.Origin__c='TEST1';
        mv15.Pricing_Type__c = 'DEFAULT';
        mv15.Fabric__c ='DEFAULT' ;
        mv15.Craft__c = 'TEST1' ;
        mv15.Zari__c = 'DEFAULT' ;
        mv15.Cost_Band__c = 'A';
        mv15.Active__c = True;
        MultiplierList.add(mv15);
        
        Multiplier_Value_Master__c mv16 = new Multiplier_Value_Master__c();
        mv16.Name = '17';
        mv16.Concatenation__c = 'TEST1DEFAULTDEFAULTDEFAULTDEFAULTDEFAULT';
        mv16.Multiplier__c = 1.25;
        mv16.Origin__c='TEST1';
        mv16.Pricing_Type__c = 'DEFAULT';
        mv16.Fabric__c ='DEFAULT' ;
        mv16.Craft__c = 'DEFAULT' ;
        mv16.Zari__c = 'DEFAULT' ;
        mv16.Cost_Band__c = 'AB';
        mv16.Active__c = True;
        MultiplierList.add(mv16);
        insert MultiplierList;
        
        list<AutoNumber__c> lstAn = new list<AutoNumber__c>();
        AutoNumber__c atNum = new AutoNumber__c();
        atNum.Auto_Number__c = 0;
        atNum.Name = 'SKU_Number';
        lstAn.add(atNum);
        
        AutoNumber__c atNum1 = new AutoNumber__c();
        atNum1.Auto_Number__c = 1;
        atNum1.Name = 'SHLPT';
        lstAn.add(atNum1);
        AutoNumber__c atNum2 = new AutoNumber__c();
        atNum2.Auto_Number__c = 2;
        atNum2.Name = 'SHL';
        lstAn.add(atNum2);
        AutoNumber__c atNum3 = new AutoNumber__c();
        atNum3.Auto_Number__c = 3;
        atNum3.Name = 'SHT';
        lstAn.add(atNum3);
        //try//{
        insert lstAn;
        
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        vendor__c acc1 = new vendor__c();
        acc1.Name= 'test Account';
        acc1.Phone_No__c = '2648394';
        //acc1.RecordTypeId = recordTypeIdAcc;
        insert acc1;
        
        list<Master__c> masterList = new List<Master__c>();
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Color';
        mas.Active__c  = True ;
        mas.Code__c ='R';
        masterList.add(mas);
        
        Master__c mas1 = new Master__c();
        mas1.Name= 'Ajrak';
        mas1.Name__c ='Craft'; // workmanship
        mas1.Active__c  = True ;
        mas1.Code__c ='AJ';
        masterList.add(mas1);
        
        Master__c mas2 = new Master__c();
        mas2.Name= 'Shikargah';
        mas2.Name__c ='Design Story';
        mas2.Active__c  = True ;
        mas2.Code__c ='SK';
        masterList.add(mas2);
        
        Master__c mas3 = new Master__c();
        mas3.Name= 'Handloom';
        mas3.Name__c ='Loom';
        mas3.Active__c  = True ;
        mas3.Code__c ='HL';
        masterList.add(mas3);
        
        Master__c mas4 = new Master__c();
        mas4.Name= 'Silk';
        mas4.Name__c ='Warp';
        mas4.Active__c  = True ;
        mas4.Code__c ='Sl';
        masterList.add(mas4);
        
        Master__c mas5 = new Master__c();
        mas5.Name= 'Silk';
        mas5.Name__c ='Weft';
        mas5.Active__c  = True ;
        mas5.Code__c ='SI';
        masterList.add(mas5);
        
        Master__c mas6 = new Master__c();
        mas6.Name= 'Handmade product of India';
        mas6.Name__c ='Nature';
        mas6.Active__c  = True ;
        mas6.Code__c ='HP';
        masterList.add(mas6);
        
        Master__c mas7 = new Master__c();
        mas7.Name= 'Wedding';
        mas7.Name__c ='Occasion';
        mas7.Active__c  = True ;
        mas7.Code__c ='W';
        masterList.add(mas7);
        
        Master__c mas8 = new Master__c();
        mas8.Name= 'Assam';
        mas8.Name__c ='Origin';
        mas8.Active__c  = True ;
        mas8.Code__c ='AS';
        masterList.add(mas8);
        
        Master__c mas9 = new Master__c();
        mas9.Name= 'Saree';
        mas9.Name__c ='Product Category';
        mas9.Active__c  = True ;
        mas9.Code__c ='S';
        masterList.add(mas9);
        
        Master__c mas10 = new Master__c();
        mas10.Name= 'Colourway';
        mas10.Name__c ='Route';
        mas10.Active__c = True ;
        mas10.Code__c ='CW';
        masterList.add(mas10);
        
        Master__c mas11 = new Master__c();
        mas11.Name= 'Silk';
        mas11.Name__c ='Zari Type';
        mas11.Active__c = True ;
        mas11.Code__c ='ZT';
        masterList.add(mas11);
        
        Master__c mas12 = new Master__c();
        mas12.Name= 'Trading';
        mas12.Name__c ='Proc-Type';
        mas12.Active__c = True ;
        mas12.Code__c ='PT';
        masterList.add(mas12);
        
        Master__c mas13 = new Master__c();
        mas13.Name= 'Vendor Co Created';
        mas13.Name__c ='Proc-Type';
        mas13.Active__c = True ;
        mas13.Code__c ='PT';
        masterList.add(mas13);
        
        /*  Master__c mas13 = new Master__c();
mas13.Name= 'Product Category';
mas13.Name__c ='USKD';
mas13.Active__c = True ;
mas13.Code__c ='U';
masterList.add(mas13);*/
        
        Master__c mas14 = new Master__c();
        mas14.Name= 'Silk';
        mas14.Name__c ='Salwar_Fabric';
        mas14.Active__c = True ;
        mas14.Code__c ='';
        masterList.add(mas14);
        
        Master__c mas15 = new Master__c();
        mas15.Name= 'Silk';
        mas15.Name__c ='Dupatta_Fabric';
        mas15.Active__c = True ;
        mas15.Code__c ='';
        masterList.add(mas15);
        
        Master__c mas16 = new Master__c();
        mas16.Name= 'Silk';
        mas16.Name__c ='Kurta_Fabric';
        mas16.Active__c = True ;
        mas16.Code__c ='';
        masterList.add(mas16);
        
        if(masterList.size()>0){
            insert masterList;
        }
        /*   List<UpdateVendorPricingField__c> pricingType = new List<UpdateVendorPricingField__c>();
UpdateVendorPricingField__c uVend1= new UpdateVendorPricingField__c();
uVend1.Name='1';
uVend1.Vendor_Type__c='AGGREGATOR';
uVend1.Pricing_Type_Code__c='C';
pricingType.add(uVend1);
UpdateVendorPricingField__c uVend2= new UpdateVendorPricingField__c();
uVend2.Name='2';
uVend2.Vendor_Type__c='MASTER WEAVER';
uVend2.Pricing_Type_Code__c='B';
pricingType.add(uVend2);
UpdateVendorPricingField__c uVend3= new UpdateVendorPricingField__c();
uVend3.Name='3';
uVend3.Vendor_Type__c='DESIGNER';
uVend3.Pricing_Type_Code__c='D';
pricingType.add(uVend3); 

insert pricingType; */
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        
        Product__c pro = new Product__c();
        pro.Name = 'Brown Saree';
        pro.vendor_custom__c = acc1.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Handloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Special_request__c=true;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Sync_Date__c=System.today();
        pro.Kurta_Fabric__c = 'Silk';
        pro.Dupatta_Fabric__c = 'silk';
        pro.Salwar_Fabric__c = 'silk';
        pro.QR_CODE__c = '123';
        pro.Vendor__c='AGGREGATOR';
        
        //insert pro;
        prodList.add(pro);
        
        
        
        Product__c prd = new Product__c();
        
        prd.Name = 'ApprovalRequestTest1';
        prd.Product_Category_Taneira__c = 'Saree';
        prd.Cluster__c = 'TEST1';
        prd.Taneira_Material_Weft__c = 'TEST1';
        prd.Material_Wrap__c = 'TEST1';
        prd.Workmanship__c = 'EX';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 3;
        prd.Cost__c = 11;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
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
        prd.Occasion_Update__c = 'TEST1';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Occasion__c = 'TEST1';
        prd.Zari_Type__c = 'TEST1';
        prd.Vendor__c='AGGREGATOR';
        prodList.add(prd);
        // insert prd ;
        
        
        Product__c prd1 = new Product__c();
        
        prd1.Name = 'ApprovalRequestTest1';
        prd1.Product_Category_Taneira__c = 'Saree';
        prd1.Cluster__c = 'TEST1';
        prd1.Taneira_Material_Weft__c = 'TEST';
        prd1.Material_Wrap__c = 'TEST';
        prd1.Workmanship__c = 'IK';
        prd1.Cost_Band__c = 'A(0-2)';            
        prd1.Quantity__c = 3;
        prd1.Cost__c = 6;
        prd1.Border_Pattern__c='Contrast Border';
        prd1.Body_Pattern__c='Medium Buta';
        prd1.Loom__c = 'Handloom';
        prd1.PO_Number__c='324324';
        prd1.Proc_Type__c = 'Value Added';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.vendor_custom__c = acc.Id;
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
        prd1.Zari_Type__c = 'TEST1';
        prodList.add(prd1);
        // insert prd1 ;
        
        
        Product__c prd2 = new Product__c();
        
        prd2.Name = 'ApprovalRequestTest1';
        prd2.Product_Category_Taneira__c = 'Saree';
        prd2.Cluster__c = 'TEST1';                      //ABCNULLABCIKKATDEFAULTCC 
        // prd2.Fabric__c = 'SILK';
        prd2.Taneira_Material_Weft__c = 'ABC';
        prd2.Material_Wrap__c = 'ABC';
        prd2.Workmanship__c = 'TEST1';
        prd2.Cost_Band__c = 'A(0-2)';
        prd2.Quantity__c = 3;
        prd2.Cost__c = 12;
        prd2.Border_Pattern__c='Contrast Border';
        prd2.Body_Pattern__c='Medium Buta';
        prd2.Loom__c = 'Handloom';
        prd2.PO_Number__c='324324';
        prd2.Proc_Type__c = 'Value Added';
        prd2.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd2.vendor_custom__c = acc.Id;
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
        
        prodList.add(prd2);
        //insert prd2 ;
        
        Product__c prd3 = new Product__c();
        
        prd3.Name = 'ApprovalRequestTest1';
        prd3.Product_Category_Taneira__c = 'USKD';
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
        prd3.vendor_custom__c = acc.Id;
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
        prd3.Salwar_Fabric__c='SILK';
        prd3.Kurta_Fabric__c='COTTON';
        prodList.add(prd3);
        //        insert prd3 ;
        
        Product__c prd4 = new Product__c();
        
        prd4.Name = 'ApprovalRequestTest1';
        prd4.Product_Category_Taneira__c = 'SSKD';
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
        prd4.vendor_custom__c = acc.Id;
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
        prodList.add(prd4);
        // insert prd4 ;
        
        
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
        prd5.vendor_custom__c = acc.Id;
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
        prodList.add(prd5);
        // insert prd5 ;
        
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
        prd6.vendor_custom__c = acc.Id;
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
        prd6.Occasion__c = 'ABC';
        prd6.Zari_Type__c = 'ryhdt';
        
        prodList.add(prd6);
        // insert prd6 ;
        
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
        prd7.vendor_custom__c = acc.Id;
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
        prodList.add(prd7);
        //insert prd7 ;
        
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
        prd8.vendor_custom__c = acc.Id;
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
        prodList.add(prd8);
        // insert prd8 ;
        
        
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
        prd9.vendor_custom__c = acc.Id;
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
        prodList.add(prd9);
        // insert prd9 ;
        
        Product__c prd10 = new Product__c();
        
        prd10.Name = 'ApprovalRequestTest1';
        prd10.Product_Category_Taneira__c = 'Saree';
        prd10.Cluster__c = 'ABCDF';                      //ABCDFNULLDEFAULTIKKATRTDEFAULTYY     
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
        prd10.vendor_custom__c = acc.Id;
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
        
        prodList.add(prd10);
        //insert prd10 ;
        
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
        prd11.vendor_custom__c = acc.Id;
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
        prodList.add(prd11);
        //insert prd11 ;
        
        Product__c prd12 = new Product__c();
        
        prd12.Name = 'ApprovalRequestTest1';
        prd12.Proc_Type__c='Vendor Co Created';
        prd12.Product_Category_Taneira__c = 'Saree';
        prd12.Cluster__c = 'XYZWA';
        prd12.Taneira_Material_Weft__c = 'SI';
        prd12.Material_Wrap__c = 'SI';
        prd12.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd12.Cost_Band__c = 'A(0-2)';
        prd12.Quantity__c = 3;
        prd12.Cost__c = 1254;
        prd12.Border_Pattern__c='Contrast Border';
        prd12.Body_Pattern__c='Medium Buta';
        prd12.Loom__c = 'Handloom';
        prd12.PO_Number__c='324324';
        prd12.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd12.vendor_custom__c = acc.Id;
        prd12.Pallu_Pattern__c='Contrast Pallu';
        prd12.Suggested_MRP__c=454;
        prd12.Comments__c='Testq432';
        prd12.Sync_Date__c=System.today();
        prd12.Created_From__c = 'Offline App';
        prd12.Collection_Update__c = 'test';
        prd12.Body_Pattern_Update__c = 'Solid';
        prd12.Body_Des_Element_Update__c = 'Temple';
        prd12.Body_Des_Material_Update__c = 'Only Zari';
        prd12.Body_Des_Density_Update__c = 'Dense';
        prd12.Border_Pattern_Update__c = 'Contrast Border';
        prd12.Border_Des_Material_Update__c = 'Only Zari';
        prd12.Border_Size_Update__c = 'No Border';
        prd12.Pallu_Pattern_Update__c = 'No Pallu';
        prd12.Pallu_Design_Update__c = 'Solid';
        prd12.Pallu_Des_Material_Update__c = 'Only Zari';
        prd12.Pallu_Des_Density_Update__c = 'Dense';
        prd12.Pallu_Size_Update__c = 'Small';
        prd12.Border_Des_Element_Update__c = 'Temple';
        prd12.Occasion_Update__c = 'Formal';
        prd12.Design_Story_Update__c = 'Korvai';
        prd12.Story_1_Update__c = 'Bengal';
        prd12.PO_Number__c = 'test';
        prd12.Occasion__c = 'e5rd';
        prd12.Zari_Type__c = 'wterter'; 
        prodList.add(prd12);
        
        Product__c prd13 = new Product__c();
        
        prd13.Name = 'ApprovalRequestTest1';
        prd13.Proc_Type__c='KVI';
        prd13.Product_Category_Taneira__c = 'Saree';
        prd13.Cluster__c = 'INDORE';
        prd13.Taneira_Material_Weft__c = 'SI';
        prd13.Material_Wrap__c = 'SI';
        prd13.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd13.Cost_Band__c = 'A(0-2)';
        prd13.Quantity__c = 3;
        prd13.Cost__c = 36;
        prd13.Border_Pattern__c='Contrast Border';
        prd13.Body_Pattern__c='Medium Buta';
        prd13.Loom__c = 'Handloom';
        prd13.PO_Number__c='324324';
        prd13.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd13.vendor_custom__c = acc.Id;
        prd13.Pallu_Pattern__c='Contrast Pallu';
        prd13.Suggested_MRP__c=454;
        prd13.Comments__c='Testq432';
        prd13.Sync_Date__c=System.today();
        prd13.Created_From__c = 'Offline App';
        prd13.Collection_Update__c = 'test';
        prd13.Body_Pattern_Update__c = 'Solid';
        prd13.Body_Des_Element_Update__c = 'Temple';
        prd13.Body_Des_Material_Update__c = 'Only Zari';
        prd13.Body_Des_Density_Update__c = 'Dense';
        prd13.Border_Pattern_Update__c = 'Contrast Border';
        prd13.Border_Des_Material_Update__c = 'Only Zari';
        prd13.Border_Size_Update__c = 'No Border';
        prd13.Pallu_Pattern_Update__c = 'No Pallu';
        prd13.Pallu_Design_Update__c = 'Solid';
        prd13.Pallu_Des_Material_Update__c = 'Only Zari';
        prd13.Pallu_Des_Density_Update__c = 'Dense';
        prd13.Pallu_Size_Update__c = 'Small';
        prd13.Border_Des_Element_Update__c = 'Temple';
        prd13.Occasion_Update__c = 'Formal';
        prd13.Design_Story_Update__c = 'Korvai';
        prd13.Story_1_Update__c = 'Bengal';
        prd13.PO_Number__c = 'test';
        prd13.Occasion__c = 'e5rd';
        prd13.Zari_Type__c = 'wterter'; 
        prodList.add(prd13);
        
        Product__c prd14 = new Product__c();
        
        prd14.Name = 'ApprovalRequestTest1';
        
        prd14.Product_Category_Taneira__c = 'Saree';
        prd14.Cluster__c = 'BHAGALPUR';
        prd14.Taneira_Material_Weft__c = 'SI';
        prd14.Material_Wrap__c = 'SI';
        prd14.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd14.Cost_Band__c = 'A(0-2)';
        prd14.Quantity__c = 3;
        prd14.Cost__c = 36;
        prd14.Border_Pattern__c='Contrast Border';
        prd14.Body_Pattern__c='Medium Buta';
        prd14.Loom__c = 'Handloom';
        prd14.PO_Number__c='324324';
        prd14.Proc_Type__c = 'Value Added';
        prd14.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd14.vendor_custom__c = acc.Id;
        prd14.Pallu_Pattern__c='Contrast Pallu';
        prd14.Suggested_MRP__c=454;
        prd14.Comments__c='Testq432';
        prd14.Sync_Date__c=System.today();
        prd14.Created_From__c = 'Offline App';
        prd14.Collection_Update__c = 'test';
        prd14.Body_Pattern_Update__c = 'Solid';
        prd14.Body_Des_Element_Update__c = 'Temple';
        prd14.Body_Des_Material_Update__c = 'Only Zari';
        prd14.Body_Des_Density_Update__c = 'Dense';
        prd14.Border_Pattern_Update__c = 'Contrast Border';
        prd14.Border_Des_Material_Update__c = 'Only Zari';
        prd14.Border_Size_Update__c = 'No Border';
        prd14.Pallu_Pattern_Update__c = 'No Pallu';
        prd14.Pallu_Design_Update__c = 'Solid';
        prd14.Pallu_Des_Material_Update__c = 'Only Zari';
        prd14.Pallu_Des_Density_Update__c = 'Dense';
        prd14.Pallu_Size_Update__c = 'Small';
        prd14.Border_Des_Element_Update__c = 'Temple';
        prd14.Occasion_Update__c = 'Formal';
        prd14.Design_Story_Update__c = 'Korvai';
        prd14.Story_1_Update__c = 'Bengal';
        prd14.PO_Number__c = 'test';
        prd14.Occasion__c = 'e5rd';
        prd14.Zari_Type__c = 'wterter'; 
        prd14.Vendor__c='AGGREGATOR';
        
        prodList.add(prd14);
        
        Product__c prd15 = new Product__c();
        
        prd15.Name = 'ApprovalRequestTest1';
        prd15.Product_Category_Taneira__c = 'Saree';
        prd15.Cluster__c = 'SOUTH';
        prd15.Weft__c='SILK';     
        prd15.Taneira_Material_Weft__c = 'SILK';
        prd15.Material_Wrap__c = 'SILK';
        prd15.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd15.Cost_Band__c = 'A(0-2)';
        prd15.Quantity__c = 3;
        prd15.Cost__c = 3600;
        prd15.Border_Pattern__c='Contrast Border';
        prd15.Body_Pattern__c='Medium Buta';
        prd15.Loom__c = 'Handloom';
        prd15.PO_Number__c='324324';
        prd15.Proc_Type__c = 'Value Added';
        prd15.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd15.vendor_custom__c = acc.Id;
        prd15.Pallu_Pattern__c='Contrast Pallu';
        prd15.Suggested_MRP__c=454;
        prd15.Comments__c='Testq432';
        prd15.Sync_Date__c=System.today();
        prd15.Created_From__c = 'Offline App';
        prd15.Collection_Update__c = 'test';
        prd15.Body_Pattern_Update__c = 'Solid';
        prd15.Body_Des_Element_Update__c = 'Temple';
        prd15.Body_Des_Material_Update__c = 'Only Zari';
        prd15.Body_Des_Density_Update__c = 'Dense';
        prd15.Border_Pattern_Update__c = 'Contrast Border';
        prd15.Border_Des_Material_Update__c = 'Only Zari';
        prd15.Border_Size_Update__c = 'No Border';
        prd15.Pallu_Pattern_Update__c = 'No Pallu';
        prd15.Pallu_Design_Update__c = 'Solid';
        prd15.Pallu_Des_Material_Update__c = 'Only Zari';
        prd15.Pallu_Des_Density_Update__c = 'Dense';
        prd15.Pallu_Size_Update__c = 'Small';
        prd15.Border_Des_Element_Update__c = 'Temple';
        prd15.Occasion_Update__c = 'Formal';
        prd15.Design_Story_Update__c = 'Korvai';
        prd15.Story_1_Update__c = 'Bengal';
        prd15.PO_Number__c = 'test';
        prd15.Occasion__c = 'e5rd';
        prd15.Zari_Type__c = 'wterter'; 
        prd15.Kurta_Fabric__c='SILK';
        prd15.Salwar_Fabric__c='SILK';
        prodList.add(prd15);
        
        Product__c prd16 = new Product__c();
        
        prd16.Name = 'ApprovalRequestTest1';
        
        prd16.Product_Category_Taneira__c = 'Saree';
        prd16.Cluster__c = 'BHAGALPUR';
        prd16.Taneira_Material_Weft__c = 'SI';
        prd16.Material_Wrap__c = 'SI';
        prd16.Workmanship__c = 'thrfrh';                      //XYZWNULLSIDEFAULTDEFAULTDEFAULT
        prd16.Cost_Band__c = 'A(0-2)';
        prd16.Quantity__c = 3;
        prd16.Cost__c = 3600;
        prd16.Border_Pattern__c='Contrast Border';
        prd16.Body_Pattern__c='Medium Buta';
        prd16.Loom__c = 'Handloom';
        prd16.PO_Number__c='324324';
        prd16.Proc_Type__c = 'Value Added';
        prd16.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd16.vendor_custom__c = acc.Id;
        prd16.Pallu_Pattern__c='Contrast Pallu';
        prd16.Suggested_MRP__c=454;
        prd16.Comments__c='Testq432';
        prd16.Sync_Date__c=System.today();
        prd16.Created_From__c = 'Offline App';
        prd16.Collection_Update__c = 'test';
        prd16.Body_Pattern_Update__c = 'Solid';
        prd16.Body_Des_Element_Update__c = 'Temple';
        prd16.Body_Des_Material_Update__c = 'Only Zari';
        prd16.Body_Des_Density_Update__c = 'Dense';
        prd16.Border_Pattern_Update__c = 'Contrast Border';
        prd16.Border_Des_Material_Update__c = 'Only Zari';
        prd16.Border_Size_Update__c = 'No Border';
        prd16.Pallu_Pattern_Update__c = 'No Pallu';
        prd16.Pallu_Design_Update__c = 'Solid';
        prd16.Pallu_Des_Material_Update__c = 'Only Zari';
        prd16.Pallu_Des_Density_Update__c = 'Dense';
        prd16.Pallu_Size_Update__c = 'Small';
        prd16.Border_Des_Element_Update__c = 'Temple';
        prd16.Occasion_Update__c = 'Formal';
        prd16.Design_Story_Update__c = 'Korvai';
        prd16.Story_1_Update__c = 'Bengal';
        prd16.PO_Number__c = 'test';
        prd16.Occasion__c = 'e5rd';
        prd16.Zari_Type__c = 'wterter'; 
        prodList.add(prd16);
        
        Product__c prd17 = new Product__c();
        
        prd17.Name = 'ApprovalRequestTest1';
        prd17.Product_Category_Taneira__c = 'Saree';
        prd17.Cluster__c = 'TEST1';
        prd17.Taneira_Material_Weft__c = 'TEST1';
        prd17.Material_Wrap__c = 'TEST1';
        prd17.Workmanship__c = 'EX';
        prd17.Cost_Band__c = 'A(0-2)';
        prd17.Quantity__c = 3;
        prd17.Cost__c = 100001;
        prd17.Border_Pattern__c='Contrast Border';
        prd17.Body_Pattern__c='Medium Buta';
        prd17.Loom__c = 'Handloom';
        prd17.PO_Number__c='324324';
        prd17.Proc_Type__c = 'Vendor Co Created';
        prd17.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd17.vendor_custom__c = acc.Id;
        prd17.Pallu_Pattern__c='Contrast Pallu';
        prd17.Suggested_MRP__c=100001;
        prd17.Comments__c='Testq432';
        prd17.Sync_Date__c=System.today();
        prd17.Created_From__c = 'Offline App';
        prd17.Collection_Update__c = 'test';
        prd17.Body_Pattern_Update__c = 'Solid';
        prd17.Body_Des_Element_Update__c = 'Temple';
        prd17.Body_Des_Material_Update__c = 'Only Zari';
        prd17.Body_Des_Density_Update__c = 'Dense';
        prd17.Border_Pattern_Update__c = 'Contrast Border';
        prd17.Border_Des_Material_Update__c = 'Only Zari';
        prd17.Border_Size_Update__c = 'No Border';
        prd17.Pallu_Pattern_Update__c = 'No Pallu';
        prd17.Pallu_Design_Update__c = 'Solid';
        prd17.Pallu_Des_Material_Update__c = 'Only Zari';
        prd17.Pallu_Des_Density_Update__c = 'Dense';
        prd17.Pallu_Size_Update__c = 'Small';
        prd17.Border_Des_Element_Update__c = 'Temple';
        prd17.Occasion_Update__c = 'Formal';
        prd17.Design_Story_Update__c = 'Korvai';
        prd17.Story_1_Update__c = 'Bengal';
        prd17.PO_Number__c = 'test';
        prd17.Occasion__c = 'TEST1';
        prd17.Zari_Type__c = 'TEST1';
        prodList.add(prd17);
        
        
        Product__c prd18 = new Product__c();
        
        prd18.Name = 'ApprovalRequestTest1';
        prd18.Product_Category_Taneira__c = 'Saree';
        prd18.Cluster__c = 'TEST1';
        prd18.Taneira_Material_Weft__c = 'TEST1';
        prd18.Material_Wrap__c = 'TEST1';
        prd18.Workmanship__c = 'EX';
        prd18.Cost_Band__c = 'A(0-2)';
        prd18.Quantity__c = 3;
        prd18.Cost__c = 6;
        prd18.Border_Pattern__c='Contrast Border';
        prd18.Body_Pattern__c='Medium Buta';
        prd18.Loom__c = 'Handloom';
        prd18.PO_Number__c='324324';
        prd18.Proc_Type__c = 'Vendor Co Created';
        prd18.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd18.vendor_custom__c = acc.Id;
        prd18.Pallu_Pattern__c='Contrast Pallu';
        prd18.Suggested_MRP__c=6;
        prd18.Comments__c='Testq432';
        prd18.Sync_Date__c=System.today();
        prd18.Created_From__c = 'Offline App';
        prd18.Collection_Update__c = 'test';
        prd18.Body_Pattern_Update__c = 'Solid';
        prd18.Body_Des_Element_Update__c = 'Temple';
        prd18.Body_Des_Material_Update__c = 'Only Zari';
        prd18.Body_Des_Density_Update__c = 'Dense';
        prd18.Border_Pattern_Update__c = 'Contrast Border';
        prd18.Border_Des_Material_Update__c = 'Only Zari';
        prd18.Border_Size_Update__c = 'No Border';
        prd18.Pallu_Pattern_Update__c = 'No Pallu';
        prd18.Pallu_Design_Update__c = 'Solid';
        prd18.Pallu_Des_Material_Update__c = 'Only Zari';
        prd18.Pallu_Des_Density_Update__c = 'Dense';
        prd18.Pallu_Size_Update__c = 'Small';
        prd18.Border_Des_Element_Update__c = 'Temple';
        prd18.Occasion_Update__c = 'Formal';
        prd18.Design_Story_Update__c = 'Korvai';
        prd18.Story_1_Update__c = 'Bengal';
        prd18.PO_Number__c = 'test';
        prd18.Occasion__c = 'TEST1';
        prd18.Zari_Type__c = 'TEST1';
        prodList.add(prd18);
        
        Product__c prd19 = new Product__c();
        
        prd19.Name = 'ApprovalRequestTest1';
        prd19.Product_Category_Taneira__c = 'USKD';
        prd19.Cluster__c = 'SOUTH';
        prd19.Taneira_Material_Weft__c = 'TEST1';
        prd19.Material_Wrap__c = 'TEST1';
        prd19.Workmanship__c = 'EX';
        prd19.Cost_Band__c = 'A(0-2)';
        prd19.Quantity__c = 3;
        prd19.Cost__c = 6;
        prd19.Border_Pattern__c='Contrast Border';
        prd19.Body_Pattern__c='Medium Buta';
        prd19.Loom__c = 'Handloom';
        prd19.PO_Number__c='324324';
        prd19.Proc_Type__c = 'Curated';
        prd19.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd19.vendor_custom__c = acc.Id;
        prd19.Pallu_Pattern__c='Contrast Pallu';
        prd19.Suggested_MRP__c=6;
        prd19.Comments__c='Testq432';
        prd19.Sync_Date__c=System.today();
        prd19.Created_From__c = 'Offline App';
        prd19.Collection_Update__c = 'test';
        prd19.Body_Pattern_Update__c = 'Solid';
        prd19.Body_Des_Element_Update__c = 'Temple';
        prd19.Body_Des_Material_Update__c = 'Only Zari';
        prd19.Body_Des_Density_Update__c = 'Dense';
        prd19.Border_Pattern_Update__c = 'Contrast Border';
        prd19.Border_Des_Material_Update__c = 'Only Zari';
        prd19.Border_Size_Update__c = 'No Border';
        prd19.Pallu_Pattern_Update__c = 'No Pallu';
        prd19.Pallu_Design_Update__c = 'Solid';
        prd19.Pallu_Des_Material_Update__c = 'Only Zari';
        prd19.Pallu_Des_Density_Update__c = 'Dense';
        prd19.Pallu_Size_Update__c = 'Small';
        prd19.Border_Des_Element_Update__c = 'Temple';
        prd19.Occasion_Update__c = 'Formal';
        prd19.Design_Story_Update__c = 'Korvai';
        prd19.Story_1_Update__c = 'Bengal';
        prd19.PO_Number__c = 'test';
        prd19.Occasion__c = 'TEST1';
        prd19.Zari_Type__c = 'TEST1';
        prd19.Kurta_Fabric__c='SILK';
        prd19.Salwar_Fabric__c='SILK';
        prodList.add(prd19);
        
        List<Exception__c > excpLst =new  List<Exception__c >();
        Exception__c exp1 = new Exception__c();
        exp1.isActive__c=true;
        exp1.Field_Name__c='Cluster__c';
        exp1.Exception_Field_Value__c='BHAGALPUR';
        exp1.Direct_MRP__c=4000;
        exp1.Min__c=0;
        exp1.Max__c=1900;
        excpLst.add(exp1);
        insert exp1; 
        
        Exception__c exp2 = new Exception__c();
        exp2.isActive__c=true;
        exp2.Field_Name__c='Cluster__c';
        exp2.Exception_Field_Value__c='SOUTH';
        exp2.Field_Name_2__c='Fabric__c';
        exp2.Exception_Field2_Value__c='SILK';
        exp2.Min__c=0;
        exp2.Max__c=2900;
        exp2.Direct_MRP__c=5000;
        excpLst.add(exp2);
        insert exp2;
        
        Exception__c exp9 = new Exception__c();
        exp9.isActive__c=true;
        exp9.Field_Name__c='Cluster__c';
        exp9.Exception_Field_Value__c='SOUTH';
        exp9.Field_Name_2__c='Fabric__c';
        exp9.Exception_Field2_Value__c='SILK';
        exp9.Direct_Multiplier__c=2;
        exp9.Min__c=0;
        exp9.Max__c=10000;
        excpLst.add(exp9);
        insert exp9; 
        
        Exception__c exp10 = new Exception__c();
        exp10.isActive__c=true;
        exp10.Field_Name__c='Cluster__c';
        exp10.Exception_Field_Value__c='SOUTH';
        exp9.Direct_Multiplier__c=2;
        exp10.Min__c=0;
        exp10.Max__c=1900;
        excpLst.add(exp10);
        insert exp10; 
        
        Exception__c exp3= new Exception__c();
        exp3.isActive__c=true;
        exp3.Field_Name__c='Proc_Type__c';
        exp3.Exception_Field_Value__c='Vendor Co Created';
        exp3.Exception_Multiplier__c=2;
        excpLst.add(exp3);
        insert exp3;
        
        Exception__c exp4 = new Exception__c();
        exp4.isActive__c=true;
        exp4.Field_Name__c='Proc_Type__c';
        exp4.Exception_Field_Value__c='KVI';
        exp4.Field_Name_2__c='Cluster__c';
        exp4.Exception_Field2_Value__c='INDORE';
        exp4.Exception_Multiplier__c=2.1;
        excpLst.add(exp4);
        insert exp4;
        
        
        Exception__c exp5 = new Exception__c();
        exp5.isActive__c=true;
        exp5.Field_Name__c='Suggested_MRP__c';
        exp5.Min__c=2000;
        exp5.Max__c=6000;
        exp5.SetNearestTo__c=250;
        excpLst.add(exp5);
        insert exp5;
        
        Exception__c exp6 = new Exception__c();
        exp6.isActive__c=true;
        exp6.Field_Name__c='Suggested_MRP__c';
        exp6.Min__c=100001;
        exp6.Max__c=100001;
        exp6.SetNearestTo__c=10000;
        excpLst.add(exp6);
        insert exp6;
        
        Exception__c exp7 = new Exception__c();
        exp7.isActive__c=true;
        exp7.Field_Name__c='Suggested_MRP__c';
        exp7.Min__c=0;
        exp7.Max__c=1000;
        exp7.Direct_MRP__c =999;
        excpLst.add(exp7);
        insert exp7;
        
        Exception__c exp8 = new Exception__c();
        exp8.isActive__c=true;
        exp8.Field_Name__c='Proc_Type__c';
        exp8.Exception_Field_Value__c = 'VALUE ADDED';
        exp8.Field_Name_2__c = 'Cluster__c';
        exp8.Exception_Field2_Value__c = 'TEST1';
        exp8.Min__c=0;
        exp8.Max__c=1000;
        exp8.Direct_MRP__c =999;
        excpLst.add(exp8);
        insert exp8;
        
        /*  

SetNearestValue__c set1 = new SetNearestValue__c();
set1.Name='1';
set1.Low__c=2000;
set1.High__c=6000;
set1.Divisor__c=250;
insert set1;

SetNearestValue__c set2 = new SetNearestValue__c();
set2.Name='2';
set2.Greater__c=100001;
set2.Divisor__c=10000;
insert set2;

SetNearestValue__c set3 = new SetNearestValue__c();
set3.Name='3';
set3.Min__c=0;
set3.Max__c=1000;
set3.Direct_MRP__c=999;
insert set3;
*/
        
        
        new NewTaneiraMultiplier().getSuggestedMRP(prodList);
        NewTaneiraMultiplier.getSuggestedMRPNearestValue( prodList , excpLst);
        NewTaneiraMultiplier.getMultiplierValue(prodList);
        NewTaneiraMultiplier.getSuggestedMRPNearestValue2( prodList , excpLst);
        //  insert prodList;
    }
    
}