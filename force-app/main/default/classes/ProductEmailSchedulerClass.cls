/*************************************************************
* Created by: Vinoth Kumar A
* Created on: 04/03/2019
* Description: Every day at 7PM an email with re-order details should be triggered to respective team
* ************************************************************/ 
global class ProductEmailSchedulerClass implements Schedulable {
    global void execute(SchedulableContext sc) {
        ProductEmailBatchClass b = new ProductEmailBatchClass(); 
        database.executebatch(b);
    }
}