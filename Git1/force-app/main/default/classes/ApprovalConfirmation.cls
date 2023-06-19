public class ApprovalConfirmation {

  /*  @AuraEnabled
    public static QuoteWrapper quoteApproval(String quoteRecordId){
        System.debug(quoteRecordId);
        Boolean verified = false;
        QuoteWrapper quoteData = new QuoteWrapper();
        List<Quote> quoteList = [Select Id,Recipient_Email_ID__c,AccountId from Quote where Id =: quoteRecordId limit 1];
        Id accountId = [Select Id,AccountId from Quote where Id =: quoteRecordId].AccountId;
        for(Account a : [Select Id, Recipient_Email_ID_Verified__c from Account where Id =: accountId]){
            verified = a.Recipient_Email_ID_Verified__c;
        }
        if(!quoteList.isEmpty()){
            quoteData.recipientEmail = quoteList[0].Recipient_Email_ID__c;
            if(verified == true){
                quoteData.verified = 'True';
            }
            else if(verified == false){
                quoteData.verified = 'False';
            }
            return quoteData;     
        }
        else{
            return quoteData;     
        }
    }
    @AuraEnabled
    public static String saveEmail(String newEmail, String quoteRecordId){
        List<String> seperatedEmailsList = newEmail.split(',');
        String result = 'No error'; 
        List<Quote> quoteList = new List<Quote>();
        List<Account> accList = new List<Account>();
        List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
        Id emailTemplateId1 = '00X7d000000slSnEAI';
        String email = '';     
        email = seperatedEmailsList[0].trim();
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
        Pattern myPattern = Pattern.compile(emailRegex);
        Matcher myMatcher = myPattern.matcher(email);
        
        if (!myMatcher.matches()){
            result = 'format error';            
        }
        else {
            for(Quote q : [Select Id, Name,Recipient_Email_ID__c,AccountId from Quote where Id =: quoteRecordId]){
                if(q.Recipient_Email_ID__c == email){
                    result = 'same email';
                }
                else {
                    q.Recipient_Email_ID__c = email;
                    q.Approval_Status_Quote__c = 'Awaiting Email Verification';
                    quoteList.add(q);
                    for(Account a : [Select Id,Name,Recipient_Email_Address__c,Recipient_Email_ID_Verified__c,Verification_Sent_On__c,
                                     Verification_Received_On__c from Account where Id =: q.AccountId]){
                                         a.Recipient_Email_Address__c = email;
                                         a.Recipient_Email_ID_Verified__c = false;
                                         a.Verification_Sent_On__c = System.now();
                                         a.Verification_Received_On__c = null; 
                                         accList.add(a);
                                         if(string.isNotBlank(email)){
                                             
                                             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();//Send Email to Recipient Email
                                             mail.setToAddresses(new List<String>{a.Recipient_Email_Address__c});
                                             mail.setTemplateId(emailTemplateId1);
                                             mail.setwhatId(a.Id);
                                             mail.setTreatTargetObjectAsRecipient(false);
                                             mail.setTargetObjectId('0037d000029nshkAAA');
                                             mail.setSaveAsActivity(False);
                                             emails.add(mail);
                                             Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
                                         }                 
                                     }
                }
            }  
        }
        update quoteList;
        update accList;
        return result;	     
    }
    @AuraEnabled
    public static String approvalInit(String comment,String quoteId){
        System.debug(quoteId);
        String exceptionMessage = 'success';
        String approvalStatus = [Select id, Approval_status_to_opportunity__c from Quote where Id=: quoteId].Approval_status_to_opportunity__c;
        System.debug(approvalStatus);
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments(comment);
        req1.setObjectId(quoteId);        
        req1.setSubmitterId(UserInfo.getUserId());//Submitted is logged in user 
        req1.setSkipEntryCriteria(true);
        Approval.ProcessResult result;
        try{
            result = Approval.process(req1);
        }
        catch(Exception e){
            if(approvalStatus == 'Pending'){
                exceptionMessage = 'This record is already submitted for approval'; 
            }
            else{
                exceptionMessage = e.getMessage();
            }
        }      
        System.debug('result---> '+result);
        if(result != null){
            exceptionMessage = 'success';
        }
        return exceptionMessage;
    }
    public class QuoteWrapper{
        @AuraEnabled public String recipientEmail;
        @AuraEnabled public String verified;
    }
@AuraEnabled
    public static SendVerificationWrapper sendVerification(String accountRecordId){
        System.debug(accountRecordId);
        SendVerificationWrapper data = new SendVerificationWrapper();
        data.toastError = 'No error';
        for(Account acc : [SELECT Id, Owner.Email, Recipient_Email_Address__c, 	Primary_Contact__c, Name,Verification_Sent_On__c,
                           Recipient_Email_ID_Verified__c,Verification_Received_On__c FROM Account WHERE Id = :accountRecordId]){
                               data.recipientEmail = acc.Recipient_Email_Address__c;
                               if(String.isBlank(acc.Recipient_Email_Address__c)){
                                   data.toastError = 'Please enter recipient email address';
                                   
                               }
                               else if(acc.Verification_Sent_On__c != Null){
                                   if(acc.Verification_Sent_On__c != null && System.now() < acc.Verification_Sent_On__c.addHours(24)  && acc.Recipient_Email_ID_Verified__c == false){
                                       data.toastError = 'Email verification link is already sent. Please try again after 24 hours';
                                       System.debug('2');
                                   }
                                   else if((acc.Verification_Sent_On__c != null && System.now() < acc.Verification_Sent_On__c.addHours(24)  && acc.Recipient_Email_ID_Verified__c == true) || 
                                           (acc.Verification_Sent_On__c != null && System.now() > acc.Verification_Sent_On__c.addHours(24) && acc.Recipient_Email_ID_Verified__c == true)){
                                               data.toastError = 'Email is already verified';
                                               System.debug('3');
                                           }                               
                               }
                           }
        System.debug('data.toastError---> '+data.toastError);
        return data;    
    }
    
    @AuraEnabled
    public static boolean sendEmail(String otherEmails, String accountRecordId)
    {      
        List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
        Id recipientEmailTemplateId = '00X7d0000013HEgEAM';
        Id primaryContactEmailTemplateId = '00X7d0000013HZtEAM';  //00X7d0000012Z3DEAU-older one
        Boolean res = true; 
        if(String.isNotBlank(otherEmails)){
            List<String> seperatedEmailsList = otherEmails.split(',');
            if(!seperatedEmailsList.isEmpty()){
                for(String em : seperatedEmailsList){
                    em = em.trim();            
                    String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
                    Pattern MyPattern = Pattern.compile(emailRegex);
                    Matcher MyMatcher = MyPattern.matcher(em);
                    
                    if(!MyMatcher.matches()){
                        res = false;            
                    }
                    else{
                        if(String.isNotBlank(em)){
                            Messaging.SingleEmailMessage mail3 = new Messaging.SingleEmailMessage();
                            mail3.setToAddresses(new List<String>{em});
                            mail3.setTemplateId(primaryContactEmailTemplateId);
                            mail3.setwhatId(accountRecordId);
                            mail3.setTreatTargetObjectAsRecipient(false);
                            mail3.setTargetObjectId('0037d000029nshkAAA');
                            mail3.setSaveAsActivity(False);
                            emails.add(mail3); 
                        }
                    }
                }
            }
        }
        if(res == true){
        String primaryContactEmail='';
        for(Contact con :[Select Id, Name, Email, Primary_Contact__c from Contact where Primary_Contact__c =: true AND AccountId =: accountRecordId limit 1]){
            if(String.isNotBlank(con.email)){
                primaryContactEmail = con.email;
            }
        }
        List<Account> accList = new List<Account>();
        for(Account acc : [SELECT Id, Owner.Email, Recipient_Email_Address__c, 	Primary_Contact__c, Name,Verification_Sent_On__c,
                           Recipient_Email_ID_Verified__c,Verification_Received_On__c FROM Account WHERE Id = :accountRecordId ]){
                               if((acc.Verification_Sent_On__c == null && acc.Recipient_Email_ID_Verified__c == false) || 
                                  (acc.Verification_Sent_On__c != null && System.now() > acc.Verification_Sent_On__c.addHours(24) && acc.Recipient_Email_ID_Verified__c == false)){
                                      System.debug('First Time Email Send or after 24 hour');                                      
                                      if(String.isNotBlank(acc.Recipient_Email_Address__c)){
                                          acc.Verification_Sent_On__c = System.now();//Field Update
                                          acc.Verification_Received_On__c = null;      
                                          accList.add(acc);
                                          
                                          Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();//Send Email to Recipient Email
                                          mail1.setToAddresses(new List<String>{acc.Recipient_Email_Address__c});
                                          mail1.setTemplateId(recipientEmailTemplateId);
                                          mail1.setwhatId(acc.Id);
                                          mail1.setTreatTargetObjectAsRecipient(false);
                                          mail1.setTargetObjectId('0037d000029nshkAAA');
                                          mail1.setSaveAsActivity(False);
                                          emails.add(mail1);    
                                          
                                          if(String.isNotBlank(primaryContactEmail)){
                                              if(String.isNotBlank(acc.Primary_Contact__c)){
                                                  
                                                  Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();//Send Email to Primary Contact Email
                                                  mail2.setToAddresses(new List<String>{primaryContactEmail});
                                                  mail2.setTemplateId(primaryContactEmailTemplateId);
                                                  mail2.setwhatId(acc.Id);
                                                  mail2.setTreatTargetObjectAsRecipient(false);
                                                  mail2.setTargetObjectId('0037d000029nshkAAA');
                                                  mail2.setSaveAsActivity(False);
                                                  emails.add(mail2);                          
                                              }
                                          }    
                                      }
                                  }
                           }
        update accList;
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        return res;         
    }
    public class SendVerificationWrapper{
        @AuraEnabled public String toastError;
        @AuraEnabled public String recipientEmail;
    }  
*/
}