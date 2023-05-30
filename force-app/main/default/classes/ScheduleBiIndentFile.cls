/*Name             : ScheduleBiIndentFile 
    Created By         : Suyog B Magar
    Email              : magarsuyog.b@kvpcorp.com
    Created Date       :
    Modified By        :
    Last Modified Date :
    Description        : Indent records created within 24 hours should be sent in  txt file format    */

global class ScheduleBiIndentFile Implements Schedulable {
    global void execute(SchedulableContext ctx){
        BiIndentFile obj=new BiIndentFile();
        integer recordsCount=obj.getCount();
        PageReference ref = Page.BiIndentFile;
        Blob b;
        if(Test.IsRunningTest() || ref.getContent().size()==0){
            b = Blob.valueOf('     ');
        }
        else{
            b =ref.getContent();
            }
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment emailAttach = new Messaging.EmailFileAttachment();
        emailAttach.setFileName('indent.txt');
        emailAttach.setBody(b);
        list<String> addressLst = new list<String>{'sfdcadmin@titan.co.in','vyshnavi@titan.co.in'};
        email.setToAddresses(addressLst);
        email.setSubject('Quote Indent');
        email.setPlainTextBody('Please find the attached the details of Indents created in the last 24 hours. Total of '+recordsCount+' indents got created.');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttach});
        if(!test.isRunningTest()){
            Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }        
    }
}
/*
ScheduleBiIndentFile scheBiInd = new ScheduleBiIndentFile();
String crn = '0 15 16 ? * * *';
String jobID = system.schedule('BiIndent', crn, scheBiInd);
*/