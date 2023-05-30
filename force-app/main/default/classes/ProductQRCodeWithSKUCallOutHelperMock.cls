@isTest
 global class ProductQRCodeWithSKUCallOutHelperMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
      //  System.assertEquals('https://taneiraqrscot.titan.in/api/v1/update_bulk_activation', req.getEndpoint());
       // System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"success": true,"message": "Records Updated!","modified": 1}');
        res.setStatusCode(200);
        return res;
    }
}




/*
'{"success": true,"message": "Records Updated!","modified": 1}'

*/