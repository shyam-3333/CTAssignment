public class TaneiraProdAttributionVF {
    public List<product__c> prodList{get;set;}
    Public boolean showUploadPopUp{get;set;}
    public blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<product__c> prodListUpdated;
    public List<product__c> Productlist;
   // public List<product__c> CSVproducts;
    public List<product__c> AttProdList{get;set;}
    public list<productWrraper> wrraperList{get;set;}
    public list<String> finalRecordSet{get;set;}
    public list<SelectOption> userList{get;set;}
    public List<productPOWrraper> poWrapper{get;set;}
    public String SLno{get;set;}
    public boolean Hidebutton{get;set;}
    public boolean showmessage{get;set;}
    public List<TaneiraPO__c> tanPO{get;set;}
    //List<User> userList= new List<User>();
    public string datbase;
    public string cntrlcode;
    public string UOM;
    public string proddata;
    List<User> userList2= new List<User>();
    public Map<id,decimal> importproc; 
    public List<productMMWrraper> mmWrapper{get;set;}
    public Map<String,String> prodCategoryCode {get;set;}
    public Map<String,String> prodWarp {get;set;}
    public Map<String,String> prodOrigin {get;set;}
    public Map<String,String> tanHie {get;set;}
    public Map<String,Master__c> ctrlCode {get;set;}
    public Map<String,String> unitMeasure {get;set;}
   // public String priceband;
    // public List<product__c> prodListExcel{get;set;}
    public Double quantity {get;set;}
    public String param{get;set;}
    public string header{get;set;}
    public string headerUSKD{get;set;}
    public string csvOutput{get;set;}
    public boolean check{get;set;}
    public boolean imported{get;set;}
    public String copyValue{get;set;}
    public String selectedCategoryUser{get;set;}
    public boolean rendValue{get;set;}
    public Map<string,string> userValues;
    public Map<string,string> UserEmail;
    //public String Buttonh{get;set;}
    String productKey;
    String accId;
    String origin;
    String Category;
    String Createddate;
    public Boolean colorCheck{get;set;}
    public  TaneiraProdAttributionVF(){
        //userList();
        //showmsg = false;
        showmessage = false;
        colorCheck = false;
        showUploadPopUp = false;
        
        check = true;
        rendValue = false;
        userValues = new map<String, String>();
        UserEmail = new map<String, string>();
        userList = new list<SelectOption>();
       userList.add(new SelectOption('None','None'));
        tanPO = new list<TaneiraPO__c>();
        tanPO = TaneiraPO__c.getall().values();
        
        for(User uname : [SELECT Id,Name,Email FROM User WHERE Profile.Name = 'Category' ORDER BY Name]){
            userList.add(new SelectOption(uname.Id, uname.Name ));
            userValues.put(uname.Id, uname.Name);
            UserEmail.put(uname.Id,uname.Email);
        }
        for(User uname : [SELECT Id,Name,Email FROM User WHERE Profile.Name = 'Attribution' OR Profile.Name = 'System Administrator' ORDER BY Name]){
            UserEmail.put(uname.Id,uname.Email);
        }        
        productKey = apexpages.currentpage().getparameters().get('ProductKeyFinder');
        accId = apexpages.currentpage().getparameters().get('Vendor');
        origin = apexpages.currentpage().getparameters().get('Origin');
        Category = apexpages.currentpage().getparameters().get('Category');
        Createddate = apexpages.currentpage().getparameters().get('CDate');
         SLno = apexpages.currentpage().getparameters().get('serialnumber');
        
        date oldDate = Date.today().addDays(-15);
        prodListUpdated = new list<Product__c>();
        //   prodListExcel = new list<Product__c>();
       // header = 'Id,Record Type,SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Warp,Weft,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock,Order ID';
        header='Id,SKU,Procurement Cost,Quantity';
        if(prodList != null && prodList.size() > 0 && prodList[0].Product_Category_Taneira__c == 'USKD') {
            
            header = 'Id,Record Type,SKU,Product,Vendor,Vendor Prod Code,Proc Type,Proc Source,Origin,PO Number,Username,MRP,Cost,Dupatta Fabric,Kurta Fabric,Salwar Fabric,Design Story,Story 1,Story 2,Design Description,Base Colour,Detailed Colour,Quantity,Fabric,Zari Type,Loom,Occasion,Blouse Size,Blouse Type,Craft,Fold,Handloom Mark,Collection,Body Pattern,Body Des Element,Body Des Material,Body Des Density,Border Pattern,Border Des Element,Border Des Material,Border Size,Pallu Pattern,Pallu Design,Pallu Des Material,Pallu Des Density,Pallu Size,Comments,Vendor Code,Warehouse Stock,Sold Stock,Store Stock,Order ID';
        }
        
        prodList = [Select Dupatta_Fabric__c,No_of_pieces__c,Kurta_Fabric__c,PO_sent_status__c,Salwar_Fabric__c,FabricR__c,CraftR__c,vendor_custom__r.Vendor_code__c,Id,Product_Key_Finder__c,Owner.Email,Story_1__c,Story_2__c,Design_Description__c,RecordTypeId,name,Photo__c,Proc_Source__c,OwnerId,Owner.Name,Design_Story__c ,Fold__c,Offline_Username__c,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,Detailed_Colour__c,Fabric__c ,Collection__c,Collection_Update__c,Pallu_Size__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,
                    Colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Taneira_Material_Weft__c,Pallu_Design__c,
                    Saree_Dimensions__c,Sync_Date__c,SKU_Code__c,Material_Wrap__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,
                    Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Blouse_Type__c,Border_Size__c,PO_Number__c,Handloommark__c,Pallu_Des_Density__c,Comments__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c,Order_Id__c, 
                    Body_Pattern_Update__c,Body_Des_Element_Update__c,Body_Des_Material_Update__c,Body_Des_Density_Update__c,Border_Pattern_Update__c,Border_Des_Material_Update__c,Border_Des_Element_Update__c,
                    Border_Size_Update__c,Pallu_Pattern_Update__c,Pallu_Design_Update__c,Pallu_Des_Material_Update__c,Pallu_Des_Density_Update__c,Pallu_Size_Update__c,Yardage_Consumption__c,Yardage_Cost__c,Yardage_SKU_Code__c,Yardage_UCP__c,Procurement_Cost__c,Packing_Logistic_Cost__c,
                    Occasion_Update__c, Design_Story_Update__c, Story_1_Update__c,Story_2_Update__c,Buyers_Cost__c,Vendor_code__c,Vendor_TaxCode__c,Price_Band__c From Product__c
                    WHERE Product_Key_Finder__c =:productKey AND Created_From__c = 'Offline App' Order By SKU_Code__c ASC];
        System.debug('Debug prodList===>'+prodList);
        System.debug('ProdList Size=====>'+prodList.size());
        wrraperList = new List<productWrraper>();
        poWrapper = new List<productPOWrraper>();
        mmWrapper = new List<productMMWrraper>();
        prodCategoryCode = new Map<String,String>();
        prodWarp = new Map<String,String>();
        prodOrigin = new Map<String,String>();
        tanHie = new Map<String,String>();
        ctrlCode = new Map<String,Master__c>();
        unitMeasure = new Map<String,String>();
        
        for(Master__c mas: [select Name,Code__c from Master__c where Name__c = 'Product Category']){
            if(mas.Name!= null && mas.Code__c!= null){
                prodCategoryCode.put(mas.Name, mas.Code__c);
            }
        }
        for(Master__c mas: [select Name,Fabric_Code__c from Master__c where Name__c = 'Warp']){
            if(mas.Name!= null && mas.Fabric_Code__c!= null){
                prodWarp.put(mas.Name, mas.Fabric_Code__c);
            }
        }
        for(Master__c mas: [select Name,Code__c from Master__c where Name__c = 'Origin']){
            if(mas.Name!= null && mas.Code__c!= null){
                prodOrigin.put(mas.Name, mas.Code__c);
            }
        }
        for(Master__c mas: [select Name,Hierarchy_Code__c from Master__c where Name__c = 'Product Category']){
            if(mas.Name!= null && mas.Hierarchy_Code__c!= null){
                tanHie.put(mas.Name, mas.Hierarchy_Code__c);
            }
        }
        for(Master__c mas: [select Name, X8Digit_Code__c, Active__c, X6Digit_Code__c from Master__c where Name__c = 'Control Code']){
            if(mas.Name!= null && mas.X8Digit_Code__c!= null && mas.X6Digit_Code__c!= null){
                ctrlCode.put(mas.Name, mas);
            }
        }
        for(Master__c mas: [select Name,Unit_of_Measure__c from Master__c where Name__c = 'Product Category']){
            if(mas.Name!= null && mas.Unit_of_Measure__c!= null){
                unitMeasure.put(mas.Name, mas.Unit_of_Measure__c);
            }
        }
        String firstSubString;
        String secondSubString;
        if(!prodList.isEmpty()){
            for(Product__c prod: prodList){
                //if(String.ValueOf(prod.CreatedDate).substring(0,13)==String.valueOf(Createddate).substring(0,13) || Test.isRunningTest()){
                prodListUpdated.add(prod);
                //}
                
            }
        }
        System.debug('====Updated Prod List===>'+prodListUpdated);
        System.debug('====Updated Prod List Size===>'+prodListUpdated.size());
        System.debug('Again prodList size====>'+prodList.size());
        for(product__c pro : prodListUpdated){
            productWrraper proWrr = new productWrraper();
            productPOWrraper proPOWrr = new productPOWrraper();
            productMMWrraper proMMWrr = new productMMWrraper();
            if(!String.isBlank(pro.Photo__c) && pro.Photo__c !=NULL){
                firstSubString = pro.Photo__c.substringBetween('<img', 'img>');
                secondSubString = firstSubString.substringBetween('src="', '"');
                proWrr.imgLink = secondSubString.replace('amp;', '');
                
            }System.debug('::::proWrr.imgLink:::@@@@::: '+proWrr.imgLink);
            if(pro.Comments__c != null){
                
                proWrr.comments = pro.Comments__c.escapeCsv();
            }
            if( pro.PO_sent_status__c ==true){
                Hidebutton = false;
            }
            else{
                Hidebutton = true;
            }
            if(pro.PO_Number__c != null)  {
                showmessage =true;
            }
            system.debug('**proWrr.comments**'+proWrr.comments);
            proWrr.productRec = pro;
            proPOWrr.productRec = pro;
            proMMWrr.proRec = pro;
            
            if(tanPO.size() > 0){
                proPOWrr.plant = tanPO[0].Name;
                proPOWrr.storageLocation = tanPO[0].Storage_Location__c;
                proPOWrr.purchaseGroup = tanPO[0].Purchase_Group__c;
                proMMWrr.plant = tanPO[0].Name;
                proMMWrr.storageLocation = tanPO[0].Storage_Location__c;
                proMMWrr.profitCenter = tanPO[0].Profit_Center__c;
            }
            
            if((prodCategoryCode!= null) && (proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'Saree' || proMMWrr.proRec.Product_Category_Taneira__c== 'Stole' || proMMWrr.proRec.Product_Category_Taneira__c== 'Yardage' || proMMWrr.proRec.Product_Category_Taneira__c== 'Pavadai' || proMMWrr.proRec.Product_Category_Taneira__c== 'Shawl' || proMMWrr.proRec.Product_Category_Taneira__c== 'Dupatta')){
                String des = ' ';
                String data = '';
                proMMWrr.conditionsMet = true;
                if(proMMWrr.proRec.Product_Category_Taneira__c.length()>=1){
                    data   = proMMWrr.proRec.Product_Category_Taneira__c.toUpperCase();
                    System.debug('Lenght of data : '+data);
                }
                if(prodCategoryCode.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)){
                    des = des + prodCategoryCode.get(proMMWrr.proRec.Product_Category_Taneira__c);
                    system.debug('inside description 1');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                else{
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 2');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                System.debug('Lenght of origin : '+proMMWrr.proRec.Cluster__c.length());
                System.debug(Taneira_Product_Description__c.getValues('SAREE').Number_Of_Letters_For_Origin__c); 
                
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_Of_Letters_For_Origin__c)){
                    des =  des + '-' + proMMWrr.proRec.Cluster__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_Of_Letters_For_Origin__c)).trim();
                    system.debug('inside description 3');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_Of_Letters_For_Origin__c)){
                    des = des + '-' + proMMWrr.proRec.Cluster__c.trim();
                    system.debug('inside description 4');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Cluster__c== null || proMMWrr.proRec.Cluster__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 5');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Material_Wrap__c!= null && proMMWrr.proRec.Material_Wrap__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)){
                    des = des + '-' + proMMWrr.proRec.Material_Wrap__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)).trim();
                    system.debug('inside description 6');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Material_Wrap__c!= null && proMMWrr.proRec.Material_Wrap__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_warp__c)){
                    des = des + '-' + proMMWrr.proRec.Material_Wrap__c.trim();
                    system.debug('inside description 7');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Material_Wrap__c== null || proMMWrr.proRec.Material_Wrap__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 8');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Taneira_Material_Weft__c!= null && proMMWrr.proRec.Taneira_Material_Weft__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)){
                    des = des + '-' + proMMWrr.proRec.Taneira_Material_Weft__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)).trim();
                    system.debug('inside description 9');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Taneira_Material_Weft__c!= null && proMMWrr.proRec.Taneira_Material_Weft__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_weft__c)){
                    des = des + '-' + proMMWrr.proRec.Taneira_Material_Weft__c.trim();
                    system.debug('inside description 10');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Taneira_Material_Weft__c== null || proMMWrr.proRec.Taneira_Material_Weft__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 11');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)).trim();
                    system.debug('inside description 12');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(data).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.trim();
                    system.debug('inside description 13');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Workmanship__c== null || proMMWrr.proRec.Workmanship__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 14');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Pure') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Pure').Value__c;
                    system.debug('inside description 15');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Tested') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Tested').Value__c;
                    system.debug('inside description 16');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Faux') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Faux').Value__c;
                    system.debug('inside description 17');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('NIL') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('NIL').Value__c;
                    system.debug('inside description 18');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c== null || proMMWrr.proRec.Zari_Type__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 19');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(!(proMMWrr.proRec.Zari_Type__c.contains('Pure') || proMMWrr.proRec.Zari_Type__c.contains('Tested') || proMMWrr.proRec.Zari_Type__c.contains('Faux') || proMMWrr.proRec.Zari_Type__c.contains('NIL'))){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside description 20');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                system.debug('inside description 21');
                system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                system.debug('cellHighlight----' + proMMWrr.cellHighlight);
                proMMWrr.materialDescription = des;
                 datbase = des;
               
            }
            
            if((prodCategoryCode!= null) && (proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'USKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'SSKD')){
                String des = ' ';
                proMMWrr.conditionsMet = true;
                if(prodCategoryCode.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)){
                    des = des + prodCategoryCode.get(proMMWrr.proRec.Product_Category_Taneira__c);
                    system.debug('inside 1');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                else{
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside 2');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_Of_Letters_For_Origin__c)){
                    des =  des + '-' + proMMWrr.proRec.Cluster__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_Of_Letters_For_Origin__c)).trim();
                    system.debug('inside 3');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Cluster__c!= null && proMMWrr.proRec.Cluster__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_Of_Letters_For_Origin__c)){
                    des = des + '-' + proMMWrr.proRec.Cluster__c.trim();
                    system.debug('inside 4');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Cluster__c== null || proMMWrr.proRec.Cluster__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside 5');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Fabric__c!= null && proMMWrr.proRec.Fabric__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_fabric__c)){
                    des = des + '-' + proMMWrr.proRec.Fabric__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_fabric__c)).trim();
                    system.debug(' inside 6');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Fabric__c!= null && proMMWrr.proRec.Fabric__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_fabric__c)){
                    des = des + '-' + proMMWrr.proRec.Fabric__c.trim();
                    system.debug('inside 7');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Fabric__c== null || proMMWrr.proRec.Fabric__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside 8');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()>= Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.substring(0,Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_craft__c)).trim();
                    system.debug('inside 9');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Workmanship__c!= null && proMMWrr.proRec.Workmanship__c.length()< Integer.valueOf(Taneira_Product_Description__c.getValues(proMMWrr.proRec.Product_Category_Taneira__c).Number_of_letters_for_craft__c)){
                    des = des + '-' + proMMWrr.proRec.Workmanship__c.trim();
                    system.debug('inside 10');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Workmanship__c== null || proMMWrr.proRec.Workmanship__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside 11');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Pure') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Pure').Value__c;
                    system.debug('inside 12');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Tested') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Tested').Value__c;
                    system.debug('inside 13');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('Faux') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('Faux').Value__c;
                    system.debug('inside 14');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c!= null && proMMWrr.proRec.Zari_Type__c.indexOf('NIL') != -1){
                    des = des + '-' + TaneiraZari__c.getValues('NIL').Value__c;
                    system.debug('inside 15');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(proMMWrr.proRec.Zari_Type__c== null || proMMWrr.proRec.Zari_Type__c== ''){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside 16');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                if(!(proMMWrr.proRec.Zari_Type__c.contains('Pure') || proMMWrr.proRec.Zari_Type__c.contains('Tested') || proMMWrr.proRec.Zari_Type__c.contains('Faux') || proMMWrr.proRec.Zari_Type__c.contains('NIL'))){
                    proMMWrr.conditionsMet = false;
                    proMMWrr.cellHighlight = 'red';
                    system.debug('inside 17');
                    system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                }
                system.debug('inside 18');
                system.debug('conditionsMet----' + proMMWrr.conditionsMet);
                system.debug('cellHighlight------'+proMMWrr.cellHighlight);
                proMMWrr.materialDescription = des;
                 datbase = des;
                
            }
            
            if((proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'SAREE' || proMMWrr.proRec.Product_Category_Taneira__c== 'Duppata' || proMMWrr.proRec.Product_Category_Taneira__c== 'Yardage' || proMMWrr.proRec.Product_Category_Taneira__c== 'Pavadai')){
                String hie = 'TA';
                String data = '';
                proMMWrr.conditionsMetHierarchy = true;
                if(proMMWrr.proRec.Product_Category_Taneira__c.length()>=1){
                    data   = proMMWrr.proRec.Product_Category_Taneira__c.toUpperCase();
                }
                if(proMMWrr.proRec.Product_Category_Taneira__c.length()>= Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_Product_Category__c)){
                    hie = hie + proMMWrr.proRec.Product_Category_Taneira__c.substring(0,Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_Product_Category__c));
                    system.debug('inside hierarchy 1');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                if(proMMWrr.proRec.Loom__c!= null && proMMWrr.proRec.Loom__c.length()>= Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_loom__c)){
                    hie = hie + proMMWrr.proRec.Loom__c.substring(0,Integer.valueOf(Taneira_Product_Hierarchy__c.getValues(data).Number_of_letters_for_loom__c));
                    system.debug('inside hierarchy 2');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                if(proMMWrr.proRec.Loom__c== null || proMMWrr.proRec.Loom__c== ''){
                    proMMWrr.conditionsMetHierarchy = false;
                    proMMWrr.cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 3');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                if(proMMWrr.proRec.Material_Wrap__c!= null && prodWarp!= null && prodWarp.containsKey(proMMWrr.proRec.Material_Wrap__c)){
                    hie = hie + prodWarp.get(proMMWrr.proRec.Material_Wrap__c);
                    system.debug('inside hierarchy 4');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                else{
                    proMMWrr.conditionsMetHierarchy = false;
                    proMMWrr.cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 5');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                hie = hie + '00009999';
                if(proMMWrr.proRec.Cluster__c!= null && prodOrigin!= null && prodOrigin.containsKey(proMMWrr.proRec.Cluster__c)){
                    hie = hie + prodOrigin.get(proMMWrr.proRec.Cluster__c);
                    system.debug('inside hierarchy 6');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                else{
                    proMMWrr.conditionsMetHierarchy = false;
                    proMMWrr.cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 7');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                system.debug('inside hierarchy 8');
                system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                system.debug('cellHighlightHierarchy----' + proMMWrr.cellHighlightHierarchy);
                hie = hie + 'L';
                proMMWrr.productHierarchy = hie;
                proddata = hie;
                System.debug('hie1111111111111111111111111111111'+hie);
            }
            
            if((proMMWrr.proRec.Product_Category_Taneira__c!= null) && (proMMWrr.proRec.Product_Category_Taneira__c== 'USKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'SSKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'Stole')){
                String hie = 'TA';
                proMMWrr.conditionsMetHierarchy = true;
                if(tanHie!= null && tanHie.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)){
                    hie = hie + tanHie.get(proMMWrr.proRec.Product_Category_Taneira__c);
                    system.debug('inside hierarchy 1');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                else{
                    proMMWrr.conditionsMetHierarchy = false;
                    proMMWrr.cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 2');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                if(proMMWrr.proRec.Blouse_Type__c!= null){
                    hie = hie + Taneira_Blouse_Type__c.getValues(proMMWrr.proRec.Blouse_Type__c).Code__c;
                    system.debug('inside hierarchy 3');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                else{
                    proMMWrr.conditionsMetHierarchy = false;
                    proMMWrr.cellHighlightHierarchy = 'red';
                    system.debug('inside hierarchy 4');
                    system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                }
                hie = hie + '00009999TAL';
                proMMWrr.productHierarchy = hie;
                proddata = hie;
                System.debug('hie1111111111111111111111111111111'+hie);
                system.debug('inside hierarchy 5');
                system.debug('conditionsMetHierarchy----' + proMMWrr.conditionsMetHierarchy);
                system.debug('cellHighlightHierarchy----' + proMMWrr.cellHighlightHierarchy);
            }
            
            if(proMMWrr.productHierarchy!= null && proMMWrr.productHierarchy!= ''  && ctrlCode!= null && ctrlCode.containsKey(proMMWrr.productHierarchy.substring(2,7))){
                system.debug('productHierarchy-----'+ proMMWrr.productHierarchy);
                system.debug('productHierarchy-----'+ proMMWrr.productHierarchy.substring(2,7));
                if(proMMWrr.proRec.Buyers_Cost__c!= null && proMMWrr.proRec.Buyers_Cost__c>=1000 && ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).Active__c== true){
                    proMMWrr.controlCode = ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).X8Digit_Code__c;
                    cntrlcode =proMMWrr.controlCode;
                }
            }
            if(proMMWrr.productHierarchy!= null  && ctrlCode!= null  && ctrlCode.containsKey(proMMWrr.productHierarchy.substring(2,7))){
                if(proMMWrr.proRec.Buyers_Cost__c!= null && proMMWrr.proRec.Buyers_Cost__c<1000 && ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).Active__c== true){
                    proMMWrr.controlCode = ctrlCode.get(proMMWrr.productHierarchy.substring(2,7)).X6Digit_Code__c;
                    cntrlcode =proMMWrr.controlCode;
                }
            }
            
            if((unitMeasure!= null) && (proMMWrr.proRec.Product_Category_Taneira__c!= null) && (unitMeasure.containsKey(proMMWrr.proRec.Product_Category_Taneira__c)) && (proMMWrr.proRec.Product_Category_Taneira__c== 'Scarf' || proMMWrr.proRec.Product_Category_Taneira__c== 'Multi Piece Saree' || proMMWrr.proRec.Product_Category_Taneira__c== 'Saree' || proMMWrr.proRec.Product_Category_Taneira__c== 'Stole' || proMMWrr.proRec.Product_Category_Taneira__c== 'Yardage' || proMMWrr.proRec.Product_Category_Taneira__c== 'Pavadai' || proMMWrr.proRec.Product_Category_Taneira__c== 'Shawl' || proMMWrr.proRec.Product_Category_Taneira__c== 'Dupatta' || proMMWrr.proRec.Product_Category_Taneira__c== 'USKD' || proMMWrr.proRec.Product_Category_Taneira__c== 'SSKD')){
                proMMWrr.unitOfMeasure = unitMeasure.get(proMMWrr.proRec.Product_Category_Taneira__c);
                UOM = proMMWrr.unitOfMeasure;
            }
            
            wrraperList.add(proWrr);
            poWrapper.add(proPOWrr);
            mmWrapper.add(proMMWrr);
        }
        csvOutput = JSON.serialize(wrraperList);
        System.debug('Heap Size----->>'+csvOutput);
        Integer i = 0;
    }
