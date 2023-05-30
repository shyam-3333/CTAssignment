/*
Created By Deepak Singh
Description: Validation for duplicate cost band from same combined key
*/
public class DuplicateBandPrevention {
    
    public void whileInsert(list<Cost_Band_Master__c> newlist){
        set<string> combinations = new set<string>();
        for(Cost_Band_Master__c cb :[select id,combinedKey__c,Band__c from Cost_Band_Master__c]){
            combinations.add(cb.combinedKey__c+cb.Band__c);
        }
        for(Cost_Band_Master__c cb : newList){
            if(combinations.contains(cb.combinedKey__c+cb.Band__c)){
                cb.addError('Duplicate band from current combined key');
            }
        }
    }
    public void whileUpdate(list<Cost_Band_Master__c> newlist,map<id,Cost_Band_Master__c> oldMap){
        boolean isChanged = false;
        for(Cost_Band_Master__c cb : newList){
            if(cb.Band__c != oldMap.get(cb.id).Band__c || cb.combinedKey__c != oldMap.get(cb.Id).combinedKey__c){
                isChanged = true;
            }
        }
        if(isChanged){
            set<id> newIds = new set<id>();
            set<string> combinations = new set<string>();
            
            for(Cost_Band_Master__c cb : newList){
                newIds.add(cb.id);
            }
            for(Cost_Band_Master__c cb :[select id,combinedKey__c,Band__c from Cost_Band_Master__c where id NOT IN :newIds]){
                combinations.add(cb.combinedKey__c+cb.Band__c);
            }
            for(Cost_Band_Master__c cb : newList){
                if(combinations.contains(cb.combinedKey__c+cb.Band__c)){
                    cb.addError('Duplicate band from current combined key');
                }
            } 
        }
        
        
    }
}