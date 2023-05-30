/**************************************************
Created By :  Yarama Sujay Reddy
Created Date : 15/09/2022
Company Name : KVP Business Solutions Pvt Ltd.
Description : Rest Api Class To Send Products From Product Update View Page To SAP When Ever User Clicks Sent PO.               
******************************************************/
public with sharing class TaneiraSentPOApi {
    //Serial Number in spreedsheet Of Product Update View Page
    public string slno;
    //The EndPoint url of SAP in Custom Label is "TaneriaPoSapEndpointURL".
    private static final String taneriaPoSapEndpointURL = system.Label.TaneriaPoSapEndpointURL;
    // Wrapper Class to Convert PO Details in a Json format.
    Public class ResponceWrapper{
        public ItemheaderWrapper ItemHeader;
    }
    public class ItemheaderWrapper{
        public String Plant;//SIKA
        public String Storage_Location;//1008
        public String Vendor_Code;//Vendor_code__c
        public String Purchase_Group;//SAR
        public String Product_type;
        public string SerialNo;
        public List<ItemDetailsWrapper> ItemDetails;
    }
    public class ItemDetailsWrapper {
        public String Item_No;
        public String Material_Code;//SKU_Code__c
        public Decimal PO_Quantity;//Quantity__c
        public Decimal Net_Price;//Procurement_Cost__c
        public DATE Delivery_Date;
        public String Tax_Code;//GT
        public String Reqmt_No;//Cluster__c
        public String Requisitioner;//Order_Id__c
        
    }
    public static void sentPO(Set<Id> pid, string slno){
        try{
           // System.debug(logginglevel.INFO, 'size: '+pid.size());
            decimal itemNo = 1;
            //List<RequestWrapper> reqList = new List<RequestWrapper>();
            id prdId = new List<id>(pid).get(0);
            Product__c prd = [select id,Vendor_code__c from  Product__c where Id =: prdId];
            ResponceWrapper ress = new ResponceWrapper();
            ItemheaderWrapper itemHead = new ItemheaderWrapper();
            itemHead.Plant = 'SIKA';
            itemHead.Storage_Location = '1008';
            itemHead.Vendor_Code = prd.Vendor_code__c;
            itemHead.Purchase_Group = 'SAR';
            itemHead.Product_type = '';
            itemHead.SerialNo = slno;
            
            List<Product__c> pdList = [select id,SKU_Code__c,Product_Category_Taneira__c,Vendor_code__c,Unit_of_Measure__c,Product_Hierarchy__c,
                                       Material_Description__c,Cluster__c,Order_Id__c,Quantity__c,Procurement_Cost__c from Product__c where Id =: pid];
            list<ItemDetailsWrapper> itemDetailsList = new List<ItemDetailsWrapper>();
            for(Product__c pd : pdList){
                string itemNoStr = String.valueOf(itemNo);
                //Creating the Instance of Wrapper Class
                
                ItemDetailsWrapper itemDetails = new ItemDetailsWrapper();
                itemDetails.Item_No = itemNoStr;
                itemDetails.Material_Code = pd.SKU_Code__c;
                itemDetails.PO_Quantity = pd.Quantity__c;
                itemDetails.Net_Price = pd.Procurement_Cost__c;
                itemDetails.Delivery_Date = Date.today() + 90;
                itemDetails.Tax_Code = 'GT';
                itemDetails.Reqmt_No = pd.Cluster__c;
                itemDetails.Requisitioner = pd.Order_Id__c;
                itemDetailsList.add(itemDetails);
                itemNo++;
            }
            itemHead.ItemDetails = itemDetailsList;
            ress.ItemHeader = itemHead;
          //  system.debug(logginglevel.INFO, ress);
           // System.debug(logginglevel.INFO, 'JSON BODY' + ress);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(taneriaPoSapEndpointURL);
            request.setBody(JSON.serialize(ress));
            request.setMethod('POST');
            String username = system.label.TaneiraSapUserid;
            String password = System.label.TaneiraSapUserPassword;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            request.setHeader('Authorization', authorizationHeader);
            Http http = new Http();
            request.setTimeout(5000);                           
            HTTPResponse res = http.send(request);
         //   System.debug(logginglevel.INFO, res.getStatusCode());
         //   system.debug(logginglevel.INFO, JSON.serialize(ress));
            
            List<Product__c> productToUpdate = new List<Product__c>();
            list<Product__c> plist = [Select id, Sl_number__c, Delivery_Date__c, Product_Key_Finder__c from Product__c where Id =: pid];
            for(Product__c pd : plist){
                pd.Sl_number__c = slno;
                pd.Delivery_Date__c = Date.today() + 90;
                productToUpdate.add(pd);
           //     system.debug(logginglevel.INFO, pd.Sl_number__c);
            }
            update productToUpdate;
        }
        //Exception handling.
        catch(Exception ex){
            System.debug(logginglevel.ERROR, 'Message ouccure'+ex.getMessage());
            System.debug(logginglevel.ERROR, 'Message line number'+ex.getLineNumber());
        }
    }
}