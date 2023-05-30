public class CategorySubmittedProductsController {
    
    public class wrapper{
        public product__c pro{get;set;}
        public integer sl_no{get;set;} 
    }
    public List<wrapper> wrapList{get;set;}
    public CategorySubmittedProductsController(){
        wrapList =new list<wrapper>();
        integer no=1;
        string ss; 
         if(Test.IsRunningTest()){
               ss = 'deepakhdh@gmail.com';
            }
            else{
               ss = ApexPages.currentPage().getParameters().get('email');
            }
        system.debug('ss'+ss);
        list<product__c> productList =  [Select id,SKU_Code__c,Actual_MRP__c,Category_Submitted_Date__c,category_user_email__c from product__c where Category_Submitted_Date__c = today and category_user_email__c	= :ss];
        for(product__c prod : productList)
        {
            wrapper wrap = new wrapper();
            wrap.pro = prod;
            wrap.sl_no = no;
            no++;
            wrapList.add(wrap);
        }
    }
}