@isTest
public class RTW_Product_Handler_Test {
    @TestSetup
    public static void testData(){
        List<RTWProduct__c> rtwProdList = new List<RTWProduct__c>(); 
       // List<Attachment> attchList = new List<Attachment>();
        rtwProdList.add(new RTWProduct__c(Name = 'DUPPATTA'));
        rtwProdList.add(new RTWProduct__c(Name = 'BLOUSE'));
        rtwProdList.add(new RTWProduct__c(Name = 'LEHENGA'));
        rtwProdList.add(new RTWProduct__c(Name = 'TROUSER'));
        rtwProdList.add(new RTWProduct__c(Name = 'MASK'));
        rtwProdList.add(new RTWProduct__c(Name = 'KURTA'));
        rtwProdList.add(new RTWProduct__c(Name = 'DRESS'));
        
        Insert rtwProdList;
        //id rec = [SELECT Id, SobjectType, Name FROM RecordType where name = 'Vendor'].id;
        vendor__c acc = new vendor__c(Name='TestAccount',Phone_No__c = '87941312132',Mail_ID__c = 'deepak@gmail.com');
        insert acc;
        
        List<Master__c> masterList = new List<Master__c>();
        masterList.add(new Master__c(Code__c='L',Name__c ='ProductType',Name = 'LEHENGA',Active__c=true));
        masterList.add(new Master__c(Code__c='B',Name__c ='ProductType',Name = 'BLOUSE',Active__c=true));
        masterList.add(new Master__c(Code__c='FW19',Name__c ='Season',Name = 'FW19',Active__c=true));
        masterList.add(new Master__c(Code__c='CW',Name__c ='Collection',Name = 'Corewear',Active__c=true));
        masterList.add(new Master__c(Code__c='C',Name__c ='Fabric',Name = 'Cotton123',Active__c=true));
         masterList.add(new Master__c(Code__c='H',Name__c ='ProductType',Name = 'MASK',Active__c=true));
        masterList.add(new Master__c(Code__c='G',Name__c ='Gender',Name = 'Male',Active__c=true));
        masterList.add(new Master__c(Code__c='2',Name__c ='Ply',Name = '2Ply',Active__c=true));
        masterList.add(new Master__c(Code__c='A',Name__c ='Style Name',Name = 'XXXX',Active__c=true));
        masterList.add(new Master__c(Code__c='KU',Name__c ='ProductType',Name = 'KURTA',Active__c=true));
        masterList.add(new Master__c(Code__c='DR',Name__c ='ProductType',Name = 'DRESS',Active__c=true));
        masterList.add(new Master__c(Code__c='TR',Name__c ='ProductType',Name = 'TROUSER',Active__c=true));

        system.debug('masterList---'+masterList[0]);
        Insert masterList;
        
        AutoNumber__c autonum = new AutoNumber__c(Name='1',Auto_Number__c=1);
        insert autonum;
        
        RTWAutoNumber__c rtwNum = new RTWAutoNumber__c(Name='Test',Combination_Code__c='LFW19CWC', Collection__c='Core wear', Fabrics__c='Cotton', ProductType__c='Blouse', Running_Number__c=10,Season__c='FW19');
        RTWAutoNumber__c rtwNum2 = new RTWAutoNumber__c(Name='Test3',Combination_Code__c='HG2A', ProductType__c='MASK', Running_Number__c=71,Gender__c='Male',Ply__c='2Ply',Style_Code__c='XXXX');
        RTWAutoNumber__c rtwNum1 = new RTWAutoNumber__c(Name='Test1',Combination_Code__c='BFW19CWC', Collection__c='Core wear', Fabrics__c='Cotton', ProductType__c='Blouse', Running_Number__c=10,Season__c='FW19');
        
        List<RTW_Ecom_Size__c> ecomsizelist = new List<RTW_Ecom_Size__c>();
        RTW_Ecom_Size__c ecomsize1 = new RTW_Ecom_Size__c(Name='1',Product__c='BLOUSE', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize1);
        RTW_Ecom_Size__c ecomsize2 = new RTW_Ecom_Size__c(Name='2',Product__c='KURTA SET', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize2);
        RTW_Ecom_Size__c ecomsize3 = new RTW_Ecom_Size__c(Name='3',Product__c='KURTA', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize3);
        RTW_Ecom_Size__c ecomsize4 = new RTW_Ecom_Size__c(Name='4',Product__c='TUNIC', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize4);
        RTW_Ecom_Size__c ecomsize5 = new RTW_Ecom_Size__c(Name='5',Product__c='TROUSER', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize5);
        RTW_Ecom_Size__c ecomsize6 = new RTW_Ecom_Size__c(Name='6',Product__c='SLIP', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize6);

        
        insert ecomsizelist;
        
        Insert rtwNum;
        Insert rtwNum1;
        Insert rtwNum2;
        SKU_Month_Code__c sku = new SKU_Month_Code__c(Name='1', Code__c = 'A');
        insert sku;
        List<RTW_Product__c> rtwProdLists = new List<RTW_Product__c>();
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', vendor_custom__c = acc.Id,season__c='FW19',Base_Colour__c='Red',collection__c='Core wear', Warp__c='Cotton123',Weft__c='Cotton123',MFabric__c = 'Cotton',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020));
        rtwProdLists.add(new RTW_Product__c(Name='LEHENGA',Product__c='LEHENGA',SKU_Count__c=1, vendor_custom__c = acc.Id, season__c='FW19',collection__c='Core wear', Warp__c='Cotton123',Weft__c='Cotton123',Base_Colour__c='Red',Size_LCD__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='LEHENGA',Base_Colour__c = 'BaseCol1',SKU_Count__c=1, vendor_custom__c = acc.Id,Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=20,Product__c='LEHENGA',Quantity__c=8,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Blouse_Type__c='Type 1',BlouseSize_LCD__c='BSL1',Dimensions__c='D1',DupattaDimensions__c='DD1',DupattaFabric__c='DF1',Dupatta_Type__c='DT1',Gender__c='Male',Occasion__c='O1',Origin__c='Banaras',ReadyGHERA_MT__c='R1',ReadyHip_Inch__c='RH1',ReadyWaist_Inch__c='R1',Silhouette__c='S1',Size_LCD__c='32',SkirtPanels__c='SP1',Source__c='S1',Year_of_Design__c=2020));
        rtwProdLists.add(new RTW_Product__c(Name='DUPPATTA',Product__c = 'DUPPATTA'));
        rtwProdLists.add(new RTW_Product__c(Name='MASK',Base_Colour__c='Black', vendor_custom__c = acc.Id,Product__c='MASK',Quantity__c=2,Gender__c='Male',MStyle_name__c='xxxx',MPly__c='2ply',MCost__c = 1000,MPleats__c ='Yes',MDesign__c = 'Block Print',MFabric__c = 'Cotton'));
        rtwProdLists.add(new RTW_Product__c(Name='MASK',Base_Colour__c='BaseCol3', vendor_custom__c = acc.Id,Product__c='MASK',Quantity__c=2,Gender__c='Male',MStyle_name__c='xxxx',MPly__c='2ply',MPleats__c ='Yes',MDesign__c = 'Block Print',MFabric__c = 'Cotton'));
        rtwProdLists.add(new RTW_Product__c(Name='MASK',Base_Colour__c='BaseCol3', vendor_custom__c = acc.Id,Product__c='MASK',Quantity__c=2,Gender__c='Male',MStyle_name__c='xxxx',MPly__c='2ply',MPleats__c ='Yes',MDesign__c = 'Block Print',MFabric__c = 'Cotton'));
        rtwProdLists.add(new RTW_Product__c(Name='TROUSER',Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Product__c='TROUSER',Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='32',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020));
        rtwProdLists.add(new RTW_Product__c(Name='KURTA',Product__c='KURTA', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020));
        rtwProdLists.add(new RTW_Product__c(Name='DRESS',Product__c='DRESS', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020));
        
        insert rtwProdLists;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Category'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'     
        );
        insert u;
        
                
        
    }
    @isTest
    public static void TestRTW_Product_HandlerBlouseMethod1()
    {
       /* 
        for(Master__c m : [SELECT Id, Active__c, Code__c, Name__c, Name FROM Master__c]){
            MasterCode.put((m.Name__c+m.Name).toLowercase().remove(' '),m.Code__c);
        }
        */
        Master__c mast = new Master__c();
        mast.Name = 'Silk';
        mast.Name__c = 'Weft';
        mast.Code__c = 'S';
        mast.Active__c = true ;
        insert mast;
        
        
         List<Attachment> attchList = new List<Attachment>();
        RTW_Product__c prod = [SELECT Id, Name,vendor_custom__c FROM RTW_Product__c                
                               where Product__c = 'BLOUSE' limit 1];
        system.debug('prod'+prod);
        ApexPages.currentPage().getParameters().put('productTypeName','BLOUSE');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        rtwHandler.defaultRTWrecs = new List<List<RTW_Product__c>>();
        rtwHandler.UniKey = 'Test';
        //rtwHandler.recordId = 'Test';
        rtwHandler.ProdList = new List<RTW_Product__c>();
        rtwHandler.selectProducts = new List<RTW_Product__c>();
        RTW_Product_Handler.StartDate = (Date.today()).addDays(-1);
        RTW_Product_Handler.EndDate = (Date.today()).addDays(1);
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
      
       // attchList.add();
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
       // rtwHandler.acc = [select id,name from account limit 1];
        rtwHandler.ProdCreatePage();
        rtwHandler.uploadAttachment();
        rtwHandler.ProductSave();
        
        rtwHandler.ProductSubmit();
        rtwHandler.doCopy();
        rtwHandler.deleteProds();
    } 
    @isTest
    public static void TestRTW_Product_HandlerLehengaMethod2()
    {
       /* 
        for(Master__c m : [SELECT Id, Active__c, Code__c, Name__c, Name FROM Master__c]){
            MasterCode.put((m.Name__c+m.Name).toLowercase().remove(' '),m.Code__c);
        }
        */
        Master__c mast = new Master__c();
        mast.Name = 'Silk';
        mast.Name__c = 'Weft';
        mast.Code__c = 'S';
        mast.Active__c = true ;
        insert mast;
        
        
         List<Attachment> attchList = new List<Attachment>();
        RTW_Product__c prod = [SELECT Id, Name,vendor_custom__c FROM RTW_Product__c                
                               where Product__c = 'LEHENGA' limit 1];
        system.debug('prod'+prod);
        ApexPages.currentPage().getParameters().put('productTypeName','LEHENGA');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        rtwHandler.defaultRTWrecs = new List<List<RTW_Product__c>>();
        rtwHandler.UniKey = 'Test';
        //rtwHandler.recordId = 'Test';
        rtwHandler.ProdList = new List<RTW_Product__c>();
        rtwHandler.selectProducts = new List<RTW_Product__c>();
        RTW_Product_Handler.StartDate = (Date.today()).addDays(-1);
        RTW_Product_Handler.EndDate = (Date.today()).addDays(1);
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id; 
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
      
       // attchList.add();
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
       // rtwHandler.acc = [select id,name from account limit 1];
        rtwHandler.ProdCreatePage();
        rtwHandler.uploadAttachment();
        rtwHandler.ProductSave();
        
        rtwHandler.ProductSubmit();
        rtwHandler.doCopy();
        rtwHandler.deleteProds();
    }
    @isTest
    public static void TestRTW_Product_HandlerDuppattaMethod3()
    {
        RTW_Product__c prod = [SELECT Id, Name FROM RTW_Product__c                
                               where Product__c = 'DUPPATTA' limit 1];
        ApexPages.currentPage().getParameters().put('productTypeName','DUPPATTA');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        RTW_Product_Handler.StartDate = Date.today();
        RTW_Product_Handler.EndDate = Date.today();
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
        rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
        
        rtwHandler.ProdCreatePage();
        rtwHandler.ProductSubmit();
        rtwHandler.doCopy();
        rtwHandler.deleteProds();
    }  
    @isTest
    public static void TestRTW_Product_HandlerLehengaMethod4()
    {
        RTW_Product__c prod = [SELECT Id, Name FROM RTW_Product__c                
                               where Product__c = 'LEHENGA' limit 1];
        ApexPages.currentPage().getParameters().put('productTypeName','LEHENGA');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        RTW_Product_Handler.StartDate = Date.today();
        RTW_Product_Handler.EndDate = Date.today();
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        //rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
        rtwHandler.ProdCreatePage();
        rtwHandler.ProductSave();
        PageReference p = rtwHandler.addNewRow();
        rtwHandler.ProductSubmit();
        rtwHandler.doCopy();
        rtwHandler.deleteProds();
       
    }
    @isTest
    public static void TestRTW_Product_HandlerBlouseMethod5()
    {
        RTW_Product__c prod = [SELECT Id,Name FROM RTW_Product__c                
                               where Product__c = 'BLOUSE' limit 1];
        ApexPages.currentPage().getParameters().put('productTypeName','BLOUSE');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        RTW_Product_Handler.StartDate = Date.today();
        RTW_Product_Handler.EndDate = Date.today();
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
       // rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
        rtwHandler.ProdCreatePage();
        rtwHandler.doCopy();
        rtwHandler.ProductSubmit();
        rtwHandler.deleteProds();
    }
    @isTest
    public static void TestRTW_Product_HandlerTrouserMethod6()
    {
        //id rec = [SELECT Id, SobjectType, Name FROM RecordType where name = 'Vendor'].id;
        vendor__c acc = new vendor__c(Name='TestAccount',Phone_No__c = '87941312132',Mail_ID__c = 'deepak@gmail.com');
        insert acc;
        
        RTW_Product__c prod = [SELECT Id,Name FROM RTW_Product__c                
                               where Name = 'TROUSER' limit 1]; 
        ApexPages.currentPage().getParameters().put('productTypeName','TROUSER');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        RTW_Product_Handler.StartDate = Date.today();
        RTW_Product_Handler.EndDate = Date.today();
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
       // rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
        rtwHandler.accProd.vendor_custom__c = acc.Id;
        rtwHandler.showVendorMessage();
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
        rtwHandler.ProdCreatePage();
        rtwHandler.wrapperImageClassList[0].prod.Base_colour__c = 'BaseCol1';
        rtwHandler.ProductSubmit();
    }
    
    @isTest
    public static void TestRTW_Product_HandlerMaskMethod7()
    {
         List<Attachment> attchList = new List<Attachment>();
        RTW_Product__c prod = [SELECT Id, Name,vendor_custom__c,Gender__c,Product__c,SKU__c FROM RTW_Product__c                
                               where Product__c = 'MASK' AND Submit__c=FALSE limit 1];
        system.debug('prod::'+prod);
        ApexPages.currentPage().getParameters().put('productTypeName','MASK');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        rtwHandler.defaultRTWrecs = new List<List<RTW_Product__c>>();
        rtwHandler.UniKey = 'Test';
        //rtwHandler.recordId = 'Test';
        rtwHandler.ProdList = new List<RTW_Product__c>();
        rtwHandler.selectProducts = new List<RTW_Product__c>();
        RTW_Product_Handler.StartDate = Date.today();
        RTW_Product_Handler.EndDate = Date.today();
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Gender__c';
        rtwHandler.no_of_Products = 10;
        rtwHandler.uploadAttachment();
        //rtwHandler.uploadAttachments();
        rtwHandler.showPopup();
        rtwHandler.hidePopup();
        rtwHandler.csvFileBody = blob.valueOf('Product__c,Base_Colour__c,MFabric__c,MStyle_name__c,Gender__c,MDesign__c,MPleats__c,MPly__c,Quantity__c,Cost,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,SKU count,Order_ID__c,Remarks__c\n'
										+'MASK,BaseCol1,Silk,XXXX,Male,Block Print,Yes,2Ply,2,1000,Test Deep,1,Test Deep,1,3,1, \n'
										+'MASK,BaseCol1,Silk,XXXX,Male,Block Print,Yes,2Ply,3,1000,Test Deep,1,Test Deep,1,3,1, \n');
        rtwHandler.importCSVFile();
        rtwHandler.deleteAddedRow();
        RTW_Product_Handler.attachmentClass attchClass = new RTW_Product_Handler.attachmentClass(prod.id); 
        attchClass.docRec.name = 'TestDoc';
        attchClass.docRec.body = Blob.valueOf('TestDoc');
        attchClass.imgRec.name = 'TestDoc';
        attchClass.imgRec.body = Blob.valueOf('TestDoc');
        
        rtwHandler.popupAttachmentList.add(attchClass);
        rtwHandler.uploadAttachment();
        rtwHandler.previewAttachment();
        rtwHandler.showUploadPopUp();
        rtwHandler.hideUploadPopUp();
       // rtwHandler. 
       // attchList.add();
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
        rtwHandler.ProdCreatePage();
      
        rtwHandler.ProductSave();
        rtwHandler.ProductSubmit();
        RTW_Product_Handler.wrapperImageClass wrapObj = new RTW_Product_Handler.wrapperImageClass();
        wrapObj.prod = prod;
        List<RTW_Product_Handler.wrapperImageClass> lstWrap = new List<RTW_Product_Handler.wrapperImageClass>();
        lstWrap.add(wrapObj);
        rtwHandler.wrapperImageClassList = lstWrap;
       // rtwHandler.doCopy();
        rtwHandler.deleteProds();
       /* ApexPages.currentPage().getParameters().put('index','0');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        rtwHandler.deleteAddedRow();*/
        VendorObjectMigrationBatchRTW myBatchObject1 = new VendorObjectMigrationBatchRTW(); 
        Id batchId1 = Database.executeBatch(myBatchObject1,200);
    }
    @isTest
    public static void TestRTW_Product_HandlerKurtaMethod8()
    {
       /* 
        for(Master__c m : [SELECT Id, Active__c, Code__c, Name__c, Name FROM Master__c]){
            MasterCode.put((m.Name__c+m.Name).toLowercase().remove(' '),m.Code__c);
        }
        */
        Master__c mast = new Master__c();
        mast.Name = 'Silk';
        mast.Name__c = 'Weft';
        mast.Code__c = 'S';
        mast.Active__c = true ;
        insert mast;
        
        
         List<Attachment> attchList = new List<Attachment>();
        RTW_Product__c prod = [SELECT Id, Name,vendor_custom__c FROM RTW_Product__c                
                               where Product__c = 'KURTA' limit 1];
        system.debug('prod'+prod);
        ApexPages.currentPage().getParameters().put('productTypeName','KURTA');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        rtwHandler.defaultRTWrecs = new List<List<RTW_Product__c>>();
        rtwHandler.UniKey = 'Test';
        //rtwHandler.recordId = 'Test';
        rtwHandler.ProdList = new List<RTW_Product__c>();
        rtwHandler.selectProducts = new List<RTW_Product__c>();
        RTW_Product_Handler.StartDate = (Date.today()).addDays(-1);
        RTW_Product_Handler.EndDate = (Date.today()).addDays(1);
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
      
       // attchList.add();
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
       // rtwHandler.acc = [select id,name from account limit 1];
        rtwHandler.ProdCreatePage();
        rtwHandler.uploadAttachment();
        rtwHandler.ProductSave();
        
        rtwHandler.ProductSubmit();
        rtwHandler.doCopy();
        rtwHandler.deleteProds();
    } 
    @isTest
    public static void TestRTW_Product_HandlerDressMethod9()
    {
       /* 
        for(Master__c m : [SELECT Id, Active__c, Code__c, Name__c, Name FROM Master__c]){
            MasterCode.put((m.Name__c+m.Name).toLowercase().remove(' '),m.Code__c);
        }
        */
        Master__c mast = new Master__c();
        mast.Name = 'Silk';
        mast.Name__c = 'Weft';
        mast.Code__c = 'S';
        mast.Active__c = true ;
        insert mast;
        
        
         List<Attachment> attchList = new List<Attachment>();
        RTW_Product__c prod = [SELECT Id, Name,vendor_custom__c FROM RTW_Product__c                
                               where Product__c = 'DRESS' limit 1];
        system.debug('prod'+prod);
        ApexPages.currentPage().getParameters().put('productTypeName','DRESS');
        ApexPages.currentPage().getParameters().put('ProductKey',prod.Name);
        RTW_Product_Handler rtwHandler = new RTW_Product_Handler();
        rtwHandler.defaultRTWrecs = new List<List<RTW_Product__c>>();
        rtwHandler.UniKey = 'Test';
        //rtwHandler.recordId = 'Test';
        rtwHandler.ProdList = new List<RTW_Product__c>();
        rtwHandler.selectProducts = new List<RTW_Product__c>();
        RTW_Product_Handler.StartDate = (Date.today()).addDays(-1);
        RTW_Product_Handler.EndDate = (Date.today()).addDays(1);
        RTW_Product_Handler.selectedCategoryUser=[select id,Name from user Limit 1 ].Id;
        // rtwHandler.listIndex = 10;
        // rtwHandler.querystr = 'Test';
        rtwHandler.selectOSku = prod;
        rtwHandler.RTW_Product = prod;
        rtwHandler.photo = Blob.valueOf('Test');
        rtwHandler.UniqueKey = new Set<String>{'Test'};
            rtwHandler.str = 10;
        //rtwHandler.showDefaultRecs = true;
        rtwHandler.showSavedRecs=true;
        RTW_Product_Handler.baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        rtwHandler.rtwProd = prod;
        rtwHandler.copyValue = 'Name';
        rtwHandler.no_of_Products = 10;
      
       // attchList.add();
       // rtwHandler.wrapperImageClassList[0].photo = Blob.valueOf('Test Image');
       // rtwHandler.acc = [select id,name from account limit 1];
        rtwHandler.ProdCreatePage();
        rtwHandler.uploadAttachment();
        rtwHandler.ProductSave();
        
        rtwHandler.ProductSubmit();
        rtwHandler.doCopy();
        rtwHandler.deleteProds();
    }   
       
}