Public class NotesAttachmentModelController{
    public List<Attachment> attachmentList{set;get;}
    public List<Quote> allQuote{get;set;}
    public List<AttachmentModel> modelList{get;set;}
    public Integer srNo{get;set;}
    public Blob fileBody{get;set;}
   public String currentQuoteId{get;set;}
    public String fileName;
    public Integer fileSize;
    Quote qu;
     
    public NotesAttachmentModelController(ApexPages.StandardController sc){
        qu = (Quote)sc.getRecord();
        currentQuoteId=qu.Id;
        allQuote = [SELECT id,name,Email,ContactID,Manager_s_Email__c from Quote where id=:qu.id and ContactId != null];
        attachmentList = [SELECT id,name,ContentType,OwnerId,Owner.Name,ParentId,Parent.Name from Attachment
                           where ParentId =: qu.id ];
        //system.debug('#################### value in Attachment List'+attachmentList);
        srNo=0;
        integer  i =0;
        modelList = new List<AttachmentModel>();
        for(Attachment att : attachmentList){
            AttachmentModel am = new AttachmentModel();
            am.srno = ++i;
            am.att = att;
            modelList.add(am);
           // return modelList;
        }
    }
  
    public class AttachmentModel{
        public Integer srNo{get;set;}
        public Attachment att{get;set;}
        public AttachmentModel(){
            srNo = 0;
            att = new Attachment();
             
        }
    }
  
   Id AccId = ApexPages.CurrentPage().getParameters().get('Id');
    
   public PageReference attachfile() {

        PageReference quotePage = new PageReference ('/p/attach/NoteAttach?'+accid);
        quotePage.setRedirect(true);  
        return quotePage; 
        }
    public PageReference createNote(){
        PageReference quoteNotePage = new PageReference ('/002/e?'+accid);
        quoteNotePage.setRedirect(true);
        return quoteNotePage;
    } 
    public PageReference viewAll(){
        PageReference quoteViewAll = new PageReference ('/ui/content/ViewAllNotesPage?'+accid);
        quoteViewAll.setRedirect(true);
        return quoteViewAll;
    } 
   public pagereference showpage(){
       PageReference sp = New PageReference('/apex/sendatt');
       sp.setRedirect(true);
return sp;
}
   public pagereference sendEmail(){
       id modId=apexpages.currentpage().getparameters().get('Attch');
       Attachment att =[SELECT id, name, body, contenttype from Attachment where id=:modId];
      
      Blob b = att.body;
        
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setFileName(att.name + 'pdf');
    
    attach.setBody(b);
 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { allQuote[0].Email });
    // mail.setCCAddresses(new String[] { allQuote[0].Manager_s_Email__c});
    mail.setSubject('Requested Document');
    mail.setHtmlBody('Please find attachemt of requested document: '+att.name);
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
 
    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
 
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Document sent to : '+  allQuote[0].Email));
 
        
        
        //pagereference pr = new pagereference('/'+qu.Id);
        return null;
       
   } 
   
}