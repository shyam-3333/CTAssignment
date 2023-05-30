public class ProductSKUTriggerHandler {
    
    public static void updateMaxSellebleSKUOnMaster(List<Product_SKU__c> productSKUList){
        Set<String> skuIds = new Set<String>();
        for(Product_SKU__c sku : productSKUList){
            if(sku.List_price__c != null && sku.sku__c != null){
                skuIds.add(sku.Id);
            }
        }
        if(!skuIds.isEmpty()){
            Database.executeBatch(new ProposalToolSellebleSKUBatch(skuIds,false),1000);
        }
    }
}