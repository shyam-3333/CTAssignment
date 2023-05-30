/**************************************************
Created By :  Yarama Sujay Reddy
Created Date : 08/12/2022
Company Name : KVP Business Solutions Pvt Ltd.
Description : Mock Callout Class for TaneiraSentPOTest.
******************************************************/
@isTest
global class TaneiraSendPOCalloutMock implements HttpCalloutMock {
     global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(202);
        res.setBody('');
        return res;
    }
}