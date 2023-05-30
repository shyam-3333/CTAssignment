/*
* Company : Kvp Business Solution 
* Date    : 27-12-2018
* Author  : Sameer Ranjan
* Description : QC_MTL_Component__c Trigger
* History     : N/L
*/
trigger QCMTLComponentTrigger on QC_MTL_Component__c (before insert,before update) {
    //Call before Insert Method
    if(Trigger.IsBefore && Trigger.IsInsert){
        QCMTLComponentTriggerHandler.beforeInsertMethod(Trigger.New);
    }
}