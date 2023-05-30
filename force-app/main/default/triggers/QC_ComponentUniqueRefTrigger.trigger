trigger QC_ComponentUniqueRefTrigger on QC_Components__c(before insert, after insert, before update, after update) {
    
    if(trigger.isBefore && trigger.isInsert){
       QC_ComponentTriggerHandler.uniqueCheckOnInsert(trigger.new);
    }
    
    if(trigger.isupdate && trigger.isBefore){
       QC_ComponentTriggerHandler.uniqueCheckOnUpdate(trigger.newMap,Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isInsert){
        QC_ComponentTriggerHandler.updateComponentPrefix(trigger.newMap); 
    }
    
    if(trigger.isUpdate && trigger.isBefore){
        QC_ComponentTriggerHandler.updateComponentApprovalStatus(trigger.new); 
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        QC_ComponentTriggerHandler.syncComponentData(Trigger.new, Trigger.oldMap);
    }
     
}