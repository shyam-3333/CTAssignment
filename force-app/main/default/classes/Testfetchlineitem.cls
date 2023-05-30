@isTest 
private class Testfetchlineitem {

    static testMethod void myUnitTest() {
       Account ac= new Account();
       ac.Name='Test';
       insert ac;
     
       
        Contact conNew = new Contact();
        conNew.Firstname = 'PeeWee';
        conNew.LastName = 'Herman';
        conNew.AccountId = ac.Id;
        conNew.Email='sachin.deshmukh@kvpcorp.com';
        insert conNew;
        
      
       Opportunity opp = new Opportunity();
       opp.Name = 'Test';
       opp.StageName ='Proforma Invoice';
       opp.CloseDate = System.today();
       opp.AccountId = ac.id;
       insert opp;
       
       Quote q = new Quote();
       q.OpportunityId = opp.Id;
       q.Name = 'Field';
       q.ContactId = conNew.id;
       insert q;
       
       
       Quote_Items__c qi = new Quote_Items__c();
       qi.Quote__c = q.Id;
       qi.Quantity__c = 5;
       qi.Station_Description__c = 'Test';
       qi.Unit_Price__c = 10;
       insert qi;
       
       Apexpages.StandardController stdController = new Apexpages.StandardController(q); // here t is the contact instance
 
       fetchlineitem controller = new fetchlineitem(StdController);
       controller.getQLineItem();
       
 }
}