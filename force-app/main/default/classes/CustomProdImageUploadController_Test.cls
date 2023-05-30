@isTest
public class CustomProdImageUploadController_Test {
    public static testMethod void testCustomProdImageUploadController() {
        
        Product_Master__c pm = ProposalToolTestDataFactory.createProduct('Eyewear','Sunglasses');
        
        
        TriggerStatus__c ts = new TriggerStatus__c();
        ts.Name = 'RollUpNoOfFiles';
        ts.Active__c = true;
        insert ts;
        
        String fileId = '';
        
        CustomProductImageUploaderController.saveTheChunkFile(pm.Id, 'ABC', 'Test Attachment Body', 'Test', fileId);
    }
}