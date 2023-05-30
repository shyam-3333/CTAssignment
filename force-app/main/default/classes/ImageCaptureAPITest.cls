@isTest
public class ImageCaptureAPITest {

    @isTest
   public static void doPostPossitive() {
       Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();
        pro.Name = 'Brown Saree';
       // pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.qr_code_1__c = '123';
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123; 
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Handloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Special_request__c=true;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Sync_Date__c=System.today();
        pro.Kurta_Fabric__c = 'Silk';
        pro.Dupatta_Fabric__c = 'silk';
        pro.Salwar_Fabric__c = 'silk';
        pro.QR_CODE__c = '123';
        insert pro;
       list<ImageCaptureAPI.ImageProductWrap> listToWS = new list<ImageCaptureAPI.ImageProductWrap>();
        ImageCaptureAPI.ImageProductWrap wrap1 = new ImageCaptureAPI.ImageProductWrap();
        ImageCaptureAPI.ImageWrap innerWrap = new ImageCaptureAPI.ImageWrap();
        innerWrap.Name = '123';
        innerWrap.ContentType = '.jpg';
        innerWrap.Body = 'Test blob data';
        innerWrap.SINO = '11';
        wrap1.ImageUpload = innerWrap;
       RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/InsertImages'; 
        req.httpMethod = 'POST';
       listToWS.add(wrap1);
        String myJSON = JSON.serialize(listToWS);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
       RestContext.response = res;
        Test.startTest();
        ImageCaptureAPI.doPost();
        Test.stopTest();
    }
}