trigger AccountDuplicateAvoid on Account (before insert, before update) {
    AccountTypeChange accType = new AccountTypeChange();
   
        if(trigger.isUpdate && trigger.isBefore){
            //acc.avoidDuplicateUpdate(trigger.new, trigger.oldMap);
            accType.prospectToCustomer(trigger.new, trigger.oldMap);
        }
        if(trigger.isInsert && trigger.isBefore){
          //  acc.avoidDuplicateInsert(trigger.new);
            system.debug('Before Insert');
            new AccountNameAndZipcodeDupllicate().whileInsert(trigger.new);
            new AccountNameAndZipcodeDupllicate().checkDuplicate(trigger.new);
        }
    
}