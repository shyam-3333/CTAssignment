/************************************************************************************
Created By: Samarth Hegade
@description: This is a scheduled Batch used to map L1L5 values to the product, Runs Daily to map upmapped products with matching L1L5 values
**************************************************************************************/

global class RP_General_L1L5Batch Implements Database.Batchable <sObject>,Schedulable {

	 global Database.QueryLocator start(Database.BatchableContext bc) {
         
        String query = 'SELECT Id,Fabric__c,Workmanship__c,Cluster__c,Zari_Type__c,L1L5Mapped__c from Product__c where L1L5Mapped__c = false';
        return Database.getQueryLocator(query);
        
    }
         
    global void execute (Database.BatchableContext bc, List<Product__c> scope) {
        List<L1_L5_Master__c> sortedL1L52 = new List<L1_L5_Master__c>();
        List<Product__c> scope1 = new List<Product__c>();
		List<Product__c> productToUpdate = new List<Product__c>();
		Set<string> forFab = new Set<string>();
        Set<string> forOrigin = new Set<string>();
		Set<string> forCraft = new Set<string>();
		Set<string> forZar = new Set<string>();
        Set<id> prodId = new Set<id>();
        

		for(Product__c pr : scope){
			if(pr.Fabric__c != null && pr.Cluster__c != null && pr.Zari_Type__c != null && pr.Workmanship__c != null){
				forFab.add(pr.Fabric__c.deleteWhitespace().toLowerCase());
				forOrigin.add(pr.Cluster__c.deleteWhitespace().toLowerCase());
				forZar.add(pr.Zari_Type__c.deleteWhitespace().toLowerCase());
				forCraft.add(pr.Workmanship__c.deleteWhitespace().toLowerCase());
			}
		}
		forFab.add('any');
        forOrigin.add('any');
        forCraft.add('any');
        forZar.add('any');
        sortedL1L52 = [SELECT Id,Fabric__c,Craft__c,Origin__c,Zari_Type__c,Active__c,L1__c,L2__c,L3__c,L4__c,L5__c from L1_L5_Master__c where Active__c = true AND fabric__c IN :forFab AND craft__c IN :forCraft AND Origin__c IN :forOrigin AND Zari_Type__c IN :forZar  order by Precedence__c ASC LIMIT 2000]; //Give batch size
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
    global void execute(SchedulableContext sc)

     {

         RP_General_L1L5Batch b = new RP_General_L1L5Batch();
    	 database.executeBatch(b);

     }

}