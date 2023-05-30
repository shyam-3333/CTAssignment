public with sharing class Clone_QuoteItems1 {

    Id quoteid;
    List<Quote_Items__c> qitem = new List<Quote_Items__c>();
    
    public Clone_QuoteItems1(ApexPages.StandardController controller) {

    }
   
    public PageReference autoRun(){
        quoteid = ApexPages.Currentpage().getParameters().get('id');
        if(quoteid == null)
            return null;
        
        Schema.DescribeSObjectResult r = Quote.sObjectType.getDescribe();   
        Map<String,Schema.SObjectField> M = r.fields.getMap(); 
       
        String SOQL = 'Select '; 
        for(String fieldName : M.keySet()){
               SOQL += fieldName + ',';  
        } 
    
        SOQL = SOQL.substring(0,SOQL.length()-1); 
        SOQL += ' From Quote where id=\''+  quoteid +'\' LIMIT 1' ;  

        Quote S = Database.query(SOQL); 
    
        Quote sss = (Quote)S;
    
        Quote newsss = sss.clone(false,true);
         // piyush 
        newsss.Cloned__c = true;
        //newsss.Mechanical_Bought_out_Cost_INR__c = null;
        //newsss.Mechanical_Fabrication_Cost_INR__c = null;
        //newsss.Electrical_Bought_out_Cost_INR__c = null;
        //newsss.Electrical_Fabrication_Cost_INR__c = null;
        //newsss.Contingency_INR__c = null;
        //newsss.Overheads_INR__c = null;
        //newsss.Packing_and_Forwarding_INR__c = null;
       // newsss.Transport_Charges_INR__c = null;
        // newsss.Transit_Insurance_INR__c = null;
         //
        insert newsss;
        System.debug('------------------------------------------------------------------------->'+newsss); 
       
        Schema.DescribeSObjectResult r1 = Quote_Items__c.sObjectType.getDescribe();   
        Map<String,Schema.SObjectField> M1 = r1.fields.getMap(); 
       
        String SOQL1 = 'Select '; 
        for(String fieldName : M1.keySet()){
               SOQL1 += fieldName + ',';  
        } 
    
        SOQL1 = SOQL1.substring(0,SOQL1.length()-1); 
        SOQL1 += ' From Quote_Items__c where Quote__c=\''+ quoteid +'\' Order By S_No__c';  

        Quote_Items__c[] S1 = Database.query(SOQL1); 
    
        Quote_Items__c[] newsss1 = S1.deepclone(false);
        for(Integer i=0; i<newsss1.size();i++){
            newsss1[i].Quote__c = newsss.Id;
            newsss1[i].Cloned__c = true;
            
        }
        insert newsss1;   
       
        PageReference pageRef = new PageReference('/' + newsss.Id );
        pageRef.setRedirect(true);
        return pageRef;

    }
    
  /*  static testmethod void CloneTest1(){
        
        Opportunity o = new Opportunity();
        o.Name = 'Test for Clone';
        o.CloseDate = System.Today() + 10;
        o.StageName = 'Under Study';
        insert o;
        
        Quote q = new Quote();
        q.Name = 'Test for Clone';
        q.OpportunityID = o.ID;
        insert q;
        
        List<Quote_Items__c> qlilist = new List<Quote_Items__c>();
        
        Quote_Items__c qi = new Quote_Items__c();
        qi.Quote__c = q.ID;
        qlilist.add(qi);
        
        Quote_Items__c qi1 = new Quote_Items__c();
        qi1.Quote__c = q.ID;
        qlilist.add(qi1);
        
        insert qlilist;
        
                
        ApexPages.CurrentPage().getParameters().Put('id',q.id);
        ApexPages.StandardController std = new ApexPages.StandardController(q);
        Clone_QuoteItems1 clone1 = new Clone_QuoteItems1(std);
        clone1.autoRun();
        
       // Delete qi1;
       
       Quote q0 = new Quote();
        q0.Name = 'Test for Clone';
        q0.OpportunityID = o.ID;
        insert q0;
        
        Delete q0;
        
    }*/
}