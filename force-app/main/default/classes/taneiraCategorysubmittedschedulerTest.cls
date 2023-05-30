@isTest
public class taneiraCategorysubmittedschedulerTest {
    
    @isTest static void testGetProduct(){
        Account acc = new Account();
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        acc.RecordTypeId = recordTypeIdAcc;
        insert acc;
        
        Product__c pro1 = new Product__c();
        pro1.Name = 'Brown Saree';
        pro1.Account__c = acc.id;
        pro1.RecordTypeId = recordTypeId;
        pro1.cost__c = 123;
        pro1.Suggested_MRP__c= 123;
        pro1.Quantity__c= 123;
        pro1.Colour__c = 'Red';
        pro1.Workmanship__c = 'Ajrak';
        pro1.Design_Story__c = 'Shikargah';
        pro1.Loom__c ='Handloom';
        pro1.Taneira_Material_Weft__c ='Silk';
        pro1.Material_Wrap__c='Silk';
        pro1.Nature__c ='Handmade pro1duct of India';
        pro1.Occasion__c = 'Wedding';
        pro1.Cluster__c ='Assam';
        pro1.Category_Submitted_Date__c = system.today();
        pro1.Product_Category_Taneira__c ='Saree';
        pro1.Route__c ='Colourway';
        pro1.Zari_Type__c = 'Silk';
        pro1.Proc_Type__c = 'Trading';
        pro1.Cost_Band__c = 'A(0-2)';
        pro1.Special_request__c=true;
        pro1.Comment_for_Special_Request__c = 'test';
        pro1.Sync_Date__c=System.today();
        pro1.Kurta_Fabric__c = 'Silk';
        pro1.Dupatta_Fabric__c = 'silk';
        pro1.Salwar_Fabric__c = 'silk';
        pro1.QR_CODE__c = '123';
        pro1.category_user_email__c = 'deepakhdh@gmail.com';
        insert pro1;
        Product__c pro = new Product__c();
        pro.Name = 'Brown Saree';
        pro.Account__c = acc.id;
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
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Special_request__c=true;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Sync_Date__c=System.today();
        pro.Kurta_Fabric__c = 'Silk';
        pro.Dupatta_Fabric__c = 'silk';
        pro.category_user_email__c = 'deepakhdh@gmail.com';
        pro.Salwar_Fabric__c = 'silk';
        pro.QR_CODE__c = '123';
        pro.Category_Submitted_Date__c = system.today();
        insert pro;
        list<product__c> proList = new list<product__c>();
        prolist.add(pro);
        prolist.add(pro1);
        taneiraCategorysubmittedscheduler aa = new taneiraCategorysubmittedscheduler();
        aa.execute(null);
        CategorySubmittedProductsController aaa = new CategorySubmittedProductsController();
        
        
    }
    @isTest static void TaneiraAttributionPendingEmailSchedulerTest(){
        TaneiraAttributionPendingEmailScheduler test1 = new TaneiraAttributionPendingEmailScheduler();
        test1.execute(null);
        String prodkey;String prodKey1;
        Account acc = new Account();
        acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        insert acc;
        prodKey1=(String.valueOf(System.now()).substring(0,13).trim()+acc.Id+'Saree'+'Banaras'+'Isha Sahu_0').trim();
        prodKey1=prodKey1.replaceAll('\\s+', '');
        prodkey=prodKey1;
        List<Taneira_View__c> prodList = new List<Taneira_View__c>();
        Taneira_View__c obj1= new Taneira_View__c();
        obj1.vendor__c=acc.Id;
        obj1.Custom_Created_Date__c=system.today();
        obj1.Product_Category__c='Saree';
        obj1.Origin__c='Banaras';
        obj1.Account_id__c=acc.Id;
        obj1.Offline_UserName__c='Isha Sahu_0';
        obj1.Total_Quantity__c=5;
        obj1.Total_Value__c=2000;
        obj1.Page_Control__c = 'Attribution';
        obj1.Product_Key_Finder1__c=prodKey;
        obj1.SKU__c=2;
        
        prodList.add(obj1);
 
        
        insert prodList;
        Test.setCreatedDate(prodList[0].Id, system.today() - 6);
        TaneiraAttributionPendingRecordEmail tt =  new TaneiraAttributionPendingRecordEmail();
    }
    
    
    
    
    
}