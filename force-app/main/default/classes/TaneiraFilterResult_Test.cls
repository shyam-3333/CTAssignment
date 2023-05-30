@isTest
private class TaneiraFilterResult_Test {
    @testSetup 
    static void dataSetUp() {
        User productUser  =    TestForAskme.toCreateUser('Ask Me Taneira Vendor-Taneira Vendor','productTaneira@test.com');
        productUser.UserPermissionsSFContentUser=false;
        
        Insert productUser; 
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        Account acc = new Account();
        acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        insert acc;
        // String recordId= Id.valueOf('012c000000092C7');
        /*Upload__C upl = new Upload__C();
        upl.Cost_Band__c = 'A(0-2)';
        upl.Product__c = 'Saree';
        upl.Origin__c = 'BANARAS';
        upl.Fabric__c = 'SILK';
        upl.Quantity__c = 5;
        upl.Start_Date__c = system.today();
        upl.End_Date__c = system.today() + 28;
        upl.Craft__c = 'Ikkat';
        insert upl;*/
        list < Master__c > masterList = new List < Master__c > ();
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;

        Master__c mas = new Master__c();
        mas.Name = 'Red';
        mas.Name__c = 'Base Colour';
        mas.Active__c = True;
        mas.Code__c = 'R';
        masterList.add(mas);

        Master__c mas1 = new Master__c();
        mas1.Name = 'Ajrak';
        mas1.Name__c = 'Craft'; // workmanship
        mas1.Active__c = True;
        mas1.Code__c = 'AJ';
        masterList.add(mas1);

        Master__c mas2 = new Master__c();
        mas2.Name = 'Shikargah';
        mas2.Name__c = 'Design Story';
        mas2.Active__c = True;
        mas2.Code__c = 'SK';
        masterList.add(mas2);

        Master__c mas3 = new Master__c();
        mas3.Name = 'Handloom';
        mas3.Name__c = 'Loom';
        mas3.Active__c = True;
        mas3.Code__c = 'H';
        masterList.add(mas3);

        Master__c mas4 = new Master__c();
        mas4.Name = 'Silk';
        mas4.Name__c = 'Warp';
        mas4.Active__c = True;
        mas4.Code__c = 'Sl';
        masterList.add(mas4);

        Master__c mas5 = new Master__c();
        mas5.Name = 'Silk';
        mas5.Name__c = 'Weft';
        mas5.Active__c = True;
        mas5.Code__c = 'SI';
        masterList.add(mas5);

        Master__c mas6 = new Master__c();
        mas6.Name = 'Handmade product of India';
        mas6.Name__c = 'Nature';
        mas6.Active__c = True;
        mas6.Code__c = 'HP';
        masterList.add(mas6);

        Master__c mas7 = new Master__c();
        mas7.Name = 'Wedding';
        mas7.Name__c = 'Occasion';
        mas7.Active__c = True;
        mas7.Code__c = 'W';
        masterList.add(mas7);

        Master__c mas8 = new Master__c();
        mas8.Name = 'Assam';
        mas8.Name__c = 'Origin';
        mas8.Active__c = True;
        mas8.Code__c = 'AS';
        masterList.add(mas8);

        Master__c mas9 = new Master__c();
        mas9.Name = 'Saree';
        mas9.Name__c = 'Product Category';
        mas9.Active__c = True;
        mas9.Code__c = 'S';
        masterList.add(mas9);

        Master__c mas10 = new Master__c();
        mas10.Name = 'Colourway';
        mas10.Name__c = 'Route';
        mas10.Active__c = True;
        mas10.Code__c = 'CW';
        masterList.add(mas10);

        Master__c mas11 = new Master__c();
        mas11.Name = 'Silk';
        mas11.Name__c = 'Zari Type';
        mas11.Active__c = True;
        mas11.Code__c = 'ZT';
        masterList.add(mas11);

        Master__c mas12 = new Master__c();
        mas12.Name = 'Value Added';
        mas12.Name__c = 'Proc-Type';
        mas12.Active__c = True;
        mas12.Code__c = 'V';
        masterList.add(mas12);
        
        Master__c mas13 = new Master__c();
        mas13.Name = 'Contrast';
        mas13.Name__c = 'Border Pattern';
        mas13.Active__c = True;
        masterList.add(mas13);
        
        Master__c mas14 = new Master__c();
        mas14.Name = 'Contrast';
        mas14.Name__c = 'Pallu Pattern';
        mas14.Active__c = True;
        masterList.add(mas14);
        
        /*Master__c mas15 = new Master__c();
        mas15.Name = 'Dummy NA';
        mas15.Name__c = 'Detailed Colour';
        mas15.Active__c = True;
        masterList.add(mas15);*/
        
        Master__c mas17 = new Master__c();
        mas17.Name = 'Solid';
        mas17.Name__c = 'Body Pattern';
        mas17.Active__c = True;
        masterList.add(mas17);
        
        Master__c mas18 = new Master__c();
        mas18.Name = 'Exclusive';
        mas18.Name__c = 'Occasion';
        mas18.Active__c = True;
        masterList.add(mas18);
        
        
        Master__c mas20 = new Master__c();
        mas20.Name = '5.3m x 1.1m';
        mas20.Name__c = 'Saree Dimensions';
        mas20.Active__c = True;
        masterList.add(mas20);
        

        /*Master__c mas22 = new Master__c();
        mas22.Name = 'Dummy NA';
        mas22.Name__c = 'Silkmark';
        mas22.Active__c = True;
        masterList.add(mas22);*/

        Master__c mas24 = new Master__c();
        mas24.Name = 'Only Thread';
        mas24.Name__c = 'Body Des Material';
        mas24.Active__c = True;
        masterList.add(mas24);
        
        Master__c mas25 = new Master__c();
        mas25.Name = 'Floral';
        mas25.Name__c = 'Body Des Element';
        mas25.Active__c = True;
        masterList.add(mas25);
        
        Master__c mas26 = new Master__c();
        mas26.Name = 'Dense';
        mas26.Name__c = 'Body Des Density';
        mas26.Active__c = True;
        masterList.add(mas26);
        
        Master__c mas27 = new Master__c();
        mas27.Name = 'Only Zari';
        mas27.Name__c = 'Pallu Des Material';
        mas27.Active__c = True;
        masterList.add(mas27);
        
        Master__c mas28 = new Master__c();
        mas28.Name = 'Sparse';
        mas28.Name__c = 'Pallu Des Density';
        mas28.Active__c = True;
        masterList.add(mas28);
        
        Master__c mas29 = new Master__c();
        mas29.Name = 'pattern';
        mas29.Name__c = 'Pallu Size';
        mas29.Active__c = True;
        masterList.add(mas29);
        
        Master__c mas30 = new Master__c();
        mas30.Name = 'Geom';
        mas30.Name__c = 'Border Des Element';
        mas30.Active__c = True;
        masterList.add(mas30);
        
        Master__c mas31 = new Master__c();
        mas31.Name = 'Only Zari';
        mas31.Name__c = 'Border Des Material';
        mas31.Active__c = True;
        masterList.add(mas31);
        
        Master__c mas32 = new Master__c();
        mas32.Name = 'Small';
        mas32.Name__c = 'Border Size';
        mas32.Active__c = True;
        masterList.add(mas32);
        
        Master__c mas33 = new Master__c();
        mas33.Name = 'Small Buti- Floral';
        mas33.Name__c = 'Pallu Design';
        mas33.Active__c = True;
        masterList.add(mas33);

        if (masterList.size() > 0) {
            insert masterList;
        }

        AutoNumber__c autoNum = new AutoNumber__c();
        autoNum.Name = 'SHV'; //Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;

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
        prodList.add(prd);
        
        Product__c prd1 = new Product__c();
        prd1.Name = 'ApprovalRequestTest2';
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
        prd1.Border_Des_Material__c = 'Only Zari';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.Account__c = acc.Id;
        prd1.Sync_Date__c=System.today()-2;
        prodList.add(prd1);
        insert prodList;
        system.debug('prodList==='+prodList);
        
        Attachment attach = new Attachment();
        attach.Name = 'TestAttach.png'; 
        attach.body =  blob.valueOf('Test1');         
        attach.OwnerId = UserInfo.getUserId();
        attach.ParentId = prd1.id; 
        attach.IsPrivate = false;
        
        insert attach; 
        List<product__c> productList  =     TestForAskme.productRecord(5);
            
        Insert productList;
    }
    public static testmethod void taneiraFilterResultMethod(){
        test.startTest();
        Profile prf  =   [SELECT Id FROM Profile WHERE Name=:'Ask Me Taneira Vendor-Taneira Vendor' LIMIT 1];
        User productUser = [Select id from user where ProfileId =: prf.Id limit 1];
        System.runAs(productUser){                                                                
            test.stopTest();
            PageReference pageRef = Page.TaneiraFillterResult;
            apexpages.currentPage().getParameters().put('counter','1');
            apexpages.currentPage().getParameters().put('profileName','Ask Me Taneira Vendor-Taneira Vendor');
            apexpages.currentPage().getParameters().put('Vendors','All');
            apexpages.currentPage().getParameters().put('origin','All');
            apexpages.currentPage().getParameters().put('selectedCateg','All');
            apexpages.currentPage().getParameters().put('zari','All');
            apexpages.currentPage().getParameters().put('loom','All');
            apexpages.currentPage().getParameters().put('bodyPattern','All');
            apexpages.currentPage().getParameters().put('palluPattern','All');
            apexpages.currentPage().getParameters().put('detailcolor','All');
            apexpages.currentPage().getParameters().put('occasion','All');
            apexpages.currentPage().getParameters().put('sareedimension','All');
            //apexpages.currentPage().getParameters().put('silkmark','All');
            apexpages.currentPage().getParameters().put('bodydesmaterial','All');
            apexpages.currentPage().getParameters().put('blousetype','All');
            apexpages.currentPage().getParameters().put('blousesize','All');
            apexpages.currentPage().getParameters().put('bodydeselement','All');
            apexpages.currentPage().getParameters().put('bodydesdensity','All');
            apexpages.currentPage().getParameters().put('palludesmaterial','All');
            apexpages.currentPage().getParameters().put('palludesdensity','All');
            apexpages.currentPage().getParameters().put('pallusize','All');
            apexpages.currentPage().getParameters().put('borderpattern','All');
            apexpages.currentPage().getParameters().put('borderdeselement','All');
            apexpages.currentPage().getParameters().put('borderdesmaterial','All');
            apexpages.currentPage().getParameters().put('bordersize','All');
            apexpages.currentPage().getParameters().put('palludesign','All');
            ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('counter','1','1000',null,false)});
            apexpages.currentPage().getParameters().put('profileName','Ask Me Taneira Vendor-Taneira Vendor');
            TaneiraFillterResult taneiraFil = new TaneiraFillterResult();
            taneiraFil.filterKey = 'vendorKVPcategory';
           // taneiraFil.filterKey = '';
            taneiraFil.onLoadFunction();
           // taneiraFil.getautoFillDataList();
            taneiraFil.searchSKU();
            taneiraFil.refresh();
            taneiraFil.moveToBack();
            taneiraFil.searching();
            taneiraFil.logout();
            
