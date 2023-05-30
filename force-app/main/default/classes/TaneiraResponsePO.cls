/**************************************************
Created By :  Yarama Sujay Reddy
Created Date : 21/09/2022
Company Name : KVP Business Solutions Pvt Ltd. 
Description : Rest Api Class to Send Serial Number to sap and Get the responce back And store the responce in SAP Information Section in product
******************************************************/
public class TaneiraResponsePO {
//This is Sap endpoint URL in custom label is 'TaneiraResponsePOEndPointURL'.
private static final String taneriaPoSapEndpointURL = system.Label.TaneiraResponsePOEndPointURL; 
// Wrapper Class to Convert Serial Number to Json
public class RequestWrapper{
    public MaterialWrapper PORequest;
}
public class MaterialWrapper {
//  public String MaterialCode;
    public string SerialNo;
}
// InvocableMethod is used because the List of products Id,s Are From Autolaunched Flow (Send PO ItemRequest To SAP)
@InvocableMethod(label = 'API' callout = 'true')
public static void responsePO(List<Id> pid){
    List<RequestWrapper> reqList = new List<RequestWrapper>();
    List<MaterialWrapper> metList = new List<MaterialWrapper>();
    RequestWrapper  itemReq = new RequestWrapper();
    MaterialWrapper req = new MaterialWrapper();
 //   System.debug(logginglevel.INFO, 'Inside responce ');
  //  System.debug(logginglevel.INFO, pid);
    List<Product__c> pdList = [select id,SKU_Code__c, Sl_number__c from Product__c where id =: pid];
    List<Product__c> productToUpdate = new List<Product__c>();
    for(Product__c pd : pdList){
        //  MaterialWrapper req = new MaterialWrapper();
        // req.MaterialCode = pd.SKU_Code__c;
        req.SerialNo = pd.Sl_number__c;
        //req.SerialNo = 8747;
        itemReq.PORequest = req; 
        metList.add(req);
        reqList.add(itemReq);
        String jsonRequestBody = JSON.serialize(itemReq);
    //    system.debug(logginglevel.INFO, 'jsonRequestBody : ' + jsonRequestBody);
       	HttpRequest request = new HttpRequest();
        request.setEndpoint(taneriaPoSapEndpointURL);
        request.setBody(JSON.serialize(itemReq));
        request.setMethod('POST');
        String username = system.label.TaneiraSapUserid;
        String password = System.label.TaneiraSapUserPassword;
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
        Http http = new Http();
        HTTPResponse response = http.send(request);
      //  System.debug(logginglevel.INFO, response.getStatusCode()); 
        //system.debug(JSON.serialize(itemReq));
      //  System.debug(logginglevel.INFO, response.getBody());
        //string json = '{"Material_Code":"SHT07B02432","Status":"S","Status_Text":"Success","Created_Date":"2022-05-26","Created_Time":"11:40:51"}';
        ResponceWrapper myJSONInstance = (ResponceWrapper)system.JSON.deserialize(response.getBody(), ResponceWrapper.class);
        string  Serial_No = myJSONInstance.MT_Taneira_GetPODetailsResponse.POResponse.SerialNo;
        if(pd.Sl_number__c == Serial_No){
        //Updating the product 
            pd.PO_Status__c = myJSONInstance.MT_Taneira_GetPODetailsResponse.POResponse.Status;
           	pd.PO_StatusText__c = myJSONInstance.MT_Taneira_GetPODetailsResponse.POResponse.StatusText;
            pd.PO_Number__c = myJSONInstance.MT_Taneira_GetPODetailsResponse.POResponse.PONo;
            //Updating the product
           productToUpdate.add(pd);
        }
    }
    update productToUpdate;
}
// Wrapper Class to Convert responce Json to String
public with sharing class ResponceWrapper{
    public MT_Taneira_GetPODetailsResponse MT_Taneira_GetPODetailsResponse;
}    
public with sharing class MT_Taneira_GetPODetailsResponse{
    public POResponse POResponse{get;set;}
}
public with sharing class POResponse {
    public String Status;
	public String StatusText;
	public String SerialNo;
    public String PONo;
}
}