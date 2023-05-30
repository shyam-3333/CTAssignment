@isTest
public class ProjectTriggerHandlerTest {
    
   static testMethod void method1(){
        Project__c p1 = new Project__c();
        p1.Name = 'Test';
        p1.Brand__c = 'Titan';
        insert p1;
    }

}