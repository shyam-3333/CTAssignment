public class checkEmailExistent {
    @invocableMethod
    public static void doesEmailExist(List<String>emailList) {
    Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
    emailMessage.setToAddresses(emailList);
    emailMessage.setSubject('Test');
    emailMessage.setPlainTextBody('This is a test email.');
    
    Boolean emailExists = false;
    
    try {
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailMessage});
        for (Messaging.SendEmailResult result : results) {
            if (!result.isSuccess()) {
                emailExists = false;
            }
        }
    } catch (Exception e) {
        emailExists = True;
    }
    
}


}