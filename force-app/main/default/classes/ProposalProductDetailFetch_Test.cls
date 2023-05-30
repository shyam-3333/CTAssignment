@IsTest(seeAllData=false)
public class ProposalProductDetailFetch_Test {
    public static testMethod void coverWithProductMasterAndProductSKU(){
        //Eyewear
        Product_Master__c pm = ProposalToolTestDataFactory.createProduct('Eyewear','Sunglasses');
        ProposalProductDetailFetch.fetchProductDetail(pm.Id, false);
        update new Product_Master__c(attribute_set_name__c = 'Accessories',Id = pm.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm.Id, false);
        update new Product_Master__c(attribute_set_name__c = 'Contactlens',Id = pm.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm.Id, false);
        update new Product_Master__c(attribute_set_name__c = 'Frames',Id = pm.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm.Id, false);
        update new Product_Master__c(attribute_set_name__c = 'Lens Migrated',Id = pm.Id);
        List<ProposalProductDetailFetch.LabelValueWrapper> labelValue = ProposalProductDetailFetch.fetchProductDetail(pm.Id, false);
        
        System.assertEquals(labelValue[0].label, 'Sku');
        System.assertEquals(labelValue[0].value, '12345');
       
        
        //Watches
        Product_Master__c pm1 = ProposalToolTestDataFactory.createProduct('Watches','Bags');
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Belts',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Clocks',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Computer Glasses',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Earphones',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Face Mask',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Frames',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Gift Purchase',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Gift With Purchase',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'GiftCard',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Pop Socket',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Reusable',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Strap',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Straps',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Sunglasses',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Titan Sunglasses',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Wallets',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Watches',Id = pm1.Id);
        ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        update new Product_Master__c(Product_Category__c = 'Fragrances',Id = pm1.Id);
        List<ProposalProductDetailFetch.LabelValueWrapper> labelValue1 = ProposalProductDetailFetch.fetchProductDetail(pm1.Id, false);
        System.assertEquals(labelValue1[0].label, 'Sku');
        System.assertEquals(labelValue1[0].value, '12345');
        
        //Jewellery
        Product_Master__c pm2 = ProposalToolTestDataFactory.createProduct('Jewellery','Gold Coin');
        ProposalProductDetailFetch.fetchProductDetail(pm2.Id, false);
        update new Product_Master__c(categories__c = 'Silver coin',Id = pm2.Id);
        List<ProposalProductDetailFetch.LabelValueWrapper> labelValue2 = ProposalProductDetailFetch.fetchProductDetail(pm2.Id, false);
        System.assertEquals(labelValue2[0].label, 'Sku');
        System.assertEquals(labelValue2[0].value, '12345');
    }
}