            TaneiraFillterResult taneiraFil1 = new TaneiraFillterResult();
            taneiraFil1.filterKey = 'zariKVPsilk';
            taneiraFil1.searching();
            taneiraFil1.filterKey = 'zariKVPsilk';
            taneiraFil1.onLoadFunction();
            taneiraFil1.getautoFillDataList();
            taneiraFil1.searchSKU();
            taneiraFil1.refresh();
            taneiraFil1.moveToBack();
            taneiraFil1.searching();
            taneiraFil1.logout();
            
            TaneiraFillterResult taneiraFil2 = new TaneiraFillterResult();
            taneiraFil2.filterKey = 'bodyPatternKVPSolid';
            taneiraFil2.searching();
            taneiraFil2.filterKey = 'bodyPatternKVPSolid';
            taneiraFil2.searching();
            taneiraFil2.onLoadFunction();
            taneiraFil2.getautoFillDataList();
            taneiraFil2.searchSKU();
            taneiraFil2.refresh();
            taneiraFil2.moveToBack();
            taneiraFil2.logout();
            
            TaneiraFillterResult taneiraFil3 = new TaneiraFillterResult();
            taneiraFil3.filterKey = 'palluPatternKVPContrast';
            taneiraFil3.searching();
            taneiraFil3.filterKey = 'palluPatternKVPContrast';
            taneiraFil3.searching();
            taneiraFil3.onLoadFunction();
            taneiraFil3.getautoFillDataList();
            taneiraFil3.searchSKU();
            taneiraFil3.refresh();
            taneiraFil3.moveToBack();            
            taneiraFil3.logout();
            
