trigger CostBandMasterTrigger on Cost_Band_Master__c (before insert,before update) {

    if((trigger.isInsert || trigger.isUpdate) && trigger.isBefore){
        new CombinedKeyGeneration().generateCombination(trigger.new);
    }
    if(trigger.isInsert && trigger.isBefore){
        new DuplicateBandPrevention().whileInsert(trigger.new);
    }
    if(trigger.isUpdate && trigger.isBefore){
        new DuplicateBandPrevention().whileupdate(trigger.new,trigger.oldMap);
    }
    if(trigger.isInsert && trigger.isBefore){
        new CostBandSuggestion().suggestCostBand(trigger.new);
    }
  
}