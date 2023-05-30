@isTest
public class VendorEmailAttachmentPageController_Test{   
     static testMethod void TestVendor(){
           string image ='test';
           Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
           //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
           List<vendor__c>accList = new List<vendor__c>();
            
            vendor__c acc = new vendor__c();
            acc.Name = 'TestAcc';
            //acc.RecordTypeId = recordTypeIdAcc;
            acc.Phone_No__c = '12345';
            acc.Approval_Date__c = Date.today().addDays(-1);
            accList.add(acc);
            
            vendor__c acc1 = new vendor__c();
            acc1.Name = 'TestAcc1';
            //acc1.RecordTypeId = recordTypeIdAcc;
            acc1.Phone_No__c = '12345';
            acc1.Approval_Date__c = Date.today().addDays(-1);
            accList.add(acc1);
            
            vendor__c acc2 = new vendor__c();
            acc2.Name = 'TestAcc2';
            //acc2.RecordTypeId = recordTypeIdAcc;
            acc2.Phone_No__c = '12345';
            acc2.Approval_Date__c = Date.today().addDays(-1);
             accList.add(acc2);
             
            if(accList.size()>0){
                insert accList;
            }
            
            Test.startTest();
            VendorEmailAttachmentPageController vend = new VendorEmailAttachmentPageController();
            Test.stopTest();
        }
    }