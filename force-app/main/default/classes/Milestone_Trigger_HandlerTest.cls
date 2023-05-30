@isTest
public class Milestone_Trigger_HandlerTest {
    
    static testMethod void method2(){
        list<Milestone__c> firstStage = new list<Milestone__c>();        
        
        Project__c p2 = new Project__c();
        p2.Name = 'Test Project';
        p2.Brand__c = 'Titan';
        insert p2;
        
        list<Milestone__c> milestoneRecs = [select id,name,status__c,Project__c from Milestone__c where project__c = :p2.id];
        System.debug('milestoneRecs : '+milestoneRecs);
        for(Milestone__c mil :milestoneRecs){
            if(mil.Name == 'Marketing Brief Release'){
                mil.status__c = 'Completed';
                mil.Approval_Status__c = 'Approved';
            }
        }
        update milestoneRecs;
        for(Milestone__c mil :milestoneRecs){
            if(mil.Name == 'Acceptance of Marketing Brief'){
                mil.status__c = 'Completed';
                mil.Approval_Status__c = 'Approved';
                
            }
        }
        update milestoneRecs;  
        for(Milestone__c mil :milestoneRecs){
            if(mil.Name == 'Final concept presentation by DEC to Brand'){
                mil.status__c = 'Completed';
                mil.Approval_Status__c = 'Approved';
                
            }
        }
        update milestoneRecs;  
        for(Milestone__c mil :milestoneRecs){
            if(mil.Name == 'Completion of technical drawing of the concept'){
                mil.status__c = 'Completed';
                mil.Approval_Status__c = 'Approved';
                
            }
        }
        update milestoneRecs;  
        for(Milestone__c mil :milestoneRecs){
            if(mil.Name == 'Approval of ISCM briefing'){
                mil.status__c = 'Completed';
                mil.Approval_Status__c = 'Approved';
                
            }
        }
        update milestoneRecs;  
    }
}