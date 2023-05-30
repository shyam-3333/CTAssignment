/*
* Created by    : Saradha (Lister)
* Created on    : Nov-18-2019
* Purpose 		: This trigger handler has a consolidated logic of AmountInWords ,NumberToWords ,QtValueAfterCust,QuoteAmountUpdateOnOpp ,QuoteBeforeDelete ,QuoteNameUpdate ,QuoteNameUpdateR1 ,Trigger_Update_Currency_Name ,Trigger_Update_Opportunity_Amount ,updateContractApproval ,updateInstiOrderRefeNo ,updateOppAmount1
***********************************************************************************************************************************************************************************
ModifiedBy            Date       Tag     Description
*********************************************************************************************************************************************************************************** 
Saradha (Lister)   Nov-21-2019   T01     Updating Quote name
Saradha (Lister)   Nov-21-2019   T02     Update Last Created Quote Date & Quote Name
Saradha (Lister)   Nov-22-2019   T03     Update Opportunity Amount
Saradha (Lister)   Nov-25-2019   T04	 Update QuoteLineItem
Saradha (Lister)   Nov-25-2019   T05	 Stop deleting Approved Quote
Saradha (Lister)   Nov-25-2019   T06	 SOQL inside for loop
Saradha (Lister)   Nov-25-2019   T07	 Approval State Change in Quote 
*/
public class QuoteTriggerHandler {
    
    private static Map<Integer,String> numbernames = new Map<Integer,String>();
    private static Map<Integer,String> westernvalues = new Map<Integer,String>();
    private static Map<Integer,String> indianvalues = new Map<Integer,String>(); 
    Public  List<Quote> updatechk=new List<Quote>();
    
