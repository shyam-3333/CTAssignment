@isTest
public class TaskCompletedEmailSchedularClassTest {
    
    public static testMethod void DoSomeClone(){
        
        Id taskRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Corporate sales').getRecordTypeId();
        list<task> taskList = new list<task>();
        Task t1 = new task();
        t1.RecordTypeId =taskRecordTypeId;
        t1.End_Date__c = system.today() + 1;
        t1.OwnerId = userinfo.getUserId();
        
        taskList.add(t1);
        
        system.debug('RecordTypeId===>'+t1.End_Date__c);
        system.debug('RecordTypeId1===>'+system.today());
        
        Task t2 = new task();
        t1.End_Date__c = system.today();
        t2.OwnerId = userinfo.getUserId();
        t1.RecordTypeId =taskRecordTypeId;
        taskList.add(t2);
        
        insert taskList;
        
        TaskOverduce s=new TaskOverduce();
        s.execute(null) ;
        TaskCompletedEmailSchedularClass s1=new TaskCompletedEmailSchedularClass();
        s1.execute(null) ;
        //new TaskCompletedEmailSchedularClass().sendEmail(taskList,'One day before end date');
    }
}