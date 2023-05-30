/*
* Company : Kvp Business Solution
* Author  : Sameer Ranjan
* Description : scheduler class of skinn NPD
* History     : N/L
*/
public with sharing class SkinnScheduleEscalationRuleClass implements Schedulable {
    public SkinnScheduleEscalationRuleClass() {
    }
    public static void emailAlert(List<String> toAddresses, List<String> ccAddresses, Skinn_Collection_Template__c rcordInfo, String parentStatus, String parentActName, String parentType) {
        system.debug('------------parentActName---------'+parentActName+'-'+parentStatus+'-'+parentType);
        system.debug('------rcordInfo------'+rcordInfo.status__c);
        if(rcordInfo.status__c == 'In Progress' ) {
            system.debug('---------coming inside if----------');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            ccAddresses.add(System.Label.Skinn_Titan_Email_Id);
            mail.setCcAddresses(ccAddresses);
            mail.setSenderDisplayName('Status Update');
            mail.setSubject('' + System.Label.Skinn_Escalation_Email_Subject);
            mail.setHtmlBody('Owner Name: ' + rcordInfo.Responsibly__r.Name + '<br> Collection Name: ' + rcordInfo.Skinn_Collection__r.Name + '<br>Model Name: ' + rcordInfo.Skinn_Model__r.Name + '  <br> Task Name: ' + rcordInfo.Item_Name__c +
                             '<br> Status: ' + rcordInfo.status__c + '<br>' + System.Label.Skinn_Escalation_Email_Body);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage [] {
                mail });
            
        }else if(rcordInfo.status__c == 'Not Started' && parentStatus == 'Completed' && parentType == 'Activity') {
            system.debug('---------coming inside 2nd if----------');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            ccAddresses.add(System.Label.Skinn_Titan_Email_Id);
            mail.setCcAddresses(ccAddresses);
            mail.setSenderDisplayName('Status Update');
            mail.setSubject('' + System.Label.Skinn_Escalation_Email_Subject);
            mail.setHtmlBody('Owner Name: ' + rcordInfo.Responsibly__r.Name + '<br> Collection Name: ' + rcordInfo.Skinn_Collection__r.Name + '<br>Model Name: ' + rcordInfo.Skinn_Model__r.Name + '  <br> Task Name: ' + rcordInfo.Item_Name__c +
                             '<br> Status: ' + rcordInfo.status__c + '<br>' + System.Label.Skinn_Escalation_Email_Body);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage [] {
                mail });
            
        }else if(rcordInfo.status__c == 'Not Started'  && (parentStatus == 'In Progress' || parentStatus == 'Not Started') && parentType == 'Activity'){
            system.debug('---------coming inside else----------');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            ccAddresses.add(System.Label.Skinn_Titan_Email_Id);
            mail.setCcAddresses(ccAddresses);
            mail.setSenderDisplayName('Status Update');
            mail.setSubject('' + System.Label.Skinn_Escalation_Email_Subject);
            mail.setHtmlBody('Owner Name: ' + rcordInfo.Responsibly__r.Name + '<br> Collection Name: ' + rcordInfo.Skinn_Collection__r.Name + '<br>Model Name: ' + rcordInfo.Skinn_Model__r.Name + '  <br> Task Name: ' + rcordInfo.Item_Name__c +
                             '<br> Status: ' + rcordInfo.status__c + '<br>' + 'This task has not been Started in its due time by its respective owner because the Previous Activity <b>' +parentActName+ '</b> is not completed in due time');
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage [] {
                mail });
        }
        
    }
    public void execute(SchedulableContext sc) {
        try{
            List<Skinn_Collection_Template__c> listSkinnCollTempRecords = [SELECT Id, Responsibly__r.Name, Item_Name__c, planned_End_Date__c, 
                                                                           Skinn_Collection__r.Name, Skinn_Model__r.Name, Responsibly__r.User_Email__c, 
                                                                           Responsibly__r.Team__r.Manager.Email, Type__c, Name, Skinn_NPD_Template_Item__c, Skinn_Model__c, Skinn_Collection__c, 
                                                                           Rolling_Planned_End_Date__c, 
                                                                           Skinn_NPD_Template_Item__r.Order_No__c, Skinn_NPD_Template_Item__r.Parent_Id__c, 
                                                                           Item_Names__c, Item_Names__r.Parent_Id__c, Status__c, 
                                                                           Skinn_NPD_Template_Item__r.Parent_Id__r.Id
                                                                           FROM Skinn_Collection_Template__c
                                                                           WHERE (Status__c = 'In Progress' OR Status__c = 'Not Started') AND Type__c = 'Activity' and skinn_collection__c != NULL
                                                                           AND Skinn_Model__c != NULL AND Active__c = True AND Rolling_Planned_End_Date__c <= TODAY limit 10000];
            Set<Id> collectionId = new Set<Id>();
            for(Skinn_Collection_Template__c each : listSkinnCollTempRecords){
                collectionId.add(each.Skinn_Collection__c);
            }
            List<Skinn_Collection_Template__c> listCollecTempRecords = [SELECT Id,Skinn_NPD_Template_Item__c,Skinn_NPD_Template_Item__r.Parent_Id__c,Skinn_Collection__c,Status__c,Type__c,Item_Name__c FROM Skinn_Collection_Template__c 
                                                                        WHERE Skinn_Collection__c in:collectionId ORDER BY Skinn_Collection__c];
            
            // Map Of Parent Info
            Map<String,Skinn_Collection_Template__c> mapOfParentInfo = new Map<String,Skinn_Collection_Template__c>();
            String key;
            for(Skinn_Collection_Template__c each : listCollecTempRecords){
                key = each.Skinn_NPD_Template_Item__c + ',' + each.Skinn_Collection__c;
                if(!mapOfParentInfo.containskey(key)){
                    mapOfParentInfo.put(key,each);
                }
            }
            String [] toaddresses;
            String [] ccAddresses;
            String parentStatus;
            String parentActName;
            String parentKey;
            String parentType;
            for(Skinn_Collection_Template__c each :listSkinnCollTempRecords) {
                parentKey = each.Skinn_NPD_Template_Item__r.Parent_Id__c+','+each.Skinn_Collection__c;
                parentStatus = mapOfParentInfo.get(parentKey).Status__c;
                parentActName = mapOfParentInfo.get(parentKey).Item_Name__c;
                parentType = mapOfParentInfo.get(parentKey).Type__c;
                toaddresses = new List<String>();
                ccAddresses = new List<String>();
                if(each.Status__c == 'Not Started') {
                    toaddresses.add(each.Responsibly__r.User_Email__c);
                    if(each.Responsibly__r.Team__r.Manager.Email != null) {
                        ccAddresses.add(each.Responsibly__r.Team__r.Manager.Email);
                    }
                } else {
                    toaddresses.add(each.Responsibly__r.User_Email__c);
                    if(each.Responsibly__r.Team__r.Manager.Email != null) {
                        ccAddresses.add(each.Responsibly__r.Team__r.Manager.Email);
                    }
                }
                emailAlert(toaddresses, ccAddresses, each, parentStatus,parentActName,parentType);
            }
        } catch(Exception ex) {
            GenericLogicClass.errorHandlingMethod(ex);
        }
    }
}