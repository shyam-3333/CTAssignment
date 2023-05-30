@isTest(SeeAllData = false)
public class ProposalToolProductFetchControllerTest {
    @isTest
    private static void fetchProductCoverageForEyewearData(){
        StaticResource ctcSR = [SELECT Id, Body FROM StaticResource WHERE Name = 'ProposalTestDataJSON' LIMIT 1];
        String jsonData = ctcSR.Body.toString();
        List<String> data= jsonData.split('\\$');
        
        
        String watchesRecordsTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Watches').getRecordTypeId();
        String jewelRecordsTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        
        Product_Master__c product = ProposalToolTestDataFactory.createProduct('Eyewear','Sunglasses');
        ProposalToolProductFetchController.fetchProducts('Eyewear',1,60,data[0]);
        
        update new Product_Master__c(Id=product.Id,attribute_set_name__c='Mask');
        ProposalToolProductFetchController.fetchProducts('Eyewear',1,60,data[1]);
        ProposalToolProductFetchController.fetchProducts('Eyewear',1,60,data[2]);
        
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Bags');
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[3]);
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[4]);
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Belts');
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[5]);
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Clocks');
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[6]);
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Earphones');
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[7]);
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Fragrances');
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[8]);
        update new Product_Master__c(Id=product.Id,RecordTypeId=watchesRecordsTypeId,Product_Category__c='Watches');
        ProposalToolProductFetchController.fetchProducts('Watches',1,60,data[9]);
        
        update new Product_Master__c(Id=product.Id,RecordTypeId=jewelRecordsTypeId,categories__c='Silver Coin');
        ProposalToolProductFetchController.fetchProducts('Jewellery',1,60,data[10]);
        ProposalToolProductFetchController.fetchProducts('Jewellery',1,60,data[11]);
        
        
        ProposalToolProductFetchController.createImageUniqueRecord('81928912');
        
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'RollUpNoOfFiles';
        tt.Active__c = true;
        insert tt;
        TriggerStatus__c tt1 = new TriggerStatus__c();
        tt1.Name = 'TestTrigger';
        tt1.Active__c = true;
        insert tt1;
        String cartData = '[{"productId":"'+product.Id+'","productIdForCart":"'+product.Id+'Cart"'+',"productImage":"Test.jpg","quantity":2,"productName":"Test","productBrand":"ALPINA","productFullName":"Test","productListPrice":62900,"productOfferPrice":62900,"percentageValue":0,"sellebleSKU":"AL372N4S6"}]';
        ProposalToolProductFetchController.generateProposal(cartData,'','j000000BTAjEAO',false);
        
        Blob beforeblob=Blob.valueOf('Test');
        
        ContentVersion cv = new ContentVersion();
        cv.title = 'testCV';      
        cv.PathOnClient ='test';           
        cv.VersionData =beforeblob;          
        insert cv;         
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];
        ProposalToolProductFetchController.contentVersionProcessToAttachments(new List<String>{testContent.ContentDocumentId},product.Id,product.Id);
        System.assertEquals('Sunglasses', product.categories__c);
        System.assertEquals('testCV', cv.Title);

        
    }    
}