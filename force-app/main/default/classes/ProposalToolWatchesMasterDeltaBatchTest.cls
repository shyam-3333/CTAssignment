@isTest
public class ProposalToolWatchesMasterDeltaBatchTest {
    public static testMethod void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new AWSMockHttpResponseGenerator());
        ProposalToolTestDataFactory.createAWSConfig('ProposalToolWatchesMasterDeltaBatch');
        
        ProposalToolWatchesMasterDeltaBatch bs = new ProposalToolWatchesMasterDeltaBatch('-11-30/');
        
        Test.startTest();
        database.executeBatch(bs,200);
        Test.stopTest();
    }
}