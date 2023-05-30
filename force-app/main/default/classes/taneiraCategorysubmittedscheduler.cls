public class taneiraCategorysubmittedscheduler implements schedulable{
    
    public void execute(SchedulableContext sc){
        list<product__c> productList =  [Select id,SKU_Code__c,Actual_MRP__c,Category_Submitted_Date__c,category_user_email__c from product__c where Category_Submitted_Date__c = today];
        system.debug('product===>'+productList);
        set<string> emails = new set<string>();
        for(product__c pro : productList){
            if(pro.category_user_email__c!=null){
                emails.add(pro.category_user_email__c);
            } 
        } 
        for(string str :emails){
            PageReference PdfAtt = Page.categorySubmittedProducts;  
            PdfAtt.getParameters().put('email',str);
            Blob b;
            if(Test.IsRunningTest()){
                b = Blob.valueOf('UNIT.TEST');
            }
            else{
                b = PdfAtt.getContent();
            }
            
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('attachment.xls');
            efa.setBody(b);
            
            Messaging.SingleEmailMessage mails = new Messaging.singleEmailMessage();
            mails.setToAddresses(new string[]{str});
            mails.setSubject('Records submitted today');
            mails.setPlainTextBody('Hi, PFA');
            mails.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mails});
        }    
    }
}