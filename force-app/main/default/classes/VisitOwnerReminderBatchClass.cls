/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 21/06/2019
* Description: Reminder to visit owner to send survey to the respective customer.
*******************************************************************************/
global class VisitOwnerReminderBatchClass implements Database.batchable <sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT id, EmailReminderStatus__c, Owner.Email, Owner.Name, Account__c FROM Visit__c WHERE EmailReminderStatus__c = true' ;
        system.debug('Check:'+Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Visit__c> Scope){
        string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
        string imageLink ='';
        Map<id,User> UserList = new Map<id,user>([SELECT ID, Name, Email FROM User]);
        Map<id,Account> AccList = new Map<id,Account>([SELECT Id, Name FROM Account]);
        Map<id,Visit__c> visitMap = new Map<id,Visit__c>(Scope);
        system.debug('ScopeMap:'+visitMap);
        system.debug('ScopeMap:'+visitMap);
        List<id> Vid = new List<id>();
       /* for(Visit__c visit:Scope){
            visitMap.put(visit.id,visit);
        }*/
        //List<Survey_Sent__c> SurveySentList = [SELECT Id FROM Survey_Sent__c WHERE Visit__c IN : visitMap.keyset()];
        //
        for(Survey_Sent__c ss :[SELECT Id FROM Survey_Sent__c WHERE Visit__c IN : visitMap.keyset()]){
            vid.add(ss.Visit__c);
        }
        for(Visit__c vs:Scope){
            if(!vid.contains(vs.Id)){
            	imageLink = '<html><body><a href="'+'https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017Y3Ar&sfdc.override=1&visitId='+vs.id+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GTNA&oid=00D2F0000000UZi&lastMod=1561466129000" height="75" width="100"/></a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="'+'https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017Y3Ar&sfdc.override=1&visitId='+vs.id+'&noImage=true'+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GTNU&oid=00D2F0000000UZi&lastMod=1561466206000" height="75" width="100"/></a></body></html>';
                List<string> emailIterationList = new List<string>();
                emailIterationList.add(UserList.get(vs.OwnerId).Email);
                emailIterationList.addAll(Label.Email_address.split(','));
                system.debug('emailIterationList:'+emailIterationList);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(emailIterationList);
                mail.setSubject('Voice of customer survey');
                mail.setHtmlBody('Hi '+ UserList.get(vs.OwnerId).Name+',<br/>'+'<br/>Regarding the visit done by the '+ AccList.get(vs.Account__c).Name+', Would you like to send the survey to the customer. <br/>'+imageLink+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
                mail.setUseSignature(false);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                
            }
        } 
    }
    global void finish(Database.BatchableContext BC){
        
    }
}