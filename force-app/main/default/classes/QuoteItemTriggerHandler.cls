/*
* Created by    : Praveen (Lister)
* Created on    : Nov-20-2019
* Purpose 		: This trigger handler has a consolidated logic of QuoteLineItemBeforeInsetUpdate,Trigger_Update_Currency and Trigger_Update_SNo
***********************************************************************************************************************************************************************************
ModifiedBy            Date       Tag     Description
*********************************************************************************************************************************************************************************** 
Praveen (Lister)   Nov-18-2019   T01    Populate currency code 
Praveen (Lister)   Nov-18-2019   T02    Update number of Quote Items in Quote
Saradha (Lister)   Nov-20-2019   T03    Update Serial Number in Quote Items
Saradha (Lister)   Nov-20-2019   T04	Update Total Value in Quote and Amount in Oportunity
*/ 
public with sharing class QuoteItemTriggerHandler {
    private final static string awaitedStatus='PO Awaited';
    private final static string recievedStatus='PO Received';
    
    //<T01>
    public static void populateCurrencyCode(List<Quote_Items__c> lstQuoteItemNew) {
        Set<Id> setOppId =new Set<Id>();
        Map<Id,String> mapOppIDNCurrency = new Map<Id,String>();
        for(Quote_Items__c qitem : lstQuoteItemNew){
            setOppId.add(qitem.OpportunityID__c);
        }
        if(setOppId.size()>0){
            List<Opportunity> listOppt = [select ID,CurrencyISOCode from Opportunity where ID IN: setOppId];
            if(listOppt.size()>0){
                for(Opportunity objOpp :listOppt ){
                    mapOppIDNCurrency.put(objOpp.id,objOpp.CurrencyIsoCode);
                }
            }
            
            if(mapOppIDNCurrency.size()>0){
                for(Quote_Items__c objQItem : lstQuoteItemNew){
                    if(mapOppIDNCurrency.containsKey(objQItem.OpportunityID__c)&&mapOppIDNCurrency.get(objQItem.OpportunityID__c)!=null){
                        objQItem.CurrencyISOCode=mapOppIDNCurrency.get(objQItem.OpportunityID__c);
                    }
                }
            }
        }
    }
    //</T01>
    //<T02>
    public static void populateQuoteFields(List<Quote_Items__c> lstQuoteItemNew) {
        set<Id> setQuoteId = new set<Id>(); 
        List<Quote> lstQuote=null;
        List<Quote> lstUpdateQuote=null;
        List<Opportunity> listOpportunity = new List<Opportunity>();
        List<Quote_Items__c> updateQuoteItems = new List<Quote_Items__c>();
        
        Map<Id,Decimal> mapQuoteWithSLNO = new Map<Id,Decimal>();
        Decimal sum = 0;
        Decimal optionalSum = 0;  
        Integer poAwait = 0;
        Integer poReceived = 0;
        //<T03>
        for(Quote_Items__c quoItem : lstQuoteItemNew){
            setQuoteId.add(quoItem.Quote__c);
            if(Trigger.isDelete){
                if(mapQuoteWithSLNO.containsKey(quoItem.Quote__c)){
                    if(quoItem.S_No__c > mapQuoteWithSLNO.get(quoItem.Quote__c)){
                        mapQuoteWithSLNO.put(quoItem.Quote__c, quoItem.S_No__c);        
                    }
                }else{
                    mapQuoteWithSLNO.put(quoItem.Quote__c, quoItem.S_No__c);
                }
            }
        }
        //<T03>
        if(setQuoteId.size()>0){
            lstQuote=[Select Id, No_Of_Parts__c, No_Of_Parts_Won__c,Total_Value_PECSA_new__c,Opportunity.Amount,opportunityId,(Select id,Part_Status__c,Total_Value__c,Optional__c,S_No__c,Quote__c from Quote_Items__r)  from Quote where Id IN: setQuoteId];   
            if(lstQuote.size()>0){
                lstUpdateQuote=new List<Quote>();
                for(Quote objQuote :lstQuote ){
                    poAwait = 0;
                    poReceived = 0;
                    sum = 0;
                    optionalSum = 0;
                    if(objQuote.Quote_Items__r.size()>0){
                        for(Quote_Items__c objQtItem :objQuote.Quote_Items__r){
                            if(Trigger.isUpdate || Trigger.isAfter){
                                if(objQtItem.Part_Status__c==awaitedStatus){
                                    poAwait++;
                                }
                                else if(objQtItem.Part_Status__c==recievedStatus){
                                    poReceived++;
                                } 
                            }
                            //<T04>
                            /*
                            if(objQtItem.Optional__c == true){
                                optionalSum = optionalSum + objQtItem.Total_Value__c;   
                            }
                            sum = sum + objQtItem.Total_Value__c;
                            */
                            if(objQtItem.Optional__c == false){
                                sum = sum + objQtItem.Total_Value__c;   
                            }
                            
                            //</T04>
                            //<T03>
                            if(Trigger.isDelete){
                                if(objQtItem.S_No__c>mapQuoteWithSLNO.get(objQtItem.Quote__c)){
                                    Quote_Items__c objQuoteTemp = new Quote_Items__c(ID = objQtItem.ID);
                                    objQuoteTemp.S_No__c = objQtItem.S_No__c -1;
                                    updateQuoteItems.add(objQuoteTemp);
                                } 
                            }
                            //</T03>
                        }
                        /*
                        System.debug('Optional '+optionalSum);
                        
                        if(optionalSum != 0){
                            System.debug('Optional '+optionalSum);
                            objQuote.Total_Value_PECSA_new__c = optionalSum;
                        }else{
                            System.debug('Total '+Sum);
                            objQuote.Total_Value_PECSA_new__c = Sum;
                        } 
                        
                        objQuote.Opportunity.Amount  =objQuote.Total_Value_PECSA_new__c;
						*/
						objQuote.Opportunity.Amount = Sum ;
                        opportunity objOpp = new opportunity(id =objQuote.opportunityId,Amount =objQuote.Opportunity.amount );
                        listOpportunity.add(objOpp);
                        //</T04>
                        
                        if(Trigger.isUpdate || Trigger.isAfter){
                            objQuote.No_Of_Parts__c = poAwait;
                            objQuote.No_Of_Parts_Won__c = poReceived; 
                        }
                        
                    }
                    //<T04>
                    
                    lstUpdateQuote.add(objQuote);
                }
            }
            if(lstUpdateQuote.size()>0)
                try{
                    update lstUpdateQuote;
                }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
            if(listOpportunity.size()>0)
                try{
                    update listOpportunity;
                }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
            if(Trigger.isDelete && updateQuoteItems.size()>0){
                try{
                    update updateQuoteItems;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
            
        }
    }
    //</T02>
}