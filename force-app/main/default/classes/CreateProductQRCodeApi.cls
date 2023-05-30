/********************************************************************************
* Created by: Vinoth kumar A
* Crated on :02/08/2019
* Description: The scanned QR code from Json will be matched with the existing QR code of the product and captured in QR code scanned field. 
***********************************************************************************/
@RestResource(urlMapping = '/ProductQRCodeUpdate')
global class CreateProductQRCodeApi {
    public Static final RestRequest rq = RestContext.request;
    public Static final RestResponse res = RestContext.response;
    @HTTPPost
    global static void doPostProduct(){
        Map<String,String> responseValue = new Map<String,String>();
        try{
            Map<string,DateTime> QrCodeMap = new Map<string,DateTime>();
            List<Product__c> JsonDataString = new List<Product__c>();
            system.debug(rq.requestBody.toString());
            JsonDataString = (List<Product__c>) System.JSON.deserialize(rq.requestBody.toString(), List<Product__c>.Class);
            system.debug('Rest data:'+rq.requestBody.toString());
            system.debug('JsonDataString:'+JsonDataString);
            for(Product__c qr:JsonDataString){
                QrCodeMap.put(qr.QR_CODE__c, qr.QR_Code_Scanned_Date__c);
                system.debug('QrCodeMap:'+QrCodeMap);
            }
            CreateProductQRCodeApiBatch CPQR = new CreateProductQRCodeApiBatch(JsonDataString);
            Database.executeBatch(CPQR);
            responseValue.put('Status','Ok');
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(String.valueof(responseValue));
        } catch( exception e){
            system.debug('Error Line:'+e.getLineNumber()+'Error Message:'+e.getMessage());
            responseValue.put('Error Message',e.getMessage());
            res.statusCode = 400;
            res.responseBody = Blob.valueOf(String.valueof(responseValue));
        }
    }
    
}