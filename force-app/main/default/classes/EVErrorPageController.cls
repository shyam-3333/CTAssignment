public class EVErrorPageController {
     
   
    
    public PageReference openNewPage(){
        
        PageReference pRef=page.ThankYouPageNo3;
        pRef.setRedirect(true);
        
        sendEmails();
        
        return pRef;
        
    }  
    
    
    public static void sendEmails(){
        string accID = ApexPages.currentPage().getParameters().get('ID');
        Id emailTemplateId = '00X7d0000012YcBEAU';
        List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
        OrgWideEmailAddress owea = new OrgWideEmailAddress();
        owea = [SELECT Id, Address, DisplayName FROM 
                OrgWideEmailAddress WHERE DisplayName='Salesforce Admin'];
 

        for(Account acct : [SELECT Id, Owner.Email, Owner.Name, Recipient_Email_Address__c,Name,
                            Recipient_Email_ID_Verified__c FROM Account WHERE Id = :accID]){
                                if(string.isNotBlank(acct.Owner.Email)){
                                    
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setToAddresses(new List<String>{'shyam.k@kvpcorp.com'});
                                    mail.setTemplateId(emailTemplateId);
                                    mail.setWhatId(acct.Id);
                                    mail.setOrgWideEmailAddressId(owea.Id);
                                    mail.setTreatTargetObjectAsRecipient(false);
                                    mail.setTargetObjectId('0037d00002AReZQAA1');
                                    mail.setSaveAsActivity(False);
                                    emails.add(mail);
                                    
                                    Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
                                    for(Messaging.SendEmailResult result : results)
                                    {
                                        if(result.success){
                                            system.debug('Email sent successfully to account owner.');
                                        }else{
                                         	system.debug('Email could not be sent to account owner.'+ result.errors[0].message);
                                        }
                                    }
                                }
                            }

    }
}