@IsTest
private class ProductViewApiTest {

    @isTest static void testGetProduct() {
        AutoNumber__c atNum = new AutoNumber__c();
        atNum.Auto_Number__c = 0;
        atNum.Name = 'SKU_Number';
        insert atNum;
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();
        pro.Name = 'Test';
     //   pro.Account__c = acc.id;
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
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.MRP_Reco__c ='A';
        
        insert pro;
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://cs14.salesforce.com/services/apexrest/Product/'
            + pro.name;
        request.httpMethod = 'GET';
        request.addHeader('Content-Type', 'application/json');
        RestContext.request = request;
        ProductViewApi.doGet();
        
    }
}