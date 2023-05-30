/**************************************************
Created By :  Omprakash
Created Date : 06/10/2022
Company Name : KVP Business Solutions Pvt Ltd.
Description : Test class for TaneriaresponseMM Mock Callout 
******************************************************/
@isTest
global class TaneiraResponseMMCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(202);
        res.setBody('{"MT_Taneira_GetItemDetailsResponse":{"ItemResponse":{"Material_Code":"SHT07B02432","Status":"S","Status_Text":"Success","Created_Date":"2022-05-26","Created_Time":"11:40:51"}}}');
        return res;
    }
}