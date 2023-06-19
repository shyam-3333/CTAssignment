public class EVErrorPageController {
     
   
    
     public PageReference openNewPage(){
        
        PageReference pageRef = new PageReference('https://titanlightningapps--npdskdev.sandbox.my.salesforce-sites.com/RecentVerificationLink');
        pageRef.setRedirect(TRUE);
        sendEmails();
        return pageRef;
        
    }  
    
    public static void sendEmails()//Email to  Account Ownerowner
    {           
        string accID = ApexPages.currentPage().getParameters().get('accId');
       
        Id emailTemplateId = '00X7d0000012YcBEAU';
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress owea = new OrgWideEmailAddress();
        owea = [SELECT Id, Address, DisplayName FROM 
                OrgWideEmailAddress WHERE DisplayName='Salesforce Admin'];
        
 

        for(Account acct : [SELECT Id, Owner.Email, Owner.Name, Recipient_Email_Address__c,Name,
                            Recipient_Email_ID_Verified__c FROM Account WHERE Id = :accID ]){
                                System.debug('Coming Inside Account check');
                                if(string.isNotBlank(acct.Owner.Email)){
                                    System.debug('Coming Inside Account check');
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setToAddresses(new List<String>{'shyam.k@kvpcorp.com'});
                                    mail.setTemplateId(emailTemplateId);
                                    mail.setWhatId(acct.Id);
                                    mail.setOrgWideEmailAddressId(owea.Id);
                                    mail.setTreatTargetObjectAsRecipient(false);
                                    mail.setTargetObjectId('0037d00002AReZQAA1');
                                    mail.setSaveAsActivity(False);
                                    emails.add(mail);
                                    System.debug('emails'+emails);
                                    
                                    
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