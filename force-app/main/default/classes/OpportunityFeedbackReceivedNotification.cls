/*      
@Name                  OpportunityFeedbackReceivedNotification
@Author                Gauri
@Version               1.0
@CreatedDate           31/8/2022
@UsedBy                
@Description           To send feedback received notification to the opportunity owner and team members
@Changes
UserId           | Author-Email                    | Date      | Comment
=================|====================================|===========|=========
|  |    |
*/
public without sharing class OpportunityFeedbackReceivedNotification {
    /*    
     * @description  To send feedback received notification to opportunity owner and team members
     * @param        List<EmailPayload> requests
     */
    @InvocableMethod(label='Feedback Received Notification' description='Send Email to Opportunity Owner and Team Members')
    public static void sendFeebackReceivedNotification(List<EmailPayload> requests){
        List<Messaging.SingleEmailMessage> sendEmailList = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'sfdcadmin@titan.co.in'];
        List<String> toEmailAddresses = new List<String>();//Stores the list of emails to which the email notifications should be sent
        
        //Loop through each email pay load and draft an email
        for(EmailPayload epl : requests){
            toEmailAddresses.addAll(String.isNotBlank(epl.emailList) ? epl.emailList.split(',') : new List<String>());
            if(!toEmailAddresses.isEmpty()){ 
                
                
                if(!Test.isRunningTest()){
                    toEmailAddresses.add(System.Label.Titan_Feedback_Email);  
                }
                toEmailAddresses = getToEmails(toEmailAddresses);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSubject(epl.emailSubject);
                mail.setHtmlBody(epl.emailBody);
                mail.setToAddresses(toEmailAddresses);
                if ( owea.size() > 0 ) {
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                }
                sendEmailList.add(mail);
                toEmailAddresses.clear();
            }
        }       
        //Check if the email list is not empty and send email
        if(!sendEmailList.isEmpty()){
            List<Messaging.SendEmailResult> results = Messaging.sendEmail(sendEmailList);
            if (!results.get(0).isSuccess()) {
                System.StatusCode statusCode = results.get(0).getErrors()[0].getStatusCode();
                String errorMessage = results.get(0).getErrors()[0].getMessage();
                system.debug(LoggingLevel.WARN,'ERROR : Status Code - '+statusCode+' Error Message '+errorMessage);
            }else{
                system.debug(LoggingLevel.WARN,'Email has been sent successfully');
            }
        }
        
    }
    
    /**    
* @description  To clear the blank values in the email list
* @param        List<String> emailList
* @return		List<String> DESCRIPTION: List of emails
*/
    @TestVisible
    private static List<String> getToEmails(List<String> emailList){
        List<String> toEmailList = new List<String>();
        toEmailList.addAll(emailList);
        Integer index = 0;
        for(String email : emailList){
            if(String.isBlank(email)){
                toEmailList.remove(index);
            }
            index++;
        }
        return toEmailList;
    }
      
    /**    
     * @description  Wrapper class to store the email pay load values passed from the flow
     */
    
    public class EmailPayload{
        
        @InvocableVariable
        public String emailSubject;
        
        @InvocableVariable
        public String emailBody;
        
        @InvocableVariable
        public String emailList;
    }
}