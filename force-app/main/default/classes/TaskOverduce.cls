global class TaskOverduce Implements Schedulable {

    global void execute(SchedulableContext sc)
    {
        Id taskRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Corporate sales').getRecordTypeId();
        List<Task> taskList = [SELECT Id,Subject,Status,End_Date__c,OwnerId,Owner.Name,Owner.Email,CreatedById,CreatedBy.Email From Task Where RecordTypeId = :taskRecordTypeId And End_Date__c = TODAY  And  Status != 'Completed'];
        IF(taskList != null){
            for(task t1 :taskList){
                t1.status = 'Overdue';
            }
        }
        if(taskList.size()>0){
            update taskList;
            new TaskCompletedEmailSchedularClass().sendEmail(taskList, 'On end date');
        }
        
    }
}