/**************************************************
Name:RTWProductSourcingController_Test
Author:Vindya
******************/

@istest
public class RTWProductSourcingController_Test {
    @isTest
    public static void TestRTW_Sourcing_ControllerBlouseMethod1()
    {
        vendor__c acc = new vendor__c(Name='TestAccount',Phone_No__c = '87941312132',Mail_ID__c = 'deepak@gmail.com');
        insert acc;
        RTW_Product__c rtwprod1 =  new RTW_Product__c(Name='BLOUSE',RTW_Pricing_Submitted_Status__c='Pending',Product__c='BLOUSE',Product_Stage__c='SOURCING',vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',PO_Number__c=345,MFabric__c = 'Cotton',Collection__c='Core wear',Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,MCost__c=456,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod1;
        
        RTW_Product__c rtwprod2 =  new RTW_Product__c(Name='BLOUSE',RTW_Pricing_Submitted_Status__c='Pending',Product__c='BLOUSE',Product_Stage__c='SOURCING', vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',PO_Number__c=345,MFabric__c = 'Cotton',Collection__c='Festive Wear',Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,MCost__c=456,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod2;
        
        RTW_Product__c rtwprod3 =  new RTW_Product__c(Name='BLOUSE',RTW_Pricing_Submitted_Status__c='Pending',Product__c='BLOUSE',Product_Stage__c='SOURCING',vendor_custom__c = acc.Id, Base_Colour__c='BaseCol3',PO_Number__c=345,MFabric__c = 'Cotton',Collection__c='Festive Wear',Craft__c='BATIK',Form__c='F1',MRP_Pc__c=123,MCost__c=456,Quantity__c=2,Season__c='FW19',Warp__c='Cotton123',Weft__c='Cotton123',Gender__c='Male',Okhai_Size__c='OS2',Size__c='S1',STYLE__c='Style1',Style_Code__c='StyleCode1',Year_of_Design__c=2020,Total_Costs__c=200);
        insert rtwprod3;   
        
        
        
       //RTWProductSourcingController.ProductKey='BLOUSE';
       //RTWProductSourcingController.ProductKey
       //RTWProductSourcingController.copyValue = 'MRP_Pc__c';
         RTWProductSourcingController rtwcat= new RTWProductSourcingController();
        rtwcat.selectedCategoryUser=userinfo.getUserId();
        rtwcat.checkSourcingUser = true;
        
      
        rtwcat.productTypeName ='BLOUSE';
         rtwcat.copyValue ='MRP_Pc__c';
         rtwcat.ProductKey ='BLOUSE';
        rtwcat.fetchData();
        rtwcat.doSave();
        //rtwcat.onchangemultiplier();
        //rtwcat.onchangeActualMrp();
        //rtwcat.doassignback();
        rtwcat.doSubmit();
        rtwcat.doCopy();
        rtwcat.copyValue = 'PO_Number__c';
        rtwcat.doCopy();
        rtwcat.copyValue = 'MCost__c';
        rtwcat.doCopy();
        rtwcat.copyValue = 'MRP_Pc__c';
        rtwcat.doCopy();
        //RTWProductSourcingController.copyValue = 'Multiplier__c';
        //rtwcat.copyAll();
        //new RTWProductSourcingController().setNearestvalue(2000,100);
              
        
    }
}