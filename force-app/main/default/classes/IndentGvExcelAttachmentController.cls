global without sharing class IndentGvExcelAttachmentController {
    
    ApexPages.StandardController standardPageController{get;set;}
    public String recdId;
    public Quote qc {get;set;}
    public Opportunity opp {get;set;}
    public List<QuoteLineItem> qliList {get;set;}
    public User us {get;set;}
    public Payment_Tracker__c ptList;
    public static List<Payment_Tracker__c> paymentList {get;set;}
    public static String requesterName {get;set;}
    public static String oppOwnerName {get;set;}
    public static String paymentTrackerName {get;set;}
    public static Id payId {get;set;}
    public static String oppName;
    
    public IndentGvExcelAttachmentController(ApexPages.StandardController standardPageController){
        this.standardPageController=standardPageController;
         
    }
    
   
    
    public void fetchingDataForExcel(){
        recdId =ApexPages.CurrentPage().getparameters().get('paymentId');
        //recdId = '0Q07c000000MwRqCAK';
        qc=[SELECT id,Opportunity.Owner.City,Recipient_Email_ID__c,OwnerId,OpportunityId,Account.Account_Oracle_ID_cbg__c FROM Quote WHERE Id =: recdId LIMIT 1];
        String oppId=qc.OpportunityId;
        String ownId=qc.OwnerId;
        qliList = new List<QuoteLineItem>();
        qliList = [SELECT id,Product2.Name,Sales_Price_c__c,Quantity,TotalPrice FROM QuoteLineItem WHERE QuoteId =: recdId];
        opp = [SELECT id,PO_No__c FROM Opportunity WHERE id=:oppId LIMIT 1];
        us= [SELECT id,UserRole.Name FROM User WHERE id=:ownId];
    }
    @future(callout=true)
    public static void attachPDFFromQuote(String quoteId,String paymentTracker,List<String> approvalId,String workItemId, String status) {
 		//requesterName='Anish';
   		//oppOwnerName='Adarsh';
   		
        payId=paymentTracker;
        paymentList = [SELECT id,Name,Opportunity__r.Record_Type_Name__c,Recipient_Bank__c,Opportunity__r.Account.Name,Approval_Status__c,RTGS_Created_Date__c,Payment_Mode__c,Courier_Name__c,Opportunity__r.Owner.Name,Payment_Type__c,Cheque_Date__c,Bank_Name__c,RTGS_No_UTR_3__c,Cheque_No__c,RTGS_No_UTR_2__c,Amount_Recieved__c,RTGS_No__c,Location_of_The_Bank__c,Initial_Email__c FROM Payment_Tracker__c WHERE Id =:paymentTracker];
        system.debug('PAyment Lst =======>'+paymentList);
        system.debug('PAyment Lst =======>'+paymentList[0].opportunity__r.Owner.Name);
        paymentTrackerName = paymentList[0].Name;
        List<Quote> quoteList=[SELECT id, Name,Opportunity_name__c,INSTI_Order_Reference__c, Insti_ref__c, opportunity_owner_name__c,Discount_on_Product__c,Price_After_Discount__c,Account.Account_Oracle_ID_cbg__c FROM Quote WHERE Id =:quoteId];
        oppOwnerName = quoteList[0].opportunity_owner_name__c;
        oppName=quoteList[0].Opportunity_name__c;
        system.debug('oppOwnerName =======>'+oppOwnerName);
        List<User> userList = [SELECT id, UserRole.Name, Name, Payment_tracker_L1approver_userName__c FROM User WHERE Name =:OppOwnerName];
        requesterName=userList[0].Payment_tracker_L1approver_userName__c;
        system.debug('requesterName =======>'+requesterName);
        System.debug('quoteId ======>>>>>>'+ quoteId);
        System.debug('paymentTracker ======>>>>>>'+ paymentTracker);
        System.debug('approvalId ======>>>>>>'+ approvalId);
        String[] ccAddresses = new String[] {'sfdcadmin@titan.co.in'};
        pageReference pagepdf1 = page.IndentGvExcelAttachmentPage;
        pagepdf1.getParameters().put('paymentId',quoteId);
        Blob body1;
        body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST1') : pagepdf1.getContent();
        //EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Email Notification to L1 Approver'];
        
        /*pageReference pagepdf2 = page.IndentEmailBodyPage;
        pagepdf2.getParameters().put('paymentId',paymentTracker);
        Blob body2;
        body2 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST2') : pagepdf2.getContent();
        String htmlBody = body2.toString();*/
        String table;
        //String approveURL='https://titanlightningapps--npdskdev.sandbox.my.salesforce.com/p/process/ProcessInstanceWorkitemWizardStageManager?id='+workItemId;
       // if(userList[0].UserRole.Name == 'Corp Sale - SO East' ||userList[0].UserRole.Name == 'Corp Sale - SO North' || userList[0].UserRole.Name == 'Corp Sale - SO South' || userList[0].UserRole.Name == 'Corp Sale - SO West' ){
        //String approveURL='https://titanlightningapps--npdskdev.sandbox.lightning.force.com/lightning/r/Payment_Tracker__c/'+paymentList[0].id+'/view';
		String approveURL = URL.getSalesforceBaseUrl().toExternalForm()+'/'+paymentList[0].id;
        if( approvalId.size()==1){
           
          table = 'Hi '+requesterName+',';
           
        }
        else{
          table = 'Hi Team,'; 
        }
        table+='<br/><br/> '+oppOwnerName+' has requested your approval of the payment tracker record associated with the opportunity '+oppName+'.<br/><br/> <style> .table, .th, .td {border: 1px solid #dddddd;text-align: left;padding: 8px;}</style> <table style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Payment Tracker Number</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Name+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Location of Bank</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Location_of_The_Bank__c+'</td></tr>';
       // table += '<tr><td>' + paymentList[0].Name + '</td><td>' + paymentList[0].Location_of_The_Bank__c + '</td></tr>';
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>RTGS No(UTR1)</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].RTGS_No__c+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Amount Recieved</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Amount_Recieved__c+'</td></tr>';
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>RTGS No(UTR2)</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].RTGS_No_UTR_2__c+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Cheque No</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Cheque_No__c+'</td></tr>';
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>RTGS No(UTR3)</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].RTGS_No_UTR_3__c+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Bank Name</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Bank_Name__c+'</td></tr>';
        if(paymentList[0].Cheque_Date__c !=null){
                table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Cheque Date</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Cheque_Date__c.day()+ '-'+paymentList[0].Cheque_Date__c.month()+ '-' + paymentList[0].Cheque_Date__c.year()+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Payment type</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Payment_Type__c+'</td></tr>';
		}
        else{
               table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Cheque Date</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+'null'+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Payment type</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Payment_Type__c+'</td></tr>';
   		}
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Courier Name</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Courier_Name__c+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Payment Mode</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Payment_Mode__c+'</td></tr>';
        
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Price After Discount</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+quoteList[0].Price_After_Discount__c+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Discount of Product</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+quoteList[0].Discount_on_Product__c+'</td></tr>';
        
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Account Name</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Opportunity__r.Account.Name+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Indent Number</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+quoteList[0].INSTI_Order_Reference__c+'</td></tr>';
        table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Recipient Bank</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Recipient_Bank__c+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Opportunity Record Type</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].Opportunity__r.Record_Type_Name__c+'</td></tr>';
        if(paymentList[0].RTGS_Created_Date__c!=null){
                table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>RTGS Created Date</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+paymentList[0].RTGS_Created_Date__c.day()+ '-'+paymentList[0].RTGS_Created_Date__c.month()+ '-' + paymentList[0].RTGS_Created_Date__c.year()+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Account Oracle Id</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+quoteList[0].Account.Account_Oracle_ID_cbg__c+'</td></tr>';
		}
        else{
               table+='<tr style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>RTGS Created Date</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+'null'+'</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;"><b>Account Oracle ID</b></td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">'+quoteList[0].Account.Account_Oracle_ID_cbg__c+'</td></tr>';
   		}
        table += '</table>';
        //table+='<br/><br/>  <p>To approve or reject this item, click this link</p>'+'<apex:outputlink value="{!LEFT($Api.Partner_Server_URL_140,FIND('+'.com'+',$Api.Partner_Server_URL_140)+4)+payId}">'+payId+'</apex:outputlink>';
        table+='<br/><br/>  <p>To approve or reject this item, click this link</p>'+'<a href="'+approveURL+'"> "Click On Link" </a>';

        table+='<br/><br/> <p>and review the related Payment Tracker.</p>';
        table+='<br/>Thanks, <br/>Titan Sales Team';
        String emailIds='';
       // List<String> strEmailList=new List<String>();
        for(User uss: [SELECT id,name,email FROM User WHERE id =:approvalId ]){
            emailIds+=uss.Email + ',';
            //strEmailList.add(uss.Email);
            
        }
         System.debug('EmailIds are ==>'+emailIds);  
        //String addresses='anish.s@kvpcorp.com,satish.g@kvpcorp.com';
        //System.debug('paymentList[0].Initial_Email__c===> '+paymentList[0].Initial_Email__c);
        //System.debug('initialValue==> '+initialValue);
        
        if((paymentList[0].Approval_Status__c == 'Pending' && status!=paymentList[0].Approval_Status__c)||(paymentList[0].Approval_Status__c == 'L2 Pending' && status!=paymentList[0].Approval_Status__c)){
            //paymentList[0].Initial_Email__c = false;
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            list<Messaging.EmailFileAttachment> msgAttachments = new list<Messaging.EmailFileAttachment>();
            csvAttc.setFileName('Indent_GV.pdf');
            csvAttc.setBody(body1);
            msgAttachments.add(csvAttc);
            string csvname= 'Account.xls';
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            //String[] toAddresses = new list<string> {'anish.s@kvpcorp.com'};
            //String subject ='Account CSV';
            email.setSubject(' Approval Request for :'+quoteList[0].Insti_ref__c+'-'+paymentTrackerName);
            //email.setplaintextbody();
            email.setHtmlBody(table); 
            email.setSenderDisplayName(paymentList[0].opportunity__r.Owner.Name);
            // email.setHtmlBody(body2);
            email.setWhatId(paymentTracker);
            // email.setTargetObjectId(strEmailList); 
            email.setToAddresses(emailIds.split(','));
            //email.setToAddresses('');
            //email.setBccAddress('sfdcadmin@titan.co.in');
            //email.setTargetObjectId('sfdcadmin@titan.co.in');
            email.setCcAddresses(ccAddresses);
            email.setSaveAsActivity(false);
            
            
            //email.setSubject(subject);
            //email.setToAddresses( toAddresses );
            //email.setPlainTextBody('Account CSV ');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            
        }
    }
    
    
    
    
    
   
    
    
}