@isTest
public class ProductPageSaree_Test{
    @testSetup static void methodName() {
 TriggerExecutionController__c tt1 = new TriggerExecutionController__c();
        tt1.Name = 'ProductSuggestedMRPHelper';
        tt1.TriggerIsActive__c = false;
        insert tt1;
        TriggerExecutionController__c tt2 = new TriggerExecutionController__c();
        tt2.Name = 'QRcodeAPI';
        tt2.TriggerIsActive__c = false;
        insert tt2;
}
    static testMethod void TestProduct(){
        TriggerExecutionController__c obj= new TriggerExecutionController__c();
        obj.Name='ProdDuplicateCheck';
        obj.TriggerIsActive__c=true;
        insert obj;
        string image ='test';
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        list<Master__c> masterList = new List<Master__c>();
        list<vendor__c> accountList = new List<vendor__c>();
        list<Attachment> attachmentList = new List<Attachment>();
        list<Product__c> productList = new List<Product__c>();
       // AutoNumber__c auto = AutoNumber__c.getall().values();
        Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition1;
        Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Base Colour';
        mas.Active__c  = True ;
        mas.Code__c ='R';
        masterList.add(mas);
        
        Master__c mas1 = new Master__c();
        mas1.Name= 'Ajrak';
        mas1.Name__c ='Craft'; // workmanship
        mas1.Active__c  = True ;
        mas1.Code__c ='AJ';
        masterList.add(mas1);
        
        Master__c mas2 = new Master__c();
        mas2.Name= 'Shikargah';
        mas2.Name__c ='Design Story';
        mas2.Active__c  = True ;
        mas2.Code__c ='SK';
        masterList.add(mas2);
        
        Master__c mas3 = new Master__c();
        mas3.Name= 'Handloom';
        mas3.Name__c ='Loom';
        mas3.Active__c  = True ;
        mas3.Code__c ='H';
        masterList.add(mas3);
        
        Master__c mas4 = new Master__c();
        mas4.Name= 'Silk';
        mas4.Name__c ='Warp';
        mas4.Active__c  = True ;
        mas4.Code__c ='Sl';
        masterList.add(mas4);
        
        Master__c mas5 = new Master__c();
        mas5.Name= 'Silk';
        mas5.Name__c ='Weft';
        mas5.Active__c  = True ;
        mas5.Code__c ='SI';
        masterList.add(mas5);
        
        Master__c mas6 = new Master__c();
        mas6.Name= 'Handmade product of India';
        mas6.Name__c ='Nature';
        mas6.Active__c  = True ;
        mas6.Code__c ='HP';
        masterList.add(mas6);
        
        Master__c mas7 = new Master__c();
        mas7.Name= 'Wedding';
        mas7.Name__c ='Occasion';
        mas7.Active__c  = True ;
        mas7.Code__c ='W';
        masterList.add(mas7);
        
        Master__c mas8 = new Master__c();
        mas8.Name= 'Assam';
        mas8.Name__c ='Origin';
        mas8.Active__c  = True ;
        mas8.Code__c ='AS';
        masterList.add(mas8);
        
        Master__c mas9 = new Master__c();
        mas9.Name= 'Saree';
        mas9.Name__c ='Product Category';
        mas9.Active__c  = True ;
        mas9.Code__c ='S';
        masterList.add(mas9);
        
        Master__c mas10 = new Master__c();
        mas10.Name= 'Colourway';
        mas10.Name__c ='Route';
        mas10.Active__c = True ;
        mas10.Code__c ='CW';
        masterList.add(mas10);
        
        Master__c mas11 = new Master__c();
        mas11.Name= 'Silk';
        mas11.Name__c ='Zari Type';
        mas11.Active__c = True ;
        mas11.Code__c ='ZT';
        masterList.add(mas11);
        
        Master__c mas12 = new Master__c();
        mas12.Name= 'Trading';
        mas12.Name__c ='Proc-Type';
        mas12.Active__c = True ;
        mas12.Code__c ='T';
        masterList.add(mas12);
        
        if(masterList.size()>0){
            insert masterList;
        }
        
        AutoNumber__c autoNum = new AutoNumber__c(); 
        autoNum.Name ='SHT';//Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;
        
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        
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
        Product__c pro = new Product__c();
        pro.Name = 'Test';
        pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Base_Colour__c = 'Red';
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
        pro.proc_Type__c = 'Trading';
        productList.add(pro);
        
        Product__c pro1 = new Product__c();
        pro1.Name = 'Test1';
        pro1.vendor_custom__c = acc.id;
        pro1.RecordTypeId = recordTypeId;
        pro1.cost__c = 1231;
        pro1.Suggested_MRP__c= 1231;
        pro1.Quantity__c= 123;
        pro1.Base_Colour__c = 'Red';
        pro1.Workmanship__c = 'Ajrak';
        pro1.Design_Story__c = 'Shikargah';
        pro1.Loom__c ='Handloom';
        pro1.Taneira_Material_Weft__c ='Silk';
        pro1.Material_Wrap__c='Silk';
        pro1.Nature__c ='Handmade product of India';
        pro1.Occasion__c = 'Wedding';
        pro1.Cluster__c ='Assam';
        pro1.Product_Category_Taneira__c ='Saree';
        pro1.Route__c ='Colourway';
        pro1.Zari_Type__c = 'Silk';
        pro1.proc_Type__c = 'Trading';
        productList.add(pro1);
        
        Product__c pro2 = new Product__c();
        pro2.Name = 'Test12';
        pro2.vendor_custom__c = acc1.id;
        pro2.RecordTypeId = recordTypeId;
        pro2.cost__c = 1231;
        pro2.Suggested_MRP__c= 1231;
        pro2.Quantity__c= 123;
        pro2.Colour__c = 'Red';
        pro2.Workmanship__c = 'Ajrak';
        pro2.Design_Story__c = 'Shikargah';
        pro2.Loom__c ='Handloom';
        pro2.Taneira_Material_Weft__c ='Silk';
        pro2.Material_Wrap__c='Silk';
        pro2.Nature__c ='Handmade product of India';
        pro2.Occasion__c = 'Wedding';
        pro2.Cluster__c ='Assam';
        pro2.Product_Category_Taneira__c ='Saree';
        pro2.Route__c ='Colourway';
        pro2.Zari_Type__c = 'Silk';
        pro2.proc_Type__c = 'Trading';
        productList.add(pro2);
        system.debug('pro==='+pro);
        if(productList.size()>0){
            insert productList;
        }
        Attachment attach = new Attachment();
        attach.Name = 'TestAttach2.png'; 
        attach.body =  blob.valueOf('Test1');         
        attach.OwnerId = UserInfo.getUserId();
        attach.ParentId = pro.id; 
        attach.IsPrivate = false;
        attachmentList.add(attach);
        
        if(attachmentList.size()>0){
            //insert attachmentList;
        }
        
        system.debug('attach==='+attach);
        Test.StartTest(); 
        
        PageReference pageRef = Page.ProductPageSaree; 
        pageRef.getParameters().put('Source', 'New');
        pageRef.getParameters().put('AccountId', null);
        Test.setCurrentPage(pageRef);
        for(Product__c prod : productList){
             ApexPages.StandardController sc = new ApexPages.StandardController(prod);
            Product_PageController prodCont = new Product_PageController(sc );
            
            prodCont.image = blob.valueOf('Test');
            
            prodCont.attachimage = attach;
            prodCont.assignValueForFields(prod.Id);
            prodCont.doClone();
            prodCont.dosave();
            
           // prodCont.dosave();
            prodCont.saveProd();
            prodCont.doCancel();
        }
        map<id,product__c> mapOfProduct = new map<id,product__c>();
        for(Product__c proo1 :productList){
            mapOfProduct.put(proo1.id, proo1);
        }
        map<id,vendor__c> mapOfVendor = new map<id,vendor__c>();
        for(vendor__c pr0o2 :accountList){
            mapOfVendor.put(pr0o2.id, pr0o2);
        }
        map<string,string> mapOfString = new map<string,string>();
        mapOfString.put('ABCD','ABCD');
        mapOfString.put('XYZ','XYZ');
        ProductTriggerHandler.generateProductDescription(mapOfProduct,mapOfVendor,mapOfString);
        ProductInsertEmailAttachment p1 = new ProductInsertEmailAttachment();
        
        Test.StopTest();
        
        
    } 
    static testMethod void TestProduct1(){
        string image ='test';
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
       // Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        list<Master__c> masterList = new List<Master__c>();
        list<vendor__c> accountList = new List<vendor__c>();
        list<Attachment> attachmentList = new List<Attachment>();
        list<Product__c> productList = new List<Product__c>();
        
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Base Colour';
        mas.Active__c  = True ;
        mas.Code__c ='R';
        masterList.add(mas);
        
        Master__c mas1 = new Master__c();
        mas1.Name= 'Ajrak';
        mas1.Name__c ='Craft'; // workmanship
        mas1.Active__c  = True ;
        mas1.Code__c ='AJ';
        masterList.add(mas1);
        
        Master__c mas2 = new Master__c();
        mas2.Name= 'Shikargah';
        mas2.Name__c ='Design Story';
        mas2.Active__c  = True ;
        mas2.Code__c ='SK';
        masterList.add(mas2);
        
        Master__c mas3 = new Master__c();
        mas3.Name= 'Handloom';
        mas3.Name__c ='Loom';
        mas3.Active__c  = True ;
        mas3.Code__c ='H';
        masterList.add(mas3);
        
        Master__c mas4 = new Master__c();
        mas4.Name= 'Silk';
        mas4.Name__c ='Warp';
        mas4.Active__c  = True ;
        mas4.Code__c ='Sl';
        masterList.add(mas4);
        
        Master__c mas5 = new Master__c();
        mas5.Name= 'Silk';
        mas5.Name__c ='Weft';
        mas5.Active__c  = True ;
        mas5.Code__c ='SI';
        masterList.add(mas5);
        
        Master__c mas6 = new Master__c();
        mas6.Name= 'Handmade product of India';
        mas6.Name__c ='Nature';
        mas6.Active__c  = True ;
        mas6.Code__c ='HP';
        masterList.add(mas6);
        
        Master__c mas7 = new Master__c();
        mas7.Name= 'Wedding';
        mas7.Name__c ='Occasion';
        mas7.Active__c  = True ;
        mas7.Code__c ='W';
        masterList.add(mas7);
        
        Master__c mas8 = new Master__c();
        mas8.Name= 'Assam';
        mas8.Name__c ='Origin';
        mas8.Active__c  = True ;
        mas8.Code__c ='AS';
        masterList.add(mas8);
        
        Master__c mas9 = new Master__c();
        mas9.Name= 'Saree';
        mas9.Name__c ='Product Category';
        mas9.Active__c  = True ;
        mas9.Code__c ='S';
        masterList.add(mas9);
        
        Master__c mas10 = new Master__c();
        mas10.Name= 'Colourway';
        mas10.Name__c ='Route';
        mas10.Active__c = True ;
        mas10.Code__c ='CW';
        masterList.add(mas10);
        
        Master__c mas11 = new Master__c();
        mas11.Name= 'Silk';
        mas11.Name__c ='Zari Type';
        mas11.Active__c = True ;
        mas11.Code__c ='ZT';
        masterList.add(mas11);
        
        Master__c mas12 = new Master__c();
        mas12.Name= 'Value Added';
        mas12.Name__c ='Proc-Type';
        mas12.Active__c = True ;
        mas12.Code__c ='V';
        masterList.add(mas12);
        
        if(masterList.size()>0){
            insert masterList;
        }
        
        AutoNumber__c autoNum = new AutoNumber__c(); 
        autoNum.Name ='SHV';//Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;
        
        vendor__c acc = new vendor__c();
        acc.Name = 'TestAcc';
        //acc.RecordTypeId = recordTypeIdAcc;
        acc.Phone_No__c = '12345';
        acc.Vendor_Code__c = '123455';
        accountList.add(acc);
         
        vendor__c acc1 = new vendor__c();
        acc1.Name = 'TestAcc1';
       // acc1.RecordTypeId = recordTypeIdAcc;
        acc1.Phone_No__c = '12345';
        accountList.add(acc1);
        
        if(accountList.size()>0){
            insert accountList;
        }
        Product__c pro = new Product__c();
        pro.Name = 'Test';
        pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Base_Colour__c = 'Red';
        pro.Body_Pattern__c = 'test';
        pro.Border_Pattern__c = 'test';
        pro.Pallu_Pattern__c = 'test';
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
        pro.proc_Type__c = 'Value Added';
        productList.add(pro);
        
        
        
        Product__c pro2 = new Product__c();
        pro2.Name = 'Test12';
        pro2.vendor_custom__c = acc1.id;
        pro2.RecordTypeId = recordTypeId;
        pro2.cost__c = 1231;
        pro2.Suggested_MRP__c= 1231;
        pro2.Quantity__c= 123;
        pro2.Base_Colour__c = 'Red';
        pro2.Body_Pattern__c = 'test';
        pro2.Border_Pattern__c = 'test';
        pro2.Pallu_Pattern__c = 'test';
        pro2.Workmanship__c = 'Ajrak';
        pro2.Design_Story__c = 'Shikargah';
        pro2.Loom__c ='Handloom';
        pro2.Taneira_Material_Weft__c ='Silk';
        pro2.Material_Wrap__c='Silk';
        pro2.Nature__c ='Handmade product of India';
        pro2.Occasion__c = 'Wedding';
        pro2.Cluster__c ='Assam';
        pro2.Product_Category_Taneira__c ='Saree';
        pro2.Route__c ='Colourway';
        pro2.Zari_Type__c = 'Silk';
        pro2.proc_Type__c = 'Value Added';
        
        productList.add(pro2);
        system.debug('pro==='+pro);
        if(productList.size()>0){
          //  insert productList;
        }
        Attachment attach = new Attachment();
        attach.Name = 'TestAttach.png'; 
        attach.body =  blob.valueOf('Test1');         
        attach.OwnerId = UserInfo.getUserId();
        attach.ParentId = pro.id; 
        attach.IsPrivate = false;
        attachmentList.add(attach);
        
       
        
        if(attachmentList.size()>0){
           // insert attachmentList;
        }
        Test.StartTest(); 
        
        
        for(Product__c prod : productList){
            PageReference pageRef = Page.ProductPageSaree; 
            pageRef.getParameters().put('Source', 'New');
            pageRef.getParameters().put('AccountId', String.valueOf(acc.id));
            
             ApexPages.StandardController sc = new ApexPages.StandardController(prod);
            Product_PageController prodCont = new Product_PageController(sc );
            
            prodCont.image = blob.valueOf('Test');
            
            prodCont.attachimage = attach;
           // prodCont.assignValueForFields(prod.Id);
            prodCont.dosave();
            prodCont.doClone();
            //pageRef.getParameters().put('prodId', prod.id);
            //Test.setCurrentPage(pageRef);
            prodCont.doClone();
            prodCont.dosave();
            prodCont.saveProd();
            prodCont.doCancel();
        }
        Test.StopTest();
        
        
    } 
  
