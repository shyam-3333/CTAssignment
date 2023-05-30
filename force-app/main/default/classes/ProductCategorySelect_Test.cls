@isTest
public class ProductCategorySelect_Test{
    static testMethod void selectCategoryTest(){
        list<Master__c> masterList = new List<Master__c>();
        Master__c mas = new Master__c();
        mas.Name= 'Saree';
        mas.Name__c ='Product Category';
        mas.Active__c  = True ;
        mas.Code__c ='S';
        masterList.add(mas);
        
        Master__c mas1 = new Master__c();
        mas1.Name= 'Stole';
        mas1.Name__c ='Product Category';
        mas1.Active__c  = True ;
        mas1.Code__c ='ST';
        masterList.add(mas1);
        
        Master__c mas2 = new Master__c();
        mas2.Name= 'Dupatta';
        mas2.Name__c ='Product Category';
        mas2.Active__c  = True ;
        mas2.Code__c ='DU';
        masterList.add(mas2); 
        
        insert masterList;
        
        Product__c prod = new Product__c();
        prod.Product_Category_Taneira__c = 'Saree';
        
        PageReference pageRef = Page.ProductCategorySelectPage; 
        pageRef.getParameters().put('Source', 'New');
       // pageRef.getParameters().put('AccontId', acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(prod);
        ProductCategorySelect prodCont = new ProductCategorySelect(sc );
        prodCont.getautoCompleteList();
        prodCont.RedirectToPage();
        prodCont.doCancel();
        
    }
}