/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/13/2019   T01    Modified Hardcoded URL To Relative URL
Saradha(Lister)  11/27/2019   T02    Test Class fix 
*/
@IsTest
private class UserDetailsApiTest {

    @isTest static void testDoGet() {
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000111@amamama.com',//<T02>
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            isActive = true,
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = r.Id
        );
        u.DOB__c = Date.newInstance(1960, 2, 17);
        u.EmployeeNumber = '123456789';
        insert u;
    
        RestRequest request = new RestRequest();
        //<T01>
        request.requestUri ='/services/apexrest/UserDetails';
          
        //<T01>
        request.httpMethod = 'GET';
        request.addHeader('Content-Type', 'application/json');
        RestContext.request = request;
        UserDetailsApi.doGet();
        
    }
    @isTest static void testDoGet1() {
        
        RestRequest request = new RestRequest();
        //<T01>
        request.requestUri ='/services/apexrest/UserDetails';
           
        //<T01>
        request.httpMethod = 'GET';
        request.addHeader('Content-Type', 'application/json');
        RestContext.request = request;
        UserDetailsApi.doGet();
        
    }
}