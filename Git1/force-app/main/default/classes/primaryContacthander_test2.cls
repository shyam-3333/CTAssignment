@istest
public class primaryContacthander_test2 {

    @testsetup
    
    public static void testData(){
        Account acc= new Account();
        acc.name='TestAccount';
        
        insert acc;
        
        Contact con1= new Contact();
        con1.AccountID=acc.ID;
        con1.lastname='Kohali';
        con1.firstname='Virat';
        con1.Primary_Contact__c=true;
        
        insert con1;
        
        Contact con2= new Contact();
        con2.AccountID=acc.ID;
        con2.lastname='Sharma';
        con2.firstname='Rohit';
        con2.Primary_Contact__c=false;
        
        insert con2;
    }
}