//Created By: Meghna Gupta
//Actions to be performed 

public class EV_EmailTemplateVerification {
    public EV_EmailTemplateVerification(){
    }
    
    public static pagereference action(){
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

        for(Account acct : [SELECT Id, Owner.Email, Owner.Name, Recipient_Email_Address__c,Name,
                            Recipient_Email_ID_Verified__c FROM Account WHERE Id = :accountID]){
                                if(string.isNotBlank(acct.Owner.Email)){
                                    
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setToAddresses(new List<String>{'meghnagupta015@gmail.com'});
                                    mail.setTemplateId(emailTemplateId);
                                    mail.setWhatId(acct.Id);
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
    /*public static void sendEmailToSOuser()
{
string accountID = ApexPages.currentPage().getParameters().get('accID');
Account acct = [SELECT Id, Region_Picklist__c, Recipient_Email_Address__c, Name FROM Account WHERE Id = :accountID];

Map<String, String> regionToProfileMap = new Map<String, String>{
'North' => 'SO North Profile',
'South' => 'SO South Profile',
'East' =>  'SO East Profile',
'West' =>  'SO West Profile'};

List<User> users = [SELECT Id, Email FROM User WHERE Profile.Name IN :regionToProfileMap.values()];    

Map<String, String> profileToEmailMap = new Map<String, String>();
for (User user : users) {
profileToEmailMap.put(user.Profile.Name, user.Email);
}

List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
String region = acct.Region_Picklist__c;
String profileName = regionToProfileMap.get(region);
String recipientEmail = profileToEmailMap.get(profileName);

String emailBody = '<p>Dear ' + profileName + ',</p>' +
'<p>The recipient email address has been verified by the customer.</p>' +
'<p>Verified Recipient Email Address:'+ acct.Recipient_Email_Address__c +'</p>' +
'<br/>' +
'<br/>' +
'<p>Titan Engineering &amp; Automation Limited</p>' +
'<p>(Wholly Owned Subsidiary Of Titan Company Limited)</p>' +
'<p>A TATA Enterprise</p>' +
'<p>Office: 28, Sipcot Industrial Complex (Phase-I), Hosur-635126(TN), India</p>' +
'<br/>' +
'<br/>' +
'<p>This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error, please notify the sender immediately by email or delete this email from your system. If you are not the intended recipient, you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited. The opinion expressed in this mail is that of the sender and does not necessarily reflect that of Titan.</p>' +
'<br/>' +
'<br/>' +
'<p>WARNING: Despite best possible precautionary measures taken by Titan Company Limited, computer viruses can be transmitted via email. The recipient should check and scan this email and any attachments for the presence of viruses. Titan Company Limited accepts no liability for any damage caused by any virus transmitted by this email</p>';


Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new List<String>{profileToEmailMap.get(profileName)});
mail.setSubject('Recipient Email is verified - ' + acct.Name);
mail.setHtmlBody(emailBody);

Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});

}*/
}