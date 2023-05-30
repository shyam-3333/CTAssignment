@istest
public class RTWProdCategoryController_Test {
    @isTest
    public static void TestRTW_Product_HandlerBlouseMethod1()
    {
        vendor__c acc = new vendor__c(Name='TestAccount',Phone_No__c = '87941312132',Mail_ID__c = 'deepak@gmail.com');
        insert acc;
        RTW_Product__c rtwprod1 =  new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',MFabric__c = 'Cotton',Collection__c='Core wear', Assigned_To__c = userInfo.getUserId(), Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod1;
        
        RTW_Product__c rtwprod2 =  new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',MFabric__c = 'Cotton',Collection__c='Festive Wear',Assigned_To__c = userInfo.getUserId(),Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod2;
        
        RTW_Product__c rtwprod3 =  new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',MFabric__c = 'Cotton',Collection__c='Festive Wear',Assigned_To__c = userInfo.getUserId(),Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod3;   
              RTW_Product__c rtwprod4 =  new RTW_Product__c(Name='KURTA',Product__c='KURTA', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',MFabric__c = 'Cotton',Collection__c='Festive Wear',Assigned_To__c = userInfo.getUserId(),Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod4; 
        
        RTW_Product__c rtw1 = new  RTW_Product__c();
        rtw1.Actual_MRP__c = null;
        rtw1.Multiplier__c = null;
        insert rtw1;
        
        RTW_Multiplier_Master__c rtwmul = new RTW_Multiplier_Master__c();
        rtwmul.Multiplier_c__c= 4.5;
        rtwmul.Fabric__c='Cotton';
        rtwmul.Product_Category__c='BLOUSE';
        rtwmul.Craft__c='BATIK';
        rtwmul.Collection__c='Festive Wear';
        insert rtwmul;
        
        RTW_Multiplier_Master__c rtwmul2 = new RTW_Multiplier_Master__c();
        rtwmul2.Multiplier_c__c= 4.5;
        rtwmul2.Fabric__c='Default';
        rtwmul2.Product_Category__c='BLOUSE';
        rtwmul2.Craft__c='Default';
        rtwmul2.Collection__c='Festive Wear';
        insert rtwmul2;
        
        RTW_Multiplier_Master__c rtwmul3 = new RTW_Multiplier_Master__c();
        rtwmul2.Multiplier_c__c= 4.5;
        rtwmul2.Fabric__c='Default';
        rtwmul2.Product_Category__c='KURTA';
        rtwmul2.Craft__c='Default';
        rtwmul2.Collection__c='Festive Wear';
        insert rtwmul3;
        
        RTW_Multiplier_Master__c rtwmul4 = new RTW_Multiplier_Master__c();
        rtwmul2.Multiplier_c__c= 4.5;
        rtwmul2.Fabric__c='Default';
        rtwmul2.Product_Category__c='LEHENGA';
        rtwmul2.Craft__c='Default';
        rtwmul2.Collection__c='Festive Wear';
        insert rtwmul4;
        
        RTW_Pricing_Exception__c prc1 = new RTW_Pricing_Exception__c();
        prc1.Min__c = 0;
        prc1.Max__c = 1000;
        prc1.SetNearestTo__c = 500;
        prc1.RTW_Product_Category__c = 'KURTA';
        insert prc1;
        
        RTWProdCategoryController.ProductKey='BLOUSE';
        RTWProdCategoryController.productTypeName='BLOUSE';
        RTWProdCategoryController.copyValue = 'Actual_MRP_Update__c';
         RTWProdCategoryController rtwcat= new RTWProdCategoryController();
        rtwcat.doSave();
        rtwcat.doSubmit();
        rtwcat.onchangemultiplier();
        rtwcat.onchangeActualMrp();
        rtwcat.doassignback();
        rtwcat.copyAll();
        RTWProdCategoryController.copyValue = 'Multiplier__c';
        rtwcat.copyAll();
        new RTWProdCategoryController().setNearestvalue(2000,100);
        

    }
}