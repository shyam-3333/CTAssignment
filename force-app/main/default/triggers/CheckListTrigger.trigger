/******************************************************************************

*****************************
** Created By   : Vijayavardan Reddy.
** Created Date : 29-6-2015.
** Description  : This trigger is used to update the activity active field to 
either true or false based on the grand chile checklist case sourcing and 
supply agency. 
*******************************************************************************

****************************/
trigger CheckListTrigger on NPD_Checklist__c(before insert, before delete, after delete, after insert, after undelete, after update, before update)
{
    system.debug('check trigger firing');
    public boolean check = false;
    try {
        // fetching Custom setting val.
        Npd_activity_trigger_controller__c cus1 = Npd_activity_trigger_controller__c.getInstance('stagetrigger');
        check = cus1.continueExecution__c;
    } catch(exception er1) {
        system.debug(er1);
    }
    if(check == false) {
        CheckListTriggerHandler handler = new CheckListTriggerHandler(trigger.new, trigger.oldmap);
        if(trigger.isAfter) {
            if(trigger.isInsert) {
                System.debug('********after insert*******' + trigger.new + '************' + trigger.oldmap);
                handler.afterInsertHandler();
            } else if(trigger.isUpdate) {
                System.debug('*******affter trigger.isUpdate*****');
                handler.afterUpdateHandler();
            }
        }
        if(trigger.isBefore) {
            if(trigger.isInsert) {
                handler.beforeInsertHandler();
            }
            else if(trigger.isdelete) {
                System.debug('********after delete*******' + trigger.new + '************' + trigger.oldmap);
                handler.beforeDeleteHandler();
            }
            else if(trigger.isUpdate) {
                System.debug('*****before update DynamicFlow**********');
                handler.beforeUpdateHandler();
            }
        }
        if((trigger.isbefore && trigger.isinsert) || (trigger.isbefore && trigger.isupdate))
        {
            for(NPD_Checklist__c ncl: Trigger.new)
            {
                //  NPD_Checklist__c ocl= trigger.oldmap.get(ncl.id);
                //&& ncl.Ids_Value__c != ocl.Ids_Value__c     //&& ncl.NPD_Activity_Chklist__r.serialno__c =='AR-0102001'
                //if(ncl.ids_value__c == 'upgrade' )
                //CheckListTriggerHandler.UpgradeOptionDynamicTable(ncl);
            }
        }
    }
}