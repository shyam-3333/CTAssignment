@istest
public class VendorCreatePage_Test {
	static testMethod void TestVendorCreateMthd(){
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        list<vendor__c> accountList = new List<vendor__c>();
        vendor__c acc = new vendor__c();
        acc.Name = 'TestAcc';
        //acc.RecordTypeId = recordTypeIdAcc;
        acc.Phone_No__c = '12345';
        accountList.add(acc);
        
        vendor__c acc1 = new vendor__c();
        acc1.Name = 'TestAcc1';
        //acc1.RecordTypeId = recordTypeIdAcc;
        acc1.Phone_No__c = '12345';
        accountList.add(acc1);
        
        if(accountList.size()>0){
            insert accountList;
        }
        PageReference pageRef = Page.VendorCreatePage;
        //pageRef.getParameters().put('RecordType', recordTypeIdAcc);
        pageRef.getParameters().put('id', acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        VendorCreatePageController venCon = new VendorCreatePageController(sc );
        venCon.doSaveNew();
        venCon.doSave();
        venCon.doCancel();
        
        PageReference pageRef1 = Page.VendorCreatePage;
        //pageRef1.getParameters().put('RecordType', recordTypeIdAcc);
        pageRef1.getParameters().put('id', null);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(acc1);
        VendorCreatePageController venCon1 = new VendorCreatePageController(sc1 );
        venCon1.doSaveNew();
        venCon1.doSave();
        venCon1.doCancel();
        
        
        
    }
}