  static testMethod void TestProduct2(){
        string image ='test';
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        list<Master__c> masterList = new List<Master__c>();
        list<vendor__c> accountList = new List<vendor__c>();
        list<Attachment> attachmentList = new List<Attachment>();
        list<Product__c> productList = new List<Product__c>();
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Color';
        mas.Active__c  = True ;
        mas.Code__c ='R';
        masterList.add(mas);
        
        Master__c mas1 = new Master__c();
        mas1.Name= 'Ajrak';
        mas1.Name__c ='Craft'; // workmanship
        mas1.Active__c  = True ;
        mas1.Code__c ='AJ';
        masterList.add(mas1);
        
        Master__c mas2 = new Master__c();
        mas2.Name= 'Shikargah';
        mas2.Name__c ='Design Story';
        mas2.Active__c  = True ;
        mas2.Code__c ='SK';
        masterList.add(mas2);
        
        Master__c mas3 = new Master__c();
        mas3.Name= 'Powerloom';
        mas3.Name__c ='Loom';
        mas3.Active__c  = True ;
        mas3.Code__c ='P';
        masterList.add(mas3);
        
        Master__c mas4 = new Master__c();
        mas4.Name= 'Silk';
        mas4.Name__c ='Warp';
        mas4.Active__c  = True ;
        mas4.Code__c ='Sl';
        masterList.add(mas4);
        
        Master__c mas5 = new Master__c();
        mas5.Name= 'Silk';
        mas5.Name__c ='Weft';
        mas5.Active__c  = True ;
        mas5.Code__c ='SI';
        masterList.add(mas5);
        
        Master__c mas6 = new Master__c();
        mas6.Name= 'Handmade product of India';
        mas6.Name__c ='Nature';
        mas6.Active__c  = True ;
        mas6.Code__c ='HP';
        masterList.add(mas6);
        
        Master__c mas7 = new Master__c();
        mas7.Name= 'Wedding';
        mas7.Name__c ='Occasion';
        mas7.Active__c  = True ;
        mas7.Code__c ='W';
        masterList.add(mas7);
        
        Master__c mas8 = new Master__c();
        mas8.Name= 'Assam';
        mas8.Name__c ='Origin';
        mas8.Active__c  = True ;
        mas8.Code__c ='AS';
        masterList.add(mas8);
        
        Master__c mas9 = new Master__c();
        mas9.Name= 'Saree';
        mas9.Name__c ='Product Category';
        mas9.Active__c  = True ;
        mas9.Code__c ='S';
        masterList.add(mas9);
        
        Master__c mas10 = new Master__c();
        mas10.Name= 'Colourway';
        mas10.Name__c ='Route';
        mas10.Active__c = True ;
        mas10.Code__c ='CW';
        masterList.add(mas10);
        
        Master__c mas11 = new Master__c();
        mas11.Name= 'Silk';
        mas11.Name__c ='Zari Type';
        mas11.Active__c = True ;
        mas11.Code__c ='ZT';
        masterList.add(mas11);
        
        Master__c mas12 = new Master__c();
        mas12.Name= 'Trading';
        mas12.Name__c ='Proc-Type';
        mas12.Active__c = True ;
        mas12.Code__c ='T';
        masterList.add(mas12);
        
        if(masterList.size()>0){
            insert masterList;
        }
        
        AutoNumber__c autoNum = new AutoNumber__c(); 
        autoNum.Name ='SPT';//Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;
        
        vendor__c acc = new vendor__c();
        acc.Name = 'TestAcc';
       // acc.RecordTypeId = recordTypeIdAcc;
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
        Product__c pro = new Product__c();
        pro.Name = 'Test';
        pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Powerloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.proc_Type__c = 'Trading';
        productList.add(pro);
        
        Product__c pro2 = new Product__c();
        pro2.Name = 'Test12';
        pro2.vendor_custom__c = acc1.id;
        pro2.RecordTypeId = recordTypeId;
        pro2.cost__c = 1231;
        pro2.Suggested_MRP__c= 1231;
        pro2.Quantity__c= 123;
        pro2.Colour__c = 'Red';
        pro2.Workmanship__c = 'Ajrak';
        pro2.Design_Story__c = 'Shikargah';
        pro2.Loom__c ='Powerloom';
        pro2.Taneira_Material_Weft__c ='Silk';
        pro2.Material_Wrap__c='Silk';
        pro2.Nature__c ='Handmade product of India';
        pro2.Occasion__c = 'Wedding';
        pro2.Cluster__c ='Assam';
        pro2.Product_Category_Taneira__c ='Saree';
        pro2.Route__c ='Colourway';
        pro2.Zari_Type__c = 'Silk';
        pro2.proc_Type__c = 'Trading';
        
        productList.add(pro2);
        system.debug('pro==='+pro);
        if(productList.size()>0){
            insert productList;
        }
        Attachment attach = new Attachment();
        attach.Name = 'TestAttach.png'; 
        attach.body =  blob.valueOf('Test1');         
        attach.OwnerId = UserInfo.getUserId();
        attach.ParentId = pro.id; 
        attach.IsPrivate = false;
        attachmentList.add(attach);
      
        
        
       
       
        if(attachmentList.size()>0){
           // insert attachmentList;
        }
        
        
        system.debug('attach==='+attach);
        Test.StartTest(); 
        
        for(Product__c prod : productList){
            Product_PageController.getProduct(prod.Id,'Yes');
      break;
        }
        
        for(Product__c prod1 : productList){
             ApexPages.StandardController sc1 = new ApexPages.StandardController(prod1);
            Product_PageController prodCont1 = new Product_PageController(sc1 );
            prodCont1.image = blob.valueOf('Test');
            prodCont1.attachimage = attach;
            prodCont1.doCancel();
            prodCont1.saveProd();
            prodCont1.dosave();
            prodCont1.doClone();
            //prodCont1.doClone();
            //prodCont1.dosave();
            //prodCont1.saveProd();
            
      
        }
       
        Test.StopTest();
        
        
    }
    static testMethod void TestProduct3(){
        Test.StartTest();
        string image ='test';
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        list<Master__c> masterList = new List<Master__c>();
        list<vendor__c> accountList = new List<vendor__c>();
        list<Attachment> attachmentList = new List<Attachment>();
        list<Product__c> productList = new List<Product__c>();
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Base Colour';
        mas.Active__c  = True ;
        mas.Code__c ='R';
        masterList.add(mas);
        
        Master__c mas1 = new Master__c();
        mas1.Name= 'Ajrak';
        mas1.Name__c ='Craft'; // workmanship
        mas1.Active__c  = True ;
        mas1.Code__c ='AJ';
        masterList.add(mas1);
        
        Master__c mas2 = new Master__c();
        mas2.Name= 'Shikargah';
        mas2.Name__c ='Design Story';
        mas2.Active__c  = True ;
        mas2.Code__c ='SK';
        masterList.add(mas2);
        
        Master__c mas3 = new Master__c();
        mas3.Name= 'Powerloom';
        mas3.Name__c ='Loom';
        mas3.Active__c  = True ;
        mas3.Code__c ='P';
        masterList.add(mas3);
        
        Master__c mas4 = new Master__c();
        mas4.Name= 'Silk';
        mas4.Name__c ='Warp';
        mas4.Active__c  = True ;
        mas4.Code__c ='Sl';
        masterList.add(mas4);
        
        Master__c mas5 = new Master__c();
        mas5.Name= 'Silk';
        mas5.Name__c ='Weft';
        mas5.Active__c  = True ;
        mas5.Code__c ='SI';
        masterList.add(mas5);
        
        Master__c mas6 = new Master__c();
        mas6.Name= 'Handmade product of India';
        mas6.Name__c ='Nature';
        mas6.Active__c  = True ;
        mas6.Code__c ='HP';
        masterList.add(mas6);
        
        Master__c mas7 = new Master__c();
        mas7.Name= 'Wedding';
        mas7.Name__c ='Occasion';
        mas7.Active__c  = True ;
        mas7.Code__c ='W';
        masterList.add(mas7);
        
        Master__c mas8 = new Master__c();
        mas8.Name= 'Assam';
        mas8.Name__c ='Origin';
        mas8.Active__c  = True ;
        mas8.Code__c ='AS';
        masterList.add(mas8);
        
        Master__c mas9 = new Master__c();
        mas9.Name= 'Saree';
        mas9.Name__c ='Product Category';
        mas9.Active__c  = True ;
        mas9.Code__c ='S';
        masterList.add(mas9);
        
        Master__c mas10 = new Master__c();
        mas10.Name= 'Colourway';
        mas10.Name__c ='Route';
        mas10.Active__c = True ;
        mas10.Code__c ='CW';
        masterList.add(mas10);
        
        Master__c mas11 = new Master__c();
        mas11.Name= 'Silk';
        mas11.Name__c ='Zari Type';
        mas11.Active__c = True ;
        mas11.Code__c ='ZT';
        masterList.add(mas11);
        
        Master__c mas12 = new Master__c();
        mas12.Name= 'Trading';
        mas12.Name__c ='Proc-Type';
        mas12.Active__c = True ;
        mas12.Code__c ='T';
        masterList.add(mas12);
        
        if(masterList.size()>0){
            insert masterList;
        }
        
         
        AutoNumber__c autoNum = new AutoNumber__c(); 
        autoNum.Name ='SPT';//Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;
        
        vendor__c acc = new vendor__c();
        acc.Name = 'TestAcc';
       // acc.RecordTypeId = recordTypeIdAcc;
        acc.Phone_No__c = '12345';
        acc.Vendor_Code__c = 'test';
        accountList.add(acc);
        
        vendor__c acc1 = new vendor__c();
        acc1.Name = 'TestAcc1';
       // acc1.RecordTypeId = recordTypeIdAcc;
        acc1.Phone_No__c = '12345';
        
        accountList.add(acc1);
        
        if(accountList.size()>0){
            insert accountList;
        }
        Product__c pro = new Product__c();
        pro.Name = 'Test';
        pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 123;
        pro.Colour__c = 'Red';
        pro.Workmanship__c = 'Ajrak';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Powerloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silk';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assam';
        pro.Product_Category_Taneira__c ='Saree';
        pro.Route__c ='Colourway';
        pro.Zari_Type__c = 'Silk';
        pro.proc_Type__c = 'Trading';
        pro.RE_ORDER__c = true;
        productList.add(pro);
        
        Product__c pro2 = new Product__c();
        pro2.Name = 'Test12';
        pro2.vendor_custom__c = acc1.id;
        pro2.RecordTypeId = recordTypeId;
        pro2.cost__c = 1231;
        pro2.Suggested_MRP__c= 1231;
        pro2.Quantity__c= 123;
        pro2.Colour__c = 'Red';
        pro2.Workmanship__c = 'Ajrak';
        pro2.Design_Story__c = 'Shikargah';
        pro2.Loom__c ='Powerloom';
        pro2.Taneira_Material_Weft__c ='Silk';
        pro2.Material_Wrap__c='Silk';
        pro2.Nature__c ='Handmade product of India';
        pro2.Occasion__c = 'Wedding';
        pro2.Cluster__c ='Assam';
        pro2.Product_Category_Taneira__c ='Saree';
        pro2.Route__c ='Colourway';
        pro2.Zari_Type__c = 'Silk';
        pro2.proc_Type__c = 'Trading';
        
        productList.add(pro2);
        system.debug('pro==='+pro);
        if(productList.size()>0){
            insert productList;
        }
        
        
        
        Attachment attach = new Attachment();
        attach.Name = 'TestAttach.png'; 
        attach.body =  blob.valueOf('Test1');         
        attach.OwnerId = UserInfo.getUserId();
        attach.ParentId = pro.id; 
        attach.IsPrivate = false;
        attachmentList.add(attach);
        
        if(attachmentList.size()>0){
           // insert attachmentList;
        }
        
        
        system.debug('attach==='+attach);
        
        pro.Base_Colour__c = 'Red';
        pro.Body_Pattern__c = 'Morning Evening';
        pro.Border_Pattern__c = 'Zigzag';
        pro.Pallu_Pattern__c = 'test1';
        update pro;
         

        Test.StopTest();
    }
}