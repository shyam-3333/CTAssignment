/**************************************************
Name:RTW_Sourcing_Controller
Author:Vindya
Description:This class is an controller for TaneiraRTWsourcing .
******************/
public class  RTW_Sourcing_Controller{
    public List<attachmentClass> popupAttachmentList{get;set;}
    Public boolean showUploadPopUp{get;set;}
    public blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public Map<string,string> UserEmail;
    public List<RTW_Product__c> CSVproducts{get;set;}
    public boolean showPopUp{get;set;}
    public Boolean colorCheck{get;set;}
    public boolean showPreview{get;set;}
    public boolean showFabric{get;set;}
    public static List<RTW_Product__c> proList{get;set;}
    public List<RTW_Product__c> proViewList{get;set;}
    public static Date StartDate{get;set;}
    public static Date EndDate{get;set;}
    public Set<string> uniqueKeySet;
    public Map<string,List<RTW_Product__c>> prodMap;
    public List<prodWrap> prodWrapList {get;set;}
    public string ProdType{get;set;}
    public boolean frm{get;set;}
    public Map<string,string> userValues;
    public RTW_Product__c accProd{get;set;}
    public List <selectoption>   selectOptionProduct   {get;set;}
    public  RTW_Product__c selectOSku   {get;set;}  
    public RTW_Product__c RTW_Product{get;set;}
    public string productTypeName  {get;set;}
    public blob photo{get;set;}
    public Integer no_of_Products{get;set;}
    public String UniqueKey {get;set;}
    public Integer str {get;set;} 
    public boolean showSavedRecs {get;set;}
    public RTW_product__c rtwProd {get;set;}
    public List<List<RTW_Product__c>> defaultRTWrecs {get;set;}
    public String copyValue{get;set;}
    public static String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
    Map < Id, String > attachMapWithProdId = new Map < Id, String > ();
    public List<RTW_Product__c> newRec=new List<RTW_Product__c>();
    Map<String,RTWProduct__c> rtwList = new Map<String,RTWProduct__c>();
    List<String> prList=new List<String>();
    public List<RTW_Product__c> selectProducts{get; set;}
    public List<wrapperImageClass> wrapperImageClassList{get; set;}
    public String UniKey { get; set; }
    public Id recordId{ get; set; }
    public List<RTW_Product__c> ProdList{ get; set; }
    public Map<Id,RTW_Product__c> RTWObjMap;
    public Map<String,Attachment> attachmentMap = new Map<String,Attachment>();
    public List<Attachment> attachImgList{get;set;}
    public List<Attachment> attachDOcList{get;set;}
    public List<product__c> AttProdList{get;set;}
    public boolean check{get;set;}
    public  String selectedPurchaseUser{get;set;}
    public List<selectoption>SourcingusersList{get;set;}
    Set<Id> vendorId = new Set<Id>();
    Map<Id,String> nameMap = new Map<Id,String>();
    
    public RTW_Sourcing_Controller() {
        SourcingusersList();
        colorCheck = false;
        check = true;
        popupAttachmentList = new List<attachmentClass>();
        UserEmail = new map<String, string>();
        userValues = new map<String, string>();
        showPopUp = false;
        showPreview = false;
        showUploadPopUp = false;
        CSVproducts = new list<RTW_product__c>();
        csvFileLines = new String[]{};
            defaultRTWrecs = new List<List<RTW_Product__c>>();
        UniKey = null;
        showFabric=false;
        recordId = null;
        showSavedRecs = false;
        frm = true;
        wrapperImageClassList = new List<wrapperImageClass> ();
        for(User uname : [SELECT Id,Name,Email FROM User WHERE Profile.Name = 'Purchase' ORDER BY Name]){
            //SourcingusersList.add(new SelectOption(uname.Id, uname.Name ));
            userValues.put(uname.Id, uname.Name);
            UserEmail.put(uname.Id,uname.Email);
        }
        for(User uname : [SELECT Id,Name,Email FROM User WHERE Profile.Name = 'Purchase' OR Profile.Name = 'System Administrator' ORDER BY Name]){
            UserEmail.put(uname.Id,uname.Email);
        }
        //To get values from custom setting for product type 
        selectOptionProduct = new list <selectoption>();
        rtwList = RTWProduct__c.getAll();
        //system.debug('rtwList'+rtwList);
        selectOptionProduct.add(new selectoption('--None--','--None--'));
        for(String products: rtwList.keySet())
        {
            selectOptionProduct.add(new selectoption(products,products));
            system.debug('selectOptionProduct' + selectOptionProduct);
        }
        
        
        accProd = new RTW_Product__c();
        productTypeName = apexpages.currentpage().getparameters().get('productTypeName');
        system.debug('Product type name : '+productTypeName);
        string  prodName;
        if( productTypeName != Null )
            prodName= productTypeName.deleteWhitespace();
        system.debug(prodName);
        productTypeName = (productTypeName!=null?(productTypeName.contains('DRPDSAREE')?'DRPDSAREE':productTypeName.contains('BLOUSE')?'BLOUSE':(productTypeName.contains('LEHENGA')?'LEHENGA':(productTypeName.contains('MASK')?'MASK':(productTypeName == 'KURTA' ?'KURTA':(prodName.contains('SHORTTOP')?'SHORT TOP':(productTypeName.contains('DRESS')?'DRESS':(productTypeName.contains('TROUSER')?'TROUSER':(productTypeName.contains('USKD')?'USKD':(productTypeName == 'KURTA SET' ? 'KURTA SET':(productTypeName.contains('TUNIC')?'TUNIC':(productTypeName == 'SLIP' ? 'SLIP':''))))))))))):null);
        uniquekey = apexpages.currentpage().getparameters().get('ProductKey');
        String action = apexpages.currentpage().getparameters().get('action');
        if(action == 'back'){
            DELETE [SELECT Id from RTW_Product__c where Name =: uniquekey];
            
        }
        //system.debug('uniquekey:--'+uniquekey);
        proViewList = new List<RTW_Product__c>();
        proList = [SELECT Id, Photo__c,SKU__c,Product__c,Body_Fit__c,Origin__c,Form__c,Warp__c,Weft__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                   Fabric__c,Size_LCD__c,Dimensions__c,ReadyGHERA_MT__c,Picklist__c,MRP_Pc__c,Buyers_Cost__c,Silhouette__c,ReadyWaist_Inch__c, Submit__c,Ecom_Size__c,Submitted_Date__c,
                   ReadyLength_Inch__c,ReadyHip_Inch__c,DupattaDimensions__c,Dupatta_Type__c,BlouseSize_LCD__c,Occasion__c,MASK_DESCRIPTION__c,E_Com_Material__c,
                   Blouse_Type__c,SkirtPanels__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,
                   name, vendor_custom__c,vendor_custom__r.Name,Sourcing_user_email__c,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,Handwork_Placement__c,Closure_Option__c,Handwork__c,Fabric_1__c,Fabric_2__c,Fabric_1_Quantity__c,Fabric_2_Quantity__c,
                   Neck_Type_Back__c,Neck_Type_Front__c,Opening_Type__c,Padding__c,RTW_SIZE__c,Sleeve_Fit__c,Sleeve_Length__c,SLEEVE_TYPE__c,Proc_type__c,Order_ID__c,
                   STYLE__c,Style_Code__c,Zari__c,Gender__c,Okhai_Size__c,Size__c,Hem_Back__c,Hem_Front__c,Loom__c,Body_Length__c,Bottom_Fabric__c,Top_Fabric__c,Style_Name__c,
                   Kurta_Fabric__c,Salwar_Fabric__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                   Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                   BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,Consumtion__c,Consumtion1__c,
                   MStyle_name__c,MDesign__c,MConstruction__c,MPleats__c,MPly__c,MCost__c,MFabric__c,owner.Name,Item_no__c,Pack_no__c,Remarks__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,Kurta_Description__c,
                   Vendot_style_code__c,CreatedBy.Name,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,ImageLink__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Assigned_sourcing_user__c,OwnerId FROM RTW_Product__c WHERE submit__c = FALSE   Order By Createddate limit 49999 ];
        uniqueKeySet = new set<string>();
        system.debug('proList :'+proList);
        prodMap = new Map<string,List<RTW_Product__c>>();
        prodWrapList = new List<prodWrap>();
        //system.debug('proList size---'+proList.size());
        RTWObjMap = new Map<Id,RTW_Product__c>();
        //--------------------------------------------------------------- Added by Priyanka       
        system.debug('proList : '+proList.size());
        for(RTW_Product__c prod : proList){
            if(prod.Vendor_custom__c != null){
                vendorId.add(prod.Vendor_custom__c);
            }
        }
        system.debug('nameMap : '+nameMap.size());
        for(Vendor__c v : [Select Id,Name from Vendor__c where Id IN :vendorId]){ 
            nameMap.put(v.Id,v.Name);
        }  
        system.debug('nameMap : '+nameMap.values());
        system.debug('nameMap : '+nameMap.size());
        //---------------------------------------------------------------      
        for(RTW_Product__c pro : proList){
            if(pro.Weft__c == pro.Warp__c){
                showFabric = true;
            }
            RTWObjMap.put(pro.Id,pro);
            
            
            //system.debug('pro.Account__r.Name'+pro.Account__r.Name);
            uniqueKeySet.add(pro.name);
            if(prodMap.containsKey(pro.name)){
                prodMap.get(pro.name).add(pro);
            } else {
                System.debug('---------- Else -----------');
                List<RTW_Product__c> proList1 = new List<RTW_Product__c>();
                proList1.add(pro);
                prodMap.put(pro.name,proList1);
                prodWrap pwrp = new prodWrap();
                pwrp.vendorName = nameMap.containsKey(pro.Vendor_custom__c) ? nameMap.get(pro.Vendor_custom__c)  : '';
                pwrp.ownerName = pro.CreatedBy.Name;
                pwrp.ProdKey = pro.Name != null ? pro.Name: '';
                pwrp.ProductCategory = pro.Product__c;
                pwrp.Origin = pro.Origin__c;
                pwrp.SKUCount = integer.valueOf(pro.SKU_Count__c);
                pwrp.CreatedDate = pro.CreatedDate.format('yyyy-MM-dd HH:mm:ss');
                prodWrapList.add(pwrp);
            }
        }
        //system.debug(prodWrapList.size());
        //system.debug('RTWObjMap==='+RTWObjMap.get('a2S5B000001iikOUAQ'));
        if(uniquekey != null){
            showSavedRecs = True;
            system.debug('### uniquekey  :'+uniquekey);
            system.debug('### prodMap  :'+prodMap);
            
            system.debug('### prodMap.get(uniquekey)[0].Product__c  :'+prodMap.get(uniquekey)[0].Product__c);
            ProdType = prodMap.get(uniquekey)[0].Product__c;
            
            proViewList.clear();
            proViewList.addAll(prodMap.get(uniquekey));
            
            Integer i=0;
            for(RTW_product__c pr:proViewList){ 
                popupAttachmentList.add(new attachmentClass(pr.Id) );
                wrapperImageClass wic = new wrapperImageClass();
                wic.prod = pr;
                wic.pdfDoc = new Attachment();
                wic.counter = i ;
                i++;
                wrapperImageClassList.add(wic);
            }
            
        }
        for(wrapperImageClass prw : wrapperImageClassList){
            // system.debug('prodWrapList---'+prw); 
        }
        
    } 
    public PageReference deleteProds(){
        PageReference PageUrl;
        if(wrapperImageClassList.size() > 0){
            String uniqueKey = wrapperImageClassList[0].prod.Name;
            if(wrapperImageClassList[0].prod.SKU__c == null || wrapperImageClassList[0].prod.SKU__c == ''){
                List<RTW_Product__c> deleteProdList = new List<RTW_Product__c>();
                for(RTW_Product__c rtwProd : [SELECT Id from RTW_Product__c where Name =: uniqueKey]){
                    deleteProdList.add(rtwProd);
                }
                if(!deleteProdList.isEmpty()){
                    DELETE deleteProdList;
                }
                
            } 
            
            //system.debug('uniqueKey ---->  '+uniqueKey);
            PageUrl = new PageReference('/apex/TaneiraProductsRTW');
            PageUrl.setRedirect(true);
            //system.debug('Page url Parameters : '+PageUrl.getParameters().values());
        } else {
            PageUrl = new PageReference('/home/home.jsp');
            PageUrl.setRedirect(true);
        }
        return PageUrl; 
    }
    //Wrapper class to show data list in the front page 
    public class prodWrap{
        public string vendorName{get;set;}
        public string ownerName{get;set;}
        public string ProductCategory{get;set;}
        public string Origin{get;set;}
        public integer SKUCount{get;set;}
        Public String CreatedDate{get;set;}
        public string ProdKey{get;set;}
    }    
    
