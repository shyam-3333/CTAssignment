/*
 Created By   : Mutturaj Heroor
 Created Date : 15/10/2020
 Trigger Name   : VendorTrigger
*/
trigger VendorTrigger on Vendor__c (before insert,After update) {

    if(trigger.isAfter && trigger.isUpdate){
        VendorTriggerHandler.vendorAfterUpdate(Trigger.new,Trigger.oldMap);
    }
    if(trigger.isbefore && trigger.isInsert){
        VendorTriggerHandler.vendorBeforeInsert(Trigger.new);
    }
}