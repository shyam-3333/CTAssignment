global class RTWemailscheduler Implements schedulable {
    global void execute(schedulableContext sc){
        list<RTW_Product__c> dataList = new list<RTW_Product__c>();
        datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        dataList = [SELECT id,RTW_Pricing_Submitted_Date__c from RTW_Product__c where RTW_Pricing_Submitted_Date__c > :startDateTime and RTW_Pricing_Submitted_Date__c < :endDateTime];
        system.debug('datalist'+dataList.size());
        if(dataList.size()>0){
           sendmail();
        }
        else if(dataList.size()==0){
            nullemail();
        }
    }
    public void sendmail()
    {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        PageReference pref = page.RTWclassificationdataPage; // Visualforce Page Name
        pref.setRedirect(true);
        Blob b;
        if(!Test.isRunningTest()){
            b = pref.getContent();
        }
        else{
            b = Blob.valueOf('Test Blob Content');
        }
        
        attach.setFileName(date.today()+'-RTW Classification Data.xls');
        attach.setBody(b);
        string [] toaddress= New string[]{'sfdcadmin@titan.co.in','aanchalp@titan.co.in'};
            email.setSubject('RTW Classification Data');
        email.setPlainTextBody('PFA');
        email.setToAddresses(toaddress);
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
        //*********************************************************************************************************************************** 
        Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
        List<Messaging.EmailFileAttachment> attachlist = new list<Messaging.EmailFileAttachment>();
        Messaging.EmailFileAttachment attach1R = new Messaging.EmailFileAttachment();
        
        
        
        Messaging.EmailFileAttachment attach1 = new Messaging.EmailFileAttachment();
        
       PageReference pref1 = page.RTWpriceupdatePage; // Visualforce Page Name
          pref1.setRedirect(true);
        Blob b1;
        if(!Test.isRunningTest()){
            b1 = pref1.getContent();
        }
        else{
            b1 = Blob.valueOf('Test Blob Content');
        }
        
        attach1.setFileName(date.today()+'-RTW Price Update.xls');
        attach1.setBody(b1);
        attachlist.add( attach1 );
        // }
        
        
        string [] toaddress1 = New string[]{'aanchalp@titan.co.in'};
            string [] ccAddress1 = new string[]{'sfdcadmin@titan.co.in'};
                email1.setSubject('RTW Price Update');
        email1.setPlainTextBody('PFA');
        email1.setToAddresses(toaddress1);
        email1.setCcAddresses(ccAddress1);
        if(attachlist.size() > 0)
            email1.setFileAttachments(attachlist);
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email1});
        //******************************************************************************************************************************
        Messaging.SingleEmailMessage email2 = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attach2 = new Messaging.EmailFileAttachment();
        
        PageReference pref2 = page.RTWpricingdata; // Visualforce Page Name
        pref2.setRedirect(true);
        Blob b2;
        if(!Test.isRunningTest()){
            b2 = pref2.getContent();
        }
        else{
            b2 = Blob.valueOf('Test Blob Content');
        }
        
        attach2.setFileName(date.today()+'-RTW Pricing Data.xls');
        attach2.setBody(b2);
        string [] toaddress2= New string[]{'sfdcadmin@titan.co.in','aanchalp@titan.co.in'};
            email2.setSubject('RTW Pricing Data');
        email2.setPlainTextBody('PFA');
        email2.setToAddresses(toaddress2);
        email2.setFileAttachments(new Messaging.EmailFileAttachment[]{attach2});
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email2});
    }
     public void nullemail(){
        /******For classification data mail triggers when the data is empty******/
        string [] toaddress1= New string[]{'sfdcadmin@titan.co.in','aanchalp@titan.co.in'};
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toaddress1);
        email.setSubject('RTW Classification Data');
        
         IF(DateTime.now().hour() == 20 || Test.isRunningTest()){
            email.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period.  <br/><br/>');
        }
       
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        
        /******For Price Update mail triggers when  the data is empty******/
        string [] toaddress2 = New string[]{'aanchalp@titan.co.in'};
            string [] ccAddress2 = new string[]{'sfdcadmin@titan.co.in'};
                Messaging.SingleEmailMessage email2 = new Messaging.SingleEmailMessage();
        email2.setToAddresses(toaddress2);
        email2.setCcAddresses(ccAddress2);
        email2.setSubject('RTW Price Update');
        IF(DateTime.now().hour() == 20 || Test.isRunningTest() ){
            email2.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period . <br/><br/>');
        }
       
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email2 });
        
        /******For Pricing Data mail triggers when  the data is empty******/
        string [] toaddress3= New string[]{'sfdcadmin@titan.co.in','aanchalp@titan.co.in'};
            Messaging.SingleEmailMessage email3 = new Messaging.SingleEmailMessage();
        email3.setToAddresses(toaddress3);
        email3.setSubject('RTW Pricing Data');
        IF(DateTime.now().hour() == 20 || Test.isRunningTest() ){
            email3.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period  . <br/><br/>');
        }
      
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email3 });
    }


}