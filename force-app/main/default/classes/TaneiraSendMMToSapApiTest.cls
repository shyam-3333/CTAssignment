/**************************************************
Created By :  Omprakash
Created Date : 05/10/2022
Company Name : KVP Business Solutions Pvt Ltd. 
Description : Test Class for TaneiraSendMMToSapApi.  
******************************************************/
@isTest
public class TaneiraSendMMToSapApiTest {
    @isTest
    Static void SentMMtest(){
        //Creating test data.
        Vendor__c vc = new Vendor__c();
        vc.Name  ='Test';
        insert vc;
        TaneiraSendMMToSapApi sdmm = new TaneiraSendMMToSapApi();
        Product__c pd = new Product__c();
        pd.Name = 'V-9535-2040';
        pd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId() ;
        pd.Vendor_custom__c = vc.Id;
        pd.Vendor_name_Test__c = 'TEST Vendor';
        pd.Cluster__c = 'Nouveau';
        pd.Blouse_Type__c = 'Unstiched Blouse Piece';
        pd.Offline_Username__c = 'Abhilash Kumar Sinha_0';
        pd.Proc_Type__c = 'Vendor Co created';
        pd.Offline_Key__c = '0_0_1';
        pd.Product_Category_Taneira__c = 'SAREE';
        pd.Loom__c = 'No Loom';
        pd.Buyers_Cost__c =  2595;
        pd.Material_Wrap__c = 'Synthetic';
        pd.Taneira_Material_Weft__c = 'Crepe';
        pd.Workmanship__c = 'Embroidery';
        pd.Zari_Type__c  = 'No Zari';
        pd.Quantity__c = 5;
        pd.Comments__c = 'Test';
        pd.Created_From__c = 'Offline App';
        pd.Cost_Band__c = '';
        pd.Special_Request__c = false ;
        pd.Comment_for_Special_Request__c = '';
        pd.Base_Colour__c = 'Dk Blue';
        pd.Order_Id__c = '250222S/SYNT';
        pd.Kurta_Fabric__c = '';
        pd.Dupatta_Fabric__c = '';
        pd.Salwar_Fabric__c = '';
        pd.Sourcing_Type__c = 'Regular Production';
        pd.MRP_Reco__c = 'C';
        pd.MM_Sent__c = False;
        insert pd;
      //  System.debug(pd);
        Product__c pd1 = new Product__c();
        pd1.Name = 'V-9535-2040';
        pd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId() ;
        pd1.Vendor_custom__c = vc.Id;
        pd1.Vendor_name_Test__c = 'TEST Vendor';
        pd1.Cluster__c = 'Nouveau';
        pd1.Blouse_Type__c = 'Unstiched Blouse Piece';
        pd1.Offline_Username__c = 'Abhilash Kumar Sinha_0';
        pd1.Proc_Type__c = 'Vendor Co created';
        pd1.Offline_Key__c = '0_0_1';
        pd1.Product_Category_Taneira__c = 'SAREE';
        pd1.Loom__c = 'No Loom';
        pd1.Buyers_Cost__c =  2595;
        pd1.Material_Wrap__c = 'Synthetic';
        pd1.Taneira_Material_Weft__c = 'Crepe';
        pd1.Workmanship__c = 'Embroidery';
        pd1.Zari_Type__c  = 'No Zari';
        pd1.Quantity__c = 5;
        pd1.Comments__c = 'Test';
        pd1.Created_From__c = 'Offline App';
        pd1.Cost_Band__c = '';
        pd1.Special_Request__c = false ;
        pd1.Comment_for_Special_Request__c = '';
        pd1.Base_Colour__c = 'Dk Blue';
        pd1.Order_Id__c = '250222S/SYNT';
        pd1.Kurta_Fabric__c = '';
        pd1.Dupatta_Fabric__c = '';
        pd1.Salwar_Fabric__c = '';
        pd1.Sourcing_Type__c = 'Regular Production';
        pd1.MRP_Reco__c = 'C';
        pd1.MM_Sent__c = False;
        insert pd1;
        System.debug(pd1);
        Set<Id> pid = new Set<Id>();
        pid.add(pd.Id);
        pid.add(pd1.Id);
      //  System.debug(pid);
        //String Id = pd.id;
        TaneiraSendMMToSapApi.responceWrapper ress =  new TaneiraSendMMToSapApi.responceWrapper();
        TaneiraSendMMToSapApi.ItemheaderWrapper itemHeader = new TaneiraSendMMToSapApi.ItemheaderWrapper();
		TaneiraSendMMToSapApi.ItemItemDetailWrapper itemDetail = new TaneiraSendMMToSapApi.ItemItemDetailWrapper();
        List<Product__c> productToUpdate = new List<Product__c>();
        itemHeader.Plant = 'SIKA';
        itemHeader.Storage_Location = '1008';
        ItemHeader.Profit_center = pd.Cluster__c;
        itemDetail.Material_No = pd.SKU_Code__c;
        itemDetail.Material_Description = pd.Material_Description__c;
        itemDetail.Material_Group =pd.Product_Category_Taneira__c;
        itemDetail.ECOM_Material = pd.SKU_Code__c;
        itemDetail.Control_Code = pd.Control_Code__c;
        itemDetail.Product_Hierarchy = pd.Product_Hierarchy__c;
        itemDetail.UOM = pd.Unit_of_Measure__c;
        itemHeader.ItemDetail = itemDetail;
        ress.ItemHeader = itemHeader;
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = system.Label.TaneriaPoSapEndpointURL; 
        req.httpMethod = 'POST';
        String myJSON = JSON.serialize(ress);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TaneiraSendMMCalloutMock());
        TaneiraSendMMToSapApi.sendMMToSap(pid);
        Test.stopTest();
    }
}