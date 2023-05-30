@RestResource(urlMapping = '/Vendor/*')
global with sharing class VendorOriginAPI{
    @HTTPGET
    global static void doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId= req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        String origin = RestContext.request.params.get('Origin');
        system.debug('**origin**'+origin);
        List<Product__c> productList = new List<Product__c>();
        if(!Test.isRunningTest()){
            productList =[SELECT Id, Name, OwnerId,Owner.name,vendor_custom__c,Cluster__c,Vendor_Name__c,Product_Category_Taneira__c,Loom__c,Material_Wrap__c,Taneira_Material_Weft__c,
                          Workmanship__c,Zari_Type__c,SKU_Code__c,Quantity__c,Cost__c,Comments__c,Blouse_Type__c,Collection__c,Silkmark__c,Design_Story__c,Detailed_Colour__c,Fabric__c,
                          Handloommark__c,Route__c,Occasion__c,Proc_Source__c,Proc_Type__c,Base_Colour__c,Photo__c FROM Product__c WHERE vendor_custom__c = :accountId AND Cluster__c =: origin];
        }
        else{
            productList =[SELECT Id, Name, OwnerId,Owner.name,vendor_custom__c,Cluster__c,Vendor_Name__c,Product_Category_Taneira__c,Loom__c,Material_Wrap__c,Taneira_Material_Weft__c,
                            Workmanship__c,Zari_Type__c,SKU_Code__c,Quantity__c,Cost__c,Comments__c,Blouse_Type__c,Collection__c,Silkmark__c,Design_Story__c,Detailed_Colour__c,Fabric__c,
                            Handloommark__c,Route__c,Occasion__c,Proc_Source__c,Proc_Type__c,Base_Colour__c,Photo__c FROM Product__c WHERE Name = 'Test Prod'];
        }
        List<prodWrapper> prodList = new List<prodWrapper>();
        Map<Id,blob> mapOfAttach = new map<Id,blob>();
        for(Attachment attach: [Select body,Id,ParentId from Attachment where ParentId in: productList ]){
            mapOfAttach.put(attach.ParentId,attach.body);
        }
        for(product__c prod : productList){
            prodWrapper wrap = new prodWrapper();
            wrap.Vendor_Prod_Code = prod.name;
            wrap.Vendor_Name = prod.Vendor_Name__c;
            wrap.Vendor_Id = prod.vendor_custom__c;
            wrap.ownerId = prod.ownerId;
            wrap.Origin = prod.Cluster__c;
            wrap.Owner_Name = prod.Owner.Name;
            wrap.Product_Category = prod.Product_Category_Taneira__c;
            wrap.Loom = prod.Loom__c;
            wrap.Craft = prod.Workmanship__c;
            wrap.Material_Wrap = prod.Material_Wrap__c;
            wrap.Material_Weft = prod.Taneira_Material_Weft__c;
            wrap.Zari_Type = prod.Zari_Type__c;
            wrap.SKU_Code = prod.SKU_Code__c;
            wrap.Quantity = prod.Quantity__c;
            wrap.Cost_Price = prod.Cost__c;
            wrap.Remarks = prod.Comments__c;
            wrap.Blouse = prod.Blouse_Type__c;
            wrap.Proc_Type = prod.Proc_Type__c;
            wrap.Proc_Source = prod.Proc_Source__c;
            wrap.Base_Colour = prod.Base_Colour__c;
            wrap.Route = prod.Route__c ;
            wrap.Handloommark = prod.Handloommark__c;
            wrap.Design_Story = prod.Design_Story__c;
            wrap.Fabric = prod.Fabric__c;
            wrap.Silkmark = prod.Silkmark__c;
            wrap.Collection = prod.Collection__c;
            wrap.Occasion = prod.Occasion__c;
            if(!mapOfAttach.isEmpty() && mapOfAttach.containsKey(prod.Id)){
                wrap.Photo = EncodingUtil.base64Encode(mapOfAttach.get(prod.Id));
            }
            
           
            prodList.add(wrap);
        }
        
        String jsonResponse =  JSON.serialize(prodList);
        if(!test.isRunningTest()){
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonResponse);
        }
        
    }
     public class prodWrapper{
        public String Vendor_Prod_Code;
        public String Vendor_Name;
        public String Vendor_Id;
        public String OwnerId;
        public String Origin;
        public String Owner_Name;
        public String Product_Category;
        public String Loom;
        public String Material_Wrap;
        public String Material_Weft;
        public String Zari_Type;
        public String SKU_Code;
        public Decimal Quantity;
        public Decimal Cost_Price;
        public String Remarks;
        public String Photo;
        public string Craft;
        public string Occasion;
        public string Route;
        public String Blouse;
        public String Proc_Type;
        public String Design_Story;
        public String Base_Colour;
        public String Detailed_Colour;
        public String Fabric;
        public String Proc_Source;
        public String Handloommark;
        public String Silkmark;
        public String Collection;
    }

}