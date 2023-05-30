trigger Project_Trigger on Project__c (before insert,after insert) {

    if(trigger.isAfter && trigger.isInsert){
        new ProjectTriggerHandler().createMillstones(trigger.new);
        new ProjectTriggerHandler().sendEmail(trigger.new);

    }
}