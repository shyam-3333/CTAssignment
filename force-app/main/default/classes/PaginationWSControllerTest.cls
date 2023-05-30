@isTest
public class PaginationWSControllerTest {
    
    @isTest
    public static void testPaginationWS() {
       List<Product__c> prods = new List<Product__c>();
       //  Map<String,object> dataMap = new Map<String,Object>();
        String productRecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        //<Product__c> prod = new <Product__c>();
        Product__c prod = new Product__c(); 
        prod.Name = 'TEST PROD';
        prod.RecordTypeId = productRecordTypeId;
        prod.Product_Category_Taneira__c = 'Saree';
        prods.add(prod);
        insert prods;
       // String jsonInput = '{"data": [{"Vendor_Prod_Code": "abc", "Quantity": 1}]}';
       // String jsonInput = '{\n' + ' "Vendor_Prod_Code": "TestProd11",\n' + ' "Proc_Type": "Trading",\n' + ' "Username": "ishasahu@titan.co.in.taneiraqa",\n' + '  "Loom": "Handloom",\n' + '  "Product_Category": "Saree",\n' + '  "Vendor_Name": "abc company"\n' + '}';
        String jsonInput =  '{"lastProdId": null, "limit": 20}';
        
        RestRequest request1 = new RestRequest();
        request1.requestUri ='/services/apexrest/ProductDetails';
        request1.httpMethod = 'POST';
        RestContext.request = request1;
        request1.requestBody = Blob.valueOf(jsonInput); 
        RestResponse res1 = new RestResponse();
        RestContext.response = new RestResponse();
        PaginationWSController.sendProducts();
        
        jsonInput =  '{"lastProdId": "'+prods[0].Id+'", "limit": 20}';
        request1 = new RestRequest();
        request1.requestUri ='/services/apexrest/ProductDetails';
        request1.httpMethod = 'POST';
        RestContext.request = request1;
        request1.requestBody = Blob.valueOf(jsonInput); 
        res1 = new RestResponse();
        RestContext.response = new RestResponse();
        PaginationWSController.sendProducts();
        
        request1 = new RestRequest();
        request1.requestUri ='/services/apexrest/ProductDetails';
        request1.httpMethod = 'GET';
        RestContext.request = request1;
        res1 = new RestResponse();
        RestContext.response = new RestResponse();
        PaginationWSController.sendProductsAsGet();
        
        request1 = new RestRequest();
        request1.requestUri ='/services/apexrest/ProductDetails/?lastProdId='+prods[0].Id+'&ProductCategory=Saree&vendor=ABC&Proc-Type=ABB&Origin=AAA&srch=qqq';
        request1.httpMethod = 'GET';
        RestContext.request = request1;
        res1 = new RestResponse();
        RestContext.response = new RestResponse();
        PaginationWSController.sendProductsAsGet();
    }
}