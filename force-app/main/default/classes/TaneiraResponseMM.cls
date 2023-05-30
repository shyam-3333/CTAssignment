/**************************************************
Created By :  Omprakash
Created Date : 22/09/2022
Company Name : KVP Business Solutions Pvt Ltd. 
Description : Rest Api Class Send Material Number(SKU_Code__c)  To sap And Get the responce Back And store the responce in SAP Information in product
******************************************************/
public class TaneiraResponseMM {
    //This is Sap endpoint URL in custom label is 'TaneriaMmSapresponceEndpointURL'.
    private static final String taneriaMmSapEndpointURL = system.Label.TaneriaMmSapresponceEndpointURL;   
    // Wrapper Class to Convert Material Number(SKU_Code__c) to Json
    public class RequestWrapper{
        public MaterialWrapper ItemRequest;
    }
    public class MaterialWrapper {
        public String Material;
    }
    // InvocableMethod is used because the List of products Id,s Are From Autolaunched Flow (	Send MM ItemRequest To SAP)
    @InvocableMethod(label = 'APICallOut' callout = 'true')
    public static void responseMM(List<Id> pid){
        try{
            List<RequestWrapper> reqList = new List<RequestWrapper>();
            List<MaterialWrapper> metList = new List<MaterialWrapper>();
            RequestWrapper  itemReq = new RequestWrapper();
            MaterialWrapper req = new MaterialWrapper();
           // System.debug(logginglevel.INFO, 'Inside responce ');
           // System.debug(logginglevel.INFO, pid);
            List<Product__c> pdList = [select id,Cluster__c,SKU_Code__c,Material_Description__c,Order_Id__c,Product_Hierarchy__c,
                                       Product_Category_Taneira__c,Unit_of_Measure__c from Product__c where id =: pid];
            List<Product__c> productToUpdate = new List<Product__c>();
            for(Product__c pd : pdList){
                //MaterialWrapper req = new MaterialWrapper();
                req.Material = pd.SKU_Code__c;
                //req.Material = 'SHT08A00777';
                itemReq.ItemRequest = req; 
                metList.add(req);
                reqList.add(itemReq);
                String jsonRequestBody = JSON.serialize(itemReq);
             //   system.debug(logginglevel.INFO, 'jsonRequestBody : ' + jsonRequestBody);
                HttpRequest request = new HttpRequest();
                request.setEndpoint(taneriaMmSapEndpointURL);
                request.setBody(JSON.serialize(itemReq));
                request.setMethod('POST');
                String username = system.label.TaneiraSapUserid;
                String password = System.label.TaneiraSapUserPassword;
                Blob headerValue = Blob.valueOf(username + ':' + password);
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                request.setHeader('Authorization', authorizationHeader);
                Http http = new Http();
                HTTPResponse response = http.send(request);
                //System.debug(response.getStatusCode()); 
                //system.debug(JSON.serialize(itemReq));
             //   System.debug(logginglevel.INFO, response.getBody());
                //string json = '{"Material_Code":"SHT07B02432","Status":"S","Status_Text":"Success","Created_Date":"2022-05-26","Created_Time":"11:40:51"}';
                ResponceWrapper myJSONInstance = (ResponceWrapper)system.JSON.deserialize(response.getBody(), ResponceWrapper.class);
                //Converting String value of Created_Date From the responce Json to date.
                Date createddt = Date.valueOf(myJSONInstance.MT_Taneira_GetItemDetailsResponse.ItemResponse.Created_Date);
                //Converting String value of Created_Time From the responce Json to Time.
                string sTime = myJSONInstance.MT_Taneira_GetItemDetailsResponse.ItemResponse.Created_Time;
                String[] strTimeSplit = sTime.split(':');
                Time timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0]) //hour
                                                   ,Integer.valueOf(strTimeSplit[1]) //min
                                                   ,0                                //sec
                                                   ,0);
                DateTime dt = DateTime.newInstance(createddt, timeChange);
                //System.debug(dt);
                if(pd.SKU_Code__c == myJSONInstance.MT_Taneira_GetItemDetailsResponse.ItemResponse.Material_Code){
                    Product__c prod = new Product__c();
                    prod.Id = pd.Id;
                    prod.Status__c = myJSONInstance.MT_Taneira_GetItemDetailsResponse.ItemResponse.Status;
                    prod.Status_Text__c = myJSONInstance.MT_Taneira_GetItemDetailsResponse.ItemResponse.Status_Text;
                    prod.Created_Date_And_Time__c = dt;
                    productToUpdate.add(prod);
                }
            }
            //Updating the product 
            update productToUpdate;
        }
        catch(Exception exp){
            System.debug(logginglevel.ERROR, 'exp.getLineNumber()'+exp.getLineNumber());
            System.debug(logginglevel.ERROR, 'exp.getMessage()'+exp.getMessage());
        }
    }
    // Wrapper Class to Convert responce Json to String 
    public with sharing class ResponceWrapper{
        public MT_Taneira_GetItemDetailsResponse MT_Taneira_GetItemDetailsResponse;
    }
    public with sharing class MT_Taneira_GetItemDetailsResponse {
        public ItemResponse ItemResponse{get;set;}
    }
    public with sharing class ItemResponse {
        public String Material_Code;
        public String Status;
        public String Status_Text;
        public String Created_Date;
        public String Created_Time;
    }
}