trigger updatingPartProduct on SQX_Part__c (Before insert,Before update) {               
    If(Trigger.isBefore &&(trigger.isInsert || trigger.isUpdate)){
        //Call Handler.
        updatingPartProduct_Handler.updateParts(trigger.new);
        
    }
}