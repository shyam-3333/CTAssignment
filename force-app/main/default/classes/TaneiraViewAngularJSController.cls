public class TaneiraViewAngularJSController{
    public static List<Taneira_View__c> tnraViewList {get;set;}
    public String mimeType {get;set;}
    public integer call {get;set;}
    public static Integer totalAPICalls{get;set;}
    public static Integer totalProducts{get;set;}
    public List<Taneira_View__c> constLoadList {get;set;} 
    public String lastProdId {get;set;}
    public List<wrapperOnPosition> wrList{set;get;}
    public static Integer defaultProdSize {get;set;}
    public static String lastId {get;set;}
    public static String prods {get;set;}
    public String filterDataString {get;set;}
    //public string postatus{get;set;}
    public String profileName{get;set;}
    public boolean disp{get;set;}
    public boolean attribution{get;set;}
    public boolean category{get;set;}
    public string categoryUrl{get;set;}
    public String userId{get;set;}
    public boolean adminUser{get;set;}
    public TaneiraViewAngularJSController(){
        Integer recordsLimit2 = Integer.valueOf(Label.ProductViewQueryLimit);
        defaultProdSize= Integer.valueOf(Label.ProductViewQueryLimit);
        String sql = 'SELECT ID,Name,Vendor_custom__r.Name,SL_Number__c,Vendor_custom__c,Attribution_Lead_pending_days__c,Category_lead_pending_days__c,Custom_Created_Date__c,Account_Id__c,Vendor_Acc_Name__c,View_Name__c,Offline_UserName__c,Origin__c,Product_Category__c,'+
                                      'Product_Key_Finder1__c,PO_status__c,Proc_Type__c,SKU__c,Total_Quantity__c,Total_Value__c,Attribution_completed_date__c,Category_User__c,Page_Control__c,CreatedDate,Pending_Days__c,Assign_Back_date__c,APPD__c,Assign_Back_date2__c,Attribution_Pending_days__c,Category_completed_date__c,Category_pending_days__c,CPPD__c,ABD__c,ABD2__c FROM Taneira_View__c';
            
        String srch = apexPages.currentPage().getParameters().get('srch');
        profileName=[Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name;
        system.debug('Profile name : '+profileName);
        attribution = false;
        category = false;
        disp = false;
        userId = [SELECT Id FROM User WHERE Id =: UserInfo.getUserId()].Id;
        adminUser = FALSE;
        if(userId == '00530000003Nll9AAC'){
            adminUser = TRUE;
            disp = true;
        }
        if(profileName == 'Category'){
            disp = true;
            category = true;
            categoryUrl = '<a href="/apex/TaneiraProdCategory?Vendor=';
        } else if(profileName == 'Attribution' || profileName == 'Purchase') {
            attribution = true;
            categoryUrl = '<a href="/apex/TaneiraProdAttributionVF?Vendor=';
        }
        if(profileName == 'Attribution' || profileName == 'Category' ||  profileName == 'Purchase'){
            if(profileName != 'Purchase'){
                if(profileName == 'Category'){
                    string tempId = '%'+userId+'%';
                    sql += ' WHERE Page_Control__c =: profileName ANd Category_User__c like :tempId';
                }
                else{
                    sql += ' WHERE Page_Control__c =: profileName';
                }
                
            }else{
                sql += ' WHERE Page_Control__c = \'Attribution\'';
            }
          	
        } else {
            sql += ' WHERE Page_Control__c !=: profileName ';
        }
        
        if(srch != null && srch != '') {
            srch = '%'+srch+'%';
            System.debug('-------srch---->>'+srch);
            sql += ' AND (Vendor_Acc_Name__c LIKE :srch OR Product_Category__c LIKE :srch OR Origin__c LIKE :srch )';  
        }
        If(profileName == 'Attribution' || profileName == 'Purchase' ){

            sql +=' ORDER BY createdDate Desc LIMIT : defaultProdSize';
        }
        else if(profileName == 'Category'){
            sql +=' ORDER BY Attribution_completed_date__c Desc LIMIT : defaultProdSize';
        }
        else{
        sql +=' ORDER BY Page_Control__c Desc LIMIT : defaultProdSize';
        }
        System.debug('constrc sql::::'+sql);
        constLoadList =DataBase.query(sql);
        for(Taneira_view__c tv : constLoadList){
            if(tv.Category_user__c != null){
                tv.Category_user__c = tv.Category_user__c.substringAfter(',');
            }
           /* if(tv.Page_Control__c == 'Attribution'){
                date d = date.newInstance(tv.CreatedDate.year(), tv.CreatedDate.month(), tv.CreatedDate.day());
                tv.Attribution_completed_date__c = d;
            }*/
            if(tv.Page_Control__c == 'Category'){
                tv.Page_Control__c = 'pricing';
            }
            //To avoid pop up error message
            if(tv.Page_Control__c == 'Attribution'){
                tv.Category_User__c = null;
                tv.Attribution_completed_date__c = null;
            }
        }        
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
        
        String sql = 'SELECT ID,Name,Vendor_custom__r.Name,SL_Number__c,Vendor_custom__c,Attribution_Lead_pending_days__c,Category_lead_pending_days__c,Custom_Created_Date__c,PO_status__c,Account_Id__c,Vendor_Acc_Name__c,View_Name__c,Offline_UserName__c,Origin__c,Product_Category__c,'+
            'Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c,Proc_Type__c,Attribution_completed_date__c,Category_User__c FROM Taneira_View__c WHERE Id != null';
        
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
            PageReference pr = new PageReference('/apex/TaneiraViewAngularJSPage?id='+filterDataString );
            pr.setRedirect(true); return pr;
        }
    
    
    public pagereference Download() {
        PageReference exdownload = null;
        mimeType = 'application/vnd.ms-excel#'+'TaneiraViewAngularJSPage.xls';
        exdownload = Page.TaneiraViewAngularJSPage;
        exdownload.setRedirect(false);
        return exdownload;
    }
   
public class wrapperOnPosition {
            public String SLNO{set;get;}
             public wrapperOnPosition(String s){
                 this.SLNO=s;
             }
             }    
}