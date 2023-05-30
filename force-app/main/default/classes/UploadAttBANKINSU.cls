public class UploadAttBANKINSU
{

Account tp;
public Id recId{get;set;}
public string fileName{get;set;}
public Blob fileBody{get;set;} 
public String currentQuoteId;
Attachment myAttachment;
Public List<Attachment> AttmentList{get;set;}
Public List<Attachment> AttmentList1{get;set;}
 
  public UploadAttBANKINSU(ApexPages.StandardController ctlr){
         currentQuoteId = ctlr.getId();
         displayAtt();
        tp=new Account();
     }   
    
     public void save(){
         system.debug('-----fileBody----'+fileBody);
         system.debug('-----fileName----'+fileName);
         currentQuoteId=ApexPages.currentPage().getParameters().get('id');
         System.debug('@@@@@@@filename' + fileName);
        if(!(fileName == Null || fileName == '')){
         myAttachment = new Attachment(ParentId =currentQuoteId);
         myAttachment.Body = fileBody;
         myAttachment.Name = fileName;
         }       
        if(fileName == NULL ||  fileBody == Null){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please upload a document.');
            ApexPages.addMessage(myMsg); 
        }
        else{
                insert myAttachment;
                fileName = null;
        }
        displayAtt();
     }
     
     public void displayAtt(){
       AttmentList=[select id,name,OwnerId,LastModifiedDate from Attachment where ParentId =: currentQuoteId and (name LIKE '%Bank Guarantee%' or Name like '%Indemnity bond%' or Name like '%Insurance%')];
        AttmentList1=[select id,name,OwnerId,LastModifiedDate from Attachment where ParentId =: currentQuoteId and (name LIKE '%LTA%' or Name like '%MOU%' or Name like '%NDA%')];
       
        
     }
 }