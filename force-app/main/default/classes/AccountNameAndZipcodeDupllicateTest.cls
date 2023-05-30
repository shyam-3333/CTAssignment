@isTest
public class AccountNameAndZipcodeDupllicateTest {
    
    public static testMethod void method1(){
        id recId = ([SELECT Id, Name FROM RecordType where Name = 'Prospect_MBA' limit 1]).id;
        Account acc = new Account();
        acc.RecordTypeId = recId;
        acc.Name = 'Test for deployment';
        acc.Type = 'Prospect';
        acc.BillingPostalCode = '506319';
        acc.Lead_first_contact_date__c = system.Today();
        insert acc;
        Account acc1 = new Account();
        acc1.RecordTypeId = recId;
        acc1.Name = 'Tests fors deployments';
        acc1.Type = 'Prospect';
        acc1.BillingPostalCode = '506319';
        acc1.Lead_first_contact_date__c = system.Today();
        insert acc1;
        Account acc2 = new Account();
        acc2.RecordTypeId = recId;
        acc2.Name = 'Testz';
        acc2.Type = 'Prospect';
        acc2.BillingPostalCode = '506319';
        acc2.Lead_first_contact_date__c = system.Today();
        insert acc2;
        Account acc3 = new Account();
        acc3.RecordTypeId = recId;
        acc3.Name = 'Testy fory';
        acc3.Type = 'Prospect';
        acc3.BillingPostalCode = '506319';
        acc3.Lead_first_contact_date__c = system.Today();
        insert acc3;
        Account acc4 = new Account();
        acc4.RecordTypeId = recId;
        acc4.Name = 'Test for deployment';
        acc4.Type = 'Prospect';
        acc4.BillingPostalCode = '506319';
        acc4.Lead_first_contact_date__c = system.Today();
        database.insert(acc4,false);
    }
    public static testMethod void method2(){
        id recId = ([SELECT Id, Name FROM RecordType where Name = 'Corporate' limit 1]).id;
        Account acc = new Account();
        acc.RecordTypeId = recId;
        acc.Name = 'Test 1';
        acc.Type = 'Prospect';
        acc.BillingPostalCode = '506319';
        acc.Lead_first_contact_date__c = system.Today();
        acc.Account_SAP_Id__c = 'ABC';
        acc.Pan_No__c = 'ABC123';
        acc.GSTN_Number__c = '123';
        acc.Date_of_establishment_of_company__c = system.Today();
        acc.Region_Picklist__c = 'North';
        insert acc;
        Account acc1 = new Account();
        acc1.RecordTypeId = recId;
        acc1.Name = 'Test 2';
        acc1.Type = 'Prospect';
        acc1.BillingPostalCode = '506319';
        acc1.Lead_first_contact_date__c = system.Today();
        acc1.Account_SAP_Id__c = 'ABC';
        acc1.Pan_No__c = 'ABC123';
        acc1.GSTN_Number__c = '123';
        acc1.Date_of_establishment_of_company__c = system.Today();
        acc1.Region_Picklist__c = 'North';
        database.insert(acc1,false);
    }
}