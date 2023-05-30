@isTest

private class ProductTest{

    static testMethod void ProductTestMethod() {
        
        Product2 p = new Product2();
        p.Name = 'Test 123';
        p.Material_Cost_Piece__c =100;
        p.Value_ADD_Piece__c = 100;
        insert p;
        
        Product2 p1 = new Product2(ID = p.ID);
        p1.Value_ADD_Piece__c = 200;
        p1.Material_Cost_Piece__c = 200;
        Update p1; 
    }
}