@istest(seeAlldata=true)
private class TestvariantDuplicatechecking{
    Static Testmethod void ProductDuplicatecheckingmethod(){
        list<Product__c> testproducts=TestForAskme.productRecord(3);
        insert testproducts;
        list<Variant__c> testvariant=TestForAskme.variantRecord(testproducts,2);
        insert testvariant;
        try{
        insert TestForAskme.variantRecord(testproducts,2);
        }catch(Exception excp){}
        
        
    }
}