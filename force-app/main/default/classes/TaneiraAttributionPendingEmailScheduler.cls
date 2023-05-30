global class TaneiraAttributionPendingEmailScheduler implements schedulable{
    global void execute(SchedulableContext sc){
        PageReference PdfAtt = Page.TaneiraAttributionPendingRecordEmail;	
        Blob b; 
        if(Test.IsRunningTest()){
            b = Blob.valueOf('UNIT.TEST');
        }
        else{
            b = PdfAtt.getContentAsPDF();  
        }
        system.debug('blob data:=='+b);
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.pdf');
        efa.setBody(b);
        
        Messaging.SingleEmailMessage mails = new Messaging.singleEmailMessage();
        mails.setToAddresses(new string[]{'vinoth.kumar@kvpcorp.com'});
        mails.setSubject('Attribution Pending records reminder');
        mails.setPlainTextBody('Hi, PFA');
        mails.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mails});
    }
}