public class testmail {
public static void sendmail(List<Account> acclist){
       // Account accc = [SELECT Id, Recipient_Email_Address__c, Name FROM Account WHERE Id = :accountID LIMIT 1];

		// Define the email template ID
		Id emailTemplateId = '00X7d000000slSnEAI';
   	 List<messaging.SingleEmailMessage> emails = new List<messaging.SingleEmailMessage>();
    	for(Account accc:acclist)
        if(string.isNotBlank(accc.Recipient_Email_Address__c)){
            
			
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(new List<String>{accc.Recipient_Email_Address__c});
            mail.setTemplateId(emailTemplateId);
            mail.setwhatId(accc.Id);
            mail.setTreatTargetObjectAsRecipient(false);
		mail.setTargetObjectId('0037d000029nshkAAA');
        mail.setSaveAsActivity(False);
        emails.add(mail);    

		// Send the email
		//Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        }
	}
}