@isTest
private class TestClone_QuoteItems1 {

    static testMethod void CloneTest() {
        // TO DO: implement unit test
        test.startTest();
         Opportunity o = new Opportunity();
        o.Name = 'Test for Clone';
        o.CloseDate = System.Today() + 10;
        o.StageName = 'Preliminary Opportunity';
        insert o;
        
        Quote q = new Quote();
        q.Name = 'Test for Clone';
        q.OpportunityID = o.ID;
        insert q;
        
      
                
        ApexPages.CurrentPage().getParameters().Put('id',q.id);
        ApexPages.StandardController std = new ApexPages.StandardController(q);
        Clone_QuoteItems1 clone1 = new Clone_QuoteItems1(std);
        clone1.autoRun();
        
       
    }
}