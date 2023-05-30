/*************************************************************
* Created by: Vinoth Kumar A
* Created on: 06/05/2019
* Description: Email should be sent if the Final Verdict of the component is reject, in the frequency of 10 days 
* ************************************************************/
global class QC_FinalVerdictRejectEmailBatchClass implements Database.batchable<sObject> {
    global Database.QueryLocator Start(Database.BatchableContext BC){
        //String dat = String.valueOf(system.today().addDays(-10));
        //for(integer i=20; i<31; i+10){
        //   dat = dat +' '+'OR'+' '+'Published_Date__c =' + String.valueOf(system.today().addDays(-i));
        // }
        String str = 'SELECT id, Report_Ref_Number__c, Sample_Received_From__c,Model__c,Watch_variant__c,Brand__r.name,Vendor__r.name,Published_Date__c FROM QC_Components__c WHERE Final_Verdict__c = \'Reject\' AND Component_Status__c = \'Active\' AND Document_Status__c = \'Published\' ';
        system.debug('String: '+str);
        return Database.getQueryLocator(str);
        
    }

    global void execute(Database.BatchableContext BC, List<QC_Components__c> scope){
        system.debug('scope+++++++++++++:'+scope);
        List<String> emailList = new List<String>();
        for(QC_Components__c comp : scope){
            system.debug('comp::::::::::::'+comp);
            if(comp.Published_Date__c != null){
                System.debug('math:'+math.mod(system.today().daysBetween(comp.Published_Date__c),10));
            }
            
            if(comp.Sample_Received_From__c != null && comp.Published_Date__c != null && math.mod(system.today().daysBetween(comp.Published_Date__c),10) == 0 && comp.Published_Date__c > DATE.Valueof('2017-07-01')|| Test.isRunningTest()){
                for(string str:comp.Sample_Received_From__c.split(',')){
                    emailList.add(str);
                    system.debug('Email+++++++++++++:'+str);
                } 
                //emailList.add('sfdcadmin@titan.co.in');
                system.debug('EmailList-------------:' +emailList);
                
                String addresses='vinoth.kumar@kvpcorp.com';
                string mailbody;
                mailbody = '<html><body>Hi ,<br/><br/> Please resubmit the sample for rejected report: '+comp.Report_Ref_Number__c +'.<br/><br/>Model :'+comp.Model__c+'<br/><br/>Wath Variant:'+comp.Watch_variant__c+'<br/><br/>Brand:'+comp.Brand__r.name+'<br/><br/>Vendor:'+comp.Vendor__r.name+'<br/><br/>Regards<br/><br/>QC Team</body></html>';
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject( 'Reminder - resubmitting rejected Sample reg' );
                email.setToAddresses(emailList);
                email.setHtmlBody(mailbody);
                //email.setPlainTextBody('Hi, \n Please resubmit the sample for rejected report: '+comp.Report_Ref_Number__c +'\nRegards\n QC team');
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                emailList.clear();
            }
        }
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}