            /*TaneiraFillterResult taneiraFil4 = new TaneiraFillterResult();
            taneiraFil4.filterKey = 'detailedcolorKVPDummy NA';
            taneiraFil4.searching();
            taneiraFil4.filterKey = 'detailedcolorKVPDummy NA';
            taneiraFil4.searching();
            taneiraFil4.onLoadFunction();
            taneiraFil4.getautoFillDataList();
            taneiraFil4.searchSKU();
            taneiraFil4.refresh();
            taneiraFil4.moveToBack();
           
            taneiraFil4.logout();*/
            
            TaneiraFillterResult taneiraFil5 = new TaneiraFillterResult();
            taneiraFil5.filterKey = 'occasionKVPExclusive';
            taneiraFil5.searching();
            taneiraFil5.filterKey = 'occasionKVPExclusive';
            taneiraFil5.searching();
            taneiraFil5.onLoadFunction();
            taneiraFil5.getautoFillDataList();
            taneiraFil5.searchSKU();
            taneiraFil5.refresh();
            taneiraFil5.moveToBack();            
            taneiraFil5.logout();
            
            /*TaneiraFillterResult taneiraFil6 = new TaneiraFillterResult();
            taneiraFil6.filterKey = 'collectionKVPDummy NA';
            taneiraFil6.searching();
            taneiraFil6.filterKey = 'collectionKVPDummy NA';
            taneiraFil6.searching();
            taneiraFil6.onLoadFunction();
            taneiraFil6.getautoFillDataList();
            taneiraFil6.searchSKU();
            taneiraFil6.refresh();
            taneiraFil6.moveToBack();            
            taneiraFil6.logout();*/
            
