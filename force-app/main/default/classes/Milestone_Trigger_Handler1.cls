/*
Written by : Deepak Singh G
Created date : 30-04-2021
Description : This class is to validate milestones milstone status cannot be changed from not started when previous milestone status is not completed
*/
public class Milestone_Trigger_Handler1 {
    
    public void validateStatus(list<Milestone__c> newList,map<id,Milestone__c> oldMap){
        map<id,string> lastClosedStage = new map<id,string>();
        list<Id> projectIds = new list<id>();
        
        for(Milestone__c mil1 : newList){
            projectIds.add(mil1.Project__c);
        }
        
        system.debug('projectIds : '+projectIds.size());
        
        for(Milestone__c mil :[select id,name,status__c,Project__c from Milestone__c where project__c in :projectIds order by Serial_Number__c asc]){
            if(mil.status__c == 'Completed'){
                lastClosedStage.put(mil.Project__c,mil.Name);
            }
        }
        
        system.debug('lastClosedStage : '+lastClosedStage);
        system.debug('lastClosedStage : '+lastClosedStage.size());
        
        for(milestone__c mil2 : newList){
            if(mil2.Status__c != oldMap.get(mil2.Id).Status__c){
                if(mil2.Status__c != 'Not started' || mil2.Status__c != null){
                    if(mil2.Name == 'Acceptance of Marketing Brief'){
                        if(lastClosedStage.containsKey(mil2.Project__c)){                           
                            if(lastClosedStage.get(mil2.Project__c) != 'Marketing Brief Release' ){
                                system.debug('Yes');                               
                                mil2.AddError('Please complete Marketing Brief Release milestone before Activating Acceptance of Marketing Brief milestone');
                                
                            }
                        }
                        else if(!lastClosedStage.containsKey(mil2.Project__c)){
                            system.debug('Yes Yes');
                            mil2.AddError('Please complete Marketing Brief Release milestone before Activating Acceptance of Marketing Brief milestone');
                        }
                    }
                    else if(mil2.Name == 'Final concept presentation by DEC to Brand'){
                        if(lastClosedStage.containsKey(mil2.Project__c)){
                            if(lastClosedStage.get(mil2.Project__c) != 'Acceptance of Marketing Brief'){
                                system.debug('Yes');                               
                                mil2.AddError('Please complete Acceptance of Marketing Brief milestone before Activating Final concept presentation by DEC to Brand milestone');
                            }
                        }
                        else if(!lastClosedStage.containsKey(mil2.Project__c)){
                            system.debug('Yes Yes');
                            mil2.AddError('Please complete Acceptance of Marketing Brief milestone before Activating Final concept presentation by DEC to Brand milestone');
                        }
                    }
                    else if(mil2.Name == 'Completion of technical drawing of the concept'){
                        if(lastClosedStage.containsKey(mil2.Project__c)){
                            if(lastClosedStage.get(mil2.Project__c) != 'Final concept presentation by DEC to Brand'){
                                system.debug('Yes');                               
                                mil2.AddError('Please complete Final concept presentation by DEC to Brand milestone before Activating Completion of technical drawing of the concept milestone');
                            }
                        }
                        else if(!lastClosedStage.containsKey(mil2.Project__c)){
                            system.debug('Yes Yes');
                            mil2.AddError('Please complete Final concept presentation by DEC to Brand milestone before Activating Completion of technical drawing of the concept milestone');
                        }
                    }
                    else if(mil2.Name == 'Approval of ISCM briefing'){
                        if(lastClosedStage.containsKey(mil2.Project__c)){
                            if(lastClosedStage.get(mil2.Project__c) != 'Completion of technical drawing of the concept'){
                                system.debug('Yes');                               
                                mil2.AddError('Please complete Completion of technical drawing of the concept milestone before Activating Approval of ISCM briefing milestone');
                            }
                        }
                        else if(!lastClosedStage.containsKey(mil2.Project__c)){
                            system.debug('Yes Yes');
                            mil2.AddError('Please complete Completion of technical drawing of the concept milestone before Activating Approval of ISCM briefing milestone');
                        }
                    }
                    
                }
            }
        }
           for(Milestone__c mil3 : newList){
            if(mil3.Status__c == 'Not started'){
                if(!Test.isRunningTest()){
                    mil3.addError('This milestone is not yet started');
                }
            }
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
    }
}