trigger RollUpNoOfFiles on ContentDocumentLink (after insert,After delete) {
    system.debug('In trigger');
    if(trigger.isInsert && TriggerStatus__c.getInstance('RollUpNoOfFiles').Active__c){
     new RollUpNoOfFilesHelper().calculateNoOfFiles(trigger.new);
    }
}