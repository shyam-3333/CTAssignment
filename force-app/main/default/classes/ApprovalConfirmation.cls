public class ApprovalConfirmation {

  /* @AuraEnabled
    public static QuoteWrapper quoteApproval(String quoteRecordId){
        System.debug(quoteRecordId);
        Boolean verified = false;
        QuoteWrapper quoteData = new QuoteWrapper();
        List<Quote> quoteList = [Select Id,Recipient_Email_ID__c,AccountId from Quote where Id =: quoteRecordId WITH SECURITY_ENFORCED limit 1];
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
    public static void approvalInit(String accId){
        Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(accId);
        
        // Submit on behalf of a specific submitter
        req1.setSubmitterId(UserInfo.getUserId()); 
        
        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('PTO_Request_Process');
        req1.setSkipEntryCriteria(true);
        
        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
    }
    public class QuoteWrapper{
        @AuraEnabled public String recipientEmail;
        @AuraEnabled public String verified;
    }*/
}