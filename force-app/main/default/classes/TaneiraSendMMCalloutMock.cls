/**************************************************
Created By :  Omprakash
Created Date : 08/12/2022
Company Name : KVP Business Solutions Pvt Ltd.
Description : Test class for TaneriaSendMM Mock Callout 
******************************************************/
@isTest
global class TaneiraSendMMCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(202);
        res.setBody('');
        return res;
    }

}