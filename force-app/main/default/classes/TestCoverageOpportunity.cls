/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
private class TestCoverageOpportunity {
    
    /*static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Map<String,Schema.RecordTypeinfo> rec = Opportunity.SobjectType.getDescribe().getRecordTypeInfosByName();
        //Profile p = [Select Id from Profile where Name LIKE '%Team member%' limit 1];
        
        //User u = [Select ID from User Where ProfileID =: p.ID AND Alias != 'prakash' AND isActive = true limit 1];
        //User u1 = [Select ID from User Where ProfileID =: p.ID AND Alias != 'prakash' AND ID !=: u.Id  AND isActive = true limit 1];
        User objUser = TestDataFactory.getMechanicalRoleUser();//<T01>
        User objUser1 = TestDataFactory.getElectricalRoleUser();//<T01>
        Account a = new Account(Name = 'Test Account for Test');
        insert a;
        
        Opportunity o = new Opportunity();
        o.Name = 'Test for Opp Test Method';
        o.RecordTypeId = rec.get('Initial Record type').getRecordTypeId();
        o.AccountID = a.ID;
        o.Type = 'New Opportunity';
        o.StageName = 'Preliminary Opportunity';
         o.Member1__c = objUser.Id;
        o.Member2__c = objUser1.Id;
        o.CloseDate = System.Today() + 10;
        Insert o; 
        
        Quote q = new Quote();
        q.Name = 'Test for Quote';
        q.OpportunityID = o.ID;
        insert q;
        
        
        
        
        QuoteDocument qd = new QuoteDocument();
        qd.QuoteId = q.Id;
        Blob b = blob.valueOf('PDF');
        qd.Document =  b;
        insert qd;        
        
        ApexPages.CurrentPage().getParameters().Put('id',q.id);
        QuotePDFCopy qpd = new QuotePDFCopy();
        qpd.copy();
        
        delete q;
        
    }*/
}