/**************************************************
Created By :  Yarama Sujay Reddy
Created Date : 11/11/2022
Company Name : KVP Business Solutions Pvt Ltd.
Description :  Mock Callout Class for TaneiraResponsePOTest.
******************************************************/
@isTest
global class TaneiraResponsePOCalloutMock implements HttpCalloutMock{
  global HttpResponse respond(HTTPRequest req){
    HttpResponse res = new HttpResponse();
    res.setStatus('OK');
    res.setStatusCode(200);
    res.setBody('{"MT_Taneira_GetPODetailsResponse":{"POResponse":{"SerialNo":123,"PONo":"0101222242","Status":"S","StatusText":"Success"}}}');
    return res;
  }
}