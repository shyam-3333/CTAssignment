@isTest
public class TestForUpdateAmountApprovalTrigger 
{
	static  testMethod void SomeMethod()
    {
        Account a=new Account();
        a.name='Demo';
        insert a;
        Opportunity o=new Opportunity();
        o.name='Demo';
        o.StageName='Quote Preparation';
        o.Amount=10000000;
        o.CloseDate=System.today();
        o.Project_Type__c='Domestic';
        o.Type='New Opportunity';
        
        o.AccountId=a.id;
        insert o;
        o.StageName='Revised Quote Submission';
        update o;
        
        o.Amount=10000;
        update o;
        
        
    }
}