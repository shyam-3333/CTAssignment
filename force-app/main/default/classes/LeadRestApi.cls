/*
Created by :@Mohammamd Rafi
Description :This rest class used for created lead from titen website.
Created Date : 30/12/2020
Method name : doPost()

*/
@RestResource(urlMapping='/lead')
global with sharing class LeadRestApi {
    @HttpPost
    global static String doPost(){
        try{
            /* Get body from from titan website once click on submit button*/
            List<Lead> listOfLead = new List<Lead>();
            List<Channel_Partner_Registration__c> CPR = new List<Channel_Partner_Registration__c>();
            String body = RestContext.request.requestBody.toString();
            LeadWrapper returnwrap = new LeadWrapper();
            returnwrap =(LeadWrapper)JSON.deserialize(body, LeadWrapper.class);
            CPR = [SELECT Id, Store_Code__c  FROM Channel_Partner_Registration__c Where Store_Code__c=:returnwrap.storeCode];
            if(returnwrap != null){
                Id devRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();                
                
                
                
                if(returnwrap.LastName !=null && returnwrap.LastName !='' && returnwrap.companyname !=null && returnwrap.companyname !='' 
                   &&  returnwrap.emailAddress !=null  && returnwrap.emailAddress !='' && returnwrap.phonNo !=null &&  returnwrap.phonNo !='' 
                   && returnwrap.message !=null &&  returnwrap.message !='' && returnwrap.LeadSource !=null &&  returnwrap.LeadSource !='')
                {
                    listOfLead = [SELECT Id, LeadSource FROM Lead Where Email=:returnwrap.emailAddress limit 50000];//Email=:returnwrap.emailAddress
                    
                    if(returnwrap.LeadSource !=null && returnwrap.LeadSource != 'Franchisee lead Form' && listOfLead.size() == 0 ||
                      returnwrap.LeadSource !=null && returnwrap.LeadSource == 'Franchisee lead Form' && CPR.size()>=0){
                        if(returnwrap.LeadSource !=null && returnwrap.LeadSource == 'Franchisee lead Form' && CPR.size()> 0 ||
                          returnwrap.LeadSource !=null && returnwrap.LeadSource != 'Franchisee lead Form' && CPR.size()==0){
                            Lead leadObj = new Lead();
                            leadObj.FirstName = returnwrap.firstName;
                            leadObj.LastName = returnwrap.lastName;
                            leadObj.Title = returnwrap.title;
                            leadObj.Company = returnwrap.companyname;
                            leadObj.Email = returnwrap.emailAddress;
                            leadObj.Phone = returnwrap.phonNo;
                            leadObj.Message__c = returnwrap.message;
                            leadObj.Function__c = returnwrap.function;
                            leadObj.City = returnwrap.City;
                            leadObj.State = returnwrap.State;
                            leadObj.Designation__c = returnwrap.Designation;
                            leadObj.Employee_Designation__c = returnwrap.EmployeeDesignation;
                            leadObj.Employee_Code__c = returnwrap.EmployeeCode;
                            leadObj.Employee_Email_ID__c = returnwrap.EmployeeEmail;
                            leadObj.Lead_Location__c = returnwrap.Leadlocation;
                            if(returnwrap.location_latitude!=null && returnwrap.location_latitude!=''&&returnwrap.location_longitude!=null && returnwrap.location_longitude!=''){
                                leadObj.Geo_location__latitude__s = Decimal.valueOf(returnwrap.location_latitude);
                                leadObj.Geo_location__longitude__s =  Decimal.valueOf(returnwrap.location_longitude);
                            }
                            leadObj.Status  = 'Open - Cold';
                            System.debug('Lead Source is'+returnwrap.LeadSource);
                            leadObj.LeadSource  = returnwrap.LeadSource;
                            leadObj.Store_Code__c  = returnwrap.storeCode;   //new
                              if( CPR != null &&  CPR.size()>0)
                              {
                                 leadObj.Channel_Partner_Registration__c = CPR[0].id; 
                              }
                            leadObj.Franchisee_Name__c  = returnwrap.franchiseeName;
                            leadObj.Franchisee_Phone__c  = returnwrap.franchiseePhone;
                            leadObj.Franchisee_Email__c  = returnwrap.franchiseeEmail;
                            leadObj.Employee_Phone__c  = returnwrap.employeePhone;
                            leadObj.Employee_Name__c  = returnwrap.employeeName;
                            leadObj.Retail_Channel__c  = returnwrap.retailChannel; //new
                            leadObj.Store_Manager_Name__c = returnwrap.storeManagerName;//new
                            leadObj.Store_Manager_Number__c = returnwrap.storeManagerNumber;//new
                            leadObj.Quantity__c = returnwrap.quantity;//new
                            leadObj.Details_of_customized_product__c = returnwrap.detailsOfProduct;//new
                            leadObj.RecordTypeId = devRecordTypeId;
                            insert leadObj;
                            Attachment att1 = new Attachment();
                            att1.Name='JSONweb.Test1';
                            att1.parentId=leadObj.Id;
                            att1.Body=RestContext.request.requestBody;
                            att1.ContentType='.txt';
                            insert att1;
                            return 'Success';
                        }else {
                            return 'This Store code is not yet registered, Please register first via the Sambandh Registration form.';
                        }
                    } else{
                        return 'Email already exists';
                    }  
                } else{
                    return 'Required field is missing';
                } 
                
            }
            
            else {
                return 'Required information is missing';
            }
            
        }catch(Exception ex){
            System.debug('Message ouccure'+ex.getMessage());
            System.debug('Message line number'+ex.getLineNumber());
            return 'Fail';
        }
    }    
    
    public class LeadWrapper {
        public String firstName; 
        public String lastName;
        public String title;
        public String companyname;
        public String emailAddress;
        public String message;
        public String phonNo;
        public String function;
        public String City;
        public String State;
        public string LeadSource;
        public String location_latitude;
        public String location_longitude;
        public String storeCode;//new
        public String franchiseeName;
        public String franchiseePhone;
        public String franchiseeEmail;
        public String retailChannel;
        public String employeeName;
        public String employeePhone;//new
        public String storeManagerName;//new
        public String storeManagerNumber;//new
        public String quantity;//new
        public String detailsOfProduct;//new
        public String Designation;//new
        public String EmployeeDesignation;//new
        public String EmployeeCode;//new
        public String EmployeeEmail;//new
        public string Leadlocation;
        public string Channelpartner;
        
        
        
    }
    
    
}
/*
{
"firstName": "Johan",
"lastName": "smith",
"title" : "Salesforce Developer",
"companyname": "kvp",
"emailAddress": "johan.smith@kvpcorp.com",
"message": "This test message",
"phonNo": "8589748901",
"function":"fn",
"City":"city name",
"State":"state name",
"LeadSource":"Facebook",
"location_latitude":13.02439,
"location_longitude":13.02439,
"storeCode":"TKOR",
"franchiseeName":"Test Franchisee",
"franchiseePhone":"11314235346",
"franchiseeEmail":"abc@gmail.com",
"retailChannel":"Test Retail Channel",
"employeeName":"Test Employee",
"employeePhone":"8589123456",
"storeManagerName":"Test Store Manager",
"storeManagerNumber":"9098908566",
"quantity":"3",
"detailsOfProduct":"Details of purpose of purchase",
"Designation": "CEO",
"EmployeeDesignation":"BA".
"EmployeeCode":"AS1234",
"EmployeeEmail": "Soumya.t@kvpcorp.com"
}
*/