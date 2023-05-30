/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/27/2019   	T01		T01 - Test Class fix 
*/
@IsTest
public class UserPasswordApiTest {
    @isTest static void testDoGet() {
        
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser00011@amamama.com',//<T02> Added 1 in user name
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = r.Id
        );
        u.DOB__c = Date.newInstance(1960, 2, 17);
        u.EmployeeNumber = '123456789';
        insert u;
        system.debug('User info+++++++++++++++++++++++'+u);
        system.runAs(u){
            RestRequest request = new RestRequest();
            //<T01>
            request.requestUri ='/services/apexrest/ForgotPassword/puser000@amamama.com';
            
            
            //<T01>
            request.httpMethod = 'GET';
            request.addHeader('Content-Type', 'application/json');
            RestContext.request = request;
            UserPasswordApi.doGet();
        }
        
        
        UserRole r2 = new UserRole(DeveloperName = 'MyCustomRole2', Name = 'My Role2');
        insert r2;
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last2',
            Email = 'pulsar@acme.com',
            Username = 'pulsar@acme.com',
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = r2.Id
        );
        //u2.DOB__c = Date.newInstance(1960, 2, 17);
        // u2.EmployeeNumber = '';
        insert u2;
        system.debug('User info+++++++++++++++++++++++'+u);
        Test.startTest();
        RestRequest request2 = new RestRequest();
        //<T01>
        request2.requestUri ='/services/apexrest/ForgotPassword/puser000@amamama.com';
            
            //<T01>
        request2.httpMethod = 'GET';
        request2.addHeader('Content-Type', 'application/json');
        RestContext.request = request2;
        try{
            UserPasswordApi.doGet();
        }catch(exception exp){
            
        }
        
        Test.stopTest();
        
    }
    @isTest static void testDoGet1() {
        
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser0002@amamama.com',//<T02> Added 2 in user name
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = r.Id
        );
        u.DOB__c = Date.newInstance(1960, 2, 17);
        u.EmployeeNumber = '123456789';
        
        insert u;
        system.debug('User info+++++++++++++++++++++++'+u);
        system.runAs(u){
            test.startTest();
            RestRequest request = new RestRequest();
            //<T01>
            request.requestUri ='/services/apexrest/ForgotPassword/puser000@12amamama.com';
              
            //<T01>
            request.httpMethod = 'GET';
            request.addHeader('Content-Type', 'application/json');
            RestContext.request = request;
            UserPasswordApi.doGet();
        }
        
        Test.stopTest();
        
    }
    
}