global class GiftcardQuoteBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT id, Quote__c, Invoice_Number__c from Gift_Cards__c where Quote__c = NULL And Invoice_Number__c != NULL]);
        
        
        
    }
    
    global void execute(Database.BatchableContext BC, List<Gift_Cards__c> scope) {  
        
        Set<string> gifInvoice  = new Set<string>();
        list<Gift_Cards__c> giftToUpdate  = new list<Gift_Cards__c>();
        Map<string, string> quoteMap = new Map<string, string>();
        for(Gift_Cards__c gif: scope){
            if(gif.Invoice_Number__c != null && gif.Invoice_Number__c != ''){
                String invoiceNumber = gif.Invoice_Number__c;
                if(invoiceNumber.containsAny('/')){
                    invoiceNumber = invoiceNumber.substring(invoiceNumber.indexOf('/')+1, invoiceNumber.length());
                    gifInvoice.add(invoiceNumber);
                    System.debug('Invoice--->' + gifInvoice);//2021/25894
                    
                }else{
                    gifInvoice.add(invoiceNumber);
                }
            }
        }
        
        if(!gifInvoice.isEmpty()){
            for(Quote quo :[Select Id, INSTI_Order_Reference__c,Insti_ref__c from Quote where (INSTI_Order_Reference__c In:gifInvoice Or Insti_ref__c IN : gifInvoice)]){
                if(quo.INSTI_Order_Reference__c != null && quo.INSTI_Order_Reference__c != '' && quo.Id != null){
                    quoteMap.put(quo.INSTI_Order_Reference__c, quo.Id);
                    quoteMap.put(quo.Insti_ref__c,quo.Id);
                }
            }
        }
        
        for(Gift_Cards__c gif : scope){
            String invoiceNumber = gif.Invoice_Number__c;
            if(invoiceNumber.containsAny('/')){
                invoiceNumber = invoiceNumber.substring(invoiceNumber.indexOf('/')+1, invoiceNumber.length());
                gifInvoice.add(invoiceNumber);
                if(!quoteMap.isEmpty() && gif.Invoice_Number__c != null && gif.Invoice_Number__c != '' && quoteMap.containsKey(invoiceNumber)){
                    gif.Quote__c = quoteMap.get(invoiceNumber);
                    gifInvoice.add(invoiceNumber);
                    System.debug('Invoice--->' + gifInvoice);
                    giftToUpdate.add(gif);
                }
            }else{
                if(!quoteMap.isEmpty() && gif.Invoice_Number__c != null && gif.Invoice_Number__c != '' && quoteMap.containsKey(invoiceNumber)){
                    gif.Quote__c = quoteMap.get(invoiceNumber);
                    giftToUpdate.add(gif);
                    
                }
            }
        }
        if(!giftToUpdate.isEmpty()){
            update giftToUpdate;
        }
    }
    
    global void finish(Database.BatchableContext BC)
    {
        System.debug('Completed');
    }
    
}