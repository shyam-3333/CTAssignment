global class RTWProductViewController {
    public static List<RTW_Product__c> proList{get;private set;}
    public boolean test{get;set;}
    public List<RTW_Product__c> proViewList{get;private set;}
    public static Date StartDate{get;set;}
    public static Date EndDate{get;set;}
    public Set<string> uniqueKeySet;
    public static Map<string,List<RTW_Product__c>> prodMap;
    public static List<prodWrap> prodWrapList {get; private set;}
    public string ProdType{get;set;}
    public boolean showSlipfield{get;set;}
    public boolean showDuppattafield{get;set;}
    public boolean showTrouserfield{get;set;}
    public boolean showKurtafield{get;set;}
    public boolean showJacketfield{get;set;}
    public boolean showSlipfieldforKurtaSet{get;set;}
    public string uniquekey;
    //public string productTypeName;
   /* public Map<string,decimal> qtyMap;
    public Map<string,decimal> mrpMap;
    public Map<string,decimal> costMap;
    public Map<string,Boolean> poStatusMap;*/
    public String param{get;set;}
    //Added for RTW MM 
    public List<ProductMMWrapper> productMMList{get;set;}
    //public List<TaneiraPO__c> tanPO{get;set;}
    public List<RtwPO__c> rtwPON{get;set;}
    public Map<String,String> proType{get;set;}
    public Map<String,String> proHie{get;set;}
    public Map<String,String> proHie5{get;set;}
    public Map<String,Master__c> proControlCode{get;set;}
    public Map<String,String> proUnitMeasure{get;set;}
    //List<User> userList= new List<User>();
  
    public RTWProductViewController(){
        system.debug('Heap size'+Limits.getHeapSize());
        string uniquekey;
        string productTypeName;
        productMMList = new List<ProductMMWrapper>();
        //tanPO = new list<TaneiraPO__c>();
        //tanPO = TaneiraPO__c.getall().values();
        rtwPON = new List<RtwPO__c>();
        rtwPON = RtwPO__c.getall().values();
        proType = new Map<String,String>();
        proHie = new Map<String,String>();
        proHie5 = new Map<String,String>();
        proControlCode = new Map<String,Master__c>();
        proUnitMeasure = new Map<String,String>();
        for(Master__c mas: [select Name,Code__c from Master__c where Name__c = 'ProductType']){
            if(mas.Name!= null && mas.Code__c!= null){
                proType.put(mas.Name, mas.Code__c);
            }
        }
        for(Master__c mas: [select Name,Hierarchy_Code__c from Master__c where Name__c = 'ProductType']){
            if(mas.Name!= null && mas.Hierarchy_Code__c!= null){
                proHie.put(mas.Name, mas.Hierarchy_Code__c);
            }
        }
        for(Master__c mas: [select Name,Hierarchy_5_Code__c from Master__c where Name__c = 'ProductType']){
            if(mas.Name!= null && mas.Hierarchy_5_Code__c!= null){
                proHie5.put(mas.Name, mas.Hierarchy_5_Code__c);
            }
        }
        for(Master__c mas: [select Name, X8Digit_Code__c, Active__c, X6Digit_Code__c from Master__c where Name__c = 'Control Code']){
            if(mas.Name!= null && mas.X8Digit_Code__c!= null && mas.X6Digit_Code__c!= null){
                proControlCode.put(mas.Name, mas);
            }
        }
        for(Master__c mas: [select Name,Unit_of_Measure__c from Master__c where Name__c = 'ProductType']){
            if(mas.Name!= null && mas.Unit_of_Measure__c!= null){
                proUnitMeasure.put(mas.Name, mas.Unit_of_Measure__c);
            }
        }
        param = 'RTWProduct'; 
        test = false;
        uniquekey = apexpages.currentpage().getparameters().get('ProductKey');
        productTypeName = apexpages.currentpage().getparameters().get('productTypeName');
        
        system.debug('uniquekey:--'+uniquekey);
        proViewList = new List<RTW_Product__c>();
        system.debug('StartDate'+StartDate);
        system.debug('EndDate'+StartDate);
       /* proList = [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                   Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                   Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                   name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                   STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                   Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                   Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                   Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                   BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,
                   MStyle_name__c,MDesign__c,MConstruction__c,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Actual_MRP_Update__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Vendor_Code__c,Vendor_TaxCode__c,Warp__c,Weft__c FROM RTW_Product__c                
                   where vendor_custom__c != null AND (RTW_Pricing_Submitted_Status__c = 'Submitted' OR Submit__c = TRUE) order by Item_no__c,CreatedDate asc  limit 49999];*/
        
        uniqueKeySet = new set<string>();
        prodMap = new Map<string,List<RTW_Product__c>>();
        prodWrapList = new List<prodWrap>();
        
       // system.debug('proList size---'+proList.size());
        Integer qty = 0;
       Map<string,decimal> qtyMap = new Map<string,decimal>();
        Map<string,decimal> mrpMap = new Map<string,decimal>();
       Map<string,decimal> costMap = new Map<string,decimal>();
       Map<string,Boolean> poStatusMap = new Map<String,Boolean>();
        for(RTW_Product__c prod : [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                   Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                   Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                   name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                   STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                   Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                   Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                   Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                   BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,Assigned_To__c,
                   MStyle_name__c,MDesign__c,MConstruction__c,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Actual_MRP_Update__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Vendor_Code__c,Vendor_TaxCode__c,Warp__c,Weft__c FROM RTW_Product__c                
                   where vendor_custom__c != null AND (RTW_Pricing_Submitted_Status__c = 'Submitted' OR Submit__c = TRUE) order by Item_no__c,CreatedDate asc  limit 49999]){
            if(qtyMap.containsKey(prod.name)){
                
                system.debug('Null check==>'+qtyMap.get(prod.name)+prod.Quantity__c+prod.Id);
                qtyMap.put(prod.name,qtyMap.get(prod.name)+prod.Quantity__c);
                
            } else {
                qtyMap.put(prod.name,prod.Quantity__c);
                
            }
            
            if(mrpMap.containsKey(prod.name)){
                System.debug('TotalCost'+prod.Total_Costs__c);
                if(prod.Total_Costs__c != null  ){
                    decimal dec = prod.MRP_Pc__c != null ? prod.Total_Costs__c : 0;
                    dec = dec != null ? dec : 0;
         
                }
              //  decimal dec = prod.MRP_Pc__c != null ? prod.Total_Costs__c : 0;
              //  mrpMap.put(prod.name, mrpMap.get(prod.name) + dec);
            } else {
                decimal dec = prod.MRP_Pc__c != null ? prod.Total_Costs__c : 0;
                mrpMap.put(prod.name, dec);
            }
            if(costMap.containsKey(prod.Name)){
                decimal cost = prod.MCost__c != NULL ? prod.MCost__c : 0;
                costMap.put(prod.Name, costmap.get(prod.Name) + cost);
            }else{
                decimal cost= prod.MCost__c != NULL ? prod.MCost__c : 0;
                costMap.put(prod.Name, cost);
            }
            if(poStatusMap.containskey(prod.Name))
            {
                Boolean postatus = (prod.PO_Number__c != Null && prod.PO_Number__c !=0) ? True : False ;
                poStatusMap.put(prod.Name, poStatusMap.get(prod.Name) && postatus);
            }else{
                Boolean postatus = (prod.PO_Number__c != Null && prod.PO_Number__c !=0) ? True : False ;
                poStatusMap.put(prod.Name, postatus);
            }
        }
        
        
        /*for( RTW_Product__c pro : proList ){
if( docIdMap.containsKey(pro.Id)){
pro.ImageLink__c =  URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file='+ docIdMap.get(pro.Id)   ;   
}
}*/
        
        for(RTW_Product__c pro : [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                   Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                   Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                   name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                   STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                   Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                   Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                   Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                   BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,Assigned_To__r.name,
                   MStyle_name__c,MDesign__c,MConstruction__c,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Actual_MRP_Update__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Vendor_Code__c,Vendor_TaxCode__c,Warp__c,Weft__c FROM RTW_Product__c                
                   where vendor_custom__c != null AND (RTW_Pricing_Submitted_Status__c = 'Submitted' OR Submit__c = TRUE) order by Item_no__c,CreatedDate asc  limit 49999]){
            uniqueKeySet.add(pro.name);
            if(prodMap.containsKey(pro.name)){
                prodMap.get(pro.name).add(pro);
            } else {
                List<RTW_Product__c> proList1 = new List<RTW_Product__c>();
                //String postatus1='';
               // postatus1=poStatusMap.get(pro.Name);
                proList1.add(pro);
                prodMap.put(pro.name,proList1);
                prodWrap pwrp = new prodWrap();
                pwrp.vendorName = pro.vendor_custom__r.Name != null ? pro.vendor_custom__r.Name: '';
                pwrp.ProductCategory = pro.Product__c;
                pwrp.Origin = pro.Origin__c;
                pwrp.SKUCount = integer.valueOf(pro.SKU_Count__c);
                pwrp.TotalQuantity =  qtyMap.get(pro.name) != null ? qtyMap.get(pro.name) : 0;
                if(pro.Product__c == 'MASK'){
                    pwrp.TotalValue = costMap.get(pro.Name) != null ? costMap.get(pro.Name) : 0;  
                }else{
                    pwrp.TotalValue = mrpMap.get(pro.name) != null ? mrpMap.get(pro.name) : 0;
                }
                pwrp.CreatedDate = pro.CreatedDate.format('yyyy-MM-dd HH:mm:ss');
                pwrp.SubmittedDate = (pro.Submitted_Date__c)== null ? '' : pro.Submitted_Date__c.format('yyyy-MM-dd HH:mm:ss');
                pwrp.PO_Status = poStatusMap.get(pro.Name)? 'Yes':'No';
                system.debug( pwrp.CreatedDate );
                pwrp.ProdKey = pro.Name;
                pwrp.Assignedto = pro.Assigned_To__r.name;
                
                prodWrapList.add(pwrp);
            }
        }
        if(uniquekey != null){
            ProdType = prodMap.get(uniquekey)[0].Product__c;
            param = prodMap.get(uniquekey)[0].CreatedBy.Name+'_'+((prodMap.get(uniquekey)[0].Submitted_Date__c)== null ? prodMap.get(uniquekey)[0].CreatedDate.format('yyyy-MM-dd') : prodMap.get(uniquekey)[0].Submitted_Date__c.format('yyyy-MM-dd'))
                +'_'+prodMap.get(uniquekey)[0].vendor_custom__r.Name +'_'+ qtyMap.get(uniquekey);
            system.debug('ProdType -->'+ ProdType);
            system.debug('size'+prodMap.get(uniquekey).size());
            proViewList.addAll(prodMap.get(uniquekey));
            set<Id> docIdSet = new set<Id>();
            for(RTW_Product__c pro : proViewList){
                productMMList.add(new ProductMMWrapper(pro,rtwPON, proType, proHie, proHie5, proControlCode, proUnitMeasure));
                
                docIdSet.add(pro.Id);
                
            }
            system.debug('docIdSet  '+docIdSet);
            Map<Id,Id> docProIdMap = new Map<Id,Id>();
            for(Document doc : [SELECT Id,Name from Document where Name in : docIdSet]){
                docProIdMap.put(doc.Name,doc.Id);
                system.debug('doc name'+ doc.Name + 'doc Id' +doc.Id);            
            }
            for(Id ids : docProIdMap.keySet()){
                system.debug('Key -----> '+ids + '----> '+docProIdMap.get(ids) );
            }
            for(RTW_Product__c rtw : proViewList){
                
                if(rtw.Photo__c != null){
                    Integer index =  rtw.Photo__c.lastIndexOf('=')+1;
                    system.debug( rtw.Photo__c.substring(index, index + 15));
                    rtw.ImageLink__c =  '/servlet/servlet.FileDownload?file='+ rtw.Photo__c.substring(index, index + 15);//docProIdMap.get(rtw.Id);   
                }
                //<img src="https://titandevbox--taneiraqa--c.cs52.visual.force.com/servlet/servlet.FileDownload?file=00P5B000003lcOhUAI"></img>
                //pro.Photo__c =  '<img src="'+URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file='+ docProIdMap.get(pro.Id)+'"></img>';
                
                system.debug('pro photo link '+ rtw.ImageLink__c);
                
            }
        }
        for(prodWrap prw : prodWrapList){
            system.debug('prodWrapList---'+prw); 
        }        
        if(proViewList.size()>0 && proViewList[0].CreatedDate.date()>=Date.newInstance(2022, 01, 25)){
            showSlipfield = true;
        }
        else{
            showSlipfield = false;
        }
        if(proViewList.size()>0 && proViewList[0].CreatedDate.date()>=Date.newInstance(2022, 02, 10)){
            showSlipfieldforKurtaSet = true;
        }
        else{
            showSlipfieldforKurtaSet = false;
        }
    }
    
    //This method is for rtw product download page
    public String COMMA {
        get {
            return String.fromCharArray(new List<Integer> { 44 });
        }
    }
    //This method is for rtw product download page
    public String CRLF {
        get {
            return '\r';
        }
    }
    
    public pageReference ProductDownload(){
        system.debug('uniquekeyuniquekey'+uniquekey);
        PageReference page = new PageReference('/apex/RTWProductDownloadPage?ProductKey='+uniquekey);
        return  page;
    }
    public pageReference ProductPDFDownload(){
        system.debug('uniquekeyuniquekey'+uniquekey);
        PageReference page = new PageReference('/apex/RTWProductDownloadPage1?ProductKey='+uniquekey);
        return  page;
    }
    
    
    //PO Changes
    public pageReference downloadPO(){
          List<User> userList1= new List<User>();
        system.debug('prod'+proViewList.size());
        system.debug('user'+userList1.size());
        if( proViewList.size()>0 && userList1.size()>0)
        {
            param=userList1[0].Counter__c+'_'+String.valueOf(Date.newInstance(proViewList[0].CreatedDate.Year(),proViewList[0].CreatedDate.Month(),proViewList[0].CreatedDate.Day()))+'_'+proViewList[0].vendor_custom__r.Name;
        }
        PageReference page = new PageReference('/apex/RTWDownloadPOPage?ProductKey='+uniquekey);
        return  page;
    }
    
    //MM Changes
    public pageReference downloadMM(){
          List<User> userList1= new List<User>();
      if( proViewList.size()>0 && userList1.size()>0)
        {
            param=userList1[0].Counter__c+'_'+String.valueOf(Date.newInstance(proViewList[0].CreatedDate.Year(),proViewList[0].CreatedDate.Month(),proViewList[0].CreatedDate.Day()))+'_'+proViewList[0].vendor_custom__r.Name;
        }
        PageReference page = new PageReference('/apex/RTWDownloadMMPage?ProductKey='+uniquekey);
        return  page;
    }
    
    public class prodWrap{
        public string vendorName{get;set;}
        public string ProductCategory{get;set;}
        public string Origin{get;set;}
        public integer SKUCount{get;set;}
        Public decimal TotalQuantity{get;set;}
        public decimal TotalValue{get;set;}
        public String PO_Status {get;set;}
        Public String CreatedDate{get;set;}
        Public String SubmittedDate{get;set;}
        public string ProdKey{get;set;}
        public string Assignedto{get;set;}
       
        
    }
    
    public class prodWrapWithImage{
        public RTW_Product__c prod {get;set;}
        public string imgLink {get;set;}
    }
    public void ProductDateFilter(){
        string uniquekey = apexpages.currentpage().getparameters().get('ProductKey');
        system.debug('StartDate:--'+StartDate);
        system.debug('EndDate:--'+EndDate);
        if(StartDate != null && EndDate != null){
            if(StartDate < EndDate){
                system.debug('data check');
               /* proList = [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                           Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                           Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                           name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                           STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                           Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                           Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                           Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                           BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,
                           MStyle_name__c,MDesign__c,MConstruction__c,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c FROM RTW_Product__c                
                           where vendor_custom__c != null AND Submit__c = TRUE order by Item_no__c,CreatedDate asc  limit 49999];*/
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ' Incorrect date '));
            }
            
            //system.debug('proList---'+proList);
            uniqueKeySet = new set<string>();
            prodMap = new Map<string,List<RTW_Product__c>>();
            prodWrapList = new List<prodWrap>();
           // if(proList != null){
                
                for(RTW_Product__c pro : [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                           Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                           Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                           name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                           STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                           Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                           Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                           Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                           BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,
                           MStyle_name__c,Assigned_To__c,MDesign__c,MConstruction__c,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Warp__c,Weft__c FROM RTW_Product__c                
                           where vendor_custom__c != null AND Submit__c = TRUE order by Item_no__c,CreatedDate asc  limit 49999]){
                    if(pro.Photo__c != null){
                        pro.ImageLink__c = pro.Photo__c.substringBetween('<img', 'img>').substringBetween('src="', '"').replace('amp;', '');
                    }
                    system.debug('pro.Account__r.Name'+pro.vendor_custom__r.Name);
                    uniqueKeySet.add(pro.name);
                    if(prodMap.containsKey(pro.name)){
                        prodMap.get(pro.name).add(pro);
                    } else {
                        List<RTW_Product__c> proList1 = new List<RTW_Product__c>();
                        proList1.add(pro);
                        system.debug('pro.Account__r.Name'+pro.vendor_custom__r.Name);
                        prodMap.put(pro.name,proList1);
                        prodWrap pwrp = new prodWrap();
                        pwrp.vendorName = pro.vendor_custom__r.Name != null ? pro.vendor_custom__r.Name: '';
                        pwrp.ProductCategory = pro.Product__c;
                        pwrp.Origin = pro.Origin__c;
                        pwrp.SKUCount = integer.valueOf(pro.SKU_Count__c);
                        
                        pwrp.TotalQuantity = pro.Total__c != null ? integer.valueOf(pro.Total__c) : 0;
                        if(pro.Product__c == 'MASK'){
                            pwrp.TotalValue = pro.MCost__c != null ? integer.valueOf(pro.MCost__c) : 0;  
                        }else{
                            pwrp.TotalValue = pro.MRP_Pc__c != null ? integer.valueOf(pro.Total_Costs__c) : 0;
                        }
                        
                        pwrp.CreatedDate = pro.CreatedDate.format('dd-MM-yyyy');
                        pwrp.ProdKey = pro.Name;
                        prodWrapList.add(pwrp);
                    }
                }
           // }
            if(uniquekey != null){
                system.debug('size'+prodMap.get(uniquekey).size());
                proViewList.addAll(prodMap.get(uniquekey));
                
            }
            for(RTW_Product__c product : proViewList){
                productMMList.add(new ProductMMWrapper(product,rtwPON, proType, proHie, proHie5, proControlCode, proUnitMeasure));
                
            }
            for(prodWrap prw : prodWrapList){
                system.debug('prodWrapList---'+prw); 
                //  productMMList.add(new ProductMMWrapper(prw));
                
            }
            
        } 
    }
    public PageReference DocDwld(){
        String proId = Apexpages.currentpage().getParameters().get('proId');
        system.debug('proId-->'+ proId );
        List<Attachment> attachDoc = [SELECT Id, Name, ContentType, ParentId FROM Attachment where ParentId =:proId  and ContentType  Like 'application/pdf' LIMIT 1];
        PageReference pageRef = Apexpages.currentpage();
        system.debug(attachDoc);
        if( attachDoc.size() >0 )
        {
            pageRef = new PageReference('/servlet/servlet.FileDownload?file='+attachDoc[0].Id);
            return pageRef; 
        }
        return pageRef;
    }
    
    public PageReference ImageDwld(){
        String proId = Apexpages.currentpage().getParameters().get('proId');
        system.debug('proId-->'+ proId );
        List<Attachment> attachDoc = [SELECT Id, Name, ContentType, ParentId FROM Attachment where ParentId =:proId  and ContentType  like 'image/%' LIMIT 1];
        PageReference pageRef = Apexpages.currentpage();
        system.debug(attachDoc);
        if( attachDoc.size() >0 )
        {
            pageRef = new PageReference('/servlet/servlet.FileDownload?file='+attachDoc[0].Id);
            return pageRef; 
        }
        return pageRef;
    }
    
    public class ProductMMWrapper{
        public String materialNumber{get;set;}
        public String plant{get;set;}
        public String storageLocation{get;set;}
        public String purchaseGroup{get;set;}
        public String UnitofMeasure{get;set;}
        public String MaterialDescription{get;set;}
        public String MaterialGroup{get;set;}
        public String ECOMMaterial{get;set;}
        public String ProfitCenter{get;set;}
        public String ControlCode{get;set;}
        public String ProductHierarchy{get;set;}
        //public List<TaneiraPO__c> taneiraPO{get;set;}
         public List<RtwPO__c> rtwPO{get;set;}
        public RTW_Product__c prod{get;set;}
        public Map<String,String> productTypeCode{get;set;}
        public Map<String,String> productHie{get;set;}
        public Map<String,String> productHie5{get;set;}
        public Map<String,Master__c> productControlCode{get;set;}
        public Map<String,String> productUnitMeasure{get;set;}
        public string cellHighlight{get;set;}
        public string cellHighlightHierarchy{get;set;}
        //public boolean conditionsMet{get;set;}
        
        public ProductMMWrapper(RTW_Product__c product,List<RtwPO__c>rtPO,  Map<String,String> prodType, Map<String,String> prodHie, Map<String,String> prodHie5, Map<String,Master__c> prodControlCode, Map<String,String> prodUnitMeasure){
            prod = new RTW_Product__c();
            prod = product;
            rtwPO =  new List<RtwPO__c>();
            //taneiraPO = new List<TaneiraPO__c>();
            productTypeCode = new Map<String,String>();
            productHie = new Map<String,String>();
            productHie5 = new Map<String,String>();
            productControlCode = new Map<String,Master__c>();
            productUnitMeasure = new Map<String,String>();
            //taneiraPO = tanePO;
            RtwPo = rtPO;
            productTypeCode = prodType;
            productHie = prodHie;
            productHie5 = prodHie5;
            productControlCode = prodControlCode;
            productUnitMeasure = prodUnitMeasure;
            this.materialNumber = prod.SKU__c;
            this.plant = rtwPO[0].Name;
            this.storageLocation = rtwPO[0].Storage_Location__c;
            this.purchaseGroup = rtwPO[0].Purchase_Group__c;
            this.MaterialGroup= prod.Product__c;
            this.ECOMMaterial= prod.E_Com_Material__c;
            this.ProfitCenter= rtwPO[0].Profit_Center__c;
            
            if(prod.Product__c== null && prod.Product__c== ''){
                cellHighlight = 'red';
                cellHighlightHierarchy = 'red';
                system.debug('inside 1');
                system.debug('cellHighlight----' + cellHighlight);
                system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
            }
            if((prod.Product__c!= null && prod.Product__c!= '') && (prod.Product__c== 'BLOUSE' || prod.Product__c== 'Lehnga')){
                String des= '';
                String data = '';
                //conditionsMet = true;
                if(prod.Product__c.length()>=1){
                    data   = prod.Product__c.toUpperCase();
                    des = des + prod.Product__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_Product_Type__c));
                    system.debug('inside 2');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Warp__c!= null && prod.Warp__c!= ''){
                    if(prod.Warp__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)){
                        des = des + '-' + prod.Warp__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)).trim();
                        system.debug('inside 3');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                    if(prod.Warp__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)){
                        des = des + '-' + prod.Warp__c.trim();
                        system.debug('inside 4');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    } 
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside 5');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                //    conditionsMet = false;
                }
                
                if(prod.Weft__c!= null && prod.Weft__c!= ''){
                    if(prod.Weft__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)){
                        des = des + '-' + prod.Weft__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)).trim();
                        system.debug('inside 6');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                    if(prod.Weft__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)){
                        des = des + '-' + prod.Weft__c.trim();
                        system.debug('inside 7');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside 8');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                //    conditionsMet = false;
                }
                
                if(prod.Craft__c!= null && prod.Craft__c!= ''){
                    //System.debug('prod---->'+prod);
                    //System.debug('prodCraft__c---->'+prod.Craft__c);
                    //System.debug('prodCraft__c---->'+Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c));
                    
                    if(prod.Craft__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                        des = des + '-' + prod.Craft__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)).trim();
                        system.debug('inside 9');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                    if(prod.Craft__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                        des = des + '-' + prod.Craft__c.trim();
                        system.debug('inside 10');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside 11');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                //    conditionsMet = false;
                }
                
                if(prod.Base_Colour__c!= null && prod.Base_Colour__c!= ''){
                    if(prod.Base_Colour__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).number_of_letters_for_Base_color__c)){
                        des = des + '-' + prod.Base_Colour__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).number_of_letters_for_Base_color__c)).trim();
                        system.debug('inside 12');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                    if(prod.Base_Colour__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).number_of_letters_for_Base_color__c)){
                        des = des + '-' + prod.Base_Colour__c.trim();
                        system.debug('inside 13');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                    }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside 14');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                //    conditionsMet = false;
                }
                
                if(prod.RTW_SIZE__c!= null && prod.RTW_SIZE__c!= ''){
                    des = des + '-' + prod.RTW_SIZE__c.trim();
                    system.debug('inside 15');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside 16');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                  //  conditionsMet = false;
                }
                system.debug('inside 17');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                this.MaterialDescription = des;
            }
            
            if((prod.Product__c!= null) && (prod.Product__c== 'JACKET' || prod.Product__c== 'TROUSER' || prod.Product__c== 'KURTA SET' || prod.Product__c== 'SHORT TOP' || prod.Product__c== 'TUNIC' || prod.Product__c== 'DRESS' || prod.Product__c== 'KURTA' || prod.Product__c== 'MASK')){
                String des= '';
                String data = '';
                if(prod.Product__c.length()>=1){
                    data   = prod.Product__c.toUpperCase();
                }
                if(productTypeCode!= null && productTypeCode.containsKey(data)){
                    des = des + productTypeCode.get(data);
                    system.debug('inside description 1');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside description 2');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.MFabric__c!= null && prod.MFabric__c!= ''){
                   // system.debug('Fabric length-----' + prod.MFabric__c.length());
                if(prod.MFabric__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_fabric__c)){
                   // system.debug('Number-----' + Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_fabric__c));
                    des = des + '-' + prod.MFabric__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_fabric__c)).trim();
                    system.debug('inside description 3');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.MFabric__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_fabric__c)){
                    des = des + '-' + prod.MFabric__c.trim();
                    system.debug('inside description 4');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                  }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside description 5');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Craft__c!= null && prod.Craft__c!= ''){
                if(prod.Craft__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                    des = des + '-' + prod.Craft__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)).trim();
                    system.debug('inside description 6');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Craft__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                    des = des + '-' + prod.Craft__c.trim();
                    system.debug('inside description 7');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                  }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside description 8');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Base_Colour__c!= null && prod.Base_Colour__c!= ''){
                if(prod.Base_Colour__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).number_of_letters_for_Base_color__c)){
                    des = des + '-' + prod.Base_Colour__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).number_of_letters_for_Base_color__c)).trim();
                    system.debug('inside description 9');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Base_Colour__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).number_of_letters_for_Base_color__c)){
                    des = des + '-' + prod.Base_Colour__c.trim();
                    system.debug('inside description 10');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                  }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside description 11');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Season__c!= null && prod.Season__c!= ''){
                if(prod.Season__c.length()>= Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_Season__c)){
                    des = des + '-' + prod.Season__c.substring(0,Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_Season__c)).trim();
                    system.debug('inside description 12');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Season__c.length()< Integer.valueOf(RTW_Product_Description__c.getValues(data).Number_of_letters_for_Season__c)){
                    des = des + '-' + prod.Season__c.trim();
                    system.debug('inside description 13');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                  }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside description 14');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.RTW_SIZE__c!= null && prod.RTW_SIZE__c!= ''){
                    des = des + '-' + prod.RTW_SIZE__c.trim();
                    system.debug('inside description 15');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside description 16');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                system.debug('inside description 17');
                        system.debug('cellHighlight----' + cellHighlight);
                        system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                this.MaterialDescription = des;
            }
            
            if((prod.Product__c!= null && prod.Product__c!= '') && (prod.Product__c== 'BLOUSE' || prod.Product__c== 'Lehnga')){
                String hie= 'TA';
                if((productHie!= null) && (productHie.containsKey('Blouse') || productHie.containsKey('Lehnga'))){
                if(prod.Product__c== 'BLOUSE'){
                    hie = hie + productHie.get('Blouse');
                    system.debug('inside hierarchy 1');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Product__c== 'Lehnga'){
                    hie = hie + productHie.get('Lehnga');
                    system.debug('inside hierarchy 2');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                  }
                }
                else{
                    cellHighlight = 'red';
                    system.debug('inside hierarchy 3');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                if(prod.Blouse_Type__c!= null && prod.Blouse_Type__c!= ''){
                    hie = hie + Taneira_Blouse_Type__c.getValues(prod.Blouse_Type__c).Code__c;
                    system.debug('inside hierarchy 4');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                else{
                    cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 5');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                system.debug('inside hierarchy 6');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                hie = hie + '00009999TAL';
                this.ProductHierarchy = hie;
            }
            if((prod.Product__c!= null && prod.Product__c!= '') && (prod.Product__c== 'JACKET' || prod.Product__c== 'TROUSER' || prod.Product__c== 'KURTA SET' || prod.Product__c== 'SHORT TOP' || prod.Product__c== 'TUNIC' || prod.Product__c== 'DRESS' || prod.Product__c== 'KURTA')){
                String hie= 'TA';
                if(productHie5!= null && productHie5.containsKey(prod.Product__c)){
                    hie = hie + productHie5.get(prod.Product__c);
                    system.debug('inside hierarchy 1');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                else{
                    cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 2');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                system.debug('inside hierarchy 3');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                hie = hie + '00009999TAL';
                this.ProductHierarchy = hie;
            }
            
            if(prod.Product__c!= null && prod.Product__c!= '' && prod.Product__c== 'MASK'){
                String hie= 'TA';
                if(productHie5!= null && productHie5.containsKey(prod.Product__c)){
                    hie = hie + productHie5.get(prod.Product__c);
                    system.debug('inside hierarchy 1');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                else{
                     cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 2');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                }
                system.debug('inside hierarchy 3');
                    system.debug('cellHighlight----' + cellHighlight);
                    system.debug('cellHighlightHierarchy----' + cellHighlightHierarchy);
                hie = hie + '00009999TAU';
                this.ProductHierarchy = hie;
            }
            
            if(ProductHierarchy!= null && ProductHierarchy!= '' && productControlCode!= null){
                if(productControlCode.containsKey(ProductHierarchy.substring(2,7)) && prod.MRP_Pc__c!= null && prod.MRP_Pc__c>=1000){
                    if(productControlCode.get(ProductHierarchy.substring(2,7)).Active__c== true){
                    this.ControlCode = productControlCode.get(ProductHierarchy.substring(2,7)).X8Digit_Code__c;
                    }
                }
            }
            if(ProductHierarchy!= null && ProductHierarchy!= ''  && productControlCode!= null){
                if(productControlCode.containsKey(ProductHierarchy.substring(2,7)) && prod.MRP_Pc__c!= null && prod.MRP_Pc__c<1000){
                    if(productControlCode.get(ProductHierarchy.substring(2,7)).Active__c== true){
                    this.ControlCode = productControlCode.get(ProductHierarchy.substring(2,7)).X6Digit_Code__c;
                    }
                }
            }
            
            if((prod.Product__c!= null && prod.Product__c!= '') && (prod.Product__c== 'BLOUSE' || prod.Product__c== 'Lehnga')){
                if(prod.Product__c== 'BLOUSE' && productUnitMeasure!= null && productUnitMeasure.containsKey('Blouse')){
                    this.UnitofMeasure = productUnitMeasure.get('Blouse');
                }
                if(prod.Product__c== 'Lehnga' && productUnitMeasure!= null && productUnitMeasure.containsKey('Lehnga')){
                    this.UnitofMeasure = productUnitMeasure.get('Lehnga');
                }
            }
            if((prod.Product__c!= null && prod.Product__c!= '') && (prod.Product__c== 'JACKET' || prod.Product__c== 'TROUSER' || prod.Product__c== 'KURTA SET' || prod.Product__c== 'SHORT TOP' || prod.Product__c== 'TUNIC' || prod.Product__c== 'DRESS' || prod.Product__c== 'KURTA' || prod.Product__c== 'MASK' || prod.Product__c== 'SLIP')){
                if(productUnitMeasure!= null && productUnitMeasure.containsKey(prod.Product__c)){
                    this.UnitofMeasure = productUnitMeasure.get(prod.Product__c);
                }
            }
        }
    }
    
    
}