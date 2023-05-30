@isTest
public class Test_Trigger_Update_Currency_CT{

    static testmethod void Test_Trigger_Update_Currency_CT(){
        
        Opportunity opp = new Opportunity(Name='Test',StageName='Revised Quotation', CloseDate=Date.Today()+5);
        insert opp;
        
        Cost_Tracking__c ct = new Cost_Tracking__c(Opportunity__c = opp.Id);
        insert ct;
    }

}