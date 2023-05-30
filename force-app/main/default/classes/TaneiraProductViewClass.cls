/**************************************************
Created By : Poornapriya YN
Description : Controller class to display products based on date,vendor,Product category,origin,count of SKU
******************************************************/

public class TaneiraProductViewClass{
    //public string vendorName{get;set;}
    //public Id vendorId {get;set;}
    //public Product__c product {get;set;}
   // public list<Id> accountSortedId {get;set;}
    public List<string> accountSortedId1 {get;set;}
    public transient List<Product__c> prodList;
    //public set<Id> setAccId;
    public Map<String,Decimal> combQtyMap {get;set;}
    public Map<String,Decimal> combAmntMap {get;set;}
    public Id accId{get;set;}
    public string origin{get;set;}
    public string createdDate{get;set;}
    public Map<Id,String> mapOfVendor{get;set;}     
    public Map<String,Map<Id,Map<String,Map<String,Integer>>>> mapOfProd {get;set;}
    public string category{get;set;}
    public String mimeType {get;set;}
    //public Map<String,Decimal> CombQtyUpdatedMap{get;set;}
    //public Map<String,Decimal> CombAmntUpdatedMap{get;set;}
    
    public TaneiraProductViewClass(ApexPages.StandardController controller){
        
        mapOfProd = new Map<String,Map<Id,Map<String,Map<String,Integer>>>>();
        //system.debug('**vendorId**'+vendorId);
        //accountSortedId = new list<Id>();
        accountSortedId1 = new list<string>();
        //setAccId = new set<Id>();
        
        mapOfVendor = new Map<Id,String>();
        //Id TaneiraRecType= [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        prodList= [SELECT id,vendor_custom__c,Name,vendor_custom__r.Name,Created_From__c,Blouse_Type__c,Product_Category_Taneira__c,SKU_Code__c,Cluster__c,Taneira_Material_Weft__c,Material_Wrap__c,Proc_Type__c,CreatedDate,Product_Type__c,Remarks__c,Cost__c,Quantity__c,Photo__c,Approval_Status__c,Reject_Need_Clarification_Comment__c,ownerId
                  from Product__c where RecordTypeId = :Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId() AND Re_Order__c != true AND Created_From__c = 'Offline App' AND CreatedDate >=2018-09-01T04:22:22.000Z order by CreatedDate desc ];
             System.debug('========== Heap Size1 :: ' + Limits.getHeapSize());
        system.debug('----------prodList----------'+prodList.size());
        viewProducts();
       // calculateQtyAmnt();
           
    }
    
    public PageReference openProductView(){
        system.debug('**CreatedDate**'+String.ValueOf(CreatedDate).substring(0,13));
        PageReference page = new PageReference('/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&Origin='+origin+'&CDate='+CreatedDate.trim());
        System.debug('====Trim date====='+CreatedDate.trim());
        return page;
    }
    
    /*** 
    Logic to display products with same created date, vendor, category, origin as one line item
    ****/
    public void viewProducts(){
        Set<string> setAccId1 = new Set<string>();
        integer i = 1;
        integer j =1;
        integer k;
        String valueHolder;
        for(Product__c pro : prodList){
          /*  if(!setAccId.contains(pro.account__c)){
                accountSortedId.add(pro.account__c);
                setAccId.add(pro.account__c);
            }*/
            valueHolder=String.valueOf(pro.CreatedDate).substring(0,13);
             if(pro.vendor_custom__c != null){    
                 if(!setAccId1.contains(valueHolder)){      
                     accountSortedId1.add(valueHolder);
                     setAccId1.add(valueHolder);
                 }
             } 
            
           // system.debug('**accountSortedId**'+accountSortedId);
            mapOfVendor.put(pro.vendor_custom__c,pro.vendor_custom__r.name);
            
            if(pro.vendor_custom__c != null){
          //  system.debug('**account__c**'+pro.account__c+'**category'+pro.Product_Category_Taneira__c+'**Origin**'+pro.Cluster__c);
                        
                if(!mapOfProd.isEmpty() && mapOfProd.ContainsKey(valueHolder)){
                    if(mapOfProd.get(valueHolder).ContainsKey(pro.vendor_custom__c)){ 
                        
                        if(mapOfProd.get(valueHolder).get(pro.vendor_custom__c).containsKey(pro.Product_Category_Taneira__c)){
                            
                            if(mapOfProd.get(valueHolder).get(pro.vendor_custom__c).get(pro.Product_Category_Taneira__c).containsKey(pro.Cluster__c)){
                                    
                                k = mapOfProd.get(valueHolder).get(pro.vendor_custom__c).get(pro.Product_Category_Taneira__c).get(pro.cluster__c);
                                mapOfProd.get(valueHolder).get(pro.vendor_custom__c).get(pro.Product_Category_Taneira__c).put(pro.cluster__c,k+1);
                                
                            }
                            else{
                                i=1;
                               // system.debug('**pro.Cluster__c**'+pro.Cluster__c);
                                mapOfProd.get(valueHolder).get(pro.vendor_custom__c).get(pro.Product_Category_Taneira__c).put(pro.Cluster__c,i);
                            }
                        }
                        else{
                            i=1;
                            //system.debug('**pro.Cluster__c**'+pro.Cluster__c);
                            mapOfProd.get(valueHolder).get(pro.vendor_custom__c).put(pro.Product_Category_Taneira__c, new Map<String,Integer>{pro.Cluster__c => i});
                        }
                    }
                    else{
                        i=1;
                        //system.debug('**pro.Product_Category_Taneira__c**'+pro.Product_Category_Taneira__c);
                        mapOfProd.get(valueHolder).put(pro.vendor_custom__c, new Map<String,Map<String,Integer>>{pro.Product_Category_Taneira__c=> new Map<String,Integer>{pro.Cluster__c=>i}});
                    }
                }
                else{
                    i=1;
                    //system.debug('here');
                    mapOfProd.put(valueHolder, new Map<Id,Map<String,Map<String,Integer>>>{pro.vendor_custom__c=> new Map<String,Map<String,Integer>> {pro.Product_Category_Taneira__c=>new Map<String,Integer>{string.valueOf(pro.Cluster__c)=>i}}});
                }
             
           } 
            
        }
        system.debug('**mapOfProd**'+mapOfProd);
        system.debug('**mapOfProd()**'+mapOfProd.size());
        /*for(Product__c prod : prodlist){  
                      
        }*/     
        system.debug('**data**'+accountSortedId1);
        system.debug('**data size**'+accountSortedId1.size());
        
        calculateQtyAmnt();
        
    }
    
        public void calculateQtyAmnt(){
        Set < String > VendorIdSet = new Set < String > ();
        Set < String > ProductCategorySet = new Set < String > ();
        Set < String > OriginSet = new Set < String > ();
        String valueHolder;
        //Map < String, Double > ProdWithAllPoMap = new Map < String, Double > ();
        //List < Product__c > ProductList = new List < Product__c > ();
        //List < Product__c > ProductListWithPO = new List < Product__c > ();
        //Date oldDate1 = Date.today().addDays(-15);
        //Id TaneiraRecType = [Select Id from RecordType where Name =: 'Taneira' AND SObjectType = 'Product__c' limit 1].Id;
        combQtyMap= new Map<String,Decimal>();
        combAmntMap= new Map<String,Decimal>();
        Decimal count,quantity;
        //CombQtyUpdatedMap= new Map<String,Decimal>();
        //CombAmntUpdatedMap= new Map<String,Decimal>();
        if(prodList.size()>0){
            for(Product__c each:prodList){
                if(each.vendor_custom__c !=NULL){
                VendorIdSet.add(each.vendor_custom__c);
                }
                if(each.Product_Category_Taneira__c !=NULL){
                    ProductCategorySet.add(each.Product_Category_Taneira__c);
                }
                if(each.Cluster__c !=NULL){
                OriginSet.add(each.Cluster__c);
                }
            }
        }
                   
        if(VendorIdSet.size()>0 && ProductCategorySet.size()>0 && OriginSet.size()>0){
                for(Product__c each:[SELECT Id,vendor_custom__c,Quantity__c,Cost__c,Blouse_Type__c,PO_Number__c, CreatedDate, Product_Category_Taneira__c, Cluster__c FROM Product__c WHERE vendor_custom__c IN :VendorIdSet AND 
                                 Product_Category_Taneira__c IN :ProductCategorySet AND Cluster__c IN :OriginSet AND 
                                 RecordTypeId =: Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId() AND vendor_custom__c !=NULL ORDER BY CreatedDate Desc] ){
                                  
                                      
                if(each.CreatedDate!=NULL && each.Product_Category_Taneira__c !=NULL && each.Cluster__c !=NULL && each.Quantity__c !=NULL){
                    valueHolder=String.valueOf(each.CreatedDate).substring(0,13)+each.vendor_custom__c+each.Product_Category_Taneira__c+each.Cluster__c;
                if(!combQtyMap.isEmpty() && combQtyMap.containsKey(valueHolder)){
                    count=combQtyMap.get(valueHolder)+each.Quantity__c;
                    combQtyMap.put(valueHolder, count);
                }
                    else{
                    combQtyMap.put(valueHolder, each.Quantity__c);
                    }
                    if(each.Cost__c !=NULL || each.Cost__c !=0){
                        if(!combAmntMap.isEmpty() && combAmntMap.containsKey(valueHolder)){
                            quantity=CombAmntMap.get(valueHolder) +(each.Quantity__c *each.Cost__c);
                            combAmntMap.put(valueHolder, quantity);
                        }
                        else{
                            combAmntMap.put(valueHolder,(each.Quantity__c*each.Cost__c));
                        }
                    }
                }
            }
        }
            System.debug('=====mapOfProd====='+mapOfProd);
            System.debug('=====mapOfProd size====='+mapOfProd.size());
        System.debug('=====CombQtyMap====='+combQtyMap);
        System.debug('======combQtyMap size==='+combQtyMap.size());
        
        System.debug('=======CombAmntMap======='+combAmntMap);
        System.debug('======combAmntMap size==='+combAmntMap.size());
        /*if(!mapOfProd.isEmpty() && !combQtyMap.isEmpty() && !combAmntMap.isEmpty() ){
            System.debug('===Coming insde for to update qty and amount');
            for(String str: mapOfProd.keySet()){
                if(combQtyMap.containsKey(str)){
                    CombQtyUpdatedMap.put(str,combQtyMap.get(str));
                }
                if(combAmntMap.containsKey(str)){
                    CombAmntUpdatedMap.put(str,combAmntMap.get(str));
                }
            }
        }
        System.debug('=====CombQtyUpdatedMap====='+CombQtyUpdatedMap);
        System.debug('=====CombQtyUpdatedMap.size====='+CombQtyUpdatedMap.size());
        System.debug('=======CombAmntUpdatedMap======='+CombAmntUpdatedMap);
        System.debug('=====CombAmntUpdatedMap size====='+CombAmntUpdatedMap.size());*/
        
        
    }
     public pagereference Download() {
        PageReference exdownload = null;
        mimeType = 'application/vnd.ms-excel#'+'TaneiraProductView.xls';
        exdownload = Page.TaneiraProductView;
        exdownload.setRedirect(false);
        return exdownload;
    }
      
}