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
private class TestClone_QuoteItems {

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
        
       /* List<Quote_Items__c> qlilist = new List<Quote_Items__c>();
        
        Quote_Items__c qi = new Quote_Items__c();
        qi.Quote__c = q.ID;
        qlilist.add(qi);
        
        Quote_Items__c qi1 = new Quote_Items__c();
        qi1.Quote__c = q.ID;
        qlilist.add(qi1);
        
        test.stopTest();
        
        insert qlilist;
        List<Quote_Items__c> qlilist11=[select id from Quote_Items__c where Quote__c =: q.ID];
        System.assertequals(2,qlilist11.size());*/
                
        ApexPages.CurrentPage().getParameters().Put('id',q.id);
        ApexPages.StandardController std = new ApexPages.StandardController(q);
        Clone_QuoteItems clone1 = new Clone_QuoteItems(std);
        clone1.autoRun();
        
       // Delete qi1;
    }
}