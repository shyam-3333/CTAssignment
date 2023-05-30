@IsTest
private class CreateProductsApiTest {

    @isTest static void testGetProduct() {
         TriggerExecutionController__c tt = new TriggerExecutionController__c();
        tt.Name = 'ProductSuggestedMRPHelper';
        tt.TriggerIsActive__c = true;
        insert tt;
        
        TriggerExecutionController__c TTT12 = new TriggerExecutionController__c();
        ttt12.Name = 'QRcodeAPI';
        ttt12.TriggerIsActive__c = false;
        insert ttt12;
        
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
        //try//{
            insert lstAn;
        //}
     /*   catch(DMLException e){
            //System.assert( e.getMessage().contains('Insert failed. First exception on ' +'row 0; first error:FIELD_CUSTOM_VALIDATION_EXCEPTION,'+'Mileage request exceeds daily limit(500): [Miles__c]'),e.getMessage() );
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
        } */
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        vendor__c acc = new vendor__c();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        //acc.RecordTypeId = recordTypeIdAcc;
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
        
      /*  Master__c mas13 = new Master__c();
        mas13.Name= 'Product Category';
        mas13.Name__c ='USKD';
        mas13.Active__c = True ;
        mas13.Code__c ='U';
        masterList.add(mas13);*/
        
        Master__c mas14 = new Master__c();
        mas14.Name= 'Silk';
        mas14.Name__c ='Salwar_Fabric';
        mas14.Active__c = True ;
        mas14.Code__c ='';
        masterList.add(mas14);
        
        Master__c mas15 = new Master__c();
        mas15.Name= 'Silk';
        mas15.Name__c ='Dupatta_Fabric';
        mas15.Active__c = True ;
        mas15.Code__c ='';
        masterList.add(mas15);
        
        Master__c mas16 = new Master__c();
        mas16.Name= 'Silk';
        mas16.Name__c ='Kurta_Fabric';
        mas16.Active__c = True ;
        mas16.Code__c ='';
        masterList.add(mas16);
        
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
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Special_request__c=true;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Sync_Date__c=System.today();
        pro.Kurta_Fabric__c = 'Silk';
        pro.Dupatta_Fabric__c = 'silk';
        pro.Salwar_Fabric__c = 'silk';
        pro.QR_CODE__c = '123';
        insert pro;
    
        /*Upload__c upl = new Upload__c();
        upl.Cost_Band__c = 'A(0-2)';
        upl.Craft__c = 'Bandhni';
        upl.Fabric__c = 'Silk';
        upl.Origin__c = 'Assam';
        upl.Product__c = 'Saree';
        upl.Purchased_Quantity__c = 10;
        upl.Purchased_Val__c = 1000;
        upl.Quantity__c = 15;
        upl.Value__c = 1500;
        upl.End_Date__c =  Date.newInstance(2016, 02, 28);
        upl.Start_Date__c =  Date.newInstance(2016, 02, 01);
        insert upl;*/
    
    
    CreateProductsApi.ProductDetails newObj = new CreateProductsApi.ProductDetails();
     
     
        CreateProductsApi.Vendor_Prod_CodeWrap val1 = new CreateProductsApi.Vendor_Prod_CodeWrap();
        val1.QRcodeName = 'TNRA1991110560';
        
        newObj.Vendor_Prod_Code.add(val1);
        newObj.Vendor_Id = acc.Id; 
       // newObj.Vendor_Name = 'test';
       // newObj.Vendor_Mobile = '1234567890';   //
        newObj.Origin = 'Assam';   //Assam/Banaras/South
        newObj.Product_Category = 'Saree'; //Saree
        newObj.Loom = 'Handloom'; 
        newObj.Material_Wrap = 'Silk';   
        newObj.Material_Weft = 'Silk';   
        newObj.Craft = 'Bandhni'; 
        newObj.Zari_Type = 'Tested'; 
        newObj.Quantity = '10'; 
        newObj.Cost_Price = 1000;
        newObj.Blouse = 'Yes';
        newObj.SINO = '1234';
        newObj.Proc_Type = 'Trading';
        newObj.Created_From = 'test';
        newObj.Prod_Ref_Code = 'test';
        newObj.Remarks = 'test';
        newObj.Username = 'test';
        newObj.specialRequest = false;
        newObj.costBand = 'A(0-2)';
        newObj.comment = 'special request';
        
       /*  CreateProductsApi.QRCodes qrCodeObj = new CreateProductsApi.QRCodes();
    	qrCodeObj.qrcodename = 'qrcodename';
        
        List<CreateProductsApi.QRCodes> qrCode = new List<CreateProductsApi.QRCodes>();
        qrCode.add(qrCodeObj);
        
        newObj.qrCode = qrCode;  */
        
    
    CreateProductsApi.ImageDetails imgObj = new CreateProductsApi.ImageDetails();
        imgObj.Name = 'test image.png'; //ImageName
        imgObj.Body = 'asfdysa guhasgfudsa sfguasuf';
        imgObj.ContentType = '.png';  //.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm
        imgObj.SINO = '1234';
    
    
    list<CreateProductsApi.ImageDetails> lstImg = new list<CreateProductsApi.ImageDetails>();
    lstImg.add(imgObj);
    
    newObj.ImageUpload = lstImg;
    
        
        
    
    String JsonMsg=JSON.serialize(newObj);
    JsonMsg = '[' +JsonMsg+ ']';

    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri = 'https://cs14.salesforce.com/services/apexrest/Product/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        
        request.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = request;
        RestContext.response= res;
        
        Test.startTest();
            //CreateProductsApi.ProductDetails newObj1 = new CreateProductsApi.ProductDetails();
            CreateProductsApi.doPost();
        Test.StopTest();   
        
    }
    
