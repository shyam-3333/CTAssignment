global class NPD_Exception_Report_SchedulerOriginal implements Schedulable{
    global void execute(SchedulableContext ctx){
        PageReference ref = Page.NPD_Exception_Report_PageOrgnl;
        Blob b;
       if(Test.IsRunningTest()){
        b = Blob.valueOf('UNIT.TEST');
       }
       else{
        b = ref.getContent();
       }
       list<String> addressLst = new list<String>();
       list<Email__c> lstEmail = Email__c.getall().values();
       //Email__c is a custom setting object
       //list<Email__c> lstEmail = [select Name, EmailId__c from Email__c];
       for(Email__c em : lstEmail ){
           if(em.EmailId__c != null){
              addressLst.add(em.EmailId__c); 
           }
       }
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment emailAttach = new Messaging.EmailFileAttachment();
        emailAttach.setFileName('exceptionReport.xls');
        emailAttach.setBody(b);
        
        email.setToAddresses(addressLst);
        //email.setCcAddresses(new String[] {'rakeshg@titan.co.in'});
        email.setSubject('Exception Report');
        email.setPlainTextBody('Please find the attachment for details of exception');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttach});
        if(!test.isRunningTest()){
            Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }

    }

}