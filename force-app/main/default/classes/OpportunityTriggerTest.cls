@isTest
public class OpportunityTriggerTest {

    public static testMethod void updateCustomerType(){
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'OpportunityTrigger';
        tt.Active__c = true;
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
        insert oppLst;
        
          OpportunityTriggerHandler tv=new OpportunityTriggerHandler();
        tv.test1();
    }
}