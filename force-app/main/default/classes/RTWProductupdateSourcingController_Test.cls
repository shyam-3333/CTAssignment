/**************************************************
Name:RTWProductupdateSourcingController_Test
Author:Vindya
Description:This class is an Test calss for RTWProductupdateSourcingController .
******************/
@isTest
public class RTWProductupdateSourcingController_Test {
    @isTest
    public static void RTWProductupdateSourcingControllerTestMethod(){
        List<RTW_Product__c> proList=new List<RTW_Product__c>();
        List<RTW_Product__c> rtwList = new List<RTW_Product__c>();
        Id userId;
        for(User usr : [Select Id from User where Name = 'Admin User' Limit 1]){
            userId=usr.Id;
        }
        
        //Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        //blob img=new blob();
        vendor__c acc2 = new vendor__c();
        acc2.Name= 'TestAccount';
        acc2.Mail_ID__c = 'vindya@kvpcorp.com';
        //acc.RecordTypeId = recordTypeId;
        insert acc2;
        
        
        RTW_Product__c rtw23 = new RTW_Product__c();
        // rtw23.Assigned_sourcing_user__c='Anand';
        rtw23.Name = 'test';
        rtw23.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw23.vendor_custom__c = acc2.id;
        rtw23.Product__c = 'BLOUSE';
        rtw23.Photo__c = '';
        // rtw.ImageLink__c=
        rtw23.SKU_Count__c=10;
        rtw23.PO_Number__c = 123456;
        rtw23.Pack_no__c = '1';
        rtw23.Quantity__c=6;
        rtw23.MCost__c = 10;
        rtw23.Origin__c='jaipur';
        rtw23.sku__c = 'BFW21FW0001XY34';
        //rtw23.Assigned_To__c=userId;
        rtw23.Warp__c = 'SATIN';
        rtw23.Weft__c = 'SATIN';
        rtw23.Craft__c = 'Block Print-Sanganeri';
        rtw23.Base_Colour__c = 'RED';
        rtw23.RTW_SIZE__c = 'XXL';
        rtw23.MRP_Pc__c = 999;
        rtw23.Blouse_Type__c = 'Stitched';
        rtw23.Assigned_sourcing_user__c = userId;
        rtw23.Product_Stage__c = 'SOURCING';
        rtw23.SKU__c = 'BFW21FW0001XY34';
        // rtw23.Assigned_sourcing_user__c = userinfo.getUserId();
        rtwList.add(rtw23);
        RTWProductupdateSourcingController.StartDate = Date.newInstance(2021, 4,13 );
        RTWProductupdateSourcingController.EndDate = Date.newInstance(2021, 4, 15);
        RTW_Product__c rtw24 = new RTW_Product__c();
        rtw24.Name = 'test';
        rtw24.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw24.vendor_custom__c = acc2.id;
        rtw24.Product__c = 'BLOUSE';
        rtw24.Photo__c = '';
        // rtw.ImageLink__c=
        rtw24.SKU_Count__c=10;
        rtw24.PO_Number__c = 123456;
        rtw24.Pack_no__c = '1';
        rtw24.Quantity__c=6;
        rtw24.MCost__c = 10;
        rtw24.Origin__c='jaipur';
        rtw24.sku__c = 'BFW21FW0001XY34';
        rtw24.Warp__c = 'SATIN';
        rtw24.Weft__c = 'SATIN';
        rtw24.Craft__c = 'Block Print-Sanganeri';
        rtw24.Base_Colour__c = 'RED';
        rtw24.RTW_SIZE__c = 'XXL';
        rtw24.MRP_Pc__c = 999;
        rtw24.Blouse_Type__c = 'Stitched';
        rtw24.Assigned_sourcing_user__c = userId;
        rtw24.Product_Stage__c = 'SOURCING';
        rtw24.SKU__c = 'BFW21FW0001XY34';
        // rtw24.Assigned_sourcing_user__c = userinfo.getUserId();
        rtwList.add(rtw24);
        
        RTW_Product__c rtw25 = new RTW_Product__c();
        rtw25.Name = 'test1';
        rtw25.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw25.vendor_custom__c = acc2.id;
        rtw25.Product__c = 'BLOUSE';
        rtw25.Photo__c = '';
        // rtw1.ImageLink__c=
        rtw25.SKU_Count__c=10;
        rtw25.PO_Number__c = 123456;
        rtw25.Pack_no__c = '1';
        rtw25.Quantity__c=6;
        rtw25.MCost__c = 5;
        rtw25.Origin__c='jaipur';
        rtw25.sku__c = 'BFW21FW0004XY34';
        rtw25.Blouse_Type__c = 'Stitched';
        rtw25.Assigned_sourcing_user__c = userId;
        rtw25.Product_Stage__c = 'SOURCING';
        rtw25.SKU__c = 'BFW21FW0001XY34';
        //rtw25.Assigned_sourcing_user__c = userinfo.getUserId();
        rtwList.add(rtw25);
        
        RTW_Product__c rtw2 = new RTW_Product__c();
        rtw2.Name = 'test2';
        rtw2.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw2.vendor_custom__c = acc2.id;
        rtw2.Product__c = 'KURTA';
        rtw2.Photo__c = '';
        // rtw.ImageLink__c=
        rtw2.SKU_Count__c=10;
        rtw2.PO_Number__c = 123456;
        rtw2.Pack_no__c = '1';
        rtw2.Quantity__c=6;
        rtw2.MCost__c = 10;
        rtw2.Origin__c='jaipur';
        rtw2.sku__c = 'BFW21FW0001XY34';
        
        rtw2.Warp__c = 'SATIN';
        rtw2.Weft__c = 'SATIN';
        rtw2.Craft__c = 'Block Print-Sanganeri';
        rtw2.Base_Colour__c = 'RED';
        rtw2.RTW_SIZE__c = 'XXL';
        rtw2.MFabric__c = 'Silk Cotton';
        rtw2.Season__c = 'FW21';
        rtw2.MRP_Pc__c = 1000;
        rtw2.Total_Costs__c = 2000;
        rtw2.Assigned_sourcing_user__c = userId;
        rtw2.Product_Stage__c = 'SOURCING';
        rtw2.SKU__c = 'BFW21FW0001XY34';
        //rtw2.Assigned_sourcing_user__c = userinfo.getUserId();
        rtwList.add(rtw2);
        
        RTW_Product__c rtw3 = new RTW_Product__c();
        rtw3.Name = 'test3';
        rtw3.RTW_Pricing_Submitted_Status__c = 'Pending';
        rtw3.vendor_custom__c = acc2.id;
        rtw3.Product__c = 'MASK';
        rtw3.Photo__c = '';
        // rtw.ImageLink__c=
        rtw3.SKU_Count__c=10;
        rtw3.Pack_no__c = '1';
        rtw3.Quantity__c=6;
        rtw3.MCost__c = 10;
        rtw3.Origin__c='jaipur';
        rtw3.sku__c = 'BFW21FW0001XY34';
        
        rtw3.Warp__c = 'SATIN';
        rtw3.Weft__c = 'SATIN';
        rtw3.Craft__c = 'Block Print-Sanganeri';
        rtw3.Base_Colour__c = 'RED';
        rtw3.RTW_SIZE__c = 'XXL';
        rtw3.MFabric__c = 'Silk Cotton';
        rtw3.Season__c = 'FW21';
        rtw3.MRP_Pc__c = 1100;
        rtw3.Assigned_sourcing_user__c = userId;
        rtw3.Product_Stage__c = 'SOURCING';
        rtw3.SKU__c = 'BFW21FW0001XY34';
        //rtw3.Assigned_sourcing_user__c = userinfo.getUserId();
        rtwList.add(rtw3);
        
        RTW_Product__c rtw4 = new RTW_Product__c();	
        rtw4.Name = 'test02';	
        rtw4.RTW_Pricing_Submitted_Status__c = 'Submitted';	
        rtw4.vendor_custom__c = acc2.id;	
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
        
        rtw4.Assigned_sourcing_user__c = userId;
        rtw4.Product_Stage__c = 'SOURCING';
        rtw4.SKU__c = 'BFW21FW0001XY34';
        // rtw4.Assigned_sourcing_user__c = userinfo.getUserId();
        rtwList.add(rtw4);
        
        insert rtwList;
        RTWProductupdateSourcingController rtwclss3 = new RTWProductupdateSourcingController();
        rtwclss3.ProductDownload();
        rtwclss3.ProductPDFDownload();
        rtwclss3.DocDwld();
        rtwclss3.ImageDwld();
        rtwclss3.ProductDateFilter();
        rtwclss3.ProdType = 'BLOUSE';
        rtwclss3.productTypeName = 'BLOUSE';
        rtwclss3.uniqueKeySet = new Set<String>{'Test'};
            RTWProductupdateSourcingController.StartDate = Date.newInstance(2021, 4,13 );
        RTWProductupdateSourcingController.EndDate = Date.newInstance(2021, 4, 15);
        
    }
}