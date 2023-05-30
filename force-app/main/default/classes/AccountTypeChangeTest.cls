@isTest
public class AccountTypeChangeTest {
    public static testMethod void typeChange(){
        List<Account> accLst = new List<Account>();
        for(Integer i = 0; i < 3; i++){
            Account acc = new Account();
            acc.Name = 'test'+i;
            acc.Type = 'Suspect';
            acc.Lead_first_contact_date__c = system.Today();
            acc.BillingPostalCode = '506319';
            accLst.add(acc);
        }
        insert accLst;
        List<Opportunity> oppLst = new List<Opportunity>();
        for(Integer i = 0; i < 3; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'test'+i;
            opp.AccountId = accLst[0].Id;
            opp.stageName = 'Opportunity Won';
            opp.CloseDate = system.Today();
            oppLst.add(opp);
        }
        insert oppLst;
        List<ACcount> accList = new List<Account>();
        Map<Id,Account> mapWithValues = new Map<Id,Account>();
        for(Account acc : accLst){
            mapWithValues.put(acc.Id,acc);
            acc.Type = 'Prospect';
            accList.add(acc);
        }
        update accList;
        test.startTest();
        AccountTypeChange accType = new AccountTypeChange();
        accType.prospectToCustomer(accList, mapWithValues);
        test.stopTest();        
    }
    
    

}