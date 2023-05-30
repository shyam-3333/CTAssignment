/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 10/06/2019
* Description: If the Opportunity owner has not sent the survey to the customer within 5 days, a reminder should be sent to the respective opportunity owner on 6th day.
*******************************************************************************/
global class SurveySentOppOwnerReminderBatchClass implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        String str = 'SELECT ID, Name, Owner.Email, Owner.Name, AccountId,createdDate, Email__c, SurveyReminderEmailSentDate__c,StageName from Opportunity WHERE SurveyReminderEmailSentDate__c != NULL';
        system.debug('String: '+str);
        return Database.getQueryLocator(str);
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> Scope){
        system.debug('Scope:===='+Scope);
        List<string> ConEmailList = new List<string>();
        List<string> OppOwnerEmail =  new List<string>();
        for(Opportunity Opp: Scope){
            DateTime dt = DateTime.newInstance(2019,10,23,0,0,0);
            if(opp.CreatedDate > dt){
                
            if(math.mod(system.today().daysBetween(Date.ValueOf(Opp.SurveyReminderEmailSentDate__c)),5) == 0){
                system.debug('SurveyReminderEmailSentDate__c:++++++++++'+Opp.SurveyReminderEmailSentDate__c);
                system.debug('Date.ValueOf(Opp.SurveyReminderEmailSentDate__c):++++++++++'+Date.ValueOf(Opp.SurveyReminderEmailSentDate__c));
                OppOwnerEmail.add(Opp.Owner.Email);
                for(contact cont:[SELECT ID, Email from contact WHERE AccountId =: Opp.AccountId]){
                    ConEmailList.add(cont.Email);
                }
            }
            List<string> SurveyList = new List<string>();
            SurveyList.addAll(System.Label.Survey_Names.split(','));
            
            List<Survey_Sent__c> SurveySentList = [SELECT ID, Email__c,Email_Body__c, Surveys__c,CreatedDate, Surveys__r.Name FROM Survey_Sent__c WHERE Email__c in:ConEmailList AND Surveys__r.Name in:SurveyList];
            system.debug('SurveySentList:===='+SurveySentList);
            if(SurveySentList.isEmpty() && math.mod(system.today().daysBetween(Date.ValueOf(Opp.SurveyReminderEmailSentDate__c)),5) == 0){
                string OppUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/' + Opp.Id;
                string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
                if(Opp.StageName == 'Order Won'){
                    String  imageLink = '<html><body><a href="https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017YD5M&sfdc.override=1&OppId='+Opp.Id+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GVlW&oid=00D2F0000000UZi&lastMod=1561966131000" height="90" width="120"/></a></body></html>';
                    List<string> emailIterationList = new List<string>();
                    emailIterationList.addAll(OppOwnerEmail);
                    emailIterationList.addAll(Label.Email_address.split(','));
                    system.debug('emailIterationList:'+emailIterationList);
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(emailIterationList);
                    mail.setSubject(Opp.Name+' - Voice of customer: Project Won');
                    mail.setHtmlBody('Hi '+ Opp.Owner.Name+',<br/>'+'<br/>To know the customer feedback regarding the opportunity '+Opp.Name+', We noticed that the survey is not send to the customer yet. <br/>Kindly send the Voice of customer: Project Won survey to the customer. <br/><br/>Please click on the below image to take the survey.<br/><br/>'+imageLink+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
                    mail.setUseSignature(false);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                    system.debug('mail+++++++++:'+mail);
                    emailIterationList.clear();
                    Opp.SurveyReminderEmailSentDate__c = system.today();
                }
                system.debug('stage===>'+Opp.StageName);
                if(Opp.StageName == 'Opportunity Lost'){
                    String  imageLink = '<html><body><a href="https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017YD5R&sfdc.override=1&OppId='+Opp.Id+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GVlW&oid=00D2F0000000UZi&lastMod=1561966131000" height="90" width="120"/></a></body></html>';
                    List<string> emailIterationList = new List<string>();
                    emailIterationList.addAll(OppOwnerEmail);
                    emailIterationList.addAll(Label.Email_address.split(','));
                    system.debug('emailIterationList:'+emailIterationList);
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(emailIterationList);
                    mail.setSubject(Opp.Name+' - Voice of customer: Project Lost');
                    mail.setHtmlBody('Hi '+ Opp.Owner.Name+',<br/>'+'<br/>To know the customer feedback regarding the opportunity '+Opp.Name+', We noticed that the survey is not send to the customer yet. <br/>Kindly send the Voice of customer: Project Lost survey to the customer. <br/><br/>Please click on the below image to take the survey<br/><br/>'+imageLink+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
                    mail.setUseSignature(false);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                    system.debug('mail+++++++++:'+mail);
                    emailIterationList.clear();
                    Opp.SurveyReminderEmailSentDate__c = system.today();
                }
            }
            }
        }
        database.update(scope,false);
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}