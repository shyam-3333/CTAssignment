/*
 * Author:KVP
 * Class Name:GiftCardTriggerHelper
 * Test class:
 * Created Date:13/10/2022
 * Description:
*/
public class GiftCardTriggerHelper 
{
    public static  boolean firstRun = true;
    //This method is used to update the opportunity's Gift_Card_Transaction_Date__c with the value from the gift card object
	public static void updateTransactionDate(List<Gift_Cards__c> giftCardList)
    {
        try
        {
            Map<String,List<Gift_Cards__c>> quoteIdGiftCardMap=new Map<String,List<Gift_Cards__c>>();
            System.debug(' start inside updateTransactionDate');
            List<String> quoteIds=new List<String>();
            Map<String,Date> QuotetransactionalMap=New Map<String,Date>();
            for(Gift_Cards__c gcObj:giftCardList)
            {
                if(gcObj.Quote__c!=Null && gcObj.Transaction_Date__c!=Null && gcObj.Transaction_Type__c=='GIFT CARD ACTIVATE' && gcObj.Invoice_Number__c!=Null)
                {
                    quoteIds.add(gcobj.Quote__c);
                    //QuotetransactionalMap.put(gcobj.Quote__c,gcobj.Transaction_Date__c);
                    if(quoteIdGiftCardMap.containsKey(gcobj.Quote__c))
                    {
						quoteIdGiftCardMap.get(gcobj.Quote__c).add(gcObj);                        
                    }
                    else
                    {
                        quoteIdGiftCardMap.put(gcobj.Quote__c,new List<Gift_Cards__c> { gcObj });
                    }
                }
            }
            
            List<Quote> quoteList=new List<Quote>();
            Map<String,String>opportunityQuoteMap=New Map<String,String>();
            quoteList=[Select id,OpportunityId,INSTI_Order_Reference__c from Quote where id=:quoteIds];
            List<String> opportunityIds=new List<String>();
            /*if(quoteList.size()>0)
            {
                for(Quote qObj:quoteList)
                {
                    opportunityIds.add(qObj.OpportunityId);
                    opportunityQuoteMap.put(qObj.OpportunityId,qObj.id);
                }
            }*/
            //new
            if(quoteList.size()>0)
            {
                for(Quote qObj:quoteList)
                {
                    for(Gift_Cards__c gObj:quoteIdGiftCardMap.get(qObj.id))
                    {
                        String invoiceNumber = gObj.Invoice_Number__c;
                        if(invoiceNumber.containsAny('/'))
                        {
                            invoiceNumber = invoiceNumber.substring(invoiceNumber.indexOf('/')+1, invoiceNumber.length());
                            if(qObj.INSTI_Order_Reference__c==invoiceNumber && !QuotetransactionalMap.containsKey(qObj.id))
                            {
                                QuotetransactionalMap.put(qObj.id,gObj.Transaction_Date__c);
                                opportunityIds.add(qObj.OpportunityId);
                                opportunityQuoteMap.put(qObj.OpportunityId,qObj.id);
                            }
                        }
                        else
                        {
                            if(qObj.INSTI_Order_Reference__c==gObj.Invoice_Number__c && !QuotetransactionalMap.containsKey(qObj.id))
                            {
                                QuotetransactionalMap.put(qObj.id,gObj.Transaction_Date__c);
                                opportunityIds.add(qObj.OpportunityId);
                                opportunityQuoteMap.put(qObj.OpportunityId,qObj.id);
                            }
                        }
                    }
                    
                }
            }
    
            List<String>oppIdList=new List<String>();
            List<Opportunity> oppListUpdate=New List<Opportunity>();
            List<Opportunity> oppList=[Select id,RecordType.Name,Gift_Card_Transaction_Date__c,Name,StageName From Opportunity where id=:opportunityIds];
            if(oppList.size()>0)
            {
                for(Opportunity opObj:oppList)
                {
                    if(opObj.RecordType.Name=='Jewellery' && opObj.Gift_Card_Transaction_Date__c==Null && !oppIdList.contains(opObj.id) && opObj.StageName!='Order Closed')
                    {
                        Opportunity singleOpp=new Opportunity();
                        singleOpp.id=opObj.id;
                        singleOpp.Gift_Card_Transaction_Date__c=QuotetransactionalMap.get(opportunityQuoteMap.get(opObj.id));
                        oppListUpdate.add(singleOpp);
                        oppIdList.add(opObj.id);
                        System.debug('opp name: '+opObj.Name);
                    }
                }
            }
            if(oppListUpdate.size()>0)
            {
                System.debug('update opp last');
                System.debug('opp update list: '+oppListUpdate);
                update oppListUpdate;
            }
        }
        catch(Exception e)
        {
            System.debug('Error-->'+e.getMessage());
            System.debug('Error Line-->'+e.getLineNumber());
        }        
    }
    
