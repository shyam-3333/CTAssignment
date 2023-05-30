@isTest(seeAllData=true)
public class UpdateContractApproval_test {
    @isTest
    public static void UpdateContractApprovalFunction(){
         Test.startTest();
        Account ac= new Account();
        ac.Name='Test';
        insert ac;
        
        Pricebook2  standardPB = new Pricebook2();
        standardPB = [select id from Pricebook2 where isStandard=true limit 1];
        
         Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName ='Proforma Invoice';
        opp.CloseDate = System.today();
        opp.AccountId = ac.id;
        insert opp;
        
        Quote q = new Quote();
        q.OpportunityId = opp.Id;
        q.Name = 'Field';
        q.Email='test@gmail.com';
        q.Pricebook2Id =standardPB.id;
        // q.ContactId = conNew.id;
        insert q;
        q.id=q.id;
        update q;
    }

}