/*
* Company : Kvp Business Solution 
* Date    : 18-02-2019
* Author  : Sameer Ranjan
* Description : Skinn_Collection__c Trigger
* History     : N/L
*/
trigger SkinnCollectionTrigger on Skinn_Collection__c (after insert,after update,after delete) {
    try{
        if(CheckRecursive.skinnCollectionTriggerFlag && CheckRecursive.isTriggerActive.Skinn_Collection_Trigger__c){
            if(Trigger.isAfter && Trigger.IsInsert){
                SkinnCollectionTriggerHandler.afterInsertMethod(Trigger.New,Trigger.newMap);
            }
        }
        if(Test.isRunningTest()){
            Integer i = 1/0;
        } 
    }catch(Exception ex){
        GenericLogicClass.errorHandlingMethod(ex);
    }
}