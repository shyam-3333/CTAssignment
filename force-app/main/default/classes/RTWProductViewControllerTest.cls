@istest
public class RTWProductViewControllerTest {
      public Set<string> uniqueKeySet;
    public static Map<string,List<RTW_Product__c>> prodMap;
      public string uniquekey;
    public string productTypeName;
    public Map<string,decimal> qtyMap;
    public Map<string,decimal> mrpMap;
    public Map<string,decimal> costMap;
    public Map<string,Boolean> poStatusMap;
    @isTest
    public static void RTWProductViewControllerTestMethod(){
        List<RTW_Product__c> proList=new List<RTW_Product__c>();
        List<RTW_Product__c> rtwList = new List<RTW_Product__c>();
        
        Id userId;
        for(User usr : [Select Id from User where Name = 'Admin User' Limit 1]){
            userId=usr.Id;
        }
        
        //Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        //blob img=new blob();
        vendor__c acc = new vendor__c();
        acc.Name= 'TestAccount';
        acc.Mail_ID__c = 'anindwita.raj@kvpcorp.com';
        //acc.RecordTypeId = recordTypeId;
        insert acc;
        rtwProductViewController prodController = new rtwProductViewController();
        //prodController.COMMA = 'A4';
        // prodController.CRLF= '/r';
        prodController.ProductDownload();
        prodController.ProductPDFDownload();
        prodController.downloadPO();
        prodController.downloadMM();
        
        RTW_Product__c rtw = new RTW_Product__c();
        rtw.Name = 'test';
        rtw.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw.vendor_custom__c = acc.id;
        rtw.Product__c = 'BLOUSE';
        rtw.Photo__c = '';
        // rtw.ImageLink__c=
        rtw.SKU_Count__c=10;
        rtw.PO_Number__c = 123456;
        rtw.Pack_no__c = '1';
        rtw.Quantity__c=6;
        rtw.MCost__c = 10;
        rtw.Origin__c='jaipur';
        rtw.sku__c = 'BFW21FW0001XY34';
        rtw.Assigned_To__c=userId;
        rtw.Warp__c = 'SATIN';
        rtw.Weft__c = 'SATIN';
        rtw.Craft__c = 'Block Print-Sanganeri';
        rtw.Base_Colour__c = 'RED';
        rtw.RTW_SIZE__c = 'XXL';
        rtw.MRP_Pc__c = 999;
        rtw.Blouse_Type__c = 'Stitched';
        rtwList.add(rtw);
        
        RTW_Product__c rtw1 = new RTW_Product__c();
        rtw1.Name = 'test1';
        rtw1.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw1.vendor_custom__c = acc.id;
        rtw1.Product__c = 'BLOUSE';
        rtw1.Photo__c = '';
        // rtw1.ImageLink__c=
        rtw1.SKU_Count__c=10;
        rtw.PO_Number__c = 123456;
        rtw1.Pack_no__c = '1';
        rtw1.Quantity__c=6;
        rtw1.MCost__c = 5;
        rtw1.Origin__c='jaipur';
        rtw1.sku__c = 'BFW21FW0004XY34';
        rtw1.Assigned_To__c=userId;
        rtw1.Blouse_Type__c = 'Stitched';
        rtwList.add(rtw1);
        
        RTW_Product__c rtw2 = new RTW_Product__c();
        rtw2.Name = 'test2';
        rtw2.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw2.vendor_custom__c = acc.id;
        rtw2.Product__c = 'KURTA';
        rtw2.Photo__c = '';
        // rtw.ImageLink__c=
        rtw2.SKU_Count__c=10;
        rtw.PO_Number__c = 123456;
        rtw2.Pack_no__c = '1';
        rtw2.Quantity__c=6;
        rtw2.MCost__c = 10;
        rtw2.Origin__c='jaipur';
        rtw2.sku__c = 'BFW21FW0001XY34';
        rtw2.Assigned_To__c=userId;
        rtw2.Warp__c = 'SATIN';
        rtw2.Weft__c = 'SATIN';
        rtw2.Craft__c = 'Block Print-Sanganeri';
        rtw2.Base_Colour__c = 'RED';
        rtw2.RTW_SIZE__c = 'XXL';
        rtw2.MFabric__c = 'Silk Cotton';
        rtw2.Season__c = 'FW21';
        rtw2.MRP_Pc__c = 1000;
        rtw2.Total_Costs__c = 2000;
        rtwList.add(rtw2);
        
        RTW_Product__c rtw3 = new RTW_Product__c();
        rtw3.Name = 'test3';
        rtw3.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw3.vendor_custom__c = acc.id;
        rtw3.Product__c = 'MASK';
        rtw3.Photo__c = '';
        // rtw.ImageLink__c=
        rtw3.SKU_Count__c=10;
        rtw3.Pack_no__c = '1';
        rtw3.Quantity__c=6;
        rtw3.MCost__c = 10;
        rtw3.Origin__c='jaipur';
        rtw3.sku__c = 'BFW21FW0001XY34';
        rtw3.Assigned_To__c=userId;
        rtw3.Warp__c = 'SATIN';
        rtw3.Weft__c = 'SATIN';
        rtw3.Craft__c = 'Block Print-Sanganeri';
        rtw3.Base_Colour__c = 'RED';
        rtw3.RTW_SIZE__c = 'XXL';
        rtw3.MFabric__c = 'Silk Cotton';
        rtw3.Season__c = 'FW21';
        rtw3.MRP_Pc__c = 1100;
        rtwList.add(rtw3);
        
         RTW_Product__c rtw5 = new RTW_Product__c();
        rtw5.Name = 'test4';
        rtw5.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw5.vendor_custom__c = acc.id;
        rtw5.Product__c = 'MASK';
        rtw5.Photo__c = '';
        // rtw.ImageLink__c=
        rtw5.SKU_Count__c=10;
        rtw5.Pack_no__c = '1';
        rtw5.Quantity__c=null;
        rtw5.MCost__c = 10;
        rtw5.Origin__c='jaipur';
        rtw5.sku__c = 'BFW22FW0001XY34';
        rtw5.Assigned_To__c=userId;
        rtw5.Warp__c = 'SATIN';
        rtw5.Weft__c = 'SATIN';
        rtw5.Craft__c = 'Block Print-Sanganeri';
        rtw5.Base_Colour__c = 'RED';
        rtw5.RTW_SIZE__c = 'XXL';
        rtw5.MFabric__c = 'Silk Cotton';
        rtw5.Season__c = 'FW21';
        rtw5.MRP_Pc__c = 1100;
        rtwList.add(rtw5);
        
        RTW_Product__c rtw4 = new RTW_Product__c();	
        rtw4.Name = 'test02';	
        rtw4.RTW_Pricing_Submitted_Status__c = 'Submitted';	
        rtw4.vendor_custom__c = acc.id;	
        rtw4.Product__c = 'BLOUSE';	
        rtw4.Photo__c = '';	
        rtw4.Submit__c = True;	
       // rtw1.ImageLink__c=	
       rtw4.SKU_Count__c=10;	
        rtw4.Pack_no__c = '1';	
        rtw4.Quantity__c=6;	
        rtw4.MCost__c = 5;	
        rtw4.Origin__c='jaipur';	
        rtw4.sku__c = 'BFW21FW0004XY34';	
        rtw4.Assigned_To__c=userId;	
        rtwList.add(rtw4);
        
        insert rtwList;
        
        List<RTW_Product__c> prodList = new List<RTW_Product__c>([Select Name,RTW_Pricing_Submitted_Status__c,vendor_custom__c,Product__c,Photo__c,SKU_Count__c,Pack_no__c,Quantity__c,MCost__c,Origin__c,sku__c,
                                                                 Assigned_To__c,Warp__c,Weft__c,Craft__c,Base_Colour__c,RTW_SIZE__c,MFabric__c,Season__c,E_Com_Material__c,Blouse_Type__c,MRP_Pc__c from RTW_Product__c]);
        //ApexPages.currentPage().getParameters().put('ProductKey','MASK');
        RTWProductViewController rtwclss = new RTWProductViewController();
        /*for(RTW_Product__c ttt : rtwList){
            RTWProductViewController.proList.add(ttt);
        }*/
        rtwclss.ProductDateFilter();
        rtwclss.ProductDownload();
        
        RTWProductViewController.prodWrapWithImage wrp = new RTWProductViewController.prodWrapWithImage();
        wrp.imgLink = '';
        wrp.prod = rtwList[0];
        
        rtwclss.ProdType = 'BLOUSE';
        //rtwclss.productTypeName = 'BLOUSE';
        
        RTWProductUpdateViewController rtwclss2 = new RTWProductUpdateViewController();
        rtwclss2.ProductDownload();
        rtwclss2.ProductPDFDownload();
        rtwclss2.DocDwld();
        rtwclss2.ImageDwld();
        rtwclss2.ProductDateFilter();
       
    
        RTWProductViewController.StartDate = Date.newInstance(2021, 4,13 );
        RTWProductViewController.EndDate = Date.newInstance(2021, 4, 15);
        
        rtwclss.ProductDateFilter();
        //rtwclss.uniquekey = apexpages.currentpage().getparameters().put(rtwclss.ProdType);
        ApexPages.currentPage().getParameters().put('ProductKey', rtw.Name);
        
        
        RTW_Product__c pro = new RTW_Product__c();
        pro.ImageLink__c='test1.img';
        
        rtwclss.DocDwld();
        rtwclss.ImageDwld();
        
        List<RTWProductViewController.ProductMMWrapper> productMMList = new List<RTWProductViewController.ProductMMWrapper>();
        /*TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        List<TaneiraPO__c> tanPO = new List<TaneiraPO__c>([select Name,Storage_Location__c,Profit_Center__c from TaneiraPO__c]);*/
        RtwPO__c rtwPO = new RtwPO__c(Name = 'SIKA', Purchase_Group__c = 'RTW',Storage_Location__c = '1008', Profit_Center__c = 'SSSIKA');
        insert rtwPO;
        List<RtwPO__c> rtwPON = new List<RtwPO__c>([select Name,Purchase_Group__c,Storage_Location__c,Profit_Center__c from RtwPO__c]);

        RTW_Product_Description__c prodDescrition1 = new RTW_Product_Description__c(Name = 'BLOUSE', Number_of_letters_for_Product_Type__c = 1, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3, Number_of_letters_for_craft__c = 3, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition1;
        RTW_Product_Description__c prodDescrition2 = new RTW_Product_Description__c(Name = 'CANCAN', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition2;
        RTW_Product_Description__c prodDescrition3 = new RTW_Product_Description__c(Name = 'DRESS',  Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition3;
        RTW_Product_Description__c prodDescrition4 = new RTW_Product_Description__c(Name = 'FABRIC BELT', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition4;
        RTW_Product_Description__c prodDescrition5 = new RTW_Product_Description__c(Name = 'GOWN', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition5;
        RTW_Product_Description__c prodDescrition6 = new RTW_Product_Description__c(Name = 'JACKET', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition6;
        RTW_Product_Description__c prodDescrition7 = new RTW_Product_Description__c(Name = 'KURTA', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition7;
        RTW_Product_Description__c prodDescrition8 = new RTW_Product_Description__c(Name = 'KURTA SET', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition8;
        RTW_Product_Description__c prodDescrition9 = new RTW_Product_Description__c(Name = 'LEHNGA', Number_of_letters_for_Product_Type__c = 1, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3, Number_of_letters_for_craft__c = 3, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition9;
        RTW_Product_Description__c prodDescrition10 = new RTW_Product_Description__c(Name = 'MASK', Number_of_letters_for_Product_Type__c = 1, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3, Number_of_letters_for_craft__c = 3, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition10;
        RTW_Product_Description__c prodDescrition11 = new RTW_Product_Description__c(Name = 'SHORT TOP', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition11;
        RTW_Product_Description__c prodDescrition12 = new RTW_Product_Description__c(Name = 'TROUSER', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition12;
        RTW_Product_Description__c prodDescrition13 = new RTW_Product_Description__c(Name = 'TUNIC', Number_of_letters_for_fabric__c = 5, Number_of_letters_for_Season__c = 5, Number_of_letters_for_craft__c = 5, number_of_letters_for_Base_color__c = 6);
        insert prodDescrition13;
        Taneira_Blouse_Type__c type1 = new Taneira_Blouse_Type__c(Name = 'Semistitched', Code__c = 'SM');
        insert type1;
        Taneira_Blouse_Type__c type2 = new Taneira_Blouse_Type__c(Name = 'Stitched', Code__c = 'ST');
        insert type2;
        Taneira_Blouse_Type__c type3 = new Taneira_Blouse_Type__c(Name = 'Stitched Blouse Piece', Code__c = 'ST');
        insert type3;
        Taneira_Blouse_Type__c type4 = new Taneira_Blouse_Type__c(Name = 'Unstiched Blouse Piece', Code__c = 'UN');
        insert type4;
        Taneira_Blouse_Type__c type5 = new Taneira_Blouse_Type__c(Name = 'Unstitched', Code__c = 'UN');
        insert type5;
        Taneira_Blouse_Type__c type6 = new Taneira_Blouse_Type__c(Name = 'Without Blouse Piece', Code__c = 'NB');
        insert type6;
        Map<String,String> proType = new Map<String,String>();
        Map<String,String> proHie = new Map<String,String>();
        Map<String,String> proHie5 = new Map<String,String>();
        Map<String,Master__c> proControlCode = new Map<String,Master__c>();
        List<Master__c> masterList = new List<Master__c>();
        Map<String,String> proUnitMeasure = new Map<String,String>();
        
        proType.put('Lehnga', 'L');
        proType.put('Blouse', 'B');
        proType.put('KURTA', 'KU');
        proType.put('TROUSER', 'TR');
        proType.put('KURTA SET', 'KS');
        proType.put('SHORT TOP', 'ST');
        proType.put('DRESS', 'DR');
        proType.put('TUNIC', 'TU');
        proType.put('MASK', 'H');
        proType.put('SLIP', 'SL');
        proType.put('JACKET', 'J');
        
        proHie.put('Lehnga', 'LCD');
        proHie.put('Blouse', 'BLO');
        
        proHie5.put('KURTA', 'KS2ST');
        proHie5.put('TROUSER', 'TROUS');
        proHie5.put('KURTA SET', 'KS2ST');
        proHie5.put('SHORT TOP', 'SHTST');
        proHie5.put('DRESS', 'DRSST');
        proHie5.put('TUNIC', 'TUNST');
        proHie5.put('MASK', 'MSKST');
        proHie5.put('JACKET', 'JACKT');
        
        proUnitMeasure.put('Blouse', 'MM');
        proUnitMeasure.put('KURTA', 'NO');
        proUnitMeasure.put('DRESS', 'NO');
        proUnitMeasure.put('MASK', 'MM');
        
        Master__c master1 = new Master__c(Name = 'BLO00', X6Digit_Code__c = '620690', X8Digit_Code__c = '62069000', Active__c = true, Name__c = 'Control Code');
        Master__c master2 = new Master__c(Name = 'DHCOT', X6Digit_Code__c = '620449', X8Digit_Code__c = '62044990', Active__c = true, Name__c = 'Control Code');
        Master__c master3 = new Master__c(Name = 'DPONF', X6Digit_Code__c = '621490', X8Digit_Code__c = '62149090', Active__c = true, Name__c = 'Control Code');
        Master__c master4 = new Master__c(Name = 'KS2ST', X6Digit_Code__c = '620700', X8Digit_Code__c = '62070000', Active__c = true, Name__c = 'Control Code');
        Master__c master5 = new Master__c(Name = 'MSKST', X6Digit_Code__c = '620690', X8Digit_Code__c = '62069000', Active__c = true, Name__c = 'Control Code');
        Master__c master6 = new Master__c(Name = 'YPSLK', X6Digit_Code__c = '620690', X8Digit_Code__c = '62069000', Active__c = true, Name__c = 'Control Code');
        masterList.add(master1);
        masterList.add(master2);
        masterList.add(master3);
        masterList.add(master4);
        masterList.add(master5);
        masterList.add(master6);
        
        insert masterList;
        for(Master__c mas: [select Name, X8Digit_Code__c, Active__c, X6Digit_Code__c from Master__c]){
            if(mas.Name!= null && mas.X8Digit_Code__c!= null && mas.X6Digit_Code__c!= null){
                proControlCode.put(mas.Name, mas);
            }
        }
        for(RTW_Product__c prod : prodList){
            System.debug(prod);
            //system.debug(tanPO);
            system.debug(proType);
            system.debug(proHie);
            system.debug(proHie5);
            system.debug(proControlCode);
            system.debug(proUnitMeasure);
                productMMList.add(new RTWProductViewController.ProductMMWrapper(prod,rtwPON, proType, proHie, proHie5, proControlCode, proUnitMeasure));
            }
        
    }
     
}