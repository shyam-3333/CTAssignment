@isTest
public class TestOppTimePlan{
  @isTest public static void unitTest(){
       Account acct = new Account();
            acct.Name = 'test';
            insert acct;
       Opportunity opp = new Opportunity();
            opp.Name = 'test';
            opp.AccountId = acct.ID;
            opp.CloseDate = system.today();
            opp.StageName = 'Quotation Submission';
            opp.RFQ_Received_Date_Date__c = system.today();
            opp.RFQ_Due_Date__c = system.today();      
            insert opp;
            ApexPages.StandardController stdCon=new ApexPages.StandardController(opp);
            OppTimePlan oopcon=new OppTimePlan(stdCon);
            Apexpages.currentpage().getParameters().put('index','1');
            oopcon.editRecord();
            oopcon.addRow();
            oopcon.deleteRow();
            oopcon.cancel();
           
           
     }
}