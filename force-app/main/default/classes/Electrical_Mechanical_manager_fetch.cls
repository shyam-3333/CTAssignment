/* Written By: Deepak Singh G
* Created date: 5/1/2020
* Description: This fields updates opportunity's
*             1) Mechanical lead with manager of mechanical member
*             2) Electrical lead with manager of electrical member
*             3) Mechanical lead's lead with manager of mechanical lead.
* */




public class Electrical_Mechanical_manager_fetch {
    
    public void whileUpdate(list<opportunity> newList,map<id,opportunity> oldMap){
        boolean runQuery;
        runQuery = false;
        for(opportunity opp1 : newList){
            If(opp1.Member1__c != oldMap.get(opp1.Id).Member1__c || opp1.Member2__c != oldMap.get(opp1.Id).Member2__c){
                runQuery = true; 
            }
        }
        
        whileInsert(newList);
    }
    public void whileInsert(list<opportunity> newList){
        
        for(opportunity opp : newList){
            id electrical_manager;
            id mechanical_manager;
            id mechanical_manager_second;
            if(opp.Member2__c != null){
                if(opp.Electrical_manager__c != null){
                    electrical_manager = opp.Electrical_manager__c;
                    opp.Electrical_Lead__c = electrical_manager;
                }
            }
            if(opp.Member1__c != null){
                if(opp.Mechanical_manager_Id__c != null){
                    mechanical_manager = opp.Mechanical_manager_Id__c;
                    opp.Mechanical_Lead__c = mechanical_manager;
                }
                if(opp.Mechanical_manager_Id_2nd_level__c != null){
                    mechanical_manager_second = opp.Mechanical_manager_Id_2nd_level__c;
                    opp.Mechanical_Lead_s_Lead__c = mechanical_manager_second;
                }
            }
        }
    }
}