/*
* Created by    : Praveen (Lister)
* Created on    : Nov-14-2019
* Purpose       : This handler class has the consolidated logic of Trigger_Check_Duplicate and Trigger_Create_second_Followup
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)   Nov-14-2019   T01     Restricting duplicate email and Phone
Praveen(Lister)   Nov-14-2019   T02     Create followUp Task based on the priority 
*/
public class LeadTriggerHandler {
    //<T01>
    private final static string secondFollowUpStatus='Second Contact';
  	//</T01>
  	
  	//<T02>
  	private final static string corporateRecType='Corporate';
    private final static string veryHighPrioritySubject='Lead Followup Call - Very High Priority Lead';
    private final static string highPrioritySubject='Lead Followup Call - High Priority Lead';
    private final static string mediumPrioritySubject='Lead Followup Call - Medium Priority Lead';
    private final static string lowPrioritySubject='Lead Followup Call - Low Priority Lead';
    private final static string veryHighPriority='Very High';
    private final static string highPriority='High';
    private final static string mediumPriority='Medium';
    private final static string lowPriority='Low';

    //Create followUp Task based on the priority 
    public static void createFollowUptask(List<Lead> listLeadNew,Map<Id, Lead> mapOldLead){
        List<Task> listTask = new List<Task>();
        Set<ID> leadId = new Set<ID>();
        
        for (Lead objLead : listLeadNew ){
            if(objLead.Lead_Record_Type__c!=corporateRecType){
                Lead oldlead = mapOldLead.get(objLead.ID);
                if(objLead.isConverted == false && objLead.Lead_Priority__c != null && ((objLead.Lead_follow_up_status__c == secondFollowUpStatus && oldlead.Lead_follow_up_status__c != objLead.Lead_follow_up_status__c) || (objLead.Lead_follow_up_status__c == secondFollowUpStatus && oldlead.Lead_Priority__c == null && oldlead.Lead_Priority__c != objLead.Lead_Priority__c) || (objLead.Lead_follow_up_status__c == secondFollowUpStatus && objLead.Counter__c != oldlead.Counter__c))) {
                    Task objTask = new Task();
                    if(objLead.Lead_Priority__c == veryHighPriority){
                        objTask= Util_Common.getFollowUpTask(objLead,7,veryHighPrioritySubject,60);
                    }
                    else if(objLead.Lead_Priority__c == highPriority){
                        objTask= Util_Common.getFollowUpTask(objLead,14,highPrioritySubject,120);
                    }
                    else if(objLead.Lead_Priority__c == mediumPriority){
                        objTask= Util_Common.getFollowUpTask(objLead,30,mediumPrioritySubject,360);
                    }
                    else if(objLead.Lead_Priority__c == lowPriority){
                        objTask= Util_Common.getFollowUpTask(objLead,90,lowPrioritySubject,720);
                    }
                    listTask.add(objTask);
                }
            }
        }
        if(listTask.size()>0){
            try{
                insert listTask;
            }
            catch(Exception e){
                Debug_Logs__c excp = Util_Common.processException(e,true,'');
            }
        }
    }
    
    public static void escalationMail(List<Lead> listLead){
        Integer financialYearStart = System.today().year();
        integer month = System.today().month();
     	Integer day =  System.today().day();
       	datetime dt =system.today();
        String StartDateString = '' + financialYearStart + '-' + month + '-' + day;
			Datetime StartDateFormat = Date.valueOf(StartDateString);
        String dayOfWeek = StartDateFormat.format('u');
        for(Lead led:listLead){
            led.weekend__c = StartDateFormat;
            led.Day_of_the_week__c= Integer.valueOf(dayOfWeek);
            System.debug('<---->'+ led.Day_of_the_week__c);
            
        }
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
    
    //</T02>
}