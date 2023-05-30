public class successorActivityName{
    public Id activityId{get;set;}
     public String msg{get;set;}
   
    public List<NPD_Email__c> getlActivity(){
        Id projectID = [select id,Name,NPD_Project_Items__c from NPD_Activity__c where id =: activityId].NPD_Project_Items__c;
        if(projectID != null){
            List<NPD_Email__c> emailName = [select id,Name,Act_Name__c from NPD_Email__c where Type__c='Successor' AND NPD_Project_Items__c =: projectID];
            if(emailName.size() > 0){
                msg = 'Please complete below activities :';
            }
            return emailName;
        }
        else
          return null;
     }
 
}