trigger updatingPartProduct on SQX_Part__c (Before insert,Before update) {               
    If(Trigger.isBefore &&(trigger.isInsert || trigger.isUpdate)){
        
        updatingPartProduct_Handler.updateParts(trigger.new);
        //This will call by Handler
        
    }
}