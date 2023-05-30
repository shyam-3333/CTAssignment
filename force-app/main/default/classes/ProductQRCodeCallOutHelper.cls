/********************************************************************************************
 * Created By : Vinoth Kumar A
 * Created On : 22/8/2019
 * Description : This API sends QR codes in the form of list.
 * ***********************************************************************************************/
public class ProductQRCodeCallOutHelper {
    
    public static void QRCodePostCallOut(List<Product__c> ProdList){
        
        List<string> QRCodeList = new List<string>();
        set<id> proIds = new set<id>();
        System.debug('ProdList:: '+ProdList);
        
        //Capturing all the QR codes
        for(Product__c pro : ProdList){
            proIds.add(pro.Id);
            if(pro.QR_CODE__c != null){
                QRCodeList.addAll(pro.QR_CODE__c.split(','));  
            }
        }
        string str = string.join(QRCodeList, ',');
        system.debug('QRCodeList:===='+QRCodeList);
        ProductQRCodeCallOutHelper.QRCodePostCallOutFuture(QRCodeList,proIds);
    }
    
    
    @future(callout = true)
    public static void QRCodePostCallOutFuture(List<string> QRCodeList , set<id> productIds){
        list<product__c> productsToUpdate = new list<product__c>();
        for(id proI : productIds){
            product__c pro = new product__c();
            pro.Id = proI;
            pro.QR_code_sent__c = true;
            productsToUpdate.add(pro);
        }
      //  update productsToUpdate;
        String qrCode = '';
        integer i = 0;
        for(String eachQR : QRCodeList){
         if(i == QRCodeList.size()-1)
         qrCode +='"'+eachQR + '"';
         else
         qrCode +='"'+eachQR + '",';
        i++;
        }
        system.debug('qrCode=-=-=-'+qrCode);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://taneiraqrscot.titan.in/api/v1/update_bulk_activation');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');
        request.setHeader('Username','taneira_sfdc');
        request.setHeader('Password','Taneira@321');
        String requestBody = '{"code_list":['+qrCode+'], "isActive" : "true"}';
        System.debug('requestBody '+requestBody );
        //request.setTimeout(2 * 60 * 1000);
        System.debug(requestBody);
        request.setBody(requestBody);
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            update productsToUpdate;
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
            system.debug('response====='+response);
        } else {
            system.debug('response====='+response);
            System.debug(response.getBody());
        }
        
    }
}