            TaneiraFillterResult taneiraFil7 = new TaneiraFillterResult();
            taneiraFil7.filterKey = 'sareedimensionKVP5.3m x 1.1m';
            taneiraFil7.searching();
            taneiraFil7.filterKey = 'sareedimensionKVP5.3m x 1.1m';
            taneiraFil7.searching();
            taneiraFil7.onLoadFunction();
            taneiraFil7.getautoFillDataList();
            taneiraFil7.searchSKU();
            taneiraFil7.refresh();
            taneiraFil7.moveToBack();            
            taneiraFil7.logout();
            
            /*TaneiraFillterResult taneiraFil8 = new TaneiraFillterResult();
            taneiraFil8.filterKey = 'silkmarkKVPDummy NA';
            taneiraFil8.searching();
            taneiraFil8.filterKey = 'silkmarkKVPDummy NA';
            taneiraFil8.searching();
            taneiraFil8.onLoadFunction();
            taneiraFil8.getautoFillDataList();
            taneiraFil8.searchSKU();
            taneiraFil8.refresh();
            taneiraFil8.moveToBack();            
            taneiraFil8.logout();*/
            
            TaneiraFillterResult taneiraFil9 = new TaneiraFillterResult();
            taneiraFil9.filterKey = 'blousetypeKVPYes';
            taneiraFil9.searching();
            taneiraFil9.filterKey = 'blousetypeKVPYes';
            taneiraFil9.searching();
            taneiraFil9.onLoadFunction();
            taneiraFil9.getautoFillDataList();
            taneiraFil9.searchSKU();
            taneiraFil9.refresh();
            taneiraFil9.moveToBack();            
            taneiraFil9.logout();
            
            TaneiraFillterResult taneiraFil10 = new TaneiraFillterResult();
            taneiraFil10.filterKey = 'bodydesmaterialKVPOnly Thread';
            taneiraFil10.searching();
            taneiraFil10.filterKey = 'bodydesmaterialKVPOnly Thread';
            taneiraFil10.searching();
            taneiraFil10.onLoadFunction();
            taneiraFil10.getautoFillDataList();
            taneiraFil10.searchSKU();
            taneiraFil10.refresh();
            taneiraFil10.moveToBack();            
            taneiraFil10.logout();
            
            TaneiraFillterResult taneiraFil11 = new TaneiraFillterResult();
            taneiraFil11.filterKey = 'bodydeselementKVPFloral';
            taneiraFil11.searching();
            taneiraFil11.filterKey = 'bodydeselementKVPFloral';
            taneiraFil11.searching();
            taneiraFil11.onLoadFunction();
            taneiraFil11.getautoFillDataList();
            taneiraFil11.searchSKU();
            taneiraFil11.refresh();
            taneiraFil11.moveToBack();            
            taneiraFil11.logout();
            
