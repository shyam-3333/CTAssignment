@IsTest
public class GiftcardQuoteBatch_Test {
    @TestSetup
    public static void giftQuote(){
        Account acc = new Account();
        acc.Name = 'test';
        acc.Type = 'Prospect';
        acc.BillingPostalCode = '506319';
        acc.Lead_first_contact_date__c = system.Today();
        
       insert acc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.Type ='Tools & Fixtures';
        opp.AccountId = acc.Id;
        opp.stageName = 'Opportunity Won';
        opp.CloseDate = system.Today();
        opp.Priority__c = 'Medium';
        insert opp;
        
        List<Quote> quotes = new List<Quote>();
        List<Gift_Cards__c> giftCards = new List<Gift_Cards__c>();
        Gift_Cards__c gift = new Gift_Cards__c();
        for (Integer i=0;i<1;i++) {
            quotes.add(new Quote(name='TestingQuoteGif'+i,
                OpportunityId= opp.Id));
            
        }
        insert quotes;
        for (Quote quo : [select id, INSTI_Order_Reference__c, Name from Quote]) {
            gift.Invoice_Number__c = quo.INSTI_Order_Reference__c;
            gift.Card_Number__c = quo.Name;
            giftCards.add(gift);
        }
        
        insert giftCards;
    }
        
    public static testMethod void giftQuoteTest(){
        Test.startTest();
        Id batchId = Database.executeBatch(new GiftcardQuoteBatch());
        Test.stopTest();
        
        Set<string> gifInvoice  = new Set<string>();
        list<Gift_Cards__c> giftToUpdate  = new list<Gift_Cards__c>();
        Map<string, string> quoteMap = new Map<string, string>();
        for(Gift_Cards__c gif: [Select Invoice_Number__c from Gift_Cards__c]){
            if(gif.Invoice_Number__c != null && gif.Invoice_Number__c != ''){
                gifInvoice.add(gif.Invoice_Number__c);
            }
        }
        if(!gifInvoice.isEmpty()){
            for(Quote quo :[Select Id, INSTI_Order_Reference__c from Quote where INSTI_Order_Reference__c in:gifInvoice]){
                if(quo.INSTI_Order_Reference__c != null && quo.INSTI_Order_Reference__c != '' && quo.Id != null){
                    quoteMap.put(quo.INSTI_Order_Reference__c, quo.Id);
                }
            }
        }
        for(Gift_Cards__c gif : [Select Invoice_Number__c, Quote__c from Gift_Cards__c]){    
            if(!quoteMap.isEmpty() && gif.Invoice_Number__c != null && gif.Invoice_Number__c != '' && quoteMap.containsKey(gif.Invoice_Number__c)){
                //System.assertEquals(null, quoteMap.get(gif.Invoice_Number__c));
            }
        }
    }
}