/*
* Developer Name : Vydhyula Sruthi
* Created Date   : 19/12/2019
* Description    : The page will be changed from suspect to prospect only after the approval of the manager.
* The prospect will be changed automatically to customer when the opportunity won is greater than or equal to 1
* --------------------------------------------------------
* Trigger Name   : AccountDuplicateAvoid
* Test Class	 : AccountTypeChangeTest
*/

public class AccountTypeChange {
    public void prospectToCustomer(List<Account> lstAcc, Map<Id,Account> mapWithValues){
        Set<Id> accSetId = new Set<Id>();
        if(lstAcc.size()>0){
            for(Account acc : lstAcc){
                if(acc.Type == 'Prospect' && mapWithValues.get(acc.Id).Type == 'Suspect'){ 
                    accSetId.add(acc.Id);
                }
            }
        }
        Map<Id,Integer> MapClosedWon = new Map<Id,Integer>();
        for(Opportunity opp : [SELECT id,name,StageName,AccountId FROM Opportunity WHERE AccountId IN : accSetId AND StageName = 'Opportunity Won']){
            if(MapClosedWon.containsKey(opp.AccountId)){
                MapClosedWon.put(opp.AccountId, MapClosedWon.get(opp.AccountId)+1);
            }else{
                MapClosedWon.put(opp.AccountId,1);
            }
        }
        for(Account acc:lstAcc){
            if(MapClosedWon.containsKey(acc.Id)){
                acc.Type = 'customer';
            }
        }
    }
}