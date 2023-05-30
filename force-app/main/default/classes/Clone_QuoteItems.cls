public with sharing class Clone_QuoteItems {

    Id id;
    List<Quote_Items__c> qitem = new List<Quote_Items__c>();
    
    public Clone_QuoteItems(ApexPages.StandardController controller) {

    }
   
    public PageReference autoRun(){
        id = ApexPages.Currentpage().getParameters().get('id');
        if(id == null)
            return null;
        
        Schema.DescribeSObjectResult r = Quote.sObjectType.getDescribe();   
        Map<String,Schema.SObjectField> M = r.fields.getMap(); 
       
        String SOQL = 'Select '; 
        for(String fieldName : M.keySet()){
               SOQL += fieldName + ',';  
        } 
    
        SOQL = SOQL.substring(0,SOQL.length()-1); 
        SOQL += ' From Quote where id=\''+  id +'\' LIMIT 1' ;  

        Quote S = Database.query(SOQL); 
    
        Quote sss = (Quote)S;
    
        Quote newsss = sss.clone(false,true);
         // piyush 
        newsss.Cloned__c = true;
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
        SOQL1 += ' From Quote_Items__c where Quote__c=\''+ id +'\' Order By S_No__c';  

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
    
   /*static testmethod void CloneTest(){
        
        Opportunity o = new Opportunity();
        o.Name = 'Test for Clone';
        o.CloseDate = System.Today() + 10;
        o.StageName = 'Preliminary Opportunity';
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
        List<Quote_Items__c> qlilist11=[select id from Quote_Items__c where Quote__c =: q.ID];
        System.assertequals(2,qlilist11.size());
                
        ApexPages.CurrentPage().getParameters().Put('id',q.id);
        ApexPages.StandardController std = new ApexPages.StandardController(q);
        Clone_QuoteItems clone1 = new Clone_QuoteItems(std);
        clone1.autoRun();
        
        Delete qi1;

        
    }*/
}