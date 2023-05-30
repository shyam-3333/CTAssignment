@isTest
global class LitmusCalloutMock implements HttpCalloutMock {
	
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(' {"code":0,"data":{"code":0}}');
        //response.setBody('{"message":"Questionnaires Response Created Successfully","Status Code":"200"}');
        response.setStatusCode(200);
        return response; 
    }
}