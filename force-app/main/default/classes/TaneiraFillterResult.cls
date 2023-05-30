global class TaneiraFillterResult {
    public Boolean isOnLoad{get;set;}
    public Boolean isSearching{get;set;}
    string vendorStr = '';
    string originStr = '';
    string proCatStr = '';
    id productRecordType;
    public transient string finalResultJson{get;set;}
    public string  queryStringForRemoteAction {get;set;}
    public string  queryStringForRemoteSerch {get;set;}
    Set<string> vendorSet;
    Set<string> originSet;
    Set<string> categorySet;
    public string searchkey{get;set;}
    public string  filterKey{get;set;}
    public String[] autoFillData{get;set;}
    public  String profileName{get;set;}
    public boolean isVendorPrf{get;set;}
    //Static variables declaration
    public Static string vendorAttributes{get;set;}
    public Static string categoryAttributes{get;set;}
    public Static string wrapAttributes{get;set;}
    public Static string weftAttributes{get;set;}
    public Static string originAttributes{get;set;}
    public Static string craftAttributes{get;set;}
    public Static string designTypeAttributes{get;set;}
    public Static string colorAttributes{get;set;}
    public Static string articalNumberAttributes{get;set;}
    public Static string suggestedMRPAttributes{get;set;}
    //Added by Rahul
    public Static String loomAttributes {get;set;}
    public Static String ZariAttributes{get;set;}
    public Static String BodyPatternAttributes{get;set;}
    public Static String PalluPatternAttributes {get;set;}
    public Static String OccasionAttributes {get;set;}
    public Static String SareeDimensionAttributes {get;set;}
    public Static String DesignStoryAttributes {get;set;}
    public Static String BodyDesMatAttributes {get;set;}
    public Static String BodyDesElemAttributes {get;set;}
    public Static String BodyDesDensAttributes {get;set;}
    public Static String PalluDesMatAttributes {get;set;}
    public Static String PalluSizeAttributes {get;set;}
     public Static String BorderPatternAttributes {get;set;}
    public Static String BorderDesElemAttributes {get;set;}
    public Static String BorderDesMatAttributes {get;set;}
    public Static String BorderSizeAttributes {get;set;}
    public Static String ProcTypeAttributes {get;set;}
    public Static String PalluDesignAttributes {get;set;}
    
        //Set variables declaration
    Set<string>  vendorFilterSet;
    Set<string>  categoryFilterSet;
    Set<String>  wrapSet; 
    Set<String>  weftSet;
    Set<String>  originFilterSet;
    Set<String>  craftSet;
    Set<String>  designSet;
    Set<String>  colorSet;
    Set<String>  articalSet;
    //added by Rahul
    Set<String> loomFilterSet;
    Set<String> zariFilterSet;
    Set<String> bodyPatternFilterSet;
    Set<String> palluPatternFilterSet;
    Set<String> occasionFilterSet;
    Set<String> sareeDimenFilterSet;
    Set<String> designStoryFilterSet;
    Set<String> bodyDesMatFilterSet;
    Set<String> bodyDesElemFilterSet;
    Set<String> bodyDesDensFilterSet;
    Set<String> palluDesMatFilterSet;
    Set<String> palluSizeFilterSet;
    Set<String> borderPatternFilterSet;
    Set<String> borderDesElemFilterSet;
    Set<String> borderDesMaterFilterSet;
    Set<String> borderSizeFilterSet;
    Set<String> procTypeFilterSet;
    Set<String> palluDesignFilterSet;
    
    decimal minMrp = 0;
    decimal maxMrp = 0;
    public string searchType{get;set;}
    public TaneiraFillterResult(){
        isOnLoad = true;
        isSearching = false;
        vendorStr = '';
        originStr = '';
        proCatStr = '';
        finalResultJson = 'TestData';
        filterKey = '';
        searchType = '';
        vendorFilterSet    = new Set<String>();
        categoryFilterSet  = new Set<String>();
        wrapSet            = new Set<String>(); 
        weftSet            = new Set<String>();
        originFilterSet    = new Set<String>();   
        craftSet           = new Set<String>();
        designSet          = new Set<String>();
        colorSet           = new Set<String>();
        articalSet         = new Set<String>(); 
        //added by Rahul
        loomFilterSet      = new Set<String>();
        zariFilterSet      = new Set<String>();
        bodyPatternFilterSet=new Set<String>();
        palluPatternFilterSet=new Set<String>();
        occasionFilterSet=new Set<String>();
        sareeDimenFilterSet=new Set<String>();
        designStoryFilterSet=new Set<String>();
        bodyDesMatFilterSet =new Set<String>();
        bodyDesElemFilterSet= new Set<String>();
        bodyDesDensFilterSet= new Set<String>();
        palluDesMatFilterSet= new Set<String>();
        palluSizeFilterSet= new Set<String>();
        borderPatternFilterSet= new Set<String>();
        borderDesElemFilterSet= new Set<String>();
        borderDesMaterFilterSet = new Set<String>();
        borderSizeFilterSet = new Set<String>();
        palluDesignFilterSet = new Set<String>();
        procTypeFilterSet= new Set<String>();
        
    }
    //On load action method for session management and displying the model details with respect to the search key or advanced search values
    public PageReference onLoadFunction(){
        isOnLoad = true;
        isSearching = false;
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
            
        } else {
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
            
        }
        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        vendorStr    =    apexpages.currentPage().getParameters().get('Vendors');
        originStr    =    apexpages.currentPage().getParameters().get('origin');
        proCatStr    =    apexpages.currentPage().getParameters().get('selectedCateg');
        searchkey    =    apexpages.currentPage().getParameters().get('searchkey');
        profileName =  apexpages.currentPage().getParameters().get('profileName');
        searchType = apexpages.currentPage().getParameters().get('searchType');
        isVendorPrf = (profileName =='Ask Me Taneira Vendor-Taneira Vendor')?true:false;
        //getting product id of taneira record type
        productRecordType = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        string queryString = '';
       
        queryString = 'Select Id,name,Photo_Backup__c,Proc_Source__c,Design_Story__c ,Fold__c,Product_Category_Taneira__c,';
        queryString = queryString + 'Occasion__c ,Workmanship__c ,Loom__c,Suggested_MRP__c,Detailed_Colour__c,Fabric__c ,Collection__c,Pallu_Size__c,';
        queryString = queryString + 'colour__c,Zari_Type__c,Cluster__c,Account__c,Account__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Comments__c,';
        queryString = queryString + 'Taneira_Material_Weft__c,Saree_Dimensions__c,SKU_Code__c,Material_Wrap__c,Blouse_Type__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,';
        queryString = queryString + 'Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Border_Size__c,';
        queryString = queryString + 'Story_1__c,Story_2__c,Design_Description__c,PO_Number__c,Handloommark__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c FROM Product__c where RecordTypeId =  \'' +productRecordType+'\'';
         //if(isVendorPrf)
            
        //else
            //queryString = queryString + 'Saree_Dimensions__c,SKU_Code__c,Blouse_Dimensions__c  ,Material_Wrap__c,Article_Number__c,Design_Type__c FROM Product__c where RecordTypeId =: productRecordType ';
        if(string.isBlank(searchkey)){
            vendorSet = new Set<string>();
            if(string.isNotBlank(vendorStr) && vendorStr != 'null'){
                if(vendorStr == 'All')
                    queryString = queryString + ' And Account__r.name != null';
                else{
                    //vendorSet.addAll(vendorStr.split(',')) ;
                    vendorStr = vendorStr.replace(',','\',\'');
                    vendorStr = '(\''+vendorStr+'\')';
                    
                    queryString = queryString + ' And Account__r.name IN '+vendorStr;
                }
            }
            originSet = new set<string>();
            if(string.isNotBlank(originStr) && originStr != 'null'){
                 if(originStr == 'All')
                    queryString = queryString + ' And Cluster__c != null';
                else{
                    //originSet.addAll(originStr.split(','));
                    originStr = originStr.replace(',','\',\'');
                    originStr = '(\''+originStr+'\')';
                    queryString = queryString + ' And Cluster__c IN '+originStr;
                }           
            }
            categorySet = new set<string>();
            if(string.isNotBlank(proCatStr) && proCatStr != 'null'){
                 if(proCatStr == 'All')
                    queryString = queryString + ' And Product_Category_Taneira__c != null';
                else{
                    //categorySet.addAll(proCatStr.split(','));
                    proCatStr = proCatStr.replace(',','\',\'');
                    proCatStr = '(\''+proCatStr+'\')';
                    queryString = queryString + ' And Product_Category_Taneira__c IN '+proCatStr;
                }           
            }
        }
        else{
            if(searchType == 'SKU')
                queryString =queryString +' and SKU_Code__c= \''+searchkey+'\'';
            else if(searchType == 'Model')
                queryString =queryString +' and name= \''+searchkey+'\'';   
        }
        queryStringForRemoteAction = queryString;
        //convertToJSON(queryString);
        
        //Wrapper classes varibles declaration and intializations 
        List<filterWrapper>    vendorList      =   new List<filterWrapper>();
        List<filterWrapper>    categoryList    =   new List<filterWrapper>();
        List<filterWrapper>    wrapList        =   new List<filterWrapper>();
        List<filterWrapper>    weftList        =   new List<filterWrapper>();
        List<originFilterWrapper>    originList      =   new List<originFilterWrapper>();
        List<filterWrapper>    craftList       =   new List<filterWrapper>();
        List<filterWrapper>    designTypeList  =   new List<filterWrapper>();
        List<filterWrapper>    colorList       =   new List<filterWrapper>();
        List<filterWrapper>    articalNumberList  =   new List<filterWrapper>();
        List<filterWrapper>    suggestedMRPList  =   new List<filterWrapper>();
        //added by Rahul
        List<filterWrapper> loomList           =   new List<filterWrapper>();
        List<FilterWrapper> zariTypeList       =   new List<FilterWrapper>();
        List<FilterWrapper> bodyPatternList    =   new List<FilterWrapper>();
        List<FilterWrapper> palluPatternList   =   new List<FilterWrapper>();
        List<FilterWrapper> occasionList       = new List<FilterWrapper>();
        List<FilterWrapper> sareeDimenList     = new List<FilterWrapper>();
        List<FilterWrapper> designStoryList    = new List<FilterWrapper>();
        List<FilterWrapper> bodyDesMatList     = new List<FilterWrapper>();
        List<FilterWrapper> bodyDesElemList     = new List<FilterWrapper>();
        List<FilterWrapper> bodyDesDensList     = new List<FilterWrapper>();
        List<FilterWrapper> palluDesMatList     = new List<FilterWrapper>();
        List<FilterWrapper> palluSizeList       = new List<FilterWrapper>();
        List<FilterWrapper> borderPatternList   = new List<FilterWrapper>();
        List<FilterWrapper> borderDesElemList   = new List<FilterWrapper>();
        List<FilterWrapper> borderDesMatList    = new List<FilterWrapper>();
        List<FilterWrapper> borderSizeList     = new List<FilterWrapper>();
        List<FilterWrapper> palluDesignList     = new List<FilterWrapper>();
        List<filterWrapper> procTypeList = new List<filterWrapper>();
        
         // code to vendors name
        Id vendorRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
        List<Account> vendors = [SELECT Id,Name FROM Account WHERE RecordTypeId =: vendorRecordTypeId];
        for(Account acc : vendors){
            filterWrapper searcRec = new filterWrapper();
            searcRec.name = acc.name;
            vendorList.add(searcRec);
        }
        map<id,list<Master__c>> designArticalnumberMap = new map<id,list<Master__c>>();
        list<Master__c> tempList = new list<Master__c>();
        map<id,list<Master__c>> originDesignumberMap = new map<id,list<Master__c>>();
        list<Master__c> tempList1 = new list<Master__c>();
        List<Master__c> allOriginList = new List<Master__c>();
        for(Master__c eachMas : [Select Id, Name,Name__c,Dependency_1__c,Dependency_2__c FROM Master__c WHERE Active__c=TRUE and 
                                (Name__c =  'Product Category' OR Name__c =  'Warp' OR Name__c =  'Weft' OR Name__c =  'Base Colour' OR Name__c =  'Craft' OR Name__c =  'Origin' OR Name__c =  'Design Type' OR Name__c = 'Article Number' OR Name__c = 'Loom' OR Name__c = 'Zari Type' OR Name__c ='Body Pattern' OR Name__c ='Pallu Pattern' OR Name__c ='Occasion' OR Name__c ='Saree Dimensions' OR Name__c = 'Design Story' OR Name__c = 'Body Des Material' OR Name__c ='Body Des Element' OR Name__c ='Body Des Density' OR Name__c ='Pallu Des Material' OR Name__c= 'Pallu Size' OR Name__c='Border Pattern' OR Name__c='Border Des Material' OR Name__c='Border Des Element' OR Name__c='Border Size' OR Name__c='Pallu Design' OR Name__c='Proc-Type') 
                                order by Name]){
            if(eachMas.Name__c=='Product Category'){
                filterWrapper rec = new filterWrapper();
                rec.name = eachMas.name;
                categoryList.add(rec);
            }
            else if(eachMas.Name__c=='Warp'){
                filterWrapper rec = new filterWrapper();
                rec.name = eachMas.name;
                wrapList.add(rec);
            }
            else if(eachMas.Name__c=='Weft'){
                filterWrapper rec = new filterWrapper();
                rec.name = eachMas.name;
                weftList.add(rec);
            }
            else if(eachMas.Name__c=='Origin'){
               allOriginList.add(eachMas);
            }
         /*   else if(eachMas.Name__c=='Design Type'){
                tempList1 = new list<Master__c>();
                if(originDesignumberMap.containsKey(eachMas.Dependency_1__c))
                    tempList1 = originDesignumberMap.get(eachMas.Dependency_1__c);
                tempList1.add(eachMas);
                originDesignumberMap.put(eachMas.Dependency_1__c, tempList1);   
            }           
            else if(eachMas.Name__c=='Article Number'){
                tempList = new list<Master__c>();
                if(designArticalnumberMap.containsKey(eachMas.Dependency_2__c))
                    tempList = designArticalnumberMap.get(eachMas.Dependency_2__c);
                tempList.add(eachMas);
                designArticalnumberMap.put(eachMas.Dependency_2__c, tempList);
            } */
            else if(eachMas.Name__c=='Base Colour'){
                filterWrapper rec = new filterWrapper();
                rec.name = eachMas.name;
                colorList.add(rec);
            }
            else if(eachMas.Name__c=='Craft'){
                filterWrapper rec = new filterWrapper();
                rec.name = eachMas.name;
                craftList.add(rec);
            }
            //added by Rahul
            else if(eachMas.Name__c=='Loom'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                loomList.add(rec);
            }
            else if(eachMas.Name__c=='Zari Type'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                zariTypeList.add(rec);
            }
            else if(eachMas.Name__c=='Body Pattern'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                bodyPatternList.add(rec);
            }
            else if(eachMas.Name__c=='Pallu Pattern'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                palluPatternList.add(rec);
            }
            else if(eachMas.Name__c=='Occasion'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                occasionList.add(rec);
            }
            else if(eachMas.Name__c=='Saree Dimensions'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                sareeDimenList.add(rec);
            }
            else if(eachMas.Name__c=='Design Story'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                designStoryList.add(rec);
            }
            else if(eachMas.Name__c=='Body Des Material'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                bodyDesMatList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Body Des Element'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                bodyDesElemList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Body Des Density'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                bodyDesDensList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Pallu Des Material'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                palluDesMatList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Pallu Size'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                palluSizeList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Border Pattern'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                borderPatternList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Border Des Element'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                borderDesElemList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Border Des Material'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                borderDesMatList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Border Size'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                borderSizeList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Pallu Design'){
                filterWrapper rec = new FilterWrapper();
                rec.name = eachMas.name;
                palluDesignList.add(rec);//add in production
            }
            else if(eachMas.Name__c=='Proc-Type'){
                filterWrapper rec = new filterWrapper();
                rec.name = eachMas.name;
                procTypeList.add(rec);
            }
            
        }
        //List<Master__c> masRecList = [Select Id, Name,Name__c,(Select Id, Name,Name__c,Dependency_1__c,Dependency_2__c FROM dependency1__r WHERE Active__c=TRUE and (Name__c = : 'Design Type' OR Name__c = : 'Article Number') order by Name) FROM Master__c WHERE Active__c=TRUE and Name__c = : 'Origin' order by Name];
        List<designTypeWrapper>    designWrraperList       =   new List<designTypeWrapper>();
        List<filterWrapper>    articalWrraperList  =   new List<filterWrapper>();
        for(Master__c masRec : allOriginList){
            originFilterWrapper orgRec = new originFilterWrapper();
            orgRec.name = masRec.Name;
            designWrraperList       =   new List<designTypeWrapper>();
           /* if(originDesignumberMap.containsKey(masRec.Id) && originDesignumberMap.get(masRec.Id) != null){
                for(Master__c dRec : originDesignumberMap.get(masRec.Id)){
                    if(dRec.Name__c=='Design Type'){
                        designTypeWrapper rec = new designTypeWrapper();
                        rec.name = dRec.name;
                        articalWrraperList  =   new List<filterWrapper>();
                        if(designArticalnumberMap.containsKey(dRec.Id) && designArticalnumberMap.get(dRec.Id) != null){
                            for(Master__c aRec : designArticalnumberMap.get(dRec.Id)){
                                filterWrapper rec1 = new filterWrapper();
                                rec1.name = aRec.name; 
                                articalWrraperList.add(rec1);
                            }
                        }
                        rec.articalNumber = json.serializePretty(articalWrraperList);
                        designWrraperList.add(rec);
                    }                
                }
            } */
            orgRec.designType = json.serializePretty(designWrraperList);
            originList.add(orgRec);
            
        }
         //Converting List of wrapper classes to Json String
        vendorAttributes        = json.serializePretty(vendorList);
        categoryAttributes      = json.serializePretty(categoryList);
        wrapAttributes          = json.serializePretty(wrapList);
        weftAttributes          = json.serializePretty(weftList);
        originAttributes        = json.serializePretty(originList);
        craftAttributes         = json.serializePretty(craftList);
      //  designTypeAttributes    = json.serializePretty(designTypeList);
        colorAttributes         = json.serializePretty(colorList);
      //  articalNumberAttributes = json.serializePretty(articalNumberList);
        suggestedMRPAttributes  = json.serializePretty(suggestedMRPList);
        //added by Rahul
        loomAttributes        = json.serializePretty(loomList);
        ZariAttributes       = json.serializePretty(zariTypeList);
        BodyPatternAttributes = json.serializePretty(bodyPatternList);
        PalluPatternAttributes = json.serializePretty(palluPatternList);
        OccasionAttributes   = json.serializePretty(occasionList);
        SareeDimensionAttributes= json.serializePretty(sareeDimenList);
        DesignStoryAttributes =json.serializePretty(designStoryList);
        BodyDesMatAttributes=json.serializePretty(bodyDesMatList);
        BodyDesElemAttributes=json.serializePretty(bodyDesElemList);
        BodyDesDensAttributes=json.serializePretty(bodyDesDensList);
        PalluDesMatAttributes=json.serializePretty(palluDesMatList);
        PalluSizeAttributes=json.serializePretty(palluSizeList);
        BorderPatternAttributes=json.serializePretty(borderPatternList);
        BorderDesElemAttributes=json.serializePretty(borderDesElemList);
        BorderDesMatAttributes=json.serializePretty(borderDesMatList);
        BorderSizeAttributes =json.serializePretty(borderSizeList);
        PalluDesignAttributes=json.serializePretty(palluDesignList);
        ProcTypeAttributes=json.serializePretty(procTypeList);
        getautoFillDataList();
        return null;
    }
    //Method declaration for autocomplete values
    public PageReference getautoFillDataList(){
        autoFillData = new List<string>();
            //List of Product
            List<product__c> productList=[SELECT id,name,SKU_Code__c FROM product__c where recordtypeId =: productRecordType LIMIT 50000];                       
            String quoteStr='"';
            if(searchType == 'SKU'){
                //Iterate to collect sku code in string format
                for(product__c pro: productList){
                    autoFillData.add('"'+pro.SKU_Code__c+'"');
                }
            }
            else if(searchType == 'Model'){
                //Iterate to collect Model in string format
                    for(product__c pro: productList){
                        autoFillData.add('"'+pro.Name+'"');
                    }    
            }
            //To sort the nicopin list
           autoFillData.sort();
           return null;
    }//End of method
    
    @RemoteAction
    global static List<product__c> convertToJSONForRemoteAction(string qurStr){
        System.debug(LoggingLevel.ERROR, 'Heap Size before : ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());   
        //finalResultJson = '';    
        //System.debug('------------111111-------------'+json.serializePretty(database.query(qurStr)));     
        return database.query(qurStr);
        
        //System.debug(LoggingLevel.ERROR, 'Heap Size after: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());    
    }
    
    public void convertToJSON(string qurStr){
        System.debug(LoggingLevel.ERROR, 'Heap Size before : ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());   
        finalResultJson = '';       
        finalResultJson =   json.serializePretty(database.query(qurStr));
        
        System.debug(LoggingLevel.ERROR, 'Heap Size after: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());    
    }
    
    public pagereference searchSKU(){
        isOnLoad = false;
        isSearching = false;
         Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
            
        } else {
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
            
        }
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        //Make the dynamic query for getting the values with respect to the search key     
        string queryString = 'Select Id,RecordTypeId,name,Photo__c,Proc_Source__c,OwnerId,Owner.Name,Offline_Username__c,Design_Story__c ,Fold__c,Product_Category_Taneira__c,';
        queryString = queryString + 'Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,Detailed_Colour__c,Fabric__c ,Collection__c,Pallu_Size__c,';
        queryString = queryString + 'colour__c,Zari_Type__c,Cluster__c,Account__c,Account__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Comments__c,';
        queryString = queryString + 'Taneira_Material_Weft__c,Saree_Dimensions__c,SKU_Code__c,Material_Wrap__c,Blouse_Type__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,';
        queryString = queryString + 'Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Border_Size__c,';
        queryString = queryString + 'Story_1__c,Story_2__c,Design_Description__c,PO_Number__c,Handloommark__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c FROM Product__c where RecordTypeId =: productRecordType';
        if(searchkey!=null&&searchkey!='' ){
           if(searchType == 'SKU')
                queryString =queryString +' and SKU_Code__c=:searchkey';
          else if(searchType == 'Model')
                queryString =queryString +' and name=:searchkey';
        }
        
        //Calling the method to convert the list of models to JSON string
        convertToJSON(queryString);
        return null;    
    }
     //Method to refresh the table
    public pagereference refresh() {
        isOnLoad = false;
        isSearching = false;
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
            
        } else {
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
            
        }
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        searchkey='';
        string queryString = 'Select Id,RecordTypeId,name,Photo__c,Proc_Source__c,OwnerId,Owner.Name,Offline_Username__c,Design_Story__c ,Fold__c,Product_Category_Taneira__c,';
        queryString = queryString + 'Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,Detailed_Colour__c,Fabric__c ,Collection__c,Pallu_Size__c,';
        queryString = queryString + 'colour__c,Zari_Type__c,Cluster__c,Account__c,Account__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,';
        queryString = queryString + 'Taneira_Material_Weft__c,SKU_Code__c,Material_Wrap__c,Blouse_Type__c,Body_Des_Density__c,Body_Des_Element__c,';
        queryString = queryString + 'Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Border_Size__c,';
        queryString = queryString + 'Story_1__c,Design_Description__c,PO_Number__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c FROM Product__c where RecordTypeId =: productRecordType';
        //Calling the method to convert list values to JSON string 
        convertToJSON(queryString);
        return null;
        
    }//End of method
    
     //Method to move previous page
    public PageReference moveToBack(){
        
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
            
        } else {
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
            
        }
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        //Navigating to the previous page
        PageReference pr = new PageReference('/apex/TaneiraPortalSearch');
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(true);
            return pr;
    }//End of method
     //Method to filter the details with respect to the filter criteria.
    public pagereference searching(){
        isOnLoad = false;
        isSearching = true;
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
    
        if (counter == null) {
    
        PageReference pr1 = new PageReference('/apex/NewLogin');
        pr1.setredirect(true);
        return pr1;
    
        } else {
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
        Integer count = Integer.valueOf(counter.getValue());
        counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
    
        }
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});      
        string[] listOfString;
        minMrp = 0;
        maxMrp = 0;
        //Make the dynamic string to get all the models
        string queryString = 'Select Id,name,Photo__c,Proc_Source__c,Design_Story__c ,Fold__c,Product_Category_Taneira__c,';
        queryString = queryString + 'Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Suggested_MRP__c,Detailed_Colour__c,Fabric__c ,Collection__c,Pallu_Size__c,';
        queryString = queryString + 'colour__c,Zari_Type__c,Cluster__c,Account__c,Account__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Comments__c,';
        queryString = queryString + 'Taneira_Material_Weft__c,Saree_Dimensions__c,SKU_Code__c,Material_Wrap__c,Blouse_Type__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,';
        queryString = queryString + 'Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Border_Size__c,';
        queryString = queryString + 'Story_1__c,Story_2__c,Design_Description__c,PO_Number__c,Handloommark__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c FROM Product__c where RecordTypeId = \'' +productRecordType +'\'';
        
        //condition to check whether filter key is not null 
        if(filterKey !=null){
        system.debug('-----------filterKey-------------'+filterKey);
            string[]  strList  =  filterKey.split('KVP');
            //strList = strList.replace(',','\',\'');
            //strList = '(\''+strList+'\')';
            system.debug('------------strList----------'+strList  );
            //Condition to check whether the base string is vendor or not
            if(strList[0] == 'vendor'){
                //collect the vendor values which are selected in the front end
                if(!vendorFilterSet.contains(strList[1])){
                
                    vendorFilterSet.add(strList[1]);
                    
                }else{
                    set<string> vendorFilterSet1 = new set<string>();
                                
                    for(string str:vendorFilterSet ){
                        if(str != strList[1]){
                        
                            vendorFilterSet1.add(str);
                            
                        }
                    }
                    vendorFilterSet  = new set<string>();
                    
                    if(!vendorFilterSet1.isempty()){
                        
                        vendorFilterSet.addAll(vendorFilterSet1);    
                    }
                }
                
            } 
            //Condition to check whether the base string is category or not
            else if(strList[0] == 'category'){
                //collect the category values which are selected in the front end
                if(!categoryFilterSet.contains(strList[1])){
                
                    categoryFilterSet.add(strList[1]);
                    
                }else{
                    set<string> categoryFilterSet1 = new set<string>();
                                
                    for(string str:categoryFilterSet ){
                        if(str != strList[1]){
                        
                            categoryFilterSet1.add(str);
                            
                        }
                    }
                    categoryFilterSet  = new set<string>();
                    
                    if(!categoryFilterSet1.isempty()){
                        
                        categoryFilterSet.addAll(categoryFilterSet1);    
                    }
                }
                
            }            
            //Condition to check whether the base string is wrap or not
            else if(strList[0] == 'Warp'){
                //collect the wrap values which are selected in the front end
                if(!wrapSet.contains(strList[1])){
                
                    wrapSet.add(strList[1]);
                    
                }else{
                    set<string> wrapSet1 = new set<string>();
                                
                    for(string str:wrapSet ){
                        if(str != strList[1]){
                        
                            wrapSet1.add(str);
                            
                        }
                    }
                    wrapSet  = new set<string>();
                    
                    if(!wrapSet1.isempty()){
                        
                        wrapSet.addAll(wrapSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is weft or not
            else if(strList[0] == 'weft'){
                //collect the weft values which are selected in the front end
                if(!weftSet.contains(strList[1])){
                
                    weftSet.add(strList[1]);
                    
                }else{
                    set<string> weftSet1 = new set<string>();
                                
                    for(string str:weftSet ){
                        if(str != strList[1]){
                        
                            weftSet1.add(str);
                            
                        }
                    }
                    weftSet  = new set<string>();
                    
                    if(!weftSet1.isempty()){
                        
                        weftSet.addAll(weftSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is origin or not
            else if(strList[0] == 'origin'){
                //collect the origin values which are selected in the front end
                if(!originFilterSet.contains(strList[1])){
                
                    originFilterSet.add(strList[1]);
                    
                }else{
                    set<string> originFilterSet1 = new set<string>();
                                
                    for(string str:originFilterSet ){
                        if(str != strList[1]){
                        
                            originFilterSet1.add(str);
                            
                        }
                    }
                    originFilterSet  = new set<string>();
                    
                    if(!originFilterSet1.isempty()){
                        
                        originFilterSet.addAll(originFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is craft or not
            else if(strList[0] == 'craft'){
                //collect the craft values which are selected in the front end
                if(!craftSet.contains(strList[1])){
                
                    craftSet.add(strList[1]);
                    
                }else{
                    set<string> craftSet1 = new set<string>();
                                
                    for(string str:craftSet ){
                        if(str != strList[1]){
                        
                            craftSet1.add(str);
                            
                        }
                    }
                    craftSet  = new set<string>();
                    
                    if(!craftSet1.isempty()){
                        
                        craftSet.addAll(craftSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is design or not
         /*   else if(strList[0] == 'designType'){
                //collect the design values which are selected in the front end
                if(!designSet.contains(strList[1])){
                
                    designSet.add(strList[1]);
                    
                }else{
                    set<string> designSet1 = new set<string>();
                                
                    for(string str:designSet ){
                        if(str != strList[1]){
                        
                            designSet1.add(str);
                            
                        }
                    }
                    designSet  = new set<string>();
                    
                    if(!designSet1.isempty()){
                        
                        designSet.addAll(designSet1);    
                    }
                }
                                
            } */
            //Condition to check whether the base string is color or not
            else if(strList[0] == 'color'){
                //collect the color values which are selected in the front end
                if(!colorSet.contains(strList[1])){
                
                    colorSet.add(strList[1]);
                    
                }else{
                    set<string> colorSet1 = new set<string>();
                                
                    for(string str:colorSet ){
                        if(str != strList[1]){
                        
                            colorSet1.add(str);
                            
                        }
                    }
                    colorSet  = new set<string>();
                    
                    if(!colorSet1.isempty()){
                        
                        colorSet.addAll(colorSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is articalNumber or not
           /* else if(strList[0] == 'articalNumber'){
                //collect the articalNumber values which are selected in the front end
                if(!articalSet.contains(strList[1])){
                
                    articalSet.add(strList[1]);
                    
                }else{
                    set<string> articalSet1 = new set<string>();
                                
                    for(string str:articalSet ){
                        if(str != strList[1]){
                        
                            articalSet1.add(str);
                            
                        }
                    }
                    articalSet  = new set<string>();
                    
                    if(!articalSet1.isempty()){
                        
                        articalSet.addAll(articalSet1);    
                    }
                }
                
            } */
            else if(strList[0] == 'suggestedMRP'){
                string[]  mrpValue  = strList[1].split('-');
                minMrp = decimal.valueOf(mrpValue[0]);
                maxMrp = decimal.valueOf(mrpValue[1]);
            } 
            //added by Rahul
            //Condition to check whether the base string is Loom or not
            else if(strList[0] == 'loom'){
                //collect the loom values which are selected in the front end
                if(!loomFilterSet.contains(strList[1])){
                
                    loomFilterSet.add(strList[1]);
                    
                }else{
                    set<string> loomFilterSet1 = new set<string>();
                                
                    for(string str:loomFilterSet ){
                        if(str != strList[1]){
                        
                            loomFilterSet1.add(str);
                            
                        }
                    }
                    loomFilterSet  = new set<string>();
                    
                    if(!loomFilterSet1.isempty()){
                        
                        loomFilterSet.addAll(loomFilterSet1);    
                    }
                }
                
            } 
            //Condition to check whether the base string is ZariType or not
            else if(strList[0] == 'zari'){
                //collect the zari values which are selected in the front end
                if(!zariFilterSet.contains(strList[1])){
                
                    zariFilterSet.add(strList[1]);
                    
                }else{
                    set<string> zariFilterSet1 = new set<string>();
                                
                    for(string str:zariFilterSet ){
                        if(str != strList[1]){
                        
                            zariFilterSet1.add(str);
                            
                        }
                    }
                    zariFilterSet  = new set<string>();
                    
                    if(!zariFilterSet1.isempty()){
                        
                        zariFilterSet.addAll(zariFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is Body Pattern or not
            else if(strList[0] == 'bodyPattern'){
                //collect the bodyPattern values which are selected in the front end
                if(!bodyPatternFilterSet.contains(strList[1])){
                
                    bodyPatternFilterSet.add(strList[1]);
                    
                }else{
                    set<string> bodyPatternFilterSet1 = new set<string>();
                                
                    for(string str:bodyPatternFilterSet ){
                        if(str != strList[1]){
                        
                            bodyPatternFilterSet1.add(str);
                            
                        }
                    }
                    bodyPatternFilterSet  = new set<string>();
                    
                    if(!bodyPatternFilterSet1.isempty()){
                        
                        bodyPatternFilterSet.addAll(bodyPatternFilterSet1);    
                    }
                }
                
            } 
            //Condition to check whether the base string is Pallu Pattern or not
            else if(strList[0] == 'palluPattern'){
                //collect the bodyPattern values which are selected in the front end
                if(!palluPatternFilterSet.contains(strList[1])){
                
                    palluPatternFilterSet.add(strList[1]);
                    
                }else{
                    set<string> palluPatternFilterSet1 = new set<string>();
                                
                    for(string str:palluPatternFilterSet){
                        if(str != strList[1]){
                        
                            palluPatternFilterSet1.add(str);
                            
                        }
                    }
                    palluPatternFilterSet  = new set<string>();
                    
                    if(!palluPatternFilterSet1.isempty()){
                        
                        palluPatternFilterSet.addAll(palluPatternFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is occasion or not
            
            else if(strList[0] == 'occasion'){
                
                if(!occasionFilterSet.contains(strList[1])){
                
                    occasionFilterSet.add(strList[1]);
                    
                }else{
                    set<string> occasionFilterSet1 = new set<string>();
                                
                    for(string str:occasionFilterSet){
                        if(str != strList[1]){
                        
                            occasionFilterSet1.add(str);
                            
                        }
                    }
                    occasionFilterSet  = new set<string>();
                    
                    if(!occasionFilterSet1.isempty()){
                        
                        occasionFilterSet.addAll(occasionFilterSet1);    
                    }
                }
                
            } 
            //Condition to check whether the base String is Saree Dimensions
            
            else if(strList[0] == 'sareedimension'){
                
                if(!sareeDimenFilterSet.contains(strList[1])){
                
                    sareeDimenFilterSet.add(strList[1]);
                    
                }else{
                    set<string> sareeDimenFilterSet1 = new set<string>();
                                
                    for(string str:sareeDimenFilterSet){
                        if(str != strList[1]){
                        
                            sareeDimenFilterSet1.add(str);
                            
                        }
                    }
                    sareeDimenFilterSet  = new set<string>();
                    
                    if(!sareeDimenFilterSet1.isempty()){
                        
                        sareeDimenFilterSet.addAll(sareeDimenFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is Design Story or not
            else if(strList[0] == 'designstory'){
                
                if(!designStoryFilterSet.contains(strList[1])){
                
                    designStoryFilterSet.add(strList[1]);
                    
                }else{
                    set<string> designStoryFilterSet1 = new set<string>();
                                
                    for(string str:designStoryFilterSet){
                        if(str != strList[1]){
                        
                            designStoryFilterSet1.add(str);
                            
                        }
                    }
                    designStoryFilterSet  = new set<string>();
                    
                    if(!designStoryFilterSet1.isempty()){
                        
                        designStoryFilterSet.addAll(designStoryFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is Body Des Material or not
            else if(strList[0] == 'bodydesmaterial'){
                
                if(!bodyDesMatFilterSet.contains(strList[1])){
                
                    bodyDesMatFilterSet.add(strList[1]);
                    
                }else{
                    set<string> bodyDesMatFilterSet1 = new set<string>();
                                
                    for(string str:bodyDesMatFilterSet){
                        if(str != strList[1]){
                        
                            bodyDesMatFilterSet1.add(str);
                            
                        }
                    }
                    bodyDesMatFilterSet  = new set<string>();
                    
                    if(!bodyDesMatFilterSet1.isempty()){
                        
                        bodyDesMatFilterSet.addAll(bodyDesMatFilterSet1);    
                    }
                }
                
            } 
            //Condition to check whether the base string is Body Des Element or not
            else if(strList[0] == 'bodydeselement'){
                
                if(!bodyDesElemFilterSet.contains(strList[1])){
                
                    bodyDesElemFilterSet.add(strList[1]);
                    
                }else{
                    set<string> bodyDesElemFilterSet1 = new set<string>();
                                
                    for(string str:bodyDesElemFilterSet){
                        if(str != strList[1]){
                        
                            bodyDesElemFilterSet1.add(str);
                            
                        }
                    }
                    bodyDesElemFilterSet  = new set<string>();
                    
                    if(!bodyDesElemFilterSet1.isempty()){
                        
                        bodyDesElemFilterSet.addAll(bodyDesElemFilterSet1);    
                    }
                }
                
            } 
            //Condition to check whether the base string is Body Des Density or not
            else if(strList[0] == 'bodydesdensity'){
                
                if(!bodyDesDensFilterSet.contains(strList[1])){
                
                    bodyDesDensFilterSet.add(strList[1]);
                    
                }else{
                    set<string> bodyDesDensFilterSet1 = new set<string>();
                                
                    for(string str:bodyDesDensFilterSet){
                        if(str != strList[1]){
                        
                            bodyDesDensFilterSet1.add(str);
                            
                        }
                    }
                    bodyDesDensFilterSet  = new set<string>();
                    
                    if(!bodyDesDensFilterSet1.isempty()){
                        
                        bodyDesDensFilterSet.addAll(bodyDesDensFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is Pallu Des Material or not
            else if(strList[0] == 'palludesmaterial'){
                
                if(!palluDesMatFilterSet.contains(strList[1])){
                
                    palluDesMatFilterSet.add(strList[1]);
                    
                }else{
                    set<string> palluDesMatFilterSet1 = new set<string>();
                                
                    for(string str:palluDesMatFilterSet){
                        if(str != strList[1]){
                        
                            palluDesMatFilterSet1.add(str);
                            
                        }
                    }
                    palluDesMatFilterSet  = new set<string>();
                    
                    if(!palluDesMatFilterSet1.isempty()){
                        
                        palluDesMatFilterSet.addAll(palluDesMatFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is Pallu Size or not
            else if(strList[0] == 'pallusize'){
                
                if(!palluSizeFilterSet.contains(strList[1])){
                
                    palluSizeFilterSet.add(strList[1]);
                    
                }else{
                    set<string> palluSizeFilterSet1 = new set<string>();
                                
                    for(string str:palluSizeFilterSet){
                        if(str != strList[1]){
                        
                            palluSizeFilterSet1.add(str);
                            
                        }
                    }
                    palluSizeFilterSet  = new set<string>();
                    
                    if(!palluSizeFilterSet1.isempty()){
                        
                        palluSizeFilterSet.addAll(palluSizeFilterSet1);    
                    }
                }
                
            }
            //Condition to check whether the base string is Border Pattern or not
            else if(strList[0] == 'borderpattern'){
                
                if(!borderPatternFilterSet.contains(strList[1])){
                
                    borderPatternFilterSet.add(strList[1]);
                    
                }else{
                    set<string> borderPatternFilterSet1 = new set<string>();
                                
                    for(string str:borderPatternFilterSet){
                        if(str != strList[1]){
                        
                            borderPatternFilterSet1.add(str);
                            
                        }
                    }
                    borderPatternFilterSet  = new set<string>();
                    
                    if(!borderPatternFilterSet1.isempty()){
                        
                        borderPatternFilterSet.addAll(borderPatternFilterSet1);    
                    }
                }
                
            }
            
            //Condition to check whether the base string is Border Des Element or not
            else if(strList[0] == 'borderdeselement'){
                
                if(!borderDesElemFilterSet.contains(strList[1])){
                
                    borderDesElemFilterSet.add(strList[1]);
                    
                }else{
                    set<string> borderDesElemFilterSet1 = new set<string>();
                                
                    for(string str:borderDesElemFilterSet){
                        if(str != strList[1]){
                        
                            borderDesElemFilterSet1.add(str);
                            
                        }
                    }
                    borderDesElemFilterSet  = new set<string>();
                    
                    if(!borderDesElemFilterSet1.isempty()){
                        
                        borderDesElemFilterSet.addAll(borderDesElemFilterSet1);    
                    }
                }
                
            }
            
            //Condition to check whether the base string is Border Des Material or not
            else if(strList[0] == 'borderdesmaterial'){
                
                if(!borderDesMaterFilterSet.contains(strList[1])){
                
                    borderDesMaterFilterSet.add(strList[1]);
                    
                }else{
                    set<string> borderDesMaterFilterSet1 = new set<string>();
                                
                    for(string str:borderDesMaterFilterSet){
                        if(str != strList[1]){
                        
                            borderDesMaterFilterSet1.add(str);
                            
                        }
                    }
                    borderDesMaterFilterSet  = new set<string>();
                    
                    if(!borderDesMaterFilterSet1.isempty()){
                        
                        borderDesMaterFilterSet.addAll(borderDesMaterFilterSet1);    
                    }
                }
                
            }
            
            
            //Condition to check whether the base string is Border Size or not
            else if(strList[0] == 'bordersize'){
                
                if(!borderSizeFilterSet.contains(strList[1])){
                
                    borderSizeFilterSet.add(strList[1]);
                    
                }else{
                    set<string> borderSizeFilterSet1 = new set<string>();
                                
                    for(string str:borderSizeFilterSet){
                        if(str != strList[1]){
                        
                            borderSizeFilterSet1.add(str);
                            
                        }
                    }
                    borderSizeFilterSet  = new set<string>();
                    
                    if(!borderSizeFilterSet1.isempty()){
                        
                        borderSizeFilterSet.addAll(borderSizeFilterSet1);    
                    }
                }
                
            }
            
            //Condition to check whether the base string is Product Description or not
          /*  else if(strList[0] == 'productdescription'){
                
                if(!productDescFilterSet.contains(strList[1])){
                
                    productDescFilterSet.add(strList[1]);
                    
                }else{
                    set<string> productDescFilterSet1 = new set<string>();
                                
                    for(string str:productDescFilterSet){
                        if(str != strList[1]){
                        
                            productDescFilterSet1.add(str);
                            
                        }
                    }
                    productDescFilterSet  = new set<string>();
                    
                    if(!productDescFilterSet1.isempty()){
                        
                        productDescFilterSet.addAll(productDescFilterSet1);    
                    }
                }
                
            }*/
            
            //Condition to check whether the base string is Pallu Design or not
            else if(strList[0] == 'palludesign'){
                
                if(!palluDesignFilterSet.contains(strList[1])){
                
                    palluDesignFilterSet.add(strList[1]);
                    
                }else{
                    set<string> palluDesignFilterSet1 = new set<string>();
                                
                    for(string str:palluDesignFilterSet){
                        if(str != strList[1]){
                        
                            palluDesignFilterSet1.add(str);
                            
                        }
                    }
                    palluDesignFilterSet  = new set<string>();
                    
                    if(!palluDesignFilterSet1.isempty()){
                        
                        palluDesignFilterSet.addAll(palluDesignFilterSet1);    
                    }
                }
                
            }
             //Condition for ProcTypeAttributes
            else if(strList[0] == 'procType'){
                //collect the ProcType values which are selected in the front end
                if(!procTypeFilterSet.contains(strList[1])){
                
                    procTypeFilterSet.add(strList[1]);
                    
                }else{
                    Set<string> procTypeFilterSet1 = new Set<string>();
                                
                    for(String str:procTypeFilterSet ){
                        if(str != strList[1]){
                        
                            procTypeFilterSet1.add(str);
                            
                        }
                    }
                    procTypeFilterSet  = new Set<string>();
                    
                    if(!procTypeFilterSet1.isempty()){
                        
                        procTypeFilterSet.addAll(procTypeFilterSet1);    
                    }
                }
                
            }
                
                
          
            //Condition to check whether the base string is color or not
            else if(strList[0] == 'color'){
                //collect the color values which are selected in the front end
                if(!colorSet.contains(strList[1])){
                
                    colorSet.add(strList[1]);
                    
                }else{
                    set<string> colorSet1 = new set<string>();
                                
                    for(string str:colorSet ){
                        if(str != strList[1]){
                        
                            colorSet1.add(str);
                            
                        }
                    }
                    colorSet  = new set<string>();
                    
                    if(!colorSet1.isempty()){
                        
                        colorSet.addAll(colorSet1);    
                    }
                }
                
            }
            
        }
        system.debug('----------vendorFilterSet----------'+vendorFilterSet);
        
        
        
        //Checks the set whether the Vendor set is empty or not. if it not empty add the condition to the dynamic query
        
        if(!vendorFilterSet.isEmpty()){
            queryString  = queryString+'  AND Account__r.name IN ' +setToStringConvert(vendorFilterSet);
        } 
        if(!categoryFilterSet.isEmpty()){
            queryString  = queryString+'  AND Product_Category_Taneira__c in ' +setToStringConvert(categoryFilterSet);
        } 
        if(!wrapSet.isEmpty()){
            queryString  = queryString+'  AND Material_Wrap__c in ' +setToStringConvert(wrapSet);
        } 
        if(!weftSet.isEmpty()){
            queryString  = queryString+'  AND Taneira_Material_Weft__c in ' +setToStringConvert(weftSet);
        } 
        if(!originFilterSet.isEmpty()){
            queryString  = queryString+'  AND Cluster__c in ' +setToStringConvert(originFilterSet);
        } 
        if(!craftSet.isEmpty()){
            queryString  = queryString+'  AND Workmanship__c in ' +setToStringConvert(craftSet);
        } 
     /*   if(!designSet.isEmpty()){
            queryString  = queryString+'  AND Design_Type__c in:designSet';
        } */
        if(!colorSet.isEmpty()){
            queryString  = queryString+'  AND Colour__c in:colorSet';
        } 
      /*  if(!articalSet.isEmpty()){
            queryString  = queryString+'  AND Article_Number__c in:articalSet';
        } */
        if(maxMrp > 0){
            queryString  = queryString+' AND Suggested_MRP__c >= ' +minMrp +'AND Suggested_MRP__c <= ' +maxMrp;    
        }
        if(!loomFilterSet.isEmpty()){
            queryString = queryString+'AND Loom__c IN '+setToStringConvert(loomFilterSet); //added by Rahul
        }
        if(!zariFilterSet.isEmpty()){
            queryString=queryString+'AND Zari_Type__c IN '+setToStringConvert(zariFilterSet);
        }
        if(!bodyPatternFilterSet.isEmpty()){
            queryString=queryString+'AND Body_Pattern__c IN'+setToStringConvert(bodyPatternFilterSet);
        }
        if(!palluPatternFilterSet.isEmpty()){
            queryString=queryString+'AND Pallu_Pattern__c IN '+setToStringConvert(palluPatternFilterSet);
        }
        if(!occasionFilterSet.isEmpty()){
            queryString=queryString+'AND Occasion__c IN '+setToStringConvert(occasionFilterSet);
        }
        if(!sareeDimenFilterSet.isEmpty()){
            queryString=queryString+'AND Saree_Dimensions__c IN '+setToStringConvert(sareeDimenFilterSet);
        }
        if(!designStoryFilterSet.isEmpty()){
            queryString=queryString+'AND Design_Story__c IN '+setToStringConvert(designStoryFilterSet);
        }
        if(!bodyDesMatFilterSet.isEmpty()){
            queryString=queryString+'AND Body_Des_Material__c IN '+setToStringConvert(bodyDesMatFilterSet);
        }
        if(!bodyDesElemFilterSet.isEmpty()){
            queryString=queryString+'AND Body_Des_Element__c IN '+setToStringConvert(bodyDesElemFilterSet);
        }
        if(!bodyDesDensFilterSet.isEmpty()){
            queryString=queryString+'AND Body_Des_Density__c IN '+setToStringConvert(bodyDesDensFilterSet);
        }
        if(!palluDesMatFilterSet.isEmpty()){
            queryString=queryString+'AND Pallu_Des_Material__c IN '+setToStringConvert(palluDesMatFilterSet);
        }
        if(!palluSizeFilterSet.isEmpty()){
            queryString=queryString+'AND Pallu_Size__c IN '+setToStringConvert(palluSizeFilterSet);
        }
        if(!borderPatternFilterSet.isEmpty()){
            queryString=queryString+'AND Border_Pattern__c IN '+setToStringConvert(borderPatternFilterSet);
        }
        if(!borderDesElemFilterSet.isEmpty()){
            queryString=queryString+'AND Border_Des_Element__c IN '+setToStringConvert(borderDesElemFilterSet);
        }
        if(!borderDesMaterFilterSet.isEmpty()){
            queryString=queryString+'AND Border_Des_Material__c IN '+setToStringConvert(borderDesMaterFilterSet);
        }
        if(!borderSizeFilterSet.isEmpty()){
            queryString=queryString+'AND Border_Size__c IN '+setToStringConvert(borderSizeFilterSet);
        }
        /*if(!productDescFilterSet.isEmpty()){
            queryString=queryString+'AND Product_Description__c IN '+setToStringConvert(productDescFilterSet);
        }*/
        if(!palluDesignFilterSet.isEmpty()){
            queryString=queryString+'AND Pallu_Design__c IN '+setToStringConvert(palluDesignFilterSet);
        }
        if(!procTypeFilterSet.isEmpty()){
            queryString=queryString+'AND Proc_Type__c IN '+setToStringConvert(procTypeFilterSet);
        }
        
        queryStringForRemoteSerch = queryString;
        //convertToJSON(queryString);
        //return pr;
        return null;
    }
    public String setToStringConvert(set<String> setStrToConv){
        system.debug('--------setStrToConv--------'+setStrToConv);
        string strVendor = '';
        for( String vendor : setStrToConv){
            strVendor += vendor +'\',\'';
        }
        if(strVendor.length() > 0){
            strVendor = strVendor.removeEnd(',\'');
            strVendor = '(\'' +strVendor +')';
        }
        system.debug('--------strVendor--------'+strVendor);
        return strVendor;
    }
    
    //method to expire the cookie that is logout from the page
    public pagereference logout(){
    
       Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
         
         counter = new Cookie('counter','1',null,0,false);
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
       PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
    }//End of method
    
    //Wrapper class to store filter
    public class filterWrapper{

        public string name{get;set;}
        
    }//End of class
    public class originFilterWrapper {
        Public string designType{get;set;}
        public string name{get;set;}         
    }
    public class designTypeWrapper{
        public string articalNumber{get;set;}
        public string name{get;set;}
    }
}