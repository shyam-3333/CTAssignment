trigger QC_TestDataTrigger on QC_Test_Data__c (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        QC_TestDataTriggerHandler.syncTestData(Trigger.new, Trigger.oldMap);
    }

}