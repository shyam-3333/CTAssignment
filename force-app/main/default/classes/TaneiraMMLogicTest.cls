/*------------------------------------------------------------------------------
* @Authoe:Vindya
* Description:Test class for TnaeiraMMLogic class
-------------------------------------------------------------------------------*/

@isTest
public class TaneiraMMLogicTest{
    @testSetup static void methodName() {
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
        tt.Name = 'ProductSuggestedMRPHelper';
        tt.TriggerIsActive__c = false;
        insert tt;
        TriggerExecutionController__c tt2 = new TriggerExecutionController__c();
        tt2.Name = 'QRcodeAPI';
        tt2.TriggerIsActive__c = false;
        insert tt2;
        TriggerExecutionController__c obj= new TriggerExecutionController__c();
        obj.Name='ProdDuplicateCheck';
        obj.TriggerIsActive__c=true;
        insert obj;
        TriggerExecutionController__c obj1= new TriggerExecutionController__c();
        obj1.Name='sendMMToSaptrigger';
        obj1.TriggerIsActive__c=false;
        insert obj1;
        
        
    }
    public static testmethod void verifySyncProdTaneira(){
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
        Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 5, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition1;
        Taneira_Product_Description__c prodDescrition2 = new Taneira_Product_Description__c(Name = 'DUPATTA', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition2;
        Taneira_Product_Description__c prodDescrition3 = new Taneira_Product_Description__c(Name = 'PAVADAI', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition3;
        Taneira_Product_Description__c prodDescrition4 = new Taneira_Product_Description__c(Name = 'SHAWL', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition4;
        Taneira_Product_Description__c prodDescrition5 = new Taneira_Product_Description__c(Name = 'SSKD', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition5;
        Taneira_Product_Description__c prodDescrition6 = new Taneira_Product_Description__c(Name = 'STOLE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition6;
        Taneira_Product_Description__c prodDescrition7 = new Taneira_Product_Description__c(Name = 'USKD', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition7;
        Taneira_Product_Description__c prodDescrition8 = new Taneira_Product_Description__c(Name = 'YARDAGE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
        insert prodDescrition8;
        
        Taneira_Product_Hierarchy__c  ProdHierarchy1 = new  Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
        Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
        Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
        Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        TaneiraZari__c tanzari = new TaneiraZari__c(Name = 'SAREE',Value__c = 'Faux');
        insert tanzari;
        TaneiraZari__c tanzari1 = new TaneiraZari__c(Name = 'SAREE',Value__c = 'NIL');
        insert tanzari1;
        TaneiraZari__c tanzari2 = new TaneiraZari__c(Name = 'SAREE',Value__c = 'Pure');
        insert tanzari2;
        TaneiraZari__c tanzari3 = new TaneiraZari__c(Name = 'SAREE',Value__c = 'Tested');
        insert tanzari3;
        string image ='test';
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        list<Master__c> masterList = new List<Master__c>();
        list<vendor__c> accountList = new List<vendor__c>();
        list<Attachment> attachmentList = new List<Attachment>();
        list<Product__c> productList = new List<Product__c>();
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
        mas4.Fabric_Code__c = 'HY';
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
        mas9.Hierarchy_Code__c = 'tytut';
        mas9.Unit_of_Measure__c='565';
        mas9.Active__c  = True ;
        mas9.Code__c ='S';
        masterList.add(mas9);
        Master__c mas23 = new Master__c();
        mas23.Name= 'Red';
        mas23.Name__c ='Control Code';
        mas23.Active__c  = True ;
        mas23.X8Digit_Code__c = 'tuij';
        mas23.X6Digit_Code__c = 'H';
        mas23.Code__c ='R';
        masterList.add(mas23);
        
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
        Master__c mas13 = new Master__c();
        mas13.Name= 'USKD';
        mas13.Name__c ='Product Category';
        mas13.Hierarchy_Code__c = 'tytut';
        mas13.Unit_of_Measure__c='565';
        mas13.Active__c  = True ;
        mas13.Code__c ='S';
        masterList.add(mas13);
        Master__c mas14= new Master__c();
        mas14.Name= 'Saree';
        mas14.Name__c ='Origin';
        mas14.Hierarchy_Code__c = 'tytut';
        mas14.Unit_of_Measure__c='565';
        mas14.Active__c  = True ;
        mas14.Code__c ='S';
        masterList.add(mas14);
        
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
        acc.Phone_No__c = '12345';
        accountList.add(acc);
        
        vendor__c acc1 = new vendor__c();
        acc1.Name = 'TestAcc1';
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
        pro.Workmanship__c = 'Ajrakyghjk';
        pro.Design_Story__c = 'Shikargah';
        pro.Loom__c ='Handloom';
        pro.Taneira_Material_Weft__c ='Silk';
        pro.Material_Wrap__c='Silks';
        pro.Nature__c ='Handmade product of India';
        pro.Occasion__c = 'Wedding';
        pro.Cluster__c ='Assams';
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
        pro1.Taneira_Material_Weft__c ='Si';
        pro1.Material_Wrap__c='Si';
        pro1.Nature__c ='Handmade product of India';
        pro1.Occasion__c = 'Wedding';
        pro1.Cluster__c ='Assa';
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
        pro2.Design_Story__c = 'Shikargah';
        pro2.Loom__c ='Handloom';
        pro2.Nature__c ='Handmade product of India';
        pro2.Occasion__c = 'Wedding';
        pro2.Product_Category_Taneira__c ='Saree';
        pro2.Route__c ='Colourway';
        pro2.Zari_Type__c = 'Silk';
        pro2.proc_Type__c = 'Trading';
        productList.add(pro2);
        Product__c pro3 = new Product__c();
        pro3.Name = 'Test12';
        pro3.vendor_custom__c = acc1.id;
        pro3.RecordTypeId = recordTypeId;
        pro3.cost__c = 1231;
        pro3.Suggested_MRP__c= 1231;
        pro3.Quantity__c= 123;
        pro3.Colour__c = 'Red';
        pro3.Workmanship__c = '';
        pro3.Design_Story__c = 'Shikargah';
        pro3.Loom__c ='Handloom';
        pro3.Taneira_Material_Weft__c ='Silk';
        pro3.Material_Wrap__c='Silk';
        pro3.Nature__c ='Handmade product of India';
        pro3.Occasion__c = 'Wedding';
        pro3.Cluster__c ='';
        pro3.Product_Category_Taneira__c ='USKD';
        pro3.Route__c ='Colourway';
        pro3.Zari_Type__c = 'Silk';
        pro3.proc_Type__c = 'Trading';
        productList.add(pro3);
        system.debug('pro==='+pro);
        if(productList.size()>0){
            insert productList;
        }
    }
    
}