trigger GiftCardTrigger on Gift_Cards__c (after insert,after update) 
{
    if(trigger.isInsert && trigger.isAfter)
    {
        String checkGiftCardTriggerStatus = label.GiftCardTrigger_Status;
        if(checkGiftCardTriggerStatus == 'True')
        {
            System.debug('trigger called GiftCardTrigger');
            GiftCardTriggerHelper.updateTransactionDate(trigger.new);
        }
    }
    if(trigger.isUpdate && trigger.isAfter)
    {
        //Recursivecheck.run=false;
        //System.debug('update trigger called GiftCardTrigger1');
        String checkGiftCardTriggerStatus = label.GiftCardTrigger_Status;
        if(checkGiftCardTriggerStatus == 'True')
        {
            //System.debug('update trigger called GiftCardTrigger2');
            //String oldOppMapstr = Json.serialize(Trigger.oldMap);
            GiftCardTriggerHelper.updateTransactionDateOnQuote(trigger.new,Trigger.oldMap);
        }
    }
}