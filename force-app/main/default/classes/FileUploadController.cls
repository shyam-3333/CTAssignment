global with sharing class FileUploadController {
    
    @RemoteAction
    global static String attachBlob(String attachmentId, String fileName, String contentType, String base64BlobValue){
        System.debug('fileName-->'+fileName);
        String x=fileName.substring(0, fileName.indexOfAny('.'));
        Product__c ac = [Select Id,SKU_Code__c,QR_CODE_1__c,QR_CODE_2__c,QR_CODE_3__c from Product__c where QR_CODE_1__c LIKE : '%'+x+'%' OR QR_CODE_2__c LIKE : '%'+x+'%' OR QR_CODE_3__c LIKE : '%'+x+'%' OR SKU_Code__c LIKE : '%'+x+'%' limit 1];
        
        if(attachmentId == '' || attachmentId == null){
            Attachment att = new Attachment(
                ParentId = ac.Id,
                Body = EncodingUtil.Base64Decode(base64BlobValue),
                Name = fileName,
                ContentType = contentType
            );
            insert att;
            product__c pro = new product__c();
            if(att.id != null && ac.Id != null){
                pro.Id = ac.Id;
                pro.Photo__c = '<img src="' + URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + att.id + '"></img>';
                update pro; 
            }
            return att.Id;
            
        }else{
            for(Attachment atm : [select Id, Body from Attachment where Id = :attachmentId]){
                update new Attachment(Id = attachmentId, Body = EncodingUtil.Base64Decode(EncodingUtil.Base64Encode(atm.Body) + base64BlobValue));
            }
            
            return attachmentId;
        }
    }
}