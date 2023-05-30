public class ExciseAlertCategoryClass {
    public list<product__c> dataList{get;set;}
    public ExciseAlertCategoryClass(){
        dataList = new list<product__c>();
    }
    public void loadDataExcel(){
        datetime startDateTime;
       // string reorder = Apexpages.currentPage().getParameters().get('Reorder'); 
       // Boolean isReorder = (reorder == 'True') ? true : false ;
       // system.debug(reorder+ '-' +isReorder);
       // datetime startDateTime = datetime.now().addHours(-24);
       
        IF(DateTime.now().hour() == 8){
         startDateTime = datetime.now().addHours(-16);
        }
        else if(DateTime.now().hour() == 16){
         startDateTime = datetime.now().addHours(-8);
        }
        datetime endDateTime = datetime.now();
        system.debug('startDateTime==>'+startDateTime+'endDateTime==>'+endDateTime);
        datalist = [select Actual_MRP__c,SKU_Code__c,Suggested_MRP__c,pricing_date__c,Product_Key_Finder__c from product__c where  pricing_date__c > :startDateTime and pricing_date__c < :endDateTime];// RE_ORDER__c=:isReorder limit 100 ]; 
        system.debug('datalist==>'+datalist);
        
    }
    
}