    //This method is used to update the opportunity's Gift_Card_Transaction_Date__c with the value from the gift card object
	public static void updateTransactionDateOnQuote(List<Gift_Cards__c> giftCardList,Map<id,Gift_Cards__c> oldGiftCardMap)
    {
        try
        {
            Map<String,List<Gift_Cards__c>> quoteIdGiftCardMap=new Map<String,List<Gift_Cards__c>>();
            System.debug(' start inside updateTransactionDate m2');
            List<String> quoteIds=new List<String>();
            Map<String,Date> QuotetransactionalMap=New Map<String,Date>();
            for(Gift_Cards__c gcObj:giftCardList)
            {
                System.debug('Testdata----->quote '+gcObj.Quote__c+'old value '+oldGiftCardMap.get(gcObj.id).Quote__c);
                if((gcObj.Quote__c!=Null && oldGiftCardMap.get(gcObj.id).Quote__c==Null) && gcObj.Transaction_Date__c!=Null && gcObj.Transaction_Type__c=='GIFT CARD ACTIVATE' && gcObj.Invoice_Number__c!=Null)
                {
                    quoteIds.add(gcobj.Quote__c);
                    //QuotetransactionalMap.put(gcobj.Quote__c,gcobj.Transaction_Date__c);
                    if(quoteIdGiftCardMap.containsKey(gcobj.Quote__c))
                    {
						quoteIdGiftCardMap.get(gcobj.Quote__c).add(gcObj);                        
                    }
                    else
                    {
                        quoteIdGiftCardMap.put(gcobj.Quote__c,new List<Gift_Cards__c> { gcObj });
                    }
                }
            }
            
            List<Quote> quoteList=new List<Quote>();
            Map<String,String>opportunityQuoteMap=New Map<String,String>();
            quoteList=[Select id,OpportunityId,INSTI_Order_Reference__c from Quote where id=:quoteIds];
            List<String> opportunityIds=new List<String>();
            /*if(quoteList.size()>0)
            {
                for(Quote qObj:quoteList)
                {
                    opportunityIds.add(qObj.OpportunityId);
                    opportunityQuoteMap.put(qObj.OpportunityId,qObj.id);
                }
            }*/
            //new
            if(quoteList.size()>0)
            {
                for(Quote qObj:quoteList)
                {
                    for(Gift_Cards__c gObj:quoteIdGiftCardMap.get(qObj.id))
                    {
                        String invoiceNumber = gObj.Invoice_Number__c;
                        if(invoiceNumber.containsAny('/'))
                        {
                            invoiceNumber = invoiceNumber.substring(invoiceNumber.indexOf('/')+1, invoiceNumber.length());
                            if(qObj.INSTI_Order_Reference__c==invoiceNumber && !QuotetransactionalMap.containsKey(qObj.id))
                            {
                                QuotetransactionalMap.put(qObj.id,gObj.Transaction_Date__c);
                                opportunityIds.add(qObj.OpportunityId);
                                opportunityQuoteMap.put(qObj.OpportunityId,qObj.id);
                            }
                        }
                        else
                        {
                            if(qObj.INSTI_Order_Reference__c==gObj.Invoice_Number__c && !QuotetransactionalMap.containsKey(qObj.id))
                            {
                                QuotetransactionalMap.put(qObj.id,gObj.Transaction_Date__c);
                                opportunityIds.add(qObj.OpportunityId);
                                opportunityQuoteMap.put(qObj.OpportunityId,qObj.id);
                            }
                        }
                    }
                    
                }
            }
    
            List<String>oppIdList=new List<String>();
            List<Opportunity> oppListUpdate=New List<Opportunity>();
            List<Opportunity> oppList=[Select id,RecordType.Name,Gift_Card_Transaction_Date__c,Name,StageName From Opportunity where id=:opportunityIds];
            if(oppList.size()>0)
            {
                for(Opportunity opObj:oppList)
                {
                    if(opObj.RecordType.Name=='Jewellery' && opObj.Gift_Card_Transaction_Date__c==Null && !oppIdList.contains(opObj.id) && opObj.StageName!='Order Closed')
                    {
                        Opportunity singleOpp=new Opportunity();
                        singleOpp.id=opObj.id;
                        singleOpp.Gift_Card_Transaction_Date__c=QuotetransactionalMap.get(opportunityQuoteMap.get(opObj.id));
                        oppListUpdate.add(singleOpp);
                        oppIdList.add(opObj.id);
                        System.debug('opp name: '+opObj.Name);
                    }
                }
            }
            if(oppListUpdate.size()>0)
            {
                System.debug('update opp last');
                System.debug('opp update list: '+oppListUpdate);
                update oppListUpdate;
            }
        }
        catch(Exception e)
        {
            System.debug('Error-->'+e.getMessage());
            System.debug('Error Line-->'+e.getLineNumber());
        }        
    }
}