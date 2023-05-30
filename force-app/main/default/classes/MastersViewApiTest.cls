/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/13/2019   T01    Modified Hardcoded URL To Relative URL
*/
@IsTest
private class MastersViewApiTest {

    @isTest static void testDoGet() {
        Master__c mas = new Master__c();
        mas.Name= 'Red';
        mas.Name__c ='Color';
        mas.Active__c  = True ;
        mas.Code__c ='R';
		insert mas;
		
        RestRequest request = new RestRequest();
        //<T01>
        request.requestUri ='/services/apexrest/Masters';
          
        //<T01>
        request.httpMethod = 'GET';
        request.addHeader('Content-Type', 'application/json');
        RestContext.request = request;
        MastersViewApi.doGet();
        
    }
}