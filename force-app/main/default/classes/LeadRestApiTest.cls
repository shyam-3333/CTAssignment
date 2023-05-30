@isTest
private class LeadRestApiTest {
   @TestSetup
    static void DataCreation(){
        TriggerStatus__c status = new TriggerStatus__c();
        status.Name = 'RollUpNoOfFiles';
        status.Active__c = False;
        insert status;
    }
    @isTest
    static void doPostPossitive() {
        LeadRestApi.LeadWrapper leadObj = new LeadRestApi.LeadWrapper();
        leadObj.firstName = 'First';
        leadObj.lastName = 'Last';
        leadObj.title = 'Salesforce Develeper';
        leadObj.companyname = 'Kvp';
        leadObj.emailAddress = 'pd123@kvpcorp.com';
        leadObj.message = 'This is test message';
        leadObj.phonNo = '5678948931';
        leadObj.location_latitude ='13.02439';
        leadObj.location_longitude ='13.02439';
        leadObj.LeadSource = 'TG-CG';
       // leadObj.image = Blob.valueOf('Test image');
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead'; 
        req.httpMethod = 'POST';
        String myJSON = JSON.serialize(leadObj);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
        Test.startTest();
        String  result = LeadRestApi.doPost();
        Test.stopTest();
    }   
    @isTest
    static void doPostNegative() {
        LeadRestApi.LeadWrapper leadObj = new LeadRestApi.LeadWrapper();
        leadObj.firstName = 'First';
        leadObj.firstName = null;
        leadObj.title = 'Salesforce Develeper';
        leadObj.companyname = 'Kvp';
        leadObj.emailAddress = 'test@kvpcorp.com';
        leadObj.message = 'This is test message';
        leadObj.phonNo = '5678948931';
    //    leadObj.image = Blob.valueOf('Test image');
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead'; 
        req.httpMethod = 'POST';
        String myJSON = JSON.serialize(leadObj);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
        Test.startTest();
        String  result = LeadRestApi.doPost();
        Test.stopTest();
    }
}