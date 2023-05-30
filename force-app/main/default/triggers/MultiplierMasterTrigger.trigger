trigger MultiplierMasterTrigger on Multiplier_Value_Master__c (before insert, before update) {

    if(trigger.isInsert && trigger.isBefore){
        new GenerateMultiplierCombination().whileInsert(trigger.new);
    }
    if(trigger.isUpdate && trigger.isBefore){
        new GenerateMultiplierCombination().whileUpdate(trigger.new, trigger.oldMap);
    }
}