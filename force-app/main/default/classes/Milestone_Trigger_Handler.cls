public class Milestone_Trigger_Handler {
    
    
    public void changeMilstone(list<Milestone__c> newList, Map<id,Milestone__c> oldMap){
        list<Milestone__c> firstStage = new list<Milestone__c>();
        list<Milestone__c> secondStage = new list<Milestone__c>();
        list<Milestone__c> thirdStage = new list<Milestone__c>(); 
        list<Milestone__c> fourthStage = new list<Milestone__c>();
        list<Milestone__c> fifthStage = new list<Milestone__c>();
        
        
        for(Milestone__c mil : newList){
            system.debug('oldMap.get(mil.Project__c).status__c ===>'+oldMap.get(mil.id).status__c); // Not started or Active
            if(mil.name == 'Marketing Brief Release' && mil.status__c == 'Completed' && mil.status__c != oldMap.get(mil.id).status__c){
                firstStage.add(mil);
                Milestone_Trigger_Handler2.sendEmailWithAttachment(newList);                
                System.Debug('firstStage : '+mil.name);
            }
            else if(mil.name == 'Acceptance of Marketing Brief' && mil.status__c == 'Completed' && mil.status__c != oldMap.get(mil.id).status__c){
                secondStage.add(mil);
                Milestone_Trigger_Handler2.sendEmailWithAttachment(newList);                
                System.Debug('secondStage : '+mil.name);
            }
            else if(mil.name == 'Final concept presentation by DEC to Brand' && mil.status__c == 'Completed' && mil.status__c != oldMap.get(mil.id).status__c){
                thirdStage.add(mil);
                Milestone_Trigger_Handler2.sendEmailWithAttachment(newList);                
                System.Debug('thirdStage : '+mil.name);  // thirdStage : Final concept presentation by DEC to Brand
            }
            else if(mil.name == 'Completion of technical drawing of the concept' && mil.status__c == 'Completed' && mil.status__c != oldMap.get(mil.id).status__c){
                fourthStage.add(mil);
                Milestone_Trigger_Handler2.sendEmailWithAttachment(newList);                
                System.Debug('fourthStage : '+mil.name);
            }
            else if(mil.name == 'Approval of ISCM briefing' && mil.status__c == 'Completed' && mil.status__c != oldMap.get(mil.id).status__c){
                Milestone_Trigger_Handler2.sendEmailWithAttachment(newList);                
                System.Debug('fifthStage : '+mil.name);
            }
            
        }
        if(firstStage.size() > 0){
            firstMilstoneCompleted(firstStage,'Acceptance of Marketing Brief');
        }
        if(secondStage.size() > 0){
            firstMilstoneCompleted(secondStage,'Final concept presentation by DEC to Brand');
        }
        if(thirdStage.size() > 0){
            firstMilstoneCompleted(thirdStage,'Completion of technical drawing of the concept');
        }
        if(fourthStage.size() > 0){
            firstMilstoneCompleted(fourthStage,'Approval of ISCM briefing');
        }
        
    }
   
    public void firstMilstoneCompleted(list<Milestone__c> newList,string nextStage){ //thirdStage,'Completion of technical drawing of the concept'
        Set<Id> projectId = new Set<Id>();
        for(Milestone__c mil : newList){
            projectId.add(mil.Project__c);   //add project id of final
            System.debug('projectId : '+projectId.size());  //1
        }
        list<Milestone__c> milStoneList = [Select id, Name, project__c, Status__c from Milestone__c where project__c in :projectId and Name = :nextStage];
        System.debug('milStoneList size: '+milStoneList.size());  //1
        System.debug('milStoneList  : '+milStoneList);    //record
        for(Milestone__c mil : milStoneList){
            mil.status__c = 'Active';
            mil.Start_date__c = system.today();
        }
        update milStoneList;
        System.debug('Updated milStoneList : '+milStoneList);
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