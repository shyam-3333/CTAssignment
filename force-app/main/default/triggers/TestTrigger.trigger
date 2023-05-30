trigger TestTrigger on ContentDocument (After insert,before delete) {
    
    If(trigger.isDelete && TriggerStatus__c.getInstance('TestTrigger').Active__c==true){
        system.debug('In if of trigger');
        new RollUpNoOfFilesHelper().decrementWhileDelete(trigger.old);
    }
}