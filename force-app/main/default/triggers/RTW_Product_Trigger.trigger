/*********************************************************************
Created by :Vinoth Kumar
Created on : 06/04/2020
Description : RTW_Product__c object trigger 
**********************************************************************/
trigger RTW_Product_Trigger on RTW_Product__c (before delete) {
    
    if(Trigger.isBefore && Trigger.isDelete){
        RTW_Product_Delete.DeleteMethod(Trigger.oldMap);
    }
}