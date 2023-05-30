/************************************************
* Created By: Poornapriya YN
* Description : This code resets autonumber to one on 1st of every month
***************************************************/

public class ResetAutoNumber{
    public void autoNumberByMonth(){
        List<AutoNumber__c> autoNumList = new List<AutoNumber__c>();
        for(AutoNumber__c auto: AutoNumber__c.getall().values()){
            auto.Auto_Number__c = 1;
            autoNumList.add(auto);
        }
        try{
            if(autoNumList.size()>0){
                update autoNumList;
            }
        }
        catch(Exception ex){
            system.debug('***Exception***'+ex);
        }
    }

}