    @isTest static void testGetProduct1() {
        
         TriggerExecutionController__c tt = new TriggerExecutionController__c();
        tt.Name = 'ProductSuggestedMRPHelper';
        tt.TriggerIsActive__c = true;
        insert tt;
        
        TriggerExecutionController__c TTT12 = new TriggerExecutionController__c();
        ttt12.Name = 'QRcodeAPI';
        ttt12.TriggerIsActive__c = false;
        insert ttt12;
        
     
        
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
        
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        vendor__c acc = new vendor__c();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        //acc.RecordTypeId = recordTypeIdAcc;
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
        
         Master__c mas14 = new Master__c();
        mas14.Name= 'Silk';
        mas14.Name__c ='Salwar_Fabric';
        mas14.Active__c = True ;
        mas14.Code__c ='';
        masterList.add(mas14);
        
        Master__c mas15 = new Master__c();
        mas15.Name= 'Silk';
        mas15.Name__c ='Dupatta_Fabric';
        mas15.Active__c = True ;
        mas15.Code__c ='';
        masterList.add(mas15);
        
        Master__c mas16 = new Master__c();
        mas16.Name= 'Silk';
        mas16.Name__c ='Kurta_Fabric';
        mas16.Active__c = True ;
        mas16.Code__c ='';
        masterList.add(mas16);
        

        
        if(masterList.size()>0){
            insert masterList;
        }
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();
        pro.Name = 'Brown Saree';
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
        pro.Proc_Type__c = 'Trading';
        pro.Cost_Band__c = 'A(0-2)';
        pro.Special_Request__c=false;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Kurta_Fabric__c = 'Silk';
        pro.Dupatta_Fabric__c = 'silk';
        pro.Salwar_Fabric__c = 'silk';
        pro.QR_CODE__c = '123';
        pro.Sync_Date__c=System.today();
        insert pro;
    
        /*Upload__c upl = new Upload__c();
        upl.Cost_Band__c = 'A(0-2)';
        upl.Craft__c = 'Bandhni';
        upl.Fabric__c = 'Silk';
        upl.Origin__c = 'Assam';
        upl.Product__c = 'Saree';
        upl.Purchased_Quantity__c = 10;
        upl.Purchased_Val__c = 1000;
        upl.Quantity__c = 15;
        upl.Value__c = 1500;
        upl.End_Date__c =  Date.newInstance(2016, 02, 28);
        upl.Start_Date__c =  Date.newInstance(2016, 02, 01);
        insert upl;*/
    
    
    CreateProductsApi.ProductDetails newObj = new CreateProductsApi.ProductDetails();
     
     
           CreateProductsApi.Vendor_Prod_CodeWrap val1 = new CreateProductsApi.Vendor_Prod_CodeWrap();
        val1.QRcodeName = 'TNRA1991110560';
        CreateProductsApi.Vendor_Prod_CodeWrap val2 = new CreateProductsApi.Vendor_Prod_CodeWrap();
        val2.QRcodeName = 'TNRA1991110565';
        
        newObj.Vendor_Prod_Code.add(val1);
        newObj.Vendor_Prod_Code.add(val2);
     //   newObj.Vendor_Prod_Code = 'Brown Saree';
        newObj.Vendor_Id = acc.Id; 
       // newObj.Vendor_Name = 'test';
       // newObj.Vendor_Mobile = '1234567890';   //
        newObj.Origin = 'Assam';   //Assam/Banaras/South
        newObj.Product_Category = 'Saree'; //Saree
        newObj.Loom = 'Handloom'; 
        newObj.Material_Wrap = 'Silk';   
        newObj.Material_Weft = 'Silk';   
        newObj.Craft = 'Bandhni'; 
        newObj.Zari_Type = 'Tested'; 
        newObj.Quantity = '10'; 
        newObj.Cost_Price = 1000;
        newObj.Blouse = 'Yes';
        newObj.SINO = '1234';
        newObj.Proc_Type = 'Trading';
        newObj.Created_From = 'test';
        newObj.Prod_Ref_Code = 'test';
        newObj.Remarks = 'test';
        newObj.Username = 'test';
        newObj.specialRequest = true;
        newObj.costBand = 'A(0-2)';
        newObj.comment = 'special request';
        
/*        CreateProductsApi.QRCodes qrCodeObj = new CreateProductsApi.QRCodes();
    	qrCodeObj.qrcodename = 'qrcodename';
        
        List<CreateProductsApi.QRCodes> qrCode = new List<CreateProductsApi.QRCodes>();
        qrCode.add(qrCodeObj);
        
        newObj.qrCode = qrCode;
   */     
    
    CreateProductsApi.ImageDetails imgObj = new CreateProductsApi.ImageDetails();
        imgObj.Name = 'test image.png'; //ImageName
        imgObj.Body = 'asfdysa guhasgfudsa sfguasuf';
        imgObj.ContentType = '.png';  //.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm
        imgObj.SINO = '1234';
    
    
    list<CreateProductsApi.ImageDetails> lstImg = new list<CreateProductsApi.ImageDetails>();
    lstImg.add(imgObj);
    
    newObj.ImageUpload = lstImg;
    
        
        
    
    String JsonMsg=JSON.serialize(newObj);
    JsonMsg = '[' +JsonMsg+ ']';

    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri = 'https://cs14.salesforce.com/services/apexrest/Product/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        
        request.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = request;
        RestContext.response= res;
        
        Test.startTest();
            //CreateProductsApi.ProductDetails newObj1 = new CreateProductsApi.ProductDetails();
            CreateProductsApi.doPost();
        Test.StopTest();   
        
    }
    
    
 /*   @isTest static void testGetProduct2() {
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
        pro.Offline_Key__c = '1234';
        pro.Sync_Date__c=System.today()-1;
        insert pro;
    
        Upload__c upl = new Upload__c();
        upl.Cost_Band__c = 'A(0-2)';
        upl.Craft__c = 'Bandhni';
        upl.Fabric__c = 'Silk';
        upl.Origin__c = 'Assam';
        upl.Product__c = 'Saree';
        upl.Purchased_Quantity__c = 10;
        upl.Purchased_Val__c = 1000;
        upl.Quantity__c = 15;
        upl.Value__c = 1500;
        upl.End_Date__c =  Date.newInstance(2016, 02, 28);
        upl.Start_Date__c =  Date.newInstance(2016, 02, 01);
        insert upl;
    
    
    CreateProductsApi.ProductDetails newObj = new CreateProductsApi.ProductDetails();
     
     
        newObj.Vendor_Prod_Code = 'Brown Saree';
        newObj.Vendor_Id = acc.Id; 
       // newObj.Vendor_Name = 'test';
       // newObj.Vendor_Mobile = '1234567890';   //
        newObj.Origin = 'Assam';   //Assam/Banaras/South
        newObj.Product_Category = 'Saree'; //Saree
        newObj.Loom = 'Handloom'; 
        newObj.Material_Wrap = 'Silk';   
        newObj.Material_Weft = 'Silk';   
        newObj.Craft = 'Bandhni'; 
        newObj.Zari_Type = 'Tested'; 
        newObj.Quantity = '5'; 
        newObj.Cost_Price = 1000;
        newObj.Blouse = 'Yes';
        newObj.SINO = '1234';
        newObj.Proc_Type = 'Trading';
        newObj.Created_From = 'test';
        newObj.Prod_Ref_Code = 'test';
        newObj.Remarks = 'test';
        newObj.Username = 'test';
        newObj.specialRequest = false;
        //newObj.Comment_for_Special_Request__c = 'test';
        newObj.costBand = 'A(0-2)';
        newObj.comment = 'special request';
        
    
    CreateProductsApi.ImageDetails imgObj = new CreateProductsApi.ImageDetails();
        imgObj.Name = 'test image.png'; //ImageName
        imgObj.Body = 'asfdysa guhasgfudsa sfguasuf';
        imgObj.ContentType = '.png';  //.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm
        imgObj.SINO = '1234';
    
    
    list<CreateProductsApi.ImageDetails> lstImg = new list<CreateProductsApi.ImageDetails>();
    lstImg.add(imgObj);
    
    newObj.ImageUpload = lstImg;
    
        
        
    
    String JsonMsg=JSON.serialize(newObj);
    JsonMsg = '[' +JsonMsg+ ']';

    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri = 'https://cs14.salesforce.com/services/apexrest/Product/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        
        request.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = request;
        RestContext.response= res;
        
        Test.startTest();
            //CreateProductsApi.ProductDetails newObj1 = new CreateProductsApi.ProductDetails();
            CreateProductsApi.doPost();
        Test.StopTest();   
        
    }*/
     
    
    @isTest static void testGetProduct3() {
         TriggerExecutionController__c tt = new TriggerExecutionController__c();
        tt.Name = 'ProductSuggestedMRPHelper';
        tt.TriggerIsActive__c = true;
        insert tt;
        
        TriggerExecutionController__c TTT12 = new TriggerExecutionController__c();
        ttt12.Name = 'QRcodeAPI';
        ttt12.TriggerIsActive__c = false;
        insert ttt12;
        
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
        
        //Id recordTypeIdAcc = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        vendor__c acc = new vendor__c();
        acc.Name= 'test Account';
        acc.Phone_No__c = '2648394';
        //acc.RecordTypeId = recordTypeIdAcc;
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
        
         Master__c mas14 = new Master__c();
        mas14.Name= 'Silk';
        mas14.Name__c ='Salwar_Fabric';
        mas14.Active__c = True ;
        mas14.Code__c ='';
        masterList.add(mas14);
        
        Master__c mas15 = new Master__c();
        mas15.Name= 'Silk';
        mas15.Name__c ='Dupatta_Fabric';
        mas15.Active__c = True ;
        mas15.Code__c ='';
        masterList.add(mas15);
        
        Master__c mas16 = new Master__c();
        mas16.Name= 'Silk';
        mas16.Name__c ='Kurta_Fabric';
        mas16.Active__c = True ;
        mas16.Code__c ='';
        masterList.add(mas16);
        

        
        if(masterList.size()>0){
            insert masterList;
        }
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        Product__c pro = new Product__c();
        pro.Name = 'Brown Saree';
        pro.vendor_custom__c = acc.id;
        pro.RecordTypeId = recordTypeId;
        pro.cost__c = 123;
        pro.Suggested_MRP__c= 123;
        pro.Quantity__c= 1;
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
        pro.Special_Request__c=false;
        pro.Comment_for_Special_Request__c = 'test';
        pro.Offline_Key__c = '1234';
        pro.Sync_Date__c=System.today();
        pro.Kurta_Fabric__c = 'Silk';
        pro.Dupatta_Fabric__c = 'silk';
        pro.Salwar_Fabric__c = 'silk';
        pro.QR_CODE__c = '123';
        insert pro;
    
        /*Upload__c upl = new Upload__c();
        upl.Cost_Band__c = 'A(0-2)';
        upl.Craft__c = 'Bandhni';
        upl.Fabric__c = 'Silk';
        upl.Origin__c = 'Assam';
        upl.Product__c = 'Saree';
        upl.Purchased_Quantity__c = 5;
        upl.Purchased_Val__c = 1000;
        upl.Quantity__c = 15;
        upl.Value__c = 1500;
        upl.End_Date__c =  Date.newInstance(2016, 02, 28);
        upl.Start_Date__c =  Date.newInstance(2016, 02, 01);
        insert upl;*/
    
    
    CreateProductsApi.ProductDetails newObj = new CreateProductsApi.ProductDetails();
     
     
           CreateProductsApi.Vendor_Prod_CodeWrap val1 = new CreateProductsApi.Vendor_Prod_CodeWrap();
        val1.QRcodeName = 'TNRA1991110560';
        
        newObj.Vendor_Prod_Code.add(val1);
    //    newObj.Vendor_Prod_Code = 'Brown Saree';
        newObj.Vendor_Id = acc.Id; 
       // newObj.Vendor_Name = 'test';
       // newObj.Vendor_Mobile = '1234567890';   //
        newObj.Origin = 'Assam';   //Assam/Banaras/South
        newObj.Product_Category = 'Saree'; //Saree
        newObj.Loom = 'Handloom'; 
        newObj.Material_Wrap = 'Silk';   
        newObj.Material_Weft = 'Silk';   
        newObj.Craft = 'Bandhni'; 
        newObj.Zari_Type = 'Tested'; 
        newObj.Quantity = '11'; 
        newObj.Cost_Price = 1000;
        newObj.Blouse = 'Yes';
        newObj.SINO = '1234';
        newObj.Proc_Type = 'Trading';
        newObj.Created_From = 'test';
        newObj.Prod_Ref_Code = 'test';
        newObj.Remarks = 'test';
        newObj.Username = 'test';
        newObj.specialRequest = false;
        newObj.costBand = 'A(0-2)';
        newObj.comment = 'special request';
        
/*        CreateProductsApi.QRCodes qrCodeObj = new CreateProductsApi.QRCodes();
    	qrCodeObj.qrcodename = 'qrcodename';
        
        List<CreateProductsApi.QRCodes> qrCodeList = new List<CreateProductsApi.QRCodes>();
        qrCodeList.add(qrCodeObj);
        
        newObj.qrCode = qrCodeList;
        
*/    
    CreateProductsApi.ImageDetails imgObj = new CreateProductsApi.ImageDetails();
        imgObj.Name = 'test image.png'; //ImageName
        imgObj.Body = 'asfdysa guhasgfudsa sfguasuf';
        imgObj.ContentType = '.png';  //.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm
        imgObj.SINO = '1234';
    
    
    list<CreateProductsApi.ImageDetails> lstImg = new list<CreateProductsApi.ImageDetails>();
    lstImg.add(imgObj);
    
    newObj.ImageUpload = lstImg;
    
        
        
    
    String JsonMsg=JSON.serialize(newObj);
    JsonMsg = '[' +JsonMsg+ ']';

    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
         //<T01>
        request.requestUri = '/services/apexrest/Product/';
          
         //<T01>
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        
        request.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = request;
        RestContext.response= res;
        
        Test.startTest();
            //CreateProductsApi.ProductDetails newObj1 = new CreateProductsApi.ProductDetails();
            CreateProductsApi.doPost();
        Test.StopTest();   
        
    }
    
}