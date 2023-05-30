/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/13/2019   T01    Modified Hardcoded URL To Relative URL
*/
@IsTest
private class CreateProductsApiCloneTest {

    @isTest static void testGetProduct() {
        list<AutoNumber__c> lstAn = new list<AutoNumber__c>();
        AutoNumber__c atNum = new AutoNumber__c();
        atNum.Auto_Number__c = 0;
        atNum.Name = 'SKU_Number';
        lstAn.add(atNum);
        
        AutoNumber__c atNum1 = new AutoNumber__c();
        atNum1.Auto_Number__c = 0;
        atNum1.Name = 'SHLPT';
        lstAn.add(atNum1);
        AutoNumber__c atNum2 = new AutoNumber__c();
        atNum2.Auto_Number__c = 0;
        atNum2.Name = 'SHL';
        lstAn.add(atNum2);
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
        insert pro;
    
    
    
    CreateProductsApiClone.ProductDetails newObj = new CreateProductsApiClone.ProductDetails();
     
     
        newObj.Vendor_Prod_Code = 'Brown Saree';
        newObj.Vendor_Id = acc.Id; 
       // newObj.Vendor_Name = 'test';
       // newObj.Vendor_Mobile = '1234567890';   //
        newObj.Origin = 'Assam';   //Assam/Banaras/South
        newObj.Product_Category = 'Saree'; //Saree
        newObj.Loom = 'Handloom'; 
        newObj.Material_Wrap = 'Cotton';   
        newObj.Material_Weft = 'Silk';   
        newObj.Craft = 'Bandhni'; 
        newObj.Zari_Type = 'Tested'; 
        newObj.Quantity = '10'; 
        newObj.Cost_Price = 1000;
        newObj.Blouse = 'Yes';
        newObj.SINO = '1234';
        newObj.Proc_Type = 'test';
        newObj.Created_From = 'test';
        newObj.Prod_Ref_Code = 'test';
        newObj.Remarks = 'test';
        newObj.Username = 'test';
        
    
    CreateProductsApiClone.ImageDetails imgObj = new CreateProductsApiClone.ImageDetails();
        imgObj.Name = 'test image.png'; //ImageName
        imgObj.Body = 'asfdysa guhasgfudsa sfguasuf';
        imgObj.ContentType = '.png';  //.png/.jpg/.jpeg/.gif/.bmp/.tiff/.pbm
        imgObj.SINO = '1234';
    
    
    list<CreateProductsApiClone.ImageDetails> lstImg = new list<CreateProductsApiClone.ImageDetails>();
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
            CreateProductsApiClone.doPost();
        Test.StopTest();   
        
    }
    
    
    
}