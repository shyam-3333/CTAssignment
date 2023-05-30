/************************************************************************************
Created By: Samarth Hegade
@description: This Batch is used to map L1L5 values to the respective 90 day old products with matching product catogery values and update L1 to L5 value if matched.

**************************************************************************************/
global class RP_L1_L5_MasterTriggerBatch Implements Database.Batchable <sObject> {
    
    Set<String> l1l5Ids = new Set<String>();
    public RP_L1_L5_MasterTriggerBatch(Set<String> l1l5Ids){
        this.l1l5Ids = l1l5Ids;
    }
    
    
	 global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id,Product_Category_1__c,Product_Category_2__c,Product_Category_3__c,Product_Category_4__c,Product_category_value_1__c,Product_category_value_2__c,Product_category_value_3__c,Product_category_value_4__c,Fabric__c,Craft__c,Origin__c,Zari_Type__c,Active__c,L1__c,L2__c,L3__c,L4__c,L5__c from L1_L5_Master__c where Active__c = true AND Id IN :l1l5Ids order by Precedence__c ASC';
        return Database.getQueryLocator(query);
    }
         
    global void execute(Database.BatchableContext bc, List<L1_L5_Master__c> sortedL1L52) {
        List<Product__c> scope = new List<Product__c>();
		List<Product__c> productToUpdate = new List<Product__c>();
        set<id> prodId = new set<id>();
        scope = [SELECT Id,Fabric__c,Workmanship__c,Cluster__c,Zari_Type__c from Product__c where L1L5Mapped__c = false AND CreatedDate = LAST_90_DAYS];
        for(integer i = 0; i < scope.size();i++ ){
            for(integer j = 0 ;j < sortedL1L52.size();j++){
                if(scope[i].Fabric__c != null && scope[i].Workmanship__c != null && scope[i].Cluster__c != null && scope[i].Zari_Type__c != null){
                 	string fab = scope[i].Fabric__c.deleteWhitespace().toLowerCase();
                    string cra = scope[i].Workmanship__c.deleteWhitespace().toLowerCase();
                    string ori = scope[i].Cluster__c.deleteWhitespace().toLowerCase();
                    string zar = scope[i].Zari_Type__c.deleteWhitespace().toLowerCase();
                    if((fab == sortedL1L52[j].fabric__c || sortedL1L52[j].fabric__c == 'any') && (cra == sortedL1L52[j].craft__c || sortedL1L52[j].craft__c == 'any') && (ori == sortedL1L52[j].origin__c || sortedL1L52[j].origin__c == 'any') && (zar == sortedL1L52[j].Zari_Type__c || sortedL1L52[j].Zari_Type__c == 'any') ){
                        if(prodId.contains(scope[i].Id)){
                            break;
                        }else{
                         	Product__c pr = new Product__c();
                            pr.Id =scope[i].Id ;
                            pr.L1__c = sortedL1L52[j].L1__c;
                            pr.L2__c = sortedL1L52[j].L2__c;
                            pr.L3__c = sortedL1L52[j].L3__c;
                            pr.L4__c = sortedL1L52[j].L4__c;
                            pr.L5__c = sortedL1L52[j].L5__c;
                            pr.L1L5Mapped__c = true;
                            productToUpdate.add(pr);
                            prodId.add(scope[i].Id);   
                        }
                	}
              	}                
            }
        }
		update productToUpdate;
    }
    
    global void finish (Database.BatchableContext bc) {
        
    }

}