public class QuoteLIQuoteOpportunity_DataHandler {
    public String compId{get;set;}
    public WrapperClass wrapList{get;set;}
    
    public QuoteLIQuoteOpportunity_DataHandler(ApexPages.StandardController stdController){
        compId = Apexpages.currentpage().getParameters().get('Id');
        System.debug('----compId----' + compId);
        getQuoteData();
        System.debug('-----wrapList-----'+wrapList.sObjQuoteDataList);
        //redirect(compId);
    } 
    
    public void getQuoteData(){
        
        List<QuoteLineItem> sObjList = new List<QuoteLineItem>();
        wrapList = new WrapperClass();
        WrapperClass wrapObj = new WrapperClass();
        for(Quote eachQuote :  [SELECT Id,Name,Opportunity.Owner.FirstName,Recipient_Email_ID__c,Opportunity.Owner.LastName,Opportunity.Owner.Street,
                                Opportunity.Owner.City,Opportunity.Owner.State,Opportunity.Owner.Country,Opportunity.Owner.PostalCode,
                                Opportunity.Owner.Phone,Opportunity.Owner.Email,Opportunity.Owner.UserRole.Name,Insti_ref__c,(SELECT Id,QLI_Total_Price__c,TotalPrice,Product2.Name,Product2.IsActive,CPG__c,Sales_Price_c__c,
                                                                                 Quantity,Insti_Order_reference_No__c FROM QuoteLineItems
                                                                                 WHERE Product2.name != ''AND Product2.IsActive =true)                                              
                                
                                
                                FROM Quote WHERE Id =: compId AND RecordType.Name = 'Jewellery' ORDER BY CreatedDate Desc limit 1]){
                                    	wrapObj.qtdata = eachQuote;
                                    for(QuoteLineItem each : eachQuote.QuoteLineItems){
                                        sObjList.add(each);
                                    }     
                                    System.debug('------eachQuote-------' +eachQuote);
                                }
        System.debug('------gfgfgfgfgfg-------' +sObjList.size());
        if(sObjList.size()>0){
            wrapObj.sObjQuoteDataList = sObjList; 
        }
        wrapList=wrapObj;
        System.debug('-----wrapList-----'+wrapList);
        System.debug('-----wrapList sObjQuoteDataList-----'+wrapObj.sObjQuoteDataList);
    }
    public class WrapperClass{
        public List<QuoteLineItem> sObjQuoteDataList {get;set;}
        public Quote qtdata{get;set;}
    }
    public PageReference redirect(String Id){
        PageReference pageRef = new PageReference('/0Q2' + Id);
        System.debug('Hiiiiiiii' + 'Page ref is --> '+pageRef);
        return pageRef;
    }
}