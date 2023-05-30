global with sharing class Attach{
    public static Id passQuoteId;
    public static Id passPaymentId;
    public Attach() {
        
    }
    
    QuoteDocument  qd = new QuoteDocument ();
    //Mohit
    public static Blob emailAlertMethod(String QuodeId){
        system.debug('QuodeId:'+QuodeId);
        pageReference pagepdf1 = page.QuoteLI_Page;
        pagepdf1.getParameters().put('id',QuodeId);
        Blob body1;
        body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST1') : pagepdf1.getContent();
        // Blob ob;
        Attachment at = new Attachment ();
        at.name='Test1.xls';
        at.Body=body1;
        at.ContentType ='.xls';
        at.IsPrivate = false;
        at.ParentId = QuodeId;
        insert at;
        return body1;
    }
    public static Blob emailAlertMethodPdf(String QuodeId){
        pageReference pagepdf1 = page.Indent_GV;
        pagepdf1.getParameters().put('id',QuodeId);
        Blob body1;
        body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST1') : pagepdf1.getContent();
        // Blob ob;
        Attachment at = new Attachment ();
        at.name='Test1.pdf';
        at.Body=body1;
        at.ContentType ='.pdf';
        at.IsPrivate = false;
        at.ParentId = QuodeId;
        insert at;
        return body1;
    }
   /* @InvocableMethod
    public static void callingAttachWordpdf(List<Id> Ids){
        Id quoteId=Ids[0];
        GeneratingIndentOnQuote.attachWordpdf((String)quoteId,'indentGV');
    }*/
    
    
    @AuraEnabled 
    webservice static void attachWordpdf(String Ids, string butt){
        
        Attachment at = new Attachment ();
        QuoteDocument  qd = new QuoteDocument ();
        List<QuoteLineItem> qt = new List <QuoteLineItem>();
        List<Quote_Items__c> qtitm = new List<Quote_Items__c>();
        Quote q;
        Payment_Tracker__c pt;
        System.debug('-----Ids------->'+Ids + butt);
        try{
            q = [select id,OpportunityId,Product_for_Approval__c,Indent_Created__c,Product_Catagory__c,Approval_Status_Quote__c,INSTI_Order_Reference__c,Insti_ref__c from Quote where Id = : Ids];
            
            qt=[Select quoteId,Quote.Id,Quote.Name,PriceBookEntry.Product2.Name from Quotelineitem Where QuoteId =:ids Order by CreatedDate limit 1];
            system.debug('&&&&&&&&&&&&&&&&&&&&&'+ q.Id);
            qtitm=[Select Quote__c from Quote_Items__c Where Quote__c =: q.Id Limit 1];
            pt = [Select Id,name,Opportunity__c from Payment_Tracker__c where Opportunity__c =: q.OpportunityId order by CreatedDate desc Limit 1];
            System.debug('payment name'+ pt.name);
            
        }
        
        catch(exception ex){
            
            system.debug('66666666666666666666'+ex);
            
        }
        
        
        if(qt.size() > 0){
            
            if(butt == 'indentGV')
            {
                system.debug('Button clicked:'+butt);
                string usrEmail = UserInfo.getUserEmail();
                system.debug('User email: '+usrEmail);
                Map<string, string> CCEmailMap = new Map<string, string>();
                for(Indent_CC_Email__c cs: [SELECT Id, Name,CC_Email__c FROM Indent_CC_Email__c]){
                    CCEmailMap.put(cs.Name,cs.CC_Email__c);
                }
                system.debug('CCEmailMap:'+CCEmailMap);
                if(((q.Product_Catagory__c == 'Gift card(QC)' || q.Product_Catagory__c == 'EGift card(QC)') && (q.Approval_Status_Quote__c == 'Approved')) || Test.isRunningTest()){
                    //Mohit
                    blob EmailsendAttach;
                    blob EmailsendAttach1;
                    EmailsendAttach= emailAlertMethod(Ids);
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    
                    Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
                    efa1.setFileName('Indent.xls');
                    efa1.setBody(EmailsendAttach);
                    EmailsendAttach1 = emailAlertMethodPdf(ids);
                    
                    list<Messaging.EmailFileAttachment> msgAttachments = new list<Messaging.EmailFileAttachment>();
                    msgAttachments.add(efa1);
                    if(q.Product_for_Approval__c != 'Gift card/eGift card(QC)'){
                        Messaging.EmailFileAttachment efa2 = new Messaging.EmailFileAttachment();
                        efa2.setFileName('Indent_GV.pdf');
                        efa2.setBody(EmailsendAttach1);
                        msgAttachments.add(efa2); 
                    }else{
                        pageReference pagepdf1 = page.Indent_GV2;
                        pagepdf1.getParameters().put('id',Ids);
                        Blob body1;
                        body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST1') : pagepdf1.getContent();
                        Messaging.EmailFileAttachment efa2 = new Messaging.EmailFileAttachment();
                        efa2.setFileName('Indent_GV.pdf');
                        efa2.setBody(body1);
                        msgAttachments.add(efa2);
                    }
                    
                   // String addresses='hulakanteppa.h@kvpcorp.com,ashokn@titan.co.in';
                    String addresses='satyam.r@kvpcorp.com,sfdcadmin@titan.co.in';
                    //List<String> emailList=new List<String>();
                    //emailList.add('vinoth.kumar@kvpcorp.com');
                    //emailList.add('rahul.mukherji@kvpcorp.com');
                    //emailList.add('ashokn@titan.co.in');
                    if(q.Product_Catagory__c == 'Gift card(QC)'){
                        email.setSubject( 'Phy-Indent GV attachment files - '+q.Insti_ref__c +'-'+pt.name);
                    }
                    else {
                        email.setSubject( 'Indent GV attachment files - '+q.Insti_ref__c +'-'+ pt.name);
                    }
                    
                    //email.setToAddresses(Label.IndentGVEmail.split(','));
                    email.setToAddresses(addresses.split(','));
                    system.debug('CCEmailMap.get(usrEmail):'+CCEmailMap.get(usrEmail));
                    if(CCEmailMap.get(usrEmail) != null){
                      //  email.setCcAddresses(new string[]{CCEmailMap.get(usrEmail)});
                    }
                    email.setPlainTextBody('Hi,\n Please find attachments of Indent');
                    //email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
                    email.setFileAttachments(msgAttachments);
                    
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                    
                    
                    system.debug('---------------EmailsendAttach-----------'+EmailsendAttach);
                }
                /*  PageReference pagepdf3 = page.Indent_GV;
pagepdf3.getParameters().put('id',Ids);

Transient Blob Document4;
Document4 = !Test.isRunningTest() ? pagepdf3.getContent() : Blob.ValueOf('dummy text');
qd.Document = Document4;
qd.QuoteId = qt.Quote.id;
insert qd; 
*/      
                pageReference pagepdf1 = page.Indent_GV;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Indent GV.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at; 
                system.debug('ATTTTTTTTTTTTTTTTTTTTT:' +at);
            }
            if(butt == 'Indent')
            {
                /*  pageReference pagepdf2 = page.Indent_Jewellery;
pagepdf2.getParameters().put('id',Ids);
Transient Blob Document3;
Document3 = !Test.isRunningTest() ? pagepdf2.getContent() : Blob.ValueOf('dummy text');
qd.Document = Document3;
qd.QuoteId = qt.Quote.id; 
System.debug('-----Indent Ids------->'+qd.QuoteId);
insert qd; 
*/  
                system.debug('In LC');
                pageReference pagepdf1 = page.Indent_Jewellery;
                
                pagepdf1.getParameters().put('id',Ids);
                
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Indent.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at;
                
            }
            if(butt == 'ProformaInvoice')
            {
                /*  pageReference pagepdf1 = page.Proforma_Jewellery;
pagepdf1.getParameters().put('id',Ids);
Transient Blob Document2;
Document2 = !Test.isRunningTest() ? pagepdf1.getContent() : Blob.ValueOf('dummy text');
qd.Document = Document2;
qd.QuoteId = qt.Quote.Id ;
insert qd; 
*/  
                pageReference pagepdf1 = page.Proforma_Jewellery;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Proforma Invoice.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at;
                
            }
            
            if(butt == 'ProformaGV')
            {
                /*  PageReference pagepdf = Page.Proforma_Gold_Voucher;
pagepdf.getParameters().put('id',Ids);
Transient Blob Document1;
Document1 = !Test.isRunningTest() ? pagepdf.getContent() : Blob.ValueOf('dummy text'); 
qd.Document = Document1;
qd.QuoteId = qt.Quote.id;
insert qd; 
*/    
                pageReference pagepdf1 = page.Proforma_Gold_Voucher;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Proforma GV.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at;
                
            }
            if(butt == 'Proformawatches'){
                /*    PageReference pagepdf = Page.Proforma_Watches;
pagepdf.getParameters().put('id',Ids);
Transient Blob Document5;
Document5 = !Test.isRunningTest() ? pagepdf.getContent() : Blob.ValueOf('dummy text'); 
qd.Document = Document5;
qd.QuoteId = qt.Quote.id;
insert qd; 
*/ 
                pageReference pagepdf1 = page.ProformaInvoiceWatches;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Proforma Invoice.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at;
                
            }
            
            if(butt == 'Indentwatches'){
                /*    PageReference pagepdf = Page.Indent_Watches;
pagepdf.getParameters().put('id',Ids);
Transient Blob Document6;
Document6 = !Test.isRunningTest() ? pagepdf.getContent() : Blob.ValueOf('dummy text'); 
qd.Document = Document6;
qd.QuoteId = qt.Quote.id;
insert qd;
*/   
                
                pageReference pagepdf1 = page.Indent_Watches;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Indent.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at;
                
                
            }
            
            if(butt == 'IndentGC'){
                /*  PageReference pagepdf = Page.Indent_Watches;
pagepdf.getParameters().put('id',Ids);
Transient Blob Document6;
Document6 = !Test.isRunningTest() ? pagepdf.getContent() : Blob.ValueOf('dummy text'); 
qd.Document = Document6;
qd.QuoteId = qt.Quote.id;
insert qd; 
*/ 
                pageReference pagepdf1 = page.Indent_Watches;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Indent GC.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qt[0].Quote.Id ;
                insert at;
                
            }
            List<String> str = new List<string>();
            str.addAll(system.label.IndentCreatedDate.split(','));
            //if(q.id != null && (q.Product_for_Approval__c == 'GV/GC Valid on Gold Coin' || q.Product_for_Approval__c =='GV/GC Not Valid on Gold Coin' || q.Product_for_Approval__c == 'GV/GC Valid on Jewellery Only' || q.Product_for_Approval__c == 'Gold Voucher' || q.Product_for_Approval__c == 'Silver Voucher')){
            if(q.id != null && str.contains(q.Product_for_Approval__c)){
                q.Indent_Created__c = True;
                q.Indent_Created_Date__c = System.Today();
                update q;
            }   
            
        }
        
        if(qtitm.size() > 0){
            system.debug('%%%%%%%%%' + qtitm[0].Quote__c);
            if(butt == 'QuotePECSA')
            {
                /*  pageReference pagepdf1 = page.Quote_PECSA;
pagepdf1.getParameters().put('id',Ids);
Transient Blob Document2;
Document2 = !Test.isRunningTest() ? pagepdf1.getContent() : Blob.ValueOf('dummy text');
qd.Document = Document2;
qd.QuoteId = qt.Quote.Id ;
insert qd; 
*/  
                pageReference pagepdf1 = page.Quote_PECSA;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Quote T&C.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qtitm[0].Quote__c ;
                
                insert at;
                
            }
            
            
            if(butt == 'NewButtonforQuotePricing')
            {
                /*  pageReference pagepdf1 = page.New_Test_Page;
pagepdf1.getParameters().put('id',Ids);
Transient Blob Document2;
Document2 = !Test.isRunningTest() ? pagepdf1.getContent() : Blob.ValueOf('dummy text');
qd.Document = Document2;
qd.QuoteId = qt.Quote.Id ;
insert qd; 
*/  
                pageReference pagepdf1 = page.New_Test_Page;
                pagepdf1.getParameters().put('id',Ids);
                Blob body1;
                
                body1 = Test.IsRunningTest() ? Blob.valueOf('UNIT.TEST') : pagepdf1.getContent();
                at.Body = body1;
                // add the user entered name
                at.Name = 'Quote Pricing.';
                at.IsPrivate = false;
                // attach the pdf to the account
                at.ParentId = qtitm[0].Quote__c ;
                insert at;   
            }   
        }        
    }	
    @AuraEnabled
    Public static string checkValidation(string qId){
        system.debug('quoteId==>'+qId);
        passQuoteId=qId;
        list<string>productlist = new list<string>();
        list<string>productapprovallist = new list<string>();
        if(qId != null){
            List<Quote> q = [Select Id,Approval_Status_Quote__c,Price_After_Discount__c,Indent_Submitted_Date__c,Payment_tracker_approval_status__c from Quote where Id = :qId and Product_Catagory__c IN('Titan' , 'EGift card(QC)','Sonata','Branded Watches','Clock & GC','Gold Voucher','Gold Plain','Gold Studded','Gold Coins','Solitaires','Plain Jew. with Stones','Gold Plain - UCP Jewellery','Studded - Solitaire','Studded - Color Stones','CZ,Silver','Silver Coins','Platinum','FQ Bags','Diamantine','Studded High Value','Gold Studded UCP','Open Polki Stones','Kundan Polki Stones','MIA Plain','MIA Studded','MIA Plain Thali','FQ','Col+CZ','Gift Voucher',	'Fastrack','Gift Card','e-Gift Card','Gift card(QC)','Titan UNI Gift Card')  and Product_for_Approval__c IN ('Watches / Accessories','Watches Gift Card','Watches Gift Voucher','Jewellery Gold Coins Only','Jewellery Silver Coins Only','Jewellery Products All','GV/GC Valid on Gold Coin','GV/GC Not Valid on Gold Coin','GV/GC Valid on Diamond Studded','Gold Voucher','Silver Voucher','Gift card/eGift card(QC)') limit 1];            
            System.debug('Quote hello '+q);
            if(!q.isEmpty()){
                
                Id oppId = [Select Id,OpportunityId from quote where Id = :qId limit 1].OpportunityId;
                List<Payment_Tracker__c> ptList = [Select Id,Amount_Recieved__c,Opportunity__c from Payment_Tracker__c where Opportunity__c =: oppId ORDER BY CreatedDate DESC LIMIT 1];
                if(ptList.size() == 0){
                    return 'No Payment Tracker';
                }
                else if(ptList.size() > 0){
                    //Updating Indent Submitter date field - Anish
                    passPaymentId=ptList[0].Id;
                    System.debug('I am called');
                    System.debug('q[0].Approval_Status_Quote__c'+q[0].Approval_Status_Quote__c);
                    System.debug('q====>'+q[0]);
                    if(q[0].Approval_Status_Quote__c == 'Approved'){
                        
                        List<Quote> qcList=new List<Quote>();
                       // Quote qcVal= [SELECT id,Approval_Status_Quote__c,Indent_Submitted_Date__c FROM Quote WHERE id=:qId LIMIT 1];
                       
                        if(ptList[0].Amount_Recieved__c<q[0].Price_After_Discount__c){
                            return 'Amount recieved in payment tracker must be greater or equal than price after discount in quote';
                        }
                        
                        
                        if(q[0].Approval_Status_Quote__c == 'Approved' && q[0].Indent_Submitted_Date__c == null){
                            System.debug('Anish'+q[0].Approval_Status_Quote__c);
                            Quote qc=new Quote();
                            qc.Id=q[0].Id;
                            qc.Payment_tracker_approval_status__c = 'Pending';
                            qc.Indent_Submitted_Date__c=System.today();
                            qc.Indent_Button_Clicked__c=true;
                           //System.debug('Hello'+qc.Indent_Created_Date__c);
                            qcList.add(qc);
                        if(!qcList.isEmpty()){
                            update qcList;
                            //IndentGvExcelAttachmentController.attachPDF(passQuoteId,passPaymentId);
                            return 'Approval process is started on payment tracker';
                        }
                        }
                        else if(q[0].Payment_tracker_approval_status__c == 'Pending'){
                            return 'Approval is Pending';
                        }
                       /* else if(q[0].Payment_tracker_approval_status__c == 'L1 approval is rejected' || q[0].Payment_tracker_approval_status__c == 'L2 approval is rejected'){
                            return 'Approval is Rejected';
                        }*/
                        else if(q[0].Payment_tracker_approval_status__c == 'Approved'){
                            return 'L2 approval is approved';
                        }
                        if(q[0].Approval_Status_Quote__c == 'Approved' && q[0].Indent_Submitted_Date__c != null && q[0].Payment_tracker_approval_status__c == 'Rejected'){
                            System.debug('Anish'+q[0].Approval_Status_Quote__c);
                            Quote qc=new Quote();
                            qc.Id=q[0].Id;
                            qc.Payment_tracker_approval_status__c = 'Pending';
                            qc.Indent_Submitted_Date__c=System.today();
                           //System.debug('Hello'+qc.Indent_Created_Date__c);
                            qcList.add(qc);
                        if(!qcList.isEmpty()){
                            update qcList;
                            //IndentGvExcelAttachmentController.attachPDF(passQuoteId,passPaymentId);
                            return 'Approval process is started on payment tracker';
                        }
                        }
                    }
                    
                    else{
                   // System.debug('@@@@@'+(string)q[0].Approval_Status_Quote__c);
                    return (string)q[0].Approval_Status_Quote__c;
                    }
                }
                
            }
            else if(q.isEmpty()){
                quote q2 = [Select Id,Approval_Status_Quote__c from quote where Id = :qId limit 1];
                return (string)q2.Approval_Status_Quote__c;
            }
            //Updating Indent Submitter date field - Anish
            /*  List<Quote> qcList=new List<Quote>();
Quote qcVal= [SELECT id,Approval_Status_Quote__c,Indent_Submitted_Date__c FROM Quote WHERE id=:qId LIMIT 1];
if(qcVal.Approval_Status_Quote__c == 'Approved' && qcVal.Indent_Submitted_Date__c == null){
Quote qc=new Quote();
qc.Id=qcVal.Id;
qc.Payment_tracker_approval_status__c = 'L1 approval is pending';
qc.Indent_Created_Date__c=System.today();
qcList.add(qc);
}
if(!qcList.isEmpty()){
update qcList;
return 'Approval process is started on payment tracker';
}*/
        }
        return null;
        
    }
}