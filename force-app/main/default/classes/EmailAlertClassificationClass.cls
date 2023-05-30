/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-23-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   03-23-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class EmailAlertClassificationClass {

    public list<product__c> dataList{get;set;}
    public EmailAlertClassificationClass(){
        dataList = new list<product__c>();
    }
    public void loadDataExcel(){ 
        datetime startDateTime;
        IF(DateTime.now().hour() == 8){
         startDateTime = datetime.now().addHours(-16);
        }
        else if(DateTime.now().hour() == 16){
         startDateTime = datetime.now().addHours(-8);
        }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
        //datetime startDateTime = datetime.now().addHours(-24);
        datetime endDateTime = datetime.now();
        system.debug('startDateTime==>'+startDateTime+'endDateTime==>'+endDateTime);
        datalist = [select vendor_custom__r.Vendor_code__c,Id,Story_1__c,Story_2__c,Design_Description__c,name,Design_Story__c ,Fold__c,Offline_Username__c,Product_Category_Taneira__c,Occasion__c ,Workmanship__c ,Loom__c,Detailed_Colour__c,Fabric__c ,Collection__c,Pallu_Size__c,Warehouse_Stock__c,Sold_Stock__c,Store_Stock__c,
                     Colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Cost__c,Quantity__c,Base_Colour__c ,Taneira_Material_Weft__c,Pallu_Design__c,Blouse_Dimensions__c,
                     Saree_Dimensions__c,SKU_Code__c,Material_Wrap__c,CreatedDate,Body_Des_Density__c,Body_Des_Element__c,Body_Des_Material__c,Body_Pattern__c,Border_Des_Element__c,FabricR__c,CraftR__c,
                     Border_Des_Material__c,Border_Pattern__c,Blouse_Size__c,Blouse_Type__c,Border_Size__c,PO_Number__c,Handloommark__c,Pallu_Des_Density__c,Comments__c,Pallu_Des_Material__c,Pallu_Pattern__c,Proc_Type__c,Order_Id__c from product__c where pricing_date__c >= :startDateTime and pricing_date__c < :endDateTime];
        system.debug('datalist==>'+datalist);
        
    }
}