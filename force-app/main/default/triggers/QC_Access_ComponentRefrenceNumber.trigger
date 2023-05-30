trigger QC_Access_ComponentRefrenceNumber on QC_Access_Component__c (before insert,after insert,before update,after update) {
    if(trigger.isInsert && trigger.isAfter){
        QC_Access_ComponentTriggerHandler.updateCompPrefix(trigger.newMap);
    }
}