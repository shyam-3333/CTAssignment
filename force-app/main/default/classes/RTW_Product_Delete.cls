/*********************************************************************
Created by :Vinoth Kumar
Created on : 06/04/2020
Description : Updates the other related products sku count when the product is deleted
**********************************************************************/
public class RTW_Product_Delete {
    public static void DeleteMethod(Map<id,RTW_Product__c> prodMap){
        Set<string> ProdKeySet = new Set<string>();
        List<RTW_Product__c> proList = new List<RTW_Product__c>();
        system.debug('prodMap.values()'+prodMap.values().size());
        for(RTW_Product__c pro : prodMap.values()){
            ProdKeySet.add(pro.name);
        }
        for(RTW_Product__c prod : [SELECT Id, name,SKU_Count__c FROM RTW_Product__c WHERE name IN : ProdKeySet]){
            if(prod.SKU_Count__c != null){
                prod.SKU_Count__c = prod.SKU_Count__c - 1;
            	proList.add(prod);
            }
            
        }
        if(!proList.isEmpty()){
            update proList;
        }
    }
}