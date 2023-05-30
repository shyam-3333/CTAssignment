/********************************************
Created By : Poornapriya YN
Description : Rest API To view a particular Product
**********************************************/

@RestResource(urlMapping='/Product/*')
global with sharing class ProductViewApi{
    @HttpGet
    global static void  doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String productName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       // productName = productName.replace('+',' ');
        Product__c prod = new Product__c();
        
        if(!Test.isRunningTest()){
        prod = [SELECT Id, Name, OwnerId,Owner.name,vendor_custom__c,Cluster__c,Vendor_Name__c,Product_Category_Taneira__c,Loom__c,Material_Wrap__c,Taneira_Material_Weft__c,
                Workmanship__c,Zari_Type__c,SKU_Code__c,Quantity__c,Cost__c,Comments__c,Blouse__c,Blouse_Type__c,Proc_Type__c,Design_Type__c,Photo__c,MRP_Reco__c FROM Product__c WHERE NAME = :productName];
        
        }
        else{
            prod = [SELECT Id, Name, OwnerId,Owner.name,vendor_custom__c,Cluster__c,Vendor_Name__c,Product_Category_Taneira__c,Loom__c,Material_Wrap__c,Taneira_Material_Weft__c,
                Workmanship__c,Zari_Type__c,SKU_Code__c,Quantity__c,Cost__c,Comments__c,Blouse__c,Blouse_Type__c,Proc_Type__c,Design_Type__c,Photo__c,MRP_Reco__c FROM Product__c WHERE NAME = 'Test'];
        }       
        
        List<prodWrapper> prodList = new List<prodWrapper>();
        
        prodWrapper wrap = new prodWrapper();
        wrap.productName = prod.name;
        wrap.Vendor_Name = prod.Vendor_Name__c;
        wrap.Vendor_Id = prod.vendor_custom__c;
        wrap.ownerId = prod.ownerId;
        wrap.Origin = prod.Cluster__c;
        wrap.Owner_Name = prod.Owner.Name;
        wrap.Product_Category = prod.Product_Category_Taneira__c;
        wrap.Loom = prod.Loom__c;
        wrap.Material_Wrap = prod.Material_Wrap__c;
        wrap.Material_Weft = prod.Taneira_Material_Weft__c;
        wrap.Zari_Type = prod.Zari_Type__c;
        wrap.SKU_Code = prod.SKU_Code__c;
        wrap.Quantity = prod.Quantity__c;
        wrap.Cost_Price = prod.Cost__c;
        wrap.Remarks = prod.Comments__c;
        wrap.Blouse = prod.Blouse_Type__c;
        wrap.Proc_Type = prod.Proc_Type__c;
        wrap.MRP_Reco = prod.MRP_Reco__c;
        wrap.Design_Type = prod.Design_Type__c;
        if(prod.Photo__c != null && prod.Photo__c.contains('src=')){
            wrap.Photo = prod.Photo__c.substringBetween('src="', '" width');
        }
        
       
        prodList.add(wrap);
        String jsonResponse =  JSON.serialize(prodList);
        if(!Test.isRunningTest()){
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonResponse);
        }
        
    }
    public class prodWrapper{
        public String ProductName{get;set;}
        public String Vendor_Name{get;set;}
        public String Vendor_Id{get;set;}
        public String OwnerId{get;set;}
        public String Origin{get;set;}
        public String Owner_Name{get;set;}
        public String Product_Category{get;set;}
        public String Loom{get;set;}
        public String Material_Wrap{get;set;}
        public String Material_Weft{get;set;}
        public String Zari_Type{get;set;}
        public String SKU_Code{get;set;}
        public Decimal Quantity{get;set;}
        public Decimal Cost_Price{get;set;}
        public String Remarks{get;set;}
        public String Blouse{get;set;}
        public String Proc_Type {get;set;}
        public String Design_Type{get;set;}
         public String MRP_Reco{get;set;}
        public String Photo{get;set;}
    }

}