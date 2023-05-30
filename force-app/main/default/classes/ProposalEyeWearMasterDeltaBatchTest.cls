@isTest
public class ProposalEyeWearMasterDeltaBatchTest {
    public static testMethod void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new EyewearMockHttpResponseGenerator());
        
        ProposalToolEyeWearMasterDeltaBatch es = new ProposalToolEyeWearMasterDeltaBatch();
        
        Test.startTest();
        ProposalToolTestDataFactory.createAWSConfig('ProposalToolEyeWearMasterDeltaBatch');
        
        database.executeBatch(es,200);
        Test.stopTest();
    }
    
}