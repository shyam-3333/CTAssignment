public class RTWpriceupdate {
    public list<RTW_Product__c> dataList{get;set;}
    public RTWpriceupdate(){
        dataList = new list<RTW_Product__c>();
    }
    public void loadDataExcel(){
         datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        system.debug('startDateTime==>'+startDateTime+'endDateTime==>'+endDateTime);
        datalist = [select Pricing_date__c,SKU__c,MRP_Pc__c,Assigned_To__r.name,Actual_MRP__c,RTW_Pricing_Submitted_Date__c from RTW_Product__c where  RTW_Pricing_Submitted_Date__c > :startDateTime and RTW_Pricing_Submitted_Date__c < :endDateTime];
        system.debug('datalist==>'+datalist);
        
    }
}