/****
 Created By : Shweta kumari
 Description : controller for category selection page. Used to redirect to difffrent page based on selected category  
*****/
public class ProductCategorySelect {
    transient public String[] autoCompleteList;
    List<Master__c> categoryList;
    string accId;  // modified by Poorna
    string productSource;
    private final Product__c prod;
    
    public ProductCategorySelect(ApexPages.StandardController controller){
        categoryList= new List<Master__c>();
        accId = ApexPages.currentPage().getParameters().get('AccontId');
        productSource = ApexPages.currentPage().getParameters().get('Source');
        this.prod = (Product__c)controller.getRecord();
    }
    //method to get list of product category
    public list<string> getautoCompleteList(){
        autoCompleteList = new List<string>();
        categoryList = [Select Id, Name,Name__c FROM Master__c WHERE Active__c=TRUE and Name__c = 'Product Category'];
        for (Master__c mRec : categoryList){
            autoCompleteList.add('"'+mRec.name+'"');            
        }
        return autoCompleteList;
    }
    //code to redirect to difffrent page based on selected category
    public pagereference RedirectToPage(){
        string url           =  '';
        if(prod.Product_Category_Taneira__c =='Saree'){
            url='/apex/ProductPageSaree?source=New&AccontId='+accId+'&Category=Saree';  
        }
        else{
           url='/apex/Product_Page_Coming_Soon?AccontId='+accId; 
        }
        PageReference pr = new PageReference(url);
        pr.setredirect(true);
        return pr;    
    }
    //method for cancel
     public pageReference doCancel(){
         PageReference pr;
         //code if product is created from account page
         if(accId != '' && accId != 'null' && accId != null)
            pr = new PageReference('/'+accId);
          //code if product is created from product tab
         else
            pr = new PageReference('/a18/o');
         pr.setRedirect(true);
         return pr;        
    }
}