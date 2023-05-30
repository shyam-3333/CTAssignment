public class GenerateIndentQueue implements Queueable, Database.AllowsCallouts {
    Set<String> quoteIds = new Set<String>();
    Set<String> paymentTrackerIds = new Set<String>();
    //List<Payment_Tracker__c> payList =new List<Payment_Tracker__c>();
    String status;
    
    public GenerateIndentQueue(Set<String> quoteIds, Set<String> paymentTrackerIds, String status) {
        this.quoteIds = quoteIds;
        this.paymentTrackerIds = paymentTrackerIds;
        //this.payList = payList;
        this.status = status;
        System.debug('quoteIds====>'+quoteIds);
        System.debug('paymentTrackerIds====>'+paymentTrackerIds);
        System.debug('status====>'+status);
        
    }
    public void execute(QueueableContext context) {
        GetApprovalDetails.ApprovalResponse appovalResponse = GetApprovalDetails.recordTypeSetting(paymentTrackerIds);
        String approvalStatus = appovalResponse.approvalStatus;
     
        System.debug('approvalStatus'+approvalStatus);
        System.debug('appovalResponse.originalActorId ==>'+appovalResponse.originalActorId);
        //Boolean initialValue=payList[0].Initial_Email__c;
       
        if(approvalStatus == 'Approved'){
            for(String quoteId : quoteIds){
                attachWordpdf(quoteId,'indentGV');
                
            }
        }else{
            try{
                
                List<Quote> quoteToApprove = new List<Quote>();
                for(Quote qDetails : [select id,OpportunityId,Product_for_Approval__c,Indent_Created__c,Product_Catagory__c,Approval_Status_Quote__c,INSTI_Order_Reference__c,Insti_ref__c,Indent_Button_Clicked__c from Quote where Id = : quoteIds AND Indent_Button_Clicked__c=true LIMIT 1]){
                    System.debug('qDetails--->'+qDetails);
                    qDetails.Payment_tracker_approval_status__c = approvalStatus;
                    for(String paymentTrackerId : paymentTrackerIds){
                        if(appovalResponse.originalActorId != null){
                            IndentGvExcelAttachmentController.attachPDFFromQuote(qDetails.Id,paymentTrackerId,appovalResponse.originalActorId,appovalResponse.workItemId,status);
                        }
                    }
                    quoteToApprove.add(qDetails);
                } 
                update quoteToApprove;
            }catch(Exception exp){
                System.debug('exp'+exp.getLineNumber());
                System.debug('exp'+exp.getMessage());
            }
            
            
        }
        
        
    }
    
    public static void attachWordpdf(String Ids, string butt){
        Attachment at = new Attachment ();
        QuoteDocument  qd = new QuoteDocument ();
        List<QuoteLineItem> qt = new List <QuoteLineItem>();
        List<Quote_Items__c> qtitm = new List<Quote_Items__c>();
        Quote q;
        String[] ccAddresses = new String[] {'sfdcadmin@titan.co.in'};
        List<String> ccemaillist = new List<String>();
        Payment_Tracker__c pt;
        System.debug('-----Ids------->'+Ids + butt);
        try{
            q = [select id,OpportunityId,Product_for_Approval__c,Indent_Created__c,Product_Catagory__c,Approval_Status_Quote__c,INSTI_Order_Reference__c,Insti_ref__c,owner.email from Quote where Id = : Ids];
            
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
                    EmailsendAttach= Attach.emailAlertMethod(Ids);
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    
                    Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
                    efa1.setFileName('Indent.xls');
                    efa1.setBody(EmailsendAttach);
                    EmailsendAttach1 = Attach.emailAlertMethodPdf(ids);
                    
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
                    
                    //String addresses='hulakanteppa.h@kvpcorp.com,ashokn@titan.co.in';
                   // String addresses='anish.s@kvpcorp.com,vyshnavi@titan.co.in,sharu.j@kvpcorp.com';
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
                    
                    email.setToAddresses(Label.IndentGVEmail.split(','));
                   // email.setToAddresses(addresses.split(','));
                    //email.setCcAddresses(ccAddresses);
                    system.debug('CCEmailMap.get(usrEmail):'+CCEmailMap.get(usrEmail));
                    if(CCEmailMap.get(usrEmail) != null){
                        ccemaillist.add(CCEmailMap.get(usrEmail));//this is fetched from custom setting to send mail w.r.t user's region
                    }
                    ccemaillist.add('sfdcadmin@titan.co.in');
                    ccemaillist.add(q.owner.email);
                     email.setCcAddresses(ccemaillist);
                    system.debug('cc email list'+ccemaillist);
                    email.setPlainTextBody('Hi ,\n\nPlease find attachment of Indent');
                    //email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
                    email.setFileAttachments(msgAttachments);
                    
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                    
                    q.Payment_tracker_approval_status__c = 'Approved';
                    system.debug('---------------EmailsendAttach-----------'+EmailsendAttach);
                }
               
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
               List<String> str = new List<string>();
            str.addAll(system.label.IndentCreatedDate.split(','));
            if(q.id != null && str.contains(q.Product_for_Approval__c)){
                q.Indent_Created__c = True;
                q.Indent_Created_Date__c = System.Today();
                update q;
            }
        }
        
        
    }
    
}