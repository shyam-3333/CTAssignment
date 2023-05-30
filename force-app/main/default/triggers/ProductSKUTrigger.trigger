trigger ProductSKUTrigger on Product_SKU__c (after insert,after update) {
    System.debug('System.isBatch()'+System.isBatch());
    if((Trigger.isUpdate || Trigger.isInsert) && Trigger.isAfter && !System.isBatch()){
        ProductSKUTriggerHandler.updateMaxSellebleSKUOnMaster(Trigger.new);
    }
}