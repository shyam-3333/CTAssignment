/*
* Created by    : Mutturaj Heroor
* Created on    : April-12-2021
* Purpose       : TaskCompletedEmailSchedularClass is Used for Sending Email to Task Owner and his Maneger and Created User which ever the task are not Completed before End Date  *******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
*/
global class TaskCompletedEmailSchedularClass Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Id taskRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Corporate sales').getRecordTypeId();
        List<Task> taskList = [SELECT Id,Subject,Status,End_Date__c,OwnerId,Owner.Name,Owner.Email,CreatedById,CreatedBy.Email From Task Where RecordTypeId = :taskRecordTypeId And End_Date__c = tomorrow  And  Status != 'Completed'];
        
        system.debug('taskList==>'+[select Status,RecordTypeId,End_Date__c from task]);
        if( taskList.size() > 0)
        {
            sendEmail(taskList, 'One day before end date');
        }
    }
    
    public void sendEmail( List<Task> taskList , string contl )
    {
        Set<Id> sAssignToUserId = new Set<Id>();
        Map<Id,taskEmailWrapper> taskEmailWrapperMap = new Map<Id,taskEmailWrapper>();
        taskEmailWrapper tskEmailWrap;
        for(Task tsk : taskList )
        {
            sAssignToUserId.add(tsk.OwnerId);
            tskEmailWrap = new taskEmailWrapper();
            tskEmailWrap.taskRecId =  tsk.Id;
            tskEmailWrap.taskRec = tsk ;
            tskEmailWrap.assignedUserId = tsk.OwnerId;
            taskEmailWrapperMap.put(tsk.Id, tskEmailWrap );
        }
        System.debug(taskEmailWrapperMap);
        
        // Fetch the Assigned User's Manager Email 
        Set<String> sAssignUserManagerEmailId = new Set<String>();
        Map<Id,String> mapOfManegers = new Map<Id,String>();
        for(User usr :[SELECT Id,Manager.Email From User where Id =: sAssignToUserId ])
        {
            mapOfManegers.put(usr.Id, usr.Manager.Email);
        }
        System.debug(mapOfManegers);
        //Construct the Email Templet for each task 
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage email;
        for(taskEmailWrapper tskwrp: taskEmailWrapperMap.Values())
        {
            //system.debug('');
            email = new Messaging.SingleEmailMessage();
            string managerEmail;
            if(mapOfManegers.containsKey(tskwrp.assignedUserId)){
                managerEmail = mapOfManegers.get(tskwrp.assignedUserId);
            }
            system.debug('managerEmail==>'+managerEmail);
            list<string> toAdd = new list<string>();
            if(tskwrp.taskRec.CreatedBy.Email != null){
                toAdd.add(tskwrp.taskRec.CreatedBy.Email);
            }
            if(tskwrp.taskRec.Owner.Email != null){
                toAdd.add(tskwrp.taskRec.Owner.Email);
            }
            if(managerEmail != null){
                toAdd.add(managerEmail);
            }
            
            email.setToAddresses(toAdd);
            system.debug('email.getToAddresses()==>'+email.getToAddresses());
            email.setCcAddresses(new List<String>{'sfdcadmin@titan.co.in'});
            if(contl == 'One day before end date'){
                email.setSubject( tskwrp.taskRec.Subject + 'is not Completed');
            email.setHtmlBody('Hi, <BR/><BR/> The task assigned to'+tskwrp.taskRec.Owner.Name +'is about to exceed the end date. Requesting you to review the task and update the status.<BR/><Br/>Link for the task: https://titanlightningapps.lightning.force.com/'+tskwrp.taskRec.Id+'<BR/><BR/>Thanks and Regards,');
            }
            else if(contl == 'On end date'){
                email.setSubject( 'Task Escalation Notification');
            email.setHtmlBody('Hi '+tskwrp.taskRec.Owner.Name +', <BR/><BR/>The task assigned to '+tskwrp.taskRec.Owner.Name+' has exceeded the end date. The status of the task has been moved to overdue. Please find the link for the task. Request your assistance on this<BR/><BR/>Link for the task: https://titanlightningapps.lightning.force.com/'+tskwrp.taskRec.Id+'<BR/><BR/>Thanks and Regards,');
            }
            
            
            emailList.add(email);
        }
        if( emailList.size() > 0 )
        {
            Messaging.sendEmail(emailList);
            System.debug(emailList);
        }
        
    }
    
    Public Class taskEmailWrapper
    {
        public Id taskRecId;
        public Task taskRec;
        public Id assignedUserId ;
        
    }
}