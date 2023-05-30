@isTest
public class ProposalToolWatchesBaseLinkingBatchTest {
    public static testMethod void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new AWSMockHttpResponseGenerator());
        
        ProposalToolWatchesBaseLinkingBatch es = new ProposalToolWatchesBaseLinkingBatch();
        
        Test.startTest();
        ProposalToolTestDataFactory.createAWSConfig('ProposalToolWatchesMasterDeltaBatch');
        
        ProposalToolTestDataFactory.createProductForAWS('Watches','Test');
        
        database.executeBatch(es,200);
        Test.stopTest();
    }
}