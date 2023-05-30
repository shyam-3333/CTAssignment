/**
* @description       : 
* @author            : ChangeMeIn@UserSettingsUnder.SFDoc
* @group             : 
* @last modified on  : 03-23-2021
* @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
* Modifications Log 
* Ver   Date         Author                               Modification
* 1.0   03-23-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class DailyEmailSchedulerTaniera Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        datetime startDateTime;
        list<product__c> dataList = new list<product__c>();
        IF(DateTime.now().hour() == 8){
            startDateTime = datetime.now().addHours(-16);
        }
        else if(DateTime.now().hour() == 16){
            startDateTime = datetime.now().addHours(-8);
        }
        
        //datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        dataList = [SELECT id from product__c where pricing_date__c >= :startDateTime and pricing_date__c < :endDateTime];
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
        PageReference pref = page.EmailAlertClassification; // Visualforce Page Name
        pref.setRedirect(true);
        Blob b;
        if(!Test.isRunningTest()){
            b = pref.getContent();
        }
        else{
            b = Blob.valueOf('Test Blob Content');
        }
        
        attach.setFileName(date.today()+'-Classification Data.xls');
        attach.setBody(b);
        string [] toaddress= New string[]{'sfdcadmin@titan.co.in','harishk2@titan.co.in','kamalkc@titan.co.in','rengasamyb@titan.co.in','akash@titan.co.in'};
            email.setSubject('Classification Data');
        email.setPlainTextBody('PFA');
        email.setToAddresses(toaddress);
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
        //*********************************************************************************************************************************** 
        Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
        List<Messaging.EmailFileAttachment> attachlist = new list<Messaging.EmailFileAttachment>();
        Messaging.EmailFileAttachment attach1R = new Messaging.EmailFileAttachment();
        
        //datetime startDateTime = datetime.now().addHours(-24);
        //datetime endDateTime = datetime.now();
        //Integer reorderCount = [select count() from product__c where  pricing_date__c > :startDateTime and pricing_date__c < :endDateTime And RE_ORDER__c= true ];
        /*
if( reorderCount > 0)
{
PageReference pref1R = page.EmailAlertExcise; // Visualforce Page Name
pref1R.getParameters().put('Reorder','True');
pref1R.setRedirect(true);
Blob b1R;

if(!Test.isRunningTest()){
b1R = pref1R.getContent();
}
else{
b1R = Blob.valueOf('Test Blob Content');
}

attach1R.setFileName(date.today()+'Reorder-Price Update.xls');
attach1R.setBody(b1R);
attachlist.add( attach1R );
}
*/
        
        Messaging.EmailFileAttachment attach1 = new Messaging.EmailFileAttachment();
        
        /* Integer newCount = [select count() from product__c where  pricing_date__c > :startDateTime and pricing_date__c < :endDateTime And RE_ORDER__c= false ];
if( newCount > 0)
{ */
        PageReference pref1 = page.EmailAlertExcise; // Visualforce Page Name
        //pref1.getParameters().put('Reorder','false');
        pref1.setRedirect(true);
        Blob b1;
        if(!Test.isRunningTest()){
            b1 = pref1.getContent();
        }
        else{
            b1 = Blob.valueOf('Test Blob Content');
        }
        
        attach1.setFileName(date.today()+'-Price Update.xls');
        attach1.setBody(b1);
        attachlist.add( attach1 );
        // }
        
        
        string [] toaddress1 = New string[]{'excisewatches@titan.co.in','sfdcadmin@titan.co.in'};
            string [] ccAddress1 = new string[]{'harishk2@titan.co.in','amritakshad@titan.co.in','sathyap@titan.co.in','kannan2@titan.co.in','medha@titan.co.in','aanchalp@titan.co.in','kamalkc@titan.co.in','rengasamyb@titan.co.in','akash@titan.co.in'};
                email1.setSubject('Price Update');
        email1.setPlainTextBody('PFA');
        email1.setToAddresses(toaddress1);
        email1.setCcAddresses(ccAddress1);
        if(attachlist.size() > 0)
            email1.setFileAttachments(attachlist);
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email1});
        //******************************************************************************************************************************
        Messaging.SingleEmailMessage email2 = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attach2 = new Messaging.EmailFileAttachment();
        
        PageReference pref2 = page.EmailAlertCategory; // Visualforce Page Name
        pref2.setRedirect(true);
        Blob b2;
        if(!Test.isRunningTest()){
            b2 = pref2.getContent();
        }
        else{
            b2 = Blob.valueOf('Test Blob Content');
        }
        
        attach2.setFileName(date.today()+'-Pricing Data.xls');
        attach2.setBody(b2);
        string [] toaddress2= New string[]{'harishk2@titan.co.in','amritakshad@titan.co.in','medha@titan.co.in','sfdcadmin@titan.co.in','kamalkc@titan.co.in','aanchalp@titan.co.in','rengasamyb@titan.co.in','akash@titan.co.in'};
            email2.setSubject('Pricing Data');
        email2.setPlainTextBody('PFA');
        email2.setToAddresses(toaddress2);
        email2.setFileAttachments(new Messaging.EmailFileAttachment[]{attach2});
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email2});
    }
    public void nullemail(){
        /******For classification data mail triggers when the data is empty******/
        string [] toaddress1= New string[]{'harishk2@titan.co.in','amritakshad@titan.co.in','sfdcadmin@titan.co.in','harishk2@titan.co.in','kamalkc@titan.co.in','rengasamyb@titan.co.in','akash@titan.co.in'};
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toaddress1);
        email.setSubject('Classification Data');
        
         IF(DateTime.now().hour() == 8 || Test.isRunningTest()){
            email.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period From 4PM to 8AM. <br/><br/>');
        }
        IF(DateTime.now().hour() == 16 || Test.isRunningTest()){
            email.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period From 8AM to 4PM. <br/><br/>');
        }
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        
        /******For Price Update mail triggers when  the data is empty******/
        string [] toaddress2 = New string[]{'harishk2@titan.co.in','amritakshad@titan.co.in','excisewatches@titan.co.in','sfdcadmin@titan.co.in'};
            string [] ccAddress2 = new string[]{'sathyap@titan.co.in','kannan2@titan.co.in','medha@titan.co.in','aanchalp@titan.co.in','kamalkc@titan.co.in','rengasamyb@titan.co.in','akash@titan.co.in'};
                Messaging.SingleEmailMessage email2 = new Messaging.SingleEmailMessage();
        email2.setToAddresses(toaddress2);
        email2.setCcAddresses(ccAddress2);
        email2.setSubject('Price Update');
        IF(DateTime.now().hour() == 8 || Test.isRunningTest() ){
            email2.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period From 4PM to 8AM. <br/><br/>');
        }
        IF(DateTime.now().hour() == 16 || Test.isRunningTest() ){
            email2.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period From 8AM to 4PM. <br/><br/>');
        }
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email2 });
        
        /******For Pricing Data mail triggers when  the data is empty******/
        string [] toaddress3= New string[]{'harishk2@titan.co.in','amritakshad@titan.co.in','medha@titan.co.in','sfdcadmin@titan.co.in','kamalkc@titan.co.in','aanchalp@titan.co.in','rengasamyb@titan.co.in','akash@titan.co.in'};
            Messaging.SingleEmailMessage email3 = new Messaging.SingleEmailMessage();
        email3.setToAddresses(toaddress3);
        email3.setSubject('Pricing Data');
        IF(DateTime.now().hour() == 8 || Test.isRunningTest() ){
            email3.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period From 4PM to 8AM . <br/><br/>');
        }
       IF(DateTime.now().hour() == 16 || Test.isRunningTest()  ){
            email3.setHtmlBody('Dear Team, <br/><br/>There was no pricing in the said period From 8AM to 4PM. <br/><br/>');
        }
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email3 });
    }
    
}