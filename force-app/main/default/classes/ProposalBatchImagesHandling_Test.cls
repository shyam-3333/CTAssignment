@isTest
public class ProposalBatchImagesHandling_Test {
        public static testMethod void testImagesHandling() {
            List<Product_Master__c> pList = new List<Product_Master__c>();
            Product_Master__c p1 = new Product_Master__c();
            
            p1.Images_1__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_2__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_3__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_4__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_5__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_6__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_7__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_8__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_9__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.Images_10__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p1.RecordTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Watches').getRecordTypeId();
                        
            Product_Master__c p2 = new Product_Master__c();
            p2.Images_1__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_2__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_3__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_4__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_5__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_6__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_7__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_8__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_9__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.Images_10__c = 'https://staticimg.titan.co.in/Tanishq/Catalog/51T557EABAAAP1_1.jpg';
            p2.RecordTypeId = Schema.SObjectType.Product_Master__c.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
                       
            pList.add(p1);
            pList.add(p2);
            insert pList;
            
            Test.startTest();
            Id batchId = Database.executeBatch(new ProposalTool_BatchClassForImagesHandling());
            Test.stopTest();
   }
}