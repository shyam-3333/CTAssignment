/*
**Class Name - Titan_MassUpdateQLiClass.
**
**Created By - Mohammad Naved.
**
**Purpose - To mass Update the Quoteline Items with the Additionally Functionality of Dynamically change discount in amount & vice versa.
**
**Naming convaction Followed -Yes
**.
**Number of SOQL queries: 1 out of 100.
*/



public with sharing class Titan_MassUpdateQLiClass {
    
    /*******************************************Start:State*****************************************************************/
    public String strQuoteId ;
    public List<QuoteLineItem >lstQuoteLineItems            {get; set;}
    public Map<Integer,Set<Id>> mapPageNumberSetId {get;set;}
    public List<QuoteLineItem >lstQuoteLineItemsupdate          {get; set;}
    public List<QuoteLineItem >lstQuoteLineItemsOnCancel            {get; set;}
    public Integer lastInsertPageNumber{get;set;}
    public Integer currentPageNumber{get;set;}
    public Set<Id> setPropertyId{get;set;}
    public List<SelectOption> lstPageNumber{get;set;}
    public List<QuoteLineItem> lstCurrentAppointments{get;set;}
    public Boolean isPreviousDisable{get;set;}
    public Boolean isNextDisable{get;set;}
    public Boolean isFilter{get;set;}
    public Boolean isTable{get;set;}
    public List<QuoteLineItem >lstupdateQuoteLineItems ;
    public Integer fromRecord{get;set;}
    public Integer toRecord{get;set;}
    public Integer totalRecord{get;set;}
    public string ascDesc{get;set;}
    public string orderBy{get;set;}
    public Boolean hasRecords{get;set;}
    
    /*******************************************End:State*********************************************************************/
    
    /*******************************************Start:Behaviour***************************************************************/
    /*
    **Method - Titan_MassUpdateQLiClass
    **
    **Parameter -None
    **
    **Purpose - Intializing the class Variable
    */
    public Titan_MassUpdateQLiClass(){
        strQuoteId =ApexPages.currentPage().getParameters().get('QuoteId');
        orderBy = 'PricebookEntry.Product2.Name';
        ascDesc ='asc';
        lstQuoteLineItemsOnCancel = new List<QuoteLineItem >();
        lstQuoteLineItemsupdate  = new List<QuoteLineItem >();
        lstQuoteLineItems = new List<QuoteLineItem >([Select  PricebookEntry.Product2.Name,q.UnitPrice,q.Price_Per_Unit_After_Discount__c ,q.TotalPrice, q.Subtotal, q.Sales_Price_c__c, q.Quantity, q.ListPrice, q.Discount_c__c,Discount_In_Values_For_Corporate__c  From QuoteLineItem q where quoteid =:strQuoteId]);
        //lstQuoteLineItemsOnCancel.add(lstQuoteLineItems);
        if(lstQuoteLineItems.size() > 0){
            BuildPagination(lstQuoteLineItems);
            hasRecords = true;
        } else {
            lstCurrentAppointments = new List<QuoteLineItem>();
            hasRecords = false;
            isPreviousDisable = false;
            isNextDisable = false;
        }
    }
    /*
    **Method - updateQuoteLineItem
    **
    **Parameter -None
    **
    **Purpose - Update the QuoteLineItem According to the user input and redirect to the detail page of Quote.
    */
    public pagereference updateQuoteLineItem(){
        System.debug('**************'+lstQuoteLineItems);
       	set<QuoteLineItem>setQuotelineitems = new set<QuoteLineItem>(); 
        if(lstQuoteLineItemsupdate.size()>0){
            for(QuoteLineItem obj:lstQuoteLineItemsupdate){
                obj.Discount = obj.Discount_c__c;
            	setQuotelineitems.add(obj);
            }
            lstQuoteLineItemsupdate = new list<QuoteLineItem>();
            for(QuoteLineItem obj:setQuotelineitems){
                obj.Discount = obj.Discount_c__c;
            	lstQuoteLineItemsupdate.add(obj);
            }
            update lstQuoteLineItemsupdate;
        }
        PageReference pageRef = new PageReference('/'+strQuoteId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    /*
    **Method - cancelQuoteLineItem
    **
    **Parameter -None
    **
    **Purpose - Cancel the QuoteLineItem to be updated
    */
    public pagereference cancelQuoteLineItem(){
        lstQuoteLineItemsupdate = new List<QuoteLineItem >();
        for(QuoteLineItem obj:lstQuoteLineItems){
        system.debug('++++++++Discount_c__c+++++'+obj.Discount_c__c);
            if(obj.Discount_c__c == 0){
                obj.Discount_In_Values_For_Corporate__c=0;
                obj.Discount = 0;
            
            }
           
            lstQuoteLineItemsupdate.add(obj);
        
        }
        update lstQuoteLineItemsupdate;
        PageReference pageRef = new PageReference('/'+strQuoteId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    private void BuildPagination(List<QuoteLineItem> lstQuoteLineItems){
        
        setPropertyId = new Set<Id>();
        mapPageNumberSetId = new Map<Integer,Set<Id>>();
        lstPageNumber = new List<SelectOption>();
        
        lastInsertPageNumber = 1;
        currentPageNumber = 1;
        isNextDisable = false;
        isPreviousDisable = false;  
        
        fromRecord = 0;
        toRecord = 0;
        totalRecord = lstQuoteLineItems.size(); 
        
        for(QuoteLineItem property : lstQuoteLineItems){
            if(setPropertyId.size() < 9){
                setPropertyId.add(property.Id); 
            }
            else{
                setPropertyId.add(property.Id);
                mapPageNumberSetId.put(lastInsertPageNumber,setPropertyId);
                lastInsertPageNumber++;
                setPropertyId = new Set<Id>();
            }                       
        }
        if(setPropertyId.size() != 0 && setPropertyId.size() < 25){
            mapPageNumberSetId.put(lastInsertPageNumber,setPropertyId);
        }       
        PreparePageNumberList();
        GetCurrentPropertyList();
    }
    
    public void GetCurrentPropertyList(){       
        Set<Id> setCurrentPropIds = mapPageNumberSetId.get(currentPageNumber);
        String strPropId = '(';
        for(Id id : setCurrentPropIds){
            if(strPropId == '('){
                strPropId += '\''+id+'\'';
            }
            else{
                strPropId += ','+'\''+id+'\'';
            }
        }
        
        
        strPropId += ')';
        String query = 'Select  PricebookEntry.Product2.Name,q.UnitPrice, q.TotalPrice, q.Subtotal,q.Price_Per_Unit_After_Discount__c, q.Sales_Price_c__c, q.Quantity, q.ListPrice, q.Discount_c__c,Discount_In_Values_For_Corporate__c From QuoteLineItem q  where Id In '+strPropId;
        query += ' order by '+orderBy+' '+ascDesc;
        system.debug('-------------------Vivek query print----------- : '+query);
        lstCurrentAppointments =Database.query(query);
        lstQuoteLineItemsupdate.addAll(lstCurrentAppointments);
        checkPreviousDisable();
        checkNextDisable(); 
        PrintPageRecordDetail();    
    }
    
    
    public void PreparePageNumberList(){
        for(Integer i=1;i<=mapPageNumberSetId.size();i++){
            lstPageNumber.add(new SelectOption(string.valueof(i),string.valueof(i)));   
        }       
    }
    
    public void GoToPageNumber(){ 
        if(lstCurrentAppointments.size()>0){
            update lstCurrentAppointments;
            lstQuoteLineItemsupdate.addAll(lstCurrentAppointments);
        }       
        GetCurrentPropertyList();
    }
    public void saveError(){
        
    }
    
    public void GoToFirstPage(){
    	lstupdateQuoteLineItems  = new list<QuoteLineItem>();
    	lstupdateQuoteLineItems.addAll(lstCurrentAppointments);
        update lstCurrentAppointments;
        lstQuoteLineItemsupdate.addAll(lstCurrentAppointments);
        currentPageNumber = 1;
        GetCurrentPropertyList();   
    } 
    
    public void GoToNextPage(){
    	lstupdateQuoteLineItems  = new list<QuoteLineItem>();
        if(lstCurrentAppointments.size()>0){
        	lstupdateQuoteLineItems.addAll(lstCurrentAppointments);
            update lstupdateQuoteLineItems;
            lstQuoteLineItemsupdate.addAll(lstCurrentAppointments);
        }   
        currentPageNumber++;
        GetCurrentPropertyList();
    }
    
    public void GoToPreviousPage(){
    	lstupdateQuoteLineItems  = new list<QuoteLineItem>();
    	lstupdateQuoteLineItems.addAll(lstCurrentAppointments);
        update lstupdateQuoteLineItems;
        lstQuoteLineItemsupdate.addAll(lstCurrentAppointments);
        currentPageNumber--;
        GetCurrentPropertyList();   
    }
    
    public void GoToLastPage(){
    	lstupdateQuoteLineItems  = new list<QuoteLineItem>();
    	lstupdateQuoteLineItems.addAll(lstCurrentAppointments);
        update lstupdateQuoteLineItems;
        lstQuoteLineItemsupdate.addAll(lstCurrentAppointments);
        currentPageNumber = mapPageNumberSetId.size();
        GetCurrentPropertyList();
    }   
    
    public void checkPreviousDisable(){
        if(currentPageNumber == 1){
            isPreviousDisable = false;  
        }           
        else{
            isPreviousDisable = true;
        }
    }
    
    public void checkNextDisable(){
        if(currentPageNumber == mapPageNumberSetId.size()){
            isNextDisable = false;
        }
        else{
            isNextDisable = true;
        }
    }
    
    public void PrintPageRecordDetail(){
        system.debug('---------currentPageNumber----------'+currentPageNumber); 
        if(currentPageNumber == mapPageNumberSetId.size() && currentPageNumber != 1){
            toRecord = totalRecord;
            fromRecord = ((mapPageNumberSetId.size() -1)*10) + 1;           
        }
        else if(currentPageNumber == mapPageNumberSetId.size() && currentPageNumber == 1){
            fromRecord = 1;
            toRecord = ((mapPageNumberSetId.size() -1)*10) + mapPageNumberSetId.get(mapPageNumberSetId.size()).size();          
        }   
        else{
            fromRecord = (currentPageNumber * mapPageNumberSetId.get(currentPageNumber).size()) - 9;
            toRecord = (currentPageNumber * mapPageNumberSetId.get(currentPageNumber).size());          
        }       
    }
    /*******************************************End:Behaviour***************************************************************/
}