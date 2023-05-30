public class RTWclassificationdata {
 public list<RTW_Product__c> dataList{get;set;}
    public RTWclassificationdata(){
        dataList = new list<RTW_Product__c>();
    }
    public void loadDataExcel(){ 
        datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        system.debug('startDateTime==>'+startDateTime+'endDateTime==>'+endDateTime);
        datalist = [select Vendor_custom__c,Product__c,RTW_Pricing_Submitted_Date__c,SKU__c,PO_Number__c,Base_Colour__c,Collection__c,Craft__c,Description__c,MFabric__c,Form__c,MRP_Pc__c,Buyers_Cost__c,Quantity__c,Season__c,Gender__c,Okhai_Size__c,Size__c,STYLE__c,Style_Code__c,Year_of_Design__c,Remarks__c,MPleats__c,
                    MPly__c,MDesign__c,MCost__c,Order_ID__c,Fabric_1__c,Fabric_1_Quantity__c,Fabric_2__c,Fabric_2_Quantity__c,MASK_DESCRIPTION__c,Top_Fabric__c,Consumtion__c,Bottom_Fabric__c,Source__c,Yardage_SKU_Code__c,Yardage_Consumption__c,Yardage_Cost__c,Total_Costs__c,Loom__c,RTW_SIZE__c,
                    Ecom_Size__c,E_Com_Material__c,Zari__c,Pricing_date__c from RTW_Product__c where RTW_Pricing_Submitted_Date__c > :startDateTime and RTW_Pricing_Submitted_Date__c < :endDateTime];
        system.debug('datalist==>'+datalist);
        
    }
}