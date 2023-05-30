public class TaneiraProdClsAnglr{
    public static List<Taneira_View__c> tnraViewList {get;set;}
    public String mimeType {get;set;}
    public static Integer totalAPICalls{get;set;}
    public static Integer totalProducts{get;set;}
    public List<Taneira_View__c> constLoadList {get;set;} 
    public String lastProdId {get;set;}
    public static Integer defaultProdSize {get;set;}
    public static String lastId {get;set;}
    public static String prods {get;set;}
    public String filterDataString {get;set;}
    public TaneiraProdClsAnglr(){
        Integer recordsLimit2 = Integer.valueOf(Label.ProductViewQueryLimit);
        defaultProdSize= Integer.valueOf(Label.ProductViewQueryLimit);
        String sql = 'SELECT ID,Name,Custom_Created_Date__c,Account_Id__c,PO_status__c,SL_Number__c,Vendor_Acc_Name__c,vendor_custom__c,vendor_custom__r.name,View_Name__c,Offline_UserName__c,Origin__c,Product_Category__c,'+
                                      'Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c FROM Taneira_View__c';
        String srch = apexPages.currentPage().getParameters().get('srch');
        if(srch != null && srch != '') {
            srch = '%'+srch+'%';
            System.debug('-------srch---->>'+srch);
            sql += ' WHERE (Vendor_Acc_Name__c LIKE :srch OR Product_Category__c LIKE :srch OR Origin__c LIKE :srch )';  
        }
        sql +=' ORDER BY Custom_Created_Date__c Desc LIMIT : defaultProdSize';
        System.debug('constrc sql::::'+sql);
        constLoadList =DataBase.query(sql);
        prods=JSON.serialize(constLoadList);
        Integer totalData=[Select count() from Taneira_view__c];
        totalProducts=totalData;
        totalAPICalls=totalData/recordsLimit2;
        lastId = ApexPages.currentPage().getParameters().get('lastProdId');
        System.debug(':::lastId::');
        
    }
    
    @RemoteAction
    public static Map<String,Object> allData(String lastProdId,String filterOptions){
        System.debug(':::lastProdId:::'+lastProdId);
        Map<String, Object> response = new Map<String, Object>();
        Integer recordsLimit =Integer.valueOf(Label.ProductViewQueryLimit);
         String srch ='';
        
        String sql = 'SELECT ID,Name,Vendor_custom__r.Name,SL_Number__c,PO_status__c,Custom_Created_Date__c,Account_Id__c,Vendor_Acc_Name__c,View_Name__c,Offline_UserName__c,Origin__c,Product_Category__c,'+
            'Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c FROM Taneira_View__c WHERE Id != null';
        
          if(filterOptions != null && filterOptions != '') {
            
            filterOptions = '%'+filterOptions+'%';
            System.debug('-------srch---->>'+filterOptions);
            sql += ' AND (Vendor_Acc_Name__c LIKE :filterOptions OR Product_Category__c LIKE :filterOptions OR Origin__c LIKE :filterOptions )';
            
        }
        
        
        if(lastProdId != null && lastProdId != '') {
            DateTime val = DateTime.valueOf(lastProdId);
            sql += ' AND Custom_Created_Date__c < : val ';
        }
            sql += ' Order By Custom_Created_Date__c Desc LIMIT :recordsLimit'; 
        tnraViewList = DataBase.query(sql);
        System.debug('Calling the remote action::::');
        //response.put('SOQL', soql);
        //response.put('lastProdId', lastProdId);
        system.debug('sql:'+sql);
        if(tnraViewList.size() > 0) {
            response.put('STATUS', 'SUCCESS');
        }
        else {
            
            response.put('STATUS', 'ERROR');
        }
        response.put('PRODUCTS', tnraViewList);
        if(tnraViewList != null && tnraViewList.size() > 0) {
            
            response.put('LAST_PROD_ID', String.valueOf(tnraViewList[tnraViewList.size()-1].Custom_Created_Date__c));
            System.debug(':::response ::: '+response.get('LAST_PROD_ID'));
            
        }
        return response;
        
    }
    
    public PageReference dosubmit(){ 
            PageReference pr = new PageReference('/apex/TaneiraProdAnglrVF?id='+filterDataString );
            pr.setRedirect(true); return pr;
        }
    
    
    public pagereference Download() {
        PageReference exdownload = null;
        mimeType = 'application/vnd.ms-excel#'+'TaneiraProdAnglrVF.xls';
        exdownload = Page.TaneiraProdAnglrVF;
        exdownload.setRedirect(false);
        return exdownload;
    }
    
}