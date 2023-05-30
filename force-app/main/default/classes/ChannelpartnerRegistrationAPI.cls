/*
Created by :@Sujay
Description :This rest class used for created ChannelPartnerRegistration from titen website.
Created Date : 14/06/2022
Method name : doPost()

*/
@RestResource(urlMapping='/ChannelpartnerRegistrationAPI/*')
global with sharing class ChannelpartnerRegistrationAPI {
     public class ChannelPartner {
        public String Name; 
        public String City;
        public String Email;
        public String FranchiseeName;
        public String FranchiseePhoneNo;
        public String Message;
        public String RetailChannel;
        public String State;
        public String StoreCode;
    }
@HTTPPost
    global static string doPost(){
        try{
            
            //Get body from from titan website once click on submit button
            List<Channel_Partner_Registration__c> listOfCpr= new List<Channel_Partner_Registration__c>();
            String body = RestContext.request.requestBody.toString();
            ChannelPartner cpr = new ChannelPartner();
            cpr =(ChannelPartner)JSON.deserialize(body, ChannelPartner.class);
                if(cpr.StoreCode !=null && cpr.StoreCode !=''){
                    
                    listOfCpr = [SELECT Id, Store_Code__c  FROM Channel_Partner_Registration__c Where Store_Code__c=:cpr.StoreCode limit 50000];
                           if(listOfCpr.size() == 0){
                           Channel_Partner_Registration__c CprObj = new Channel_Partner_Registration__c();
                           //CprObj.Name = cpr.Name;
                           CprObj.City__c = cpr.City;
                           CprObj.Franchisee_Email_ID__c = cpr.Email;
                           CprObj.Franchisee_Name__c = cpr.FranchiseeName;
                           CprObj.Franchisee_Phone_No__c = cpr.FranchiseePhoneNo;
                           CprObj.Message__c = cpr.Message;
                           CprObj.Retail_Channel__c = cpr.RetailChannel;
                           CprObj.State__c = cpr.State;
                           CprObj.Store_Code__c = cpr.StoreCode;
                           
                           insert CprObj;
                           return ' Channel Partner Registration is Successfully Created.';
                   
                }
            
            else{
                           return 'This Store code is already registered with us. Please submit your referral using the Sambandh page.';
                }
            
                }
            
            else{
                           return 'Store Code is missing';
                }
        }
        catch(Exception ex){
            System.debug('Message ouccure'+ex.getMessage());
            System.debug('Message line number'+ex.getLineNumber());
            return 'Fail';
        }
    }
}