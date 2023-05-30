@isTest
public class ProductApprovalEmailForSapTeam_Test{   
     static testMethod void TestProduct(){
           string image ='test';
           Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
           //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
           List<vendor__c>accList = new List<vendor__c>();
            
            vendor__c acc = new vendor__c();
            acc.Name = 'TestAcc';
            //acc.RecordTypeId = recordTypeIdAcc;
            acc.Phone_No__c = '12345';
            acc.Approval_Date__c = Date.today();
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
            acc2.Approval_Date__c = Date.today();
             accList.add(acc2);
             
            if(accList.size()>0){
                insert accList;
            }
            
            Product__c pro = new Product__c();
            pro.Name = 'Test';
            pro.vendor_custom__c = acc.id;
            pro.Approval_Date__c = Date.today().addDays(-1);
            pro.RecordTypeId = recordTypeId;
            pro.cost__c = 123;
            pro.Suggested_MRP__c= 123;
            pro.Quantity__c= 123;
            pro.Colour__c = 'Red';
            pro.Workmanship__c = 'Ajrak';
            pro.Design_Story__c = 'Shikargah';
            pro.Loom__c ='Handloom';
            pro.Taneira_Material_Weft__c ='Silk';
            pro.Material_Wrap__c='Silk';
            pro.Nature__c ='Handmade product of India';
            pro.Occasion__c = 'Wedding';
            pro.Cluster__c ='Assam';
            pro.Product_Category_Taneira__c ='Saree';
            pro.Route__c ='Colourway';
            pro.Zari_Type__c = 'Silk';
            
            insert pro;
            
            Test.StartTest(); 
            ProductApprovalEmailForSapTeam lcr = new ProductApprovalEmailForSapTeam();                  
            lcr.execute(null);
            Test.StopTest();
        }
}