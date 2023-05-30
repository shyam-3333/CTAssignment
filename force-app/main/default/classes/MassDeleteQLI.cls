/*
Written by : Deepak singh
Created date - 20-04-2021
Test class : TestForQuote_Clone_Actual

*/
public with sharing class MassDeleteQLI {
    @AuraEnabled
    public static String fetchQLIs(string qId){
        List<wrapper> wrapList = new List<wrapper>();
        if(qId != null){
            for(quoteLineItem qli : [select id,QuoteId,Product2Id,Sales_Price_c__c,Discount_c__c,Price_Per_Unit_After_Discount__c from quoteLineItem where quoteId = :qId]){
                wrapper wrap = new wrapper();
                wrap.check = false;
                wrap.qli = qli;
                wrapList.add(wrap);
            }
        }
        system.debug('wrapList==>'+wrapList.size());
        return JSON.serialize( wrapList );
    }
    public class wrapper{
        public boolean check;
        public quoteLineItem qli;
    }
    
    @AuraEnabled
    public static void deleteQli(string qliListStr)
    {
        List<wrapper> wrapList = (List<wrapper>) JSON.deserialize(qliListStr, List<wrapper>.class);
        List<quoteLineItem> deleteQliList = new List<quoteLineItem>();
        for(wrapper wrap : wrapList){
            if(wrap.check)
                deleteQliList.add(wrap.qli);
        }
        System.debug('deleteQliList' + deleteQliList);
        if(deleteQliList.size() > 0){
            Delete deleteQliList ;
        }
    }
}