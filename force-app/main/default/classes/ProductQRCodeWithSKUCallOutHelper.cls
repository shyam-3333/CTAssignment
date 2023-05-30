/********************************************************************************************
 * Created By : Vinoth Kumar A
 * Created On : 14/01/2020
 * Description : This API sends QR codes and SKU in the form of JSON.
 * ***********************************************************************************************/
public class ProductQRCodeWithSKUCallOutHelper {    
    
    public static void QRCodePostCallOut(List<Product__c> ProdList){
        
        List<string> QRCodeList = new List<string>();
        Map<string, string> QRCodeMap = new Map<string, string>();
        System.debug('ProdList:: '+ProdList);
        
        //Capturing all the QR codes
        for(Product__c pro : ProdList){
            if(pro.QR_CODE__c != null ){
                QRCodeList.addAll(pro.QR_CODE__c.split(','));
                for(string s : pro.QR_CODE__c.split(',')){
                    QRCodeMap.put(s,pro.SKU_Code__c);
                }
            }
        }
        string str = string.join(QRCodeList, ',');
        system.debug('QRCodeList:===='+QRCodeList);
        ProductQRCodeWithSKUCallOutHelper.QRCodePostCallOutFuture(QRCodeMap);
    }
    
    
    @future(callout = true)
    public static void QRCodePostCallOutFuture(Map<string,string> QRCodeMap){
        String qrCodewithSKU = '{"metadata" : {';
        integer i = 1;
        for(String eachQR : QRCodeMap.keyset()){
            if(i == QRCodeMap.size()){
                qrCodewithSKU = qrCodewithSKU+'"'+eachQR+'":"'+QRCodeMap.get(eachQR)+'"';
            } else {
                qrCodewithSKU = qrCodewithSKU+'"'+eachQR+'":"'+QRCodeMap.get(eachQR)+'",';
            }
            i++;
        }
        qrCodewithSKU = qrCodewithSKU+'}}';
        system.debug('Json data : ===='+qrCodewithSKU);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
    
            request.setEndpoint('https://taneiraqrscot.titan.in/api/v1/update_bulk_metadata');
   
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');
        request.setHeader('Username','taneira_sfdc');
        request.setHeader('Password','Taneira@321');
        String requestBody = qrCodewithSKU;
        System.debug('requestBody '+requestBody );
        //request.setTimeout(2 * 60 * 1000);
        System.debug(requestBody);
        request.setBody(requestBody);
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
            system.debug('response====='+response);
        } else {
            system.debug('response====='+response);
            System.debug(response.getBody());
        }
        
    }
}