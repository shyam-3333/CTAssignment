/*
* Created by    : Praveen (Lister)
* Created on    : Nov-21-2019
* Purpose       : This handler class has the consolidated logic of the following triggers
salespriceUpdate,QuoteRollUptotalAmount,updateCategorynSubcategory,RollUpAmount and AccountContractValidation 
********************************************************************************************************************************************************************************
ModifiedBy            Date       Tag     Description
********************************************************************************************************************************************************************************
Praveen(Lister)     11/21/2019   T01   Populate price fields in QuoteLineItem
Praveen(Lister)     11/21/2019   T02   Update QuoteLineItem fields from OpportunityLineItem
Praveen(Lister)     11/22/2019	 T03   Update Total amount in Quote
Praveen(Lister)     11/22/2019	 T04   Update Product Category and Sub Category in Quote
Praveen(Lister)     11/25/2019	 T05   Delete the QuoteLineItem if the Product is in Lost status
Praveen(Lister)     11/25/2019	 T06   Update Quote with Approval Or Approval Required statsu
*/
public class QuoteLineItemTriggerHandler {
    
    //<Recordtype Initialization> 
    private final static Id opptRecordTypeJewellery = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeJewellery).getRecordTypeId();
    private final static Id opptRecordTypeLifestyle = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeLifestyle).getRecordTypeId();
    private final static Id opptRecordTypeWatches = Schema.SObjectType.Quote.getRecordTypeInfosByName().get(Util_Common.recordTypeWatches).getRecordTypeId();
    //</Recordtype Initialization>
    //Variable Declaration
    private final static string categoryError='Product category or sub category should not be left blank.';
    private final static string frontSlash='/';
    private static double dobtotalPrice;
    private static double dobCusSubTotal;
    private static double dobCusTotalPrice;
    private static double dobTotCusCharges;
    private static double dobAllCusCharges;
    private static double dobPriceBookEntry;
    private static String productCategory;
    private static String productSubCategory;
    private static Id quoteRecordTypeID;
    private static String keyOppIdNProdId;
    public static boolean isUpdate=true;
    private static string productStatus ='Lost';
    //</Variable Declaration>
    
    public static void populateQLIFields(List<QuoteLineItem> listQLINew,Map<Id, QuoteLineItem> mapOldQuoteLineItem){
        Set<Id> setQuoteId = new Set<Id>();
        Set<ID> setOppId = new Set<ID>();
        Set<ID> setProdId = new Set<ID>();
        List<Quote> lstQuote = new List<Quote>();
        List<OpportunityLineItem> listOpptLineItem=new List<OpportunityLineItem>();
        Map<Id,Quote> mapIdNQuote = new Map<Id,Quote>();
        Map<String,OpportunityLineItem> mapOppIdnOpptLineItem =new Map<String,OpportunityLineItem>();
        
        for(QuoteLineItem objQLI : listQLINew)
        {
            //before it was objQLI.Quote.Id and it replaced with proper context variable objQLI.Quoteid
            setQuoteId.add(objQLI.Quoteid);
        }
        if(setQuoteId.size()>0){
            lstQuote = [select id,AccountId,OpportunityId,Approval_Status_Quote__c,RecordtypeId from Quote where id =:setQuoteId];
            if(lstQuote.size()>0){
                For(Quote objQt : lstQuote){
                    mapIdNQuote.put(objQt.Id,objQt);
                }
            }
        }
        //<T01>
        if(mapIdNQuote.size()>0){
            for(QuoteLineItem objQLI : listQLINew)
            {
                if(mapIdNQuote.containsKey(objQLI.QuoteId) && mapIdNQuote.get(objQLI.QuoteId)!=null){
                    quoteRecordTypeID = mapIdNQuote.get(objQLI.QuoteId).RecordtypeId;                    
                    if(quoteRecordTypeID!=opptRecordTypeJewellery && quoteRecordTypeID!=opptRecordTypeLifestyle && quoteRecordTypeID!=opptRecordTypeWatches){
                        if(trigger.isInsert){
                            setOppId.add(objQLI.Opportunity_Id__c);
                            setProdId.add(objQLI.Product_ID__c);
                            if(objQLI.Roll_Up__c==false)     
                            {
                                objQLI.Sales_Price_1__c=objQLI.UnitPrice;  
                                objQLI.UnitPrice=0;  // need to check with client
                            }
                        }
                        if(trigger.isUpdate){
                            system.debug('upd');
                            if(mapOldQuoteLineItem!=null &&(objQLI.Roll_Up__c!=mapOldQuoteLineItem.get(objQLI.Id).Roll_Up__c))  {
                                 system.debug('updinside');
                                if(objQLI.Roll_Up__c==true && objQLI.UnitPrice==0)     
                                {
                                    objQLI.UnitPrice=objQLI.Sales_Price_1__c;  
                                }
                                if(objQLI.Roll_Up__c==false){
                                    objQLI.UnitPrice=0;  
                                }
                            }
                        }
                        objQLI.Total_Price_1__c=objQLI.Quantity * objQLI.Sales_Price_1__c;
                        objQLI.subtotal_1__c=objQLI.Quantity * objQLI.Sales_Price_1__c;
                    }
                }
            }
        }
        //</T01>
        //<T02>
        if(trigger.isInsert){
            if(setOppId.size()>0 && setProdId.Size()>0){
                listOpptLineItem =[select Id,Quantity,Min_Lot_Size_Nos__c,OpportunityID,FA_Price_Piece__c,BOI_Cost_Piece__c,Spl_Process_Cost_Piece__c,PricebookEntry.Product2Id,Material_Cost_Piece__c,Value_ADD_Piece__c,EAU_Quantity__c,One_Time_Development_Charges_Part__c from OpportunityLineItem where OpportunityID IN: setOppId AND PricebookEntry.Product2Id IN: setProdId];
                if(listOpptLineItem.size()>0){
                    for(OpportunityLineItem objOptLI :listOpptLineItem){
                        mapOppIdnOpptLineItem.put(String.valueof(objOptLI.OpportunityId).substring(0,15)+String.valueof(objOptLI.PricebookEntry.Product2Id).substring(0,15),objOptLI);
                    }
                }
                if(mapOppIdnOpptLineItem.size()>0){
                    for(QuoteLineItem objQLI : listQLINew){
                        keyOppIdNProdId = String.valueof(objQLI.Opportunity_Id__c)+String.valueof(objQLI.Product_ID__c);
                        if(mapOppIdnOpptLineItem.containskey(keyOppIdNProdId) && mapOppIdnOpptLineItem.get(keyOppIdNProdId)!=null){
                            objQLI.FA_Price_Piece__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).FA_Price_Piece__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).FA_Price_Piece__c:objQLI.FA_Price_Piece__c);
                            objQLI.Material_Cost_Piece__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).Material_Cost_Piece__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).Material_Cost_Piece__c:objQLI.Material_Cost_Piece__c);
                            objQLI.Value_ADD_Piece__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).Value_ADD_Piece__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).Value_ADD_Piece__c:objQLI.Value_ADD_Piece__c);
                            objQLI.Spl_Process_Cost_Piece__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).Spl_Process_Cost_Piece__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).Spl_Process_Cost_Piece__c:objQLI.Spl_Process_Cost_Piece__c);
                            objQLI.BOI_Cost_Piece__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).BOI_Cost_Piece__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).BOI_Cost_Piece__c:objQLI.BOI_Cost_Piece__c);
                            objQLI.Quantity=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).Quantity!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).Quantity:1);
                            objQLI.One_Time_Development_Charges_Part__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).One_Time_Development_Charges_Part__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).One_Time_Development_Charges_Part__c:objQLI.One_Time_Development_Charges_Part__c);
                            objQLI.Min_Lot_Size_Nos__c=(mapOppIdnOpptLineItem.get(keyOppIdNProdId).Min_Lot_Size_Nos__c!=null?mapOppIdnOpptLineItem.get(keyOppIdNProdId).Min_Lot_Size_Nos__c:objQLI.Min_Lot_Size_Nos__c);
                        }
                    }
                }
            }      
        }
        //</T02>
    }
    //<T03>
    public static void updateQuoteFields(List<QuoteLineItem> listQLINew,Map<Id, QuoteLineItem> mapOldQuoteLineItem){
        Set<Id> setQuoteId = new Set<Id>();
        Map<Id,Double> mapIdNPrice = new Map<Id,Double>();
        list<Quote>listQuoteUpdate = new  list<quote>();
        Map<Id,Quote> mapIDNQuoteUpdate = new Map<Id,Quote>();
        list<Quote> listQuote = new  list<quote>();
        
        Map<Id,Quote> mapIdNQuote = new Map<Id,Quote>();
        Set <Id> setProdId = new Set<Id>();
        Set <Id> setAcctId = new Set<Id>();
        Map<String,Product2> mapKeyNProd = new Map<String,Product2>();
        Map<Id,List<Contract_Details__c>> mapIdNListCont = new Map<Id,List<Contract_Details__c>>();
        boolean isContactUpdate = false;
        
        for(QuoteLineItem objQLI:listQLINew){
            setQuoteId.add(objQLI.QuoteId ); 
            setProdId.add(objQLI.Product2Id);
        }
        // Changed the recursive check variable to runForQli to make sure the quote fields are autopopulated
        if(Util_Common.runForQLI){
            if(setQuoteId.size()>0){
                listQuote = [Select Id,RecordTypeId,Product_Catagory__c,Product_Sub_Category__c,Price_Before_Discount__c,Total_No_of_QuoteLineItem__c,Price_After_Discount__c,Record_Type_Name__c,AccountId,OpportunityId,Approval_Status_Quote__c,Discounted_Total_Cust_Charges__c,Total_Cust_Charges__c,
                             (Select Id,Discount_c__c,Total_Price_Custom__c,custom_subtotal__c,Custom_TotalPrice__c,Total_Cust_Charges__c,All_Customization_Charges__c,PriceBookEntry.Name,QuoteId,Product_Catagory__c,Product_Sub_Category__c from QuoteLineItems) from Quote where Id =: setQuoteId];
                if(listQuote.Size()>0){
                    system.debug('listQuote '+listQuote);
                    for(Quote objQt : listQuote){
                        setAcctId.add(objQt.AccountId);
                        mapIdNQuote.put(objQt.Id,objQt);
                        for(QuoteLineItem objQLI:objQt.QuoteLineItems){
                            if(!trigger.isUpdate || (Trigger.IsUpdate && mapOldQuoteLineItem!=null && mapOldQuoteLineItem.ContainsKey(objQLI.id) && mapOldQuoteLineItem.get(objQLI.id).Total_Price_Custom__c!=objQLI.Total_Price_Custom__c)){
                                if(dobtotalPrice==null)
                                    dobtotalPrice=(objQLI.Total_Price_Custom__c!=null ? objQLI.Total_Price_Custom__c : 0);
                                else
                                    dobtotalPrice+=(objQLI.Total_Price_Custom__c!=null ? objQLI.Total_Price_Custom__c : 0);
                            }
                            //<T05>
                            if(!trigger.isUpdate || (Trigger.IsUpdate && mapOldQuoteLineItem!=null && mapOldQuoteLineItem.ContainsKey(objQLI.id) && mapOldQuoteLineItem.get(objQLI.id).custom_subtotal__c!=objQLI.custom_subtotal__c)){
                                if(dobCusSubTotal==null)
                                    dobCusSubTotal=(objQLI.custom_subtotal__c!=null ? objQLI.custom_subtotal__c : 0);
                                else
                                    dobCusSubTotal+=(objQLI.custom_subtotal__c!=null ? objQLI.custom_subtotal__c : 0);
                            }
                            if(!trigger.isUpdate || (Trigger.IsUpdate && mapOldQuoteLineItem!=null && mapOldQuoteLineItem.ContainsKey(objQLI.id) && mapOldQuoteLineItem.get(objQLI.id).Custom_TotalPrice__c!=objQLI.Custom_TotalPrice__c)){
                                if(dobCusTotalPrice==null)
                                    dobCusTotalPrice=(objQLI.Custom_TotalPrice__c!=null ? objQLI.Custom_TotalPrice__c : 0);
                                else
                                    dobCusTotalPrice+=(objQLI.Custom_TotalPrice__c!=null ? objQLI.Custom_TotalPrice__c : 0);
                            }
                            if(!trigger.isUpdate || (Trigger.IsUpdate && mapOldQuoteLineItem!=null && mapOldQuoteLineItem.ContainsKey(objQLI.id) && mapOldQuoteLineItem.get(objQLI.id).Total_Cust_Charges__c!=objQLI.Total_Cust_Charges__c)){
                                if(dobTotCusCharges==null)
                                    dobTotCusCharges=(objQLI.Total_Cust_Charges__c!=null ? objQLI.Total_Cust_Charges__c : 0);
                                else
                                    dobTotCusCharges+=(objQLI.Total_Cust_Charges__c!=null ? objQLI.Total_Cust_Charges__c : 0);
                            }
                            if(!trigger.isUpdate || (Trigger.IsUpdate && mapOldQuoteLineItem!=null && mapOldQuoteLineItem.ContainsKey(objQLI.id) && mapOldQuoteLineItem.get(objQLI.id).All_Customization_Charges__c!=objQLI.All_Customization_Charges__c)){
                                if(dobAllCusCharges == null)
                                    dobAllCusCharges=(objQLI.All_Customization_Charges__c!=null ? objQLI.All_Customization_Charges__c : 0);
                                else
                                    dobAllCusCharges+=(objQLI.All_Customization_Charges__c!=null ? objQLI.All_Customization_Charges__c : 0);}
                            if(!trigger.isUpdate || (Trigger.IsUpdate && mapOldQuoteLineItem!=null && mapOldQuoteLineItem.ContainsKey(objQLI.id) && mapOldQuoteLineItem.get(objQLI.id).PriceBookEntry.Name!=objQLI.PriceBookEntry.Name)){
                                if(objQLI.PriceBookEntry.Name!=''){
                                    dobPriceBookEntry=objQt.QuoteLineItems.size();
                                }
                            }
                            //</T05>
                        }
                        objQt.Total_Price_Qli__c =(objQt.QuoteLineItems.size()>0?dobtotalPrice:0);
                        //listQuoteUpdate.add(objQt);
                        //Check with titan on business functionality -<T04>
                        if(!trigger.isUpdate){
                            if(objQt.QuoteLineItems.size()>0){
                                for(QuoteLineItem objnewQLI: listQLINew){
                                    if(objnewQLI.Product_Catagory__c == null || objnewQLI.Product_Sub_Category__c == null){
                                        objnewQLI.addError(categoryError);
                                    }
                                    productCategory=objnewQLI.Product_Catagory__c;
                                    productSubCategory=objnewQLI.Product_Sub_Category__c;
                                }
                            }
                            else{
                                objQt.Product_Catagory__c='';
                                objQt.Product_Sub_Category__c='';
                                objQt.Contract_Approval__c=false;
                                objQt.Contract_Approval_Status__c='';
                            }
                            if(productCategory!='' && productSubCategory!=''){
                                objQt.Product_Catagory__c=productCategory;
                                objQt.Product_Sub_Category__c=productSubCategory;
                            }
                        }
                        //</T04>
                        //<T05>
                        if(objQt.RecordTypeId==opptRecordTypeWatches){
                            objQt.Price_Before_Discount__c = (dobCusSubTotal!=null ?dobCusSubTotal:objQt.Price_Before_Discount__c);
                            objQt.Price_After_Discount__c = (dobCusTotalPrice!=null ?dobCusTotalPrice:objQt.Price_After_Discount__c);
                            objQt.Total_Cust_Charges__c = (dobTotCusCharges!=null ?dobTotCusCharges:objQt.Total_Cust_Charges__c);
                            objQt.Discounted_Total_Cust_Charges__c =(dobAllCusCharges!=null ?dobAllCusCharges:objQt.Discounted_Total_Cust_Charges__c);
                            objQt.Total_No_of_QuoteLineItem__c = (dobPriceBookEntry!=null ?dobPriceBookEntry:objQt.Total_No_of_QuoteLineItem__c);
                        }
                        if(objQt.RecordTypeId==opptRecordTypeJewellery){
                            objQt.Price_Before_Discount__c = (dobCusSubTotal!=null ?dobCusSubTotal:objQt.Price_Before_Discount__c);
                            objQt.Price_After_Discount__c = (dobCusTotalPrice!=null ?dobCusTotalPrice:objQt.Price_After_Discount__c);
                            objQt.Total_No_of_QuoteLineItem__c =(dobPriceBookEntry!=null ?dobPriceBookEntry:objQt.Total_No_of_QuoteLineItem__c);
                        }
                        //</T05
                        listQuoteUpdate.add(objQt);
                        mapIDNQuoteUpdate.put(objQt.id,objQt);
                        
                    }
                }
            }
            system.debug('mapIDNQuoteUpdate '+mapIDNQuoteUpdate);
            // <T06>
            // Update the quote with Approval Or Apporoval Required status
            if(mapIdNQuote.size()>0 && setProdId.size()>0){
                List<Product2> listProd = [select id,name,Product_Category__c,Sub_Category__c  from Product2 WHERE Id in : setProdId];
                if(listProd.size()>0){
                    for(Product2 objProd : listProd){
                        mapKeyNProd.put(objProd.Product_Category__c+'/'+objProd.Sub_Category__c,objProd);
                    }
                }
                if(mapKeyNProd.size()>0 && setAcctId.size()>0) {
                    List<Contract_Details__c> listCont = [SELECT Id,Name,Customer__c,Brand__c,Product_Sub_Category__c,Discount__c,Valid_From__c,Valid_To__c FROM Contract_Details__c where Valid_To__c >= Today AND Customer__c in:setAcctId];
                    if(listCont.size()>0){
                        For(Contract_Details__c objCont :listCont ){
                            if(mapKeyNProd.containskey(objCont.Brand__c+'/'+objCont.Product_Sub_Category__c)){
                                if(mapIdNListCont.containskey(objCont.Customer__c)){
                                    mapIdNListCont.get(objCont.Customer__c).add(objCont);
                                }
                                else{
                                    mapIdNListCont.put(objCont.Customer__c,new List<Contract_Details__c>{objCont});
                                }
                            }
                        }
                    }
                }
                for(QuoteLineItem objQLI : listQLINew){
                    if(mapIDNQuoteUpdate.containskey(objQLI.QuoteId) && mapIDNQuoteUpdate.get(objQLI.QuoteId)!=null){
                        if(mapIdNQuote.containskey(objQLI.QuoteId)&& mapIdNQuote.get(objQLI.QuoteId).AccountId!=null &&
                           mapIdNListCont.size()>0 && mapIdNListCont.containskey(mapIdNQuote.get(objQLI.QuoteId).AccountId)){
                               for(Contract_Details__c objCont :mapIdNListCont.get(mapIdNQuote.get(objQLI.QuoteId).AccountId)){
                                   if(objQLI.Product_Catagory__c+'/'+objQLI.Product_Sub_Category__c == objCont.Brand__c+'/'+objCont.Product_Sub_Category__c && objQLI.Discount_c__c <= objCont.Discount__c ){
                                       isContactUpdate=true;
                                   }
                               }
                           }
                        else{
                            isContactUpdate=false;
                        }
                        if(isContactUpdate){
                            mapIDNQuoteUpdate.get(objQLI.QuoteId).Approved_Discount_corp__c = objQLI.Discount_c__c;
                            mapIDNQuoteUpdate.get(objQLI.QuoteId).Approval_Status_Quote__c =Util_Common.APPROVED;
                        }
                        else{
                            mapIDNQuoteUpdate.get(objQLI.QuoteId).Approved_Discount_corp__c = objQLI.Discount_c__c;
                            mapIDNQuoteUpdate.get(objQLI.QuoteId).Approval_Status_Quote__c =Util_Common.APPROVALREQ;
                        }
                    }
                }
            }
            //</T06>
            if(mapIDNQuoteUpdate.size()>0){
                try{
                    system.debug('one '+mapIDNQuoteUpdate);
                    update mapIDNQuoteUpdate.values();
                    Util_Common.runForQLI= false;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
        }
    }
    //</T03>
    //
    //<T05>
    //Suggestion - Instead of deleting the line, Prevent from adding the line if product is Lost
    public static void deleteQLI(List<QuoteLineItem> listQLINew){
        Set<ID> setOppId = new Set<ID>();
        Set<ID> setQLIId= new Set<ID>();
        Set<ID> setProdId = new Set<ID>();
        Set<ID> delProdId = new Set<ID>();
        List<QuoteLineItem> listDelQLI = new List<QuoteLineItem>(); 
        if(trigger.isInsert){
            for(QuoteLineItem objQLI : listQLINew){
                setOppId.add(objQLI.Opportunity_Id__c);
                setProdId.add(objQLI.Product_ID__c);
            } 
        }
        if(setOppId.size()>0 || setProdId.size()>0){
            List<OpportunityLineItem> listOLI = [select ID,Status__c,ProductID__c from OpportunityLineItem where OpportunityID IN: setOppId OR ProductID__c IN: setProdId];
            if(listOLI.size()>0){
                for(OpportunityLineItem objOLI : listOLI){
                    if(objOLI.Status__c == productStatus)
                    {
                        delProdId.add(objOLI.ProductID__c);
                    }
                }
            }
            if(delProdId.size()>0){
                For(QuoteLineItem objQLI : listQLINew )
                {
                    if(delProdId.Contains(objQLI.Product_ID__c)){
                        QuoteLineItem ql = new QuoteLineItem(Id = objQLI.Id);
                        listDelQLI.add(ql);
                    }
                }
            }
            if(listDelQLI.size()>0){
                try{
                    delete listDelQLI;
                }
                catch(Exception e){
                    Debug_Logs__c excp = Util_Common.processException(e,true,'');
                }
            }
        }
    }
    //</T05>
}