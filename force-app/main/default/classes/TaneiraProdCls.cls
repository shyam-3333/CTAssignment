public class TaneiraProdCls{
    public List<Taneira_View__c> tnraViewList {get;set;}
    public String mimeType {get;set;}
    public Id accId{get;set;}
    public string origin{get;set;}
    public string createdDate{get;set;}
    public String productKey {get;set;}
    public String category{get;set;}
     
    public TaneiraProdCls(){
               
             System.debug('========== Heap Size1 :: ' + Limits.getHeapSize());
        //system.debug('----------prodList----------'+prodList.size());
        viewProducts();
       
           
    }
    
    
    public PageReference openProductView(){
        System.debug('-----accId-->>'+accId);
        System.debug('-----origin-->>'+origin);
        System.debug('-----createdDate-->>'+createdDate);
        System.debug('-----productKey-->>'+productKey);
        System.debug('-----category-->>'+category);
        
        //system.debug('**CreatedDate**'+String.ValueOf(CreatedDate).substring(0,13));
        PageReference page = new PageReference('/apex/TestingOfflineProdView?Account='+accId + '&Category='+category+'&Origin='+origin+'&CDate='+CreatedDate.trim()+'&ProductKeyFinder='+productKey.trim());
       // System.debug('====Trim date====='+CreatedDate.trim());
        return page;
    }
    
    /*** 
    Logic to display products with same created date, vendor, category, origin as one line item
    ****/
    public List<Taneira_View__c> viewProducts(){
        tnraViewList = new List<Taneira_View__c>();  
          tnraViewList = [SELECT ID,Name,Vendor__r.Name,Custom_Created_Date__c,Account_Id__c,Vendor_Acc_Name__c,Offline_UserName__c,Origin__c,Product_Category__c,
                          Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c FROM Taneira_View__c Order By Custom_Created_Date__c Desc LIMIT 10000];
                          System.debug('===tnraViewList---->>'+tnraViewList );
                          System.debug('===tnraViewList---->>'+tnraViewList.size() );
        return tnraViewList;
    }
    
       
     public pagereference Download() {
        PageReference exdownload = null;
        mimeType = 'application/vnd.ms-excel#'+'TnraTestView.xls';
        exdownload = Page.TnraTestView;
        exdownload.setRedirect(false);
        return exdownload;
    }
      
}