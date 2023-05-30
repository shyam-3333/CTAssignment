public class EvEmailTemplateVerification {
    
      
   /* public static pagereference action(){
        string accountID = ApexPages.currentPage().getParameters().get('accID');
        PageReference pageref;
        String redirectURL= updater(accountID);
        pageref = new PageReference(redirectURL);
        pageref.setRedirect(TRUE);
        return pageref;    	
    }
    
    public static string updater(String accountID){ 
        String redirectURL;
        
        Account account = [SELECT Id, Recipient_Email_ID_Verified__c,Verification_Received_On__c, Recipient_Email_Address__c, Verification_Sent_On__c FROM Account WHERE Id =:accountID];
        EmailMessage messageToValidate = new EmailMessage();
        Boolean validateWithin24Hours = isWithin24Hour(account.Verification_Sent_On__c,Datetime.now());    
        
        if(validateWithin24Hours){
            
            if(!account.Recipient_Email_ID_Verified__c){
                
                //Redirect to page1
                redirectURL = 'https://titanlightningapps--npdskdev.sandbox.my.salesforce-sites.com/ThankONSucces';
                
                //Update Account Fields
                account.Recipient_Email_ID_Verified__c = true; 
                account.Verification_Received_On__c = DateTime.now();
                
                List<Quote> quoteupdate = [SELECT Id, Recipient_Email_ID__c FROM Quote WHERE AccountId =:account.Id];
                for(Quote quote : quoteupdate){
                    quote.Recipient_Email_ID__c = account.Recipient_Email_Address__c;
                }
                update quoteupdate;
                
                //Send Email to Accountowner
                sendEmailToAccountOwner(accountID);
            }
        }else{
            account.Recipient_Email_ID_Verified__c = false;
            redirectURL = 'https://titanlightningapps--npdskdev--c.sandbox.vf.force.com/apex/EV_VerificationLinkExpired';
        }
        update Account;
        return redirectURL;
    }
    
    public static boolean isWithin24Hour(Datetime mailRecievedDatetime, Datetime clickedDatetime){
        system.debug('clickedDatetime'+clickedDatetime);
        system.debug('mailRecievedDatetime'+mailRecievedDatetime);
        
        Datetime tillValidateDatetime = mailRecievedDatetime.addHours(24);
        system.debug('tillValidateDatetime'+ tillValidateDatetime);
        
        if(tillValidateDatetime >= clickedDatetime){
            system.debug('within time');
            return true;    
            
        }else{
            system.debug('out of time');
            return false; 
        }
    }
    public static void sendEmailToAccountOwner(string accountID) // Email to  Account Ownerowner
    {
        Id emailTemplateId = '00X7d0000012YcBEAU';
        List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
        OrgWideEmailAddress owea = new OrgWideEmailAddress();
        owea = [SELECT Id, Address, DisplayName FROM 
                OrgWideEmailAddress WHERE DisplayName='Salesforce Admin'];
 

        for(Account acct : [SELECT Id, Owner.Email, Owner.Name, Recipient_Email_Address__c,Name,
                            Recipient_Email_ID_Verified__c FROM Account WHERE Id = :accountID]){
                                if(string.isNotBlank(acct.Owner.Email)){
                                    
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setToAddresses(new List<String>{'meghna.g@kvpcorp.com'});
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
    } */
}