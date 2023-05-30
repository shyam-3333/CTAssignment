/**
 * @description       : To attach all the reports according to the ranges in a single mail
 * @author            : Ajay
 * @last modified on  : 03-23-2021
 
**/
global class DeviationReportEmail Implements Schedulable  
{
    global void execute(SchedulableContext sc)
    {
       senddeviationmail();
        
    } 
   @future(callout=true)
   global static void senddeviationmail() {
      list<product__c> dataList = new list<product__c>();
       
        datetime startDateTime = datetime.now().addHours(-200);  //200
        datetime endDateTime = datetime.now().addHours(-32); //32
       system.Debug('----------starttime---------'+startDateTime);
       system.Debug('--------endtime-----------'+endDateTime);
AggregateResult[] ar=[SELECT count(id) cnt, sum(Suggested_MRP__c) sm, sum(Deviation__c) dev, sum(Actual_MRP__c) amrp, sum(Suggested_Multiplier__c) mul,sum(Actual_Multiplier__c)amul,sum(	Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime];
AggregateResult[] ar1=[SELECT count(id) cnt,sum(Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime and Multiplier_Deviation__c >20];
AggregateResult[] ar2=[SELECT count(id) cnt,sum(Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime and Multiplier_Deviation__c >=10 and Multiplier_Deviation__c <=20 ];
AggregateResult[] ar3=[SELECT count(id) cnt,sum(Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime and Multiplier_Deviation__c >=0 and Multiplier_Deviation__c <=10 ];
AggregateResult[] ar4=[SELECT count(id) cnt,sum(Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime and Multiplier_Deviation__c >=-20 and Multiplier_Deviation__c <=-10 ];
AggregateResult[] ar5=[SELECT count(id) cnt,sum(Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime and Multiplier_Deviation__c >-10 and Multiplier_Deviation__c <0 ];
AggregateResult[] ar6=[SELECT count(id) cnt,sum(Multiplier_Deviation__c)devp from product__c where pricing_date__c >=: startDateTime and pricing_date__c <: endDateTime and Multiplier_Deviation__c <-20 ];
                                                                                                
       
      // AggregateResult[]  ar=[SELECT count(id), name, sum(Cost__c) sm, sum(Suggested_MRP__c) mr, sum(Multiplier_Deviation__c) md, sum(Deviation__c) dev, sum(Actual_MRP__c) amrp, sum(Multiplier__c) mul FROM product__c where Multiplier_Deviation__c != null group by name];
        //  List<string> emailList = new List<string>();        
      //  emailList.addAll(Label.Deviation_report_email_address.split(','));
      
        String instanceName = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId=';
string url1=instanceName+'00O5Y00000DN54OUAT';
string url2=instanceName+'00O5Y00000DN54TUAT';
string url3=instanceName+'00O5Y00000DN54YUAT';
string url4=instanceName+'00O5Y00000DN54dUAD';
string url5=instanceName+'00O5Y00000DN54nUAD';
string url6=instanceName+'00O5Y00000DN54iUAD';       
       
       ApexPages.PageReference report = new ApexPages.PageReference(url1);
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('>20%_Deviation_Report.csv');
         Blob b1;
            if(!Test.isRunningTest()){
                b1 = report.getContent();
            }
            else{
                b1 = Blob.valueOf('Test Blob Content');
            }
        attachment.setBody(b1);
        attachment.setContentType('text/csv');
        ApexPages.PageReference report1 = new ApexPages.PageReference(url2);
        Messaging.EmailFileAttachment attachment1 = new Messaging.EmailFileAttachment();
        attachment1.setFileName('10-20%_Deviation_Report.csv');
        Blob b2;
            if(!Test.isRunningTest()){
                b2 = report1.getContent();
            }
            else{
                b2 = Blob.valueOf('Test Blob Content');
            }
        attachment1.setBody(b2);
        attachment1.setContentType('text/csv');
        ApexPages.PageReference report2 = new ApexPages.PageReference(url3);
        Messaging.EmailFileAttachment attachment2 = new Messaging.EmailFileAttachment();
        attachment2.setFileName('0-10%_Deviation_Report.csv');
         Blob b3;
            if(!Test.isRunningTest()){
                b3 = report2.getContent();
            }
            else{
                b3 = Blob.valueOf('Test Blob Content');
            }
        attachment2.setBody(b3);
        
        attachment2.setContentType('text/csv');
        ApexPages.PageReference report3 = new ApexPages.PageReference(url4);
        Messaging.EmailFileAttachment attachment3 = new Messaging.EmailFileAttachment();
        attachment3.setFileName('-10 to -20%_Deviation_Report.csv');
         Blob b4;
            if(!Test.isRunningTest()){
                b4 = report3.getContent();
            }
            else{
                b4 = Blob.valueOf('Test Blob Content');
            }
        attachment3.setBody(b4);
       
        attachment3.setContentType('text/csv');
        ApexPages.PageReference report4 = new ApexPages.PageReference(url5);
        Messaging.EmailFileAttachment attachment4 = new Messaging.EmailFileAttachment();
        attachment4.setFileName('>-20%_Deviation_Report.csv');
         Blob b5;
            if(!Test.isRunningTest()){
                b5 = report4.getContent();
            }
            else{
                b5 = Blob.valueOf('Test Blob Content');
            }
        attachment4.setBody(b5);
       
        attachment4.setContentType('text/csv');
       ApexPages.PageReference report5 = new ApexPages.PageReference(url6);
        Messaging.EmailFileAttachment attachment5 = new Messaging.EmailFileAttachment();
        attachment5.setFileName('0 to-10%_Deviation_Report.csv');
         Blob b6;
            if(!Test.isRunningTest()){
                b6 = report5.getContent();
            }
            else{
                b6 = Blob.valueOf('Test Blob Content');
            }
        attachment5.setBody(b6);
       
        attachment5.setContentType('text/csv');
       
        
       
       
       
      /* String instanceName = URL.getSalesforceBaseUrl().toExternalForm();
string url=instanceName+'/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId='+reportId;
ApexPages.PageReference objPage = new ApexPages.PageReference(url);
       */
       
       
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment,attachment1,attachment2,attachment3,attachment4,attachment5} );
        message.setSubject('Deviation  Weekly Report with multiplier % Ranges');
       /* message.setPlainTextBody('The report is attached'  +                 
                                 'SUMMARY OF Last Week <br> TOTAL COST ='  +ar[0].get('sm')  +                
                                 'TOTAL MULTIPLIER DEVIATION'+ar[0].get('md'));*/
         
        message.setHtmlBody('<html><body>The reports are attached below<br> <br>SUMMARY OF LAST WEEK:<BR> TOTAL Records ='+ar[0].get('cnt')  +'<br>TOTAL MRP = '+ar[0].get('sm')+'<br>TOTAL Actual MRP = '+ar[0].get('amrp')  +'<br>TOTAL Deviation = '+ar[0].get('dev')+'<br>TOTAL Suggested Multiplier = '+ar[0].get('mul')+'<br>TOTAL Actual Multiplier = '+ar[0].get('amul')+'<br>TOTAL  Multiplier Deviation = '+ar[0].get('devp')+'<br><br>Number of Spec items 0-10% = '+ar3[0].get('cnt')+'<br>Number of Spec items 10-20% = '+ar2[0].get('cnt')+'<br>Number of Spec items greater than 20% = '+ar1[0].get('cnt')+'<br>Number of Spec items 0 to -10% = '+ar5[0].get('cnt')+'<br>Number of Spec items -10 to -20% = '+ar4[0].get('cnt')+'<br>Number of Spec items less than -20% = '+ar6[0].get('cnt')+'<br></body></html>');   
        message.setToAddresses(new String[] {'ambujnarayan@titan.co.in','akash@titan.co.in','shalinig@titan.co.in','aanchalp@titan.co.in','kamalkc@titan.co.in','deepakbaid@titan.co.in','medha@titan.co.in','harishk2@titan.co.in','nikhilupadyaya@titan.co.in','rengasamyb@titan.co.in','amritakshad@titan.co.in'});
      // message.setToAddresses(new String[] {'ajaypavana.k@kvpcorp.com'});
      // system.Debug('-------------------email recipeints'+emailList);
        message.setCcAddresses(new String[] { 'sfdcadmin@titan.co.in','ajaypavana.k@kvpcorp.com'});
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        
    }
}