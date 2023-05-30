trigger Qc_Component_Lightning_Trigger on QC_Components__c(before insert, after insert, before update, after update) {
    if(  TriggerExecutionController__c.getInstance('Qc_Component_Lightning_Trigger').TriggerIsActive__c)
    {
        System.debug('Testing Lightning Trigger');
    
        if(trigger.isBefore && trigger.isInsert){
            Qc_ComponentNewTriggerHandler.uniqueCheckOnInsert(trigger.new);
        }
        
        if(trigger.isupdate && trigger.isBefore){
            Qc_ComponentNewTriggerHandler.uniqueCheckOnUpdate(trigger.newMap,Trigger.oldMap);
        }
        
        if(Trigger.isAfter && Trigger.isUpdate){
            Qc_ComponentNewTriggerHandler.syncComponentData(Trigger.new, Trigger.oldMap);
        }

        if(trigger.isUpdate && trigger.isAfter){
            Qc_ComponentNewTriggerHandler.updateComponentApprovalStatus(trigger.newMap,trigger.oldMap); 
        }

        if( trigger.isupdate && trigger.isBefore )
        {
            Qc_ComponentNewTriggerHandler.updateComponentReportRefNumber(trigger.new,trigger.oldMap);
        }
        if( (trigger.isInsert || trigger.isupdate) && trigger.isBefore )
        {
            ComponentEmailSampleReceivedFromHandler.MultipleEmailAdd(Trigger.new);
        }
        

    }
}