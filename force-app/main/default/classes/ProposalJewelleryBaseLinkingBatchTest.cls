@isTest
public class ProposalJewelleryBaseLinkingBatchTest {
    public static testMethod void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new JewelMockHttpResponseGenerator());
        
        ProposalToolJewelleryBaseLinkingBatch es = new ProposalToolJewelleryBaseLinkingBatch();
        
        Test.startTest();
        ProposalToolTestDataFactory.createAWSConfig('ProposalToolJewelleryBaseLinkingBatch');
        
        ProposalToolTestDataFactory.createProductForAWS('Jewellery','Test');
        
        database.executeBatch(es,200);
        Test.stopTest();
    }
}