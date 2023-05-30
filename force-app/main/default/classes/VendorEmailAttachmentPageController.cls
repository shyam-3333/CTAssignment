/************************************************************************************************************************************************
Created By : Poornapriya YN
Description : VendorEmailAttachmentPageController will attach Excel sheet to ProductApprovalEmailForSapTeam which has the data that has been approved TODAY
*************************************************************************************************************************************************/

public class VendorEmailAttachmentPageController{
    public List<vendor__c>accList {get;set;}
    public VendorEmailAttachmentPageController(){
        //Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
        accList = [SELECT Id, Name, Vendor_Code__c,Type__c,Approval_Date__c,Category__c,Approval_Status__c,Title__c,Name_1__c,Name_2__c,Mobile_Phone__c,Country__c,Postal_code__c,
                PAN_Number__c,TIN_CST_Number__c,Payment_Terms__c,Payment_Methods__c,CurrencyIsoCode,Incoterms__c,Name__c,IFSC__c,Account_Number__c,Mail_ID__c, OwnerId,Owner.Name,
                Phone_No__c FROM vendor__c WHERE Approval_Date__c= YESTERDAY];
    }
}