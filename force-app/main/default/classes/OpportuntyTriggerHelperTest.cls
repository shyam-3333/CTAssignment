@isTest
public class OpportuntyTriggerHelperTest {
    public static testMethod void updateCustomerType(){
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.name = 'OpportunityTrigger';
        tt.active__c = true;
            insert tt;
        List<Account> accLst = new List<Account>();
        for(Integer i = 0; i < 3; i++){
                Account acc = new Account();
                acc.Name = 'test'+i;
                acc.Type = 'Prospect';
                acc.BillingPostalCode = '506319';
                acc.Lead_first_contact_date__c = system.Today();
                accLst.add(acc);
        }
        insert accLst;
        List<Opportunity> oppLst = new List<Opportunity>();
        for(Integer i = 0; i < 3; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'test'+i;
            opp.AccountId = accLst[i].Id;
            opp.stageName = 'Opportunity Won';
            opp.CloseDate = system.Today();
            oppLst.add(opp);
        }
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.AccountId = accLst[0].Id;
        opp.stageName = 'Closed Won';
        opp.CloseDate = system.Today();
        oppLst.add(opp);
        insert oppLst;
        OpportuntyTriggerHelper oppTrig = new OpportuntyTriggerHelper();
        oppTrig.autoUpdateOfCustomerType(oppLst);
         Opportunity opp1 = new Opportunity();
        opp1.Name = 'test';
        opp1.AccountId = accLst[0].Id;
        opp1.stageName = 'Closed Won';
        opp1.CloseDate = system.Today();
        insert opp1;
        User u = [Select ID,UserRole.Name,isActive from User Where UserRole.name Like '%Electric%' and isActive = true limit 1];
          User u1 = [Select ID,UserRole.Name,isActive from User Where  UserRole.name Like '%Mechani%' and isActive = true limit 1];
        opp1.stageName = 'Qualified-RFQ study';
         opp1.Member1__c = u1.Id;
         opp1.Member2__c = u.Id;
        opp1.RFQ_status__c = 'Received';
        opp1.RFQ_Received_Date_Date__c = system.today();
        opp1.RFQ_Received_Visit_Date__c = system.today();
        update opp1;
    }
}