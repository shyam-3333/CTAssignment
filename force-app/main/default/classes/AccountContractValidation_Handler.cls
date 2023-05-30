/******
    Purpose : This code checks the valid Contract of parent account of any quoteline items.
              The contract data will be checked with percentage value,product,product sub category and discount 
              if the data matches with quoteline item data then quotation status will be updated.   
    Developed By:Umesh Mor.
	Modified By :- Anindwita
	Test Class Name :- TestupdateContractApproval
    Date :11-6-2018
          
******/
public class AccountContractValidation_Handler
{ 
    public static void validate_QuoteContract(List<QuoteLineItem> listQLineItem)
    {
        Set<id> quoteSet = new Set<id>();
        Set<id> prodIdSet = new Set<id>();
        system.debug('-------listQLineItem-------'+listQLineItem.size());
        for(QuoteLineItem quot : listQLineItem){
            if(quot.QuoteId!=null){
                quoteSet.add(quot.quoteId);  
            }
            if(quot.Product2Id!=null){
                prodIdSet.add(quot.Product2Id);
            }
        }
        Map<String,Product2> mapOfCode = new Map<String,Product2>();
        for(Product2 prod : [select id,name,Product_Category__c,Sub_Category__c  from Product2 WHERE Id in : prodIdSet ]){
            String pkey = prod.Product_Category__c+'/'+prod.Sub_Category__c;
            System.debug('----THE Parent Key is Product---------'+pkey);
            mapOfCode.put(pkey,prod);
        }
        Map<Id,Quote> accQuoteMap = new Map<Id,Quote>();
        Set<Id> accountIdSet = new Set<id>();
        for(Quote quot : [SELECT Id,AccountId,OpportunityId,Approval_Status_Quote__c,RecordType.Name from Quote where Id  IN :quoteSet]){
            accountIdSet.add(quot.AccountId);
            accQuoteMap.put(quot.id,Quot);
        }
        System.debug('====THE List of the AccountSet is===='+accountIdSet);
        System.debug('====THE List of the accQuoteMap is===='+accQuoteMap);
        System.debug('====THE List of the accQuoteMap is===='+accQuoteMap.values());
        List<Contract_Details__c> mapWithContract = [SELECT Id,Name,Customer__c,Brand__c,Product_Sub_Category__c,Discount__c,Valid_From__c,Valid_To__c FROM Contract_Details__c where Valid_To__c >= Today AND Customer__c in:accountIdSet];
        Map<Id,list<Contract_Details__c>> mapContractInfo = new Map<Id,list<Contract_Details__c>>();   //this map is to get the multiple contracts under an Account
        String prodCatSubCat = '';
        for(Contract_Details__c con : mapWithContract ){
            String pkey = con.Brand__c+'/'+con.Product_Sub_Category__c;
            //prodCatSubCat = pkey;
            System.debug('----THE Parent Key is contract---------'+pkey);
            if(mapOfcode.containsKey(pkey)){
                prodCatSubCat = pkey;
                if(!mapContractInfo.isEmpty() && mapContractInfo.containsKey(con.Customer__c) ){
                    mapContractInfo.get(con.Customer__c).add(con);
                }else{
                    mapContractInfo.put(con.Customer__c,new list<Contract_Details__c>{con});
                }
            }
        }
        System.debug('=======The details of contract is====='+mapContractInfo);
        Map<Id,Quote> mapQuoteIdQuote = new Map<Id,Quote>();        //this map is used to avoid the duplicate Ids while updating the quote based on quote line items
        Map<Id,String> mapQuoteIdApprStatus = new Map<Id,String>(); //this map is used to check the approval status based on the discount of quote line item while inserting in bulk
        Map<Id,Quote> mapQuoteIdAndQuote = new map<Id,Quote>([Select Id, Approval_Status_Quote__c from Quote where Id IN :quoteSet ]); //this map is used to query the previous approval status before insertion of quotelineitem
        System.debug('-----------mapQuoteIdAndQuote-----------'+mapQuoteIdAndQuote );
        
        for(QuoteLineItem quot : listQLineItem){
            if(accQuoteMap.containsKey(quot.QuoteId) && !accQuoteMap.isEmpty() && accQuoteMap.get(quot.QuoteId).AccountId!= NULL){
                system.debug('====The referred Account Id is====='+accQuoteMap.get(quot.quoteId).AccountId);
                Account accInstance = new Account();
                accInstance.Id = accQuoteMap.get(quot.quoteId).AccountId;
                
                //modified by Anindwita
                System.debug('==== quote.Product_Catagory__cquote.Product_Sub_Category__c========'+ quot.Product_Catagory__c+'/'+quot.Product_Sub_Category__c);
                System.debug('====mapContractInfo.containsKey(accInstance.Id)========'+mapContractInfo.containsKey(accInstance.Id));
                System.debug('===quot.Discount_c__c======='+quot.Discount_c__c);
                boolean isContactrMatch = false;
                if(!mapContractInfo.isEmpty() && mapContractInfo.containsKey(accInstance.id)){
                    for(Contract_Details__c cont : mapContractInfo.get(accInstance.id)){
                        if( quot.Product_Catagory__c+'/'+quot.Product_Sub_Category__c == cont.Brand__c+'/'+cont.Product_Sub_Category__c && quot.Discount_c__c <= cont.Discount__c ){
                            System.debug('====cont information========'+cont);
                            if(!mapQuoteIdQuote.containsKey(quot.QuoteId)){
                                //System.debug('==if==containsKey===false====');
                                Quote qt = new Quote();
                                qt.Id=quot.QuoteId;
                                qt.Approved_Discount_corp__c=quot.Discount_c__c;
                                if(mapQuoteIdAndQuote.get(qt.Id).Approval_Status_Quote__c == null || mapQuoteIdAndQuote.get(qt.Id).Approval_Status_Quote__c == '' || mapQuoteIdAndQuote.get(qt.Id).Approval_Status_Quote__c == 'Approved' || mapQuoteIdAndQuote.get(qt.Id).Approval_Status_Quote__c == 'None'  ){
                                    qt.Approval_Status_Quote__c ='Approved';
                                }
                                
                                mapQuoteIdQuote.put(quot.QuoteId, qt);
                            }else{
                                //System.debug('==if==containsKey===true====');
                                mapQuoteIdQuote.get(quot.QuoteId).Id=quot.QuoteId;
                                mapQuoteIdQuote.get(quot.QuoteId).Approved_Discount_corp__c = quot.Discount_c__c;
                                if(mapQuoteIdAndQuote.get(quot.QuoteId).Approval_Status_Quote__c == '' || mapQuoteIdAndQuote.get(quot.QuoteId).Approval_Status_Quote__c == null || mapQuoteIdAndQuote.get(quot.QuoteId).Approval_Status_Quote__c == 'Approved' || mapQuoteIdAndQuote.get(quot.QuoteId).Approval_Status_Quote__c == 'None' ){
                                    mapQuoteIdQuote.get(quot.QuoteId).Approval_Status_Quote__c ='Approved';
                                }
                                
                            }
                            //qt.Id=quot.QuoteId;
                            //qt.Approved_Discount_corp__c=quot.Discount_c__c; 
                            //qt.Approval_Status_Quote__c ='Approved';
                            //quoteList.add(qt); 
                            isContactrMatch = true;
                            break;
                        }
                        else
                        {
                            System.debug('====else=======');
                            if(!mapQuoteIdQuote.containsKey(quot.QuoteId)){
                                //System.debug('==else==containsKey===false====');
                                Quote qt = new Quote();
                                qt.Id=quot.QuoteId;
                                qt.Approved_Discount_corp__c = quot.Discount_c__c;
                                qt.Approval_Status_Quote__c ='Approval Required';
                                mapQuoteIdQuote.put(quot.QuoteId, qt);
                            }else{
                                //System.debug('==esle==containsKey===true====');
                                mapQuoteIdQuote.get(quot.QuoteId).Id = quot.QuoteId;
                                mapQuoteIdQuote.get(quot.QuoteId).Approved_Discount_corp__c= quot.Discount_c__c; //it takes the latest discount only
                                mapQuoteIdQuote.get(quot.QuoteId).Approval_Status_Quote__c = 'Approval Required';
                            }
                            
                            //Quote qt = new Quote();
                            //qt.Id=quot.QuoteId;
                            //qt.Approved_Discount_corp__c=quot.Discount_c__c; 
                            //qt.Approval_Status_Quote__c ='Approval Required';
                            //quoteList.add(qt);
    
                        }
                        
                    //quoteList.add(qt);
                    }
                }else{
                    if(!mapQuoteIdQuote.containsKey(quot.QuoteId)){
                        //System.debug('==if=no contract=containsKey===false====');
                        Quote qt = new Quote();
                        qt.Id=quot.QuoteId;
                        qt.Approved_Discount_corp__c = quot.Discount_c__c;
                        qt.Approval_Status_Quote__c ='Approval Required';
                        mapQuoteIdQuote.put(quot.QuoteId, qt);
                    
                    }else{
                            //System.debug('==esle==containsKey===true====');
                            mapQuoteIdQuote.get(quot.QuoteId).Id = quot.QuoteId;
                            mapQuoteIdQuote.get(quot.QuoteId).Approved_Discount_corp__c= quot.Discount_c__c; //it takes the latest discount only
                            mapQuoteIdQuote.get(quot.QuoteId).Approval_Status_Quote__c = 'Approval Required';
                        }
                }
                if(!isContactrMatch){
                    mapQuoteIdApprStatus.put(quot.QuoteId, 'Approval Required');
                }
            }
        }
        System.debug('====mapQuoteIdQuote======='+mapQuoteIdQuote);
        System.debug('====mapQuoteIdApprStatus======='+mapQuoteIdApprStatus);
        
        for(Quote q : mapQuoteIdQuote.values()){
            if(mapQuoteIdApprStatus.containsKey(q.Id)){
                q.Approval_Status_Quote__c = mapQuoteIdApprStatus.get(q.Id);
            }
        }
        if(!mapQuoteIdQuote.values().isEmpty()){
            update mapQuoteIdQuote.values();
        }
    }
    //=====================================================For Update Methods======================================================
     public static void upDateQuoteData(Map<Id,QuoteLineItem>newMapQuoteLineItem,Map<Id,QuoteLineItem>oldMapQuoteLineItem){
            Set<id> quoteSet = new Set<id>();
            Set<id> prodIdSet = new Set<id>();
            System.debug('========Entered Inside the Loop====');
            for(QuoteLineItem qlItem : newMapQuoteLineItem.values()){
                    System.debug('========New Map Product Id==='+qlItem.Product2Id);
                    System.debug('========Old Map Product Id==='+oldMapQuoteLineItem.get(qlItem .Id).product2Id);
                    System.debug('=======New Map Discount==='+qlItem.Discount_c__c);
                    System.debug('========Old Map Discount==='+oldMapQuoteLineItem.get(qlItem .Id).Discount_c__c);
                    
                    System.debug('=====The ProductId New Map-----');
                    if(((qlItem.Product2Id ==oldMapQuoteLineItem.get(qlItem .Id).product2Id) && (qlItem.Discount_c__c !=oldMapQuoteLineItem.get(qlItem .Id).Discount_c__c))||(qlItem.Product2Id !=oldMapQuoteLineItem.get(qlItem .Id).product2Id)){
                          System.debug('-----Hello Debug----');
                          if(qlItem.QuoteId!=null){
                                        quoteSet.add(qlItem.quoteId);  
                          }
                          if(qlItem.Product2Id!=null){
                                prodIdSet.add(qlItem.Product2Id);
                          }

                          
                    }
            }
            //To construct the map of product used 
            Map<String,Product2> mapOfCode = new Map<String,Product2>();
            for(Product2 prod : [select id,name,Product_Category__c,Sub_Category__c  from Product2 WHERE Id in : prodIdSet ]){
                    String pkey = prod.Product_Category__c+'/'+prod.Sub_Category__c;
                    mapOfCode.put(pkey,prod);
            }
            //To construct the map of Quote used 
            Map<Id,Quote> accQuoteMap = new Map<Id,Quote>();
            Set<Id> accountIdSet = new Set<id>();
            for(Quote quot : [SELECT Id,AccountId,OpportunityId,Approval_Status_Quote__c,RecordType.Name from Quote where Id  IN :quoteSet]){
                accountIdSet.add(quot.AccountId);
                accQuoteMap.put(quot.id,Quot);
            }
            
            System.debug('====THE List of the AccountSet is===='+accountIdSet);
            System.debug('====THE List of the accQuoteMap is===='+accQuoteMap);
            System.debug('====THE List of the accQuoteMap is===='+accQuoteMap.values());
            
            List<Contract_Details__c> mapWithContract = [SELECT Id,Name,Customer__c,Brand__c,Product_Sub_Category__c,Discount__c,Valid_From__c,Valid_To__c FROM Contract_Details__c where Valid_To__c >= Today AND Customer__c in:accountIdSet];
            Map<Id,Contract_Details__c> mapContractInfo = new Map<Id,Contract_Details__c>();
            for(Contract_Details__c con : mapWithContract ){
                String pkey = con.Brand__c+'/'+con.Product_Sub_Category__c;
                if(mapOfcode.containsKey(pkey)){
                     mapContractInfo.put(con.Customer__c,con);
                }
            }
            //Main Logic to compare the quote Line Item data contract details data
            System.debug('=======The details of contract is====='+mapContractInfo);
            List<Quote>quoteList=new List<Quote>();
            for(QuoteLineItem quotRec : newMapQuoteLineItem.values()){
                if(accQuoteMap.containsKey(quotRec.QuoteId) && !accQuoteMap.isEmpty() && accQuoteMap.get(quotRec.QuoteId).AccountId!= NULL){
                    system.debug('====The referred Account Id is====='+accQuoteMap.get(quotRec.quoteId).AccountId);
                    Account accInstance = new Account();
                    accInstance.Id = accQuoteMap.get(quotRec.quoteId).AccountId;
                    if(mapContractInfo.containsKey(accInstance.Id) && quotRec.Discount_c__c <= mapContractInfo.get(accInstance.Id).Discount__c ){
                        Contract_Details__c cont = mapContractInfo.get(accInstance.id);
                        System.debug('====cont information========'+cont);
                        Quote qt = new Quote();
                        qt.Id=quotRec.QuoteId;
                        qt.Approved_Discount_corp__c=quotRec.Discount_c__c; 
                        qt.Approval_Status_Quote__c ='Approved';
                        quoteList.add(qt);
                    }
                    else
                    {
                        Quote qt = new Quote();
                        qt.Id=quotRec.QuoteId;
                        qt.Approved_Discount_corp__c=quotRec.Discount_c__c; 
                        qt.Approval_Status_Quote__c ='Approval Required';
                        quoteList.add(qt);
    
                    }
                }
            }
            system.debug('=======The list to update'+quoteList);
            if(!quoteList.isEmpty()){
                update quoteList;
            }
  
    }              
    
