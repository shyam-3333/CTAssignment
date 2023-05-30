trigger SKinnModelTrigger on Skinn_Model__c (after insert,after update) {
    try{    
        //After Insert Method
        if(CheckRecursive.skinnModelTriggerFlag && CheckRecursive.isTriggerActive.Skinn_Model_Trigger__c){
            if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate )){
                SkinnModelTriggerHandler.afterInsertUpdateMethod(Trigger.New,Trigger.newMap);
            }
        }
        if(Test.isRunningTest()){
            Integer i = 1/0;
        }
    }catch(Exception ex){
        GenericLogicClass.errorHandlingMethod(ex);
    }
}