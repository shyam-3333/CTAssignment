trigger QC_InputDataTrigger on QC_Input_Data__c (after insert, after update) {
    system.debug('------QC_Input_Data__c -----------');
    if(Trigger.isAfter && Trigger.isInsert){
        QC_InputDataTriggerHandler.syncNewInputData(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        QC_InputDataTriggerHandler.syncUpdatedInputData(Trigger.new, Trigger.oldMap);
    }
}