global class PaginationDemoController {
    public enum SORT_BY {
        ByTitle,ByPage
        }
    public static SORT_BY sortBy = SORT_BY.ByTitle; 

    /*public PaginationDemoController(accCtrl controller) {

    }*/


    global static Set < String > dataSearchOptionsKeys {
        get;
        set;
    }
    global static Map < String, String > classKeyMap {
        get;
        set;
    }
    global static Map < String, Set < String >> dataSearchOptions {
        get;
        set;
    }
    global static integer totalAPICalls {
        get;
        set;
    }
    global static integer defaultProdsSize {
        get;
        set;
    }
    global static list < JsonValue > jsonstringList {
        get;
        set;
    }
    global static id lstid {
        get;
        set;
    }
    global static String prods {
        get;
        set;
    }
    global static integer totalProducts {
        get;
        set;
    }
    global static list < String > vendorLst {
        get;
        set;
    }
    global String filterDataString {
        get;
        set;
    }
    global static Map < Id, String > vendorIdMap {
        get;
        set;
    }
    global Integer count {
        get;
        set;
    }
    global static Map < String, String > masterMap {
        get;
        set;
    }
    global static List < CostBandCustSett > costBandCustSetList {
        get;
        set;
    }
    global static List < CostPriceCustSett > costPriceRangeList {
        get;
        set;
    }

    public class JsonValue {

        public String name {
            get;
            set;
        }
        public Id VendorId {
            get;
            set;
        }
    }
    public class CostBandCustSett implements Comparable{
        public String dispVal {
            get;
            set;
        }
        public String paramVal {
            get;
            set;
        }
        
        public Integer compareTo(Object objToCompare){
            if(sortBy == SORT_BY.ByTitle){
                return dispVal.compareTo(((CostBandCustSett)objToCompare).dispVal);
            }
            else{
                return Integer.valueOf(((CostBandCustSett)objToCompare).paramVal);
            }
    }
    }
    public class CostPriceCustSett implements Comparable {
        public String costPriceDisp {
            get;
            set;
        }
        public String costPriceParam {
            get;
            set;
        }
        public Integer compareTo(Object objToCompare){
            if(sortBy == SORT_BY.ByTitle){
                return costPriceDisp.compareTo(((CostPriceCustSett)objToCompare).costPriceDisp);
            }
            else{
                return Integer.valueOf(((CostPriceCustSett)objToCompare).costPriceParam);
            }
    }
    }
    

    global PaginationDemoController() {
        //String labelValue='';
        String soqlWhere = '';
        String productRecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        Integer recordsLimit2 = Integer.valueOf(Label.QUERY_LIMIT);
        defaultProdsSize = Integer.valueOf(Label.QUERY_LIMIT);
        //labelValue=Label.CostBandFilter;//will get the costband filters
        //List<String> costFilterList = new List<String>(labelValue.split(','));
        dataSearchOptions = new Map < String, Set < String >> ();
        classKeyMap = new Map < String, String > ();
        Set < String > categories = new Set < String > ();
        categories.add('Product Category');
        categories.add('Proc-Type');
        categories.add('Origin');
        categories.add('Loom');
        categories.add('Weft');
        categories.add('Warp');
        categories.add('Zari Type');
        categories.add('Craft');
        categories.add('Occasion'); // added by Mayur 29.11.2018
        categories.add('Color'); // added by Mayur 29.11.2018
        categories.add('Border Des Element');
        categories.add('Border Pattern');
        categories.add('Body Des Material');
        categories.add('Body Des Element');
        categories.add('Body Des Density');
        categories.add('Body Pattern');
        categories.add('Blouse Dimensions');
        categories.add('Border Des Material');
        categories.add('Border Size');
        categories.add('Pallu Des Density');
        categories.add('Pallu Des Material');
        categories.add('Pallu Pattern');
        categories.add('Pallu Size');
        set < String > duplicateSet = new set < String > ();
        Map < Id, String > vendorIdMap = new Map < Id, String > ();

        String tmpStr = '';
        Set < String > tmp;
        Decimal val1, val2, val3, val4;
        Integer counter = 0, counter1 = 0;
        //vendorLst = new list<String>();
        jsonstringList = new List < JsonValue > ();
        //vendorIdMap = new Map<Id,String>();
        masterMap = new Map < String, String > ();
        costBandCustSetList = new List < CostBandCustSett > ();
        costPriceRangeList = new List < CostPriceCustSett > ();
        Map < String, Set < String >> prodAttribMap = new Map < String, Set < String >> ();
        Set < String > fabrSet = new Set < String > ();
        Set < String > wareHouseSet = new Set < String > ();
        Set < String > soldSet = new Set < String > ();
        Set < String > stockSet = new Set < String > ();
        Set < String > costFilterSet = new Set < String > ();
        Set < String > bodyDesMatSet = new Set < String > ();
        Set < String > bodyDesElemSet = new Set < String > ();
        Set < String > bodyDesDensitySet = new Set < String > ();
        Set < String > bodyPatternSet = new Set < String > ();
        //Set<String> mrpSet = new Set<String>();
        /*--------------------------------------------------------------*/
        //adding new values from Custom Label here
        Map < String, Taneira_Cost_Band_Range__c > rangeMap = Taneira_Cost_Band_Range__c.getAll();
        CostBandCustSett custSetObj;
        if (!rangeMap.isEmpty()) {
            for (String rangeValues: rangeMap.keySet()) {
                custSetObj = new CostBandCustSett();
                custSetObj.dispVal = rangeValues;
                custSetObj.paramVal = rangeMap.get(rangeValues).Values__c;
                costBandCustSetList.add(custSetObj);
                // mrpSet.add(rangeValues);
                //masterMap1.put(rangeValues,rangeMap.get(rangeValues).Values__c);
                masterMap.put(rangeValues, rangeValues.replace(' ', '_').toLowerCase());
            }
        }
        costBandCustSetList.sort();
        Map < String, Taneira_CostPriceBand__c > costRangeMap = Taneira_CostPriceBand__c.getAll();
        CostPriceCustSett costCustObj;
        if (!costRangeMap.isEmpty()) {
            for (String custVal: costRangeMap.keySet()) {
                costCustObj = new CostPriceCustSett();
                costCustObj.costPriceDisp = custVal;
                costCustObj.costPriceParam = costRangeMap.get(custVal).CostPriceRange__c;
                costPriceRangeList.add(costCustObj);
                masterMap.put(custVal, custVal.replace(' ', '_').toLowerCase());
            }
        }
        costPriceRangeList.sort();

        //System.debug('mrpSet::: '+mrpSet);
        System.debug('masterMap::: ' + masterMap);
        /*if(costFilterList.size()>0){
            for(String str : costFilterList){
                costFilterSet.add(str);
                tmpStr=str;
                //System.debug('--tmpStr in costfilter--'+tmpStr);
                masterMap.put(str,tmpStr.replace(' ','_').toLowerCase());
            }
        }*/
        //System.debug('Checking the value for Custom Label in masterMap---->>'+masterMap);
        //till here.

        //dataSearchOptions.put('Fabric',fabrSet);
        //dataSearchOptions.put('WareHouse',wareHouseSet);
        //dataSearchOptions.put('Store',stockSet);
        //dataSearchOptions.put('Sold',soldSet);
        //dataSearchOptions.put('CostFilter',costFilterSet);

        /*----------------------------------------------------------------*/


        for (Product__c eachProd: [SELECT Fabric__c, Warehouse_Stock__c, Sold_Stock__c, Store_Stock__c, Body_Des_Density__c, Body_Des_Element__c, Body_Des_Material__c, Body_Pattern__c FROM Product__c WHERE(Fabric__c != NULL AND Fabric__c != ''
                AND RecordTypeId =: productRecordTypeId) OR(RecordTypeId =: productRecordTypeId AND(Warehouse_Stock__c != NULL OR Sold_Stock__c != NULL OR Store_Stock__c != NULL)) ORDER BY Warehouse_Stock__c ASC, Sold_Stock__c ASC, Store_Stock__c ASC]) {
            if (eachProd.Fabric__c != NULL && eachProd.Fabric__c != '') {
                fabrSet.add(eachProd.Fabric__c);
                tmpStr = eachProd.Fabric__c;
                //System.debug('----tmpStr---'+tmpStr);
                masterMap.put(eachProd.Fabric__c, tmpStr.replace(' ', '_').toLowerCase());


            }
            if (eachProd.Warehouse_Stock__c != NULL) {
                wareHouseSet.add(String.valueOf(eachProd.Warehouse_Stock__c));
                tmpStr = String.valueOf(eachProd.Warehouse_Stock__c);
                masterMap.put(String.valueOf(eachProd.Warehouse_Stock__c), tmpStr.replace(' ', '_').toLowerCase());
            }
            if (eachProd.Sold_Stock__c != NULL) {
                soldSet.add(String.valueOf(eachProd.Sold_Stock__c));
                tmpStr = String.valueOf(eachProd.Sold_Stock__c);
                masterMap.put(String.valueOf(eachProd.Sold_Stock__c), tmpStr.replace(' ', '_').toLowerCase());
            }
            if (eachProd.Store_Stock__c != NULL) {
                stockSet.add(String.valueOf(eachProd.Store_Stock__c));
                tmpStr = String.valueOf(eachProd.Store_Stock__c);
                masterMap.put(String.valueOf(eachProd.Store_Stock__c), tmpStr.replace(' ', '_').toLowerCase());
            }

        }



        dataSearchOptions.put('Fabric', fabrSet); //will arrange the filters accordingly if put into this map.
        //dataSearchOptions.put('MRP',mrpSet);
        for (Master__c master: [SELECT Name, Name__c FROM Master__c WHERE Active__c = true AND Name__c IN: categories ORDER BY Name__c, Name ASC]) {
            //System.debug('----master--->>'+master);
            if (master.Name != null && master.Name != '') {
                tmp = (dataSearchOptions.get(master.Name__c) == null) ? new Set < String > () : dataSearchOptions.get(master.Name__c);
                tmp.add(master.Name);
                tmpStr = master.Name;
                dataSearchOptions.put(master.Name__c, tmp);
                tmpStr = master.Name;
                masterMap.put(master.Name, tmpStr.replace(' ', '_').toLowerCase());
            }
        }
        JsonValue wrpObj;
        for (Account acc: [SELECT Name, Id, recordType.Name FROM Account WHERE recordType.Name = 'Vendor'
                ORDER BY Name ASC
            ]) {
            if (acc != NULL) {
                wrpObj = new JsonValue();
                wrpObj.name = acc.Name;
                wrpObj.VendorId = acc.Id;
                jsonstringList.add(wrpObj);
                tmpStr = acc.Id;

                masterMap.put(acc.Id, tmpStr.replace(' ', '_').toLowerCase());
            }
        }

        dataSearchOptions.put('WareHouse', wareHouseSet);
        dataSearchOptions.put('Store', stockSet);
        dataSearchOptions.put('Sold', soldSet);

        dataSearchOptionsKeys = dataSearchOptions.keySet();

        for (String str: dataSearchOptions.keySet()) {
            if (str.contains(' ')) {
                classKeyMap.put(str, (str.replace(' ', '_')));
            } else {
                classKeyMap.put(str, str);
            }
            System.debug('::::classKeyMap:::' + classKeyMap.keySet());
        }


        System.debug('dataSearchOptionsKeys:' + dataSearchOptionsKeys);

        String soql = 'SELECT Id, Name, Vendor_Name__c,Account__c, Product_Category_Taneira__c, SKU_Code__c,Proc_Type__c,Proc_Source__c, PO_Number__c,Cost__c,Quantity__c,Suggested_MRP__c,Cluster__c,Story_1__c,Collection__c,Design_Story__c,Material_Wrap__c,Taneira_Material_Weft__c,Zari_Type__c, Base_Colour__c,Detailed_Colour__c,Workmanship__c,Loom__c,Occasion__c,Colour__c,Cost_Band__c,Fold__c,Fabric__c,Story_2__c, Blouse_Dimensions__c,Blouse_Type__c,Blouse_Size__c,Body_Des_Element__c,Body_Des_Material__c, Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Counter_Test__c,Pallu_Size__c,Body_Des_Density__c,Sold_Stock__c,Store_Stock__c,Warehouse_Stock__c, Photo_Backup__c FROM Product__c WHERE RecordTypeId =:productRecordTypeId';


        String prodCategory = apexPages.currentPage().getParameters().get('ProductCategory');
        List < String > prodCategories = new List < String > ();
        if ((prodCategory != null && prodCategory != '') || test.isRunningTest()) {

            prodCategories = prodCategory.split(',');
            soqlWhere += ' AND (Product_Category_Taneira__c IN :prodCategories)';
        }
        //added by Mayur

        String srch = apexPages.currentPage().getParameters().get('srch');
        if (srch != null && srch != '') {

            srch = '%' + srch + '%';
            System.debug('-------srch---->>' + srch);
            soqlWhere += ' AND (Vendor_Name__c LIKE :srch OR Product_Category_Taneira__c LIKE :srch OR SKU_Code__c LIKE :srch)';
        }


        String prodVendor = apexPages.currentPage().getParameters().get('Vendor');
        System.debug('prodVendor:' + prodVendor);
        List < String > prodVend = new List < String > ();
        if (prodVendor != null && prodVendor != '') {

            prodVend = prodVendor.split(',');
            system.debug('prodVend:' + prodVend);
            soqlWhere += ' AND (Account__c IN :prodVend)';
        }

        String prodProc = apexPages.currentPage().getParameters().get('ProcType');
        List < String > prodPro = new List < String > ();
        if (prodProc != null && prodProc != '') {

            prodPro = prodProc.split(',');
            soqlWhere += ' AND (Proc_Type__c IN :prodPro)';
        }

        String prodOrigin = apexPages.currentPage().getParameters().get('Origin');
        List < String > prodOri = new List < String > ();
        if (prodOrigin != null && prodOrigin != '') {

            prodOri = prodOrigin.split(',');
            soqlWhere += ' AND (Cluster__c IN :prodOri)';
        }

        String fabricData = apexPages.currentPage().getParameters().get('Fabric');
        List < String > fabricList = new List < String > ();
        if (fabricData != null && fabricData != '') {

            fabricList = fabricData.split(',');
            soqlWhere += ' AND (Fabric__c IN :fabricList)';
        }

        String prodLoom = apexPages.currentPage().getParameters().get('Loom');
        List < String > prodLoo = new List < String > ();
        if (prodLoom != null && prodLoom != '') {

            prodLoo = prodLoom.split(',');
            soqlWhere += ' AND (Loom__c IN :prodLoo)';
        }

        String productWeft = apexPages.currentPage().getParameters().get('Weft');
        List < String > prodWeft = new List < String > ();
        if (productWeft != null && productWeft != '') {

            prodWeft = productWeft.split(',');
            soqlWhere += ' AND (Taneira_Material_Weft__c IN :prodWeft )';
        }

        String prodPoNum = apexPages.currentPage().getParameters().get('Ponumber');
        List < String > prodPo = new List < String > ();
        if (prodPoNum != null && prodPoNum != '') {

            prodPo = prodPoNum.split(',');
            soqlWhere += ' AND (PO_Number__c IN :prodPo)';
        }

        String prodProSrc = apexPages.currentPage().getParameters().get('ProcSource');
        List < String > prodPoSr = new List < String > ();
        if (prodProSrc != null && prodProSrc != '') {

            prodPoSr = prodProSrc.split(',');
            soqlWhere += ' AND (Proc_Source__c IN :prodPoSr)';
        }

        String prodQuantity = apexPages.currentPage().getParameters().get('Quantity');
        List < String > prodQua = new List < String > ();
        if (prodQuantity != null && prodQuantity != '') {

            prodQua = prodQuantity.split(',');
            soqlWhere += ' AND (PO_Number__c IN :prodQua)';
        }


        String prodStory1 = apexPages.currentPage().getParameters().get('Story1');
        List < String > prodStr1 = new List < String > ();
        if (prodStory1 != null && prodStory1 != '') {

            prodStr1 = prodStory1.split(',');
            soqlWhere += ' AND (Story_1__c IN :prodStr1)';
        }

        String prodStory2 = apexPages.currentPage().getParameters().get('Story2');
        List < String > prodStr2 = new List < String > ();
        if (prodStory2 != null && prodStory2 != '') {

            prodStr2 = prodStory2.split(',');
            soqlWhere += ' AND (Story_2__c IN :prodStr2)';
        }

        String prodDesignDescription = apexPages.currentPage().getParameters().get('DesignDescription');
        List < String > prodDDS = new List < String > ();
        if (prodDesignDescription != null && prodDesignDescription != '') {

            prodDDS = prodDesignDescription.split(',');
            soqlWhere += ' AND (Design_Description__c IN :prodDDS)';
        }

        String prodDesignStory = apexPages.currentPage().getParameters().get('DesignStory');
        List < String > prodDS = new List < String > ();
        if (prodDesignStory != null && prodDesignStory != '') {

            prodDS = prodDesignStory.split(',');
            soqlWhere += ' AND (Design_Story__c IN :prodDS)';

        }

        String prodWarp = apexPages.currentPage().getParameters().get('Warp');
        List < String > prodWr = new List < String > ();
        if (prodWarp != null && prodWarp != '') {

            prodWr = prodWarp.split(',');
            soqlWhere += ' AND (Material_Wrap__c IN :prodWr)';
        }

        String prodZariType = apexPages.currentPage().getParameters().get('ZariType');
        List < String > prodZT = new List < String > ();
        if (prodZariType != null && prodZariType != '') {

            prodZT = prodZariType.split(',');
            soqlWhere += ' AND (Zari_Type__c IN :prodZT)';
        }

        String prodBaseColor = apexPages.currentPage().getParameters().get('BaseColor');
        List < String > prodBC = new List < String > ();
        if (prodBaseColor != null && prodBaseColor != '') {

            prodBC = prodBaseColor.split(',');
            soqlWhere += ' AND (Base_Colour__c IN :prodBC)';
        }

        String prodDetailedColor = apexPages.currentPage().getParameters().get('DetailedColor');
        List < String > prodDC = new List < String > ();
        if (prodDetailedColor != null && prodDetailedColor != '') {

            prodDC = prodDetailedColor.split(',');
            soqlWhere += ' AND (Detailed_Colour__c IN :prodDC)';
        }
        String prodCraft = apexPages.currentPage().getParameters().get('Craft');
        List < String > prodCrf = new List < String > ();
        if (prodCraft != null && prodCraft != '') {

            prodCrf = prodCraft.split(',');
            soqlWhere += ' AND (Workmanship__c IN :prodCrf)';
        }


        String prodOccasion = apexPages.currentPage().getParameters().get('Occasion');
        List < String > prodOcc = new List < String > ();
        if (prodOccasion != null && prodOccasion != '') {

            prodOcc = prodOccasion.split(',');
            soqlWhere += ' AND (Occasion__c IN :prodOcc)';
        }

        String prodColor = apexPages.currentPage().getParameters().get('Color'); //added by mayur
        List < String > prodClr = new List < String > ();
        if (prodColor != null && prodColor != '') {

            prodClr = prodColor.split(',');
            soqlWhere += ' AND (Colour__c IN :prodClr)';
        }

        String prodFold = apexPages.currentPage().getParameters().get('Fold');
        List < String > prodFo = new List < String > ();
        if (prodFold != null && prodFold != '') {

            prodFo = prodFold.split(',');
            soqlWhere += ' AND (Fold__c IN :prodFo)';
        }

        String prodCollection = apexPages.currentPage().getParameters().get('Collection');
        List < String > prodColle = new List < String > ();
        if (prodCollection != null && prodCollection != '') {

            prodColle = prodCollection.split(',');
            soqlWhere += ' AND (Collection__c IN :prodColle)';
        }

        String prodBlouseDimen = apexPages.currentPage().getParameters().get('BlouseDimensions');
        List < String > prodBlouDimen = new List < String > ();
        if (prodBlouseDimen != null && prodBlouseDimen != '') {

            prodBlouDimen = prodBlouseDimen.split(',');
            soqlWhere += ' AND (Blouse_Dimensions__c IN :prodBlouDimen)';
        }

        String prodBlouseType = apexPages.currentPage().getParameters().get('BlouseType');
        List < String > prodBlouTy = new List < String > ();
        if (prodBlouseType != null && prodBlouseType != '') {

            prodBlouTy = prodBlouseType.split(',');
            soqlWhere += ' AND (Blouse_Type__c IN :prodBlouTy)';
        }

        String prodBlouseSize = apexPages.currentPage().getParameters().get('BlouseSize');
        List < String > prodBlouSize = new List < String > ();
        if (prodBlouseSize != null && prodBlouseSize != '') {

            prodBlouSize = prodBlouseSize.split(',');
            soqlWhere += ' AND (Blouse_Size__c IN :prodBlouSize)';
        }

        String prodBodyDesDensity = apexPages.currentPage().getParameters().get('BodyDesDensity');
        List < String > prodBodyDD = new List < String > ();
        if (prodBodyDesDensity != null && prodBodyDesDensity != '') {

            prodBodyDD = prodBodyDesDensity.split(',');
            soqlWhere += ' AND (Body_Des_Density__c IN :prodBodyDD)';
        }

        String prodBodyDesElement = apexPages.currentPage().getParameters().get('BodyDesElement');
        List < String > prodBodyDE = new List < String > ();
        if (prodBodyDesElement != null && prodBodyDesElement != '') {

            prodBodyDE = prodBodyDesElement.split(',');
            soqlWhere += ' AND (Body_Des_Element__c IN :prodBodyDE)';
        }

        String prodBodyDesMaterial = apexPages.currentPage().getParameters().get('BodyDesMaterial');
        List < String > prodBodyDM = new List < String > ();
        if (prodBodyDesMaterial != null && prodBodyDesMaterial != '') {

            prodBodyDM = prodBodyDesMaterial.split(',');
            soqlWhere += ' AND (Body_Des_Material__c IN :prodBodyDM)';
        }

        String prodBodyPattern = apexPages.currentPage().getParameters().get('BodyPattern');
        List < String > prodBodyPat = new List < String > ();
        if (prodBodyPattern != null && prodBodyPattern != '') {

            prodBodyPat = prodBodyPattern.split(',');
            soqlWhere += ' AND (Body_Pattern__c IN :prodBodyPat)';
        }

        String prodBorderDesElement = apexPages.currentPage().getParameters().get('BorderDesElement');
        List < String > prodBorderDesE = new List < String > ();
        if (prodBorderDesElement != null && prodBorderDesElement != '') {

            prodBorderDesE = prodBorderDesElement.split(',');
            soqlWhere += ' AND (Border_Des_Element__c IN :prodBorderDesE)';
        }

        String prodBorderdesMaterial = apexPages.currentPage().getParameters().get('BorderDesMaterial');
        List < String > prodBorderDesM = new List < String > ();
        if (prodBorderdesMaterial != null && prodBorderdesMaterial != '') {

            prodBorderDesM = prodBorderdesMaterial.split(',');
            soqlWhere += ' AND (Border_Des_Material__c IN :prodBorderDesM)';
        }

        String prodBorderPattern = apexPages.currentPage().getParameters().get('BorderPattern');
        List < String > prodBorderPatt = new List < String > ();
        if (prodBorderPattern != null && prodBorderPattern != '') {

            prodBorderPatt = prodBorderPattern.split(',');
            soqlWhere += ' AND (Border_Pattern__c IN :prodBorderPatt)';
        }

        String prodBorderSize = apexPages.currentPage().getParameters().get('BorderSize');
        List < String > prodorderSZ = new List < String > ();
        if (prodBorderSize != null && prodBorderSize != '') {

            prodorderSZ = prodBorderSize.split(',');
            soqlWhere += ' AND (Border_Size__c IN :prodorderSZ)';
        }

        String prodPalluDesDensity = apexPages.currentPage().getParameters().get('PalluDesDensity');
        List < String > prodPalluDesD = new List < String > ();
        if (prodPalluDesDensity != null && prodPalluDesDensity != '') {

            prodPalluDesD = prodPalluDesDensity.split(',');
            soqlWhere += ' AND (Pallu_Des_Density__c IN :prodPalluDesD)';
        }

        String prodPalluDesMaterial = apexPages.currentPage().getParameters().get('PalluDesMaterial');
        List < String > prodPalluDesMat = new List < String > ();
        if (prodPalluDesMaterial != null && prodPalluDesMaterial != '') {

            prodPalluDesMat = prodPalluDesMaterial.split(',');
            soqlWhere += ' AND (Pallu_Des_Material__c IN :prodPalluDesMat)';
        }

        String prodPalluPattern = apexPages.currentPage().getParameters().get('PalluPattern');
        List < String > prodPalluPat = new List < String > ();
        if (prodPalluPattern != null && prodPalluPattern != '') {

            prodPalluPat = prodPalluPattern.split(',');
            soqlWhere += ' AND (Pallu_Pattern__c IN :prodPalluPat)';
        }

        String prodPalluSize = apexPages.currentPage().getParameters().get('PalluSize');
        List < String > prodPalluSZ = new List < String > ();
        if (prodPalluSize != null && prodPalluSize != '') {

            prodPalluSZ = prodPalluSize.split(',');
            soqlWhere += ' AND (Pallu_Size__c IN :prodPalluSZ)';
        }

        String wareHouseStock = apexPages.currentPage().getParameters().get('WareHouse');
        List < Decimal > wareHouseList = new List < Decimal > ();
        if (wareHouseStock != null && wareHouseStock != '') {
            for (String str: wareHouseStock.split(',')) {
                wareHouseList.add(Decimal.valueOf(str));
            }
            soqlWhere += ' AND (Warehouse_Stock__c IN :wareHouseList)';
        }



        String storeStock = apexPages.currentPage().getParameters().get('Store');
        List < Decimal > storeStockList = new List < Decimal > ();
        if (storeStock != null && storeStock != '') {
            for (String str: storeStock.split(',')) {
                storeStockList.add(Decimal.valueOf(str));
            }

            soqlWhere += ' AND (Store_Stock__c IN :storeStockList)';
        }

        String soldStock = apexPages.currentPage().getParameters().get('Sold');
        List < Decimal > soldStockList = new List < Decimal > ();
        if (soldStock != null && soldStock != '') {
            for (String str: soldStock.split(',')) {
                soldStockList.add(Decimal.valueOf(str));
            }

            soqlWhere += ' AND (Sold_Stock__c IN :soldStockList)';
        }

        String costFilt = apexPages.currentPage().getParameters().get('CostPrice');
        List < String > costBandList = new List < String > ();
        if (costFilt != NULL && costFilt != '') {
            for (String str: costFilt.split(',')) {
                costBandList.add(str);
            }
            if (costBandList.size() > 0) {

                soqlWhere += ' AND (';
                for (Integer i = 0; i < costBandList.size(); i++) {
                    counter++;
                    val1 = Decimal.valueOf(costBandList[i].substring(0, costBandList[i].indexOf('-')));
                    System.debug('----val1---->>' + val1);
                    val2 = Decimal.valueOf(costBandList[i].substring(costBandList[i].indexOf('-') + 1));
                    System.debug('----val2---->>' + val2);
                    soqlWhere += ' (Cost__c >= ' + val1 + ' AND Cost__c <= ' + val2 + ')';

                    if (costBandList.size() > 1 && counter != costBandList.size()) {
                        soqlWhere += ' OR ';
                    }
                }

                soqlWhere += ')';
            }
        }
        //Adding mrp here..
        String mrpStore = apexPages.currentPage().getParameters().get('MRP');

        List < String > mrpRangeList = new List < String > ();
        if (mrpStore != NULL && mrpStore != '') {
            for (String str: mrpStore.split(',')) {
                mrpRangeList.add(str);
            }
        }
        System.debug('mrpRangeList!!!:::--->>>>  ' + mrpRangeList);

        if (mrpRangeList.size() > 0) {
            soqlWhere += ' AND (';
            for (Integer i = 0; i < mrpRangeList.size(); i++) {
                counter1++;
                val3 = Decimal.valueOf(mrpRangeList[i].substring(0, mrpRangeList[i].indexOf('-')));
                System.debug('----val3---->>' + val3);
                val4 = Decimal.valueOf(mrpRangeList[i].substring(mrpRangeList[i].indexOf('-') + 1));
                System.debug('----val4---->>' + val4);
                soqlWhere += ' (Suggested_MRP__c >= ' + val3 + ' AND Suggested_MRP__c <= ' + val4 + ')';
                if (mrpRangeList.size() > 1 && counter1 != mrpRangeList.size()) {
                    soqlWhere += ' OR ';
                }

            }
            soqlWhere += ')';

        }
        System.debug('------soqlWhere---->>' + soqlWhere);


        soql += soqlWhere + ' ORDER BY ID DESC LIMIT :defaultProdsSize';

        System.debug('====soql===>>' + soql);
        List < Product__c > prods1 = Database.Query(soql);
        System.debug('------prods1 size is------>>' + prods1.size());
        count = prods1.size();
        prods = (JSON.serialize(prods1)).escapeEcmaScript();
        system.debug('prods:' + prods1);
        

        Integer totProds = Database.countQuery('SELECT count() FROM Product__c WHERE RecordTypeId = :productRecordTypeId ' + soqlWhere);
        totalAPICalls = totProds / recordsLimit2;

        totalProducts = totProds;

        System.debug('----filterDataString----->>' + filterDataString);
    }


    public PageReference dosubmit() {
        PageReference pr = new PageReference('/apex/PaginationDemo?id=' + filterDataString);
        pr.setRedirect(true);
        return pr;
    }

    @RemoteAction
    public static Map < String, Object > getProductList(String lastProdId, String filterOptions) {

        List < String > tmp;
        Integer counter = 0, counter1 = 0;
        Decimal val1, val2, val3, val4;
        System.debug('filterOptions:' + filterOptions);
        Map < String, String > filterMaps = new Map < String, String > ();
        Map < String, Taneira_Cost_Band_Range__c > rangeMap = Taneira_Cost_Band_Range__c.getAll();
        for (String filterOps: filterOptions.split('###')) {
            tmp = filterOps.split(':::');
            //system.debug('tmp:'+tmp);
            if (tmp.size() > 1) {
                filterMaps.put(tmp[0], tmp[1]);
            }

        }

        lastProdId = filterMaps.get('lastProdId');
        system.debug('filterMaps::::' + filterMaps);

        List < String > filterOps = filterOptions.split('###');
        System.debug(':::List filterOps:::' + filterOps);
        Map < String, Object > response = new Map < String, Object > ();
        RestRequest req = RestContext.request;
        System.debug('--req------>>' + req);
        RestResponse res = RestContext.response;
        System.debug('---response map----->>' + response);
        System.debug('--res------>>' + res);
        String srch = '';

        System.debug('-------lastProdId---->>' + lastProdId);
        Integer recordsLimit;
        String productRecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        String soql = 'SELECT Id, Name, Vendor_Name__c, Product_Category_Taneira__c, SKU_Code__c,Proc_Type__c,Proc_Source__c,' +
            ' PO_Number__c,Cost__c,Quantity__c,Suggested_MRP__c,Cluster__c,Cost_Band__c,Story_1__c,Collection__c,' +
            ' Design_Description__c,Design_Story__c,Material_Wrap__c,Taneira_Material_Weft__c,Zari_Type__c,' +
            ' Base_Colour__c,Detailed_Colour__c,Workmanship__c,Loom__c,Occasion__c,Fold__c,Fabric__c,Story_2__c,' +
            ' Blouse_Dimensions__c,Blouse_Type__c,Blouse_Size__c,Body_Des_Element__c,Body_Des_Material__c,' +
            ' Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Border_Size__c,' +
            ' Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,Body_Des_Density__c, Photo_Backup__c ' +
            ' FROM Product__c' +
            ' WHERE RecordTypeId = :productRecordTypeId';
        recordsLimit = Integer.valueOf(Label.QUERY_LIMIT);

        Boolean orderByClause = false;
        String prodCategory = ''; //RestContext.request.params.get('ProductCategory');
        List < String > prodCategories = new List < String > ();
        if (filterMaps.get('ProductCategory') != null && filterMaps.get('ProductCategory') != '') {
            prodCategories = filterMaps.get('ProductCategory').split(',');
            soql += ' AND (Product_Category_Taneira__c IN :prodCategories)';
        }
        //added by Mayur

        List < String > prodVend = new List < String > ();
        if (filterMaps.get('Vendor') != null && filterMaps.get('Vendor') != '') {
            System.debug('----filtermap for vendor---' + filterMaps);
            prodVend = filterMaps.get('Vendor').split(',');
            system.debug('prodVend:' + prodVend);
            soql += ' AND (Account__c IN :prodVend)';
        }

        //String prodProc = '';//RestContext.request.params.get('Proc-Type');
        List < String > prodPro = new List < String > ();
        if (filterMaps.get('ProcType') != null && filterMaps.get('ProcType') != '') {

            prodPro = filterMaps.get('ProcType').split(',');
            soql += ' AND (Proc_Type__c IN :prodPro)';
        }

        //String prodOrigin = '';//RestContext.request.params.get('Origin');
        List < String > prodOri = new List < String > ();
        if (filterMaps.get('Origin') != null && filterMaps.get('Origin') != '') {

            prodOri = filterMaps.get('Origin').split(',');
            soql += ' AND (Cluster__c IN :prodOri)';
        }


        List < String > fabriclst = new List < String > ();
        if (filterMaps.get('Fabric') != null && filterMaps.get('Fabric') != '') {
            fabriclst = filterMaps.get('Fabric').split(',');
            soql += ' AND (Fabric__c IN :fabriclst )';
        }
        System.debug('=====fabriclst====:::' + fabriclst);

        //String prodLoom = '';//RestContext.request.params.get('Loom');
        List < String > prodLoo = new List < String > ();
        if (filterMaps.get('Loom') != null && filterMaps.get('Loom') != '') {

            prodLoo = filterMaps.get('Loom').split(',');
            soql += ' AND (Loom__c IN :prodLoo)';
        }

        //String productWeft ='';// RestContext.request.params.get('Weft');
        List < String > prodWeft = new List < String > ();
        if (filterMaps.get('Weft') != null && filterMaps.get('Weft') != '') {

            prodWeft = filterMaps.get('Weft').split(',');
            soql += ' AND (Taneira_Material_Weft__c IN :prodWeft )';
        }


        List < String > zariList = new List < String > ();
        if (filterMaps.get('ZariType') != null && filterMaps.get('ZariType') != '') {
            zariList = filterMaps.get('ZariType').split(',');
            soql += ' AND (Zari_Type__c IN :fabriclst )';
        }
        List < String > craftList = new List < String > ();
        if (filterMaps.get('Craft') != null && filterMaps.get('Craft') != '') {
            craftList = filterMaps.get('Craft').split(',');
            soql += ' AND (Workmanship__c IN :craftList )';
        }

        List < String > OccasionList = new List < String > ();
        if (filterMaps.get('Occasion') != null && filterMaps.get('Occasion') != '') { //Added by Mayur 20.11.2018 
            OccasionList = filterMaps.get('Occasion').split(',');
            soql += ' AND (Occasion__c IN :OccasionList )';
        }

        List < String > borderdeselemList = new List < String > ();
        if (filterMaps.get('BorderDesElement') != null && filterMaps.get('BorderDesElement') != '') {
            borderdeselemList = filterMaps.get('BorderDesElement').split(',');
            soql += ' AND (Border_Des_Element__c IN :borderdeselemList )';
        }

        List < String > borderPatternList = new List < String > ();
        if (filterMaps.get('BorderPattern') != null && filterMaps.get('BorderPattern') != '') {
            borderPatternList = filterMaps.get('BorderPattern').split(',');
            soql += ' AND (Border_Pattern__c IN :borderPatternList )';
        }

        List < String > bodyDesMatList = new List < String > ();
        if (filterMaps.get('BodyDesMaterial') != null && filterMaps.get('BodyDesMaterial') != '') {
            bodyDesMatList = filterMaps.get('BodyDesMaterial').split(',');
            soql += ' AND (Body_Des_Material__c IN :bodyDesMatList )';
        }

        List < String > bodyDesEleList = new List < String > ();
        if (filterMaps.get('BodyDesElement') != null && filterMaps.get('BodyDesElement') != '') {
            bodyDesEleList = filterMaps.get('BodyDesMaterial').split(',');
            soql += ' AND (Body_Des_Element__c IN :bodyDesEleList )';
        }
        List < String > bodyDesDensList = new List < String > ();
        if (filterMaps.get('BodyDesDensity') != null && filterMaps.get('BodyDesDensity') != '') {
            bodyDesDensList = filterMaps.get('BodyDesDensity').split(',');
            soql += ' AND (Body_Des_Density__c IN :bodyDesDensList )';
        }
        List < String > bodyDesPatternList = new List < String > ();
        if (filterMaps.get('BodyPattern') != null && filterMaps.get('BodyPattern') != '') {
            bodyDesPatternList = filterMaps.get('BodyPattern').split(',');
            soql += ' AND (Body_Des_Density__c IN :bodyDesPatternList )';
        }

        List < String > blouseDimList = new List < String > ();
        if (filterMaps.get('BlouseDimensions') != null && filterMaps.get('BlouseDimensions') != '') {
            blouseDimList = filterMaps.get('BlouseDimensions').split(',');
            soql += ' AND (Blouse_Dimensions__c IN :blouseDimList )';
        }

        List < String > borderDesMatList = new List < String > ();
        if (filterMaps.get('BorderDesMaterial') != null && filterMaps.get('BorderDesMaterial') != '') {
            borderDesMatList = filterMaps.get('BorderDesMaterial').split(',');
            soql += ' AND (Border_Des_Material__c IN :borderDesMatList )';
        }
        List < String > borderSizeList = new List < String > ();
        if (filterMaps.get('BorderSize') != null && filterMaps.get('BorderSize') != '') {
            borderSizeList = filterMaps.get('BorderSize').split(',');
            soql += ' AND (Border_Size__c IN :borderSizeList )';
        }
        List < String > palluDesDensityList = new List < String > ();
        if (filterMaps.get('PalluDesDensity') != null && filterMaps.get('PalluDesDensity') != '') {
            palluDesDensityList = filterMaps.get('PalluDesDensity').split(',');
            soql += ' AND (Pallu_Des_Density__c IN :palluDesDensityList )';
        }
        List < String > PalluDesMatList = new List < String > ();
        if (filterMaps.get('PalluDesMaterial') != null && filterMaps.get('PalluDesMaterial') != '') {
            PalluDesMatList = filterMaps.get('PalluDesMaterial').split(',');
            soql += ' AND (Pallu_Des_Material__c IN :PalluDesMatList )';
        }
        List < String > PalluPatternList = new List < String > ();
        if (filterMaps.get('PalluPattern') != null && filterMaps.get('PalluPattern') != '') {
            PalluPatternList = filterMaps.get('PalluPattern').split(',');
            soql += ' AND (Pallu_Pattern__c IN :PalluPatternList )';
        }
        List < String > PalluSizeList = new List < String > ();
        if (filterMaps.get('PalluSize') != null && filterMaps.get('PalluSize') != '') {
            PalluSizeList = filterMaps.get('PalluSize').split(',');
            soql += ' AND (Pallu_Size__c IN :PalluSizeList )';
        }
        List < Decimal > WareHouseList = new List < Decimal > ();
        if (filterMaps.get('WareHouse') != null && filterMaps.get('WareHouse') != '') {
            for (String str: filterMaps.get('WareHouse').split(',')) {
                wareHouseList.add(Decimal.valueOf(str));
            }
            soql += ' AND (Warehouse_Stock__c IN :WareHouseList )';
        }
        List < Decimal > StoreList = new List < Decimal > ();
        if (filterMaps.get('Store') != null && filterMaps.get('Store') != '') {
            for (String str: filterMaps.get('Store').split(',')) {
                StoreList.add(Decimal.valueOf(str));
            }
            soql += ' AND (Store_Stock__c IN :StoreList )';
        }
        List < Decimal > SoldList = new List < Decimal > ();
        if (filterMaps.get('Sold') != null && filterMaps.get('Sold') != '') {
            for (String str: filterMaps.get('Sold').split(',')) {
                SoldList.add(Decimal.valueOf(str));
            }
            soql += ' AND (Store_Stock__c IN :SoldList )';
        }

        List < String > costBandList = new List < String > ();
        if (filterMaps.get('CostPrice') != null && filterMaps.get('CostPrice') != '') {
            costBandList = filterMaps.get('CostPrice').split(',');
        }
        if (costBandList.size() > 0) {

            soql += ' AND (';
            for (Integer i = 0; i < costBandList.size(); i++) {
                counter++;
                val1 = Decimal.valueOf(costBandList[i].substring(0, costBandList[i].indexOf('-')));
                System.debug('----val1---->>' + val1);
                val2 = Decimal.valueOf(costBandList[i].substring(costBandList[i].indexOf('-') + 1));
                System.debug('----val2---->>' + val2);
                soql += ' (Cost__c >= ' + val1 + ' AND Cost__c <= ' + val2 + ')';

                if (costBandList.size() > 1 && counter != costBandList.size()) {
                    soql += ' OR ';
                }
            }

            soql += ')';
        }

        //Adding MRP Here.
        List < String > mrpRangeList = new List < String > ();
        List < String > rangeDataList = new List < String > ();
        String temp = '';
        if (filterMaps.get('MRP') != NULL && filterMaps.get('MRP') != '') {
            mrpRangeList = filterMaps.get('MRP').split(',');
        }
        if (mrpRangeList.size() > 0) {
            for (String str: mrpRangeList) {
                rangeDataList.add(str);
            }
        }
        if (rangeDataList.size() > 0) {
            soql += ' AND (';
            for (Integer i = 0; i < rangeDataList.size(); i++) {
                counter1++;
                val3 = Decimal.valueOf(rangeDataList[i].substring(0, rangeDataList[i].indexOf('-')));
                System.debug('----val3---->>' + val3);
                val4 = Decimal.valueOf(rangeDataList[i].substring(rangeDataList[i].indexOf('-') + 1));
                System.debug('----val4---->>' + val4);
                soql += ' (Suggested_MRP__c > ' + val3 + ' AND Suggested_MRP__c <= ' + val4 + ')';

                if (rangeDataList.size() > 1 && counter1 != rangeDataList.size()) {
                    soql += ' OR ';
                }
            }

            soql += ')';

        }
        System.debug('-----soql after mrpList---->>' + soql);

        //System.debug('=====fabriclst====:::'+fabriclst);
        System.debug('filterMaps::::' + filterMaps);

        if (srch != NULL && srch != '') {

            srch = '%' + srch + '%';
            //System.debug('-------srch---->>'+srch);
            soql += ' AND (Vendor_Name__c LIKE : srch OR Product_Category_Taneira__c LIKE : srch OR SKU_Code__c LIKE : srch)';

        }
        if (lastProdId != null && lastProdId != '') {

            recordsLimit = Integer.valueOf(Label.QUERY_LIMIT);
            System.debug('-----recordsLimit in if----->>' + recordsLimit);
            soql += ' AND Id < :lastProdId';
            soql += ' ORDER BY ID DESC LIMIT ' + recordsLimit;

        } else {

            soql += ' ORDER BY ID DESC LIMIT ' + recordsLimit;
        }

        system.debug('soql:' + soql);

        //JSONGenerator gen = JSON.createGenerator(true);
        List < Product__c > accct = Database.Query(soql);
        System.debug('-----accct----->>' + accct);
        response.put('SOQL', soql);
        response.put('lastProdId', lastProdId);
        if (accct.size() > 0) {

            response.put('STATUS', 'SUCCESS');
        } else {

            response.put('STATUS', 'ERROR');
        }
        response.put('PRODUCTS', accct);
        //response.put('PRODUCTSJSON', JSON.serialize(accct));
        System.debug('======check the response here======>>>' + response);
        if (accct != null && accct.size() > 0) {

            response.put('LAST_PROD_ID', accct[accct.size() - 1].Id);

        }
        System.debug('======response map======>>>' + response);
        //res.addHeader('Access-Control-Allow-Origin', Label.Pagination_URL);

        //res.responseBody = Blob.valueOf(JSON.serializePretty(response));

        return response;
    }


}