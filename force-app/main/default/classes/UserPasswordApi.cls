/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/13/2019   T01    Modified Hardcoded URL To Relative URL
*/
@RestResource(urlMapping='/ForgotPassword/*')
global with sharing class UserPasswordApi{
    @HttpGet
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String usrName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        try{
            
            User userInfo = [SELECT Id, Name,DOB__c,EmployeeNumber FROM User WHERE Username= :usrName];
            usrWrapper wrap = new usrWrapper();
            wrap.DOB = string.valueOf(userInfo.DOB__c);
            wrap.EmployeeNumber = userInfo.EmployeeNumber;
            String jsonResponse =  JSON.serialize(wrap);
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(jsonResponse);
            
        }
        Catch(Exception exp){
            System.debug('current message is='+exp.getMessage());
            
            Map<String,String> recList = new Map<String,String>();
            recList.put('Error','Failure');
            recList.put('Status','400');
            String expMsg = json.serialize(recList);
            if(!Test.isRunningTest()){//<T01>
                RestContext.response.addHeader('Content-Type', 'application/json');
                RestContext.response.responseBody = Blob.valueOf(expMsg);
            }//<T01>
        }
    }
    public class usrWrapper{
        
        public String DOB{get;set;}
        public String EmployeeNumber{get;set;}
        
    }
}