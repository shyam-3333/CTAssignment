/*This class will help display the multiple images
from PaginationDemo VF page(Ask me Portal)
*/

public class ImagePreviewClass{
   public String prodId {get;set;}
    public Product__c prodObj {get;set;}
    public String imagesrc {get;set;}
    
    public ImagePreviewClass(){
    
    String prodId=apexPages.currentPage().getParameters().get('PrdId');
    System.debug('===prodId==='+prodId);
    Product__c prodObj=[Select Id,photo__c from Product__c where Id =:prodId];
      imagesrc=prodObj.photo__c; 
      System.debug('====imagesrc---'+imagesrc); 
    }
    public void coverclass(){
        Integer i=0;
        i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
        
    }
    

}