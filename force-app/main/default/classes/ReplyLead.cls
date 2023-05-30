public class ReplyLead{
     private final Task ts{get;set;}
     public EmailMessage email{get;set;}
     public Task tsk{get;set;}
     public string to{get;set;}
     public string cc{get;set;}
     public String bcc{get;set;}
     //public String attachment{get;set;}
     public List<Attachment> attList{get;set;}
     public String subject{get;set;}
     public String body{get;set;}
     public String currentAttId;
     public String currentQuoteId;
     public Boolean toAddpresent;
     public Boolean sendSuccess{get;set;}
     public Quote qt{ get; set; }
     //public User usr{ get; set; }
     public Quote UserEmail;
     public String[] jsonDescriptionData;
     //public String parentId {get;set;}
    // public Attachment attach {get;set;}
    public String filename{get;set;} 
    public transient Attachment attach{get;set;}
    //public String recNo{get;set;}
    //public String attachId{get;set;}
    //public String FName{get;set;}
    Public String fSize{get;set;}
    //Public blob bodypart{get;set;}
    //Public Boolean inLine{get;set;}
    public transient  String fbody{get;set;} 
    public String buttonData{get;set;}
    //public List<AttachmentWrap > attList1{get;set;}
    public ReplyLead(ApexPages.StandardController controller){
        email=new EmailMessage();
        qt= new Quote();
        toAddpresent=false;
        sendSuccess=false;
        attach = new Attachment();
        currentQuoteId=ApexPages.currentPage().getParameters().get('retURl');
        body='Please Find The Following Attachment';
        
        System.debug('button name='+buttonData);
        UserEmail=[select Id,contact.Email,Record_Type_Name__c,RecordType.name,INSTI_Order_Reference__c,Insti_ref__c from Quote where Id=:currentQuoteId limit 1 ];
        String autonum='Indent number-'+UserEmail.Insti_ref__c;    
        System.debug('Email Data='+UserEmail.RecordType.name);
        if(UserEmail.contact.Email !=null || UserEmail.contact.Email!= '')
             
        currentAttId=ApexPages.currentPage().getParameters().get('attid');
        attList=new List<Attachment>();
        attList=[Select id,Name,Body From Attachment WHERE Id=:currentAttId LIMIT 1];
        System.debug('*********************************'+currentAttId);
        System.debug('(((()'+attList[0].name);
        System.debug('Before the If Condition');
        if(attList[0].name=='Indent GV.')
        {
           Map<string,GC_Data__c> mapCodes = GC_Data__c.getAll();  
		   // display the ISO code for Afghanistan
		   String toEmail=mapCodes.get('Gv').Email__c;
            System.debug('my toEmail='+toEmail);
           String ccEmail=mapCodes.get('Gv').CC_Email__c;
            
           subject=autonum;
            
           to =toEmail;
           cc=ccEmail; 
          
        }
        else if(attList[0].name=='Indent GC.')
        {
           Map<string,GC_Data__c> mapCodes = GC_Data__c.getAll();  
		   // display the ISO code for Afghanistan
		   String toEmail=mapCodes.get('Gc').Email__c;
            System.debug('my toEmail='+toEmail);
           String ccEmail=mapCodes.get('Gc').CC_Email__c;
           
            subject=autonum;
            
           to =toEmail;
           cc=ccEmail; 
          
        }
        else
        {
            to =UserEmail.contact.Email;
        }

        this.ts=(Task)controller.getRecord();
        tsk= new Task();
    }
   /* public void replyRec(){
    System.debug('**************replyRec**************');
         qt= new Quote();
    
     }*/
    public PageReference doCancel(){
        return null;
    }
    public void upload()
    {
        //This shows how to insert an Attachment
        attach.ParentId = currentQuoteId;
        insert attach;
        //return new ApexPages.Standardcontroller(attach).view();  
    }
    public void doAttachment(){ 
        try{    
            Attachment at=new Attachment();
            system.debug('filename:'+filename);
            system.debug('fbody:'+fbody);
            system.debug('fSize:'+fSize);
            at.Name=filename;
            at.parentId =currentQuoteId;
            String substring = fbody.substring(0, (fbody.indexOf(',')+1));
            system.debug(substring );
            at.Body =EncodingUtil.base64Decode(fbody.replace(substring ,''));//Blob.valueOf(fbody);           
            // at.inLine=false;
            insert at;
            attList.add(at); 
            if(attList.size()>0){
                insert attList;
            }
        }
        catch(exception r){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Attachment Size Crossed limit');
            ApexPages.addMessage(myMsg);
        }                               
    }
    public List<string> getjsonDescriptionData(){
        try{ 
            jsonDescriptionData = new List<string>();
            List<User> UserList = [select id,Email,Name from User];
            List<Contact> conList=[Select id,Email From Contact];
            if(UserList != null && UserList .size() != 0){
                Set<String > EmailSet= new Set<String>();
                for(User acc : UserList){
                    EmailSet.add(acc.Email);
                }
                for(Contact con : conList){
                    EmailSet.add(con.Email);
                }
                for(String nam : EmailSet){
                    jsonDescriptionData.add('"'+nam+'"');
                }
            }
        }catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,ex.getMessage()));
            return null;
        }
        jsonDescriptionData.sort();
        return jsonDescriptionData;
    }   
    public PageReference sendReply() {
        System.debug('**************sendReply**************');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        //attach.setFileName(attList[0].name + 'pdf');
        // attach.setBody(attList[0].Body);
        system.debug('attList:'+attList);
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : attList){
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();  
            efa.setFileName(a.Name);     
            // a.body = EncodingUtil.base64Decode((a.body.tostring()).replace('data:text/plain;base64',''));
            system.debug(fbody);
            efa.setBody( a.body); 
            fileAttachments.add(efa);
        }    
        if(to != null && to != ''){ 
            email.setToAddresses(to.split(',').size()  > 0 ? to.split(',') : new String[]{to});
            toAddpresent=true;
        }
        if(cc != null && cc != ''){ 
            email.setCcAddresses(cc.split(',').size()  > 0 ? cc.split(',') : new String[]{cc});
        }
        if(bcc != null && bcc != ''){ 
            email.setBccAddresses(bcc.split(',').size()  > 0 ? bcc.split(',') : new String[]{bcc});
        }
        email.setSubject( subject );
        email.setHtmlBody( body );
   
        email.setFileAttachments(fileAttachments);
        // email.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
        if(toAddpresent){            
          
                Messaging.SendEmailResult [] results =Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Email Send Successfully'));
                sendSuccess=true;
            
            
               User objUser =[select Email from user where id =: UserInfo.getUserId()];
                    String strUserEmail = objUser.Email;
                    Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
                    email1.setToAddresses(new String[] { strUserEmail  });
                    email1.setSubject('Email Received');
                    email1.setPlainTextBody('Email Received By Recepient');
                    List<Messaging.SendEmailResult> results1 = 
                    Messaging.sendEmail(new Messaging.Email[] { email1 });
                    body = body.replaceAll('<[^>]+>',' ');
                    String strComment = 'To :'+to+'\n\n'+'Cc :'+cc+'\n\n'+'Bcc :'+bcc+'\n\n'+'Subject :'+subject+'\n\n'+'Body'+body ;
                    // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Email Deliverd successfully'));
                    Task objTask = new Task(OwnerId = objUser.Id,Subject ='Send Quote',Status ='Completed',Priority ='Normal',ActivityDate =system.today(),Description = strComment ,whatId =userEmail.id,Titan_Subject__c =subject  );
                    insert objTask;
            
            
                return null;
             
            }
                
        
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'To Address is mandatory to send email,Please Enter To address')); 
            return null;
        } 
    }
    public PageReference redirectQuotePage(){
        System.debug('**************redirectQuotePage**************');
        PageReference pageRef=new PageReference('/'+currentQuoteId);
        pageRef.setRedirect(true);
        return pageRef;
    }
   
}