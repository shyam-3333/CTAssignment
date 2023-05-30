/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/13/2019   T01    Modified Hardcoded URL To Relative URL
*/
@IsTest
private class AccountViewApiTest {

    @isTest static void testAccountViewDoGet() {
        
       // Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
		vendor__c acc = new vendor__c();
		acc.Name= 'test Account';
		acc.Phone_No__c = '2648394';
		//acc.recordTypeId = recordTypeId;
		insert acc;
		
        
        RestRequest request = new RestRequest();
        //<T01>
        request.requestUri ='/services/apexrest/Account/';
           
        //<T01>
        request.httpMethod = 'GET';
        request.addHeader('Content-Type', 'application/json');
        RestContext.request = request;
        AccountViewApi.doGet();
        
    }
	
	@isTest static void testAccountViewDoPost() {
        
        //Id recordTypeId = [Select Id from RecordType where Name=:'Vendor' and SObjectType = 'Account' limit 1].Id;
		vendor__c acc = new vendor__c();
		acc.Name= 'test Account';
		acc.Phone_No__c = '2648394';
		//acc.recordTypeId = recordTypeId;
		insert acc;
		
		AccountViewApi.accWrapper newObj = new AccountViewApi.accWrapper();
     
     
        newObj.Vendor_Name = 'Brown Saree';
        newObj.Vendor_Id = acc.Id; 
        newObj.Vendor_Code  = 'test';
        newObj.Category = 'Society';  
        newObj.Type = 'Other';   
        newObj.Title = 'Saree'; 
        newObj.Name1 = 'Handloom'; 
        newObj.Name2 = 'Cotton';   
        newObj.Mobile_Phone = '2345678904';   
        newObj.Country = 'INDIA'; 
        newObj.Postal_Code = '243564'; 
        newObj.Mail_Id = 'test@test.com'; 
        newObj.Phone_No = '3452673890';
        
		
		 String JsonMsg=JSON.serialize(newObj);
		JsonMsg = '[' +JsonMsg+ ']';

    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        //<T01>
        request.requestUri = '/services/apexrest/Account/';
           
        //<T01>
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        
        request.requestBody = Blob.valueof(JsonMsg);
        
        RestContext.request = request;
        RestContext.response= res;
        
        Test.startTest();
      
        AccountViewApi.doPost();
        Test.StopTest();   
     
    }
}