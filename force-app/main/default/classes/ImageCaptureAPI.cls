/*
Written by : Deepak singh
Date : 15/02/2021
Description : This webService will recieve images and product QR code from external system and inserts images under appropriate product in SF 
on the basis of QR code
*/
@RestResource(urlMapping = '/InsertImages')
global class ImageCaptureAPI {
    public Static RestResponse res = RestContext.response;
    //Wrapper class to deserialize JSON data
    global class ImageProductWrap{
        global string Username;//Username of logged in user in mobile app
        global string Vendor_Mobile;//Mobile number of vendor
        global string Vendor_Name;//Name of vendor
        global string Prod_ref_code;//Product refernce code
        global string Vendor_Id;//SF Id of vendor
        global boolean specialRequest;
        global string productLineItemId;//Mobile app Id of product
        global string Vendor_Prod_Code;//QR code of product
        global string Created_From;//Offline app
        global ImageWrap ImageUpload = new ImageWrap();
    }
    //Wrapper class to hold image details
    global class ImageWrap{
        global string SINO;
        global string Name;//ImageName
        global string ContentType;//.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm/m4a.mpeg
        global string Body;//blob_value
    }
    @HTTPPost
    global static void doPost() {
        map<string,string> responseValue = new map<string,string>();
        Blob_Data_Object__c obj= new Blob_Data_Object__c();
        obj.name='Image';
        insert obj;
        Attachment att1 = new Attachment();
        att1.Name='Att1.Image';
        att1.parentId=obj.Id;
        att1.Body=RestContext.request.requestBody;
        att1.ContentType='.txt';
        insert att1;
        Savepoint sp = DataBase.setSavepoint();
        try{
            list<ImageProductWrap> imageList = new list<ImageProductWrap>();
            system.debug('JSON body'+RestContext.request.requestBody.toString());
            imageList=(List<ImageProductWrap>)System.JSON.deserialize(RestContext.request.requestBody.toString(),List<ImageProductWrap>.class);
            System.debug('imageList: ' +imageList);
            set<string> qrCodes = new set<string>();
            for(ImageProductWrap imp : imageList){
                if(imp.ImageUpload.name != null){
                    qrCodes.add('%'+imp.ImageUpload.name+'%');
                }
            }   
            System.debug('qrCodes: ' +qrCodes);
            System.debug('Heap @ Start: ' + (Limits.getHeapSize()));
            System.debug('Heap @ Start1: ' + (Limits.getLimitHeapSize()));
            
            map<string,id> qrCodeWithId = new map<string,id>();
            for(product__c pro : [select id,qr_code_1__c,qr_code_2__c,qr_code_3__c from product__c where QR_CODE_1__c LIKE :qrCodes OR QR_CODE_2__c LIKE :qrCodes OR QR_CODE_3__c LIKE :qrCodes]){
                
                list<string> qrListTemp1 = new list<string>();
                list<string> qrListTemp2 = new list<string>();
                list<string> qrListTemp3 = new list<string>();
                list<string> finalQRcodes = new list<string>();
                string qrTemp2;
                string qrTemp3;
                string qrTemp1 = pro.QR_CODE_1__c;
                qrListTemp1 = qrTemp1.split(',');
                finalQRcodes.addAll(qrListTemp1);
                if(pro.QR_CODE_2__c != null){
                    qrTemp2 = pro.QR_CODE_2__c;
                    qrListTemp2 = qrTemp2.split(',');
                }
                if(pro.QR_CODE_3__c != null){
                    qrTemp3 = pro.QR_CODE_3__c;
                    qrListTemp3 = qrTemp3.split(',');
                }
                
                finalQRcodes.addAll(qrListTemp2);
                finalQRcodes.addAll(qrListTemp3);
                for(string str :finalQRcodes){
                    if(qrCodes.contains('%'+str+'%')){
                        qrCodeWithId.put(str,pro.Id);
                    }
                }
            }
            map<id,attachment> attachmentMap = new map<id,attachment>();
            for(ImageProductWrap imp : imageList){
                Attachment attach = new Attachment();
                attach.Name = imp.ImageUpload.Name+imp.ImageUpload.ContentType;
                // attach.ContentType=img.ContentType;
                attach.Body = EncodingUtil.base64Decode(imp.ImageUpload.Body);
                attach.isPrivate = false;
                if(qrCodeWithId.containsKey(imp.ImageUpload.Name)){
                    attach.ParentId = qrCodeWithId.get(imp.ImageUpload.Name);
                    attachmentMap.Put(qrCodeWithId.get(imp.ImageUpload.Name),attach);
                }
                
            }
            insert attachmentMap.values();
            list<product__c> updateProducts = new list<product__c>();
            for(id ids :attachmentMap.keyset()){
                Product__c pro = new Product__c();
                pro.Id = ids;
                if(attachmentMap.containsKey(ids)){
                    pro.Photo__c = '<img src="' + URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + attachmentMap.get(ids).id + '"></img>';
                }
                updateProducts.add(pro);
                System.debug('Heap @ Start2: ' + (Limits.getHeapSize()));
                System.debug('Heap @ Start3: ' + (Limits.getLimitHeapSize()));
            }
            update updateProducts;
            responseValue.put('Status','Ok');
            responseValue.put('Status code','0');
            responseValue.put('message','Image inserted successfully');
            system.debug('res===>'+res);
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(json.serialize(responseValue));
            
        }
        catch(Exception e){
            responseValue.put('Error Message',e.getMessage());
            responseValue.put('Error ine',String.valueOf(e.getLineNumber()));
            responseValue.put('Status','Fail');
            responseValue.put('Status code','400');
            responseValue.put('message','Image insertion failed');
            res.statusCode = 400;
            res.responseBody = Blob.valueOf(json.serialize(responseValue));
            Database.RollBack(sp);
        }
    }
}