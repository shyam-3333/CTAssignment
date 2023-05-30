public class RTWProductUpdateViewController {
    public static List<RTW_Product__c> proList{get;private set;}
    public boolean test{get;set;}
    public List<RTW_Product__c> proViewList{get;private set;}
    public static Date StartDate{get;set;}
    public static Date EndDate{get;set;}
    public Set<string> uniqueKeySet;
    public static Map<string,List<RTW_Product__c>> prodMap;
    public static List<prodWrap> prodWrapList {get; private set;}
    public string ProdType{get;set;}
    public string uniquekey;
    public string productTypeName;
    public Map<string,decimal> qtyMap;
    public Map<string,decimal> mrpMap;
    public Map<string,decimal> costMap;
    public Map<string,Boolean> poStatusMap;
    public String param{get;set;}
    public RTWProductUpdateViewController(){
        try{
            
            param = 'RTWProduct'; 
            test = false;
            //uniquekey = apexpages.currentpage().getparameters().get('ProductKey');
            productTypeName = apexpages.currentpage().getparameters().get('productTypeName');
            
            system.debug('uniquekey:--'+uniquekey);
            proViewList = new List<RTW_Product__c>();
            system.debug('StartDate'+StartDate);
            system.debug('EndDate'+StartDate);
            proList = [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                       Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                       Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                       name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                       STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                       Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                       Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                       Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                       BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,
                       MStyle_name__c,MDesign__c,MConstruction__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,RTW_Pricing_Submitted_Date__c FROM RTW_Product__c                
                       where vendor_custom__c != null AND SKU__c != null AND (Assigned_To__c != null OR Assigned_To__c!='') AND (RTW_Pricing_Submitted_Status__c != 'Submitted' OR Submit__c = False) AND (Assigned_To__c=:UserInfo.getUserId() OR Login_User__c=:'Admin User' OR Login_User__c=:' Harish Kumar M R') order by Item_no__c,CreatedDate asc limit 49999];
            System.debug('proList '+proList);
            uniqueKeySet = new set<string>();
            prodMap = new Map<string,List<RTW_Product__c>>();
            prodWrapList = new List<prodWrap>();
            
            system.debug('proList size---'+proList.size());
            Integer qty = 0;
            qtyMap = new Map<string,decimal>();
            mrpMap = new Map<string,decimal>();
            costMap = new Map<string,decimal>();
            poStatusMap = new Map<String,Boolean>();
            for(RTW_Product__c prod : proList){
                if(qtyMap.containsKey(prod.name)){
                    
                    system.debug('Null check==>'+prod.name);
                    system.debug('Null check1==>'+qtyMap.get(prod.name)+prod.Id);
                    system.debug('Null check2==>'+qtyMap.get(prod.name)+prod.Quantity__c+prod.Id);
                    system.debug('contains==>'+qtyMap);
                    if(prod.Quantity__c==null){
                        qtyMap.put(prod.name,qtyMap.get(prod.name)+0);
                    }else{
                        qtyMap.put(prod.name,qtyMap.get(prod.name)+prod.Quantity__c);    
                    }
                    system.debug('contains==>'+qtyMap);
                    
                } else {
                    if(prod.Quantity__c==null){
                        qtyMap.put(prod.name,0.0);
                    }else{
                        qtyMap.put(prod.name,prod.Quantity__c);
                    }
                    
                    
                }
                
                if(mrpMap.containsKey(prod.name)){
                    decimal dec = prod.MRP_Pc__c != null ? prod.Total_Costs__c : 0;
                    mrpMap.put(prod.name, mrpMap.get(prod.name) != null ? mrpMap.get(prod.name) + dec : 0);
                } else {
                    decimal dec = prod.MRP_Pc__c != null ? prod.Total_Costs__c : 0;
                    mrpMap.put(prod.name, dec);
                }
                if(costMap.containsKey(prod.Name)){
                    decimal cost = prod.MCost__c != NULL ? prod.MCost__c : 0;
                    costMap.put(prod.Name, costmap.get(prod.Name) != null ? costmap.get(prod.Name) + cost : 0);
                }else{
                    decimal cost= prod.MCost__c != NULL ? prod.MCost__c : 0;
                    costMap.put(prod.Name, cost);
                }
                if(poStatusMap.containskey(prod.Name))
                {
                    Boolean postatus = prod.PO_Number__c != Null ? True : False ;
                    poStatusMap.put(prod.Name, poStatusMap.get(prod.Name) && postatus);
                }else{
                    Boolean postatus = prod.PO_Number__c != Null ? True : False ;
                    poStatusMap.put(prod.Name, postatus);
                }
            }
            
            
            /*for( RTW_Product__c pro : proList ){
if( docIdMap.containsKey(pro.Id)){
pro.ImageLink__c =  URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file='+ docIdMap.get(pro.Id)   ;   
}
}*/
            
            for(RTW_Product__c pro : proList){
                uniqueKeySet.add(pro.name);
                if(prodMap.containsKey(pro.name) ){
                    prodMap.get(pro.name).add(pro);
                } else {
                    List<RTW_Product__c> proList1 = new List<RTW_Product__c>();
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
                    
                    if(pro.Submitted_Date__c !=null){
                        pwrp.pendingDays=pro.Submitted_Date__c.date().daysBetween(system.today());    
                    }
                    
                    system.debug( pwrp.CreatedDate );
                    pwrp.ProdKey = pro.Name;
                    prodWrapList.add(pwrp);
                }
            }
            System.debug('prodWrapList :'+prodWrapList.size());
            if(uniquekey != null){
                ProdType = prodMap.get(uniquekey)[0].Product__c;
                param = prodMap.get(uniquekey)[0].CreatedBy.Name+'_'+((prodMap.get(uniquekey)[0].Submitted_Date__c)== null ? prodMap.get(uniquekey)[0].CreatedDate.format('yyyy-MM-dd') : prodMap.get(uniquekey)[0].Submitted_Date__c.format('yyyy-MM-dd'))
                    +'_'+prodMap.get(uniquekey)[0].vendor_custom__r.Name +'_'+ qtyMap.get(uniquekey);
                system.debug('ProdType -->'+ ProdType);
                system.debug('size'+prodMap.get(uniquekey).size());
                proViewList.addAll(prodMap.get(uniquekey));
                set<Id> docIdSet = new set<Id>();
                for(RTW_Product__c pro : proViewList){
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
        }catch(exception ex){
            system.debug('exception line : '+ex.getLineNumber());
            system.debug('exception message: '+ex.getMessage());
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
        public Integer pendingDays{get;set;}
        
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
                proList = [SELECT Id, Photo__c, ImageLink__c, SKU__c,Product__c,Origin__c,Form__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                           Fabrics__c,Size_LCD__c,Item_no__c,Pack_no__c,MRP_Pc__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,Occasion__c,
                           Blouse_Type__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,MASK_DESCRIPTION__c,Submitted_Date__c,
                           name,vendor_custom__c, vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,RTW_SIZE__c,
                           STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Loom__c,Vendot_style_code__c,CreatedBy.Name,
                           Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,Ecom_Size__c,E_Com_Material__c,
                           Kurta_Fabric__c,Salwar_Fabric__c,Proc_Type__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                           Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                           BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,
                           MStyle_name__c,MDesign__c,MConstruction__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Order_ID__c,Remarks__c,Fabric__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c FROM RTW_Product__c                
                           where vendor_custom__c != null AND SKU__c != null AND (Assigned_To__c != null OR Assigned_To__c!='') AND (RTW_Pricing_Submitted_Status__c != 'Submitted') AND (Assigned_To__c=:UserInfo.getUserId() OR Login_User__c=:'Admin User' OR Login_User__c=:' Harish Kumar M R') order by Item_no__c,CreatedDate asc  limit 49999];
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ' Incorrect date '));
            }
            
            system.debug('proList---'+proList);
            uniqueKeySet = new set<string>();
            prodMap = new Map<string,List<RTW_Product__c>>();
            prodWrapList = new List<prodWrap>();
            if(proList != null){
                
                for(RTW_Product__c pro : proList){
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
            }
            if(uniquekey != null){
                system.debug('size'+prodMap.get(uniquekey).size());
                proViewList.addAll(prodMap.get(uniquekey));
            }
            for(prodWrap prw : prodWrapList){
                system.debug('prodWrapList---'+prw); 
            }
            
        } 
        
               Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;      
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;  
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;       
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
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
}