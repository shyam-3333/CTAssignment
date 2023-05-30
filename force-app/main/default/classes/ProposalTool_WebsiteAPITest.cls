@IsTest
public class ProposalTool_WebsiteAPITest {
    
    public class ProductMaster {
        
        DateTime startDate;
        DateTime endDate;
        String businessType;
        Integer batchCount;
        public ProductMaster(DateTime sD, Datetime eD, String rT, Integer bT)
        {
            startDate = sD;
            endDate = eD;
            businessType = rT;
            batchCount = bT;
        }
    }
    
    @isTest static void testEyewear(){
        Datetime dt1 = Datetime.now().AddDays(-1);
        Datetime dt2 = Datetime.now();
        System.debug('start----'+dt1);
        System.debug('end----'+dt2);
        Product_Master__c eyewearProduct = ProposalToolTestDataFactory.createProduct('Eyewear','Sunglasses');
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://titanlightningapps--propdev.my.salesforce.com/services/apexrest/ProposalToolAPI';
        request.httpMethod = 'POST';
      //  request.addHeader('Content-Type', 'application/json');
        ProductMaster pm1 = new ProductMaster(dt1, dt2, 'Eyewear', 200);
        
        String JSONString = SYSTEM.JSON.serialize(pm1);
        
        request.requestBody = Blob.valueOf(JSONString);
        RestContext.request = request;
        
        ProposalTool_WebsiteAPI.doPost();
        
    }
    
    @isTest static void testJewellery(){
        Datetime dt1 = Datetime.now().AddDays(-1);
        Datetime dt2 = Datetime.now();
        System.debug('start----'+dt1);
        System.debug('end----'+dt2);
        Product_Master__c jewelleryProduct = ProposalToolTestDataFactory.createProduct('Jewellery','Silver Coin');
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://titanlightningapps--propdev.my.salesforce.com/services/apexrest/ProposalToolAPI';
        request.httpMethod = 'POST';
      //  request.addHeader('Content-Type', 'application/json');
        ProductMaster pm1 = new ProductMaster(dt1, dt2, 'Jewellery', 200);
        
        String JSONString = SYSTEM.JSON.serialize(pm1);
        
        request.requestBody = Blob.valueOf(JSONString);
        RestContext.request = request;
        
        ProposalTool_WebsiteAPI.doPost();
        
    }
    
    @isTest static void testWatches(){
        Datetime dt1 = Datetime.now().AddDays(-1);
        Datetime dt2 = Datetime.now();
        System.debug('start----'+dt1);
        System.debug('end----'+dt2);
        Product_Master__c watchesProduct = ProposalToolTestDataFactory.createProduct('Watches','Bags');
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://titanlightningapps--propdev.my.salesforce.com/services/apexrest/ProposalToolAPI';
        request.httpMethod = 'POST';
      //  request.addHeader('Content-Type', 'application/json');
        ProductMaster pm1 = new ProductMaster(dt1, dt2, 'Watches', 200);
        
        String JSONString = SYSTEM.JSON.serialize(pm1);
        
        request.requestBody = Blob.valueOf(JSONString);
        RestContext.request = request;
        
        ProposalTool_WebsiteAPI.doPost();
     }
}