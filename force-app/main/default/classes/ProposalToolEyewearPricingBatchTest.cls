@isTest
public class ProposalToolEyewearPricingBatchTest {
    public static testMethod void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new EyewearMockHttpResponseGenerator());
        
        ProposalToolEyewearPricingBatch es = new ProposalToolEyewearPricingBatch();
        
        Test.startTest();
        ProposalToolTestDataFactory.createAWSConfig('ProposalToolEyewearPricingBatch');
        
        ProposalToolTestDataFactory.createProductForAWS('Eyewear','Test');
        
        database.executeBatch(es,200);
        Test.stopTest();
    }
}