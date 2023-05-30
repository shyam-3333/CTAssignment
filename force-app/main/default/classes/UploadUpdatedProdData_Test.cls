@isTest
public class UploadUpdatedProdData_Test {
    public static String accId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
    public static String rec=Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
    public static String str;  
    public static String[] csvFileLines;
    
    public static Blob csvFileBody;
    
    public static testmethod void readUpl() {
        
        
        //Insert Account before inserting a Product.
        
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestprodAccount';
        acc.Phone_No__c = '7567567561';
        acc.Mobile_Phone__c = '8098987787';
        acc.Mail_ID__c = 'accvend1@fake.com';
        acc.Email_Id_Vendor__c = 'accvend1@fake.com';
        insert acc;
        Account acc1 = new Account();
        acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestprodAccount123';
        acc1.Phone_No__c = '1232424244';
        acc1.Mobile_Phone__c = '8098027787';
        acc1.Mail_ID__c = 'accvend123@fake.com';
        acc1.Email_Id_Vendor__c = 'accvend123@fake.com';
        insert acc1;
        
        //Insert Product
        
        list < Master__c > masterList = new List < Master__c > ();
        SKU_Month_Code__c mnth = new SKU_Month_Code__c();
        mnth.Name = '12';
        mnth.Code__c = 'L';
        insert mnth;
        
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
        
        Product__c prd = new Product__c();
        prd.Name = 'ApprovalRequestTest1';
        prd.Product_Category_Taneira__c = 'Saree';
        prd.Cluster__c = 'BANARAS';
        prd.Taneira_Material_Weft__c = 'SILK';
        prd.Material_Wrap__c = 'SILK';
        prd.Workmanship__c = 'Ikkat';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 6;
        prd.Cost__c = 100;
        prd.Loom__c = 'Handloom';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.Account__c = acc.Id;
        insert prd;
        Product__c prd1 = new Product__c();
        prd1.Name = 'ApprovalRequestTest2';
        prd1.Product_Category_Taneira__c = 'Saree';
        prd1.Cluster__c = 'BANARAS';
        prd1.Taneira_Material_Weft__c = 'SILK';
        prd1.Material_Wrap__c = 'SILK';
        prd1.Workmanship__c = 'Ikkat';
        prd1.Cost_Band__c = 'B(0-2)';
        prd1.Quantity__c = 7;
        prd1.Cost__c = 200;
        prd1.Loom__c = 'Handloom';
        prd1.Proc_Type__c = 'Value Added';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.Account__c = acc1.Id;
        insert prd1;
        str=prd1.Id+',0125B0000000CHZ,SHT03H00845,Saree,arsenal,New,Trading,Test,Banaras,Test,Isha Sahu_0,2000,3500,Silk,Silk,Design Story,Story 1,Story 2,Design Description,Lt Green,White,2,Georgette,NIL,Handloom,Party,Yes,Ikat,Yes,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border,Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,'+'"These are miniature blocks of PARCHA.'+ 
            'PARCHA is a combination of old border blocks. These saris are in combination with full body, intricate motifs incorporating 7 to 10 coloured blocks. It means incorporation of those many DATTA blocks in these set of blocks.It takes alot of effort to register these blocks and to match each one of them.'+ 
            'Moreover not just the block printing is very tedious, but the block making process for these are also a craftsmanship story to add on to the look of the saree.'+ 
            'These designs date back to 300 years ago, when Sanganer was only known for its Natural dye printing....",'+'20,10,10\r\n';
        str+=prd1.Id+',0125B0000000CHZ,SHT03H00845,Saree,arsenal,New,Trading,Test,Banaras,Test,Isha Sahu_0,2000,3500,Silk,Silk,Design Story,Story 1,Story 2,Design Description,Lt Green,White,2,Georgette,NIL,Handloom,Party,Yes,Ikat,Yes,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border,Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,'+'"These are miniature blocks of PARCHA.'+ 
            'PARCHA is a combination of old border blocks. These saris are in combination with full body, intricate motifs incorporating 7 to 10 coloured blocks. It means incorporation of those many DATTA blocks in these set of blocks.It takes alot of effort to register these blocks and to match each one of them.'+ 
            'Moreover not just the block printing is very tedious, but the block making process for these are also a craftsmanship story to add on to the look of the saree.'+ 
            'These designs date back to 300 years ago, when Sanganer was only known for its Natural dye printing....",'+'20,10,10\r\n';
        test.startTest();
        UploadUpdatedProdData fv = new UploadUpdatedProdData();
        csvFileBody = Blob.valueOf(str);
        String csvData = csvFileBody.toString();
        csvFileLines = csvData.split('\r\n');
        fv.contentFile=csvFileBody;
        fv.uploadOfflineData();
        test.stopTest();
        
    }
}