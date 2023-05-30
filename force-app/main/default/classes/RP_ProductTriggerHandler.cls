/************************************************************************************
Created By: Samarth Hegade, Priyanka Dumane
@description: This handler is used to map L1L5 values to the product whenever a product with matching procuct category values with L1L5 master is inserted or updated
@description: This Handler Update Total Value In the Master
**************************************************************************************/

public with sharing class RP_ProductTriggerHandler {
    /* @description: This method will insert the Product records from trigger*/
    public static void updateL1_L5(List<Product__c> scope){
		List<L1_L5_Master__c> sortedL1L52 = new List<L1_L5_Master__c>();
		set<string> forFab = new set<string>();
        set<string> forOrigin = new set<string>();
		set<string> forCraft = new set<string>();
		set<string> forZar = new set<string>();
        set<id> prodId = new set<id>();
        for(product__c p : scope){
            if(p.Fabric__c != null){
                forFab.add(p.Fabric__c.deleteWhitespace().toLowerCase());	
            }
				
		}
        
        for(product__c p : scope){
            if(p.Cluster__c != null){
                forOrigin.add(p.Cluster__c.deleteWhitespace().toLowerCase());
            }
			
		}
        
        for(product__c p : scope){
            if(p.Zari_Type__c != null){
                forZar.add(p.Zari_Type__c.deleteWhitespace().toLowerCase());	
            }
				
		}
        
        for(product__c p : scope){
            if(p.Workmanship__c != null){
               forCraft.add(p.Workmanship__c.deleteWhitespace().toLowerCase()); 
            }
						
		}
        forFab.add('any');
        forOrigin.add('any');
        forCraft.add('any');
        forZar.add('any');
        
        sortedL1L52 = [SELECT Id,Fabric__c,Craft__c,Origin__c,Zari_Type__c,Active__c,L1__c,L2__c,L3__c,L4__c,L5__c,Precedence__c from L1_L5_Master__c where Active__c = true AND fabric__c IN :forFab AND craft__c IN :forCraft AND Origin__c IN :forOrigin AND Zari_Type__c IN :forZar WITH SECURITY_ENFORCED  order by Precedence__c ASC];
        
        if(sortedL1L52.size()>0){
            for(Product__c pr : scope){
             //system.debug('product test :'+ pr.Zari_Type__c);   
            for(integer j = 0 ;j < sortedL1L52.size();j++){
                if(pr.Fabric__c != null && pr.Workmanship__c != null && pr.Cluster__c != null && pr.Zari_Type__c != null){
                 	string fab = pr.Fabric__c.deleteWhitespace().toLowerCase();
                    string cra = pr.Workmanship__c.deleteWhitespace().toLowerCase();
                    string ori = pr.Cluster__c.deleteWhitespace().toLowerCase();
                    string zar = pr.Zari_Type__c.deleteWhitespace().toLowerCase();
                    
                    if((fab == sortedL1L52[j].fabric__c || sortedL1L52[j].fabric__c == 'any') && (cra == sortedL1L52[j].craft__c || sortedL1L52[j].craft__c == 'any') && (ori == sortedL1L52[j].origin__c || sortedL1L52[j].origin__c == 'any') && (zar == sortedL1L52[j].Zari_Type__c || sortedL1L52[j].Zari_Type__c == 'any') ){
                        if(prodId.contains(pr.Id) && prodId.size()>0){
                            break;
                        }else{
                            pr.L1__c = sortedL1L52[j].L1__c;
                            pr.L2__c = sortedL1L52[j].L2__c;
                            pr.L3__c = sortedL1L52[j].L3__c;
                            pr.L4__c = sortedL1L52[j].L4__c;
                            pr.L5__c = sortedL1L52[j].L5__c;
                            pr.L1L5Mapped__c = true;
                            if(pr.Id != null){
                             	prodId.add(pr.Id);   
                            }
                        }
                    }
              	}                
            }
         }
        }else{
            for(Product__c pr : scope){
                if(prodId.contains(pr.Id)){
                            break;
                        }else{
                            pr.L1__c = '';
                            pr.L2__c = '';
                            pr.L3__c = '';
                            pr.L4__c = '';
                            pr.L5__c = '';
                            pr.L1L5Mapped__c = false;
                            if(pr.Id != null){
                             	prodId.add(pr.Id);   
                            }
                        }
            }
        }
        
		
 }
    /* @description: This method will insert the Product records from trigger*/
    public static void updateTotalValueInMaster(List<Product__c> prodList){
        Set<String> setProductOrderId = new Set<String>();
        Decimal totalBuyerCost = 0.00;
        Decimal totalQuantity = 0;
        for(Product__c pro : prodList){
            if(pro.Order_Id__c != null){
                setProductOrderId.add(pro.Order_Id__c);
            }           
        } 
        if(!setProductOrderId.isEmpty()){
            List<Product__c> proListWithSameOrderId = [Select Id, Quantity__c, Buyers_Cost__c from Product__c where Order_Id__c IN: setProductOrderId WITH SECURITY_ENFORCED limit 40000];
            if(!proListWithSameOrderId.isEmpty()){
                for(Product__c pro : proListWithSameOrderId){
                    if(pro.Buyers_Cost__c != null){
                    totalBuyerCost = totalBuyerCost + pro.Buyers_Cost__c;
                    }
                    if(pro.Quantity__c != null){
                    totalQuantity = totalQuantity + pro.Quantity__c;
                    }
                }
            }
        }
        List<Master__c> masterList = new List<Master__c>();
        List<Master__c> masterWithSameOrderId = [Select Id, Total_Quantity__c, Total_Value__c from Master__c where Name IN: setProductOrderId and Active__c = true WITH SECURITY_ENFORCED];
        if(!masterWithSameOrderId.isEmpty()){
            for(Master__c m : masterWithSameOrderId){
                m.Total_Quantity__c = totalQuantity;
                m.Total_Value__c = totalBuyerCost;
                masterList.add(m);
            }
        }
        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, masterList, true);
        update masterList;
    }
}