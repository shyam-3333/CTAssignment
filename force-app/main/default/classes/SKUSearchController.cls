public class SKUSearchController {
    public String searchKey {get;set;}
    public list<Product__c> prodList {get;set;}
    public String prodCategory {get;set;}
    public List<Product__c> excelProdList{get;set;}
    public String seachResult {get;set;}
    public string header{get;set;}
    public string headerUSKD{get;set;}
    public integer totalRecs{get;set;}
    private integer OffsetSize = 0;
    private integer LimitSize= 10;
    public SKUSearchController() {
        prodList = new List<Product__c>();
        seachResult = 'Search Result';
        totalRecs=0;
        searchkey = apexpages.currentPage().getParameters().get('searchKey');
    }
    
    public void searchmethod(){       
        header = 'SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Warp,Weft,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric,Fabric_R,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Craft_R,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock,Order ID,QR CODE';
        headerUSKD = 'SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Dupatta Fabric,Kurta Fabric,Salwar Fabric,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric_R,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Craft_R,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock,Order ID,QR CODE';
       System.debug('searchKey : '+searchKey);
        if(searchKey!='NA' && searchKey!=''){
            list<String> POnumberstring = new list<string>();
            if(!Test.isRunningTest()){
               POnumberstring  = searchKey.split(',');
            }
            totalRecs = [select count() from Product__c where PO_Number__c =:POnumberstring ];
             // system.debug('PO string'+POnumberstring);
            String searchquery='Select Id,SKU_Code__c,Product_Category_Taneira__c,vendor_custom__r.name,Name,Proc_Type__c,Proc_Source__c,Cluster__c,PO_Number__c,Offline_Username__c,Suggested_MRP__c,Buyers_Cost__c,Procurement_Cost__c,Material_Wrap__c,Taneira_Material_Weft__c,Dupatta_Fabric__c,Kurta_Fabric__c,Salwar_Fabric__c,Design_Story__c,Story_1__c,Story_2__c,Design_Description__c,Base_Colour__c,Detailed_Colour__c,Quantity__c,Fabric__c,FabricR__c,Zari_Type__c,Loom__c,Occasion__c,Blouse_Size__c,Blouse_Type__c,Workmanship__c,CraftR__c,Fold__c,Handloommark__c,Collection__c,Body_Pattern__c,Body_Des_Element__c,Body_Des_Material__c,Body_Des_Density__c,Border_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Size__c,Pallu_Pattern__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Des_Density__c,Pallu_Size__c,Comments__c,vendor_custom__r.Vendor_Code__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,Order_Id__c,QR_CODE__c from Product__c where PO_Number__c =:POnumberstring  LIMIT :LimitSize OFFSET :OffsetSize';
            prodList= Database.query(searchquery);
            if(prodList.size() > 0 && prodList[0] != null){
                prodCategory=prodList[0].Product_Category_Taneira__c;
                System.debug('Product Category : '+prodCategory);
            }
            excelProdList = new List<Product__c>();
            excelProdList = [Select Id,SKU_Code__c,Product_Category_Taneira__c,vendor_custom__r.name,Name,Proc_Type__c,Proc_Source__c,Cluster__c,PO_Number__c,Offline_Username__c,Suggested_MRP__c,Buyers_Cost__c,Procurement_Cost__c,Material_Wrap__c,Taneira_Material_Weft__c,Dupatta_Fabric__c,Kurta_Fabric__c,Salwar_Fabric__c,Design_Story__c,Story_1__c,Story_2__c,Design_Description__c,Base_Colour__c,Detailed_Colour__c,Quantity__c,Fabric__c,FabricR__c,Zari_Type__c,Loom__c,Occasion__c,Blouse_Size__c,Blouse_Type__c,Workmanship__c,CraftR__c,Fold__c,Handloommark__c,Collection__c,Body_Pattern__c,Body_Des_Element__c,Body_Des_Material__c,Body_Des_Density__c,Border_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Size__c,Pallu_Pattern__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Des_Density__c,Pallu_Size__c,Comments__c,vendor_custom__r.Vendor_Code__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,Order_Id__c,QR_CODE__c,Sent_PO_date_and_time__c from Product__c where PO_Number__c =:POnumberstring];
            System.debug('excelProdList : '+excelProdList);
            System.debug('excelProdList : '+excelProdList.size());
        }
    }
    
    public void clear(){
        if(!prodList.isEmpty()){
            prodList.clear();
        }
    }
    
    //On click of button data sholud be downloaded in the excel format.
    public PageReference excelDownload(){
        PageReference pageRef;
        if(!prodList.isEmpty()){
            System.debug('Excel Download');
            pageRef = new PageReference('/apex/SKUSearchExcel');
        }
        return pageRef;
        
    }
  /*  public void FirstPage()
    {
        OffsetSize = 0;
    }*/
    public void previous(){
        If(OffsetSize - LimitSize > 0){
            OffsetSize = OffsetSize - LimitSize;
            searchmethod();
        }
        
    }

    public void next()
    {
        OffsetSize = OffsetSize + LimitSize;
        searchmethod();
    }/*public void LastPage()
    {
        OffsetSize = totalRecs - math.mod(totalRecs,LimitSize);
        search();
    }*/
    public boolean getprev()
    {
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
    public boolean getnxt()
    {
        if((OffsetSize + LimitSize) > totalRecs)
            return true;
        else
            return false;
    }
}