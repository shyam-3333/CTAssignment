/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestduplicateRecords {

    static testMethod void myUnitTest() {
        Account acc=new Account();
            acc.Name='Sample';
        insert acc;
        Contract_Details__c cd=new Contract_Details__c(Customer__c=acc.Id,Brand__c='Titan',Product_Sub_Category__c='Watches',Value_From__c=1000,Value_To__c=100000,Valid_From__c=System.today(),Valid_To__c=System.today()+5,Discount__c=15);
        insert cd;
            cd.Product_Sub_Category__c='Watches';
        update cd;
    }
    static testMethod void myUnitTest2() {
        Account acc=new Account();
            acc.Name='Sample';
        insert acc;
        Contract_Details__c cd=new Contract_Details__c(Customer__c=acc.Id,Brand__c='Titan',Product_Sub_Category__c='Watches',Value_From__c=1000,Value_To__c=100000,Valid_From__c=System.today(),Valid_To__c=System.today()+5,Discount__c=15);
        insert cd;
            cd.Product_Sub_Category__c='Watches';
        update cd;
        Contract_Details__c cd2=new Contract_Details__c(Customer__c=acc.Id,Brand__c='Sonata',Product_Sub_Category__c='Watches',Value_From__c=1000,Value_To__c=100000,Valid_From__c=System.today(),Valid_To__c=System.today()+5,Discount__c=15);
        insert cd2;
            cd2.Value_From__c=1500;
            cd2.Brand__c='Fastrack';
        update cd2;
            cd2.Product_Sub_Category__c='';
        try{
            update cd2;
        }
        catch(DMLException e){
            System.debug('Sub category cannot be blank');
        }      
    }
    static testMethod void myUnitTest3() {
        Account acc=new Account();
            acc.Name='Sample';
        insert acc;
        Contract_Details__c cd=new Contract_Details__c(Customer__c=acc.Id,Brand__c='Titan',Product_Sub_Category__c='',Value_From__c=1000,Value_To__c=100000,Valid_From__c=System.today(),Valid_To__c=System.today()+5,Discount__c=15);
        try{
            insert cd;
        }
        catch(DMLException e){
            System.debug('Sub category blank');
        }    
            cd.Product_Sub_Category__c='Watches';
        try{
            update cd;
        }
        catch(DMLException e){
            System.debug('Sub category cannot be blank');
        }       
        Contract_Details__c cd2=new Contract_Details__c(Customer__c=acc.Id,Brand__c='Sonata',Product_Sub_Category__c='Watches',Value_From__c=1000,Value_To__c=100000,Valid_From__c=System.today(),Valid_To__c=System.today()+5,Discount__c=15);
        try{
            insert cd2;
        }
        catch(DMLException e){
            System.debug('Sub category blank');
        }         
            cd2.Value_From__c=1500;
            cd2.Brand__c='Fastrack';
        try{
            update cd2;
        }
        catch(DMLException e){
            System.debug('Sub category blank');
        }  
            cd2.Product_Sub_Category__c='';
        try{
            update cd2;
        }
        catch(DMLException e){
            System.debug('Sub category cannot be blank');
        }
        
    }
}