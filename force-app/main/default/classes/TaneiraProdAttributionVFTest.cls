@isTest
public class TaneiraProdAttributionVFTest{
    public static String recType= Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
    public static String str;// = 'Prod1,'+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+Prod2+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
    public static String[] csvFileLines;
    public static Blob csvFileBody;
    public String csvDataString;
    public String[] recordSepr= new String[]{};
        Double qty; Double amount;
    
    public static testmethod void  verifyData(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
        Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c  = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c  = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.Story_2_Update__c = 'test';
        prd.PO_Number__c = 'test';
        prd.SKU_Code__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.Photo__c = '<img src=" test amp;" img>';
        prd.SKUImageDownloadData__c = 'test,test1';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.SKUImageDownloadData__c = 'test,test1';
        prd1.SKU_Code__c = 'test1';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.Photo__c = '<img src=" test amp;" img>';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;

        //Test.setCurrentPageReference(new PageReference('Page.SKUImageDownload')); 
		apexpages.currentpage().getParameters().put('id', prodList[0].id);
        SKUImageDownloadController sc = new SKUImageDownloadController();
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Collection_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.selectedCategoryUser = 'Anand';
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Collection_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData1(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        acc1.Phone_No__c = '87621827' ;
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.SKU_Code__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';      
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.SKUImageDownloadData__c = 'test,test1';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Body_Pattern_Update__c';
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        opObj.poDownload();
       opObj.mmDownload();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Body_Pattern_Update__c = 'ABCD';
        opObj.doCopy();
         opObj.copyValue = 'Pallu_Des_Density_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Density_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Border_Des_Element_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Border_Des_Element_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Pallu_Size_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Size_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = ' Pallu_Des_Material_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Occasion_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Occasion_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Design_Story_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Design_Story_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_1_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_1_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_2_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_2_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'PO_Number__c';
        opObj.doCopy();
        opObj.prodList[0].PO_Number__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        //opObj1.assignBack();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
public static testmethod void  verifyData2(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
    
    TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
    
        Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
    
     Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
    
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
    	acc.Phone_No__c = '8762921827' ;
    	acc.Mail_ID__c = 'soumyatikariha03@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
    	acc1.Phone_No__c = '8762921827';
    	acc1.Mail_ID__c = 'soumya.t@kvpcop.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
     //   opObj.copyValue = 'Body_Pattern_Update__c';
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Body_Pattern_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData3(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Body_Des_Element_Update__c';
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Body_Des_Element_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData4(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;        
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Body_Des_Material_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Body_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData5(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;       
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
          opObj.copyValue = 'Body_Des_Density_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Body_Des_Density_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        opObj.poDownload();
       opObj.mmDownload();
        test.StopTest();
        
    }
    public static testmethod void  verifyData15(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;
        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Border_Pattern_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        opObj.poDownload();
       opObj.mmDownload();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Border_Pattern_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData6(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;        prd1.Loom__c = 'Handloom';
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Border_Des_Material_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Border_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData7(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;        prd1.Loom__c = 'Handloom';
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Border_Size_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Border_Size_Update__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData8(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'Bhagalpur';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Pallu_Pattern_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Pallu_Pattern_Update__c = 'ABCD';
        opObj.doCopy();
         opObj.copyValue = 'Pallu_Des_Density_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Density_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Border_Des_Element_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Border_Des_Element_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Pallu_Size_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Size_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = ' Pallu_Des_Material_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Occasion_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Occasion_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Design_Story_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Design_Story_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_1_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_1_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_2_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_2_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'PO_Number__c';
        opObj.doCopy();
        opObj.prodList[0].PO_Number__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData9(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'BANARAS';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        mas8.Name = 'BANARAS';
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
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 3000;
        prd.Buyers_Cost__c = 3000;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
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
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 3000;
        prd1.Procurement_Cost__c = 3000;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;        prd1.Loom__c = 'Handloom';
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
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.Zari_Type__c = 'Silver Gold Zari';
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;
        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
       opObj.copyValue = 'Pallu_Design_Update__c';
        opObj.sentPo();
        opObj.poDownload();
       opObj.mmDownload();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Pallu_Design_Update__c = 'ABCD';
        opObj.doCopy();
         opObj.copyValue = 'Pallu_Des_Density_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Density_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Border_Des_Element_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Border_Des_Element_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Pallu_Size_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Size_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = ' Pallu_Des_Material_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Occasion_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Occasion_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Design_Story_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Design_Story_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_1_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_1_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_2_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_2_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'PO_Number__c';
        opObj.doCopy();
        opObj.prodList[0].PO_Number__c = 'ABCD';
        opObj.doCopy();
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj.poDownload();
       opObj.mmDownload();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        
        
        test.StopTest();
        
    }
    public static testmethod void  verifyData19(){
        TriggerExecutionController__c tt = new TriggerExecutionController__c();
    tt.Name = 'ProductSuggestedMRPHelper';
    tt.TriggerIsActive__c = false;
    insert tt;
        
        TriggerExecutionController__c ttt = new TriggerExecutionController__c();
        ttt.Name = 'QRcodeAPI';
        ttt.TriggerIsActive__c = false;
        insert ttt;
        
        TaneiraPO__c taneiraPO = new TaneiraPO__c(Name = 'SIKA', Storage_Location__c = '1008', Purchase_Group__c = 'SAR', Profit_Center__c = 'SSSIKA');
        insert taneiraPO; 
        
        Taneira_Blouse_Type__c	prodBlouseType = new Taneira_Blouse_Type__c(Name ='Without Blouse Piece',Code__c = 'NB');
        insert prodBlouseType;
        
          Taneira_Product_Description__c prodDescrition1 = new Taneira_Product_Description__c(Name = 'SAREE', Number_of_letters_for_craft__c = 9, Number_of_letters_for_fabric__c = 0, Number_Of_Letters_For_Origin__c = 6, Number_of_letters_for_warp__c = 3, Number_of_letters_for_weft__c = 3);
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
        
         Taneira_Product_Hierarchy__c  ProdHierarchy1 = new 	Taneira_Product_Hierarchy__c(Name = 'DUPATTA', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy1;
         Taneira_Product_Hierarchy__c  ProdHierarchy2 = new Taneira_Product_Hierarchy__c(Name = 'PAVADAI', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy2;
         Taneira_Product_Hierarchy__c  ProdHierarchy3 = new Taneira_Product_Hierarchy__c(Name = 'SAREE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy3;
         Taneira_Product_Hierarchy__c  ProdHierarchy4 = new Taneira_Product_Hierarchy__c(Name = 'YARDAGE', Number_of_letters_for_loom__c =1 , Number_of_letters_for_Product_Category__c=1);
        insert ProdHierarchy4;
        
        List<Multiplier_value__c> MultiplierList = new List<Multiplier_value__c>();
        for(Integer i=0;i<=1000;i++){
            Multiplier_value__c mul = new Multiplier_value__c();
            mul.Vendor_Type__c = 'Aggregator';
            mul.Origin__c = 'BANARAS';
            mul.Fabric__c = 'Tussar';
            mul.Craft__c = 'Woven';
            mul.Zari__c = 'Nil';
            mul.Cost_Band__c = 'B';
            mul.Multiplier__c =  1.44;  
            mul.Name = 'sruthi'+i;
            mul.Concatenation__c = 'BHAGALPURAGGREGATORTUSSARWOVENNILB';    
            MultiplierList.add(mul);    
        }
        insert MultiplierList;
        Test.startTest();
        
        //String csvData = csvFileBody.toString();
        //csvFileLines = csvData.split('\n');  
        List<Product__c> prodList= new List<Product__c>();
        
        //String recId=Id.valueOf('012c000000091sM');
        vendor__c acc = new vendor__c();
        //acc.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc.Name = 'TestClass1';
        acc.Phone_No__c = '8762921827';
        acc.Mail_ID__c = 'muttu@gmail.com';
        insert acc;
        vendor__c acc1 = new vendor__c();
        //acc1.Record_type_of_Account__c = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        acc1.Name = 'TestClass2';
        acc1.Phone_No__c = '8762921827';
        acc1.Mail_ID__c = 'muttu@gmail.com';
        insert acc1;
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
        mas8.Name = 'BANARAS';
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
        prd.Product_Category_Taneira__c = 'USKD';
        prd.Cluster__c = 'BANARAS';
        prd.Taneira_Material_Weft__c = 'SILK';
        prd.Material_Wrap__c = 'SILK';
        prd.Workmanship__c = 'Ikkat';
        prd.Cost_Band__c = 'A(0-2)';
        prd.Quantity__c = 3;
        prd.Yardage_Consumption__c = 50;
        prd.Yardage_UCP__c = 50;
        prd.Yardage_Cost__c = 100;
        prd.Procurement_Cost__c = 100;
        prd.Buyers_Cost__c = 100;
        prd.Packing_Logistic_Cost__c = 50;
        prd.Cost__c = 250;        prd.Border_Pattern__c='Contrast Border';
        prd.Body_Pattern__c='Medium Buta';
        prd.Loom__c = 'Handloom';
        prd.PO_Number__c='324324';
        prd.Proc_Type__c = 'Value Added';
        prd.RecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        prd.vendor_custom__c = acc.Id;
        prd.Pallu_Pattern__c='Contrast Pallu';
        prd.Suggested_MRP__c=454;
        prd.Comments__c='Testq432';
        //prd.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd.Sync_Date__c=System.today();
        prd.Created_From__c = 'Offline App';
        prd.Collection_Update__c = 'test';
        prd.Body_Pattern_Update__c = 'Solid';
        prd.Body_Des_Element_Update__c = 'Temple';
        prd.Body_Des_Material_Update__c = 'Only Zari';
        prd.Body_Des_Density_Update__c = 'Dense';
        prd.Border_Pattern_Update__c = 'Contrast Border';
        prd.Border_Des_Material_Update__c = 'Only Zari';
        prd.Border_Size_Update__c = 'No Border';
        prd.Pallu_Pattern_Update__c = 'No Pallu';
        prd.Pallu_Design_Update__c = 'Solid';
        prd.Pallu_Des_Material_Update__c = 'Only Zari';
        prd.Pallu_Des_Density_Update__c = 'Dense';
        prd.Pallu_Size_Update__c = 'Small';
        prd.Border_Des_Element_Update__c = 'Temple';
        prd.Occasion_Update__c = 'Formal';
        prd.Design_Story_Update__c = 'Korvai';
        prd.Story_1_Update__c = 'Bengal';
        prd.PO_Number__c = 'test';
        prd.Blouse_Type__c='Without Blouse Piece';
        prd.Zari_Type__c = 'Silver Gold Zari';
        prd.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd);
        
        Product__c prd1 = new Product__c();
        prd1.Name = 'ApprovalRequestTest2';
        prd1.Product_Category_Taneira__c = 'USKD';
        prd1.Cluster__c = 'BANARAS';
        prd1.Taneira_Material_Weft__c = 'SILK';
        prd1.Material_Wrap__c = 'SILK';
        prd1.Workmanship__c = 'Ikkat';
        prd1.Cost_Band__c = 'A(0-2)';
        prd1.Quantity__c = 3;
        prd1.Yardage_Consumption__c = 50;
        prd1.Yardage_UCP__c = 50;
        prd1.Yardage_Cost__c = 100;
        prd1.Procurement_Cost__c = 100;
        prd1.Buyers_Cost__c = 100;
        prd1.Packing_Logistic_Cost__c = 50;
        prd1.Cost__c = 250;     
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
        prd1.Zari_Type__c = 'Silver Gold Zari';
        //prd1.Photo__c='<img src="https://titandevbox--TaneiraQA.cs52.my.salesforce.com/servlet/servlet.FileDownload?file=00P5B000002Me3IUAS"></img>';
        prd1.Sync_Date__c=System.today();
        prd1.Created_From__c = 'Offline App';
        
        
        prd1.Collection_Update__c = 'test';
        prd1.Body_Pattern_Update__c = 'Solid';
        prd1.Body_Des_Element_Update__c = 'Temple';
        prd1.Body_Des_Material_Update__c = 'Only Zari';
        prd1.Body_Des_Density_Update__c = 'Dense';
        prd1.Border_Pattern_Update__c = 'Contrast Border';
        prd1.Border_Des_Material_Update__c = 'Only Zari';
        prd1.Border_Size_Update__c = 'No Border';
        prd1.Pallu_Pattern_Update__c = 'No Pallu';
        prd1.Pallu_Design_Update__c = 'Solid';
        prd1.Pallu_Des_Material_Update__c = 'Only Zari';
        prd1.Pallu_Des_Density_Update__c = 'Dense';
        prd1.Pallu_Size_Update__c = 'Small';
        prd1.Border_Des_Element_Update__c = 'Temple';
        prd1.Occasion_Update__c = 'Formal';
        prd1.Design_Story_Update__c = 'Korvai';
        prd1.Story_1_Update__c = 'Bengal';
        prd1.PO_Number__c = 'test';
        prd1.Blouse_Type__c='Without Blouse Piece';
        prd1.FabricR__c = 'Silk';
        prd1.CraftR__c = 'Prints' ;
        prd1.category_user_email__c = 'sfdcadmin@titan.co.in';
        prd1.Attribution_User_Email__c = 'sfdcadmin@titan.co.in';
        prodList.add(prd1);
        insert prodList;

        
        for(Product__c prod:prodList){
            apexpages.currentpage().getparameters().put('Vendor',prod.vendor_custom__c);
            apexpages.currentpage().getparameters().put('Origin',prod.Cluster__c);
            apexpages.currentpage().getparameters().put('Category',prod.Product_Category_Taneira__c);
            apexpages.currentpage().getparameters().put('CDate',String.valueOf(System.now()));
        }
        
        str=prd.Name+','+recType+','+acc.Name+',BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test123,Offline App\n'+prd1.Name+','+recType+','+acc1.Name+','+'BANARAS,Yes,Trading,Saree,Handloom,400,Silk,Silk,Ikkat,Tested,5,Test124,Offline App';
        
        TaneiraProdAttributionVF opObj = new TaneiraProdAttributionVF();
        opObj.copyValue = 'Pallu_Des_Material_Update__c';
        opObj.sentPo();
        // opObj.dataUpdated();
        //opObj.priceUpdated();
        //opObj.poNumUpdated();
        csvFileBody = Blob.valueOf(str);
        //opObj.uploadOfflineData();
        opObj.downloadProducts();
        // opObj.downloadProductsPdf();
        // opObj.dataUpdated();
        // opObj.priceUpdated();
        // opObj.poNumUpdated();
        opObj.doSubmit();
        List<string> toEmailList = new List<string>{'sruthi.v@kvpcorp.com'};
            List<string> ccEmailList = new List<string>{'vinoth.kumar@kvpcorp.com'};
                opObj.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj.doSave();
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'CraftR__c';
        opObj.doCopy();
        opObj.prodList[0].CraftR__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'FabricR__c';
        opObj.doCopy();
        opObj.prodList[0].FabricR__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Pallu_Des_Density_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Density_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Border_Des_Element_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Border_Des_Element_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Pallu_Size_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Size_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = ' Pallu_Des_Material_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Pallu_Des_Material_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Occasion_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Occasion_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Design_Story_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Design_Story_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_1_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_1_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'Story_2_Update__c';
        opObj.doCopy();
        opObj.prodList[0].Story_2_Update__c = 'ABCD';
        opObj.doCopy();
        opObj.copyValue = 'PO_Number__c';
        opObj.doCopy();
        opObj.prodList[0].PO_Number__c = 'ABCD';
        opObj.doCopy();
        
        
         TaneiraProdCategoryClass opObj1 = new TaneiraProdCategoryClass();
        csvFileBody = Blob.valueOf(str);
        opObj1.downloadProducts();
        opObj1.sendEmailMsg('TestemailBody',toEmailList , 'TestSubject',ccEmailList );
        opObj1.doSubmit();
        oPObj1.doSave();
        opObj1.copyAll();
        opObj1.onKeyUpForMultiplier();
        opObj1.mrpMasterData();
        //opObj1.testData();
        
        
        test.StopTest();
        
        
        
        
    }
    
    
}