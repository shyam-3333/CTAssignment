public class ProductImageCtrl {
     
    public String imageId {get; set;}
         
    public ProductImageCtrl(){
        imageId    =    apexpages.currentPage().getParameters().get('Id');
      system.debug('------------------imageId------------------'+imageId);  
        
    }
    
     public String getimageDisplay() {
        String fileId = '';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:imageId limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
        }
        return fileId;    
    }
    
   /* public  void  getImage() {
                
           //List<Attachment> attachedFiles = [select Id from Attachment];
            list<Product__c> prodImage=[SELECT id,Photo__c FROM Product__c];
            System.debug('----prodImage-->>'+prodImage);
          
    }    */  
  /*  public void getimageDisplay(){
         // query from Product only photo field using the Id. get the substring
         Product__c prodImage=[SELECT id,Photo__c FROM Product__c  WHERE id =: imageId ];
         System.debug('----prodImage-->>'+prodImage);   
    }*/
}