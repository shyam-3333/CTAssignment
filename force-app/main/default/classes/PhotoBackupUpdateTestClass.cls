/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			12/02/2019   T01   Test Class Failure Fix 
*/
@isTest
public class PhotoBackupUpdateTestClass {
    
    static testmethod void updatePhoto(){
        
         list<AutoNumber__c> lstAn = new list<AutoNumber__c>();
        AutoNumber__c atNum = new AutoNumber__c();
        atNum.Auto_Number__c = 0;
        atNum.Name = 'SKU_Number';
        lstAn.add(atNum);
        
        AutoNumber__c atNum1 = new AutoNumber__c();
        atNum1.Auto_Number__c = 1;
        atNum1.Name = 'SHLPT';
        lstAn.add(atNum1);
        AutoNumber__c atNum2 = new AutoNumber__c();
        atNum2.Auto_Number__c = 2;
        atNum2.Name = 'SHL';
        lstAn.add(atNum2);
        AutoNumber__c atNum3 = new AutoNumber__c();
        atNum3.Auto_Number__c = 3;
        atNum3.Name = 'SHT';
        lstAn.add(atNum3);
        
        insert lstAn;
        
        Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        Account acc = new Account();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        acc.RecordTypeId = recordTypeIdAcc;
        insert acc;
        
         list<Master__c> masterList = new List<Master__c>();
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
        mas3.Code__c ='HL';
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
        mas12.Code__c ='PT';
        masterList.add(mas12);
        
        if(masterList.size()>0){
            insert masterList;
        }
        
        /*Special_Request__c spr= new Special_Request__c();
        spr.Name='Spr1';
        spr.Vendor__c=acc.Id;
        spr.Quantity__c=20;
        spr.Product_Category__c='Saree';
        spr.Material_Weft__c='Silk';
        spr.Material_Wrap__c='Silk';
        spr.Origin__c='Assam';
        spr.Loom__c='Handloom';
        spr.craft__c='Bandhni';
        spr.Cost_Band__c='A(0-2)';
        spr.Special_Request__c=true;
        spr.Cost_Price__c=2000;
        insert spr;*/
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
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
        insert pro;
        
        Product__c pro1 = new Product__c();
        pro1.Name = 'Brown Saree1';
        pro1.Account__c = acc.id;
        pro1.RecordTypeId = recordTypeId;
        pro1.cost__c = 123;
        pro1.Suggested_MRP__c= 123;
        pro1.Quantity__c= 123;
        pro1.Colour__c = 'Red';
        pro1.Workmanship__c = 'Ajrak';
        pro1.Design_Story__c = 'Shikargah';
        pro1.Loom__c ='Handloom';
        pro1.Taneira_Material_Weft__c ='Cotton';
        pro1.Material_Wrap__c='Cotton';
        pro1.Nature__c ='Handmade pro1duct of India';
        pro1.Occasion__c = 'Wedding';
        pro1.Cluster__c ='Assam';
        pro1.product_Category_Taneira__c ='Saree';
        pro1.Route__c ='Colourway';
        pro1.Zari_Type__c = 'Silk';
        pro1.proc_Type__c = 'Trading';
        pro1.Cost_Band__c = 'A(0-2)';
        pro1.Special_request__c=false;
        pro1.Comment_for_Special_Request__c = 'test';
        pro1.Sync_Date__c=System.today();
        insert pro1;
        
        Attachment att = new Attachment();
        att.Name='Att1.txt';
        att.ParentId=pro.Id;
        att.Body=Blob.valueOf('testtstrstrs32113223');
        insert att;
         Attachment att1 = new Attachment();
         att1.Name='Att2.png';
        att1.ParentId=pro1.Id;
        att1.Body=Blob.valueOf('testtstrstrs32113223');
        insert att1;
        List<Attachment> attlst= new List<Attachment>();
        attlst.add(att1);attlst.add(att);
        
        test.startTest();
        AttachmentTriggerHandler obj = new AttachmentTriggerHandler();//<T01>
        AttachmentTriggerHandler.updateProductFields(attlst);//<T01>
        test.stopTest();
    }
}