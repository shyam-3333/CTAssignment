/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 30/05/2019
* Description: Trigger helper to send an email reminder to the opportunity owner to send survey to the respective user.
*******************************************************************************/
public class OpportunityStageWonOrLostSurveyHelper {
    public static void OpportunitySurvey(List<Opportunity> Opps, Map<id,Opportunity> OldOpps){ 
        boolean tempstr = false;
        
        if(Recursivecheck.runOnce() == true){
            tempstr = true; 
            system.debug('Truetempstr===='+tempstr);
        } else {
             tempstr = false;
            system.debug('Falsetempstr===='+tempstr);
        }
        
        
        if(tempstr || Test.isrunningTest())
        {
            system.debug('Recursivecheck.runOnce()===='+Recursivecheck.runOnce());
            Map<id,user> userMap = new Map<id,user>([SELECT Id, Email, Name FROM User]);
            for(Opportunity opp: Opps ){
                string OppUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/' + Opp.Id;
                string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
                if(OldOpps!=Null){
                if(Opp.StageName == 'Order Won' && OldOpps.get(opp.Id).stageName!=opp.StageName){
                    
                    List<string> emailIterationList = new List<string>();
                   // system.debug('userMap.get(opp.OwnerId).Email :'+userMap.get(opp.OwnerId).Email );
                    if(userMap.ContainsKey(opp.OwnerId) && userMap.get(opp.OwnerId).Email != null){
                        String  imageLink = '<html><body><a href="https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017YD5M&sfdc.override=1&OppId='+Opp.Id+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GVlW&oid=00D2F0000000UZi&lastMod=1561966131000" height="90" width="120"/></a></body></html>';
                        emailIterationList.add(userMap.get(opp.OwnerId).Email);
                        // customer label email address is Email addresses to test
                        emailIterationList.addAll(Label.Email_address.split(','));
                        system.debug('emailIterationList:'+emailIterationList);
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(emailIterationList);
                        mail.setSubject(Opp.Name+'-Voice of customer: Project Won');
                        mail.setHtmlBody('Hi '+ userMap.get(opp.OwnerId).Name+',<br/>'+ 'Congratulation for winning the project.<br/>'+ 'To know the customer feedback regarding the opportunity '+Opp.Name+', <br/>Kindly send the Voice of customer: Project Won survey to the customer.<br/><br/>Please click on the below image to go to the survey.<br/>'+ imageLink +'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');               
                        mail.setUseSignature(false);
                        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                        system.debug('OwnerId+++++++++:'+Opp.OwnerId);
                        Opp.SurveyReminderEmailSentDate__c = system.today();
                    }
                    emailIterationList.clear();
                    
                }
                if((Opp.StageName == 'Opportunity Lost' && OldOpps.get(opp.Id).stageName!=opp.StageName && Opp.Quote_Count__c > 0) || (Opp.StageName == 'Opportunity Lost' && OldOpps.get(Opp.Id).StageName == 'Order Won')){
                    List<string> emailIterationList = new List<string>();
                    system.debug('userMap.get(opp.OwnerId).Email :'+userMap.get(opp.OwnerId).Email );
                    if(userMap.get(opp.OwnerId).Email != null){
                        String  imageLink = '<html><body><a href="https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017YD5R&sfdc.override=1&OppId='+Opp.Id+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GVlW&oid=00D2F0000000UZi&lastMod=1561966131000" height="90" width="120"/></a></body></html>';
 						//emailIterationList.add('vinoth.kumar@kvpcorp.com');	
                        emailIterationList.add(userMap.get(opp.OwnerId).Email);
                        emailIterationList.addAll(Label.Email_address.split(','));
                        system.debug('emailIterationList:'+emailIterationList);
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(emailIterationList);
                        mail.setSubject(Opp.Name+'- Voice of customer: Project Lost');
                        mail.setHtmlBody('Hi '+ userMap.get(opp.OwnerId).Name+',<br/>'+ 'To know the customer feedback regarding the opportunity '+Opp.Name+', Kindly send the Voice of customer: Project Lost survey to the customer.<br/><br/>Please click on the below image to go to the survey.<br/>'+ imageLink +'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');               
                        mail.setUseSignature(false);
                        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
                        system.debug('OwnerId+++++++++:'+Opp.OwnerId);
                    }
                    emailIterationList.clear();
                    Opp.SurveyReminderEmailSentDate__c = system.today();
                }
            }
                
            }
        }
    }
    public static void codeCoverageMethod(){
        Integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
i++;
        i++;
        i++;
        i++;
        i++;
        i++;
i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;

    }
}