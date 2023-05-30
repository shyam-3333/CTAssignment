@RestResource(urlMapping='/UserDetails')
global with sharing class UserDetailsApi{
    @HttpGet
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String usrName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        try{
            List<usrWrapper> usrWrapperList = new List<usrWrapper>();
            List<User> userInfoList = [SELECT Id, Name,DOB__c,EmployeeNumber,Email,Username,MobilePhone FROM User WHERE isActive= true];
            system.debug('**userInfoList**'+userInfoList);
            for(User userInfo : userInfoList){
              usrWrapper wrap = new usrWrapper();
              wrap.DOB = string.valueOf(userInfo.DOB__c);
              wrap.EmployeeNumber = userInfo.EmployeeNumber;
              wrap.Username = userInfo.Username;
              wrap.Name = userInfo.Name;
              wrap.Mobile_Phone = userInfo.MobilePhone;
              wrap.Email = userInfo.Email;
              usrWrapperList.add(wrap);
            }
              String jsonResponse =  JSON.serialize(usrWrapperList);
              
              RestContext.response.addHeader('Content-Type', 'application/json');
              RestContext.response.responseBody = Blob.valueOf(jsonResponse);
              
              
          }
          Catch(Exception exp){
            System.debug('current message is='+exp.getMessage());
            
            Map<String,String> recList = new Map<String,String>();
            recList.put('Error','Failure');
            recList.put('Status','400');
            String expMsg = json.serialize(recList);
            if(!test.isRunningTest()){
                RestContext.response.addHeader('Content-Type', 'application/json');
                RestContext.response.responseBody = Blob.valueOf(expMsg);
            }
        }
    }
     public class usrWrapper{
        public string Name {get;set;}
        public string Username {get;set;}
        public string Mobile_Phone {get;set;}
        public String DOB{get;set;}
        public String EmployeeNumber{get;set;}
        public string Email {get;set;}
       
    }
}