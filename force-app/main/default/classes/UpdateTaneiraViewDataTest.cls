@isTest
public class UpdateTaneiraViewDataTest {
    public static testmethod void verifyData(){
        String prodKey1,prodKey2,prodKey;
        List<Product__c> prodList = new List<Product__c>();
         vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c ='8762921827' ;
        acc.Mail_ID__c = 'Muttu@gmail.com';
        insert acc;
         vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c ='8762921827' ;
        acc1.Mail_ID__c = 'Muttu@gmail.com';
        insert acc1;
         list < Master__c > masterList = new List < Master__c > ();
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        prodKey2=(String.valueOf(System.now()).substring(0,13).trim()+acc1.Id+'Dupatta'+'Karnataka'+'Isha Sahu_0').trim();
        prodKey2=prodKey2.replaceAll('\\s+', '');
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
        Product__c prd;
        for(Integer i=0;i<200;i++){
         prd = new Product__c();
        prd.Name = 'ApprovalRequestTest1'+i;
        prd.Product_Category_Taneira__c = 'Dupatta';
        prd.Cluster__c = 'Karnataka';
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
        prd.vendor_custom__c = acc1.Id;
        prd.Sync_Date__c=System.today()-2;
        prd.Created_From__c='Offline App';
        prd.Comments__c='Testing in prog'+i;
        prd.Updated_in_TaneiraView__c=false;
        prd.Product_Key_Finder__c=prodKey2;
        prodList.add(prd);
        }
        insert prodList;
        List<Taneira_View__c> tnvList = new List<Taneira_View__c>();
         Taneira_View__c obj = new Taneira_View__c();
        obj.vendor_custom__c=acc.Id;
        obj.Custom_Created_Date__c=system.today();
        obj.Product_Category__c='Saree';
        obj.Origin__c='Banaras';
        obj.Offline_UserName__c='Isha Sahu_0';
        obj.Total_Quantity__c=5;
        obj.Total_Value__c=2000;
        obj.Product_Key_Finder1__c=prodKey;
        obj.SKU__c=2;
        tnvList.add(obj);
        
        insert tnvList;

        Test.startTest();
       //System.schedule('Job1', '0 0 * * * ?', new UpdateTaneiraViewData());
       System.schedule('Testing', '0 0 23 * * ?', new UpdateTaneiraViewData());
        Test.stopTest();        
    }
}