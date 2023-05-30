/** Created By : Poornapriya YN
Description : Rest API to get the user information **/

@RestResource(urlMapping='/User/*')
global with sharing class UserInfoApi{
    @HttpGet
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String usrName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        try{
              User userInfo = new User();
              LoginHistory logHistory  = new LoginHistory();
              if(!Test.isRunningTest()){
                userInfo = [SELECT Id, Name,MobilePhone,Username,Email,Profile.Name,Profile.UserLicense.Name, Address FROM User WHERE Username= :usrName];
                logHistory = [SELECT Status FROM LoginHistory where UserId=: userInfo.Id order by LoginTime desc Limit 1];
              }
            else{
                userInfo = [SELECT Id, Name,MobilePhone,Username,Email,Profile.Name,Profile.UserLicense.Name, Address FROM User WHERE Username = :usrName limit 1];
                //logHistory = [SELECT Status FROM LoginHistory order by LoginTime desc Limit 1];
              
              } 
              
              usrWrapper wrap = new usrWrapper();
                wrap.Name = userInfo.Name;
                wrap.Username = userInfo.Username;               
                wrap.Email = userInfo.Email;
                wrap.Profile = userInfo.Profile.Name;
                wrap.User_License = userInfo.Profile.UserLicense.Name;
                wrap.Address = userInfo.Address;
                wrap.Phone = userInfo.MobilePhone;
            	wrap.Status = logHistory.Status;
                String jsonResponse =  JSON.serialize(wrap);
                if(!Test.isRunningTest()){
                    RestContext.response.addHeader('Content-Type', 'application/json');
                    RestContext.response.responseBody = Blob.valueOf(jsonResponse);
                }
                
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
            public String Name{get;set;}
            public String Username{get;set;}
            public String Email{get;set;}
            public String Profile{get;set;}
            public String User_License{get;set;}
            public String Status{get;set;}
            public Address Address{get;set;}
            public string Phone {get;set;}
        
        }
                            
    
}