/*public List<selectoption> userList (){
        userList= new List<selectoption>();
        userList.add(new selectoption('','--None--'));
        for(user u :[Select id,name  from user where Profile.Name='Attribution' ]){
            userList.add(new selectoption(u.id,u.Name));
            
        }
        
        return userList;        
    } */   
    
    public pagereference downloadProducts(){
        
        finalRecordSet = new List<String>();
        List<String> tmp;
        
        quantity=0;
        System.debug('prodList size in downloadProducts===>'+prodListUpdated.size());
        if(!prodListUpdated.isEmpty()){
            for(Product__c prod:prodListUpdated){
                if(prod.Quantity__c !=NULL){
                    System.debug('prod offlineUser===>'+prod.Offline_Username__c);
                    System.debug('Prod Sync Date====>'+prod.CreatedDate);
                    System.debug('prodQuantity-->'+prod.Quantity__c);
                    quantity+=prod.Quantity__c;
                }  
            }System.debug('Quantity-->'+quantity);
        }       
        List<User> userList1= new List<User>();
        Set<Id> prodIdSet= new Set<Id>();
        Set<Id> userIdSet= new Set<Id>();
        if(!wrraperList.isEmpty()){
            
            
            for(productWrraper wrap:wrraperList){
                
                tmp = new List<String>();
                tmp.add(wrap.productRec.Id);
                tmp.add(wrap.productRec.RecordTypeId);
                tmp.add(wrap.productRec.SKU_Code__c);
                
                if(prodList != null && prodList.size() > 0 && prodList[0].Product_Category_Taneira__c == 'USKD') {
                    
                    tmp.add(wrap.productRec.Product_Category_Taneira__c);
                }
                finalRecordSet.add(String.join(tmp, ','));
                
                prodIdSet.add(wrap.productRec.Id);
                userIdSet.add(wrap.productRec.Owner.Id);
                System.debug('==wrap data====>'+wrap.productRec.Id);
                System.debug('==wrap.productRec.Owner.Id====>'+wrap.productRec.Owner.Id);
            }
        }
        Integer prodCount=0,counter=0;
        List<User> userList= new List<User>();
        if(!userIdSet.isEmpty()){
            userList=[SELECT Id,Name,Email,Counter__C FROM User WHERE ID IN:userIdSet];
        }System.debug('------userList----->'+userList);
        List<Product__C> prodctList= new List<Product__C>();
        List<Product__C> prodctList1= new List<Product__C>();
        if(!prodIdSet.isEmpty()){
            prodctList=[SELECT ID,Name,AlreadyDownloaded__c FROM Product__c WHERE ID IN :prodIdSet];
        }
        System.debug('-----prodctList with already downloaded value-----'+prodctList);
        if(!prodctList.isEmpty()){
            for(Product__C prod:prodctList){
                if(prod.AlreadyDownloaded__c ==True){
                    break;
                }else{
                    prodCount++;
                    System.debug('---prodCount inside else----'+prodCount);
                    prod.AlreadyDownloaded__c=true;
                    prodctList1.add(prod);
                }
            }
        }if(prodCount ==prodctList.size()){
            counter++;
            System.debug('---counter----'+counter); 
        }System.debug('---prodctList1--'+prodctList1);
        if(!prodctList1.isEmpty()){
            update prodctList1;
        }
        if(!userList.isEmpty()){
            for(User usr:userList){
                System.debug('====user list value===='+usr.Name);
                System.debug('====user counter value===='+usr.Counter__c);
                if(usr.Counter__c !=NULL){
                    usr.Counter__c += counter;
                }
                userList1.add(usr);
            }
        }
        if(userList1.size()>0){
            update userList1;
        }
        System.debug('-----userList1------'+userList1);
        
        //--------------------------------------------------
        
        if(userList1.size()>0 && prodListUpdated.size()>0)
        {
            System.debug('=======prodListUpdated.OfflineUsername====='+prodListUpdated[0].Offline_UserName__C);
            param='SS00'+userList1[0].Counter__c+prodListUpdated[0].Offline_UserName__C+'_'+'_'+String.valueOf(Date.newInstance(prodListUpdated[0].CreatedDate.Year(),prodListUpdated[0].CreatedDate.Month(),prodListUpdated[0].CreatedDate.Day()))+'_'+prodListUpdated[0].Vendor_Name__c+'-'+prodListUpdated[0].Cluster__c+'_'+quantity;
            
        }else{
            param='SS00DefaultUserDefUserNameTodayDefVendorDefCluster+DefQuantity';
        }
        System.debug('==param=='+param);
        
        //csvOutput =
        //csvOutput =  JSON.serialize(recordsSet);
        PageReference page = new PageReference('/apex/TnraProdDwnldPage');
        
        return page;
        
    }
   public pagereference  downloadProductsproc(){
      PageReference page1 = new PageReference('/apex/TaneiraAttributionDownload'); 
       return page1;
   }
    /*public pagereference downloadProductsPdf(){
quantity=0;
System.debug('prodList size in downloadProducts===>'+prodListUpdated.size());
if(!prodListUpdated.isEmpty()){
for(Product__c prod:prodListUpdated){
if(prod.Quantity__c !=NULL){
System.debug('prod offlineUser===>'+prod.Offline_Username__c);
System.debug('Prod Sync Date====>'+prod.CreatedDate);
System.debug('prodQuantity-->'+prod.Quantity__c);
quantity+=prod.Quantity__c;
}  
}System.debug('Quantity-->'+quantity);
}       
List<User> userList1= new List<User>();
Set<Id> prodIdSet= new Set<Id>();
Set<Id> userIdSet= new Set<Id>();
if(!wrraperList.isEmpty()){
for(productWrraper wrap:wrraperList){
prodIdSet.add(wrap.productRec.Id);
userIdSet.add(wrap.productRec.Owner.Id);
System.debug('==wrap data====>'+wrap.productRec.Id);
System.debug('==wrap.productRec.Owner.Id====>'+wrap.productRec.Owner.Id);
}
}
Integer prodCount=0,counter=0;
List<User> userList= new List<User>();
if(!userIdSet.isEmpty()){
userList=[SELECT Id,Name,Email,Counter__C FROM User WHERE ID IN:userIdSet];
}System.debug('------userList----->'+userList);
List<Product__C> prodctList= new List<Product__C>();
List<Product__C> prodctList1= new List<Product__C>();
if(!prodIdSet.isEmpty()){
prodctList=[SELECT ID,Name,AlreadyDownloaded__c FROM Product__c WHERE ID IN :prodIdSet];
}
System.debug('-----prodctList with already downloaded value-----'+prodctList);
if(!prodctList.isEmpty()){
for(Product__C prod:prodctList){
if(prod.AlreadyDownloaded__c ==True){
break;
}else{
prodCount++;
System.debug('---prodCount inside else----'+prodCount);
prod.AlreadyDownloaded__c=true;
prodctList1.add(prod);
}
}
}if(prodCount ==prodctList.size()){
counter++;
System.debug('---counter----'+counter); 
}System.debug('---prodctList1--'+prodctList1);
if(!prodctList1.isEmpty()){
update prodctList1;
}
if(!userList.isEmpty()){
for(User usr:userList){
System.debug('====user list value===='+usr.Name);
System.debug('====user counter value===='+usr.Counter__c);
if(usr.Counter__c !=NULL){
usr.Counter__c += counter;
}
userList1.add(usr);
}
}
if(userList1.size()>0){
update userList1;
}
System.debug('-----userList1------'+userList1);

//--------------------------------------------------

if(userList1.size()>0 && prodListUpdated.size()>0)
{
System.debug('=======prodListUpdated.OfflineUsername====='+prodListUpdated[0].Offline_UserName__C);
param='SS00'+userList1[0].Counter__c+prodListUpdated[0].Offline_UserName__C+'_'+'_'+String.valueOf(Date.newInstance(prodListUpdated[0].CreatedDate.Year(),prodListUpdated[0].CreatedDate.Month(),prodListUpdated[0].CreatedDate.Day()))+'_'+prodListUpdated[0].Vendor_Name__c+'-'+prodListUpdated[0].Cluster__c+'_'+quantity;

}else{
param='SS00DefaultUserDefUserNameTodayDefVendorDefCluster+DefQuantity';
}
System.debug('==param=='+param);
PageReference page = new PageReference('/apex/ProductPDFDownloadPage1');

return page;

}*/
    /*  public void exportToexcel(){
for(Product__c prod: prodListUpdated){
// prodListExcel.add(prod);
}
} */
    /* public void dataUpdated(){
List<String> sendTo = new List<String>();
list<String>ccTo = new list<String>();
set<String>ccToSet = new Set<String>();
sendTo = label.Mechandize_Team.split(',');
ccTo = label.PO_Team.split(',');
//sendTo.add('poornapriya.yn@kvpcorp.com');
//ccTo.add('poornapriya.yn@kvpcorp.com');
//system.debug('**ccTo**'+ccTo[0]);
string subject = '';
string mailbody = '';
Messaging.singleEmailmessage Email;
boolean isUpdated = true;      
for(Product__c prod: prodListUpdated){
if(!ccToSet.contains(prod.Owner.Email) && prod.Owner.Email != null){
ccToSet.add(prod.Owner.Email);
ccTo.add(prod.Owner.Email);
}
system.debug('**ccTo**'+ccTo);
system.debug('**Border_Pattern__c **'+prod.Border_Pattern__c);
system.debug('**Body_Pattern__c**'+prod.Body_Pattern__c);
system.debug('**Pallu_Pattern__c **'+prod.Pallu_Pattern__c );
if(prod.Border_Pattern__c == null || prod.Body_Pattern__c== null || prod.Pallu_Pattern__c == null){
isUpdated = false;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Data from Attribution Team is not updated'));
return;
}
else{                   
subject = 'Requesting to price the products';
mailbody = '<html><body>Dear Team,<br/><br/>The attribution for the list of items procured by '+prod.owner.Name +' on '+ CreatedDate + ' from '+ prod.Account__r.name +' is now COMPLETE. Kindly refer the below link and PRICE the products.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&CDate='+CreatedDate+'&Origin='+origin+'<br/><br/>Thank You,<br/>Aryabhatta for Taneira<br/>Taneira Procurement Solution</body></html>';
}


if(isUpdated){
Email =new Messaging.singleEmailmessage();
email.setsubject(subject );
email.Sethtmlbody(mailbody);
// system.debug('execute'+ emails);
Email.SetToAddresses(sendTo);
Email.SetCCAddresses(ccTo);
}



}
if(isUpdated){
Messaging.sendemailResult[] r = Messaging.sendemail(new Messaging.singleEmailmessage[]{email});
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email to Merchandise Team sent successfully'));
}


}*/
    /* public void priceUpdated(){
List<String> sendTo = new List<String>();

set<String> ccToSet = new set<String>();
sendTo = label.WH_Team.split(',');
system.debug('**sendTo**'+sendTo[0]);
string subject = '';
string mailbody = '';
boolean isPriceUpdate = true;
List<String>ccTo = new List<String>();
List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();

for(Product__c prod: prodListUpdated){
if(!ccToSet.contains(prod.Owner.email) && prod.Owner.Email != null){
ccToSet.add(prod.Owner.Email);
ccTo.add(prod.Owner.Email);
}

if(prod.PO_Number__c != null){
if(prod.Border_Pattern__c != null && prod.Body_Pattern__c != null && prod.Pallu_Pattern__c != null){
if(prod.suggested_mrp__c != null){
subject = 'Requesting to Inward and tag';
mailbody = '<html><body>Dear Team,<br/><br/>The products procured by '+prod.owner.Name +' on '+ CreatedDate + 
' from '+ prod.Account__r.name +' now ready for inwarding and tagging. The PO number for this list of item is ' + prod.PO_Number__c +'. Please refer the below link and kindly inward and tag when received.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/OfflineProductsPage?Account='+accId + '&Category='+category+'&CDate='+CreatedDate+'&Origin='+origin+'<br/><br/>Thank You,<br/>'+UserInfo.getname()+'<br/>Taneira Procurement Solution</body></html>';            
}
else{
isPriceUpdate = false;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Price for Products are not updated'));
return;
}

}
else{
isPriceUpdate = false;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Cannot Update Price'));
return;
}
}

else{
isPriceUpdate = false;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Cannot Update Price'));
return;
}   

}
Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subject,ccTo);
newemailslist.add(emailmsg);
if(isPriceUpdate){
Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist); 
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email to WH Team sent successfully'));
}
}*/
    
    /* public void poNumUpdated(){
List<String> sendTo = new List<String>();
sendTo = label.Mechandize_Team.split(',');

system.debug('**sendTo**'+sendTo[0]);
string subject = '';
string mailbody = '';
boolean isPOUpdate = true;
List<String>ccTo = new List<String>();
List<Messaging.SingleEmailMessage> newemailslist = new List<Messaging.SingleEmailMessage> ();

for(Product__c prod: prodListUpdated){
if(prod.suggested_Mrp__c == null){

if(prod.PO_Number__c!= null){
subject = 'PO Updated';
mailbody = '<html><body>Dear Team,<br/><br/>The PO Number is updated for products procured by '+prod.owner.Name +' on '+ CreatedDate+ ' from '+ prod.Account__r.name +' <br/>Please refer the below link for the products.<br/><br/>'+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/TaneiraProductView<br/><br/>Thank You,<br/>'+UserInfo.getname()+'<br/>Taneira Procurement Solution</body></html>';           
}
else{
isPOUpdate = false;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'PO Number for Products are not added'));
return;
}


}

else{
isPOUpdate = false;
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Cannot Update PO Number'));
return;
}   

}
Messaging.SingleEmailMessage emailmsg = sendEmailMsg(mailbody,sendTo,subject,ccTo);
newemailslist.add(emailmsg);
if(isPOUpdate){
Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(newemailslist); 
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email to Aryabatta Team sent successfully!!'));
}
}*/
    /*   Public class defaultvalue{
Public string strDefault {get; set;}
public defaultvalue(){
strDefault = 'NA';
} 
}*/
    public Messaging.SingleEmailMessage sendEmailMsg(string emailBody,String[] sendTo,String subj,String[] ccTo){
        Messaging.SingleEmailMessage newemail = new Messaging.SingleEmailMessage ();
        newemail.setHtmlBody(emailBody);
        newemail.setSubject(subj);
        newemail.setToAddresses(sendTo);  
        newemail.setCCAddresses(ccTo);
        return newemail;
    }
    
    public PageReference doSubmit(){
        colorCheck = true;
        check = true;
        string ProString = '';
        String mailbody = '';
        String mailbody1 = '';
        system.debug('submitted');
        AttProdList = new List<product__c>();
        if(prodList.size()>0){
            for(product__c product : prodList){
                //if(product.Body_Pattern_Update__c != null && product.Body_Des_Element_Update__c != null && product.Body_Des_Material_Update__c != null && product.Border_Pattern_Update__c != null && product.Border_Size_Update__c != null && product.Pallu_Pattern_Update__c != null && product.Border_Des_Element_Update__c != null && product.PO_Number__c !=null)
                if(product.PO_Number__c != null && product.Design_Story_Update__c != null && product.Story_1_Update__c != null && product.Story_2_Update__c != null && product.Occasion_Update__c != null && product.Collection_Update__c != null)
                {
                    product.category_user_email__c = UserEmail.get(selectedCategoryUser);
                    product.Attribution_User_Email__c = UserEmail.get(UserInfo.getUserId());
                    product.Stage__c='Category';//*********** new
                    AttProdList.add(product);                  
                }
                else
                {
                    check = FALSE;
                    return null;
                }
            }
        }
        system.debug('AttprodList'+AttprodList);
        system.debug('check'+check);
        if(!AttprodList.isEmpty() && check == TRUE){
            
            List<Taneira_View__c> taneiraViewLst = new List<Taneira_View__c>();
            List<string> emailList = new List<string>();
            for(Taneira_View__c taneiraView : [SELECT Id, Product_Key_Finder1__c,Assign_Back_date__c,APPD__c,Assign_Back_date2__c,Attribution_Pending_days__c,Category_completed_date__c,Category_pending_days__c,CPPD__c,createdDate FROM Taneira_View__c Where Product_Key_Finder1__c = :productKey ] ){
                taneiraView.Page_Control__c = 'Category';
                taneiraView.Category_User__c = selectedCategoryUser+','+userValues.get(selectedCategoryUser);
                system.debug(selectedCategoryUser+','+userValues.get(selectedCategoryUser));
                taneiraView.Category_user_email__c = UserEmail.get(selectedCategoryUser);
                taneiraView.Attribution_completed_date__c = System.today();
                if(taneiraView.Assign_Back_date__c == null && taneiraView.Assign_Back_date2__c == null){
                    DateTime dT2 = taneiraView.CreatedDate;
                    Date myDate2 = date.newinstance(dT2.year(), dT2.month(), dT2.day());
                    taneiraView.APPD__c = myDate2.daysBetween(date.today());
                }
                else if(taneiraView.Assign_Back_date__c != null && taneiraView.Assign_Back_date2__c == null){
                    DateTime dT = taneiraView.Assign_Back_date__c;
                    Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
                    taneiraView.APPD__c = myDate.daysBetween(date.today()) + taneiraView.APPD__c;
                }
                else if(taneiraView.Assign_Back_date__c != null && taneiraView.Assign_Back_date2__c != null){
                    DateTime dT1 = taneiraView.Assign_Back_date2__c;
                    Date myDate1 = date.newinstance(dT1.year(), dT1.month(), dT1.day());
                    taneiraView.APPD__c = myDate1.daysBetween(date.today()) + taneiraView.APPD__c;
                }
                taneiraViewLst.add(taneiraView);
                emailList.add(UserEmail.get(selectedCategoryUser));
            }
            update taneiraViewLst;
            update AttProdList; 
            
            mailbody = '<html><body>Hi Team,<br/><br/> Attribution team submitted the record.<br/><br/>Thank you<br/><br/></body></html>';
            emailList.add('sfdcadmin@titan.co.in');
            system.debug('emailList++++===='+emailList);
            Messaging.SingleEmailMessage Msg = new Messaging.SingleEmailMessage();
            msg.setToAddresses(emailList);
            msg.Sethtmlbody(mailbody);
            msg.setSubject('Attribution team submitted the Product');
            //ProductEmailTriggerHandler.afterInserProduct(JSON.serialize(AttprodList),'AttributionPage');
            /*mailbody1 = '<html><body>Hi Team,<br/><br/> Attribution completed.<br/><br/>Thank you<br/><br/></body></html>';
            list<string> emaillist1 = new list<string>();
            emaillist1.add('vindyashree.ak@kvpcorp.com');
            Messaging.SingleEmailMessage msg1 = new Messaging.SingleEmailMessage();
            msg1.setToAddresses(emaillist1);
            msg1.Sethtmlbody(mailbody1);
            msg1.setSubject('Attribution completed');*/
            
            //Messaging.sendEmail(new Messaging.SingleEmailmessage[] {msg,msg1});
            Messaging.sendEmail(new Messaging.SingleEmailmessage[] {msg});
            
        }
        
        PageReference pr = new PageReference('/apex/TaneiraViewAngularJSPage');
        return pr;
    }
    public PageReference poDownload(){
        //System.debug('PO');
        
        system.debug('prod'+prodList.size());
        system.debug('user'+userList2.size());
        if(prodList.size()>0)
        {
            
            user loggedinuser = [Select Counter__c,Name from User where id =:UserInfo.getUserId()];
            system.debug('user'+loggedinuser);
            
            // System.debug('=======prodListUpdated.OfflineUsername====='+prodList[0].Offline_UserName__C);
            param = loggedinuser.Name+'_'+String.valueOf(Date.newInstance(prodList[0].CreatedDate.Year(),prodList[0].CreatedDate.Month(),prodList[0].CreatedDate.Day()))+'_'+prodList[0].Vendor_Name__c;
            
        }
        System.debug('param'+param);        
        PageReference pageRef = new PageReference('/apex/TaneiraDownloadPOPage');
        
        return pageRef;
    }
    public PageReference mmDownload(){
        //System.debug('MM download');
        if( prodListUpdated.size()>0)
        { 
             user loggedinuser = [Select Counter__c,Name from User where id =:UserInfo.getUserId()];
            system.debug('user'+loggedinuser);
            // System.debug('=======prodListUpdated.OfflineUsername====='+prodListUpdated[0].Offline_UserName__C);
            param = loggedinuser.Name+'_'+'_'+String.valueOf(Date.newInstance(prodListUpdated[0].CreatedDate.Year(),prodListUpdated[0].CreatedDate.Month(),prodListUpdated[0].CreatedDate.Day()))+'_'+prodListUpdated[0].Vendor_Name__c;
        }
        PageReference pageRef = new PageReference('/apex/TaneiraDownloadMMPage');
        return pageRef;
    }
    public void doSave(){
        decimal quantity=0;
        Taneira_View__c tt = new Taneira_View__c();
        if(!Test.isRunningTest()){
            tt = [select id, PO_status__c from Taneira_View__c where Product_Key_Finder1__c = :productKey limit 1];
        }
        tt.PO_status__c = 'YES';
        for(Product__c pro :prodList){
            if(pro.PO_Number__c == null){
                tt.PO_status__c = 'NO';     
            } 
            if(pro.Quantity__c!=0){
              quantity+=pro.Quantity__c; 
                 System.debug('**.....***'+quantity);
            }
        }
         System.debug('**runningg***'+quantity);
       tt.Total_Quantity__c= quantity;
        
        Map<Id,product__c> oldProdList2 = new MAP<Id,product__c>([SELECT id,Cost__c,Suggested_MRP__c,Yardage_Cost__c,Yardage_Consumption__c,Yardage_UCP__c,Packing_Logistic_Cost__c,Procurement_Cost__c FROM product__c WHERE Product_Key_Finder__c =:productKey]);  
        for(product__c prod : prodList){
             System.debug('**runningg***');
            if(oldProdList2.containsKey(prod.Id) && (prod.Yardage_Cost__c != oldProdList2.get(prod.Id).Yardage_Cost__c || prod.Yardage_UCP__c != oldProdList2.get(prod.Id).Yardage_UCP__c || prod.Yardage_Consumption__c != oldProdList2.get(prod.Id).Yardage_Consumption__c ||prod.Yardage_Cost__c!=0)){
                prod.Yardage_Cost__c = prod.Yardage_Consumption__c * prod.Yardage_UCP__c;
                prod.Cost__c =( prod.Procurement_Cost__c != Null ? prod.Procurement_Cost__c : 0) + prod.Yardage_Cost__c + prod.Packing_Logistic_Cost__c;
                
            }
            else if(prod.Yardage_Cost__c==0) {
                
                prod.Cost__c =( prod.Procurement_Cost__c != Null ? prod.Procurement_Cost__c : 0) + prod.Packing_Logistic_Cost__c;
            }
        }
        if(!Test.isRunningTest()){
                update tt;
                Update prodList; 
            }
    } 
    public void doCopy(){
        /* sObject ChangedObj = null;
Boolean Ischanged = FALSE;
List<id> prodIdList = new List<id>();
for(productWrraper copypro: wrraperList)
{
prodIdList.add(copypro.productRec.Id);   
}
Map<Id,product__c> oldProdList = new MAP<Id,product__c>([SELECT id,Collection_Update__c,Body_Des_Element_Update__c,Body_Pattern_Update__c,Body_Des_Material_Update__c,
Body_Des_Density_Update__c,Border_Pattern_Update__c,Border_Des_Material_Update__c,Border_Size_Update__c,
Pallu_Pattern_Update__c,Pallu_Design_Update__c,Pallu_Des_Material_Update__c,Pallu_Des_Density_Update__c,Pallu_Size_Update__c,
PO_Number__c,Story_2_Update__c,Story_1_Update__c,Design_Story_Update__c,Occasion_Update__c,Border_Des_Element_Update__c
FROM product__c WHERE Product_Key_Finder__c =:productKey]); 

for(productWrraper copyprod: wrraperList){
sObject sobj = copyprod.productRec;
sObject mapObj = oldProdList.get(sobj.Id);

}
*/
        
        /*
* ====Vydhyula Sruthi====Modified Date: 10/01/2020
* This method is used to copy the values to preceding rows. 
*/
        String str1 = prodList[0].Collection_Update__c;
        
        String str2 = prodList[0].Body_Pattern_Update__c;
        String str3 = prodList[0].Body_Des_Element_Update__c;
        String str4 = prodList[0].Body_Des_Material_Update__c;
        String str5 = prodList[0].Body_Des_Density_Update__c;
        String str6 = prodList[0].Border_Pattern_Update__c;
        String str7 = prodList[0].Border_Des_Material_Update__c;
        String str8 = prodList[0].Border_Size_Update__c;
        String str9 = prodList[0].Pallu_Pattern_Update__c;
        String str10 = prodList[0].Pallu_Design_Update__c;
        String str11 = prodList[0].Pallu_Des_Material_Update__c;
        String str12 = prodList[0].Pallu_Des_Density_Update__c;
        String str13 = prodList[0].Pallu_Size_Update__c;
        String str14 = prodList[0].Border_Des_Element_Update__c;
        String str15 = prodList[0].Occasion_Update__c;
        String str16 = prodList[0].Design_Story_Update__c;
        String str17 = prodList[0].Story_1_Update__c;
        String str18 = prodList[0].Story_2_Update__c;
        String str19 = prodList[0].PO_Number__c;
        String str20 = prodList[0].FabricR__c ;
        String str21 = prodList[0].CraftR__c;
        String str22 = prodList[0].Price_Band__c;
        
        
        Integer enter = 0;
        Map<Id,product__c> oldProdList = new MAP<Id,product__c>([SELECT id,Collection_Update__c,Body_Des_Element_Update__c,Body_Pattern_Update__c,Body_Des_Material_Update__c,
                                                                 Body_Des_Density_Update__c,Border_Pattern_Update__c,Border_Des_Material_Update__c,Border_Size_Update__c,
                                                                 Pallu_Pattern_Update__c,Pallu_Design_Update__c,Pallu_Des_Material_Update__c,Pallu_Des_Density_Update__c,Pallu_Size_Update__c,
                                                                 PO_Number__c,Story_2_Update__c,Story_1_Update__c,Design_Story_Update__c,Occasion_Update__c,Border_Des_Element_Update__c,FabricR__c,CraftR__c,Price_Band__c
                                                                 FROM product__c WHERE Product_Key_Finder__c =:productKey]); 
        for(product__c prod : prodList){
            system.debug('prod12345==>'+prod.name);
            if(copyValue == 'Collection_Update__c' ){
                if(prod.Collection_Update__c != oldProdList.get(prod.Id).Collection_Update__c){
                    str1 = prod.Collection_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Collection_Update__c = str1;
                }
            }
            else if(copyValue == 'Body_Pattern_Update__c'){
                if(prod.Body_Pattern_Update__c != oldProdList.get(prod.Id).Body_Pattern_Update__c){
                    str2 = prod.Body_Pattern_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Body_Pattern_Update__c = str2; 
                }
            }
            else if(copyValue == 'Body_Des_Element_Update__c'){
                if(prod.Body_Des_Element_Update__c != oldProdList.get(prod.Id).Body_Des_Element_Update__c ){
                    str3 = prod.Body_Des_Element_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Body_Des_Element_Update__c = str3;
                }
            }
            else if(copyValue == 'Body_Des_Material_Update__c'){
                if(prod.Body_Des_Material_Update__c != oldProdList.get(prod.Id).Body_Des_Material_Update__c ){
                    str4 = prod.Body_Des_Material_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Body_Des_Material_Update__c = str4;
                }
            }
            else if(copyValue == 'Body_Des_Density_Update__c'){
                if(prod.Body_Des_Density_Update__c != oldProdList.get(prod.Id).Body_Des_Density_Update__c ){
                    str5 = prod.Body_Des_Density_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Body_Des_Density_Update__c = str5;
                }
            }
            else if(copyValue == 'Border_Pattern_Update__c'){
                if(prod.Border_Pattern_Update__c != oldProdList.get(prod.Id).Border_Pattern_Update__c ){
                    str6 = prod.Border_Pattern_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Border_Pattern_Update__c = str6;
                }
            }
            else if(copyValue == 'Border_Des_Material_Update__c'){
                if(prod.Border_Des_Material_Update__c != oldProdList.get(prod.Id).Border_Des_Material_Update__c ){
                    str7 = prod.Border_Des_Material_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Border_Des_Material_Update__c = prodList[0].Border_Des_Material_Update__c;
                }
            }
            else if(copyValue == 'Border_Size_Update__c'){
                if(prod.Border_Size_Update__c != oldProdList.get(prod.Id).Border_Size_Update__c ){
                    str8 = prod.Border_Size_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Border_Size_Update__c = str8;
                }
            }
            else if(copyValue == 'Pallu_Pattern_Update__c'){
                if(prod.Pallu_Pattern_Update__c != oldProdList.get(prod.Id).Pallu_Pattern_Update__c ){
                    str9 = prod.Pallu_Pattern_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Pallu_Pattern_Update__c = str9;
                }
            }
            else if(copyValue == 'Pallu_Design_Update__c'){
                if(prod.Pallu_Design_Update__c != oldProdList.get(prod.Id).Pallu_Design_Update__c ){
                    str10 = prod.Pallu_Design_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Pallu_Design_Update__c = str10;
                }
            }
            else if(copyValue == 'Pallu_Des_Material_Update__c'){
                if(prod.Pallu_Des_Material_Update__c != oldProdList.get(prod.Id).Pallu_Des_Material_Update__c ){
                    str11 = prod.Pallu_Des_Material_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Pallu_Des_Material_Update__c = str11;
                }
            }
            else if(copyValue == 'Pallu_Des_Density_Update__c'){
                if(prod.Pallu_Des_Density_Update__c != oldProdList.get(prod.Id).Pallu_Des_Density_Update__c ){
                    str12 = prod.Pallu_Des_Density_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Pallu_Des_Density_Update__c = str12;
                }
            }
            else if(copyValue == 'Border_Des_Element_Update__c'){
                if(prod.Border_Des_Element_Update__c != oldProdList.get(prod.Id).Border_Des_Element_Update__c ){
                    str14 = prod.Border_Des_Element_Update__c;
                    enter = 1;
                } if(enter == 1){               
                    prod.Border_Des_Element_Update__c = str14;
                }
            }
            else if(copyValue == 'Pallu_Size_Update__c'){
                if(prod.Pallu_Size_Update__c != oldProdList.get(prod.Id).Pallu_Size_Update__c ){
                    str13 = prod.Pallu_Size_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Pallu_Size_Update__c = str13;
                }
            }
            else if(copyValue == 'Occasion_Update__c'){
                if(prod.Occasion_Update__c != oldProdList.get(prod.Id).Occasion_Update__c ){
                    str15 = prod.Occasion_Update__c;
                    enter = 1;
                } if(enter == 1){
                    prod.Occasion_Update__c = str15;
                }
            }
            else if(copyValue == 'Design_Story_Update__c'){
                if(prod.Design_Story_Update__c != oldProdList.get(prod.Id).Design_Story_Update__c ){
                    str16 = prod.Design_Story_Update__c;
                    enter = 1;
                } if(enter == 1){
                    prod.Design_Story_Update__c = str16;
                }
            }
            else if(copyValue == 'Story_1_Update__c'){
                if(prod.Story_1_Update__c != oldProdList.get(prod.Id).Story_1_Update__c ){
                    str17 = prod.Story_1_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Story_1_Update__c = str17;
                }
                
            }else if(copyValue == 'Story_2_Update__c'){
                if(prod.Story_2_Update__c != oldProdList.get(prod.Id).Story_2_Update__c ){
                    str18 = prod.Story_2_Update__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Story_2_Update__c = str18;
                }
            }else if(copyValue == 'PO_Number__c'){
                if(prod.PO_Number__c != oldProdList.get(prod.Id).PO_Number__c ){
                    str19 = prod.PO_Number__c;
                    enter = 1;
                }if(enter == 1){
                    prod.PO_Number__c = str19;
                }
            }else if(copyValue == 'FabricR__c'){
                if(prod.FabricR__c != oldProdList.get(prod.Id).FabricR__c ){
                    str20 = prod.FabricR__c;
                    enter = 1;
                }if(enter == 1){
                    prod.FabricR__c = str20;
                }
            }else if(copyValue == 'CraftR__c'){
                if(prod.CraftR__c != oldProdList.get(prod.Id).CraftR__c ){
                    str21 = prod.CraftR__c;
                    enter = 1;
                }if(enter == 1){
                    prod.CraftR__c = str21;
                }
            }else if(copyValue == 'Price_Band__c'){
                if(prod.Price_Band__c != oldProdList.get(prod.Id).Price_Band__c){
                    str22 = prod.Price_Band__c;
                    enter = 1;
                }if(enter == 1){
                    prod.Price_Band__c = str22;
                }
            }
            
            
        }
        
    }
    
    public class productWrraper{
        
        public product__c productRec{get;set;}
        public string imgLink{get;set;}
        public string comments {get;set;}
        productWrraper(){           
            productRec = new product__c();
            imgLink = null;
            comments = null;
        }  
    }
    public class productPOWrraper{
        public product__c productRec{get;set;}
        public string plant{get;set;}
        public string storageLocation{get;set;}
        public string purchaseGroup{get;set;}
        productPOWrraper(){
            productRec = new product__c();
        }
    }
    
    public class productMMWrraper{
        public product__c proRec{get;set;}
        public string plant{get;set;}
        public string storageLocation{get;set;}
        public string profitCenter{get;set;}
        public string materialDescription{get;set;}
        public string productHierarchy{get;set;}
        public string controlCode{get;set;}
        public string unitOfMeasure{get;set;}
        public boolean conditionsMet{get;set;}
        public boolean conditionsMetHierarchy{get;set;}
        public string cellHighlight{get;set;}
        public string cellHighlightHierarchy{get;set;}
        productMMWrraper(){
            proRec = new product__c();
        }
    }
   public  void sentPo(){
      
                system.debug('Hidebutton'+Hidebutton);
       Hidebutton = false;
       system.debug('Hidebutton1'+Hidebutton);
       DateTime now = System.now();
       System.debug(productKey);
       if(String.isNotBlank(productKey)){
           List<product__c> polist = [Select id from product__c where Product_Key_Finder__c =:productKey];
           Set<Id> poids = (new Map<Id,product__c>(polist)).keySet();        
           TaneiraSentPOApi.sentPO(poids, SLno);
           //  
           system.debug(poids); 
           system.debug(polist);
           system.debug(SLno);
           for(product__c po:polist)
           {
               po.Sent_PO_date_and_time__c =  now;
               po.PO_sent_status__c = true;
               //po.Sl_number__c = Slno;
               system.debug(po.Sent_PO_date_and_time__c);
               update po;
           }
       }
       
          
    
   }
    public void showUploadPopUp(){
        showUploadPopUp = true;
      
    }
    public void hideUploadPopUp(){
        showUploadPopUp = false;
       
    }
    
    
     public void importCSVFile(){
        
            imported = true;
     importproc=new Map<id,decimal>(); 
         Map<id,integer> importqty=new Map<id,integer>();
      
        // CSVproducts = new list<product__c>();
        csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n'); 
        system.debug(csvFileLines);
        for(Integer i=1;i<csvFileLines.size();i++){
            product__c  accObj = new product__c () ;
            string[] csvRecordData = csvFileLines[i].split(',');
                     if( csvRecordData[0] != '' && csvRecordData[2] != '')
               importproc.put(csvRecordData[0].trim(), Decimal.valueOf(csvRecordData[2].trim()));
               importqty.put(csvRecordData[0].trim(), Integer.valueOf(csvRecordData[3].trim()));
            
        }
         for(productWrraper wrap:wrraperList){
             if( importproc.containsKey(wrap.productRec.Id)){
                 wrap.productRec.Procurement_Cost__c=importproc.get(wrap.productRec.Id);
                 wrap.productRec.Quantity__c=importqty.get(wrap.productRec.Id);
             }
                }
        system.debug(wrraperList);
        showUploadPopUp = false;
        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.CONFIRM,'Document succesfully inserted');
        ApexPages.addMessage(errorMessage);
     }
   
   }