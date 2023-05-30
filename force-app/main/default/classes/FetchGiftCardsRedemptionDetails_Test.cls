@isTest
public class FetchGiftCardsRedemptionDetails_Test {
    public static testMethod void testschedule() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://example.com/example/test');
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
		Test.StartTest();
		FetchGiftCardsDetailsFromAWS testsche = new FetchGiftCardsDetailsFromAWS();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
	}
}