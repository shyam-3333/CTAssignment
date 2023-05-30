/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 10/06/2019
* Description: If the user has not taken the survey within 5 days, a reminder should be sent to the respective user on 6th day.
*******************************************************************************/
global class SurveySentCustomerReminderBatchClass implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){
        String str = 'SELECT ID, Email__c,Email_Body__c, Customer_name__c, Opportunity__r.Name,Opportunity__r.Owner.name, Surveys__c,CreatedDate, Surveys__r.Name,SurveyLinkImage__c FROM Survey_Sent__c';
        system.debug('String: '+str);
        return Database.getQueryLocator(str);
    }
    
    global void execute(Database.BatchableContext BC, List<Survey_Sent__c> Scope){
        List<string> EmailList =  new List<string>();
        EmailList.addAll(Label.SurveySentCustomerReminderBatchClass_Label.split(','));
        string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
        Map<string,id> SsMap = new Map<string,id>();
        for(Survey_Sent__c	Ss: Scope){
            SsMap.put(Ss.Email__c,Ss.Surveys__c);
            List<SurveyTaker__c> SurveyTaken = [SELECT Id FROM SurveyTaker__c WHERE Email__c in: SsMap.keySet() AND Survey__c in: SsMap.values()];
            if(SurveyTaken.isempty()){
                if(Ss.Customer_name__c == null){
                        Ss.Customer_name__c = ' ';
                    }
                system.debug('CreateDate:++++++++++'+Ss.CreatedDate);
                system.debug('Math:++++++++++'+math.mod(system.today().daysBetween(Date.ValueOf(Ss.CreatedDate)),5));
                if(math.mod(system.today().daysBetween(Date.ValueOf(Ss.CreatedDate)),5) == 0){
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    EmailList.add(Ss.Email__c);
                    mail.setToAddresses(EmailList);
                    if(Ss.Opportunity__r.Name != null){
                       mail.setSubject(Ss.Opportunity__r.Name+'- Voice of customer survey'); 
                    } else {
                        mail.setSubject('Voice of customer survey');
                    }
                    
                    mail.setHtmlBody('Hi '+ Ss.Customer_name__c+',<br/> Recently we invited you to participate in a survey. We await your responce & feedback in the survey. We kindly ask that you spend just a few minutes filling out the survey.<br/>Thanks in advance.<br/><br/>Please click on the below image to take the survey<br/>'+Ss.SurveyLinkImage__c+'<br/><br/>Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');	
                    mail.setUseSignature(false);
                    Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                    EmailList.clear();
                }  
            }
            
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}