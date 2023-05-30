@isTest
private class TaneiraPortalSearch_Test {
    public static testmethod void taneiraPortalSearchMethod(){
        test.startTest();
        User productUser  =    TestForAskme.toCreateUser('Ask Me Taneira Vendor-Taneira Vendor','productTaneira@test.com');
        productUser.UserPermissionsSFContentUser=false;
        
        Insert productUser; 
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        list<Master__c> masterList = new List<Master__c>();
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
        mas12.Name = 'Value Added';
        mas12.Name__c = 'Proc-Type';
        mas12.Active__c = True;
        mas12.Code__c = 'V';
        masterList.add(mas12);
        
        if(masterList.size()>0){
            insert masterList;
        }
        
        AutoNumber__c autoNum = new AutoNumber__c();
        autoNum.Name = 'SHV'; //Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;
        
        vendor__c acc = new vendor__c();
        acc.Name = 'TestAcc';
        //acc.RecordTypeId = recordTypeIdAcc;
         acc.Phone_No__c = '12345';
        insert acc;
        
        
        Product__c pro = new Product__c();
        pro.Name = 'Ask me Product';
        pro.vendor_custom__c = acc.id;
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
         pro.Approval_Status__c = 'Approved';
        pro.Proc_Type__c='Value Added';
        
        insert pro;
        system.debug('pro==='+pro);
        
        Attachment attach = new Attachment();
        attach.Name = 'TestAttach.png'; 
        attach.body =  blob.valueOf('Test1');         
        attach.OwnerId = UserInfo.getUserId();
        attach.ParentId = pro.id; 
        attach.IsPrivate = false;
        
        insert attach;
        
        System.runAs(productUser){
            
            List<product__c> productList  =     TestForAskme.productRecord(5);
            
            Insert productList;                                         
            test.stopTest();
            
            apexpages.currentPage().getParameters().put('profileName','What user Profile');
            ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('counter','1','1000',null,false)});
            apexpages.currentPage().getParameters().put('profileName','Work instructions user profile');
            TaneiraPortalSearch taneiraPS = new TaneiraPortalSearch();
            taneiraPS.getVendorList();
            taneiraPS.getOriginList();
            taneiraPS.getProCatList();
            taneiraPS.sessionManagement();
            taneiraPS.searchProduct();
          //  taneiraPS.getautoFillDataList();
            taneiraPS.logout();
                
        }
        
    }
    
}