            TaneiraFillterResult taneiraFil12 = new TaneiraFillterResult();
            taneiraFil12.filterKey = 'bodydesdensityKVPDense';
            taneiraFil12.searching();
            taneiraFil12.filterKey = 'bodydesdensityKVPDense';
            taneiraFil12.searching();
            taneiraFil12.onLoadFunction();
            taneiraFil12.getautoFillDataList();
            taneiraFil12.searchSKU();
            taneiraFil12.refresh();
            taneiraFil12.moveToBack();            
            taneiraFil12.logout();
            
            
        }
    }
    public static testmethod void taneiraFilterResultMethod1(){
        test.startTest();
        Profile prf  =   [SELECT Id FROM Profile WHERE Name=:'Ask Me Taneira Vendor-Taneira Vendor' LIMIT 1];
        User productUser = [Select id from user where ProfileId =: prf.Id limit 1];
        
        System.runAs(productUser){                                                              
            test.stopTest();
            PageReference pageRef = Page.TaneiraFillterResult;
            apexpages.currentPage().getParameters().put('counter','1');
            apexpages.currentPage().getParameters().put('profileName','Ask Me Taneira Vendor-Taneira Vendor');
            apexpages.currentPage().getParameters().put('Vendors','TestAccAskme');
            apexpages.currentPage().getParameters().put('origin','Assam');
            apexpages.currentPage().getParameters().put('selectedCateg','Saree');
            apexpages.currentPage().getParameters().put('zari','Silk');
            apexpages.currentPage().getParameters().put('loom','Handloom');
            apexpages.currentPage().getParameters().put('bodyPattern','Solid');
            apexpages.currentPage().getParameters().put('palluPattern','Contrast');
            //apexpages.currentPage().getParameters().put('detailcolor','Dummy NA');
            apexpages.currentPage().getParameters().put('occasion','Exclusive');
            apexpages.currentPage().getParameters().put('sareedimension','5.3m x 1.1m');
            //apexpages.currentPage().getParameters().put('silkmark','Dummy NA');
            apexpages.currentPage().getParameters().put('bodydesmaterial','Only Thread');
            apexpages.currentPage().getParameters().put('blousetype','Yes');
            apexpages.currentPage().getParameters().put('blousesize','40');
            apexpages.currentPage().getParameters().put('bodydeselement','Floral');
            apexpages.currentPage().getParameters().put('bodydesdensity','Dense');
            apexpages.currentPage().getParameters().put('palludesmaterial','Only Zari');
            apexpages.currentPage().getParameters().put('palludesdensity','Sparse');
            apexpages.currentPage().getParameters().put('pallusize','pattern');
            apexpages.currentPage().getParameters().put('borderpattern','Contrast');
            apexpages.currentPage().getParameters().put('borderdeselement','Geom');
            apexpages.currentPage().getParameters().put('borderdesmaterial','Only Zari');
            apexpages.currentPage().getParameters().put('bordersize','Small');
            apexpages.currentPage().getParameters().put('palludesign','Small Buti- Floral');
            ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('counter','1','1000',null,false)});
            apexpages.currentPage().getParameters().put('profileName','Ask Me Taneira Vendor-Taneira Vendor');
            TaneiraFillterResult taneiraFil = new TaneiraFillterResult();            
            taneiraFil.onLoadFunction();
            taneiraFil.getautoFillDataList();
            taneiraFil.searchSKU();
            taneiraFil.refresh();
            taneiraFil.filterKey = 'categoryKVPsaree';
            taneiraFil.searching();
            taneiraFil.filterKey = 'categoryKVPsaree';
            taneiraFil.searching();
            taneiraFil.moveToBack();            
            taneiraFil.logout();
            
            
            
            TaneiraFillterResult taneiraFil1 = new TaneiraFillterResult();
            taneiraFil1.filterKey = 'warpKVPsilk';
            taneiraFil1.searching();
            taneiraFil1.filterKey = 'warpKVPsilk';
            taneiraFil1.onLoadFunction();
            taneiraFil1.getautoFillDataList();
            taneiraFil1.searchSKU();
            taneiraFil1.refresh();
            taneiraFil1.moveToBack();
            taneiraFil1.searching();
            taneiraFil1.logout();
            
            TaneiraFillterResult taneiraFil2 = new TaneiraFillterResult();
            taneiraFil2.filterKey = 'weftKVPsilk';
            taneiraFil2.searching();
            taneiraFil2.filterKey = 'weftKVPsilk';
            taneiraFil2.searching();
            taneiraFil2.onLoadFunction();
            taneiraFil2.getautoFillDataList();
            taneiraFil2.searchSKU();
            taneiraFil2.refresh();
            taneiraFil2.moveToBack();
            
            taneiraFil2.logout();
            
            TaneiraFillterResult taneiraFil3 = new TaneiraFillterResult();
            taneiraFil3.filterKey = 'colorKVPred';
            taneiraFil3.searching();
            taneiraFil3.filterKey = 'colorKVPred';
            taneiraFil3.searching();
            taneiraFil3.onLoadFunction();
            taneiraFil3.getautoFillDataList();
            taneiraFil3.searchSKU();
            taneiraFil3.refresh();
            taneiraFil3.moveToBack();            
            taneiraFil3.logout();
            
            TaneiraFillterResult taneiraFil4 = new TaneiraFillterResult();
            taneiraFil4.filterKey = 'originKVPassam';
            taneiraFil4.searching();
            taneiraFil4.filterKey = 'originKVPassam';
            taneiraFil4.searching();
            taneiraFil4.onLoadFunction();
            taneiraFil4.getautoFillDataList();
            taneiraFil4.searchSKU();
            taneiraFil4.refresh();
            taneiraFil4.moveToBack();
           
            taneiraFil4.logout();
            
            TaneiraFillterResult taneiraFil5 = new TaneiraFillterResult();
            taneiraFil5.filterKey = 'craftKVPajrak';
            taneiraFil5.searching();
            taneiraFil5.filterKey = 'craftKVPajrak';
            taneiraFil5.searching();
            taneiraFil5.onLoadFunction();
          //  taneiraFil5.getautoFillDataList();
            taneiraFil5.searchSKU();
            taneiraFil5.refresh();
            taneiraFil5.moveToBack();            
            taneiraFil5.logout();
            
            TaneiraFillterResult taneiraFil8 = new TaneiraFillterResult();
            taneiraFil8.filterKey = 'suggestedMRPKVP0-500';
            taneiraFil8.searching();
            taneiraFil8.filterKey = 'suggestedMRPKVP0-500';
            taneiraFil8.searching();
            taneiraFil8.onLoadFunction();
           // taneiraFil8.getautoFillDataList();
            taneiraFil8.searchSKU();
            taneiraFil8.refresh();
            taneiraFil8.moveToBack();
            
            taneiraFil8.logout();
             TaneiraFillterResult tFil2 = new TaneiraFillterResult();
            tFil2 .filterKey = 'loomKVPhandloom';
            tFil2 .searching();
            tFil2 .filterKey = 'loomKVPhandloom';
            tFil2 .searching();
            tFil2 .onLoadFunction();
            tFil2 .getautoFillDataList();
            tFil2 .searchSKU();
            tFil2 .refresh();
            tFil2 .moveToBack();
            tFil2.logout();
            
            TaneiraFillterResult taneiraFil13 = new TaneiraFillterResult();
            taneiraFil13.filterKey = 'palludesmaterialKVPOnly Zari';
            taneiraFil13.searching();
            taneiraFil13.filterKey = 'palludesmaterialKVPOnly Zari';
            taneiraFil13.searching();
            taneiraFil13.onLoadFunction();
            taneiraFil13.getautoFillDataList();
            taneiraFil13.searchSKU();
            taneiraFil13.refresh();
            taneiraFil13.moveToBack();            
            taneiraFil13.logout();
            
            TaneiraFillterResult taneiraFil14 = new TaneiraFillterResult();
            taneiraFil14.filterKey = 'borderdesmaterialKVPOnly Zari';
            taneiraFil14.searching();
            taneiraFil14.filterKey = 'borderdesmaterialKVPOnly Zari';
            taneiraFil14.searching();
            taneiraFil14.onLoadFunction();
            taneiraFil14.getautoFillDataList();
            taneiraFil14.searchSKU();
            taneiraFil14.refresh();
            taneiraFil14.moveToBack();            
            taneiraFil14.logout();
            
            TaneiraFillterResult taneiraFi20 = new TaneiraFillterResult();
            taneiraFi20.filterKey = 'blousesizeKVP40';
            taneiraFi20.searching();
            taneiraFi20.filterKey = 'blousesizeKVP40';
            taneiraFi20.searching();
            taneiraFi20.onLoadFunction();
            taneiraFi20.getautoFillDataList();
            taneiraFi20.searchSKU();
            taneiraFi20.refresh();
            taneiraFi20.moveToBack();            
            taneiraFi20.logout();
            
           
        }
    }    
}