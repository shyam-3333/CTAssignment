@istest(seeAlldata=true)
private class TestProductDuplicatechecking{
    Static Testmethod void ProductDuplicatecheckingmethod(){
        list<Product__c> testproducts=TestForAskme.productRecord(3);
        insert testproducts;
        try{
        insert TestForAskme.productRecord(3);
        }catch(Exception excp){}
        
        
    }
}