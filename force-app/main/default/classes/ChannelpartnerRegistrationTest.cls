@isTest
private class ChannelpartnerRegistrationTest {
    @isTest
    static void doPostPossitive() {
        ChannelpartnerRegistrationAPI.ChannelPartner CprObj = new ChannelpartnerRegistrationAPI.ChannelPartner();

        CprObj.City = 'Bng';
        CprObj.Email = 'Kvp@gmail.com';
        CprObj.FranchiseeName = 'Kvp';
        CprObj.FranchiseePhoneNo = '0123456789';
        CprObj.Message = 'Test';
        CprObj.RetailChannel = 'test';
        CprObj.State ='karnataka';
        CprObj.StoreCode ='ABL';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ChannelpartnerRegistrationAPI'; 
        req.httpMethod = 'POST';
        String myJSON = JSON.serialize(CprObj);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
        Test.startTest();
        String result = ChannelpartnerRegistrationAPI.doPost();
        Test.stopTest();
    }   
    @isTest
    static void doPostNegative() {
        ChannelpartnerRegistrationAPI.ChannelPartner CprObj = new ChannelpartnerRegistrationAPI.ChannelPartner();
        CprObj.City = 'Penukonda';
        CprObj.Email = 'Kvp@gmail.com';
        CprObj.FranchiseeName = 'Kvp';
        CprObj.FranchiseePhoneNo = '0123456789';
        CprObj.Message = 'Test';
        CprObj.RetailChannel = 'test';
        CprObj.State ='Andhra';
        CprObj.StoreCode = null;
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ChannelpartnerRegistrationAPI'; 
        req.httpMethod = 'POST';
        String myJSON = JSON.serialize(CprObj);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
        Test.startTest();
        String  result = ChannelpartnerRegistrationAPI.doPost();
        Test.stopTest();
    }
}