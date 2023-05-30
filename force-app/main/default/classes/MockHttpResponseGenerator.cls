@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
       // System.assertEquals('http://example.com/example/test', req.getEndpoint());
       // System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('1000270118498484,Fastrack,FT-FICKS-1126095,Fastrack,31/05/2021,12:24:22,FT-FICKS-1117442,qcetpintguser,Fastrack CorpSales eGift Cards,GIFT CARD ACTIVATE,1000,2795,FICKS_1_279953,Transaction successful.,None,500,0,13/05/2022,8,Manual,15099301,{itemCode=NM3189KM01|groupCode=FT|clustercode=ANALG|amount=2795.00|payType=OP|qty=1}{Total Gross Amt~2795.0},306045807097\n1000270118498484,Fastrack,FT-FICKS-1126095,Fastrack,31/05/2021,12:24:22,FT-FICKS-1117442,qcetpintguser,Fastrack CorpSales eGift Cards,GIFT CARD REDEEM,-500,2795,FICKS_1_279953,Transaction successful.,None,500,0,13/05/2022,8,Manual,15099301,{itemCode=NM3189KM01|groupCode=FT|clustercode=ANALG|amount=2795.00|payType=OP|qty=1}{Total Gross Amt~2795.0},3060458070}');
        res.setStatusCode(200);
        return res;
    }
}