@isTest
public class Opportunity_Stage_History_ReportTest {

    @isTest
    public static void testmethod1()
    {
        Account acc=new Account();
        acc.Name = 'Acc1';
        acc.AccountNumber = '123';
        acc.BillingPostalCode  = '586101';
        insert acc;
        
        Opportunity opp = new Opportunity();
        Opp.Name = 'opp1';
        Opp.AccountId = acc.Id;
        Opp.StageName = 'Preliminary Opportunity';
        Opp.Type = 'Scope Change Amendment';
        Opp.CloseDate = system.today();
        Opp.Amount = 100;
        insert Opp;
        /*
        Opp.StageName = 'Qualified-RFQ study';
        update opp;
        */
        Opportunity_Stage_History_ReportClass oppH =new Opportunity_Stage_History_ReportClass();
        oppH.startDate = system.today().addDays(-1);
        oppH.tillDate = system.today();
        oppH.selectedStage ='Preliminary Opportunity';
        oppH.getOpportunityInfo();
        
        pageReference pageRef = oppH.download();
        
        Test.setCurrentPageReference(pageRef);
        oppH.getOpportunityInfoDownLoad();
        
        List<SelectOption> selectOpt =oppH.getStageName();
    }
}