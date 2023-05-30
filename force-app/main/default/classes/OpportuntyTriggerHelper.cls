/*
* Developer Name : Vydhyula Sruthi
* Created Date   : 23/12/2019
* Description    :  The customer type will be “Suspect” or “Prospect” based on the account type. 
* If the opportunity won is greater than or equal to 1, then the customer type will be “Customer”. 
* --------------------------------------------------------
* Trigger Name   : OpportunityTrigger
* Test Class	 : OpportuntyTriggerHelperTest
*/

public class OpportuntyTriggerHelper {
    public void autoUpdateOfCustomerType(List<Opportunity> oppLst){
        Set<Id> accSetId = new Set<Id>();
        for(Opportunity opp: oppLst){
            if(opp.AccountId != null){
                accSetId.add(opp.AccountId);
            }
        }
        Map<Id,Account> mapWithType = new Map<Id,Account>();
        for(Account acc: [SELECT id,name,Type,Industry_and_Product_Details__c,Product_Category__c FROM Account WHERE Id IN : accSetId]){
            mapWithType.put(acc.Id, acc);
        }
        for(Opportunity opp:oppLst){
            if(opp.StageName == 'Opportunity won'){
                opp.Customer_Type__c = 'Customer';
            }else{
                opp.Customer_Type__c = mapWithType.get(opp.AccountId).type;
            }
            opp.Industry_and_Product_Details__c = mapWithType.get(opp.AccountId).Industry_and_Product_Details__c;
            opp.Product_Category__c = mapWithType.get(opp.AccountId).Product_Category__c;
        }
    }
}