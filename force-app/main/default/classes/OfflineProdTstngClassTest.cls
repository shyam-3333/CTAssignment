@isTest
public class OfflineProdTstngClassTest {
      public static String recType= Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
    public static String str;// = 'Prod1,'+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+Prod2+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
    public static String[] csvFileLines;
    public static Blob csvFileBody;
    public String csvDataString;
    public String[] recordSepr= new String[]{};
     Double qty; Double amount;
    
    public static testmethod void  verifyData(){
        
         Test.startTest();
       SKUSearchController p = new SKUSearchController();
        //p.FirstPage();
        p.previous();
       // p.POnumberstring = new List<string>();
       // p.POnumberstring.add('1234');
        //p.LastPage();
        p.getprev();
        p.getnxt();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        List<Taneira_view__c> tanlist = new List <Taneira_view__c>();
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Mobile_Phone__c = '8123559020';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
         vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Mobile_Phone__c = '8762921827';
        acc1.Mail_ID__c = 'mutturaj@gmail.com';
        insert acc1;
        string productKey;
        string prodkey1;
prodKey1=(String.valueOf(System.now()).substring(0,13).trim()+acc.Id+'Saree'+'Banaras'+'Isha Sahu_0').trim();
        prodKey1=prodKey1.replaceAll('\\s+', '');
        productKey=prodKey1;
       
           
        // String recordId= Id.valueOf('012c000000092C7');
        /*Upload__C upl = new Upload__C();
        upl.Cost_Band__c = 'A(0-2)';
        upl.Product__c = 'Saree';
        upl.Origin__c = 'BANARAS';
        upl.Fabric__c = 'SILK';
        upl.Quantity__c = 5;
        upl.Start_Date__c = system.today();
        upl.End_Date__c = system.today() + 28;
        upl.Craft__c = 'Ikkat';
        insert upl;*/
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
        prd.Quantity__c = 3;
        prd.Cost__c = 50;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Product_Key_Finder__c = productKey;
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prodList.add(prd);
        
        Product__c prd1 = new Product__c();
        prd1.Name = 'ApprovalRequestTest2';
        prd1.Product_Category_Taneira__c = 'Saree';
        prd1.Cluster__c = 'BANARAS';
        prd1.Taneira_Material_Weft__c = 'SILK';
        prd1.Material_Wrap__c = 'SILK';
        prd1.Workmanship__c = 'Ikkat';
        prd1.Cost_Band__c = 'A(0-2)';
        prd1.Quantity__c = 3;
        prd1.Cost__c = 50;
        prd.Product_Key_Finder__c = productKey;
        prd1.Loom__c = 'Handloom';
        prd1.Proc_Type__c = 'Value Added';
        prd1.Border_Pattern__c='Contrast Border';
        prd1.Body_Pattern__c='Medium Buta';
        prd1.PO_Number__c='6564645';
        prd1.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd1.vendor_custom__c = acc.Id;
        prd1.Pallu_Pattern__c='Contrast Pallu';
        prd1.Suggested_MRP__c=5454;
        prd1.Comments__c='Resyusd423342';
        //prd1.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd1.Sync_Date__c=System.today();
        prd1.Created_From__c = 'Offline App';
        prodList.add(prd1);
        insert prodList;
         Taneira_View__c obj1 = new Taneira_View__c();
        obj1.Vendor_custom__c=acc.Id;
        obj1.Custom_Created_Date__c=system.today();
        obj1.Product_Category__c='Saree';
        obj1.Origin__c='Banaras';
        obj1.Account_id__c=acc.Id;
        obj1.Offline_UserName__c='Isha Sahu_0';
        obj1.Total_Quantity__c=5;
        obj1.Total_Value__c=2000;
        obj1.Pricing_completed__c = true;
       obj1.Product_Key_Finder1__c=productKey;
        obj1.SKU__c=2;
        tanlist.add(obj1);
            insert tanlist;
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('ProductKeyFinder',prod.Product_Key_Finder__c);
        apexpages.currentpage().getparameters().put('Account',prod.vendor_custom__c);
        apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
        apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
        apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
       str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';

        OfflineProdTestingClass opObj ;
        for(Taneira_view__C tan:tanlist){
            apexpages.currentpage().getparameters().put('ProductKeyFinder',tan.Product_Key_Finder1__c);
        }
        
        opObj= new OfflineProdTestingClass();
        opObj.dataUpdated();
        opObj.priceUpdated();
        opObj.poNumUpdated();
       csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        opObj.downloadProductsPdf();
        opObj.dataUpdated();
        opObj.priceUpdated();
        opObj.poNumUpdated();
        //opobj.repricing();
        SKUSearchController opObj2 = new SKUSearchController();
        list<string> POnumberstring = new List<string>();
        //opObj2.POnumberstring.add('1234');
        //opObj2.searchmethod();
        opObj2.clear();
        opObj2.excelDownload();

        test.StopTest();

    }
    

}