    // =================================== Delete Method ===========================
    
    
     public static void validate_QuoteContractAfterDelete(List<QuoteLineItem> listQLineItem)
    {
        Set<id> quoteSet = new Set<id>();
        Set<id> prodIdSet = new Set<id>();
        for(QuoteLineItem quot : listQLineItem){
            if(quot.QuoteId!=null){
                quoteSet.add(quot.quoteId);  
            }
            if(quot.Product2Id!=null){
                prodIdSet.add(quot.Product2Id);
            }
        }
        Map<String,Product2> mapOfCode = new Map<String,Product2>();
        for(Product2 prod : [select id,name,Product_Category__c,Sub_Category__c  from Product2 WHERE Id in : prodIdSet ]){
            String pkey = prod.Product_Category__c+'/'+prod.Sub_Category__c;
            System.debug('----THE Parent Key is Product---------'+pkey);
            mapOfCode.put(pkey,prod);
        }
        Map<Id,Quote> accQuoteMap = new Map<Id,Quote>();
        Set<Id> accountIdSet = new Set<id>();
        for(Quote quot : [SELECT Id,AccountId,OpportunityId,Approval_Status_Quote__c,RecordType.Name from Quote where Id  IN :quoteSet]){
            accountIdSet.add(quot.AccountId);
            accQuoteMap.put(quot.id,Quot);
        }
        System.debug('====THE List of the AccountSet is===='+accountIdSet);
        System.debug('====THE List of the accQuoteMap is===='+accQuoteMap);
        System.debug('====THE List of the accQuoteMap is===='+accQuoteMap.values());
        List<Contract_Details__c> mapWithContract = [SELECT Id,Name,Customer__c,Brand__c,Product_Sub_Category__c,Discount__c,Valid_From__c,Valid_To__c FROM Contract_Details__c where Valid_To__c >= Today AND Customer__c in:accountIdSet];
        Map<Id,Contract_Details__c> mapContractInfo = new Map<Id,Contract_Details__c>();
        for(Contract_Details__c con : mapWithContract ){
            String pkey = con.Brand__c+'/'+con.Product_Sub_Category__c;
            System.debug('----THE Parent Key is contract---------'+pkey);
            if(mapOfcode.containsKey(pkey)){
                mapContractInfo.put(con.Customer__c,con);
            }
        }
        System.debug('=======The details of contract is====='+mapContractInfo);
        List<Quote>quoteList=new List<Quote>();
        //Modified by:vinoth kumar
        //The quote list was taking duplicate which causes error, to avoid that created set of quote
        set<Quote> QuotesSet = new set<Quote>(); 
        for(QuoteLineItem quot : listQLineItem){
            if(accQuoteMap.containsKey(quot.QuoteId) && !accQuoteMap.isEmpty() && accQuoteMap.get(quot.QuoteId).AccountId!= NULL){
                system.debug('====The referred Account Id is====='+accQuoteMap.get(quot.quoteId).AccountId);
                Account accInstance = new Account();
                accInstance.Id = accQuoteMap.get(quot.quoteId).AccountId;
              
                    Contract_Details__c cont = mapContractInfo.get(accInstance.id);
                    System.debug('====cont information========'+cont);
                    Quote qt = new Quote();
                    qt.Id=quot.QuoteId;
                   
                    qt.Approval_Status_Quote__c ='None';
                    QuotesSet.add(qt);
              
            }
        }
        quoteList.addAll(QuotesSet);
        system.debug('=======The list to update'+quoteList);
        if(!quoteList.isEmpty()){
            update quoteList;
        }
    }
    
}