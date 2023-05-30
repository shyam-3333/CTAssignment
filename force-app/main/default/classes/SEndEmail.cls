public class SEndEmail {
   
    public static void mailSending(){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        
        
        mail.setToAddresses(new List<String>{'shyamkhadse3399@gmail.com'});
        mail.setSubject('This is for testing only');
        mail.setPlainTextBody('Hi this is the body of testing email');
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
           
            
                                             
    }

}