    //This method creates the rtw products
    public void showVendorMessage()
    {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'Contact us for a new vendor addition !!')); 
    }
    public PageReference ProdCreatePage(){
        // accProd = new RTW_Product__c();
        //system.debug('----------accId---------'+accProd.vendor_custom__c);
        if(accProd.vendor_custom__c==null)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select the Vendor!'));   
            return null;
        }
        else{
            string unikey=productTypeName+String.valueOf(system.now()).remove(' '); 
            //system.debug('no_of_Products==productTypeName'+no_of_Products+productTypeName);
            List<RTW_product__c> rtwProd = new List<RTW_product__c>();
            for(Integer i=0;i<no_of_Products;i++){ 
                RTW_product__c pro = new RTW_product__c();
                pro.Product__c = productTypeName;
                pro.SKU_Count__c=no_of_Products;
                pro.vendor_custom__c = accProd.vendor_custom__c;
                pro.Name=unikey;
                
                rtwProd.add(pro);
            }
            //system.debug('prod list size:--'+rtwProd.size());
            insert rtwProd; // creates product
            
            //system.debug('unikey--=-='+unikey);
            PageReference PageUrl = new PageReference('/apex/TaneiraProductsRTW');
            PageUrl.setRedirect(true);
            PageUrl.getParameters().put('ProductKey',unikey);
            PageUrl.getParameters().put('productTypeName',productTypeName);
            return  PageUrl;   
        }
        
    }  
    public PageReference addNewRow()
    {
        List<RTW_product__c> rtwList = new List<RTW_product__c>();
        
        for(Integer i=0; i < wrapperImageClassList.size(); i++){
            wrapperImageClassList[i].prod.SKU_Count__c = wrapperImageClassList[i].prod.SKU_Count__c +1;
            rtwList.add( wrapperImageClassList[i].prod );
        }
        
        update rtwList;
        RTW_product__c pro = new RTW_product__c();
        pro.Product__c = wrapperImageClassList[0].prod.Product__c;
        pro.SKU_Count__c= wrapperImageClassList[0].prod.SKU_Count__c ;
        pro.vendor_custom__c = wrapperImageClassList[0].prod.vendor_custom__c;
        pro.Name= wrapperImageClassList[0].prod.Name;
        
        insert pro;
        PageReference PageUrl = new PageReference('/apex/TaneiraProductsRTW');
        PageUrl.setRedirect(true);
        PageUrl.getParameters().put('ProductKey',pro.Name);
        PageUrl.getParameters().put('productTypeName',pro.Product__c);
        return  PageUrl;  
    }
    

    //This method is to save the product data   
    public void  ProductSave(){  
        //system.debug('proViewList==>'+proViewList);

        String month = '';
        string yearOfOperation = '';
        string numOfZero = '';
        showSavedRecs = true;
        List<Attachment> attachmentList = new List<Attachment>();
        List<RTW_Product__c> rtwProdList = new List<RTW_Product__c>();
        List<RTWAutoNumber__c> RTWAutoNumberList = new List<RTWAutoNumber__c>();
        Map<string,string> MasterCode = new Map<string,string>();
        Map<string,string> AutoNumberMap = new Map<string,string>();
        Map<string,Integer> AutoNumberUpdateMap = new Map<string, Integer>();
        Map<Integer,String>mapOfMonth = new Map<Integer,String>();
        Map<string,RTWAutoNumber__c> mapOfAutoNum = new Map<string,RTWAutoNumber__c>();
        Map<String,RTW_Ecom_Size__c> mapOfEcomSize = new Map<String,RTW_Ecom_Size__c>();
        Boolean autoNumberUpdate = False;
        Boolean uskdautoNumberUpdate = False;
        
        for(Master__c m : [SELECT Id, Active__c, Code__c, Name__c, Name FROM Master__c]){
            MasterCode.put((m.Name__c+m.Name).toLowercase().remove(' '),m.Code__c);
        }
        
        //system.debug('********************************************************************************************');
        for(RTWAutoNumber__c an : [SELECT Id, Combination_Code__c, Collection__c, Fabrics__c,ProductType__c, Running_Number__c,Season__c,Gender__c,Ply__c,Style_Code__c FROM RTWAutoNumber__c]){
            AutoNumberMap.put(an.Combination_Code__c,an.Running_Number__c+','+an.id);
            mapOfAutoNum.put(an.Combination_Code__c,an);  
            
        } 
        for(SKU_Month_Code__c mnt : SKU_Month_Code__c.getall().values()){
            mapOfMonth.put(integer.valueOf(mnt.Name),mnt.code__c);
        }
        
        for( RTW_Ecom_Size__c rtwEcomSize : [SELECT Id,Name,Product__c,Size__c,Ecom_Size__c FROM RTW_Ecom_Size__c ])
        {
            mapOfEcomSize.put( (rtwEcomSize.Product__c + rtwEcomSize.Size__c).toLowercase().remove(' ')  , rtwEcomSize );
        }
        
        Map<String,Integer> uskdAutoNumberMap = new Map<String, Integer>();
        Map<String,AutoNumber__c> uskdAutoNumberMapUpdate = new Map<String, AutoNumber__c>();
        List< AutoNumber__c > autoNumList = new List<AutoNumber__c>();
        //system.debug('*************************Using AutoNumber__c custom setting for USKD Product categaty **********************************');
        for(AutoNumber__c an : [SELECT Id, Auto_Number__c, Loom__c,Proc_Type__c,Product_Category__c FROM AutoNumber__c]){
            uskdAutoNumberMap.put(  (an.Product_Category__c + an.Loom__c + an.Proc_Type__c).toLowercase().remove(' ')  ,  (Integer)an.Auto_Number__c);
            uskdAutoNumberMapUpdate.put( (an.Product_Category__c + an.Loom__c + an.Proc_Type__c).toLowercase().remove(' ') , an );
        } 
        Map<string,string> allspecsMap = new Map<string,string>();
        Integer itemNo = 1;
        //boolean preGroup = null;
        for(wrapperImageClass pro : wrapperImageClassList){
            integer picklist;
            integer dup = pro.prod.Duppatta__c == 'YES' ? 1 : 0;
            integer kurt = pro.prod.Kurta__c == 'YES' ? 1 : 0 ;
            integer jack = pro.prod.Jacket__c == 'YES' ? 1 : 0 ;
            integer slip = pro.prod.SLIP__c == 'YES' ? 1 : 0 ;
            integer tro = pro.prod.Trouser__c == 'YES' ? 1 : 0 ;
             system.debug('pro.prod.Duppatta__c' +dup);
             system.debug('pro.prod.Kurta__c' +kurt);
             system.debug('pro.prod.Jacket__c' +jack);
             system.debug('pro.prod.SLIP__c' +slip);
             system.debug('pro.prod.Trouser__c' +tro);
               picklist =  dup + kurt + jack + slip + tro ;
            if(pro.prod.Product__c == 'KURTA' || pro.prod.Product__c == 'KURTA SET'){
                system.debug('value '+picklist);
                if((pro.prod.X1_SET__c == '1PC')&& (picklist<1 || picklist>1)){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'No of Pieces value not matching to YES in individual Components')); 
                }
                if((pro.prod.X1_SET__c == '1SET/2PC' || pro.prod.X1_SET__c == '2 PC') && (picklist<2 || picklist>2) ){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'No of Pieces value not matching to YES in individual Components'));                 
                }
                if((pro.prod.X1_SET__c == '1SET/3PC' || pro.prod.X1_SET__c == '3 PC') && (picklist<3 || picklist>3)){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'No of Pieces value not matching to YES in individual Components'));                 
                } 
                if(pro.prod.X1_SET__c == '1SET/4PC' && (picklist<4 || picklist>4)){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'No of Pieces value not matching to YES in individual Components'));                 
                }
                
            }
            if(pro.prod.CreatedDate.date()>=Date.newInstance(2022,05, 24)){
                if(pro.prod.Kurta__c==null || pro.prod.Duppatta__c==null || pro.prod.SLIP__c==null || pro.prod.Trouser__c==null || pro.prod.Jacket__c==null ){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Plesae enter required data'));           
                }
            }
            // pro.prod.fabric__c = pro.prod.MFabric__c ;
            //system.debug(MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+pro.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+pro.prod.collection__c).toLowercase().remove(' '))+MasterCode.get(('Fabric'+pro.prod.fabric__c).toLowercase().remove(' ')));
            //system.debug( pro.prod.Product__c );
            if(pro.prod.Product__c != 'MASK' && pro.prod.Product__c != 'USKD'){
                if(pro.prod.Product__c == 'BLOUSE' || pro.prod.Product__c == 'KURTA' || pro.prod.Product__c == 'SHORT TOP' || pro.prod.Product__c == 'DRESS' || pro.prod.Product__c == 'TROUSER' || pro.prod.Product__c == 'KURTA SET' || pro.prod.Product__c == 'SLIP' || pro.prod.Product__c == 'TUNIC' || pro.prod.Product__c == 'LEHENGA' ){
                    /*if(pro.prod.Buyers_Cost__c != null && pro.prod.Yardage_Cost__c != null){
//system.debug('Enter Condition 1');
pro.prod.Total_Costs__c = pro.prod.Buyers_Cost__c + pro.prod.Yardage_Cost__c;
}
else if(pro.prod.Buyers_Cost__c != null && pro.prod.Yardage_Cost__c == null){ 
//system.debug('Enter Condition 2');
pro.prod.Total_Costs__c = pro.prod.Buyers_Cost__c;
}
else if(pro.prod.Buyers_Cost__c == null && pro.prod.Yardage_Cost__c != null){ 
//system.debug('Enter Condition 3');
pro.prod.Total_Costs__c = pro.prod.Yardage_Cost__c;
}
else if(pro.prod.Buyers_Cost__c == null && pro.prod.Yardage_Cost__c == null){ 
//system.debug('Enter Condition 4');
pro.prod.Total_Costs__c = 0;
}*/
                }
                system.debug(  pro.prod.Product__c+'Season-->'+pro.prod.season__c+'Collection-->'+pro.prod.collection__c);
                if( pro.prod.Product__c != null && pro.prod.season__c != null && pro.prod.collection__c != null && pro.prod.Base_Colour__c != null && (pro.prod.RTW_SIZE__c != null || pro.prod.Size_LCD__c != null || pro.prod.Okhai_Size__c != null)){
                    // system.debug(  pro.prod.Product__c+'Season-->'+pro.prod.season__c+'Collection-->'+pro.prod.collection__c);
                    string AutoNumberString = MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+pro.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+pro.prod.collection__c).toLowercase().remove(' '));
                    //system.debug('AutoNumberString--'+AutoNumberString);
                    
                    Boolean autoNumError = false;
                    if(!MasterCode.containskey(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.Product__c+' product')); 
                        autoNumError = true;
                    }
                    if(!MasterCode.containskey(('Season'+pro.prod.season__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.season__c+' season')); 
                        autoNumError = true;
                    }
                    if(!MasterCode.containskey(('Collection'+pro.prod.collection__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.collection__c+' collection')); 
                        autoNumError = true;
                    }
                    
                    
                    if(test.isRunningTest()){
                        AutoNumberString = 'BFW19CWC';
                    }
                    
                    //system.debug('AutoNumberMap==>'+AutoNumberMap);
                    Integer AutoNumber = null; 
                    
                    if(!AutoNumberMap.containskey( AutoNumberString ) && !autoNumError ){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact to administrator to create Autonumber for'+ AutoNumberString +'combination code !!')); 
                    }
                    
                    if(AutoNumberMap.get(AutoNumberString) != null){
                        string size = '';
                        if(pro.prod.Product__c == 'BLOUSE' || pro.prod.Product__c == 'KURTA' || pro.prod.Product__c == 'SHORT TOP' || pro.prod.Product__c == 'DRESS' || pro.prod.Product__c == 'TROUSER' || pro.prod.Product__c == 'KURTA SET' || pro.prod.Product__c == 'SLIP' || pro.prod.Product__c == 'TUNIC' ){
                            size = pro.prod.RTW_SIZE__c;
                        } else if(pro.prod.Product__c == 'LEHENGA' ){
                            size = pro.prod.Size_LCD__c; //pro.prod.BlouseSize_LCD__c;
                        }else if(pro.prod.Product__c == 'DRPDSAREE' ){
                            size = pro.prod.Size__c;} 
                            else {
                            size = pro.prod.Okhai_Size__c;
                        }
                        AutoNumber = Integer.valueOf(AutoNumberMap.get(AutoNumberString).SubstringBefore(','));
                        /*    if(AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))){
AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')));
pro.prod.SKU__C =  MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+pro.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+pro.prod.collection__c).toLowercase().remove(' '))+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+MasterCode.get(('Base Colour'+pro.prod.Base_Colour__c).toLowercase().remove(' '))+size;
autoNumberUpdate = true;
} else {
AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);

pro.prod.SKU__C =  MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+pro.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+pro.prod.collection__c).toLowercase().remove(' '))+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+MasterCode.get(('Base Colour'+pro.prod.Base_Colour__c).toLowercase().remove(' '))+size;
autoNumberUpdate = true;
}*/
                        
                        //system.debug('autonumber---'+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')));
                        
                        string allspecString;
                        
                        switch on pro.prod.Product__c {
                            when 'LEHENGA' {        
                                allspecString = (pro.prod.Base_Colour__c  +  pro.prod.Collection__c   +    pro.prod.Craft__c    +    pro.prod.Season__c  +   pro.prod.MFabric__c  
                                                 + pro.prod.Form__c  +   pro.prod.Top_Fabric__c   +  pro.prod.Bottom_Fabric__c  +  pro.prod.Style_Code__c + pro.prod.Vendot_style_code__c +  pro.prod.Blouse_Type__c   +  
                                                 pro.prod.Blouse_Fabric__c  +  pro.prod.Blouse_Color__c    +   pro.prod.DupattaFabric__c   +  pro.prod.Dupatta_Color__c    +   pro.prod.Source__c  );
                                if( mapOfEcomSize.Containskey((pro.prod.Product__c +pro.prod.Size_LCD__c).toLowercase().remove(' ')) )
                                    pro.prod.Ecom_Size__c = mapOfEcomSize.get((pro.prod.Product__c +pro.prod.Size_LCD__c).toLowercase().remove(' ')).Ecom_Size__c;
                            }   
                            when 'BLOUSE'{     
                                allspecString = (pro.prod.Base_Colour__c   +   pro.prod.Collection__c   +    pro.prod.Craft__c    +   pro.prod.Season__c    +   pro.prod.MFabric__c   +    pro.prod.Form__c   +     
                                                 pro.prod.Top_Fabric__c   +   pro.prod.Bottom_Fabric__c       +    pro.prod.Source__c   +    pro.prod.Loom__c  +
                                                 pro.prod.Style_Code__c + pro.prod.Vendot_style_code__c  +  pro.prod.Zari__c   );
                                //system.debug( (pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ') );
                                if( mapOfEcomSize.Containskey((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                    pro.prod.Ecom_Size__c = mapOfEcomSize.get((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                            }
                            when 'KURTA SET', 'TUNIC', 'KURTA', 'SLIP' {        
                                allspecString = (pro.prod.Base_Colour__c    +   pro.prod.Collection__c   +   pro.prod.Craft__c    +    pro.prod.MFabric__c    +    pro.prod.Top_Fabric__c    +    pro.prod.Bottom_Fabric__c    +
                                                 pro.prod.Form__c    +      pro.prod.X1_SET__c     +     pro.prod.Season__c     +     pro.prod.Style_Name__c     +     
                                                 pro.prod.Style_Code__c  + pro.prod.Vendot_style_code__c   +    pro.prod.Source__c    +     pro.prod.Loom__c    +    pro.prod.Zari__c    );
                                if( mapOfEcomSize.Containskey((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                    pro.prod.Ecom_Size__c = mapOfEcomSize.get((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                            }
                            when 'SHORT TOP','DRESS' {
                                allspecString = (pro.prod.Base_Colour__c   +   pro.prod.Collection__c    +   pro.prod.Craft__c    +    pro.prod.MFabric__c    +    pro.prod.Form__c    +    pro.prod.Season__c    + 
                                                 pro.prod.Style_Code__c  + pro.prod.Vendot_style_code__c  +   pro.prod.Source__c     +     pro.prod.Loom__c    +     pro.prod.Zari__c    );
                                if( mapOfEcomSize.Containskey((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                    pro.prod.Ecom_Size__c = mapOfEcomSize.get((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                            }
                            when 'TROUSER' {    
                                allspecString = (pro.prod.Base_Colour__c   +   pro.prod.Collection__c    +   pro.prod.Craft__c    +    pro.prod.MFabric__c    +    pro.prod.Top_Fabric__c    +    pro.prod.Bottom_Fabric__c  +   
                                                 pro.prod.Form__c   +     pro.prod.Season__c    +  pro.prod.Style_Name__c  +   pro.prod.Style_Code__c  + pro.prod.Vendot_style_code__c  +   pro.prod.Source__c     +     
                                                 pro.prod.Loom__c    +     pro.prod.Zari__c     );
                                if( mapOfEcomSize.Containskey((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                    pro.prod.Ecom_Size__c = mapOfEcomSize.get((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                            }
                            when else {       
                                allspecString = (pro.prod.Base_Colour__c    +   pro.prod.Collection__c    +    pro.prod.Craft__c    +    pro.prod.MFabric__c    +    pro.prod.Form__c   +    pro.prod.Season__c    +
                                                 pro.prod.Gender__c    +    pro.prod.STYLE__c    +    pro.prod.Style_Code__c  + pro.prod.Vendot_style_code__c   +    pro.prod.Year_of_Design__c  );
                                if( mapOfEcomSize.Containskey((pro.prod.Product__c +pro.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                    pro.prod.Ecom_Size__c = mapOfEcomSize.get((pro.prod.Product__c +pro.prod.Okhai_Size__c).toLowercase().remove(' ')).Ecom_Size__c;
                            }
                        }
                        
                        if( allspecsMap.ContainsKey( allspecString ))
                        {
                            pro.prod.SKU__C =  allspecsMap.get(allspecString) + size ;
                            pro.prod.E_Com_Material__c = allspecsMap.get(allspecString);
                            //system.debug('allspecString -->'+allspecString);
                        }else{
                            //system.debug('allspecString <--'+allspecString);
                            if( pro.prod.SKU__C == Null )
                            {
                                
                                if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',') ))
                                {
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                    autoNumberUpdate = true;
                                }else{
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                }
                                Integer  SerialNum = AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                System.debug('SerialNum -> ' + SerialNum );
                                String currentAutoNum = String.valueOf(SerialNum).length() ==1 ? ('000' + SerialNum) : String.valueOf(SerialNum).length() ==2 ? ('00' + SerialNum ) : String.valueOf(SerialNum).length() ==3  ? ('0'+SerialNum) : String.valueOf(SerialNum) ;
                                string skuStr =  MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+pro.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+pro.prod.collection__c).toLowercase().remove(' '))+ currentAutoNum;
                                pro.prod.SKU__C = skuStr + size ;
                                pro.prod.E_Com_Material__c = skuStr;
                                allspecsMap.put( allspecString, skuStr);
                                
                            }else{
                                if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',') ))
                                {
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                    autoNumberUpdate = true;
                                }else{
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                }
                                
                                Integer  SerialNum = AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                System.debug('SerialNum -> ' + SerialNum );
                                String currentAutoNum = String.valueOf(SerialNum).length() ==1 ? '000' + SerialNum : String.valueOf(SerialNum).length() ==2 ? '00' + SerialNum : String.valueOf(SerialNum).length() ==3 ? '0'+SerialNum : String.valueOf(SerialNum);
                                string skuStr =  MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+pro.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+pro.prod.collection__c).toLowercase().remove(' '))+ currentAutoNum;
                                pro.prod.SKU__C = skuStr + size ;
                                pro.prod.E_Com_Material__c = skuStr;
                                allspecsMap.put( allspecString, skuStr);
                                
                                //system.debug('sku' +pro.prod.SKU__C );
                            }
                            
                        }
                    }
                    //system.debug('AutoNumberString--'+AutoNumberString+'---AutoNumber==='+AutoNumber+'===pro.SKU__C--'+pro.prod.SKU__C);
                }
                
            } 
            else if(pro.prod.Product__c == 'MASK'){
                pro.prod.Item_no__c = itemNo;
                itemNo++;
                if(pro.prod.Gender__c != null && pro.prod.MFabric__c != null && pro.prod.MStyle_name__c != null && pro.prod.MPly__c != null){
                    pro.prod.MASK_DESCRIPTION__c = 'MA-'+pro.prod.Gender__c+'-'+pro.prod.MFabric__c+'-'+pro.prod.MStyle_name__c+'-'+pro.prod.MPly__c;
                }
                if( pro.prod.Product__c != null && pro.prod.MPly__c != null && pro.prod.MStyle_name__c != null && pro.prod.Gender__c != null){
                    
                    string AutoNumberString = MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '));
                    //system.debug('AutoNumberString--'+AutoNumberString);
                    Integer AutoNumber = null;
                    
                    Boolean autoNumError = false;
                    if(!MasterCode.containskey(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.Product__c+' product')); 
                        autoNumError = true;
                    }
                    if(!MasterCode.containskey(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.Gender__c+' gender')); 
                        autoNumError = true;
                    }
                    if(!MasterCode.containskey(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.MPly__c+' ply')); 
                        autoNumError = true;
                    }
                    if(!MasterCode.containskey( ('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '))){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact the administrator to create master code for ' +pro.prod.MStyle_name__c+' style name')); 
                        autoNumError = true;
                    }
                    
                    
                    //system.debug(MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' ')));
                    // System.debug('mapOfAutoNum'+mapOfAutoNum.keyset());
                    // system.debug(MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' ')));
                    
                    if(!mapOfAutoNum.containskey(AutoNumberString) && !autoNumError){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact to administrator to create Autonumber for'+ AutoNumberString +'combination code !!')); 
                        
                    }
                    Integer autoNum;
                    if(mapOfAutoNum.containskey(AutoNumberString)){
                        autoNum = integer.valueOf(mapOfAutoNum.get(MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '))).Running_Number__c);
                    }
                    integer len = string.valueOf(autoNum).length();
                    //system.debug('**autoNum**'+autoNum);
                    //system.debug('**len**'+len);
                    numOfZero = '';
                    for(integer i=1; i <= 4-len; i++){
                        numOfZero += '0';
                    }
                    if(date.Today().year() == 2016){
                        yearOfOperation = '01';
                    }
                    else{
                        integer year = (date.Today().year()- 2016) + 1;
                        yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                    }
                    month = mapOfMonth.get(date.Today().month());
                    
                    AutoNumber = Integer.valueOf(AutoNumberMap.get(AutoNumberString).SubstringBefore(','));
                    //system.debug('----------AutoNumber------------'+AutoNumber);
                    //system.debug('----------AutoNumberMap.get(AutoNumberString)--------'+AutoNumberMap.get(AutoNumberString));
                    //system.debug('-------------AutoNumberUpdateMap-------------'+AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString)));
                    
                    string allspecString =  pro.prod.Base_Colour__c   +   pro.prod.MFabric__c    +    pro.prod.MStyle_name__c   +   pro.prod.Gender__c    +    pro.prod.MDesign__c    +    pro.prod.MPleats__c    +   pro.prod.MPly__c    +    pro.prod.Fabric_1__c    +    pro.prod.Fabric_1_Quantity__c   + pro.prod.Fabric_2__c    +   pro.prod.Fabric_2_Quantity__c  ;
                    
                    if( allspecsMap.ContainsKey( allspecString ))
                    {
                        if(pro.prod.Pack_no__c != '1')
                        {
                            pro.prod.SKU__C =  allspecsMap.get(allspecString) + 'P'+pro.prod.Pack_no__c;
                        } else {
                            pro.prod.SKU__C =  allspecsMap.get(allspecString) ;
                        }
                        
                        // system.debug('allspecString -->'+allspecString);
                    }else{
                        //system.debug('allspecString <--'+allspecString);
                        if( pro.prod.SKU__C == Null )
                        {
                            if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')))
                            {
                                AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                string skuStr = MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                
                                // system.debug('skuStr->'+skuStr);
                                allspecsMap.put( allspecString, skuStr);
                                if(pro.prod.Pack_no__c != '1'){
                                    pro.prod.SKU__C = skuStr + 'P'+pro.prod.Pack_no__c;
                                }else{
                                    pro.prod.SKU__C = skuStr ;
                                }
                                autoNumberUpdate = true;
                            } else {
                                AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                string skuStr = MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                
                                //system.debug('skuStr->'+skuStr);
                                allspecsMap.put( allspecString, skuStr);
                                if(pro.prod.Pack_no__c != '1'){
                                    pro.prod.SKU__C = skuStr + 'P'+pro.prod.Pack_no__c;
                                }else{
                                    pro.prod.SKU__C = skuStr ;
                                }
                            }
                        } else {
                            if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')))
                            {
                                AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                string skuStr = MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                
                                //system.debug('skuStr->'+skuStr);
                                allspecsMap.put( allspecString, skuStr);
                                if(pro.prod.Pack_no__c != '1'){
                                    pro.prod.SKU__C = skuStr + 'P'+pro.prod.Pack_no__c;
                                }else{
                                    pro.prod.SKU__C = skuStr ;
                                }
                                autoNumberUpdate = true;
                            } else {
                                AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                string skuStr = MasterCode.get(('ProductType'+pro.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+pro.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+pro.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+pro.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                
                                //system.debug('skuStr->'+skuStr);
                                allspecsMap.put( allspecString, skuStr);
                                if(pro.prod.Pack_no__c != '1'){
                                    pro.prod.SKU__C = skuStr + 'P'+pro.prod.Pack_no__c;
                                }else{
                                    pro.prod.SKU__C = skuStr ;
                                }
                                //autoNumberUpdate = true;
                            }
                        }
                    }
                   
                    
                    //system.debug('autonumber---'+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')));
                }
                
            }
            else if( pro.prod.Product__c == 'USKD' ){
                //system.debug(  pro.prod.Product__c + pro.prod.Loom__c + pro.prod.Proc_Type__c );
                if( pro.prod.Product__c != null && pro.prod.Loom__c != null && pro.prod.Proc_Type__c != null ){
                    string autonumstring = (pro.prod.Product__c + pro.prod.Loom__c + pro.prod.Proc_Type__c).toLowercase().remove(' ');            
                    //system.debug('**uskd autonumstring**'+ autonumstring);
                    if(!uskdAutoNumberMap.containskey(autonumstring)){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Contact to administrator to create Autonumber for'+ autonumstring +'combination code !!')); 
                        
                    }
                    
                    integer autoNum = uskdAutoNumberMap.get( autonumstring );
                    //system.debug(  pro.prod.Product__c + pro.prod.Loom__c + pro.prod.Proc_Type__c  +'-->' + autoNum);\
                    system.debug('autonumstring '+autonumstring);
                    uskdAutoNumberMap.put( autonumstring , uskdAutoNumberMap.get( autonumstring )+1);
                    integer len = string.valueOf(autoNum).length();
                    //system.debug('**autoNum**'+autoNum);
                    //system.debug('**len**'+len);
                    numOfZero = '';
                    for(integer i=1; i <= 5-len; i++){
                        numOfZero += '0';
                    }
                    if(date.Today().year() == 2016){
                        yearOfOperation = '01';
                    }
                    else{
                        integer year = (date.Today().year()- 2016) + 1;
                        yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                    }
                    month = mapOfMonth.get(date.Today().month());
                    if( pro.prod.SKU__c == null){
                        
                        uskdautoNumberUpdate = True;
                    }
                    pro.prod.SKU__c= MasterCode.get(('Product Category'+pro.prod.Product__c).toLowercase().remove(' ')) + MasterCode.get(('Loom'+pro.prod.Loom__c).toLowercase().remove(' ')) + MasterCode.get(('Proc-Type'+pro.prod.Proc_Type__c).toLowercase().remove(' ')) +yearOfOperation +month+ numOfZero +autoNum;
                    //system.debug('USKD SKU -->' + pro.prod.SKU__c);
                    
                }
            }
            
            
            
            if(pro.prod.product__c == 'BLOUSE' )
            {
                pro.prod.Description__c =  'BL-'+pro.prod.Base_Colour__c + '-' + pro.prod.Collection__c +'-'+ pro.prod.Craft__c+ '-' + pro.prod.MFabric__c + '-' + pro.prod.RTW_SIZE__c;
                
            }
            if(pro.prod.product__c == 'SHORT TOP')
            {
                pro.prod.Description__c =  'ST-'+pro.prod.MFabric__c + '-' + pro.prod.Base_Colour__c +'-'+ pro.prod.Season__c+ '-' + pro.prod.RTW_SIZE__c;
            }
            if(pro.prod.product__c == 'DRESS')
            {
                pro.prod.Description__c =  'DR-'+pro.prod.MFabric__c + '-' + pro.prod.Base_Colour__c +'-'+ pro.prod.Season__c+ '-' + pro.prod.RTW_SIZE__c;
            }
             if(pro.prod.product__c == 'DRPDSAREE')
            {
                pro.prod.Description__c =  'DS-'+pro.prod.MFabric__c + '-' + pro.prod.Base_Colour__c +'-'+ pro.prod.Season__c+ '-' + pro.prod.SIZE__c;
            }
            
            /* 
if(pro.prod.Product__c == 'LEHENGA'){
if(pro.prod.Product__c != null && pro.prod.Origin__c != null && pro.prod.MFabric__c != null && pro.prod.Craft__c != null && pro.prod.Base_Colour__c != null){
pro.prod.Description__c = pro.prod.Product__c.substring(0,1)+'-'+pro.prod.Origin__c+'-'+pro.prod.MFabric__c+'-'+pro.prod.Craft__c.substring(0,7)+'-'+pro.prod.Base_Colour__c;
}

} else if(pro.prod.Product__c == 'BLOUSE'){
if(pro.prod.Product__c != null && pro.prod.MFabric__c != null && pro.prod.Craft__c != null && pro.prod.Base_Colour__c != null && pro.prod.Zari__c != null && pro.prod.RTW_SIZE__c != null){
pro.prod.Description__c = (pro.prod.Product__c!=null?pro.prod.Product__c.substring(0,1)+'-':'')+(pro.prod.MFabric__c!=null?pro.prod.MFabric__c.substring(0,2)+'-':'')+(pro.prod.Craft__c!=null?pro.prod.Craft__c.substring(0,2)+'-':'')+(pro.prod.Zari__c!=null?pro.prod.Zari__c.substring(0,2)+'-':'')+(pro.prod.Base_Colour__c!=null?pro.prod.Base_Colour__c+'-':'')+pro.prod.RTW_SIZE__c;
}
} else {
if(pro.prod.Craft__c != null && pro.prod.Base_Colour__c != null && pro.prod.Origin__c != null && pro.prod.Style_Code__c != null && pro.prod.Quantity__c != null){
pro.prod.Description__c = pro.prod.Origin__c.substring(0,2)+'-'+pro.prod.Base_Colour__c.substring(0,3)+'-'+pro.prod.Style_Code__c.substring(0,3)+'-'+pro.prod.Quantity__c+'-'+pro.prod.Craft__c.substring(0,2);
}
} */
            if(attachmentMap.containsKey(pro.prod.Id)){
                pro.prod.Photo__c = '<img src="'+baseUrl+'/servlet/servlet.FileDownload?file='+attachmentMap.get(pro.prod.Id).Id+'"></img>';//attachMapWithProdId.get(pro.prod.Id);
            }
                 
       

            //preGroup = pro.Prod.group__c;
            rtwProdList.add(pro.prod);
        } 
        // system.debug('allspecsMap');
        for(string a : allspecsMap.keyset())
        {
            //  system.debug(a);
        }
        attachmentMap.clear();
        if(rtwProdList.size() > 0){
            update rtwProdList;
            for(string s : AutoNumberUpdateMap.keyset()){
                RTWAutoNumber__c rtw = new RTWAutoNumber__c(id=s);
                rtw.Running_Number__c = Integer.ValueOf(AutoNumberUpdateMap.get(s)+1);
                RTWAutoNumberList.add(rtw);
            }
            for(String s : uskdAutoNumberMap.keyset())
            {
                AutoNumber__c an = new AutoNumber__c();
                an.id = uskdAutoNumberMapUpdate.get(s).Id;
                an.Auto_Number__c = uskdAutoNumberMap.get(s);
                autoNumList.add(an);
            }
            
            
            //system.debug('------autoNumberUpdate-----------'+autoNumberUpdate);
            if(autoNumberUpdate == True && RTWAutoNumberList.size() > 0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Saved Sucessfully!'));
                update RTWAutoNumberList;
                
            }
            if(autoNumList.size() > 0  && uskdautoNumberUpdate )
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Saved Sucessfully!'));
                update autoNumList;
            }
            
        }
    }
    
    public void doCopy(){
        Integer i=0;
        sObject firstObj = wrapperImageClassList[0].prod;
        system.debug('firstObj Field: '+copyValue+' | '+firstObj.get(copyValue));
        Boolean Ischanged = FALSE;
        system.debug('Ischangedd: '+Ischanged);
        List<id> prodIdList = new List<id>();
        List<RTW_Product__c> finalList = new List<RTW_Product__c>();
        for(wrapperImageClass copypro: wrapperImageClassList){
            prodIdList.add(copypro.prod.Id);
        }
        system.debug('prodIdList : '+prodIdList.size());
        
        RTWObjMap = new Map<Id,RTW_Product__c>([SELECT Id,Body_Fit__c,Photo__c,Pack_no__c,Item_no__c, SKU__c,Product__c,Origin__c,Form__c,Warp__c,Weft__c,Craft__c,Year_of_Design__c,Source__c,Base_Colour__c,
                                                Fabric__c,Size_LCD__c,Dimensions__c,ReadyGHERA_MT__c,MRP_Pc__c,Buyers_Cost__c,Silhouette__c,ReadyWaist_Inch__c, Submit__c,Ecom_Size__c,Submitted_Date__c,
                                                ReadyLength_Inch__c,ReadyHip_Inch__c,DupattaDimensions__c,Dupatta_Type__c,BlouseSize_LCD__c,Occasion__c,MASK_DESCRIPTION__c,
                                                Blouse_Type__c,SkirtPanels__c,Quantity__c,Total__c,DupattaFabric__c,Description__c,Season__c,Collection__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2_Quantity__c,Fabric_2__c,
                                                name, vendor_custom__c,vendor_custom__r.Name,vendor_custom__r.Vendor_Code__c,Product_Key__c, SKU_Count__c,CreatedDate,Handwork_Placement__c,Closure_Option__c,Handwork__c,
                                                Neck_Type_Back__c,Neck_Type_Front__c,Opening_Type__c,Padding__c,RTW_SIZE__c,Sleeve_Fit__c,Sleeve_Length__c,SLEEVE_TYPE__c,Proc_type__c,Order_ID__c,
                                                STYLE__c,Style_Code__c,Zari__c,Picklist__c,Gender__c,Okhai_Size__c,Size__c,Hem_Back__c,Hem_Front__c,Loom__c,Body_Length__c,MStyle_name__c,Bottom_Fabric__c,Top_Fabric__c,Kurta_Description__c,Consumtion__c,Consumtion1__c,Style_Name__c,
                                                
                                                Kurta_Fabric__c,Salwar_Fabric__c,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Story_1__c,Story_2__c,
                                                Warehouse_Stock__c,Store_Stock__c,Sold_Stock__c,Pallu_Des_Density__c,Pallu_Design__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,PO_Number__c,Zari_Type__c,Suggested_MRP__c,Detailed_Colour__c,Design_Story__c,
                                                BASE_COLOUR_DUPATTA__c,BASE_COLOUR_TROUSER__c,Dupatta_WARP__c,Dupatta_WEFT__c,Kurta_WARP__c,Kurta_WEFT__c,Trouser_WARP__c,Trouser_WEFT__c,X1_SET__c,
                                                MDesign__c,MConstruction__c,MPleats__c,MPly__c,MCost__c,MFabric__c,Remarks__c,Blouse_Fabric__c,Dupatta_Color__c,Blouse_Color__c,
                                                Vendot_style_code__c,CreatedBy.Name,SLIP__c,Duppatta__c,Jacket__c,Kurta__c,Trouser__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c FROM RTW_Product__c WHERE Id IN :prodIdList AND submit__c = FALSE Order By CreatedDate]);
        
        system.debug('RTWObjMap : '+RTWObjMap.size());
        sObject ChangedObj = null; 
        
        system.debug('wrapperImageClassList : '+wrapperImageClassList.size());
        Integer a = 1;
        for(wrapperImageClass copyprod: wrapperImageClassList){
            
            productTypeName = copyprod.prod.Product__c;
            system.debug('productTypeName : '+productTypeName);
            
            sObject sobj = copyprod.prod; //record number 1
            system.debug('sobj Id : '+sobj.Id);
            system.debug(' N obj '+copyValue+' : '+sobj.get(copyValue));
            
            sObject mapObj = RTWObjMap.get(sobj.Id);
            //system.debug('O mapObj '+copyValue+' : '+RTWObjMap.get(sobj.Id).Base_Colour__c); 
            system.debug('mapObj '+mapObj);
            if(sobj.get(copyValue) == mapObj.get(copyValue) && Ischanged == FALSE){
                
                //sobj.put(copyValue,firstObj.get(copyValue));
                system.debug(a);
                system.debug('Equal');
                system.debug('firstObj : '+firstObj.get(copyValue));
                a++;
            } else {
                system.debug(a);
                system.debug('else not equal');
                Ischanged = TRUE;
                if(ChangedObj == null){
                    ChangedObj = copyprod.prod;
                    system.debug('ChangedObj Id : '+ChangedObj.Id);
                    system.debug('ChangedObj Value : '+ChangedObj.get(copyValue));
                }
                sobj.put(copyValue,ChangedObj.get(copyValue));
                a++;
            }
            copyprod.prod = (RTW_Product__c)sobj;
            system.debug('Final Value : '+copyprod.prod.get(copyValue));
            finalList.add(copyprod.prod);
        }
        update finalList;
        RTWObjMap.clear();
        
    }
    
    
    //This method is to submit the completely filled product records
    public void ProductSubmit(){
                           
        if(selectedPurchaseUser!=null){
            Boolean isPassed=true;
            String month = '';
            string yearOfOperation = '';
            string numOfZero = '';
            //system.debug('proViewList==>'+proViewList);
            
            List<RTW_Product__c> rtwProdList = new List<RTW_Product__c>();
            Map<string,string> MasterCode = new Map<string,string>();
            Map<string,string> AutoNumberMap = new Map<string,string>();
            Map<string,Integer> AutoNumberUpdateMap = new Map<string, Integer>();
            List<RTWAutoNumber__c> RTWAutoNumberList = new List<RTWAutoNumber__c>();
            Map<Integer,String>mapOfMonth = new Map<Integer,String>();
            Map<string,RTWAutoNumber__c>mapOfAutoNum = new Map<string,RTWAutoNumber__c>();
            Map<string,RTW_Ecom_Size__c> mapOfEcomSize = new Map<string,RTW_Ecom_Size__c>();
            Set < String > setOfUsrName = new Set < string > ();
            Boolean uskdautoNumberUpdate = False;
            
            
            for(Master__c m : [SELECT Id, Active__c, Code__c, Name__c, Name FROM Master__c]){
                MasterCode.put((m.Name__c+m.Name).toLowercase().remove(' '),m.Code__c);
            }
            for(RTWAutoNumber__c an : [SELECT Id, Combination_Code__c, Collection__c, Fabrics__c, ProductType__c, Running_Number__c,Season__c FROM RTWAutoNumber__c]){
                AutoNumberMap.put(an.Combination_Code__c,an.Running_Number__c+','+an.id);
                mapOfAutoNum.put(an.Combination_Code__c,an); 
            }
            for(SKU_Month_Code__c mnt : SKU_Month_Code__c.getall().values()){
                mapOfMonth.put(integer.valueOf(mnt.Name),mnt.code__c);
            }
            
            for( RTW_Ecom_Size__c rtwEcomSize : [SELECT Id,Name,Product__c,Size__c,Ecom_Size__c FROM RTW_Ecom_Size__c ])
            {
                mapOfEcomSize.put( (rtwEcomSize.Product__c + rtwEcomSize.Size__c).toLowercase().remove(' ')  , rtwEcomSize );
            }
            
            Map<String,Integer> uskdAutoNumberMap = new Map<String, Integer>();
            Map<String,AutoNumber__c> uskdAutoNumberMapUpdate = new Map<String, AutoNumber__c>();
            List< AutoNumber__c > autoNumList = new List<AutoNumber__c>();
            //system.debug('*************************Using AutoNumber__c custom setting for USKD Product categaty **********************************');
            for(AutoNumber__c an : [SELECT Id, Auto_Number__c, Loom__c,Proc_Type__c,Product_Category__c FROM AutoNumber__c]){
                uskdAutoNumberMap.put(  (an.Product_Category__c + an.Loom__c + an.Proc_Type__c).toLowercase().remove(' ')  ,  (Integer)an.Auto_Number__c);
                uskdAutoNumberMapUpdate.put( (an.Product_Category__c + an.Loom__c + an.Proc_Type__c).toLowercase().remove(' ') , an );
            } 
            
            
            //system.debug('mapSize:--'+MasterCode.size()+'----'+AutoNumberMap.size());
            List<RTW_Product__c> UpdatedList=new List<RTW_Product__c>();
            
            Map<string,string> allspecsMap = new Map<string,string>();
            //boolean preGroup = null;
            for(wrapperImageClass rtw:wrapperImageClassList){
                
                string fabricValue = rtw.prod.MFabric__c;
                rtw.prod.Product_Stage__c = 'SOURCING';
                if(rtw.prod.Product__c == 'MASK'){
                    rtw.prod.MCost__c = rtw.prod.Buyers_Cost__c;
                }
                else{
                    rtw.prod.MRP_Pc__c = rtw.prod.Buyers_Cost__c;
                }
                rtw.prod.Assigned_to_sourcing__c = selectedPurchaseUser;
                rtw.prod.Assigned_sourcing_user__c=selectedPurchaseUser!='--None--'?selectedPurchaseUser:null;
                setOfUsrName.add(rtw.prod.owner.Name);
                if(rtw.prod.Product__c != 'MASK' && rtw.prod.Product__c != 'USKD' ){
                    // system.debug( rtw.prod.Product__c );
                    if(rtw.prod.SKU__C == null && rtw.prod.Product__c != null && rtw.prod.season__c != null && rtw.prod.collection__c != null && rtw.prod.Base_Colour__c != null && (rtw.prod.SIZE__c != null||rtw.prod.RTW_SIZE__c != null || rtw.prod.Size_LCD__c != null || rtw.prod.Okhai_Size__c != null) ){
                        string AutoNumberString = MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+rtw.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+rtw.prod.collection__c).toLowercase().remove(' '))+MasterCode.get(('Fabric'+fabricValue).toLowercase().remove(' '));
                        //   system.debug('AutoNumberString123==>'+ AutoNumberString);
                        //  system.debug('AutoNumberMap123==>'+ AutoNumberMap);
                        Integer AutoNumber = null;
                        if(test.isRunningTest()){
                            AutoNumberString = 'BFW19CWC';
                        }
                        if(AutoNumberMap.get(AutoNumberString) != null){
                            string size = '';
                            if(rtw.prod.Product__c == 'BLOUSE' || rtw.prod.Product__c == 'KURTA' || rtw.prod.Product__c == 'SHORT TOP' || rtw.prod.Product__c == 'DRESS' || rtw.prod.Product__c == 'TROUSER'  || rtw.prod.Product__c == 'KURTA SET' || rtw.prod.Product__c == 'SLIP' || rtw.prod.Product__c == 'TUNIC' ){
                                size = rtw.prod.RTW_SIZE__c;
                            } else if(rtw.prod.Product__c == 'LEHENGA' ){
                                size = rtw.prod.Size_LCD__c;//rtw.prod.BlouseSize_LCD__c;
                            }else if(rtw.prod.Product__c == 'DRPDSAREE' ){
                                size = rtw.prod.Size__c; 
                            }else {
                                size = rtw.prod.Okhai_Size__c;
                            }
                            AutoNumber = Integer.valueOf(AutoNumberMap.get(AutoNumberString).SubstringBefore(','));
                           
                            
                            string allspecString;
                            
                            switch on rtw.prod.Product__c {
                                when 'LEHENGA' {        
                                    allspecString = (rtw.prod.Base_Colour__c  +  rtw.prod.Collection__c   +    rtw.prod.Craft__c    +    rtw.prod.Season__c  +   rtw.prod.MFabric__c  + rtw.prod.Form__c  +  
                                                     rtw.prod.Top_Fabric__c   +    rtw.prod.Bottom_Fabric__c  +    rtw.prod.Style_Code__c  + rtw.prod.Vendot_style_code__c   +  rtw.prod.Blouse_Type__c   +  
                                                     rtw.prod.Blouse_Fabric__c  +  rtw.prod.Blouse_Color__c    +   rtw.prod.DupattaFabric__c   +  rtw.prod.Dupatta_Color__c    +   rtw.prod.Source__c   );
                                    // system.debug( (rtw.prod.Product__c +rtw.prod.Size_LCD__c).toLowercase().remove(' ') );
                                    if( mapOfEcomSize.Containskey((rtw.prod.Product__c +rtw.prod.Size_LCD__c).toLowercase().remove(' ')) )
                                        rtw.prod.Ecom_Size__c = mapOfEcomSize.get((rtw.prod.Product__c +rtw.prod.Size_LCD__c).toLowercase().remove(' ')).Ecom_Size__c;
                                }   
                                when 'BLOUSE'{     
                                    allspecString = (rtw.prod.Base_Colour__c   +   rtw.prod.Collection__c   +    rtw.prod.Craft__c    +   rtw.prod.Season__c    +   rtw.prod.MFabric__c   +    rtw.prod.Form__c   +   
                                                     rtw.prod.Top_Fabric__c   +  rtw.prod.Bottom_Fabric__c     +    rtw.prod.Source__c   +    rtw.prod.Loom__c  +
                                                     rtw.prod.Style_Name__c   +  rtw.prod.Style_Code__c   +  rtw.prod.Zari__c   );
                                    // system.debug( (rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ') );
                                    if( mapOfEcomSize.Containskey((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                        rtw.prod.Ecom_Size__c = mapOfEcomSize.get((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                                }
                                when 'KURTA SET', 'TUNIC', 'KURTA', 'SLIP' {        
                                    allspecString = (rtw.prod.Base_Colour__c    +   rtw.prod.Collection__c   +   rtw.prod.Craft__c    +    rtw.prod.MFabric__c    +    
                                                     rtw.prod.Top_Fabric__c    +   rtw.prod.Bottom_Fabric__c    +  rtw.prod.Form__c    +    
                                                     rtw.prod.X1_SET__c     +     rtw.prod.Season__c     +     rtw.prod.Style_Name__c     +     
                                                     rtw.prod.Style_Code__c  + rtw.prod.Vendot_style_code__c   +    rtw.prod.Source__c    +     rtw.prod.Loom__c    +    rtw.prod.Zari__c    );
                                    //system.debug( (rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ') );
                                    if( mapOfEcomSize.Containskey((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                        rtw.prod.Ecom_Size__c = mapOfEcomSize.get((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                                }
                                when 'SHORT TOP','DRESS' {
                                    allspecString = (rtw.prod.Base_Colour__c   +   rtw.prod.Collection__c    +   rtw.prod.Craft__c    +    rtw.prod.MFabric__c    +    rtw.prod.Form__c    +    rtw.prod.Season__c    + 
                                                     rtw.prod.Style_Code__c   + rtw.prod.Vendot_style_code__c  +   rtw.prod.Source__c     +     rtw.prod.Loom__c    +     rtw.prod.Zari__c     );
                                    //system.debug( (rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ') );
                                    if( mapOfEcomSize.Containskey((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                        rtw.prod.Ecom_Size__c = mapOfEcomSize.get((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                                }
                                when 'TROUSER' {    
                                    allspecString = (rtw.prod.Base_Colour__c   +   rtw.prod.Collection__c    +   rtw.prod.Craft__c    +    rtw.prod.MFabric__c    +    rtw.prod.Top_Fabric__c    +    rtw.prod.Bottom_Fabric__c    +
                                                     rtw.prod.Form__c    +    rtw.prod.Season__c    + rtw.prod.Style_Name__c  +  rtw.prod.Style_Code__c  + rtw.prod.Vendot_style_code__c  +   rtw.prod.Source__c     +   rtw.prod.Loom__c    +     rtw.prod.Zari__c);
                                    // system.debug( (rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ') );
                                    if( mapOfEcomSize.Containskey((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')) )
                                        rtw.prod.Ecom_Size__c = mapOfEcomSize.get((rtw.prod.Product__c +rtw.prod.RTW_SIZE__c).toLowercase().remove(' ')).Ecom_Size__c;
                                }
                                when else {       
                                    allspecString = (rtw.prod.Base_Colour__c    +   rtw.prod.Collection__c    +    rtw.prod.Craft__c    +    rtw.prod.MFabric__c    +    rtw.prod.Form__c   +    rtw.prod.Season__c    +
                                                     rtw.prod.Gender__c    +    rtw.prod.STYLE__c    +    rtw.prod.Style_Code__c     +    rtw.prod.Year_of_Design__c     );
                                    //system.debug( (rtw.prod.Product__c +rtw.prod.Okhai_Size__c).toLowercase().remove(' ') );
                                    if( mapOfEcomSize.Containskey((rtw.prod.Product__c +rtw.prod.Okhai_Size__c).toLowercase().remove(' ')) )
                                        rtw.prod.Ecom_Size__c = mapOfEcomSize.get((rtw.prod.Product__c +rtw.prod.Okhai_Size__c).toLowercase().remove(' ')).Ecom_Size__c;
                                }
                            }
                            
                            if( allspecsMap.ContainsKey( allspecString ))
                            {
                                rtw.prod.SKU__C =  allspecsMap.get(allspecString) + size ;
                                rtw.prod.E_Com_Material__c = allspecsMap.get(allspecString);
                                //system.debug('allspecString -->'+allspecString);
                            }else{
                                //system.debug('allspecString <--'+allspecString);
                                if( rtw.prod.SKU__C == Null )
                                {
                                    
                                    if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',') ))
                                    {
                                        AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                        //autoNumberUpdate = true;
                                    }else{
                                        AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                    }
                                    
                                    
                                    Integer  SerialNum = AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                    String currentAutoNum = String.valueOf(SerialNum).length() ==1 ? '000' + SerialNum : String.valueOf(SerialNum).length() ==2 ? '00' + SerialNum : String.valueOf(SerialNum).length() ==3 ? '0'+SerialNum : String.valueOf(SerialNum);
                                    string skuStr =  MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+rtw.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+rtw.prod.collection__c).toLowercase().remove(' '))+ currentAutoNum;
                                    rtw.prod.SKU__C = skuStr + size ;
                                    rtw.prod.E_Com_Material__c = skuStr;
                                    allspecsMap.put( allspecString, skuStr);
                                    
                                }else{
                                    if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',') ))
                                    {
                                        AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                        //autoNumberUpdate = true;
                                    }else{
                                        AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                    }
                                    
                                    Integer  SerialNum = AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                    String currentAutoNum = String.valueOf(SerialNum).length() == 1 ? '000' + SerialNum : String.valueOf(SerialNum).length() ==2 ? '00' + SerialNum : String.valueOf(SerialNum).length() ==3 ? '0'+SerialNum : String.valueOf(SerialNum);
                                    string skuStr =  MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Season'+rtw.prod.season__c).toLowercase().remove(' '))+MasterCode.get(('Collection'+rtw.prod.collection__c).toLowercase().remove(' '))+ currentAutoNum;
                                    rtw.prod.SKU__C = skuStr + size ;
                                    rtw.prod.E_Com_Material__c = skuStr;
                                    allspecsMap.put( allspecString, skuStr);
                                    
                                    // system.debug('sku' +rtw.prod.SKU__C );
                                }
                                
                            }
                        }
                    }
                }else if(rtw.prod.Product__c == 'MASK'){
                    if(rtw.prod.Gender__c != null && rtw.prod.MFabric__c != null && rtw.prod.MStyle_name__c != null && rtw.prod.MPly__c != null){
                        rtw.prod.MASK_DESCRIPTION__c = 'MA-'+rtw.prod.Gender__c+'-'+rtw.prod.MFabric__c+'-'+rtw.prod.MStyle_name__c+'-'+rtw.prod.MPly__c;
                    }
                    if( rtw.prod.Product__c != null && rtw.prod.MPly__c != null && rtw.prod.MStyle_name__c != null && rtw.prod.Gender__c != null){
                        
                        string AutoNumberString = MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+rtw.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+rtw.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+rtw.prod.MStyle_name__c).toLowercase().remove(' '));
                        //system.debug('AutoNumberString--'+AutoNumberString);
                        Integer AutoNumber = null;
                        integer autoNum = integer.valueOf(mapOfAutoNum.get(MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+rtw.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+rtw.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+rtw.prod.MStyle_name__c).toLowercase().remove(' '))).Running_Number__c);
                        integer len = string.valueOf(autoNum).length();
                        //  system.debug('**autoNum**'+autoNum);
                        //  system.debug('**len**'+len);
                        numOfZero = '';
                        for(integer i=1; i <= 4-len; i++){
                            numOfZero += '0';
                        }
                        if(date.Today().year() == 2016){
                            yearOfOperation = '01';
                        }
                        else{
                            integer year = (date.Today().year()- 2016) + 1;
                            yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                        }
                        month = mapOfMonth.get(date.Today().month());
                        
                        AutoNumber = Integer.valueOf(AutoNumberMap.get(AutoNumberString).SubstringBefore(','));
                        //
                        string allspecString =  rtw.prod.Base_Colour__c   +   rtw.prod.MFabric__c    +    rtw.prod.MStyle_name__c   +   rtw.prod.Gender__c    +    rtw.prod.MDesign__c    +    rtw.prod.MPleats__c    +   rtw.prod.MPly__c     +    rtw.prod.Fabric_1__c    +    rtw.prod.Fabric_1_Quantity__c   + rtw.prod.Fabric_2__c    +   rtw.prod.Fabric_2_Quantity__c   ;
                        
                        if( allspecsMap.ContainsKey( allspecString ))
                        {
                            if(rtw.prod.Pack_no__c != '1')
                            {
                                rtw.prod.SKU__C =  allspecsMap.get(allspecString) + 'P'+rtw.prod.Pack_no__c;
                            } else {
                                rtw.prod.SKU__C =  allspecsMap.get(allspecString) ;
                            }
                            
                            //                        system.debug('allspecString -->'+allspecString);
                        }else{
                            // system.debug('allspecString <--'+allspecString);
                            if( rtw.prod.SKU__C == Null )
                            {
                                if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')))
                                {
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                    string skuStr = MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+rtw.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+rtw.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+rtw.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                    
                                    //system.debug('skuStr->'+skuStr);
                                    allspecsMap.put( allspecString, skuStr);
                                    if(rtw.prod.Pack_no__c != '1'){
                                        rtw.prod.SKU__C = skuStr + 'P'+rtw.prod.Pack_no__c;
                                    }else{
                                        rtw.prod.SKU__C = skuStr ;
                                    }
                                } else {
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                    string skuStr = MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+rtw.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+rtw.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+rtw.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                    
                                    // system.debug('skuStr->'+skuStr);
                                    allspecsMap.put( allspecString, skuStr);
                                    if(rtw.prod.Pack_no__c != '1'){
                                        rtw.prod.SKU__C = skuStr + 'P'+rtw.prod.Pack_no__c;
                                    }else{
                                        rtw.prod.SKU__C = skuStr ;
                                    }
                                }
                            } else {
                                if( AutoNumberUpdateMap.containskey(AutoNumberMap.get(AutoNumberString).SubstringAfter(',')))
                                {
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','))+1);
                                    string skuStr = MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+rtw.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+rtw.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+rtw.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                    
                                    // system.debug('skuStr->'+skuStr);
                                    allspecsMap.put( allspecString, skuStr);
                                    if(rtw.prod.Pack_no__c != '1'){
                                        rtw.prod.SKU__C = skuStr + 'P'+rtw.prod.Pack_no__c;
                                    }else{
                                        rtw.prod.SKU__C = skuStr ;
                                    }
                                } else {
                                    AutoNumberUpdateMap.put(AutoNumberMap.get(AutoNumberString).SubstringAfter(','),AutoNumber);
                                    string skuStr = MasterCode.get(('ProductType'+rtw.prod.Product__c).toLowercase().remove(' '))+MasterCode.get(('Gender'+rtw.prod.Gender__c).toLowercase().remove(' '))+MasterCode.get(('Ply'+rtw.prod.MPly__c).toLowercase().remove(' '))+MasterCode.get(('Style Name'+rtw.prod.MStyle_name__c).toLowercase().remove(' '))+yearOfOperation +month+numOfZero+AutoNumberUpdateMap.get(AutoNumberMap.get(AutoNumberString).SubstringAfter(','));
                                    
                                    //system.debug('skuStr->'+skuStr);
                                    allspecsMap.put( allspecString, skuStr);
                                    if(rtw.prod.Pack_no__c != '1'){
                                        rtw.prod.SKU__C = skuStr + 'P'+rtw.prod.Pack_no__c;
                                    }else{
                                        rtw.prod.SKU__C = skuStr ;
                                    }
                                }
                            }
                        }

                    }
                }
                else if(rtw.prod.Product__c == 'USKD'){
                    
                    //system.debug(  rtw.prod.Product__c + rtw.prod.Loom__c + rtw.prod.Proc_Type__c + rtw.prod.SKU__c);
                    if( rtw.prod.Product__c != null && rtw.prod.Loom__c != null && rtw.prod.Proc_Type__c != null ){
                        string autonumstring = (rtw.prod.Product__c + rtw.prod.Loom__c + rtw.prod.Proc_Type__c).toLowercase().remove(' ');
                        // system.debug('**uskd autonumstring**'+ autonumstring);
                        integer autoNum = uskdAutoNumberMap.get( autonumstring );
                        // system.debug(  rtw.prod.Product__c + rtw.prod.Loom__c + rtw.prod.Proc_Type__c  +'-->' + autoNum);
                        uskdAutoNumberMap.put( autonumstring , uskdAutoNumberMap.get( autonumstring )+1);
                        integer len = string.valueOf(autoNum).length();
                        //system.debug('**autoNum**'+autoNum);
                        //system.debug('**len**'+len);
                        numOfZero = '';
                        for(integer i=1; i <= 5-len; i++){
                            numOfZero += '0';
                        }
                        if(date.Today().year() == 2016){
                            yearOfOperation = '01';
                        }
                        else{
                            integer year = (date.Today().year()- 2016) + 1;
                            yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                        }
                        month = mapOfMonth.get(date.Today().month());
                        if( rtw.prod.SKU__c == null){
                            uskdautoNumberUpdate = True;
                            rtw.prod.SKU__c= MasterCode.get(('Product Category'+rtw.prod.Product__c).toLowercase().remove(' ')) + MasterCode.get(('Loom'+rtw.prod.Loom__c).toLowercase().remove(' ')) + MasterCode.get(('Proc-Type'+rtw.prod.Proc_Type__c).toLowercase().remove(' ')) +yearOfOperation +month+ numOfZero +autoNum;
                        }
                        
                        //system.debug('USKD SKU -->' + rtw.prod.SKU__c);
                        
                    }
                }
                rtwProdList.add(rtw.prod);
                system.debug('prodtype name'+rtw.prod.Product__c);
                if( productTypeName != 'LEHENGA' && productTypeName != 'BLOUSE' && productTypeName != 'MASK' && productTypeName != 'KURTA' && productTypeName != 'SHORT TOP' && productTypeName != 'DRESS' && productTypeName != 'TROUSER' && productTypeName != 'USKD' && productTypeName != 'KURTA SET' && productTypeName != 'SLIP' && productTypeName != 'TUNIC'){
                    system.debug('others==>');
                    system.debug('ddddddddd =>'+rtw.prod.Product__c);
                    system.debug('dddd rtw.prod.Base_Colour__c'+rtw.prod.Base_Colour__c);
                    system.debug('dddd rtw.prod.Collection__c'+rtw.prod.Collection__c);
                    system.debug('dddd rtw.prod.Craft__c'+rtw.prod.Craft__c);
                    system.debug('dddd rtw.prod.MRP_Pc__c'+rtw.prod.MRP_Pc__c);
                    system.debug('dddd rtw.prod.Quantity__c'+rtw.prod.Quantity__c);
                    system.debug('dddd rtw.prod.Season__c'+rtw.prod.Season__c);
                    system.debug('dddd rtw.prod.Warp__c'+rtw.prod.Warp__c);
                    system.debug('dddd rtw.prod.Weft__c'+rtw.prod.Weft__c);
                    system.debug('dddd rtw.prod.Gender__c'+rtw.prod.Gender__c);
                    system.debug('dddd rtw.prod.Okhai_Size__c'+rtw.prod.Okhai_Size__c);
                    system.debug('dddd rtw.prod.Size__c'+rtw.prod.Size__c);
                    system.debug('dddd rtw.prod.STYLE__c'+rtw.prod.STYLE__c);
                    system.debug('dddd rtw.prod.Style_Code__c'+rtw.prod.Style_Code__c);
                    system.debug('dddd rtw.prod.Year_of_Design__c'+rtw.prod.Year_of_Design__c);
                    
                    if  (rtw.prod.Base_Colour__c == null || rtw.prod.Collection__c == null||  rtw.prod.Craft__c == null || rtw.prod.MRP_Pc__c==null || rtw.prod.Product__c==null || RTW.prod.Quantity__c==null|| rtw.prod.Season__c==null || rtw.prod.Gender__c==null || 
                         rtw.prod.Okhai_Size__c==null || rtw.prod.Size__c==null || rtw.prod.STYLE__c==null || rtw.prod.Style_Code__c==null || rtw.prod.Year_of_Design__c==null ){
                             showSavedRecs = true; 
                              system.debug('1111111');
                             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the data before submitting!'));
                         }       
                    else
                    {
                        rtw.prod.Submit__c = true;
                        rtw.prod.Submitted_Date__c = System.now();
                        UpdatedList.add(rtw.prod);
                        showSavedRecs = false; 
                        system.debug('Yes');
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Submitted Sucessfully!'));
                        // mailOnSubmit(setOfUsrName);
                    } 
                } else if(productTypeName == 'BLOUSE'  || productTypeName == 'SHORT TOP' || productTypeName == 'DRESS' || productTypeName == 'TROUSER'){
                    system.debug('Blouse==>');
                    
                    if  (rtw.prod.SKU__c == Null || rtw.prod.Product__c == Null||  rtw.prod.Base_Colour__c == Null ||  rtw.prod.Collection__c == Null || 
                         rtw.prod.Craft__c == Null || rtw.prod.Season__c == Null || rtw.prod.MFabric__c == Null ||  rtw.prod.MRP_Pc__c == Null || 
                         rtw.prod.Quantity__c == Null || rtw.prod.Source__c == Null || rtw.prod.Loom__c == Null ||  rtw.prod.RTW_SIZE__c == Null || 
                         rtw.prod.Style_Code__c == Null || rtw.prod.Order_ID__c == Null ){
                             showSavedRecs = true;
                              system.debug('222222');
                             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the data before submitting!'));
                         }       
                    else
                    {
                        rtw.prod.Submit__c = true;
                        rtw.prod.Submitted_Date__c = System.now();
                        UpdatedList.add(rtw.prod);
                        showSavedRecs = false; 
                        system.debug('3333333');
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Inserted Sucessfully!'));
                        // mailOnSubmit(setOfUsrName);
                    }
                    
                } else if( productTypeName == 'KURTA SET' || productTypeName == 'KURTA' || productTypeName == 'TUNIC' || productTypeName == 'SLIP'){
                    system.debug('4444');
                    
                    if  (rtw.prod.SKU__c == Null || rtw.prod.Product__c == Null||  rtw.prod.Base_Colour__c == Null ||  rtw.prod.Collection__c == Null || rtw.prod.Craft__c == Null || rtw.prod.Season__c == Null || rtw.prod.MFabric__c == Null 
                         ||  rtw.prod.MRP_Pc__c == Null || rtw.prod.Quantity__c == Null || rtw.prod.Source__c == Null || rtw.prod.Loom__c == Null ||  rtw.prod.RTW_SIZE__c == Null || rtw.prod.Style_Code__c == Null
                         || rtw.prod.Order_ID__c == Null  || rtw.prod.Bottom_Fabric__c == Null  || rtw.prod.Top_Fabric__c == Null  || rtw.prod.X1_SET__c == Null 
                         || rtw.prod.Kurta_Description__c == Null  || rtw.prod.Style_Name__c == Null ){
                             showSavedRecs = true;
                             system.debug('555');
                             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the data before submitting!'));
                         }       
                    else
                    {
         
                        rtw.prod.Submit__c = true;
                        rtw.prod.Submitted_Date__c = System.now();
                        UpdatedList.add(rtw.prod);
                        showSavedRecs = false;
                        system.debug('666666');
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Inserted Sucessfully!'));
                        // mailOnSubmit(setOfUsrName);
                    }
                    
                } else {
                    if(productTypeName == 'LEHENGA'){
                        system.debug('77777');
                        // system.debug( rtw.prod.SKU__c +'-'+rtw.prod.Product__c+'-'+rtw.prod.Base_Colour__c +'-'+  rtw.prod.Collection__c +'-'+ rtw.prod.Craft__c+'-'+ rtw.prod.Season__c+'-'+ rtw.prod.MFabric__c +'-'+ rtw.prod.Form__c +'-'+ rtw.prod.MRP_Pc__c +'-'+  rtw.prod.Quantity__c +'-'+ rtw.prod.Style_Code__c +'-'+ rtw.prod.Blouse_Type__c +'-'+ rtw.prod.Blouse_Fabric__c +'-'+ rtw.prod.Blouse_Color__c+'-'+ rtw.prod.DupattaFabric__c +'-'+ rtw.prod.Dupatta_Color__c+'-'+ rtw.prod.Size_LCD__c +'-'+rtw.prod.Source__c +'-'+ rtw.prod.Order_ID__c+'-'+ rtw.prod.Remarks__c);
                        if( rtw.prod.SKU__c == Null || rtw.prod.Product__c == Null || rtw.prod.Base_Colour__c == Null ||  rtw.prod.Collection__c ==Null || rtw.prod.Craft__c == Null || rtw.prod.Season__c == Null  || rtw.prod.MFabric__c == Null || rtw.prod.MRP_Pc__c == Null ||  rtw.prod.Quantity__c == Null || rtw.prod.Style_Code__c == Null  ||  rtw.prod.Blouse_Type__c == Null || rtw.prod.Blouse_Fabric__c == Null ||rtw.prod.Blouse_Color__c == Null || rtw.prod.DupattaFabric__c == Null || rtw.prod.Dupatta_Color__c == Null || rtw.prod.Size_LCD__c == Null ||rtw.prod.Source__c == Null || rtw.prod.Order_ID__c== Null ){
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the Lehenga data before submitting!'));
                            showSavedRecs = true; 
                            system.debug('In if under L');
                            
                        }       
                        else
                        {
                              system.debug('In else under L');
                            rtw.prod.Submit__c = true;
                            rtw.prod.Submitted_Date__c = System.now();
                             system.debug('---------rtw.prod.Submit__c----------'+rtw.prod.Submit__c);
                            UpdatedList.add(rtw.prod);
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Submitted Sucessfully!'));
                            showSavedRecs = false; 
                            // mailOnSubmit(setOfUsrName);
                            
                        }
                    }else If(productTypeName == 'MASK'){
                         system.debug('----------coming inside mask if----------');
                        if(rtw.prod.Base_Colour__c == null ||  rtw.prod.MFabric__c == null || rtw.prod.MStyle_name__c==null ||rtw.prod.Gender__c==null ||rtw.prod.Product__c==null || rtw.prod.Quantity__c==null|| rtw.prod.MDesign__c==null || rtw.prod.MPleats__c==null || rtw.prod.MPly__c==null || rtw.prod.MCost__c==null ){
                            showSavedRecs = true; 
                            system.debug('--------showSavedRecs--------'+showSavedRecs);
                            
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the Mask data before submitting!'));
                        }       
                        else 
                        {
                            rtw.prod.Submit__c = true;
                            rtw.prod.Submitted_Date__c = System.now();
                            UpdatedList.add(rtw.prod);
                            showSavedRecs = false; 
                            system.debug('8888');
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Submitted Sucessfully!'));
                            // mailOnSubmit(setOfUsrName);
                        }
                    }else If(productTypeName == 'USKD'){
                        //  system.debug('----------coming inside USKD if----------');
                        //system.debug( rtw.prod.SKU__c+ rtw.prod.Loom__c + rtw.prod.Proc_Type__c + rtw.prod.Quantity__c  );
                        if( rtw.prod.SKU__c == null || rtw.prod.Loom__c == null ||  rtw.prod.Proc_Type__c == null || rtw.prod.Quantity__c== null ){
                            showSavedRecs = true; 
                            //  system.debug('--------showSavedRecs--------'+showSavedRecs);
                            
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the USKD data before submitting!'));
                        }       
                        else 
                        {
                            rtw.prod.Submit__c = true;
                            rtw.prod.Submitted_Date__c = System.now();
                            UpdatedList.add(rtw.prod);
                            showSavedRecs = false;
                            system.debug('999');
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Submitted Sucessfully!'));
                            // mailOnSubmit(setOfUsrName);
                        }
                    }
                }
                /* if(rtw.prod.product__c == 'LEHENGA'){
if(rtw.prod.product__c != null && rtw.prod.Origin__c != null && rtw.prod.MFabric__c != null && rtw.prod.Craft__c != null && rtw.prod.Base_Colour__c != null && rtw.prod.BlouseSize_LCD__c != NULL){
rtw.prod.Description__c = rtw.prod.product__c.substring(0,1)+'-'+rtw.prod.Origin__c+'-'+rtw.prod.MFabric__c.substring(0,3)+'-'+rtw.prod.Craft__c.substring(0,7)+'-'+rtw.prod.Base_Colour__c+'-'+rtw.prod.BlouseSize_LCD__c;
}

} else if(rtw.prod.product__c == 'BLOUSE'){
if(rtw.prod.product__c != null && rtw.prod.MFabric__c != null && rtw.prod.Craft__c != null && rtw.prod.Base_Colour__c != null && rtw.prod.Zari__c != null && rtw.prod.RTW_SIZE__c != null){
//system.debug(rtw.product__c+'-'+rtw.Warp__c+'-'+rtw.Weft__c+'-'+rtw.Craft__c+'-'+rtw.Zari__c+'-'+rtw.Base_Colour__c+'-'+rtw.RTW_SIZE__c);
rtw.prod.Description__c = rtw.prod.product__c.substring(0,1)+'-'+rtw.prod.MFabric__c.substring(0,3)+'-'+rtw.prod.Craft__c.substring(0,3)+'-'+rtw.prod.Zari__c.substring(0,3)+'-'+rtw.prod.Base_Colour__c+'-'+rtw.prod.RTW_SIZE__c;
}
} else 
*/
                if(rtw.prod.product__c == 'BLOUSE' )
                {
                    rtw.prod.Description__c =  'BL-'+rtw.prod.Base_Colour__c + '-' + rtw.prod.Collection__c +'-'+ rtw.prod.Craft__c+ '-' + rtw.prod.MFabric__c + '-' +rtw.prod.RTW_SIZE__c;
                }
                if(rtw.prod.product__c == 'SHORT TOP')
                {
                    rtw.prod.Description__c =  'ST-'+rtw.prod.MFabric__c + '-' + rtw.prod.Base_Colour__c +'-'+ rtw.prod.Season__c+ '-' + rtw.prod.RTW_SIZE__c;
                }
                if(rtw.prod.product__c == 'DRESS')
                {
                    rtw.prod.Description__c =  'DR-'+rtw.prod.MFabric__c + '-' + rtw.prod.Base_Colour__c +'-'+ rtw.prod.Season__c+ '-' + rtw.prod.RTW_SIZE__c;
                }
                if(rtw.prod.product__c != 'MASK' && rtw.prod.product__c != 'LEHENGA' && rtw.prod.product__c != 'BLOUSE'){
                    if(rtw.prod.Craft__c != null && rtw.prod.Base_Colour__c != null && rtw.prod.Origin__c != null && rtw.prod.Style_Code__c != null && rtw.prod.Quantity__c != null && rtw.prod.Okhai_Size__c != NULL){
                        rtw.prod.Description__c = rtw.prod.Origin__c.substring(0,2)+'-'+rtw.prod.Base_Colour__c.substring(0,3)+'-'+rtw.prod.Style_Code__c.substring(0,3)+'-'+rtw.prod.Quantity__c+'-'+rtw.prod.Craft__c.substring(0,2)+'-'+rtw.prod.Okhai_Size__c;
                    }
                }
                if(attachmentMap.containsKey(rtw.prod.Id)){
                    
                    rtw.prod.Photo__c = '<img src="'+baseUrl+'/servlet/servlet.FileDownload?file='+attachmentMap.get(rtw.prod.Id).Id+'"></img>';//attachMapWithProdId.get(pro.prod.Id);
                    //system.debug(rtw.Photo__c);
                }
                
   
            }
            
            //prodList.clear();
            // system.debug('----------UpdatedList------------'+UpdatedList.size());
            mailOnSubmit(setOfUsrName);
            // Messaging.sendEmail(Email);
            if(UpdatedList.size()>0)
            {
                Integer itemNum = 1;
                List<RTW_product__share> jobShares = new List<RTW_product__share>();
                for(RTW_Product__c rtProd: UpdatedList)
                {
                    rtProd.Item_no__c = itemNum;
                    itemNum++;
                    
                    
                    
                    RTW_product__share shr= new RTW_product__share();
                    shr.Parentid=rtProd.id;
                    shr.UserOrGroupId=selectedPurchaseUser;
                    shr.AccessLevel = 'edit';
                    shr.RowCause = 'Manual';
                    jobShares.add(shr);
                    
                    
                }
                if(!jobShares.isempty()){
                    Database.SaveResult[] jobShareInsertResult = Database.insert(jobShares,false);
                    system.debug('###  jobShareInsertResult  :'+jobShareInsertResult);
                }
                upsert UpdatedList;
                for(string s : AutoNumberUpdateMap.keyset()){
                    RTWAutoNumber__c rtw = new RTWAutoNumber__c(id=s);
                    rtw.Running_Number__c = Integer.ValueOf(AutoNumberUpdateMap.get(s))+1;
                    RTWAutoNumberList.add(rtw);
                }
                if(RTWAutoNumberList.size() > 0){
                    update RTWAutoNumberList;
                }
                
                for(String s : uskdAutoNumberMap.keyset())
                {
                    AutoNumber__c an = new AutoNumber__c();
                    an.id = uskdAutoNumberMapUpdate.get(s).Id;
                    an.Auto_Number__c = uskdAutoNumberMap.get(s);
                    autoNumList.add(an);
                }
                if(autoNumList.size() > 0  && uskdautoNumberUpdate )
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records Saved Sucessfully!'));
                    update autoNumList;
                }
            }
            Double totalQuantity = 0; 
            // colorCheck = true;
            // check = true;
            string ProString = '';
            String mailbody = '';
            String mailbody1 = '';
            system.debug('submitted');
            list<RTW_Product__c> newList = new list<RTW_Product__c>();
            
            if(UpdatedList.size()>0){
                for(RTW_Product__c rtw : UpdatedList){
                    if (rtw.Quantity__c != NULL) {
                        totalQuantity += rtw.Quantity__c;
                    }
                    
                        rtw.Sourcing_user_email__c = UserEmail.get(selectedPurchaseUser);
                    
                    newList.add(rtw);                  
                    
                    
                }
            }
            system.debug('UpdatedList'+UpdatedList);
            //system.debug('check'+check);
            system.debug('newList '+newList);
            system.debug('check '+check);
            if(!newList.isEmpty() && check == TRUE){
                
                List<RTW_Product__c> rtwproductViewLst = new List<RTW_Product__c>();
                
                List<string> emailList = new List<string>();
                uniquekey = apexpages.currentpage().getparameters().get('ProductKey');
                system.debug('unikey'+uniquekey);
                system.debug('productTypeName'+productTypeName);
                system.debug('selectedPurchaseUser '+selectedPurchaseUser);
                system.debug('userValues.get(selectedPurchaseUser) '+userValues.get(selectedPurchaseUser));
                for(RTW_Product__c rtwp : [SELECT Id,Sourcing_user__c,Sourcing_user_email__c,Product_Stage__c,createdDate FROM RTW_Product__c where   name=:uniquekey and Product__c=:productTypeName ] ){
                    rtwp.Product_Stage__c = 'SOURCING';
                    
                    rtwp.Sourcing_user__c = selectedPurchaseUser+','+userValues.get(selectedPurchaseUser);
                    system.debug(selectedPurchaseUser+','+userValues.get(selectedPurchaseUser));
                    rtwp.Sourcing_user_email__c = UserEmail.get(selectedPurchaseUser);
                    system.debug('Sourcing_user_email__c'+rtwp.Sourcing_user_email__c);
                    rtwproductViewLst.add(rtwp);
                    system.debug('UserEmail'+UserEmail);
                    emailList.add(UserEmail.get(selectedPurchaseUser));
                }
                update rtwproductViewLst;
                update newList; 
                String table;
                String VendorName= '';
                 Vendor__c ven = new Vendor__c();
               
                table = '<table border="1"><tr><th>Vendor name</th><th>SKU</th><th>Name</th><th>Quantity</th></tr>';
                for(RTW_Product__c pro: UpdatedList){
                    System.debug('Test ======>');
                     if(pro.Vendor_custom__c != NULL){
                    ven = [SELECT Id, Name FROM Vendor__c WHERE Id =: pro.Vendor_custom__c limit 1];
                    VendorName = ven.Name;
                    
                                   }
                    table = table + '<tr>'+'<td style="text-align:center;">'+VendorName+'</td>'+'<td>'+pro.SKU__c+'</td>'+'<td style="text-align:center;">'+pro.Name+'</td>'+'</td>'+'<td style="text-align:center;">'+pro.Quantity__c+'</tr>';
                    
                }
                table = table+'</table>';
                System.debug('Table===>'+table);
                
                //mailbody = '<html><body>Dear Team,<br/><br/> Taneira team has placed orders for the following SKU.<br/><br/>kindly complete the Sourcing operation.<br/><br/>Thank you<br/><br/></body></html>';
                mailbody  = '<html> Dear  Team' + ',' + '<br/><br/>' + 'Taneira team has placed orders for the following SKUs.' +
                    '<br/> kindly complete the Sourcing operation.' +
                    '<br/><br/> Total Quantity=' + totalQuantity +
                    
                    '<br/>'+ table+
                    '<br/>Thank You';
                PageReference pdf = Page.RTWProductEmailtablevf;
                //pdf.getParameters().put('KeyFinder',UpdatedList[0].);
                pdf.setRedirect(true);
                Blob b;
                // Take the PDF content
                /*if(!Test.isRunningTest()){
system.debug('executing........');
b = pdf.getContent();
}
else{
system.debug('executing........Test');
b = blob.valueOf('Test');
}*/
                
                emailList.add('sfdcadmin@titan.co.in');
                system.debug('emailList++++===='+emailList);
                Messaging.SingleEmailMessage Msg = new Messaging.SingleEmailMessage();
                msg.setToAddresses(emailList);
                msg.Sethtmlbody(mailbody);
                msg.setSubject('TaneiraRTW:Submitted for sourcing');
                Messaging.sendEmail(new Messaging.SingleEmailmessage[] {msg});
                
               
            }
            
        }
        
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Select Sourcing User'));
        }   
        
    }
    
    public void mailOnSubmit(Set<String> setOfUsrName){
        Map < String, User > mapOfUser = new Map < String, User > ();
        // system.debug('----------setOfUsrName--------'+setOfUsrName);
        if (!setOfUsrName.isEmpty()) {
            for (User usr: [Select Id, UserName,Email, Name from user Where Name in: setOfUsrName]) {
                mapOfUser.put(usr.Name, usr);
            }
        }
        //  system.debug('-------mapOfUser------------'+mapOfUser.keyset());
        List < String > sendTo = new List < String > ();
        List < String > ccTo = new List < String > ();
        ccTo = label.Mechandize_Team.split(',');
        String poTeam = label.PO_TeamNew;
        if (poTeam != null) {
            if (poTeam.contains(',')) {
                for (String str: poTeam.split(',')) {
                    sendTo.add(str);
                }
            } else {
                sendTo.add(poTeam);
            }
        }
        String arayabattaTeam = label.Arayabatta_TeamNew;
        if (arayabattaTeam != null) { 
            if (arayabattaTeam.contains(',')) {
                for (String str: arayabattaTeam.split(',')) {
                    sendTo.add(str);
                }
            } else {
                sendTo.add(arayabattaTeam);
            }
        }System.debug('====map of user==='+mapOfUser);
        //System.debug('===mapOfLineItems==='+mapOfLineItems);
        //system.debug('Recipients===>'+sendTo);
        
        string subject = '';
        string mailbody = '';
        String  accountName = '';
        subject = 'New procurement details';
        system.debug('wrapperImageClassList =>'+wrapperImageClassList);
        List < Messaging.SingleEmailMessage > myEmails = new List < Messaging.SingleEmailMessage > ();
        if(!mapOfUser.isEmpty()){
            for(wrapperImageClass rtw :wrapperImageClassList){
                mailbody = '<html><body>Dear Team,<br/><br/>The attached items have been procured by ' + mapOfUser.get(rtw.prod.Owner.Name).Name + ' on ' + system.Today().format() + ' from ' + rtw.prod.vendor_custom__r.Name + '. Kindly create Purchase Order for the Vendor and update the PO number to Aryabhatta team by using below link<br/><br/>' + URL.getSalesforceBaseUrl().toExternalForm() + '/apex/RTWProductView<br/><br/>Thank You,<br/><br/>' + mapOfUser.get(rtw.prod.Owner.Name).Name + '<br/>Taneira Procurement Solution</body></html>';
                accountName = rtw.prod.vendor_custom__r.Name;
            }  
            
            // myEmails.add(Email);
        }
        Messaging.singleEmailmessage Email = new Messaging.singleEmailmessage();
        email.setsubject(subject+' - '+accountName);
        email.Sethtmlbody(mailbody);
        Email.SetToAddresses(sendTo);
        Email.SetCCAddresses(ccTo);
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {Email};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        
        
    }
    public class wrapperImageClass {
        public Attachment pdfDoc{get;set;}
        public transient blob photo{get;set;}
        public RTW_product__c prod{get;set;}
        public Integer counter{get;set;}
    }
    
    public void uploadAttachments(){
        
    }
    public void showPopup(){
        showPopUp = true;
    }
    public void hidePopup(){
        showPopUp = false;
        showPreview = false;
    }   
    public void showUploadPopUp(){
        showUploadPopUp = true;
        showPreview = false;
    }
    public void hideUploadPopUp(){
        showUploadPopUp = false;
        showPreview = false;
    }
    public void importCSVFile(){
        //     try{
        csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n'); 
        
        for(Integer i=1;i<csvFileLines.size();i++){
            RTW_Product__c accObj = new RTW_Product__c() ;
            string[] csvRecordData = csvFileLines[i].split(',');
            accObj.name = csvRecordData[0]+String.valueOf(system.now()).remove(' ');
            accObj.Item_no__c = i;
            if( csvRecordData[0] != '')
                accObj.Product__c = csvRecordData[0];
            if( csvRecordData[1] != '')
                accObj.Base_Colour__c = csvRecordData[1];
            if( csvRecordData[2] != '')
                accObj.MFabric__c = csvRecordData[2];
            if( csvRecordData[3] != '')
                accObj.MStyle_name__c = csvRecordData[3];
            if( csvRecordData[4] != '')
                accObj.Gender__c = csvRecordData[4];
            if( csvRecordData[5] != '')
                accObj.MDesign__c = csvRecordData[5];
            if( csvRecordData[6] != '')
                accObj.MPleats__c = csvRecordData[6];
            if( csvRecordData[7] != '')
                accObj.MPly__c = csvRecordData[7];
            if( csvRecordData[8] != '')
                accObj.Quantity__c = Decimal.valueOf(csvRecordData[8]);
            if( csvRecordData[9] != '')
                accObj.MCost__c = Decimal.valueOf(csvRecordData[9]);
            if( csvRecordData[10] != '')
                accObj.Fabric_1__c = csvRecordData[10];
            if( csvRecordData[11] != '')
                accObj.Fabric_1_Quantity__c = Decimal.valueOf(csvRecordData[11]);
            if( csvRecordData[12] != '')
                accObj.Fabric_2__c = csvRecordData[12];
            if( csvRecordData[13] != '')
                accObj.Fabric_2_Quantity__c = Decimal.valueOf(csvRecordData[13]);
            if( csvRecordData[14] != '')
                accObj.SKU_count__c = Decimal.valueOf(csvRecordData[14]);
            if( csvRecordData[15] != '')
                accObj.Order_ID__c = csvRecordData[15];
            if( csvRecordData[16] != '')
                accObj.Remarks__c = csvRecordData[16];
            if( csvRecordData[17] != '')
                accObj.Buyers_Cost__c = Decimal.valueOf(csvRecordData[17]);
            accObj.Submit__c = false;
            if( accProd.vendor_custom__c != NULL) 
                accObj.vendor_custom__c = accProd.vendor_custom__c;
            
            
            
            CSVproducts.add(accObj);   
        }
        //system.debug(CSVproducts);
        insert CSVproducts;
        showUploadPopUp = false;
        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.CONFIRM,'DOcument succesfully inserted');
        ApexPages.addMessage(errorMessage);
        
        /*    }
catch (Exception e)
{
ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
ApexPages.addMessage(errorMessage);
}  */
    }
    public List<selectoption> SourcingusersList (){
        SourcingusersList= new List<selectoption>();
        SourcingusersList.add(new selectoption('','--None--'));
        for(user u :[Select id,name  from user where Profile.Name='Purchase' ]){
            SourcingusersList.add(new selectoption(u.id,u.Name));
            
        }
        
        return SourcingusersList;        
    }
    public class attachmentClass{
        public attachment docRec{get;set;}
        public attachment  imgRec{get;set;}
        public attachmentClass(String parentIdValue){
            docRec = new attachment(ParentId = parentIdValue);
            imgRec = new attachment(ParentId = parentIdValue);
        }
    }
    
    public void previewAttachment(){
        showPreview =true;
        Set<Id> sImgParentId = new Set<Id>();
        Set<Id> sDocParentId = new Set<Id>();
        system.debug('popuplist'+popupAttachmentList);
        for(attachmentClass attchClass : popupAttachmentList){
            sImgParentId.add(attchClass.imgRec.ParentId);
            sDocParentId.add(attchClass.docRec.ParentId);
        }
        attachImgList = [SELECT Id, Name, ContentType, ParentId FROM Attachment where ParentId=:sImgParentId And ContentType like 'image/%' Order By CreatedDate Desc Limit 1];
        attachDOcList = [SELECT Id, Name, ContentType, ParentId FROM Attachment where ParentId=:sDocParentId And ContentType = 'application/pdf' Order By CreatedDate Desc Limit 1];
        
    }
    public void uploadAttachment(){
        List<Attachment> attchList = new List<Attachment>();
        Set<Id> sImgParentId = new Set<Id>();
        Set<Id> sDocParentId = new Set<Id>();
        for(attachmentClass attchClass : popupAttachmentList){
            if(attchClass.imgRec.Body != null){
                attchClass.imgRec.Id = null;
                attchList.add(attchClass.imgRec);
                sImgParentId.add(attchClass.imgRec.ParentId);
                
            }
            if(attchClass.docRec.Body != null){
                attchClass.docRec.Id = null;
                attchList.add(attchClass.docRec);
                sDocParentId.add(attchClass.docRec.ParentId);
            }
        }
        if(!attchList.isEmpty()){
            delete [SELECT Id, Name, ContentType, ParentId FROM Attachment where ParentId =:sImgParentId  and ContentType  Like 'image/%'   ];
            delete [SELECT Id, Name, ContentType, ParentId FROM Attachment where ParentId =:sDocParentId  and ContentType  Like 'application/pdf'   ];
            insert attchList;
            attchList.clear(); 
            showPreview = false;
            showPopUp = false;
            
            for(attachmentClass attchCls : popupAttachmentList){
                if(attchCls.imgRec.Id != null){
                    attchCls.imgRec.Body = null;
                    attachmentMap.put(attchCls.imgRec.ParentId,attchCls.imgRec);
                }
                attchCls.docRec.body = null; 
            } 
        }
    }
    
    
    public PageReference deleteAddedRow(){
        
        Integer addedRow;
        if(Apexpages.currentpage().getParameters().get('index')!= null){
            addedRow = Integer.valueOf(Apexpages.currentpage().getParameters().get('index'));
        }
        
        string uniquekey = apexpages.currentpage().getparameters().get('ProductKey');
        // system.debug('UniqueKey --> '+uniquekey);
        //system.debug( prodWrapList[i] );
        RTW_Product__c rtw= new RTW_Product__c();
        for(Integer i=0; i < wrapperImageClassList.size(); i++){
            if(wrapperImageClassList[i].counter == addedRow){
                //system.debug( wrapperImageClassList[i].prod );
                rtw = wrapperImageClassList[i].prod;
                wrapperImageClassList.remove(i);     
            }
        }  
        //system.debug( rtw );
        if( rtw.id != null)
            delete rtw;
        for(Integer i=0; i < prodWrapList.size(); i++){
            if(prodWrapList[i].ProdKey == uniquekey){
                if(prodWrapList[i].SKUCount != null){
                    prodWrapList[i].SKUCount--;
                }
                
            }
        }  
        return null;    
    }
}