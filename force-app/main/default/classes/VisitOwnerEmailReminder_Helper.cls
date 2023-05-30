/*******************************************************************************
* Created by: Vinoth Kumar A
* Created on: 21/06/2019
* Description: If the visit type is 'by customer' an email should be sent to the visit owner to send survey to the respective customer.
*******************************************************************************/
public class VisitOwnerEmailReminder_Helper {
    public static void VisitOwnerEmailReminderMethod(List<Visit__c> visitList){
        string TealLogo =  '<html><body><img src="https://newdev-ped.cs91.force.com/servlet/servlet.ImageServer?id=0152F0000000xHw&oid=00D2F0000000UZi&lastMod=1555913835000" /><br/></body></html>';
        string imageLink ='';
       // string noImageLink = '';
        Map<id,User> UserList = new Map<id,user>([SELECT ID, Name, Email FROM User]);
        Map<id,Account> AccList = new Map<id,Account>([SELECT Id, Name FROM Account]);

        for(Visit__c vl: visitList){
            imageLink = '<html><body><a href="'+'https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017Y3Ar&sfdc.override=1&visitId='+vl.id+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GTNA&oid=00D2F0000000UZi&lastMod=1561466129000" height="75" width="100"/></a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="'+'https://titanlightningapps--c.na79.visual.force.com/apex/SurveyManagerPage?id=a091O000017Y3Ar&sfdc.override=1&visitId='+vl.id+'&noImage=true'+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GTNU&oid=00D2F0000000UZi&lastMod=1561466206000" height="75" width="100"/></a></body></html>';
            //noImageLink = '<html><body><a href="'+'https://c.cs91.visual.force.com/apex/SurveyManagerPage?id=a092F000000Gr3n&sfdc.override=1&visitId='+vl.id+'&noImage=true'+'"><img src="https://c.cs91.content.force.com/servlet/servlet.ImageServer?id=0152F000000GTNU&oid=00D2F0000000UZi&lastMod=1561466206000" height="90" width="120"/></a></body></html>';
            if(vl.Visit_Type__c == 'By Customer'){
                List<string> emailIterationList = new List<string>();
                emailIterationList.add(UserList.get(vl.OwnerId).Email);
                emailIterationList.addAll(Label.Email_address.split(','));
                system.debug('emailIterationList:'+emailIterationList);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(emailIterationList);
                mail.setSubject('Voice of customer survey');
                mail.setHtmlBody('Hi '+ UserList.get(vl.OwnerId).Name+',<br/>'+'<br/>Regarding the visit done by the '+ AccList.get(vl.Account__c).Name+', Would you like to send the survey to the customer. <br/>'+imageLink+'<br/><br/>Thanks & Regards,<br/>'+TealLogo+'Titan Engineering & Automation Limited <br/>(Wholly Owned Subsidiary Of Titan Company Limited)<br/>A TATA Enterprise  <br/>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India <br/>www.titanteal.com');
                mail.setUseSignature(false);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
              /*  
                Visit__c visit = new Visit__c(id=vl.Id);
                visit.SurveyImageLink__c = imageLink;
                update visit;*/
            }
        }
    }
}