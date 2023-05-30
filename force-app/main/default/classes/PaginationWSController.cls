@RestResource(urlMapping='/ProductDetails/*')
global class PaginationWSController {
           
    @ReadOnly
    @HttpGet
    webservice static void sendProductsAsGet(){
                
        Map<String, Object> response = new Map<String, Object>();
        RestRequest req = RestContext.request;
        System.debug('--req------>>'+req);
        RestResponse res = RestContext.response;
        System.debug('---response map----->>'+response);
        System.debug('--res------>>'+res);
        //String body = Req.requestBody.toString().trim();
        //System.debug('---body--->>'+body);
        //Map<String, Object> bodyJSON = (Map<String, Object>)JSON.deserializeUntyped(body);
        //System.debug('----bodyJSON---->>'+bodyJSON);
        //String lastProdId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        String lastProdId = RestContext.request.params.get('lastProdId');
        String srch = RestContext.request.params.get('srch');
        
        
        System.debug('-------lastProdId---->>'+lastProdId);
        //Integer recordsLimit = (bodyJSON != null && bodyJSON.get('limit') != null) ? Integer.valueOf(bodyJSON.get('limit')) : 1000;
        //system.debug('bodyJSON::'+recordsLimit);
        Integer recordsLimit;
        String productRecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        String soql = 'SELECT Id, Name, Vendor_Name__c, Product_Category_Taneira__c, SKU_Code__c,Proc_Type__c,Proc_Source__c,'+
                        ' PO_Number__c,Cost__c,Quantity__c,Suggested_MRP__c,Cluster__c,Story_1__c,Collection__c,'+
                        ' Design_Description__c,Design_Story__c,Material_Wrap__c,Taneira_Material_Weft__c,Zari_Type__c,'+
                        ' Base_Colour__c,Detailed_Colour__c,Workmanship__c,Loom__c,Occasion__c,Fold__c,Fabric__c,Story_2__c,'+
                        ' Blouse_Dimensions__c,Blouse_Type__c,Blouse_Size__c,Body_Des_Element__c,Body_Des_Material__c,'+
                        ' Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Counter_Test__c,Border_Pattern__c,Border_Size__c,'+
                        ' Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,Body_Des_Density__c, Photo_Backup__c '+
                        ' FROM Product__c '+
                        ' WHERE RecordTypeId = :productRecordTypeId';
        recordsLimit = Integer.valueOf(Label.QUERY_LIMIT);
        
        Boolean orderByClause = false;
        String prodCategory = RestContext.request.params.get('ProductCategory');
        List<String> prodCategories = new List<String>();
        if(prodCategory != null && prodCategory != '') {
            
            prodCategories = prodCategory.split(',');
            soql += ' AND (Product_Category_Taneira__c IN :prodCategories)';
        }
       //added by Mayur
       
       String prodVendor = RestContext.request.params.get('vendor');
        List<String> prodVend = new List<String>();
        if(prodVendor != null && prodVendor != '') {
            
            prodVend = prodVendor.split(',');
            soql += ' AND (Vendor_Name__c IN :prodVend)';
        }
       
        String prodProc = RestContext.request.params.get('Proc-Type');
        List<String> prodPro = new List<String>();
        if(prodProc != null && prodProc != '') {
            
            prodPro = prodProc.split(',');
            soql += ' AND (Proc_Type__c IN :prodPro)';
        }
        
        String prodOrigin = RestContext.request.params.get('Origin');
        List<String> prodOri = new List<String>();
        if(prodOrigin != null && prodOrigin != '') {
            
            prodOri = prodOrigin.split(',');
            soql += ' AND (Cluster__c IN :prodOri)';
        }
       
       String prodLoom = RestContext.request.params.get('Loom');
        List<String> prodLoo = new List<String>();
        if(prodLoom != null && prodLoom != '') {
            
            prodLoo = prodLoom.split(',');
            soql += ' AND (Loom__c IN :prodLoo)';
        }
       
       String productWeft = RestContext.request.params.get('Weft');
        List<String> prodWeft = new List<String>();
        if(productWeft != null && productWeft != '') {
            
            prodWeft = productWeft.split(',');
            soql += ' AND (Taneira_Material_Weft__c IN :prodWeft )';
        }
       /*
       String prodColor = RestContext.request.params.get('Color');
        List<String> prodClr = new List<String>();
        if(prodColor != null && prodColor != '') {
            
            prodClr = prodColor.split(',');
            soql += ' AND (Colour__c IN :prodClr)';
        }
        
        String prodCollection = RestContext.request.params.get('Collection');
        List<String> prodCollec = new List<String>();
        if(prodCollection != null && prodCollection != '') {
            
            prodCollec = prodCollection.split(',');
            soql += ' AND (Collection__c IN :prodCollec)';
        }
        */
        
        if(srch != null && srch != '') {
            
            srch = '%'+srch+'%';
            System.debug('-------srch---->>'+srch);
            soql += ' AND (Vendor_Name__c LIKE :srch OR Product_Category_Taneira__c LIKE :srch OR SKU_Code__c LIKE :srch)';
            
        }
        if(lastProdId != null && lastProdId != '') {
            
            recordsLimit = Integer.valueOf(Label.QUERY_LIMIT);
            System.debug('-----recordsLimit in if----->>'+recordsLimit);
            soql +=' AND Id < :lastProdId';
            soql +=' ORDER BY ID DESC LIMIT '+recordsLimit;
            
        } else {
            
            soql +=' ORDER BY ID DESC LIMIT '+recordsLimit;
        }
        
        system.debug('soql:'+soql);
        
        JSONGenerator gen = JSON.createGenerator(true);
        List<Product__c> accct = Database.Query(soql);
        System.debug('-----accct----->>'+accct);
        response.put('SOQL', soql);
        response.put('lastProdId', lastProdId);
        if(accct.size() > 0) {
            
            response.put('STATUS', 'SUCCESS');
        } else {
            
            response.put('STATUS', 'ERROR');
        }
        response.put('PRODUCTS', accct);
        //response.put('PRODUCTSJSON', JSON.serialize(accct));
        System.debug('======check the response here======>>>'+response);
        if(accct != null && accct.size() > 0) {
            
            response.put('LAST_PROD_ID', accct[accct.size()-1].Id);
            
        }
        System.debug('======response map======>>>'+response);
        res.addHeader('Access-Control-Allow-Origin', Label.Pagination_URL);

        res.responseBody = Blob.valueOf(JSON.serializePretty(response));
    }
    
    @ReadOnly
    @HttpPost
    webservice static void sendProducts(){
                
        Map<String, Object> response = new Map<String, Object>();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        System.debug('---response map----->>'+response);
        String body = Req.requestBody.toString().trim();
        System.debug('---body--->>'+body);
        Map<String, Object> bodyJSON = (Map<String, Object>)JSON.deserializeUntyped(body);
        System.debug('----bodyJSON---->>'+bodyJSON);
        Integer recordsLimit = (bodyJSON != null && bodyJSON.get('limit') != null) ? Integer.valueOf(bodyJSON.get('limit')) : 100;
        system.debug('bodyJSON::'+recordsLimit);
        String lastProdId;
        String productRecordTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        String soql = 'SELECT Id, Name, Vendor_Name__c, Product_Category_Taneira__c, SKU_Code__c,Proc_Type__c,Proc_Source__c,'+
                        ' PO_Number__c,Cost__c,Quantity__c,Suggested_MRP__c,Cluster__c,Story_1__c,Collection__c,'+
                        ' Design_Description__c,Design_Story__c,Material_Wrap__c,Taneira_Material_Weft__c,Zari_Type__c,'+
                        ' Base_Colour__c,Detailed_Colour__c,Workmanship__c,Loom__c,Occasion__c,Fold__c,Fabric__c,Story_2__c,'+
                        ' Blouse_Dimensions__c,Blouse_Type__c,Blouse_Size__c,Body_Des_Element__c,Body_Des_Material__c,'+
                        ' Body_Pattern__c,Border_Des_Element__c,Border_Des_Material__c,Border_Pattern__c,Counter_Test__c,Border_Size__c,'+
                        ' Pallu_Des_Density__c,Pallu_Des_Material__c,Pallu_Pattern__c,Pallu_Size__c,Body_Des_Density__c,Photo_Backup__c'+
                        ' FROM Product__c '+
                        ' WHERE RecordTypeId = :productRecordTypeId ';
        
        if(bodyJSON != null && bodyJSON.get('lastProdId') != null) {
            
            //recordsLimit = Integer.valueOf(Label.QUERY_LIMIT);
            lastProdId = String.valueOf(bodyJSON.get('lastProdId'));
            soql +=' AND Id < :lastProdId';
        }
        
        if(bodyJSON != null && bodyJSON.get('Vendor_Name__c') != null) {
            String vendorName = String.valueOf(bodyJSON.get('Vendor_Name__c'));
            soql +=' AND Vendor_Name__c = :vendorName ' ;
        }
        
        if(bodyJSON != null && bodyJSON.get('Product_Category_Taneira__c') != null) {
            String prodCategory = String.valueOf(bodyJSON.get('Product_Category_Taneira__c'));
            soql +=' AND Product_Category_Taneira__c = :prodCategory ' ;
        }
        
        soql +=' ORDER BY Id DESC LIMIT '+recordsLimit;
        system.debug('soql:'+soql);
        
        JSONGenerator gen = JSON.createGenerator(true);
        List<Product__c> accct = Database.Query(soql);
        
        if(accct.size() > 0) {
            
            response.put('STATUS', 'SUCCESS');
        } else {
            
            response.put('STATUS', 'ERROR');
        }
        response.put('PRODUCTS', accct);
        response.put('PRODUCTSCOUNT', accct.size());
        System.debug('======responsefor acc======>>>'+response);
        //response.put('PRODUCTJSON',Blob.valueOf(JSON.serializePretty(response)));
        
        if(accct != null && accct.size() > 0) {
            
            response.put('LAST_PROD_ID', accct[accct.size()-1].Id);
            
        }System.debug('======response map======>>>'+response);
        /*
        if(bodyJSON != null && bodyJSON.get('limit') != null) {
            
            Integer recordsLimit2 = Integer.valueOf(Label.QUERY_LIMIT);
            Integer totProds = Database.countQuery('SELECT count() FROM Product__c WHERE RecordTypeId = :productRecordTypeId');
            //system.debug('totProds:'+totProds);
            response.put('TOTAL_PRODUCTS', (totProds/recordsLimit2));
        }
        */
        res.addHeader('Access-Control-Allow-Origin', Label.Pagination_URL);

        res.responseBody = Blob.valueOf(JSON.serializePretty(response));
    }
}