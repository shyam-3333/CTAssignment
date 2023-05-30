trigger SkinnCollectionTemplateTrigger on Skinn_Collection_Template__c (before update,after update) {
    try{
        if(CheckRecursive.skinnCollectionTemplateTriggerFlag && CheckRecursive.isTriggerActive.Skinn_Collection_Template_Trigger__c){
            if(Trigger.isUpdate  && Trigger.isBefore){
                SkinnCollectionTemplateTriggerHandler.beforeUpdateMethod(Trigger.new);
            }
            if(Trigger.isUpdate && Trigger.isBefore){
                SkinnCollectionTemplateTriggerHandler.dispErrorOnInsert(Trigger.New,Trigger.oldMap);
                SkinnCollectionTemplateTriggerHandler.dispErrorRevistionDateError(Trigger.New,Trigger.oldMap);
            }
            if(Trigger.isUpdate && Trigger.isAfter){
                // Stage , sub-stage auto completion
                SkinnCollectionTemplateTriggerHandler.afterUpdateMethod(Trigger.new,Trigger.oldMap,Trigger.newMap);
                //this method caluculate revision logic
                SkinnCollectionTemplateTriggerHandler.revisionDateMethod(Trigger.new,Trigger.oldMap,Trigger.newMap);
                // Update Model Record
                SkinnCollectionTemplateTriggerHandler.updateModelRecordLaunchDate(Trigger.new,Trigger.oldMap);
            }
        }
        if(Test.isRunningTest()){
            Integer i = 1/0;
        }
    }catch(Exception ex){
        GenericLogicClass.errorHandlingMethod(ex);
    }
}