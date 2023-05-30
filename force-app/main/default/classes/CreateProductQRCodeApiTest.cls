@isTest
private class CreateProductQRCodeApiTest {
 
    @isTest static void productQRCode(){
        
        TriggerExecutionController__c TTT = new TriggerExecutionController__c();
        ttt.Name = 'ProdDuplicateCheck';
        ttt.TriggerIsActive__c = true;
        insert ttt;
        
        TriggerExecutionController__c TTT12 = new TriggerExecutionController__c();
        ttt12.Name = 'QRcodeAPI';
        ttt12.TriggerIsActive__c = true;
        insert ttt12;
        
        TriggerExecutionController__c eee = new TriggerExecutionController__c();
        eee.TriggerIsActive__c = true;
        eee.Name = 'ProductTriggerHandlerUpdate';
        insert eee;
        
        
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
        tt.TriggerIsActive__c = true;
        tt.Name = 'ProductSuggestedMRPHelper';
        insert tt;
        
        Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Account acc = new Account();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        acc.RecordTypeId = recordTypeIdAcc;
        insert acc;
        
        Master__c m2 = new master__c();
        m2.Active__c = true;
        m2.Code__c = 'T';
        m2.Name = 'Trading';
        m2.Name__c = 'Proc-Type';
        insert m2;
        Master__c m3 = new master__c();
        m3.Active__c = true;
        m3.Code__c = 'S';
        m3.Name__c = 'Product Category';
        m3.Name = 'sare';
        insert m3;

        Master__c m1 = new master__c();
        m1.Active__c = true;
        m1.Code__c = 'H';
        m1.Name__c = 'Loom';
        m1.Name = 'Handloom';
 
        insert m1;     
        
        AutoNumber__c A1 = new AutoNumber__c();
        A1.Auto_Number__c = 5;
        A1.Loom__c = 'Handloom';
        A1.Proc_Type__c = 'Trading';
        A1.Product_Category__c = 'sare';
        A1.Name = 'SHT';
        insert A1;
        
        TriggerExecutionController__c TG1 = new TriggerExecutionController__c();
        TG1.Name = 'ProductTriggerHandlerInsert';
        TG1.TriggerIsActive__c = true;
        insert TG1;
        
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();
        pro.Name = 'Brown sare';
        pro.Account__c = acc.id;
        pro.RecordTypeId = recordTypeId;
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
        pro.Product_Category_Taneira__c ='sare';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Special_request__c=true;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Sync_Date__c=System.today();
        pro.QR_CODE__c = '8974563210';
      //insert pro;
        list<product__c> proList = new list<product__c>();
        proList.add(pro);
        insert proList;
        
       RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
		Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         req.addHeader('httpMethod', 'POST');
         req.requestUri = '/services/apexrest/ProductQRCodeUpdate';       
         String postData = '[{"QR_CODE__c":"8974563210","QR_Code_Scanned_Date__c":"2011-07-31T19:43:37"}]';
         //String JsonMsg=JSON.serialize(postData);
         req.requestBody = Blob.valueof(postData);
         RestContext.request = req; 
         RestContext.response= res;
        Test.setMock(HttpCalloutMock.class, new ProductQRCodeWithSKUCallOutHelperMock() );
       Test.startTest();
        ProductQRCodeWithSKUCallOutHelper.QRCodePostCallOut(proList);
        CreateProductQRCodeApi.doPostProduct();
        Test.stopTest();
    }
    
}