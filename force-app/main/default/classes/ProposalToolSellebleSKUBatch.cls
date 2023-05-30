public class ProposalToolSellebleSKUBatch implements Database.Batchable<sObject> {
    
    Set<String> productSKUIds;
    Boolean isManualRun = false;
    
    public ProposalToolSellebleSKUBatch(Set<String> productSKUIds,Boolean isManualRun){
        this.productSKUIds =productSKUIds;        
        this.isManualRun = isManualRun;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('productSKUIds'+productSKUIds);
        String query = '';
        
        if(isManualRun){
            query = 'Select Id,Business_Unit__c,Product_Master__c,Offer_price__c,sku__c,List_Price__c from Product_SKU__c';
            
        }else{
            query = 'Select Id,Business_Unit__c,Product_Master__c,Offer_price__c,sku__c,List_Price__c from Product_SKU__c where Id In : productSKUIds';
            
        }
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Product_SKU__c> skuList) {
        try {
            
            // process each batch of records default size is 200
            Set<String> productMasterIdSet = new Set<String>();
            List<Product_Master__c> productMaster = new List<Product_Master__c>();
            for(Product_SKU__c sku : skuList){
                if(sku.Product_Master__c != null){
                    productMasterIdSet.add(sku.Product_Master__c);
                }
            }
            System.debug('productMasterIdSet'+productMasterIdSet);
            
            for(Product_Master__c master : [SELECT Id,All_Images__c,images__c,RecordType.Name,(Select Id,Business_Unit__c,Offer_price__c,sku__c,Base_Sku__c,List_Price__c from Product_SKUs1__r where List_Price__c >= 1 Order BY List_Price__c DESC LIMIT 1) FROM Product_Master__c where Id In :productMasterIdSet ]){
                List<Product_SKU__c> skuData= new List<Product_SKU__c>();
                skuData.addAll(master.Product_SKUs1__r);
                if(!skuData.isEmpty()){     
                    if(master.RecordType.Name =='Eyewear'){
                        if(master.images__c != '' && master.images__c != null){
                            productMaster.add(new Product_Master__c(Id=master.Id,Sellable_SKU__c =skuData[0].sku__c,List_Price__c = skuData[0].List_Price__c,Offer_price__c = skuData[0].Offer_price__c,Product_To_Show__c =true,Record_Sent__c = true));
                        }else{
                            productMaster.add(new Product_Master__c(Id=master.Id,Sellable_SKU__c =skuData[0].sku__c,List_Price__c = skuData[0].List_Price__c,Offer_price__c = skuData[0].Offer_price__c,Product_To_Show__c =false,Record_Sent__c = false));
                        }
                    }else if(master.RecordType.Name =='Watches'){
                        if(master.All_Images__c != '' && master.All_Images__c != null){
                            productMaster.add(new Product_Master__c(Id=master.Id,Sellable_SKU__c =skuData[0].sku__c,List_Price__c = skuData[0].List_Price__c,Offer_price__c = skuData[0].Offer_price__c,Product_To_Show__c =true,Record_Sent__c = true));
                        }else{
                            productMaster.add(new Product_Master__c(Id=master.Id,Sellable_SKU__c =skuData[0].sku__c,List_Price__c = skuData[0].List_Price__c,Offer_price__c = skuData[0].Offer_price__c,Product_To_Show__c =false,Record_Sent__c = false));
                        }
                    }else if(master.RecordType.Name =='Jewellery'){
                        if(master.All_Images__c != '' && master.All_Images__c != null){
                            productMaster.add(new Product_Master__c(Id=master.Id,Sellable_SKU__c =skuData[0].sku__c,List_Price__c = skuData[0].List_Price__c,Offer_price__c = skuData[0].Offer_price__c,Product_To_Show__c =true,Record_Sent__c = true));
                        }else{
                            productMaster.add(new Product_Master__c(Id=master.Id,Sellable_SKU__c =skuData[0].sku__c,List_Price__c = skuData[0].List_Price__c,Offer_price__c = skuData[0].Offer_price__c,Product_To_Show__c =false,Record_Sent__c = false));
                        }    
                    }
                    
                }
            }
            
            if(!productMaster.isEmpty()){
                Database.update(productMaster);
            }
            
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    public void finish(Database.BatchableContext BC) {
    }
}