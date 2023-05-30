global class schedulePaymentDetails Implements Schedulable {
    global void execute(SchedulableContext ctx){
      PageReference ref = Page.PaymentDetailsUpdatePage;
       Blob b;
       if(Test.IsRunningTest()){
        b = Blob.valueOf('UNIT.TEST');
       }
       else{
        b = ref.getContent();
       }
       
       list<String> addressLst = new list<String>();
       list<CSpayment_Email__c> lstEmail = CSpayment_Email__c.getall().values(); //custom setting
       for(CSpayment_Email__c em : lstEmail ){
           if(em.Email_Id__c!= null){
              addressLst.add(em.Email_Id__c); 
           }
       }
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment emailAttach = new Messaging.EmailFileAttachment();
        emailAttach.setFileName('paymentDetails.txt');
        emailAttach.setBody(b);
        //email.setToAddresses(new String[] {'mailtitansfdc@gmail.com','achyutm@titan.co.in','antarjyami@titan.co.in','sreenivasab@titan.co.in','rakeshg@titan.co.in'});
        email.setToAddresses(addressLst);
        email.setSubject('Payment Tracker Details');
        email.setPlainTextBody('Please find the attachment for details of indent gift voucher');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttach});
        if(!test.isRunningTest()){
            Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }

    }
}