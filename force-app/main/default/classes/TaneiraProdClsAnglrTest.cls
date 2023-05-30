@isTest
public class TaneiraProdClsAnglrTest {
    
    public static testmethod void verifyData(){
         Test.startTest();
        String prodkey;String prodKey1;
       // String accID,category,origin,createddate,productKey;
        
        List<Taneira_View__c> prodList = new List<Taneira_View__c>();
         vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        insert acc;
        list < Master__c > masterList = new List < Master__c > ();
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        prodKey1=(String.valueOf(System.now()).substring(0,13).trim()+acc.Id+'Saree'+'Banaras'+'Isha Sahu_0').trim();
        prodKey1=prodKey1.replaceAll('\\s+', '');
        prodkey=prodKey1;
        Master__c mas = new Master__c();
        mas.Name = 'Red';
        mas.Name__c = 'Base Colour';
        mas.Active__c = True;
        mas.Code__c = 'R';
        masterList.add(mas);

        Master__c mas1 = new Master__c();
        mas1.Name = 'Ajrak';
        mas1.Name__c = 'Craft'; // workmanship
        mas1.Active__c = True;
        mas1.Code__c = 'AJ';
        masterList.add(mas1);

        Master__c mas2 = new Master__c();
        mas2.Name = 'Shikargah';
        mas2.Name__c = 'Design Story';
        mas2.Active__c = True;
        mas2.Code__c = 'SK';
        masterList.add(mas2);

        Master__c mas3 = new Master__c();
        mas3.Name = 'Handloom';
        mas3.Name__c = 'Loom';
        mas3.Active__c = True;
        mas3.Code__c = 'H';
        masterList.add(mas3);

        Master__c mas4 = new Master__c();
        mas4.Name = 'Silk';
        mas4.Name__c = 'Warp';
        mas4.Active__c = True;
        mas4.Code__c = 'Sl';
        masterList.add(mas4);

        Master__c mas5 = new Master__c();
        mas5.Name = 'Silk';
        mas5.Name__c = 'Weft';
        mas5.Active__c = True;
        mas5.Code__c = 'SI';
        masterList.add(mas5);

        Master__c mas6 = new Master__c();
        mas6.Name = 'Handmade product of India';
        mas6.Name__c = 'Nature';
        mas6.Active__c = True;
        mas6.Code__c = 'HP';
        masterList.add(mas6);

        Master__c mas7 = new Master__c();
        mas7.Name = 'Wedding';
        mas7.Name__c = 'Occasion';
        mas7.Active__c = True;
        mas7.Code__c = 'W';
        masterList.add(mas7);

        Master__c mas8 = new Master__c();
        mas8.Name = 'Assam';
        mas8.Name__c = 'Origin';
        mas8.Active__c = True;
        mas8.Code__c = 'AS';
        masterList.add(mas8);

        Master__c mas9 = new Master__c();
        mas9.Name = 'Saree';
        mas9.Name__c = 'Product Category';
        mas9.Active__c = True;
        mas9.Code__c = 'S';
        masterList.add(mas9);

        Master__c mas10 = new Master__c();
        mas10.Name = 'Colourway';
        mas10.Name__c = 'Route';
        mas10.Active__c = True;
        mas10.Code__c = 'CW';
        masterList.add(mas10);

        Master__c mas11 = new Master__c();
        mas11.Name = 'Silk';
        mas11.Name__c = 'Zari Type';
        mas11.Active__c = True;
        mas11.Code__c = 'ZT';
        masterList.add(mas11);

        Master__c mas12 = new Master__c();
        mas12.Name = 'Value Added';
        mas12.Name__c = 'Proc-Type';
        mas12.Active__c = True;
        mas12.Code__c = 'V';
        masterList.add(mas12);

        if (masterList.size() > 0) {
            insert masterList;
        }

        AutoNumber__c autoNum = new AutoNumber__c();
        autoNum.Name = 'SHV'; //Static record 1 of custom setting
        autoNum.Auto_Number__c = 1;
        insert autoNum;
        List<Product__c> prodList1 = new List<Product__c>();
        Product__c prd = new Product__c();
        prd.Name = 'ApprovalRequestTest1';
        prd.Product_Category_Taneira__c = 'Saree';
        prd.Cluster__c = 'Banaras';
        prd.Taneira_Material_Weft__c = 'SILK';
        prd.Material_Wrap__c = 'SILK';
        prd.Workmanship__c = 'Ikkat';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 3;
        prd.Cost__c = 5000;
        prd.Offline_Username__c='Isha Sahu_0';
        prd.Loom__c = 'Handloom';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.Vendor_custom__c = acc.Id;
        prd.Sync_Date__c=System.today()-3;
       
        prd.Created_From__c='Offline App';
        prd.Product_Key_Finder__c=prodKey1;
        prodList1.add(prd);
        
        Product__c prd1 = new Product__c();
        prd1.Name = 'ApprovalRequestTest2';
        prd1.Product_Category_Taneira__c = 'Saree';
        prd1.Cluster__c = 'Banaras';
        prd1.Taneira_Material_Weft__c = 'SILK';
        prd1.Material_Wrap__c = 'SILK';
        prd1.Workmanship__c = 'Ikkat';
        prd1.Cost_Band__c = 'A(0-2)';
        prd1.Quantity__c = 3;
        prd1.Cost__c = 5000;
        prd1.Offline_Username__c='Isha Sahu_0';
        prd1.Loom__c = 'Handloom';
        prd1.Proc_Type__c = 'Value Added';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.Vendor_custom__c = acc.Id;
        prd1.Sync_Date__c=System.today()-2;
        prd1.Created_From__c='Offline App';
        prd1.Product_Key_Finder__c=prodKey1;
        prodList1.add(prd1);
        
       Taneira_View__c obj = new Taneira_View__c();
        obj.Vendor_custom__c=acc.Id;
        obj.Custom_Created_Date__c=system.today();
        obj.Product_Category__c='Saree';
        obj.Origin__c='Banaras';
        obj.Account_id__c=acc.Id;
        obj.Offline_UserName__c='Isha Sahu_0';
        obj.Total_Quantity__c=5;
        obj.Total_Value__c=2000;
        obj.Product_Key_Finder1__c=prodKey;
        obj.SKU__c=2;
        prodList.add(obj);
        
        insert prodList;
        
            
        TaneiraProdClsAnglr tn = new TaneiraProdClsAnglr();
        TaneiraProdClsAnglr.allData(String.valueOf(prodList[0].Custom_Created_Date__c),'Saree');
        tn.Download();
        Test.stopTest();
    }

}