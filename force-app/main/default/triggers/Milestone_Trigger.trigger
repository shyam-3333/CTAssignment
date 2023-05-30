trigger Milestone_Trigger on Milestone__c (before insert,after update,before update) {
     
    if(trigger.isAfter && trigger.isUpdate && CheckRecursive.runOnce()){
        System.debug('Start of After Update Trigger');
        new Milestone_Trigger_Handler().changeMilstone(trigger.new,trigger.oldMap);
      //  new Milestone_Trigger_Handler2().sendEmailWithAttachment(Trigger.new);
        System.debug('End of After Update Trigger');
    }
    if(trigger.isBefore && trigger.isUpdate){
        System.debug('Start of Before Update Trigger');        
        new Milestone_Trigger_Handler1().validateStatus(trigger.new,trigger.oldMap);
        System.debug('End of Before Update Trigger');        
    }
  
}