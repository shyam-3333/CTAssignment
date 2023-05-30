public class EV_QuoteApprovalController {
    
    @AuraEnabled
    public static String quoteApproval(String quoteRecordId){
        System.debug(quoteRecordId);
        String recipientEmail = [Select Id,Recipient_Email_ID__c from Quote where Id =: quoteRecordId].Recipient_Email_ID__c;
        return recipientEmail;
    }
    @AuraEnabled
    public static String saveEmail(String newEmail, String quoteRecordId){
        //List<String> seperatedEmailsList = otherEmails.split(',');
        String result = 'No error'; 
        List<Quote> quoteList = new List<Quote>();
        String em = newEmail.trim();            
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
        Pattern myPattern = Pattern.compile(emailRegex);
        Matcher myMatcher = myPattern.matcher(em);
        
        if (!myMatcher.matches()){
            result = 'format error';            
        }
        else {
            for(Quote q : [Select Id, Name, Recipient_Email_ID__c from Quote where Id =: quoteRecordId]){
                if(q.Recipient_Email_ID__c == em){
                    result = 'same email';
                }
                else {
                q.Recipient_Email_ID__c = em;
                quoteList.add(q);
                }
            }  
        }
        update quoteList;
        return result;	
        
    }
}