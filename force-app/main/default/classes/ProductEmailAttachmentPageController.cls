/************************************************************************************************************************************************
Created By : Poornapriya YN
Description : ProductEmailAttachmentPageController will attach Excel sheet to ProductApprovalEmailForSapTeam which has the data that has been approved TODAY
*************************************************************************************************************************************************/

public class ProductEmailAttachmentPageController{
    public List<Product__c> productList {get;set;}
     public ProductEmailAttachmentPageController(ApexPages.StandardController Controller){
          Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
         productList = [Select Id,name,Photo__c,Design_Story__c ,Product_Category_Taneira__c,Nature__c ,Occasion__c ,Workmanship__c ,Loom__c,Route__c,Suggested_MRP__c,
                         colour__c,Zari_Type__c,Cluster__c,vendor_custom__c,vendor_custom__r.name,Vendor_Name__c,Cost__c,Quantity__c,Comments__c,Taneira_Material_Weft__c,
                         Saree_Dimensions__c,SKU_Code__c,Blouse_Dimensions__c,Material_Wrap__c,Product_Type__c,Article_Number__c,Design_Type__c From Product__c Where RecordTypeId =: recordTypeId AND Approval_Date__c = Yesterday ORDER BY Product_Type__c];   
     }
}