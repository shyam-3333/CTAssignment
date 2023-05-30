@isTest
public class TestRTW_Product_Delete {
    
    public static testMethod void method1(){
        
        List<RTW_Product__c> rtwProdLists = new List<RTW_Product__c>();
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', season__c='FW19',collection__c='Core wear',
                                            Warp__c='Cotton123',Weft__c='Cotton123',SKU_Count__c=10));
        rtwProdLists.add(new RTW_Product__c(Name='BLOUSE',Product__c='BLOUSE', season__c='FW19',collection__c='Core wear',
                                            Warp__c='Cotton123',Weft__c='Cotton123',SKU_Count__c=10));
        insert rtwProdLists;
        delete rtwProdLists[0];
     
    }
}