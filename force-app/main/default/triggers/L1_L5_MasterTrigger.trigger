trigger L1_L5_MasterTrigger on L1_L5_Master__c (before insert,before Update,after update,after insert) {
   
    if(Trigger.isBefore && (Trigger.isInsert)){
        RP_L1_L5_MasterTriggerHandler.createUniqueKey(Trigger.new);
    }
    
    if(Trigger.isAfter && (Trigger.isInsert)){
        Set<String> l1L5Ids = new Set<String>();
        for(L1_L5_Master__c master :  trigger.new){
            l1L5Ids.add(master.Id);
        }
        
        RP_L1_L5_MasterTriggerBatch b = new RP_L1_L5_MasterTriggerBatch(l1L5Ids);
        database.executeBatch(b);
    }
   
}