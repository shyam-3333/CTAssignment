@isTest
public class AccountNewOverride_Test{
    static testMethod void newButtonTest(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Id recordTypeId1 = [Select Id from RecordType where Name=:'MBA' and SObjectType = 'Account' limit 1].Id;
        Account acc = new Account();
        acc.recordTypeId = recordTypeId;
        
        Account acc1 = new Account();
        acc1.recordTypeId = recordTypeId1;
        
        Test.startTest();
        PageReference pageRef = Page.AccountNewButtonOverride ; 
        pageRef.getParameters().put('RecordType', acc.recordTypeId);
        //pageRef.getParameters().put('Source', 'New');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        AccountNewOverride accCont = new AccountNewOverride(sc);
        accCont.redirect();
        pageRef.getParameters().put('RecordType', acc1.recordTypeId);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(acc1);
        AccountNewOverride accCont1 = new AccountNewOverride(sc1);
        accCont1.redirect();
        Test.stopTest();
    }
    static testMethod void newButtonTest1(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Id recordTypeId1 = [Select Id from RecordType where Name=:'MBA' and SObjectType = 'Account' limit 1].Id;
        Account acc = new Account();
        acc.recordTypeId = recordTypeId;
        
        Test.startTest();
        PageReference pageRef = Page.AccountNewButtonOverride ; 
        pageRef.getParameters().put('RecordType', null);
        //pageRef.getParameters().put('Source', 'New');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        AccountNewOverride accCont = new AccountNewOverride(sc);
        accCont.redirect();
        
        Test.stopTest();
    }
   
}