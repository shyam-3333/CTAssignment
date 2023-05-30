/*Author: Vindya
Description:Scheduler class to run everyday at 8AM for Payment tracker
*/
global  class Paymenttracker Implements Schedulable{
    global void execute(SchedulableContext sc)
    {
        list<Payment_Tracker__c> dataList = new list<Payment_Tracker__c>();
        datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        dataList = [SELECT id,createddate from Payment_Tracker__c where createddate>:startDateTime and createddate<:endDateTime];
        List<Opportunity> opplist = new list<Opportunity>();
        if(dataList.size()>0){
            sendmail();
        }
    }
    public void sendmail(){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        PageReference pref = page.Paymanttrackeremail; // Visualforce Page Name
        pref.setRedirect(true);
        Blob b;
        if(!Test.isRunningTest()){
            b = pref.getContent();
        }
        else{
            b = Blob.valueOf('Test Blob Content');
        }
        attach.setFileName(date.today()+'-Payment tracker Data.xls');
        attach.setBody(b);
        string [] toaddress= New string[]{'sfdcadmin@titan.co.in','vyshnavi@titan.co.in'};
            email.setSubject('Payment tracker scheduler');
        email.setPlainTextBody('PFA');
        email.setToAddresses(toaddress);
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
    }
}