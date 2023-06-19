public class AddEmailAddressCont{
    /**
* @description 
* @param  
* @return 
*/
        @AuraEnabled
    public static String fieldUpdate(String accountRecordId){
        System.debug(accountRecordId);
        String errorMessage = 'No error';
        List<Account> accList = new List<Account>();
        List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
        Id emailTemplateId1 = '00X7d000000slSnEAI';
        Id emailTemplateId2 = '00X7d0000012Z3DEAU';
        String primaryContactEmail='';
        for(Contact con : [Select Id, Name, email, Primary_Contact__c from Contact where Primary_Contact__c =: true AND AccountId =: accountRecordId limit 1]){
            if(string.isNotBlank(con.email)){
                primaryContactEmail = con.email;
            }
        }
        System.debug('primaryContactEmail---> '+primaryContactEmail);
        for(Account acc : [SELECT Id, Owner.Email, Recipient_Email_Address__c, Customer_Primary_Contact__c, Name,Verification_Sent_On__c,
                           Recipient_Email_ID_Verified__c,Verification_Received_On__c FROM Account WHERE Id = :accountRecordId]){
            if((acc.Verification_Sent_On__c == null && acc.Recipient_Email_ID_Verified__c == false) || 
              (acc.Verification_Sent_On__c != null && System.now() > acc.Verification_Sent_On__c.addHours(24) && acc.Recipient_Email_ID_Verified__c == false)){
            System.debug('1');
            acc.Verification_Sent_On__c = System.now();//Field Update.
            acc.Verification_Received_On__c = null;      
            accList.add(acc);
            
            if(string.isNotBlank(acc.Recipient_Email_Address__c)){
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();//Send Email to Recipient Email.
                mail.setToAddresses(new List<String>{acc.Recipient_Email_Address__c});
                mail.setTemplateId(emailTemplateId1);
                mail.setwhatId(acc.Id);
                mail.setTreatTargetObjectAsRecipient(false);
                mail.setTargetObjectId('0037d000029nshkAAA');
                mail.setSaveAsActivity(False);
                emails.add(mail);    
                
                if(string.isNotBlank(primaryContactEmail)){
                    if(string.isNotBlank(acc.Customer_Primary_Contact__c)){
                        
                        Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();//Send Email to Primary Contact Email
                        mail2.setToAddresses(new List<String>{primaryContactEmail});
                        mail2.setTemplateId(emailTemplateId2);
                        mail2.setwhatId(acc.Id);
                        mail2.setTreatTargetObjectAsRecipient(false);
                        mail2.setTargetObjectId('0037d000029nshkAAA');
                        mail2.setSaveAsActivity(False);
                        emails.add(mail2);                          
                    }
                }    
                // Send the email
                Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
            }
            else{
                errorMessage = 'Please enter recipient email address';
            }
        }
            else if(acc.Verification_Sent_On__c != null && System.now() < acc.Verification_Sent_On__c.addHours(24)  && acc.Recipient_Email_ID_Verified__c == false){
                errorMessage = 'Email verification link is already sent. Please try again after 24 hours';
            System.debug('2');
            }
            else if((acc.Verification_Sent_On__c != null && System.now() < acc.Verification_Sent_On__c.addHours(24)  && acc.Recipient_Email_ID_Verified__c == true) || 
            (acc.Verification_Sent_On__c != null && System.now() > acc.Verification_Sent_On__c.addHours(24) && acc.Recipient_Email_ID_Verified__c == true)){
                errorMessage = 'Email is already verified';
            System.debug('3');
            }
        }
        update accList;
        System.debug('errorMessage---> '+errorMessage);
        return errorMessage;	
    }
    
    @AuraEnabled
    public static boolean sendVerification(String otherEmails, String accountRecordId)
    {
        List<String> seperatedEmailsList = otherEmails.split(',');
        Boolean res = true; 
        for(String em : seperatedEmailsList){
            em = em.trim();            
            String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
            Pattern MyPattern = Pattern.compile(emailRegex);
            Matcher MyMatcher = MyPattern.matcher(em);
            
            if (!MyMatcher.matches()){
                res = false;            
            }
            else{
                Id emailTemplateId2 = '00X7d0000012Z3DEAU';
                List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(seperatedEmailsList);
                mail.setTemplateId(emailTemplateId2);
                mail.setwhatId(accountRecordId);
                mail.setTreatTargetObjectAsRecipient(false);
                mail.setTargetObjectId('0037d000029nshkAAA');
                mail.setSaveAsActivity(False);
                emails.add(mail); 
                Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
            }
        }
        System.debug('seperatedEmailsList---> '+seperatedEmailsList);
        return res;	
        
    }
}