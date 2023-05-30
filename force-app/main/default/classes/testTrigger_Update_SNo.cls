/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/8/2019    TO1    Fixing test class issue
*/
@isTest (seealldata = true)
public class testTrigger_Update_SNo
{
    public static testMethod void Method1()
    {
        Account acct = new Account();
        acct.Name = 'test';
        insert acct;
        
        
        //List<RecordType> lstreco = [select name,id from RecordType where Sobjecttype='Opportunity' and name='Lifestyle'];
        opportunity opp = new opportunity();
        opp.Name = 'test';
        //opp.RecordTypeId= lstreco[0].Id;
        opp.AccountId = acct.Id;
        opp.Amount=1500000;
        opp.StageName = 'Quotation Submission';
        opp.CloseDate=System.today();
        opp.RFQ_Received_Date_Date__c=System.today();
        opp.RFQ_Due_Date__c=System.today();
        insert opp;
        
        //List<RecordType> lstreco1 = [select name,id from RecordType where Sobjecttype='Quote' and name='Lifestyle'];
        Quote q = new Quote();
        q.name= 'test';
        //q.RecordTypeId= lstreco1[0].Id;
        q.opportunityId = opp.id;
        insert q;
        
        test.startTest();//<T01>
        
        Quote_Items__c qt1 = new Quote_Items__c();
        qt1.Quote__c= q.id;
        qt1.S_No__c = 1234;
        insert qt1;
        
        /*Quote_Items__c qt2 = new Quote_Items__c();
        qt2.Quote__c= q.id;
        qt2.S_No__c = qt1.S_No__c - 1;
        insert qt2;*/
        
        Quote_Items__c qt = new Quote_Items__c();
        qt.Quote__c= q.id;
        qt.S_No__c = 123;
        insert qt;
        
        delete qt;
        
        
        
        test.stopTest();//<T01>
    }
}