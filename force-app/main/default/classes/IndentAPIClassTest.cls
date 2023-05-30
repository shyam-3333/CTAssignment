@isTest(SeeAllData=false)
private class IndentAPIClassTest {
    @isTest static void testGetCaseById() {
        RestRequest request = new RestRequest();
        request.requestBody = BLOB.valueOf('[{"Insti_ref": "2021/57781","Amount_Received": "12345","Bank_Name": "SBI","Payment_Type": "Advance","Payment_Mode": "RTGS","Bank_Location": "North","RTGS_No": "1010ABC"}]');
        request.requestUri ='https://titanlightningapps--newdev.my.salesforce.com/services/apexrest/PaymentTracker';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestResponse res = new RestResponse();
        RestContext.response = res;
        System.assertEquals('POST', request.httpMethod);
        IndentAPIClass.doPost();
    }
}