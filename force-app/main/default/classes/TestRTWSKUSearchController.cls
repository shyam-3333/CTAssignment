@isTest
public class TestRTWSKUSearchController {
 public static String recType= Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
    public static String str;// = 'Prod1,'+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+Prod2+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
    public static String[] csvFileLines;
    public static Blob csvFileBody;
    public String csvDataString;
    public String[] recordSepr= new String[]{};
     Double qty; Double amount;
    
    public static testmethod void  verifyData(){
        
         Test.startTest();
        RTWSKUSearchController p = new RTWSKUSearchController();
        //p.FirstPage();
        p.previous();
       // p.POnumberstring = new List<string>();
       // p.POnumberstring.add('1234');
        //p.LastPage();
        p.getprev();
        p.getnxt();
       List<RTWProduct__c> rtwProdList = new List<RTWProduct__c>(); 
        List<Attachment> attchList = new List<Attachment>();
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
        masterList.add(new Master__c(Code__c='FW',Name__c ='Season',Name = 'FW19',Active__c=true));
        masterList.add(new Master__c(Code__c='CW',Name__c ='Collection',Name = 'Corewear',Active__c=true));
        masterList.add(new Master__c(Code__c='C',Name__c ='Fabric',Name = 'Cotton123',Active__c=true));
        masterList.add(new Master__c(Code__c='H',Name__c ='ProductType',Name = 'MASK',Active__c=true));
        masterList.add(new Master__c(Code__c='G',Name__c ='Gender',Name = 'Male',Active__c=true));
        masterList.add(new Master__c(Code__c='2',Name__c ='Ply',Name = '2Ply',Active__c=true));
        masterList.add(new Master__c(Code__c='A',Name__c ='Style Name',Name = 'XXXX',Active__c=true));
        masterList.add(new Master__c(Code__c='KU',Name__c ='ProductType',Name = 'KURTA',Active__c=true));
        masterList.add(new Master__c(Code__c='DR',Name__c ='ProductType',Name = 'DRESS',Active__c=true));
        masterList.add(new Master__c(Code__c='U',Name__c ='ProductType',Name = 'USKD',Active__c=true));
        masterList.add(new Master__c(Code__c='TR',Name__c ='ProductType',Name = 'TROUSER',Active__c=true));
        masterList.add(new Master__c(Code__c='DU',Name__c ='ProductType',Name = 'DUPPATTA',Active__c=true));
        
        
        system.debug('masterList---'+masterList[0]);
        Insert masterList;
        
        AutoNumber__c autonum = new AutoNumber__c(Name='1',Auto_Number__c=1);
        insert autonum;
        AutoNumber__c autonum1 = new AutoNumber__c(Name='2',Auto_Number__c=2,Product_Category__c = 'USKD',Loom__c = 'Handloom',Proc_Type__c='trading');
        insert autonum1;
        RTWAutoNumber__c rtwNum = new RTWAutoNumber__c(Name='Test',Combination_Code__c='LFW19CWC', Collection__c='Core wear', Fabrics__c='Cotton', ProductType__c='Blouse', Running_Number__c=10,Season__c='FW19');
        RTWAutoNumber__c rtwNum2 = new RTWAutoNumber__c(Name='Test3',Combination_Code__c='HG2A', ProductType__c='MASK', Running_Number__c=71,Gender__c='Male',Ply__c='2Ply',Style_Code__c='XXXX');
        RTWAutoNumber__c rtwNum1 = new RTWAutoNumber__c(Name='Test1',Combination_Code__c='BFW19CWC', Collection__c='Core wear', Fabrics__c='Cotton', ProductType__c='Blouse', Running_Number__c=10,Season__c='FW19');
        RTWAutoNumber__c rtwNum3 = new RTWAutoNumber__c(Name='Test1',Combination_Code__c='BFW19CWC', Collection__c='Core wear', Fabrics__c='Cotton', ProductType__c='TROUSER', Running_Number__c=10,Season__c='FW19');
        RTWAutoNumber__c rtwNum4 = new RTWAutoNumber__c(Name='Test1',Combination_Code__c='BFW19CWC', Collection__c='Core wear', Fabrics__c='Cotton', ProductType__c='DUPPATTA', Running_Number__c=10,Season__c='FW19');
        
        List<RTW_Ecom_Size__c> ecomsizelist = new List<RTW_Ecom_Size__c>();
        RTW_Ecom_Size__c ecomsize1 = new RTW_Ecom_Size__c(Name='1',Product__c='BLOUSE', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize1);
        RTW_Ecom_Size__c ecomsize2 = new RTW_Ecom_Size__c(Name='2',Product__c='KURTA SET', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize2);
        RTW_Ecom_Size__c ecomsize3 = new RTW_Ecom_Size__c(Name='3',Product__c='KURTA', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize3);
        RTW_Ecom_Size__c ecomsize4 = new RTW_Ecom_Size__c(Name='4',Product__c='TUNIC', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize4);
        RTW_Ecom_Size__c ecomsize5 = new RTW_Ecom_Size__c(Name='5',Product__c='TROUSER', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize5);
        RTW_Ecom_Size__c ecomsize6 = new RTW_Ecom_Size__c(Name='6',Product__c='SLIP', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize6);
        RTW_Ecom_Size__c ecomsize7 = new RTW_Ecom_Size__c(Name='7',Product__c='DRESS', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize7);
        RTW_Ecom_Size__c ecomsize8 = new RTW_Ecom_Size__c(Name='8',Product__c='TROUSER', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize8);
        RTW_Ecom_Size__c ecomsize9 = new RTW_Ecom_Size__c(Name='9',Product__c='DUPPATTA', Size__c='32', Ecom_Size__c='M');ecomsizelist.add(ecomsize9);
        
        
        insert ecomsizelist;
        
        Insert rtwNum;
        Insert rtwNum1;
        Insert rtwNum2;
        SKU_Month_Code__c sku = new SKU_Month_Code__c(Name='1', Code__c = 'A');
        insert sku;
        List<RTW_Product__c> rtwProdLists = new List<RTW_Product__c>();
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='BLOUSE', vendor_custom__c = acc.Id,season__c='FW19',Base_Colour__c='Red',collection__c='Core wear', Warp__c='Cotton123',Weft__c='Cotton123',MFabric__c = 'Cotton',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='BLOUSE', vendor_custom__c = acc.Id,season__c='FW19',Base_Colour__c='Red',collection__c='Core wear', Warp__c='Cotton123',Weft__c='Cotton123',MFabric__c = 'Cotton',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        
        rtwProdLists.add(new RTW_Product__c(Name='DUPPATTA',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='DUPPATTA', Okhai_Size__c='OS2',vendor_custom__c = acc.Id,season__c='FW19',Base_Colour__c='Red',collection__c='Core wear', Warp__c='Cotton123',Weft__c='Cotton123',MFabric__c = 'Cotton',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='DUPPATTA',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='DUPPATTA',vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        
        rtwProdLists.add(new RTW_Product__c(Name='LEHENGA',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c='LEHENGA',SKU_Count__c=1, vendor_custom__c = acc.Id, season__c='FW19',collection__c='Core wear', Warp__c='Cotton123',Weft__c='Cotton123',Base_Colour__c='Red',Size_LCD__c='32',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='LEHENGA',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Base_Colour__c = 'BaseCol1',SKU_Count__c=1, vendor_custom__c = acc.Id,Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=20,Product__c='LEHENGA',Quantity__c=8,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Blouse_Type__c='Type 1',BlouseSize_LCD__c='BSL1',Dimensions__c='D1',DupattaDimensions__c='DD1',DupattaFabric__c='DF1',Dupatta_Type__c='DT1',Gender__c='Male',Occasion__c='O1',Origin__c='Banaras',ReadyGHERA_MT__c='R1',ReadyHip_Inch__c='RH1',ReadyWaist_Inch__c='R1',Silhouette__c='S1',Size_LCD__c='32',SkirtPanels__c='SP1',Source__c='S1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        
        rtwProdLists.add(new RTW_Product__c(Name='DUPPATTA',submit__c = FALSE ,Product__c = 'DUPPATTA'));
        rtwProdLists.add(new RTW_Product__c(Name='USKD',Sourcing_user_email__c='vindya@gmail.com',submit__c = FALSE ,Product__c = 'USKD',Loom__c = 'Handloom',Proc_Type__c='Trading',Base_Colour__c = 'BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',MRP_Pc__c=12,Quantity__c =12,Season__c='FW19',Warp__c='Cotton123DD',Weft__c='Cotton123',Gender__c='Male', Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='DUPPATTA',submit__c = FALSE ,Product__c = 'DUPPATTA',Base_Colour__c = null,Collection__c='Core wear',Craft__c='Craft1234',MRP_Pc__c=12,Quantity__c =12,Season__c='FW19',Warp__c='Cotton123DD',Weft__c='Cotton123',Gender__c='Male', Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020));
        rtwProdLists.add(new RTW_Product__c(Name='MASK',Sourcing_user_email__c='vindya@gmail.com',Base_Colour__c='',submit__c = FALSE , vendor_custom__c = acc.Id,Product__c='MASK',Quantity__c=2,Gender__c='Male',MStyle_name__c='xxxx',MPly__c='2ply',MCost__c = 1000,MPleats__c ='Yes',MDesign__c = 'Block Print',MFabric__c = 'Cotton',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='MASK',Sourcing_user_email__c='vindya@gmail.com',Base_Colour__c='BaseCol3',submit__c = FALSE , vendor_custom__c = acc.Id,Product__c='MASK',Quantity__c=2,Gender__c='Male',MStyle_name__c='xxxx',MPly__c='2ply',MPleats__c ='Yes',MDesign__c = 'Block Print',MFabric__c = 'Cotton',RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='MASK',Sourcing_user_email__c='vindya@gmail.com',Base_Colour__c='Black',submit__c = FALSE , vendor_custom__c = acc.Id,Product__c='MASK',Quantity__c=2,Gender__c='Male',MStyle_name__c='xxxx',MPly__c='2ply',MPleats__c ='Yes',MDesign__c = 'Block Print',MFabric__c = 'Cotton',RTW_SIZE__c=''));
        rtwProdLists.add(new RTW_Product__c(Name='TROUSER',Sourcing_user_email__c='vindya@gmail.com',Base_Colour__c='BaseCol3',submit__c = FALSE ,Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',Buyers_Cost__c=123,MRP_Pc__c=123,Product__c='TROUSER',Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='32',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='KURTA',Sourcing_user_email__c='vindya@gmail.com',Product__c='KURTA',submit__c = FALSE , vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='DRESS',Sourcing_user_email__c='vindya@gmail.com',Product__c='DRESS',submit__c = FALSE , vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
        rtwProdLists.add(new RTW_Product__c(Name='DRPDSAREE',Sourcing_user_email__c='vindya@gmail.com',Product__c='DRPDSAREE',submit__c = FALSE , vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));
       // rtwProdLists.add(new RTW_Product__c(Name='DRPDSAREE',Sourcing_user_email__c='vindya@gmail.com',Product__c='DRPDSAREE',submit__c = FALSE , vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',Collection__c='Core wear',Craft__c='Craft1234',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,RTW_SIZE__c='32'));

        insert rtwProdLists;
        
        
        
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Purchase'].Id,
            LastName = 'last',
            Email = 'vindyashree.ak@gmail.com',
            Username = 'vindyashree.ak@gmail.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'     
        );
        insert u;
        RTWSKUSearchController opObj2 = new RTWSKUSearchController();
        list<string> POnumberstring = new List<string>();
        //opObj2.POnumberstring.add('1234');
        //opObj2.searchmethod();
        opObj2.clear();
        opObj2.excelDownload();
        opObj2.searchmethod();
        opObj2.previous();
        opObj2.next();
          test.StopTest();

    }
    

}