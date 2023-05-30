/**
 * Created By: Priyanka Dumane
 * @description : This apex controller class will display the detailed summary of RangePlan associated to searched order Id.
 */
public with sharing class RangePlanSummary {
        /**
     * @description Method used to fetch details of Rangle Plan of seached order id
     * @param  textkey
     * @return List<MasterDataWrapper>
     */
    @AuraEnabled
    public static List<MasterDataWrapper> fetchRangePlan(String textkey)
    {
        textkey = textkey.trim();
        String orderRecordId;
        Decimal actualProcured = 0;
        Decimal actualProcuredValue = 0;
        List<RangePlan_Master__c> rangePlanList = new List<RangePlan_Master__c>();
        List<MasterDataWrapper> masterDataList = new List<MasterDataWrapper>();
        Map<String,Product__c> mapOfProducts = new Map<String,Product__c>();
        Map<String,Decimal> mapofProductQuantity = new Map<String,Decimal>();
        Map<String,Decimal> mapofProductProcurementCost = new Map<String,Decimal>();
        
        if(textkey != '')
        {
            List<Master__c> masterList = [Select Id,Total_Quantity__c,Total_Value__c from Master__c WHERE Active__c = True AND Name =: textkey WITH SECURITY_ENFORCED limit 1];   
            
            for(Product__c product : [Select Id,L1__c,L2__c,L3__c,L4__c,Quantity__c,Procurement_Cost__c	from Product__c  where Order_Id__c =:textkey WITH SECURITY_ENFORCED]){
                String key = product.L1__c+product.L2__c+product.L3__c+product.L4__c;
                key = key.toUpperCase();
                mapOfProducts.put(key,product);//---------------------------A3 - 2
                // Product Quantity
                if(mapofProductQuantity.containskey(key)){
                    Decimal productQuantity = 0.00;
                    productQuantity = mapofProductQuantity.get(key) + product.Quantity__c;
                    mapofProductQuantity.put(key,productQuantity);
                }
                else{
                    mapofProductQuantity.put(key,product.Quantity__c);
                }
                // Product Procurement Cost
                if(mapofProductProcurementCost.containskey(key)){
                    Decimal productProcurementCost = 0.00;
                    productProcurementCost = mapofProductProcurementCost.get(key) + product.Procurement_Cost__c;
                    mapofProductProcurementCost.put(key,productProcurementCost);
                }
                else{
                    mapofProductProcurementCost.put(key,product.Procurement_Cost__c);
                }               
            }
            if(masterList.size() > 0)
            {
                for(Master__c m : masterList)
                {
                    orderRecordId = m.Id;
                    actualProcured = m.Total_Quantity__c;
                    actualProcuredValue = m.Total_Value__c;
                }
            }
        }       
        if(orderRecordId != null){
            rangePlanList = [SELECT Id, Name,Order_ID__c,L1__c,L2__c,L3__c,L4__c,Price_Band__c,Cost_Band__c,Average_Cost__c,
                             Total_Order_Quantity__c,Order_Value__c,Remark__c FROM RangePlan_Master__c WHERE Order_ID__c =: orderRecordId and Active__c = true WITH SECURITY_ENFORCED];
            
        }
        if(!rangePlanList.isEmpty()){
            for(RangePlan_Master__c rp : rangePlanList){
                MasterDataWrapper masterData = new MasterDataWrapper();
                String key = rp.L1__c+rp.L2__c+rp.L3__c+rp.L4__c;
                key = key.toUpperCase();
                if(mapOfProducts.containsKey(key)){
                    masterData.orderId = rp.Id;
                    masterData.l1 = rp.L1__c;  
                    masterData.l2 = rp.L2__c;  
                    masterData.l3 = rp.L3__c;  
                    masterData.l4 = rp.L4__c;  
                    masterData.priceBand = rp.Price_Band__c;
                    masterData.costBand = rp.Cost_Band__c;  
                    masterData.averageCost = rp.Average_Cost__c;  
                    masterData.totalOrderQuantity = rp.Total_Order_Quantity__c;  
                    masterData.orderValue = rp.Order_Value__c;  
                    masterData.remarks = rp.Remark__c;  
                    masterData.actualProcured = mapofProductQuantity.get(key);
                    masterData.actualProcuredValue = mapofProductProcurementCost.get(key);
                    //Total order quantity - actual procured
                    if(rp.Total_Order_Quantity__c != null){
                        masterData.balance_Quantity = rp.Total_Order_Quantity__c - mapofProductQuantity.get(key);
                        if(masterData.balance_Quantity < 0 ){
                            masterData.cssRedIndicatorQuantity =  'slds-text-color_error';
                        }
                        else if(masterData.balance_Quantity >= 0 ){
                            masterData.cssRedIndicatorQuantity =  'slds-text-color_default';
                        }
                    }
                    else {
                        masterData.balance_Quantity = 0 - mapofProductQuantity.get(key);
                        if(masterData.balance_Quantity <= 0 ){
                            masterData.cssRedIndicatorQuantity =  'slds-text-color_error';
                        }
                    }
                    //order value - actual procured value
                    if(rp.Order_Value__c != null){
                        masterData.balance_Cost = rp.Order_Value__c - mapofProductProcurementCost.get(key);
                        if(masterData.balance_Cost < 0 ){
                            masterData.cssRedIndicatorCost =  'slds-text-color_error';
                        }
                        else if(masterData.balance_Cost >= 0 ){
                            masterData.cssRedIndicatorCost =  'slds-text-color_default';
                        }             
                    }
                    else {
                        masterData.balance_Cost = 0 - mapofProductProcurementCost.get(key);
                        if(masterData.balance_Cost <= 0 ){
                            masterData.cssRedIndicatorCost =  'slds-text-color_error';
                        }
                    }                
                    masterDataList.add(masterData);
                }else{
                    masterData.orderId = rp.Id;
                    masterData.l1 = rp.L1__c;  
                    masterData.l2 = rp.L2__c;  
                    masterData.l3 = rp.L3__c;  
                    masterData.l4 = rp.L4__c;  
                    masterData.priceBand = rp.Price_Band__c;
                    masterData.costBand = rp.Cost_Band__c;  
                    masterData.averageCost = rp.Average_Cost__c;  
                    masterData.totalOrderQuantity = rp.Total_Order_Quantity__c;  
                    masterData.orderValue = rp.Order_Value__c;  
                    masterData.remarks = rp.Remark__c;  
                    masterData.actualProcured = 0;
                    masterData.actualProcuredValue = 0;
                    
                    if(rp.Total_Order_Quantity__c != null){
                        masterData.balance_Quantity = rp.Total_Order_Quantity__c - 0;
                        if(masterData.balance_Quantity < 0 ){
                            masterData.cssRedIndicatorQuantity =  'slds-text-color_error';
                        }
                        else if(masterData.balance_Quantity >= 0 ){
                            masterData.cssRedIndicatorQuantity =  'slds-text-color_default';
                        }
                    }
                    else {
                        masterData.balance_Quantity = 0 - 0;
                        if(masterData.balance_Quantity <= 0 ){
                            masterData.cssRedIndicatorQuantity =  'slds-text-color_error';
                        }
                    }                    
                    if(rp.Order_Value__c != null){
                        masterData.balance_Cost = rp.Order_Value__c - 0;
                        if(masterData.balance_Cost < 0 ){
                            masterData.cssRedIndicatorCost =  'slds-text-color_error';
                        }
                        else if(masterData.balance_Cost >= 0 ){
                            masterData.cssRedIndicatorCost =  'slds-text-color_default';
                        }             
                    }
                    else {
                        masterData.balance_Cost = 0 - 0;
                        if(masterData.balance_Cost <= 0 ){
                            masterData.cssRedIndicatorCost =  'slds-text-color_error';
                        }
                    }                     
                    masterDataList.add(masterData);
                }               
            }
            return masterDataList;   
        }
        else{
            return masterDataList;
        }       
    }   
    /**
     * @description This is a wrapper class for Order Id table values
     */
    public class MasterDataWrapper{
        @AuraEnabled public String orderId = '';
        @AuraEnabled public String l1 = '';
        @AuraEnabled public String l2 = '';
        @AuraEnabled public String l3 = '';
        @AuraEnabled public String l4 = '';
        @AuraEnabled public String priceBand = '';
        @AuraEnabled public String costBand = '';
        @AuraEnabled public Decimal averageCost = 0.00;  
        @AuraEnabled public Decimal totalOrderQuantity = 0.00;      
        @AuraEnabled public Decimal actualProcured = 0.00;      
        @AuraEnabled public Decimal balance_Quantity = 0.00;
        @AuraEnabled public Decimal orderValue = 0.00;
        @AuraEnabled public Decimal actualProcuredValue = 0.00;   
        @AuraEnabled public Decimal balance_Cost = 0.00;
        @AuraEnabled public String remarks = '';       
        @AuraEnabled public String cssRedIndicatorQuantity = '';
        @AuraEnabled public String cssRedIndicatorCost = '';       
    }
}