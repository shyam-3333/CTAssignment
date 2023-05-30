/*
Created By Deepak Singh
Description: Generation of combined key
*/
public class CombinedKeyGeneration {
    
    public void generateCombination(list<Cost_Band_Master__c> newlist){
        for(Cost_Band_Master__c cb : newList){
            if(cb.Origin__c != null && cb.Fabric__c != null && cb.Occasion__c != null && cb.Zari_Type__c != null){
                string comb = cb.Origin__c+cb.Fabric__c+cb.Occasion__c+cb.Zari_Type__c;
                cb.combinedKey__c = comb.toUpperCase();
            }
        }
    }
}