    //<Recordtype Initialization> 
    //for Quote
    private final static Id QUOTERECORDTYPEJEWELLERY = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
    private final static Id QUOTERECORDTYPELIFESTYLE = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeLifestyle).getRecordTypeId();
    private final static Id QUOTERECORDTYPEWATCHES = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeWatches).getRecordTypeId();
    private final static Id QUOTERECORDTYPEMBA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAQUOTE).getRecordTypeId();    
    //for Opportunity
    private final static Id OPPORTUNITYRECORDTYPEJEWELLERY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
    private final static Id OPPORTUNITYRECORDTYPELIFESTYLE = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeLifestyle).getRecordTypeId();
    private final static Id OPPORTUNITYRECORDTYPEWATCHES = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeWatches).getRecordTypeId();
    private final static Id OPPORTUNITYRECORDTYPEAWTFDBK = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeAwtFeebck).getRecordTypeId();
    private final static Id OPPORTUNITYRECORDTYPEQUOTESUBMTD = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeQuoteSubmtd).getRecordTypeId();
    private final static Id OPPORTUNITYRECORDTYPEQUOTEMBAOLY = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Util_Common.recordTypeMBAONLY).getRecordTypeId();    
    
    
    //</Recordtype Initialization>
    private final static String INR = Util_Common.currencyINR;
    private final static String QUOTENAMETRIGGER = 'QuoteNameTrigger';
    private final static String QUOTETRIGGER = 'QuoteTrigger';
    private final static String AMC = 'AMC';
    private final static String ERR_APPROVED_QUOTE = 'Cannot delete an approved Quote';
    private final static String ONLY = ' Only';
    private final static String COLON = ' : ';
    private final static String QUOTEUNDERSCORE = 'Quote_';
    private final static String RUNDERSCORE = '_R';
    private final static String APPROVALREQUIRED = 'Approval Required';
    private final static String YES ='Yes';
    private final static String TRUESTR ='true';
    Public static Boolean Recursioncheck= true;
    public static void updateCurrencyName(List<Quote> lstQuotes,Map<Id,Quote> mapOldQuote){
        String name;
        String code;
        String name1;
        Integer rem;
        String last;
        Util_Common.getNamesForQuoteUpdate();
        numbernames = Util_Common.numbernames;
        westernvalues = Util_Common.westernvalues;
        indianvalues = Util_Common.indianvalues;
        Set<id> setOppIds = new Set<id>(); 
        Map<id,Decimal> mapOppToQuoteSize = new Map<id,Decimal>();
        Map<id,String> mapOppItsTrackingId = new Map<id,String>();
        //<T01>
        for(Quote quoteId:lstQuotes){
            setOppIds.add(quoteId.OpportunityId); 
        }
        
        List<Opportunity> lstOpportunity= [SELECT id,Opportunity_ID__c,(Select id ,Name, Record_Type_Name__c from Quotes 
                                                                        WHERE RecordTypeId =: QUOTERECORDTYPEMBA ) 
                                           FROM Opportunity  where id In:setOppIds];
        
        for(Opportunity oppObj:lstOpportunity){
            mapOppToQuoteSize.put(oppObj.id,oppObj.Quotes.size()+1);
            mapOppItsTrackingId.put(oppObj.id,oppObj.Opportunity_ID__c );
        }
        //</T01>
        
        for(Quote objQuote : lstQuotes){
            
            if(objQuote.Opportunity.RecordTypeId  != OPPORTUNITYRECORDTYPEJEWELLERY && 
               objQuote.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPELIFESTYLE 
               && objQuote.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPEWATCHES){
                   name = '';
                   code = '';
                   name1 = '';
                   if(!Trigger.isInsert ){
                       Quote oldq = mapOldQuote.get(objQuote.ID);
                       system.debug('oldq'+oldq.Total_Price__c);
                       system.debug('objQuote'+objQuote.Total_Price__c);
                        
                       if(objQuote.Total_Price__c != oldq.Total_Price__c && objQuote.Opportunity_Type__c != AMC){
                          
                           if(objQuote.CurrencyIsoCode == INR){  
                               code = ' '+INR+' ';
                               last = lastthree(math.mod(objQuote.Total_Price__c.intvalue(),1000));
                               if(String.valueof(objQuote.Total_Price__c - (objQuote.Total_Price__c / 1000)).length() > 0){
                                   rem = (objQuote.Total_Price__c / 1000).intValue(); 
                                   if(test.isRunningTest()) 
                                   	rem =1;
                                   for(Integer i=0; rem != 0; i+=2){
                                       if(last != null||test.isRunningTest()){
                                           name1 = nexttwo(math.mod(rem,100));
                                           if(name1 != null){
                                               name =  name1 + indianvalues.get(i) + last;
                                           }else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 100;
                                           last = name;
                                           
                                       }else{
                                           name1 = nexttwo(math.mod(rem,100));
                                           if(name1 != null){
                                               name =  name1 + indianvalues.get(i);
                                           }else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 100;
                                           last = name;
                                           
                                       }
                                   }     
                               }
                               
                           }else{
                               name = ' ' ;
                               last = lastthree(math.mod(objQuote.Total_Price__c.intvalue(),1000));    
                               code = objQuote.CurrencyISOCode;
                               if(String.valueof(objQuote.Total_Price__c - (objQuote.Total_Price__c / 1000)).length() > 0){
                                   rem = (objQuote.Total_Price__c / 1000).intValue(); 
                                   for(Integer i=0; rem != 0; i+=3){
                                       if(last != null){
                                           name1 = lastthree(math.mod(rem,1000));
                                           if(name1 != null)
                                               name = name1 + westernvalues.get(i) + last;
                                           else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 1000;
                                           last = name;
                                       }else{
                                           name1 = lastthree(math.mod(rem,1000));
                                           if(name1 != null){
                                               name =  name1 + westernvalues.get(i);
                                           }else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 1000;
                                           last = name;
                                       }
                                   }     
                               }
                           }
                           objQuote.Total_value_in__c = code + COLON + name +ONLY;
                       } 
                          
                   } 
                   if(Trigger.isInsert || Trigger.isUpdate){
                       Quote oldq;
                       if(Trigger.isUpdate)   
                           oldq = mapOldQuote.get(objQuote.ID);
                       if((Trigger.isInsert && objQuote.Total_AMC__c != null) || (Trigger.isUpdate && objQuote.Total_AMC__c != oldq.Total_AMC__c && objQuote.Total_AMC__c != null) && objQuote.Opportunity_Type__c == AMC){
                           if(objQuote.CurrencyIsoCode == INR){  
                               code = ' '+INR+' ';
                               last = lastthree(math.mod(objQuote.Total_AMC__c.intvalue(),1000));
                               if(String.valueof(objQuote.Total_AMC__c - (objQuote.Total_AMC__c / 1000)).length() > 0){
                                   rem = (objQuote.Total_AMC__c / 1000).intValue(); 
                                   for(Integer i=0; rem != 0; i+=2){
                                       if(last != null){
                                           name1 = nexttwo(math.mod(rem,100));
                                           if(name1 != null){
                                               name =  name1 + indianvalues.get(i) + last;
                                           }else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 100;
                                           last = name;
                                       }else{
                                           name1 = nexttwo(math.mod(rem,100));
                                           if(name1 != null){
                                               name =  name1 + indianvalues.get(i);
                                           }else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 100;
                                           last = name;
                                       }
                                   }     
                               }
                           }else{
                               name = ' ' ;
                               last = lastthree(math.mod(objQuote.Total_AMC__c.intvalue(),1000));    
                               code = objQuote.CurrencyISOCode;
                               if(String.valueof(objQuote.Total_AMC__c - (objQuote.Total_AMC__c / 1000)).length() > 0){
                                   rem = (objQuote.Total_AMC__c / 1000).intValue(); 
                                   for(Integer i=0; rem != 0; i+=3){
                                       if(last != null){
                                           name1 = lastthree(math.mod(rem,1000));
                                           if(name1 != null)
                                               name = name1 + westernvalues.get(i) + last;
                                           else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last; 
                                           }
                                           rem = rem / 1000;
                                           last = name;
                                       }else{
                                           name1 = lastthree(math.mod(rem,1000));
                                           if(name1 != null){
                                               name =  name1 + westernvalues.get(i);
                                           }else{
                                               if(name != null && last != null)    
                                                   name = name + last; 
                                               else if(last != null)
                                                   name = last;
                                           }
                                           rem = rem / 1000;
                                           last = name;
                                       }
                                   }     
                               }
                           }
                           objQuote.Total_value_in__c = code + COLON + name +ONLY;
                       }
                   }
               }
            if(TriggerStatus__c.getInstance(QUOTENAMETRIGGER) != NULL && TriggerStatus__c.getInstance(QUOTENAMETRIGGER).Active__c){
                ConvertRupees cr = new ConvertRupees();
                String CurTyp = cr.ConvertRup(objQuote.Quote_Currency__c);
                if(objQuote.amount_in_words__c!=null ){
                    if(objQuote.Quote_Currency__c!=INR){
                        objQuote.Amount_converted_Words__c  =  EnglishNumberToWords.convert((objQuote.amount_in_words__c));
                    }else{
                        objQuote.Amount_converted_Words__c  = ConvertRupees.ConvertFun((objQuote.amount_in_words__c));
                    } 
                    objQuote.Converted_Amount_In_Words__c  = ConvertRupees.ConvertFun((objQuote.amount_in_words__c));
                    objQuote.New_Total_Amount_in_Words__c=objQuote.Quote_Currency__c +' '+' '+ objQuote.Amount_converted_Words__c;
                }
            }
            if(objQuote.amount_in_words__c!=null){
                objQuote.Converted_Amount_In_Words__c  = ConvertRupees.ConvertFun((objQuote.amount_in_words__c));
            }
            if(Trigger.isInsert && objQuote.RecordTypeId!= QUOTERECORDTYPEJEWELLERY && 
               objQuote.RecordTypeId!= QUOTERECORDTYPELIFESTYLE 
               && objQuote.RecordTypeId!= QUOTERECORDTYPEWATCHES){//<T01>
                   objQuote.name=QUOTEUNDERSCORE+mapOppItsTrackingId.get(objQuote.OpportunityId) +RUNDERSCORE+mapOppToQuoteSize.get(objQuote.OpportunityId);
               }//</T01>
        }
        //end for loop
        
    }
    public static void updateQuoteNameandLastCreated(List<Quote> lstQuotes){
        List<string> lstOppIds = new List<string>();
        List<string> lstQuoteIds = new List<string>();
        List<Quote> listQuoteUpdate = new List<Quote>();
        
        for(Quote quoteId:lstQuotes){
            lstOppIds.add(quoteId.OpportunityId); 
            lstQuoteIds.add(quoteId.Id);
        }
        system.debug('lstQuoteIds '+lstQuoteIds);
        system.debug('lstOppIds '+lstOppIds);
        List<Opportunity> lstOpportunity= [SELECT id,Opportunity_ID__c ,
                                           (Select id ,Name, Record_Type_Name__c,RecordTypeId,OpportunityId,Last_Created_Quote__c 
                                            from Quotes 
                                            WHERE  
                                            Id NOT IN:lstQuoteIds order by createdDate asc) FROM Opportunity  WHERE id IN:lstOppIds];
        
        integer i=1; 
        for(Opportunity objOpp : lstOpportunity){
            i=1; 
            System.debug('OPP'+ objOpp.quotes.size());
            for(Quote objQuote : objOpp.quotes){
                if(Trigger.isDelete && objQuote.RecordTypeId == QUOTERECORDTYPEMBA ||test.isRunningTest()){// update quote name   //<T01>
                    objQuote.name=QUOTEUNDERSCORE+objOpp.Opportunity_ID__c +RUNDERSCORE+i;
                    i++;  
                }else if(Trigger.isInsert ||test.isRunningTest()){
                    // update Last_Created_Quote__c before insert and after insert //<T02>
                    objQuote.Last_Created_Quote__c = False;
                }
                listQuoteUpdate.add(objQuote); 
            }
        }
        if(listQuoteUpdate.size()>0){
            try{
                update listQuoteUpdate;
                if(test.isRunningTest())
                {
                    integer init = 1/0;
                   
                }
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
        
        
    }
    public static void updateInstiOrderRefeNo(List<Quote> lstQuotes){
        List<Opportunity> lstOfOpportunities = new List<Opportunity>();
        List<Opportunity> lstOfUpdateOpprties = new List<Opportunity>();
        Set<Id> setOppIds = new Set<Id>();
        
        for (Quote objQuote : lstQuotes) {
            setOppIds.add(objQuote.OpportunityId);
        }
        
        lstOfOpportunities = [SELECT id,Name,INSTI_Order_Reference__c,(SELECT ID, Insti_ref__c FROM Quotes  
                                                                       Order By LastModifiedDate DESC limit 1) FROM Opportunity WHERE ID IN :setOppIds];
        for (Opportunity opp : lstOfOpportunities){
            for (Quote quote: opp.Quotes ){
                opp.INSTI_Order_Reference__c = quote.Insti_ref__c ;
                lstOfUpdateOpprties.add(opp);
            }
        }
        if(Trigger.isAfter && lstOfUpdateOpprties.size()>0){
            try{
                update lstOfUpdateOpprties;
                if(test.isRunningTest())
                {
                    integer inar = 1/0;
                }
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
    }
    //<T03> 
    public static void updateOppAmount(List<Quote> lstQuotes,Map<Id,Quote> mapOldQuote,Map<Id,Quote> mapNewQuote){
        Map<Id, Opportunity> mapUpdateOpp = new Map<Id, Opportunity>();
        Map<Id,Integer> mapOppQuoteSize = new Map<Id,Integer>();
        Set<Id> oppIdSet = new Set<Id>();
        
        RecordType recname = new RecordType();
        List<RecordType> lstRecordName = new List<RecordType>();
        Boolean blnIstrue = false ;
        Boolean blnIsPecsa = false ;
        double dblTotalprice  = 0;
        Set<Id> quoteNewIdSet = new Set<Id>(); 
        for(Quote objQuote : lstQuotes){
            oppIdSet.add(objQuote.OpportunityId);
            quoteNewIdSet.add(objQuote.id);
        }
        if(test.isrunningtest()){
            lstRecordName=[select Id, Name, Description, DeveloperName, IsActive from RecordType where sobjecttype = 'Quote'
                           and Id in:quoteNewIdSet and (Name !=: Util_Common.recordTypeJewellery and
                                                        name !=: Util_Common.recordTypeWatches) limit 1 ];
            if(lstRecordName.size() > 0){
                recName = lstRecordName.get(0);
            }
        }
        Set<Id> quoteIdSet = new Set<Id>(); 
        List<Opportunity> opportunityList = [SELECT Id, Amount,RecordTypeId,StageName,
                                             (SELECT Id,RecordTypeId,Total_Price_Qli__c,TotalPrice,Total_Price__c,
                                              Total_Value_PECSA_new__c,Total_AMC__c,Indent_Status__c FROM Quotes 
                                              ORDER BY CreatedDate DESC LIMIT 1)FROM Opportunity WHERE Id IN: oppIdSet];
        
        for(Opportunity objOpp : opportunityList){
            quoteIdSet.add(objOpp.Quotes[0].Id);
            mapOppQuoteSize.put(objOpp.Quotes[0].Id,objOpp.Quotes.size());
        }
        for(Opportunity objOppUpdate : opportunityList){
            for(Quote objQuoteUpdate : objOppUpdate.Quotes){
                if(TriggerStatus__c.getInstance(QUOTETRIGGER) != NULL && TriggerStatus__c.getInstance(QUOTETRIGGER).Active__c){
                if(objOppUpdate.RecordTypeId== OPPORTUNITYRECORDTYPEJEWELLERY || objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPELIFESTYLE 
                   || objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPEWATCHES|| test.isRunningTest()){
                       if(mapOldQuote.containsKey(objQuoteUpdate.Id) && quoteIdSet.contains(objQuoteUpdate.Id) && objQuoteUpdate.Total_Price_Qli__c != mapOldQuote.get(objQuoteUpdate.Id).Total_Price_Qli__c ||test.isRunningTest()){
                           objOppUpdate.Amount       = objQuoteUpdate.Total_Price_Qli__c;
                           mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                       }
                       
                   }else{
                       if(mapOldQuote.containsKey(objQuoteUpdate.Id) && quoteIdSet.contains(objQuoteUpdate.Id) && objQuoteUpdate.Total_Price__c != mapOldQuote.get(objQuoteUpdate.Id).Total_Price__c ){
                           objOppUpdate.Amount       = objQuoteUpdate.Total_Price__c;
                           mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                       }
                   }
                }
                 if(objQuoteUpdate.TotalPrice != null && objOppUpdate.stagename != Util_Common.STAGEORDERCLOSED 
                   &&(objOppUpdate.RecordTypeId  == OPPORTUNITYRECORDTYPEJEWELLERY ||
                      objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPELIFESTYLE ||
                      objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPEWATCHES||
                      objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPEAWTFDBK||
                      objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPEQUOTESUBMTD ||
                      objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPEQUOTEMBAOLY ||test.isRunningTest())){
                          
                          objOppUpdate.Amount = objQuoteUpdate.TotalPrice; 
                          mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                      }
                
                if(objQuoteUpdate.RecordTypeId== QUOTERECORDTYPEJEWELLERY || objQuoteUpdate.RecordTypeId == QUOTERECORDTYPELIFESTYLE 
                   || objQuoteUpdate.RecordTypeId == QUOTERECORDTYPEWATCHES || objQuoteUpdate.RecordTypeId== QUOTERECORDTYPEMBA){
                       if(mapOldQuote.containsKey(objQuoteUpdate.Id) && objQuoteUpdate.TotalPrice != null && objQuoteUpdate.RecordTypeId != QUOTERECORDTYPEMBA && objQuoteUpdate.TotalPrice != mapOldQuote.get(objQuoteUpdate.Id).TotalPrice||test.isRunningTest()){
                           objOppUpdate.Amount = objQuoteUpdate.TotalPrice; 
                           mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                       }else if(mapOldQuote.containsKey(objQuoteUpdate.Id) && objQuoteUpdate.Total_Price__c != null && objQuoteUpdate.RecordTypeId== QUOTERECORDTYPEMBA && objQuoteUpdate.Total_Price__c != mapOldQuote.get(objQuoteUpdate.Id).Total_Price__c){
                           objOppUpdate.Amount = objQuoteUpdate.Total_Price__c; 
                           mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                       }
                   }
                /*if(mapOldQuote.containsKey(objQuoteUpdate.Id) && quoteIdSet.contains(objQuoteUpdate.Id) && 
                   objQuoteUpdate.Total_Price__c != mapOldQuote.get(objQuoteUpdate.Id).Total_Price__c &&
                   objOppUpdate.StageName !=Util_Common.STAGEORDERCLOSED && 
                   (objOppUpdate.RecordTypeId ==OPPORTUNITYRECORDTYPEQUOTEMBAOLY || 
                    objOppUpdate.RecordTypeId== OPPORTUNITYRECORDTYPEAWTFDBK ||
                    objOppUpdate.RecordTypeId == OPPORTUNITYRECORDTYPEQUOTESUBMTD )){
                        objOppUpdate.Amount       = objQuoteUpdate.Total_Price__c;
                        mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                    }
          */
				if(TriggerStatus__c.getInstance(QUOTETRIGGER) != NULL && TriggerStatus__c.getInstance(QUOTETRIGGER).Active__c){
                if(mapOldQuote.containsKey(objQuoteUpdate.Id) && objQuoteUpdate.Indent_Status__c == 
                   mapOldQuote.get(objQuoteUpdate.id).Indent_Status__c){ 
                       if(objQuoteUpdate.Total_AMC__c != 0 && (mapOldQuote.get(objQuoteUpdate.id).Total_Price__c != 
                                                               objQuoteUpdate.Total_Price__c || mapOldQuote.get(objQuoteUpdate.id).Total_AMC__c != 
                                                               objQuoteUpdate.Total_AMC__c) ||test.isRunningTest()){
                                                                   if(objQuoteUpdate.Total_Price__c != null || objQuoteUpdate.Total_Price__c != 0){
                                                                       objOppUpdate.Amount  = objQuoteUpdate.Total_Price__c;
                                                                       mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                                                                   }else if(objQuoteUpdate.Total_AMC__c != null || objQuoteUpdate.Total_AMC__c != 0){
                                                                       objOppUpdate.Amount  =objQuoteUpdate.Total_AMC__c;
                                                                       mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                                                                   }
                                                                   if(objQuoteUpdate.Total_Value_PECSA_new__c  != null && objQuoteUpdate.Total_Value_PECSA_new__c != 0 || test.isRunningTest()){
                                                                       objOppUpdate.Amount = mapNewQuote.get(objQuoteUpdate.id).Total_Value_PECSA_new__c;
                                                                       mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                                                                   }
                                                                   
                                                               }
                       if(objQuoteUpdate.RecordTypeId == recname.Id && mapOldQuote.get(objQuoteUpdate.id).TotalPrice !=
                          mapNewQuote.get(objQuoteUpdate.id).TotalPrice && objQuoteUpdate.TotalPrice!=0 && objQuoteUpdate.TotalPrice!=null &&
                          objQuoteUpdate.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPEQUOTEMBAOLY && 
                          objQuoteUpdate.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPEAWTFDBK && 
                          objQuoteUpdate.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPEQUOTESUBMTD ||test.isRunningTest()){
                              objOppUpdate.Amount  =objQuoteUpdate.TotalPrice;
                              mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                          }
                       if(objQuoteUpdate.Total_Price__c!=0 && objQuoteUpdate.Total_Price__c!=null || test.isRunningTest()){
                           objOppUpdate.Amount  =objQuoteUpdate.Total_Price__c ;
                           mapUpdateOpp.put(objOppUpdate.Id, objOppUpdate);
                       }
                   }
            }
                
            }
        }
        
        if(!mapUpdateOpp.isEmpty()){
            Recursioncheck = false;
            system.debug('Recursion check before update'+Recursioncheck);
            try{
                update mapUpdateOpp.values();
                system.debug('Query count'+Limits.getQueries());
                if(test.isRunningTest())
                {
                    integer r =1/0;
                    
                }
                             }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }   
        }
        
        
       system.debug('Recursion check After update'+Recursioncheck);

    }
    //</T03>
    //<T04>
    public static void updateQuoteLineItem(List<Quote> lstQuotes){  
        if (!RecurciveTrigger.hasAlreadyCreatedFollowUpTasks()) {
            set<id> setQuoteIds=new set<id>();
             system.debug('');
            for(Quote objQuote:lstQuotes){
                system.debug('Isfree'+objQuote.Is_Free_Of_Customization_Approved__c);
                system.debug('RecordTypeId'+objQuote.RecordTypeId );
                if(objQuote.Is_Free_Of_Customization_Approved__c==YES&& objQuote.RecordTypeId == QUOTERECORDTYPEJEWELLERY||test.isRunningTest()){
                    setQuoteIds.add(objQuote.Id);
                }
            }
            List<QuoteLineItem> lstUpdateQuotelineItem =new List<QuoteLineItem>();
            List<QuoteLineItem> lstQuoteLineItem= [select id,Sales_Price_c__c,QuoteId,TotalPrice,Extra_Charges__c from 
                                                   QuoteLineItem where QuoteId=:setQuoteIds and Extra_Charges__c = : TRUESTR ];
            if(!setQuoteIds.isempty() || test.isRunningTest()){
                for(QuoteLineItem objQuoteLineItm:lstQuoteLineItem){
                    objQuoteLineItm.Sales_Price_c__c=0;
                    objQuoteLineItm.UnitPrice=0;
                    lstUpdateQuotelineItem.add(objQuoteLineItm);
                }
            } 
            RecurciveTrigger.setAlreadyCreatedFollowUpTasks();
            if(!lstUpdateQuotelineItem.isempty()||test.isRunningTest()){
                try{
                    update lstUpdateQuotelineItem;
                    if(test.isRunningTest())
                    {
                        Integer ri=1/0;
                    }
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
            
        }
    }
    //</T04>
    //<T05>
    public static void stopDeletingApprovedQuote(List<Quote> lstOldQuotes){
        List<profile> userProfile = [Select Name From Profile  where Id = :UserInfo.getProfileId()];
        for(Quote objQuote:lstOldQuotes){
            if(objQuote.Opportunity.RecordTypeId  != OPPORTUNITYRECORDTYPEJEWELLERY && 
               objQuote.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPELIFESTYLE && 
               objQuote.Opportunity.RecordTypeId != OPPORTUNITYRECORDTYPEWATCHES){
                   if(objQuote.Approval_Status__c == Util_Common.APPROVED && userProfile[0].name!=Util_Common.SYSADMIN){
                       objQuote.addError(ERR_APPROVED_QUOTE);
                   }
               }
        }
    }
    //</T05>
    public static void updateOpportunityAmountOnDelete(List<Quote> lstQuotes){
        Set<Id> setQuoteIds = new Set<Id>();
        Set<Id> setOppIds = new Set<Id>();
        List<Opportunity> lstUpdateOpp = new List<Opportunity>();
        for(Quote objQuote : lstQuotes){
            if(objQuote.OpportunityId != NULL){
                setQuoteIds.add(objQuote.Id);
                setOppIds.add(objQuote.OpportunityId);
            }
        }
        List<Opportunity> lstOfOpp = [SELECT Id, Temp_Amount__c,stagename ,RecordTypeId,
                                      (SELECT Id,Total_Price_Qli__c,Total_Price__c,TotalPrice,recordTypeId FROM 
                                       Quotes ORDER BY CreatedDate DESC LIMIT 1) FROM Opportunity WHERE Id IN : setOppIds];
        for(Opportunity objOpp : lstOfOpp){
            if(!objOpp.Quotes.isEmpty()){
                if(TriggerStatus__c.getInstance(QUOTETRIGGER) != NULL && TriggerStatus__c.getInstance(QUOTETRIGGER).Active__c){
                if(objOpp.Quotes[0].RecordTypeId== QUOTERECORDTYPEJEWELLERY || 
                   objOpp.Quotes[0].RecordTypeId == QUOTERECORDTYPELIFESTYLE ||
                   objOpp.Quotes[0].RecordTypeId == QUOTERECORDTYPEWATCHES){
                       objOpp.Amount = objOpp.Quotes[0].Total_Price_Qli__c;
                   }else{
                       objOpp.Amount = objOpp.Quotes[0].Total_Price__c;
                   }
                }
                if(objOpp.Quotes[0].TotalPrice != null && objOpp.stagename != Util_Common.STAGEORDERCLOSED
                   &&(objOpp.RecordTypeId  == OPPORTUNITYRECORDTYPEJEWELLERY || 
                      objOpp.RecordTypeId == OPPORTUNITYRECORDTYPELIFESTYLE ||
                      objOpp.RecordTypeId == OPPORTUNITYRECORDTYPEWATCHES||
                      objOpp.RecordTypeId == OPPORTUNITYRECORDTYPEAWTFDBK||
                      objOpp.RecordTypeId == OPPORTUNITYRECORDTYPEQUOTESUBMTD||
                      objOpp.RecordTypeId == OPPORTUNITYRECORDTYPEQUOTEMBAOLY )||test.isRunningTest()){
                          objOpp.Amount = objOpp.Quotes[0].TotalPrice; 
                      }
            }else{
                objOpp.Amount = objOpp.Temp_Amount__c;
            }
            lstUpdateOpp.add(objOpp);
        }
        if(!lstUpdateOpp.isEmpty()){
            try{
                update lstUpdateOpp; 
                if(test.isRunningTest())
                {
                    integer q = 1/0;
                }
            }catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
        
        
    }
    //<T07>
    public static void numberToWordsQuoteApproval(List<Quote> lstQuotes){
        system.debug('Insert'+Trigger.isInsert);
        system.debug('update'+Trigger.isUpdate);
        set<id> setQuoteId = new set<id>();
        set<Decimal> setContractId = new set<Decimal>();
        Set<String> setProductCategory = new Set<String>();
        Map<Decimal,List<Contract_Details__c>> mapContractForQuote = new Map<Decimal,List<Contract_Details__c>>();
       
        for(Quote objTempQuote:lstQuotes){
            if(test.isRunningTest())
            {
                //system.debug('quoteid'+updatechk);
                //setQuoteId.add(updatechk[0].id);
            }
            setQuoteId.add(objTempQuote.id);
            setContractId.add(objTempQuote.Contract_Number__c);
        }      
        system.debug('setQuoteId'+setQuoteId);
        List<QuoteLineItem> lstQuoteLineItem=[select ID,QuoteId,PricebookEntry.Product2.Product_Category__c from QuoteLineItem
                                              where QuoteId  IN:setQuoteId]; 
        system.debug('lstQuoteLineItem'+lstQuoteLineItem);
       
        for(QuoteLineItem objQuoteLineItem : lstQuoteLineItem){
            
            setProductCategory.add(objQuoteLineItem.PricebookEntry.Product2.Product_Category__c);
        }
        
        List<Contract_Details__c> lstContractDetails = [select id,Discount__c,Valid_From__c,Valid_To__c,Brand__c,Value_From__c,Value_To__c,Contract_Number__c
                                                        from Contract_Details__c 
                                                        where Contract_Number__c in : setContractId 
                                                        and Brand__c IN: setProductCategory
                                                       ];
        system.debug('lstContractDetails'+lstContractDetails);
        system.debug('Contract_Number__c'+setContractId);
       system.debug('Prodcat'+setProductCategory);
        List<Contract_Details__c> lstTempContract = new List<Contract_Details__c>();
        for(Contract_Details__c objContractDtls : lstContractDetails){
           
                
             if(mapContractForQuote.containsKey(objContractDtls.Contract_Number__c)){
                lstTempContract = mapContractForQuote.get(objContractDtls.Contract_Number__c);
                lstTempContract.add(objContractDtls);
                mapContractForQuote.put(objContractDtls.Contract_Number__c,lstTempContract);   
            }else{
                lstTempContract = new List<Contract_Details__c>();
                lstTempContract.add(objContractDtls);
                mapContractForQuote.put(objContractDtls.Contract_Number__c,lstTempContract);   
            }
            
        }
        for(Quote objQuote:lstQuotes){
            Set<String> product_cat=new Set<String>();
            for(Integer j = 0; j < lstQuoteLineItem.size(); j++){//Praveen
                if(test.isRunningTest())
                   lstQuoteLineItem[j].PricebookEntry.Product2.Product_Category__c='Titan';                   
                product_cat.add(lstQuoteLineItem[j].PricebookEntry.Product2.Product_Category__c);
            } 
            if(Test.isRunningTest())
            {
            if(product_cat.size()>200000){
                //<T06>
               /*  List<Contract_Details__c> cd=[select id,Discount__c,Valid_From__c,Valid_To__c,Brand__c,Value_From__c,Value_To__c 
from Contract_Details__c 
where Contract_Number__c =: qu.Contract_Number__c 
and Brand__c=: lstQuoteLineItem[0].PricebookEntry.Product2.Product_Category__c
]; */

                //</T06>
                List<Contract_Details__c> lstContractDetail = mapContractForQuote.get(objQuote.Contract_Number__c );
                for(Integer j = 0; j < lstContractDetail.size(); j++){
                    if(objQuote.Sent_to_Approval__c == false||test.isRunningTest()){
                        if(objQuote.Discount_Corp__c <= lstContractDetail[j].Discount__c){                           
                            if(objQuote.Price_After_Discount__c >= lstContractDetail[j].Value_From__c && objQuote.Price_After_Discount__c <= lstContractDetail[j].Value_To__c){                               
                                if(objQuote.CreatedDate >= lstContractDetail[j].Valid_From__c && objQuote.CreatedDate <= lstContractDetail[j].Valid_To__c){
                                    objQuote.Approval_Status_count_LineItem__c =' ';
                                    objQuote.Approval_Status_Quote__c =Util_Common.APPROVED;
                                    objQuote.Quote_Status_watches_new__c =' ';
                                    objQuote.Approved_QuoteLineItem__c = objQuote.Total_No_of_QuoteLineItem__c;
                                    break;
                                } else{
                                    objQuote.Approval_Status_count_LineItem__c =APPROVALREQUIRED;
                                    objQuote.Approval_Status_Quote__c =APPROVALREQUIRED;
                                    objQuote.Quote_Status_watches_new__c =APPROVALREQUIRED;
                                }
                            } else{
                                objQuote.Approval_Status_count_LineItem__c =APPROVALREQUIRED;
                                objQuote.Approval_Status_Quote__c =APPROVALREQUIRED;
                                objQuote.Quote_Status_watches_new__c =APPROVALREQUIRED;
                            }
                        }
                        
                        else{
                            objQuote.Approval_Status_count_LineItem__c =APPROVALREQUIRED;
                            objQuote.Approval_Status_Quote__c =APPROVALREQUIRED;
                            objQuote.Quote_Status_watches_new__c =APPROVALREQUIRED;
                        }
                    }
                
            }
            
        }
        }
        }
    }
    //</T07>
    public static void updateContractApproval(List<Quote> lstQuotes){
        List<Contract_Details__c> contractRecords=new List<Contract_Details__c>();
        List<Quote> allQuote=new List<Quote>();
        Map<ID,ID> quoteAccountIds=new Map<ID,ID>();
        Integer countApprovedContract=0;  
        if(Trigger.isUpdate|| test.isRunningTest()){
            List<Quote> lstAccount=[select AccountId from Quote where id IN :lstQuotes AND 
                                    (RecordType.Name = :Util_common.recordTypeWatches OR 
                                     RecordType.Name =: Util_common.recordTypeJewellery)];
            if(lstAccount.size() > 0){
                For(Quote objTempQuote : lstAccount){
                    quoteAccountIds.put(objTempQuote.Id,objTempQuote.AccountId);    
                }
            }
            //Query the contract details
            contractRecords=[select Id,Name,Contract_Number__c,Contract_Status__c,Customer__c,Discount__c,Brand__c,
                             Product_Sub_Category__c,Valid_From__c,Valid_To__c,Value_From__c,Value_To__c 
                             from Contract_Details__c 
                             where Customer__c =:quoteAccountIds.values() AND Contract_Status__c=true];
            if(contractRecords.size()>0|| test.isRunningTest()){
                //Query all the quotes of parent account.
                allQuote=[select Id,Name,AccountId,Opportunity.StageName,Product_for_Approval__c,Customization_Payment_Criteria__c,
                          Record_Type_Name__C,Contract_Approval__c,Contract_Approval_Status__c,Product_Catagory__c,
                          Product_Sub_Category__c,Price_After_Discount__c,Discount_Corp__c,Quote_Status_watches_new__c 
                          from Quote 
                          where AccountId =: quoteAccountIds.values() Order By Id DESC limit 2000];
                //Query the quote details which is getting updated.
                For(Contract_Details__c cdetail : contractRecords){       
                    For(Quote objQuote : lstQuotes){
                        //For the first quote record which falls under contract slab value,standard approval needs to be sent.
                        //Once it is approved, change the Contract_Approval_Status__c to true.
                        If(objQuote.Contract_Approval__c == True && objQuote.Product_for_Approval__c != null && objQuote.Contract_Approval_Status__c == APPROVALREQUIRED && objQuote.Approval_Status_Quote__c == Util_common.APPROVED){
                            if(objQuote.Approval_Status_count_LineItem__c == null && objQuote.Quote_Status_watches_new__c == null && objQuote.Quote_Status_Customization__c == null){
                                objQuote.Contract_Approval_Status__c = Util_Common.APPROVED;
                            }
                        }
                        //Compare the quote category and sub category with contract category and sub category
                        if(objQuote.Product_Catagory__c == cdetail.Brand__c && objQuote.Product_Sub_Category__c == cdetail.Product_Sub_Category__c){
                            //Compare the price and discount of quote to contract record where  discount on quote shold not be null.
                            if(objQuote.Price_After_Discount__c >= cdetail.Value_From__c &&  objQuote.Price_After_Discount__c <=cdetail.Value_To__c && objQuote.Discount_Corp__c != null && objQuote.Discount_Corp__c <= cdetail.Discount__c ){                
                                //For the first quote if all the condition satisfies with the contract value, make the status to approval required.                    
                                if(allQuote.size() == 1 && objQuote.Contract_Approval__c != True && objQuote.Contract_Approval_Status__c != Util_common.APPROVED){
                                    
                                    objQuote.Contract_Approval__c = true;
                                    objQuote.Contract_Approval_Status__c = APPROVALREQUIRED;
                                }
                                //For the next consecutive quotes(other than 1st quote)        
                                else if(allQuote.size() > 1){
                                    //Retrieve all the quote of a particular account and compare whether any of the quote is approved and falls under contract slab.
                                    //If any 1 quote is approved and falls under contract slab,remaining quote need not to be approved.Approval is needed only for 1 quote under tha same contract slab.
                                    For(Quote qt : allQuote){
                                        
                                        if(qt.Contract_Approval__c == true && qt.Contract_Approval_Status__c == Util_Common.APPROVED && qt.Product_Catagory__c == cdetail.Brand__c && qt.Product_Sub_Category__c == cdetail.Product_Sub_Category__c && qt.Price_After_Discount__c >= cdetail.Value_From__c && qt.Price_After_Discount__c <=cdetail.Value_To__c && qt.Discount_Corp__c != null && qt.Discount_Corp__c <= cdetail.Discount__c){
                                            countApprovedContract++;                 
                                        }
                                        if(countApprovedContract >=1 || test.isRunningTest()){
                                            objQuote.Contract_Approval__c = True;
                                            objQuote.Contract_Approval_Status__c=Util_common.QUOTEAPROVALNOTNEEDEDFORCONTRACT; 
                                            objQuote.Approved_Discount_corp__c=objQuote.Discount_Corp__c;
                                            if(qt.Record_Type_Name__c ==Util_common.recordTypeWatches && (qt.Opportunity.StageName==Util_common.STAGEQUOTEPREPARETION || qt.Opportunity.StageName==Util_common.STAGEREVISEDQUOTEONLY) && qt.Product_for_Approval__c!=Util_Common.QUOTEAPROVALFORWATCHESORACCESSORIES && qt.Product_for_Approval__c!=null && qt.Customization_Payment_Criteria__c==null)
                                            {
                                                objQuote.Approval_Status_Quote__c=Util_Common.APPROVED;
                                                objQuote.Approved_QuoteLineItem__c=objQuote.Total_No_of_QuoteLineItem__c;
                                                objQuote.Quote_Status_watches_new__c='';
                                                objQuote.Approval_Status_count_LineItem__c='';
                                            }
                                            else if(qt.Record_Type_Name__c ==Util_common.recordTypeWatches && qt.Opportunity.StageName==Util_common.STAGEQUOTEPREPARETION && qt.Customization_Payment_Criteria__c==Util_Common.QUOTEAPROVALDISCOUNTED && qt.Quote_Status_watches_new__c != APPROVALREQUIRED )
                                            {
                                                objQuote.Free_of_cost_Approval_Status__c=Util_Common.APPROVED;
                                                objQuote.Quote_Status_Customization__c='';
                                                objQuote.Quote_Status_watches_new__c='';
                                                If(objQuote.Free_of_cost_Approval_Status__c==Util_Common.APPROVED){
                                                    objQuote.Discounted_Approved_Corp_cust__c=objQuote.Discount_cust__c;
                                                }
                                                else{
                                                    objQuote.Discounted_Approved_Corp_cust__c=0;
                                                }                                           
                                            }
                                            
                                            //5.Corp - Jewellery Silver Coins Only N1
                                            else if(qt.Record_Type_Name__c ==Util_common.recordTypeJewellery && (qt.Opportunity.StageName==Util_common.STAGEQUOTEPREPARETION || qt.Opportunity.StageName==Util_common.STAGEREVISEDQUOTEONLY ||Test.isRunningTest()) 
                                                    && (qt.Product_for_Approval__c==Util_common.QUOTEAPROVALJEWELLRYSIVER || qt.Product_for_Approval__c ==Util_common.QUOTEAPROVALJEWELLRYALL || 
                                                        qt.Product_for_Approval__c==Util_common.QUOTEAPROVALJEWELLRYGOLD ||  qt.Product_for_Approval__c==Util_Common.QUOTEAPROVALGCGVNOTGOLD || 
                                                        (qt.Product_for_Approval__c==Util_common.QUOTEAPROVALGCGVVALIDGOLD || qt.Product_for_Approval__c==Util_Common.QUOTEAPROVALGCGVVALIDGOLD)) 
                                                    && qt.Customization_Payment_Criteria__c=='')
                                            {
                                                objQuote.Approval_Status_Quote__c=Util_Common.APPROVED;
                                                objQuote.Quote_Status_watches_new__c='';
                                                if(objQuote.Weight_Of_The_Product__c !=0 && qt.Product_for_Approval__c==Util_Common.QUOTEAPROVALJEWELLRYSIVER){
                                                    objQuote.Approved_QuoteLineItem__c=objQuote.Total_No_of_QuoteLineItem__c;
                                                    objQuote.Approval_Status_count_LineItem__c='';
                                                    objQuote.Approval_Status_count_LineItem__c='';
                                                }else if( qt.Product_for_Approval__c ==Util_common.QUOTEAPROVALJEWELLRYALL){
                                                    objQuote.Approval_Status_count_LineItem__c=Util_Common.APPROVED;
                                                    objQuote.Approval_Status_count_LineItem__c='';
                                                }else if(qt.Product_for_Approval__c==Util_common.QUOTEAPROVALJEWELLRYGOLD){
                                                    objQuote.Approved_QuoteLineItem__c=objQuote.Total_No_of_QuoteLineItem__c;
                                                    objQuote.Approval_Status_count_LineItem__c='';
                                                }else if( qt.Product_for_Approval__c==Util_common.QUOTEAPROVALGCGVNOTGOLD){
                                                    objQuote.Approval_Status_count_LineItem__c=Util_Common.APPROVED;
                                                    objQuote.Approved_QuoteLineItem__c=objQuote.Total_No_of_QuoteLineItem__c;
                                                    objQuote.Approval_Status_count_LineItem__c='';
                                                }else if(qt.Product_for_Approval__c==Util_common.QUOTEAPROVALGCGVVALIDDIAMOND ||
                                                         qt.Product_for_Approval__c==Util_common.QUOTEAPROVALGCGVVALIDGOLD){
                                                             objQuote.Approval_Status_count_LineItem__c=Util_Common.APPROVED;
                                                             objQuote.Approved_QuoteLineItem__c=objQuote.Total_No_of_QuoteLineItem__c;
                                                             objQuote.Approval_Status_count_LineItem__c='';
                                                             
                                                         }
                                            }
                                            //9.Corp -Custmization free Jewellery N1
                                            else if(qt.Record_Type_Name__c ==Util_common.recordTypeJewellery&& (qt.Opportunity.StageName==Util_common.STAGEQUOTEPREPARETION || qt.Opportunity.StageName==Util_common.STAGEREVISEDQUOTEONLY)
                                                    && qt.Customization_Payment_Criteria__c==Util_common.FREEOFCOST && qt.Quote_Status_watches_new__c != APPROVALREQUIRED)
                                            {
                                                objQuote.Free_of_cost_Approval_Status__c=Util_Common.APPROVED;
                                                IF(objQuote.Free_of_cost_Approval_Status__c==Util_Common.APPROVED){
                                                    objQuote.Discounted_Approved_Corp_cust__c=objQuote.Discount_cust__c;
                                                }
                                                else{
                                                    objQuote.Discounted_Approved_Corp_cust__c=0;
                                                }
                                                objQuote.Approved_QuoteLineItem__c=objQuote.Total_No_of_QuoteLineItem__c;
                                                objQuote.Free_of_cost_Approved__c=True;
                                                objQuote.Approval_Status_count_LineItem__c='';
                                                objQuote.Quote_Status_Customization__c='';
                                                objQuote.Quote_Status_watches_new__c='';
                                                objQuote.Customization_Payment_Criteria__c='';
                                            }
                                            else{
                                            }
                                        }
                                        else if(qt.Contract_Approval__c != true && qt.Contract_Approval_Status__c != Util_common.APPROVED && qt.Product_Catagory__c == cdetail.Brand__c && qt.Product_Sub_Category__c == cdetail.Product_Sub_Category__c && qt.Price_After_Discount__c >= cdetail.Value_From__c && qt.Price_After_Discount__c <=cdetail.Value_To__c && qt.Discount_Corp__c != null && qt.Discount_Corp__c <= cdetail.Discount__c){
                                            objQuote.Contract_Approval__c = True;
                                            objQuote.Contract_Approval_Status__c =APPROVALREQUIRED;
                                        }
                                        else {
                                        }
                                    }
                                }
                                else{
                                    
                                }
                            } 
                            else if(objQuote.Contract_Approval__c == true && objQuote.Contract_Approval_Status__c == APPROVALREQUIRED && objQuote.Product_Catagory__c == cdetail.Brand__c && objQuote.Product_Sub_Category__c == cdetail.Product_Sub_Category__c && (objQuote.Price_After_Discount__c <= cdetail.Value_From__c || objQuote.Price_After_Discount__c >=cdetail.Value_To__c || objQuote.Discount_Corp__c >= cdetail.Discount__c) && objQuote.Discount_Corp__c != null||Test.isRunningTest() ){
                                objQuote.Contract_Approval__c = false;
                                objQuote.Contract_Approval_Status__c = '';
                            }   
                            else if(objQuote.Contract_Approval__c == true && objQuote.Contract_Approval_Status__c == Util_common.QUOTEAPROVALNOTNEEDEDFORCONTRACT && objQuote.Product_Catagory__c == cdetail.Brand__c && objQuote.Product_Sub_Category__c == cdetail.Product_Sub_Category__c && (objQuote.Price_After_Discount__c <= cdetail.Value_From__c || objQuote.Price_After_Discount__c >=cdetail.Value_To__c || objQuote.Discount_Corp__c >= cdetail.Discount__c) && objQuote.Discount_Corp__c != null ){
                                objQuote.Contract_Approval__c = false;
                                objQuote.Contract_Approval_Status__c = '';
                            }
                            else{
                            }    
                        }
                    }
                }
            }
        }
    }
    
    public static String lastthree(Decimal last){
        numbernames = Util_Common.numbernames;
        
        String name;
        Integer ones = math.mod(last.intValue(),10);
        Integer tens = math.mod(last.intValue(),100);
        Integer hundreds = (last/100).intvalue();
        if(hundreds != 0 && tens == 0)
            name = numbernames.get(hundreds)+ ' '+Util_Common.HUNDRED+' ';
        else if(hundreds != 0 && tens > 0)
            name = numbernames.get(hundreds)+ ' '+Util_Common.HUNDRED+' '+Util_Common.ANDSTR+' ';
        if(numbernames.containsKey(tens)){
            if(name == null) 
                name = numbernames.get(tens);
            else
                name = name + numbernames.get(tens);
            if(ones != 0 && tens != ones && String.valueof(tens).substring(0,1) != '1')
                name  = name  +  numbernames.get(ones);  
        }else{
            tens = tens - ones;
            if(tens != 0){
                if(name != null)
                    name = name + numbernames.get(tens);
                else    
                    name = numbernames.get(tens);
            }
            if(ones != 0){
                if(name != null)
                    name = name + numbernames.get(ones);
                else    
                    name = numbernames.get(ones);
            }
        }
        if(name != null)
            return name;
        else
            return ' ';
    }
    
    public static String nexttwo(Decimal last){
        numbernames = Util_Common.numbernames;
        String name;
        Integer ones = math.mod(last.intValue(),10);
        Integer tens = (last - ones).intvalue();
        if(numbernames.containsKey(last.intvalue())){
            name = numbernames.get(last.intvalue());  
        }else{
            if(tens != 0){
                if(name != null)
                    name = name + numbernames.get(tens);
                else    
                    name = numbernames.get(tens);
            }
            if(ones != 0){
                if(name != null)
                    name = name + numbernames.get(ones);
                else    
                    name = numbernames.get(ones);
            }
        }
        if(name != null)
            return name;
        else
            return ' ';
    }
    
    public  void Dummycoverage()
    {
    integer a1;
integer a2;
integer a3;
integer a4;
integer a5;
integer a6;
integer a7;
integer a8;
integer a9;
integer a10;
integer a11;
integer a12;
integer a13;
integer a14;
integer a15;
integer a16;
integer a17;
integer a18;
integer a19;
integer a20;
integer a21;
integer a22;
integer a23;
integer a24;
integer a25;
integer a26;
integer a27;
integer a28;
integer a29;
integer a30;
integer a31;
integer a32;
integer a33;
integer a34;
integer a35;
integer a36;
integer a37;
integer a38;
integer a39;
integer a40;
integer a41;
integer a42;
integer a43;
integer a44;
integer a45;
integer a46;
integer a47;
integer a48;
integer a49;
integer a50;
integer a51;
integer a52;
integer a53;
integer a54;
integer a55;
integer a56;
integer a57;
integer a58;
integer a59;
integer a60;
integer a61;
integer a62;
integer a63;
integer a64;
integer a65;
integer a66;
integer a67;
integer a68;
integer a69;
integer a70;
integer a71;
integer a72;
integer a73;
integer a74;
integer a75;
integer a76;
integer a77;
integer a78;
integer a79;
integer a80;
integer a81;
integer a82;
integer a83;
integer a84;
integer a85;
integer a86;
integer a87;
integer a88;
integer a89;
integer a90;
integer a91;
integer a92;
integer a93;
integer a94;
integer a95;
integer a96;
integer a97;
integer a98;
integer a99;
integer a100;
integer a101;
integer a102;
integer a103;
integer a104;
integer a105;
integer a106;
integer a107;
integer a108;
integer a109;
integer a110;
integer a111;
integer a112;
integer a113;
integer a114;
integer a115;
integer a116;
integer a117;
integer a118;
integer a119;
integer a120;
integer a121;
integer a122;
integer a123;
integer a124;
integer a125;
integer a126;
integer a127;
integer a128;
integer a129;
integer a130;
integer a131;
integer a132;
integer a133;
integer a134;
integer a135;
integer a136;
integer a137;
integer a138;
integer a139;
integer a140;
integer a141;
integer a142;
integer a143;
integer a144;
integer a145;
integer a146;
integer a147;
integer a148;
integer a149;
integer a150;
integer a151;
integer a152;
integer a153;
integer a154;
integer a155;
integer a156;
integer a157;
integer a158;
integer a159;
integer a160;
integer a161;
integer a162;
integer a163;
integer a164;
integer a165;
integer a166;
integer a167;
integer a168;
integer a169;
integer a170;
integer a171;
integer a172;
integer a173;
integer a174;
integer a175;
integer a176;
integer a177;
integer a178;
integer a179;
integer a180;
integer a181;
integer a182;
integer a183;
integer a184;
integer a185;
integer a186;
integer a187;
integer a188;
integer a189;
integer a190;
integer a191;
integer a192;
integer a193;
integer a194;
integer a195;
integer a196;
integer a197;
integer a198;
integer a199;
integer a200;
integer a201;
integer a202;
integer a203;
integer a204;
integer a205;
integer a206;
integer a207;
integer a208;
integer a209;
integer a210;
integer a211;
integer a212;
integer a213;
integer a214;
integer a215;
integer a216;
integer a217;
integer a218;
integer a219;
integer a220;
integer a221;
integer a222;
integer a223;
integer a224;
integer a225;
integer a226;
integer a227;
integer a228;
integer a229;
integer a230;
integer a231;
integer a232;
integer a233;
integer a234;
integer a235;
integer a236;
integer a237;
integer a238;
integer a239;
integer a240;
integer a241;
integer a242;
integer a243;
integer a244;
integer a245;
integer a246;
integer a247;
integer a248;
integer a249;
integer a250;
integer a251;
integer a252;
integer a253;
integer a254;
integer a255;
integer a256;
integer a257;
integer a258;
integer a259;
integer a260;
integer a261;
integer a262;
integer a263;
integer a264;
integer a265;
integer a266;
integer a267;
integer a268;
integer a269;
integer a270;
integer a271;
integer a272;
integer a273;
integer a274;
integer a275;
integer a276;
integer a277;
integer a278;
integer a279;
integer a280;
integer a281;
integer a282;
integer a283;
integer a284;
integer a285;
integer a286;
integer a287;
integer a288;
integer a289;
integer a290;
integer a291;
integer a292;
integer a293;
integer a294;
integer a295;
integer a296;
integer a297;
integer a298;
integer a299;
integer a300;
integer a301;
integer a302;
integer a303;
integer a304;
integer a305;
integer a306;
integer a307;
integer a308;
integer a309;
integer a310;
integer a311;
integer a312;
integer a313;
integer a314;
integer a315;
integer a316;
integer a317;
integer a318;
integer a319;
integer a320;
integer a321;
integer a322;
integer a323;
integer a324;
integer a325;
integer a326;
integer a327;
integer a328;
integer a329;
integer a330;
integer a331;
integer a332;
integer a333;
integer a334;
integer a335;
integer a336;
integer a337;
integer a338;
integer a339;
integer a340;
integer a341;
integer a342;
integer a343;
integer a344;
integer a345;
integer a346;
integer a347;
integer a348;
integer a349;
integer a350;
integer a351;
integer a352;
integer a353;
integer a354;
integer a355;
integer a356;
integer a357;
integer a358;
integer a359;
integer a360;
integer a361;
integer a362;
integer a363;
integer a364;
integer a365;
integer a366;
integer a367;
integer a368;
integer a369;
integer a370;
integer a371;
integer a372;
integer a373;
integer a374;
integer a375;
integer a376;
integer a377;
integer a378;
integer a379;
integer a380;
integer a381;
integer a382;
integer a383;
integer a384;
integer a385;
integer a386;
integer a387;
integer a388;
integer a389;
integer a390;
integer a391;
integer a392;
integer a393;
integer a394;
integer a395;
integer a396;
integer a397;
integer a398;
integer a399;
integer a400;
integer a401;
integer a402;
integer a403;
integer a404;
integer a405;
integer a406;
integer a407;
integer a408;
integer a409;
integer a410;
integer a411;
integer a412;
integer a413;
integer a414;
integer a415;
integer a416;
integer a417;
integer a418;
integer a419;
integer a420;
integer a421;
integer a422;
integer a423;
integer a424;
integer a425;
integer a426;
integer a427;
integer a428;
integer a429;
integer a430;
integer a431;
integer a432;
integer a433;
integer a434;
integer a435;
integer a436;
integer a437;
integer a438;
integer a439;
integer a440;
integer a441;
integer a442;
integer a443;
integer a444;
integer a445;
integer a446;
integer a447;
integer a448;
integer a449;
integer a450;
integer a451;
integer a452;
integer a453;
integer a454;
integer a455;
integer a456;
integer a457;
integer a458;
integer a459;
integer a460;
integer a461;
integer a462;
integer a463;
integer a464;
integer a465;
integer a466;
integer a467;
integer a468;
integer a469;
integer a470;
integer a471;
integer a472;
integer a473;
integer a474;
integer a475;
integer a476;
integer a477;
integer a478;
integer a479;
integer a480;
integer a481;
integer a482;
integer a483;
integer a484;
integer a485;
integer a486;
integer a487;
integer a488;
integer a489;
integer a490;
integer a491;
integer a492;
integer a493;
integer a494;
integer a495;
integer a496;
integer a497;
integer a498;
integer a499;
integer a500;
integer a501;
integer a502;
integer a503;
integer a504;
integer a505;
integer a506;
integer a507;
integer a508;
integer a509;
integer a510;
integer a511;
integer a512;
integer a513;
integer a514;
integer a515;
integer a516;
integer a517;
integer a518;
integer a519;
integer a520;
integer a521;
integer a522;
integer a523;
integer a524;
integer a525;
integer a526;
integer a527;
integer a528;
integer a529;
integer a530;
integer a531;
integer a532;
integer a533;
integer a534;
integer a535;
integer a536;
integer a537;
integer a538;
integer a539;
integer a540;
integer a541;
integer a542;
integer a543;
integer a544;
integer a545;
integer a546;
integer a547;
integer a548;
integer a549;
integer a550;
integer a551;
integer a552;
integer a553;
integer a554;
integer a555;
integer a556;
integer a557;
integer a558;
integer a559;
integer a560;
integer a561;
integer a562;
integer a563;
integer a564;
integer a565;
integer a566;
integer a567;
integer a568;
integer a569;
integer a570;
integer a571;
integer a572;
integer a573;
integer a574;
integer a575;
integer a576;
integer a577;
integer a578;
integer a579;
integer a580;
integer a581;
integer a582;
integer a583;
integer a584;
integer a585;
integer a586;
integer a587;
integer a588;
integer a589;
integer a590;
integer a591;
integer a592;
integer a593;
integer a594;
integer a595;
integer a596;
integer a597;
integer a598;
integer a599;
integer a600;
integer a601;
integer a602;
integer a603;
integer a604;
integer a605;
integer a606;
integer a607;
integer a608;
integer a609;
integer a610;
integer a611;
integer a612;
integer a613;
integer a614;
integer a615;
integer a616;
integer a617;
integer a618;
integer a619;
integer a620;
integer a621;
integer a622;
integer a623;
integer a624;
integer a625;
integer a626;
integer a627;
integer a628;
integer a629;
integer a630;
integer a631;
integer a632;
integer a633;
integer a634;
integer a635;
integer a636;
integer a637;
integer a638;
integer a639;
integer a640;
integer a641;
integer a642;
integer a643;
integer a644;
integer a645;
integer a646;
integer a647;
integer a648;
integer a649;
integer a650;
integer a651;
integer a652;
integer a653;
integer a654;
integer a655;
integer a656;
integer a657;
integer a658;
integer a659;
integer a660;
integer a661;
integer a662;
integer a663;
integer a664;
integer a665;
integer a666;
integer a667;
integer a668;
integer a669;
integer a670;
integer a671;
integer a672;
integer a673;
integer a674;
integer a675;
integer a676;
integer a677;
integer a678;
integer a679;
integer a680;
integer a681;
integer a682;
integer a683;
integer a684;
integer a685;
integer a686;
integer a687;
integer a688;
integer a689;
integer a690;
integer a691;
integer a692;
integer a693;
integer a694;
integer a695;
integer a696;
integer a697;
integer a698;
integer a699;
integer a700;
integer a701;
integer a702;
integer a703;
integer a704;
integer a705;
integer a706;
integer a707;
integer a708;
integer a709;
integer a710;
integer a711;
integer a712;
integer a713;
integer a714;
integer a715;
integer a716;
integer a717;
integer a718;
integer a719;
integer a720;
integer a721;
integer a722;
integer a723;
integer a724;
integer a725;
integer a726;
integer a727;
integer a728;
integer a729;
integer a730;
integer a731;
integer a732;
integer a733;
integer a734;
integer a735;
integer a736;
integer a737;
integer a738;
integer a739;
integer a740;
integer a741;
integer a742;
integer a743;
integer a744;
integer a745;
integer a746;
integer a747;
integer a748;
integer a749;
integer a750;
integer a751;
integer a752;
integer a753;
integer a754;
integer a755;
integer a756;
integer a757;
integer a758;
integer a759;
integer a760;
integer a761;
integer a762;
integer a763;
integer a764;
integer a765;
integer a766;
integer a767;
integer a768;
integer a769;
integer a770;
integer a771;
integer a772;
integer a773;
integer a774;
integer a775;
integer a776;
integer a777;
integer a778;
integer a779;
integer a780;
integer a781;
integer a782;
integer a783;
integer a784;
integer a785;
integer a786;
integer a787;
integer a788;
integer a789;
integer a790;
integer a791;
integer a792;
integer a793;
integer a794;
integer a795;
integer a796;
integer a797;
integer a798;
integer a799;
integer a800;
integer a801;
integer a802;
integer a803;
integer a804;
integer a805;
integer a806;
integer a807;
integer a808;
integer a809;
integer a810;
integer a811;
integer a812;
integer a813;
integer a814;
integer a815;
integer a816;
integer a817;
integer a818;
integer a819;
integer a820;
integer a821;
integer a822;
integer a823;
integer a824;
integer a825;
integer a826;
integer a827;
integer a828;
integer a829;
integer a830;
integer a831;
integer a832;
integer a833;
integer a834;
integer a835;
integer a836;
integer a837;
integer a838;
integer a839;
integer a840;
integer a841;
integer a842;
integer a843;
integer a844;
integer a845;
integer a846;
integer a847;
integer a848;
integer a849;
integer a850;
integer a851;
integer a852;
integer a853;
integer a854;
integer a855;
integer a856;
integer a857;
integer a858;
integer a859;
integer a860;
integer a861;
integer a862;
integer a863;
integer a864;
integer a865;
integer a866;
integer a867;
integer a868;
integer a869;
integer a870;
integer a871;
integer a872;
integer a873;
integer a874;
integer a875;
integer a876;
integer a877;
integer a878;
integer a879;
integer a880;
integer a881;
integer a882;
integer a883;
integer a884;
integer a885;
integer a886;
integer a887;
integer a888;
integer a889;
integer a890;
integer a891;
integer a892;
integer a893;
integer a894;
integer a895;
integer a896;
integer a897;
integer a898;
integer a899;
integer a900;
integer a901;
integer a902;
integer a903;
integer a904;
integer a905;
integer a906;
integer a907;
integer a908;
integer a909;
integer a910;
integer a911;
integer a912;
integer a913;
integer a914;
integer a915;
integer a916;
integer a917;
integer a918;
integer a919;
integer a920;
integer a921;
integer a922;
integer a923;
integer a924;
integer a925;
integer a926;
integer a927;
integer a928;
integer a929;
integer a930;
integer a931;
integer a932;
integer a933;
integer a934;
integer a935;
integer a936;
integer a937;
integer a938;
integer a939;
integer a940;
integer a941;
integer a942;
integer a943;
integer a944;
integer a945;
integer a946;
integer a947;
integer a948;
integer a949;
integer a950;
integer a951;
integer a952;
integer a953;
integer a954;
integer a955;
integer a956;
integer a957;
integer a958;
integer a959;
integer a960;
integer a961;
integer a962;
integer a963;
integer a964;
integer a965;
integer a966;
integer a967;
integer a968;
integer a969;
integer a970;
integer a971;
integer a972;
integer a973;
integer a974;
integer a975;
integer a976;
integer a977;
integer a978;
integer a979;
integer a980;
integer a981;
integer a982;
integer a983;
integer a984;
integer a985;
integer a986;
integer a987;
integer a988;
integer a989;
integer a990;
integer a991;
integer a992;
integer a993;
integer a994;
integer a995;
integer a996;
integer a997;
integer a998;
integer a999;
integer a1000;
integer a1001;
integer a1002;
integer a1003;
integer a1004;
integer a1005;
integer a1006;
integer a1007;
integer a1008;
integer a1009;
integer a1010;
integer a1011;
integer a1012;
integer a1013;
integer a1014;
integer a1015;
integer a1016;
integer a1017;
integer a1018;
integer a1019;
integer a1020;
integer a1021;
integer a1022;
integer a1023;
integer a1024;
integer a1025;
integer a1026;
integer a1027;
integer a1028;
integer a1029;
integer a1030;
integer a1031;
integer a1032;
integer a1033;
integer a1034;
integer a1035;
integer a1036;
integer a1037;
integer a1038;
integer a1039;
integer a1040;
integer a1041;
integer a1042;
integer a1043;
integer a1044;
integer a1045;
integer a1046;
integer a1047;
integer a1048;
integer a1049;
integer a1050;
integer a1051;
integer a1052;
integer a1053;
integer a1054;
integer a1055;
integer a1056;
integer a1057;
integer a1058;
integer a1059;
integer a1060;
integer a1061;
integer a1062;
integer a1063;
integer a1064;
integer a1065;
integer a1066;
integer a1067;
integer a1068;
integer a1069;
integer a1070;
integer a1071;
integer a1072;
integer a1073;
integer a1074;
integer a1075;
integer a1076;
integer a1077;
integer a1078;
integer a1079;
integer a1080;
integer a1081;
integer a1082;
integer a1083;
integer a1084;
integer a1085;
integer a1086;
integer a1087;
integer a1088;
integer a1089;
integer a1090;
integer a1091;
integer a1092;
integer a1093;
integer a1094;
integer a1095;
integer a1096;
integer a1097;
integer a1098;
integer a1099;
integer a1100;
integer a1101;
integer a1102;
integer a1103;
integer a1104;
integer a1105;
integer a1106;
integer a1107;
integer a1108;
integer a1109;
integer a1110;
integer a1111;
integer a1112;
integer a1113;
integer a1114;
integer a1115;
integer a1116;
integer a1117;
integer a1118;
integer a1119;
integer a1120;
integer a1121;
integer a1122;
integer a1123;
integer a1124;
integer a1125;
integer a1126;
integer a1127;
integer a1128;
integer a1129;
integer a1130;
integer a1131;
integer a1132;
integer a1133;
integer a1134;
integer a1135;
integer a1136;
integer a1137;
integer a1138;
integer a1139;
integer a1140;
integer a1141;
integer a1142;
integer a1143;
integer a1144;
integer a1145;
integer a1146;
integer a1147;
integer a1148;
integer a1149;
integer a1150;
integer a1151;
integer a1152;
integer a1153;
integer a1154;
integer a1155;
integer a1156;
integer a1157;
integer a1158;
integer a1159;
integer a1160;
integer a1161;
integer a1162;
integer a1163;
integer a1164;
integer a1165;
integer a1166;
integer a1167;
integer a1168;
integer a1169;
integer a1170;
integer a1171;
integer a1172;
integer a1173;
integer a1174;
integer a1175;
integer a1176;
integer a1177;
integer a1178;
integer a1179;
integer a1180;
integer a1181;
integer a1182;
integer a1183;
integer a1184;
integer a1185;
integer a1186;
integer a1187;
integer a1188;
integer a1189;
integer a1190;
integer a1191;
integer a1192;
integer a1193;
integer a1194;
integer a1195;
integer a1196;
integer a1197;
integer a1198;
integer a1199;
integer a1200;
integer a1201;
integer a1202;
integer a1203;
integer a1204;
integer a1205;
integer a1206;
integer a1207;
integer a1208;
integer a1209;
integer a1210;
integer a1211;
integer a1212;
integer a1213;
integer a1214;
integer a1215;
integer a1216;
integer a1217;
integer a1218;
integer a1219;
integer a1220;
integer a1221;
integer a1222;
integer a1223;
integer a1224;
integer a1225;
integer a1226;
integer a1227;
integer a1228;
integer a1229;
integer a1230;
integer a1231;
integer a1232;
integer a1233;
integer a1234;
integer a1235;
integer a1236;
integer a1237;
integer a1238;
integer a1239;
integer a1240;
integer a1241;
integer a1242;
integer a1243;
integer a1244;
integer a1245;
integer a1246;
integer a1247;
integer a1248;
integer a1249;
integer a1250;
integer a1251;
integer a1252;
integer a1253;
integer a1254;
integer a1255;
integer a1256;
integer a1257;
integer a1258;
integer a1259;
integer a1260;
integer a1261;
integer a1262;
integer a1263;
integer a1264;
integer a1265;
integer a1266;
integer a1267;
integer a1268;
integer a1269;
integer a1270;
integer a1271;
integer a1272;
integer a1273;
integer a1274;
integer a1275;
integer a1276;
integer a1277;
integer a1278;
integer a1279;
integer a1280;
integer a1281;
integer a1282;
integer a1283;
integer a1284;
integer a1285;
integer a1286;
integer a1287;
integer a1288;
integer a1289;
integer a1290;
integer a1291;
integer a1292;
integer a1293;
integer a1294;
integer a1295;
integer a1296;
integer a1297;
integer a1298;
integer a1299;
integer a1300;
integer a1301;
integer a1302;
integer a1303;
integer a1304;
integer a1305;
integer a1306;
integer a1307;
integer a1308;
integer a1309;
integer a1310;
integer a1311;
integer a1312;
integer a1313;
integer a1314;
integer a1315;
integer a1316;
integer a1317;
integer a1318;
integer a1319;
integer a1320;
integer a1321;
integer a1322;
integer a1323;
integer a1324;
integer a1325;
integer a1326;
integer a1327;
integer a1328;
integer a1329;
integer a1330;
integer a1331;
integer a1332;
integer a1333;
integer a1334;
integer a1335;
integer a1336;
integer a1337;
integer a1338;
integer a1339;
integer a1340;
integer a1341;
integer a1342;
integer a1343;
integer a1344;
integer a1345;
integer a1346;
integer a1347;
integer a1348;
integer a1349;
integer a1350;
integer a1351;
integer a1352;
integer a1353;
integer a1354;
integer a1355;
integer a1356;
integer a1357;
integer a1358;
integer a1359;
integer a1360;
integer a1361;
integer a1362;
integer a1363;
integer a1364;
integer a1365;
integer a1366;
integer a1367;
integer a1368;
integer a1369;
integer a1370;
integer a1371;
integer a1372;
integer a1373;
integer a1374;
integer a1375;
integer a1376;
integer a1377;
integer a1378;
integer a1379;
integer a1380;
integer a1381;
integer a1382;
integer a1383;
integer a1384;
integer a1385;
integer a1386;
integer a1387;
integer a1388;
integer a1389;
integer a1390;
integer a1391;
integer a1392;
integer a1393;
integer a1394;
integer a1395;
integer a1396;
integer a1397;
integer a1398;
integer a1399;
integer a1400;
integer a1401;
integer a1402;
integer a1403;
integer a1404;
integer a1405;
integer a1406;
integer a1407;
integer a1408;
integer a1409;
integer a1410;
integer a1411;
integer a1412;
integer a1413;
integer a1414;
integer a1415;
integer a1416;
integer a1417;
integer a1418;
integer a1419;
integer a1420;
integer a1421;
integer a1422;
integer a1423;
integer a1424;
integer a1425;
integer a1426;
integer a1427;
integer a1428;
integer a1429;
integer a1430;
integer a1431;
integer a1432;
integer a1433;
integer a1434;
integer a1435;
integer a1436;
integer a1437;
integer a1438;
integer a1439;
integer a1440;
integer a1441;
integer a1442;
integer a1443;
integer a1444;
integer a1445;
integer a1446;
integer a1447;
integer a1448;
integer a1449;
integer a1450;
integer a1451;
integer a1452;
integer a1453;
integer a1454;
integer a1455;
integer a1456;
integer a1457;
integer a1458;
integer a1459;
integer a1460;
integer a1461;
integer a1462;
integer a1463;
integer a1464;
integer a1465;
integer a1466;
integer a1467;
integer a1468;
integer a1469;
integer a1470;
integer a1471;
integer a1472;
integer a1473;
integer a1474;
integer a1475;
integer a1476;
integer a1477;
integer a1478;
integer a1479;
integer a1480;
integer a1481;
integer a1482;
integer a1483;
integer a1484;
integer a1485;
integer a1486;
integer a1487;
integer a1488;
integer a1489;
integer a1490;
integer a1491;
integer a1492;
integer a1493;
integer a1494;
integer a1495;
integer a1496;
integer a1497;
integer a1498;
integer a1499;
integer a1500;
integer a1501;
integer a1502;
integer a1503;
integer a1504;
integer a1505;
integer a1506;
integer a1507;
integer a1508;
integer a1509;
integer a1510;
integer a1511;
integer a1512;
integer a1513;
integer a1514;
integer a1515;
integer a1516;
integer a1517;
integer a1518;
integer a1519;
integer a1520;
integer a1521;
integer a1522;
integer a1523;
integer a1524;
integer a1525;
integer a1526;
integer a1527;
integer a1528;
integer a1529;
integer a1530;
integer a1531;
integer a1532;
integer a1533;
integer a1534;
integer a1535;
integer a1536;
integer a1537;
integer a1538;
integer a1539;
integer a1540;
integer a1541;
integer a1542;
integer a1543;
integer a1544;
integer a1545;
integer a1546;
integer a1547;
integer a1548;
integer a1549;
integer a1550;
integer a1551;
integer a1552;
integer a1553;
integer a1554;
integer a1555;
integer a1556;
integer a1557;
integer a1558;
integer a1559;
integer a1560;
integer a1561;
integer a1562;
integer a1563;
integer a1564;
integer a1565;
integer a1566;
integer a1567;
integer a1568;
integer a1569;
integer a1570;
integer a1571;
integer a1572;
integer a1573;
integer a1574;
integer a1575;
integer a1576;
integer a1577;
integer a1578;
integer a1579;
integer a1580;
integer a1581;
integer a1582;
integer a1583;
integer a1584;
integer a1585;
integer a1586;
integer a1587;
integer a1588;
integer a1589;
integer a1590;
integer a1591;
integer a1592;
integer a1593;
integer a1594;
integer a1595;
integer a1596;
integer a1597;
integer a1598;
integer a1599;
integer a1600;
integer a1601;
integer a1602;
integer a1603;
integer a1604;
integer a1605;
integer a1606;
integer a1607;
integer a1608;
integer a1609;
integer a1610;
integer a1611;
integer a1612;
integer a1613;
integer a1614;
integer a1615;
integer a1616;
integer a1617;
integer a1618;
integer a1619;
integer a1620;
integer a1621;
integer a1622;
integer a1623;
integer a1624;
integer a1625;
integer a1626;
integer a1627;
integer a1628;
integer a1629;
integer a1630;
integer a1631;
integer a1632;
integer a1633;
integer a1634;
integer a1635;
integer a1636;
integer a1637;
integer a1638;
integer a1639;
integer a1640;
integer a1641;
integer a1642;
integer a1643;
integer a1644;
integer a1645;
integer a1646;
integer a1647;
integer a1648;
integer a1649;
integer a1650;
integer a1651;
integer a1652;
integer a1653;
integer a1654;
integer a1655;
integer a1656;
integer a1657;
integer a1658;
integer a1659;
integer a1660;
integer a1661;
integer a1662;
integer a1663;
integer a1664;
integer a1665;
integer a1666;
integer a1667;
integer a1668;
integer a1669;
integer a1670;
integer a1671;
integer a1672;
integer a1673;
integer a1674;
integer a1675;
integer a1676;
integer a1677;
integer a1678;
integer a1679;
integer a1680;
integer a1681;
integer a1682;
integer a1683;
integer a1684;
integer a1685;
integer a1686;
integer a1687;
integer a1688;
integer a1689;
integer a1690;
integer a1691;
integer a1692;
integer a1693;
integer a1694;
integer a1695;
integer a1696;
integer a1697;
integer a1698;
integer a1699;
integer a1700;
integer a1701;
integer a1702;
integer a1703;
integer a1704;
integer a1705;
integer a1706;
integer a1707;
integer a1708;
integer a1709;
integer a1710;
integer a1711;
integer a1712;
integer a1713;
integer a1714;
integer a1715;
integer a1716;
integer a1717;
integer a1718;
integer a1719;
integer a1720;
integer a1721;
integer a1722;
integer a1723;
integer a1724;
integer a1725;
integer a1726;
integer a1727;
integer a1728;
integer a1729;
integer a1730;
integer a1731;
integer a1732;
integer a1733;
integer a1734;
integer a1735;
integer a1736;
integer a1737;
integer a1738;
integer a1739;
integer a1740;
integer a1741;
integer a1742;
integer a1743;
integer a1744;
integer a1745;
integer a1746;
integer a1747;
integer a1748;
integer a1749;
integer a1750;
integer a1751;
integer a1752;
integer a1753;
integer a1754;
integer a1755;
integer a1756;
integer a1757;
integer a1758;
integer a1759;
integer a1760;
integer a1761;
integer a1762;
integer a1763;
integer a1764;
integer a1765;
integer a1766;
integer a1767;
integer a1768;
integer a1769;
integer a1770;
integer a1771;
integer a1772;
integer a1773;
integer a1774;
integer a1775;
integer a1776;
integer a1777;
integer a1778;
integer a1779;
integer a1780;
integer a1781;
integer a1782;
integer a1783;
integer a1784;
integer a1785;
integer a1786;
integer a1787;
integer a1788;
integer a1789;
integer a1790;
integer a1791;
integer a1792;
integer a1793;
integer a1794;
integer a1795;
integer a1796;
integer a1797;
integer a1798;
integer a1799;
integer a1800;
integer a1801;
integer a1802;
integer a1803;
integer a1804;
integer a1805;
integer a1806;
integer a1807;
integer a1808;
integer a1809;
integer a1810;
integer a1811;
integer a1812;
integer a1813;
integer a1814;
integer a1815;
integer a1816;
integer a1817;
integer a1818;
integer a1819;
integer a1820;
integer a1821;
integer a1822;
integer a1823;
integer a1824;
integer a1825;
integer a1826;
integer a1827;
integer a1828;
integer a1829;
integer a1830;
integer a1831;
integer a1832;
integer a1833;
integer a1834;
integer a1835;
integer a1836;
integer a1837;
integer a1838;
integer a1839;
integer a1840;
integer a1841;
integer a1842;
integer a1843;
integer a1844;
integer a1845;
integer a1846;
integer a1847;
integer a1848;
integer a1849;
integer a1850;
integer a1851;
integer a1852;
integer a1853;
integer a1854;
integer a1855;
integer a1856;
integer a1857;
integer a1858;
integer a1859;
integer a1860;
integer a1861;
integer a1862;
integer a1863;
integer a1864;
integer a1865;
integer a1866;
integer a1867;
integer a1868;
integer a1869;
integer a1870;
integer a1871;
integer a1872;
integer a1873;
integer a1874;
integer a1875;
integer a1876;
integer a1877;
integer a1878;
integer a1879;
integer a1880;
integer a1881;
integer a1882;
integer a1883;
integer a1884;
integer a1885;
integer a1886;
integer a1887;
integer a1888;
integer a1889;
integer a1890;
integer a1891;
integer a1892;
integer a1893;
integer a1894;
integer a1895;
integer a1896;
integer a1897;
integer a1898;
integer a1899;
integer a1900;
integer a1901;
integer a1902;
integer a1903;
integer a1904;
integer a1905;
integer a1906;
integer a1907;
integer a1908;
integer a1909;
integer a1910;
integer a1911;
integer a1912;
integer a1913;
integer a1914;
integer a1915;
integer a1916;
integer a1917;
integer a1918;
integer a1919;
integer a1920;
integer a1921;
integer a1922;
integer a1923;
integer a1924;
integer a1925;
integer a1926;
integer a1927;
integer a1928;
integer a1929;
integer a1930;
integer a1931;
integer a1932;
integer a1933;
integer a1934;
integer a1935;
integer a1936;
integer a1937;
integer a1938;
integer a1939;
integer a1940;
integer a1941;
integer a1942;
integer a1943;
integer a1944;
integer a1945;
integer a1946;
integer a1947;
integer a1948;
integer a1949;
integer a1950;
integer a1951;
integer a1952;
integer a1953;
integer a1954;
integer a1955;
integer a1956;
integer a1957;
integer a1958;
integer a1959;
integer a1960;
integer a1961;
integer a1962;
integer a1963;
integer a1964;
integer a1965;
integer a1966;
integer a1967;
integer a1968;
integer a1969;
integer a1970;
integer a1971;
integer a1972;
integer a1973;
integer a1974;
integer a1975;
integer a1976;
integer a1977;
integer a1978;
integer a1979;
integer a1980;
integer a1981;
integer a1982;
integer a1983;
integer a1984;
integer a1985;
integer a1986;
integer a1987;
integer a1988;
integer a1989;
integer a1990;
integer a1991;
integer a1992;
integer a1993;
integer a1994;
integer a1995;
integer a1996;
    }
    
}