@isTest
public class AccountViewOverideController_Test{
    static testMethod void viewButtonTest(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Id recordTypeId1 = [Select Id from RecordType where Name=:'MBA' and SObjectType = 'Account' limit 1].Id;
        
        Account acc = new Account();
        acc.recordTypeId = recordTypeId;
        acc.Name = 'TestAcc';
        acc.Mail_ID__c = 'poornapriya.yn@kvpcorp.com';
        insert acc;
        
        Account acc1 = new Account();
        acc1.recordTypeId = recordTypeId1;
        acc1.Name = 'TestAcc';
        
        insert acc1;
        
         Test.startTest();
        PageReference pageRef = Page.AccountViewOveride; 
        pageRef.getParameters().put('Id', acc.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        AccountViewOverideController accCont = new AccountViewOverideController(sc);
        accCont.redirect();
        
        pageRef.getParameters().put('Id', acc1.Id);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(acc1);
        AccountViewOverideController accCont1 = new AccountViewOverideController(sc1);
        accCont1.redirect();
        Test.stopTest();
    }
}