@isTest
public class PagingSortingControllerTest {
	
    @isTest
    public static void testMethod1() {
        
        List<Product__c> prods = new List<Product__c>();
        Product__c prod = new Product__c();
        prod.Name = 'TEST PROD';
        prods.add(prod);
        insert prods;
        
        List<Product__c> prods1 = PagingSortingController.getProducts();
    }
}