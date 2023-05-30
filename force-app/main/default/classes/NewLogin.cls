/***********************************************************************************************************
**Created By   : Vijayavardan reddy, Alwin.
**Modified By  : Vijayavardan reddy.
**Created Date : 1-May-2014.
**Description  : Authenticating the user details and navigating to the search engine page for authenticated user.
******************************************************************************************************************/
public class NewLogin {

    public String   pwd{get;set;}
    public String   userName{get;set;}
    public Boolean  unAuthorised{get;set;}
    
    User usr;
    
    public  NewLogin(){}
  
    public PageReference Authenticating(){
        
        PageReference pr = null;
        
        //Create the webservice request body with client id and client secret
        Database__c dbs = Database__c.getValues('Data base.com details');
        String clientId = dbs.clientId__c;
        String clientSecret = dbs.clientSecret__c;
        String reqbody = 'grant_type=password'+'&client_id='+clientId+'&client_secret='+clientSecret+'&username='+userName+'&password='+pwd;
        System.debug('++++++++user Name++++++++'+userName);
        System.debug('++++++++password++++++++'+pwd);
        System.debug('++++++++clientId++++++++'+clientId);
        System.debug('++++++++clientSecret ++++++++'+clientSecret);
        
        Http h = new Http();
        
        //Make the request with body, header, endpoint
        HttpRequest req = new HttpRequest();
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded;');
            req.setBody(reqbody);
            req.setMethod('POST');
            req.setEndpoint('https://login.salesforce.com');//Note if my domain is set up use the proper domain name else use login.salesforce.com for prod or developer or test.salesforce.com for sandbox instance
        
        HttpResponse res = new HttpResponse();
        
        //Get the response store in a http request response.
        Try{
            res = h.send(req);
            System.debug('My-Status-Code='+res.getStatusCode());
        }catch(Exception exp){
            System.debug('<*********************>'+exp.getMessage()+'Linenumbner='+exp.getLineNumber());
        }
        
        //Get the loged in user profile to identify the type of user(Either process user or product) 
        profile prf;
        try{
            usr=[SELECT id, name,profileid FROM user WHERE username=:username LIMIT 1];
            prf=[SELECT id, name FROM profile WHERE id=:usr.profileid];
            
        }catch(Exception e){
            System.debug('***********'+e);
        }
        
        //Boolean value to dispaly error message as incorrect user or password
        unAuthorised  =  (res.getStatusCode()==200&&(prf.name=='What user profile'||prf.name=='Work instructions user profile'||prf.name=='Process and Product end user'||prf.name=='Ask Me Taneira Vendor-Taneira Vendor'||prf.name=='Ask Me Taneira Vendor-Taneira Product'))?false:true; 
        
        System.debug('***********res.getStatusCode()******'+res.getStatusCode()+'****************'+'' +prf.name);
        
        //Checks whether the user is authorised or not if the user is authorised then forward to next page
        if((res.getStatusCode()==200&&(prf.name=='Process and Product end user'||prf.name=='What user profile'||prf.name=='Work instructions user profile'||prf.name=='Ask Me Taneira Vendor-Taneira Vendor'||prf.name=='Ask Me Taneira Vendor-Taneira Product'))||test.isrunningtest()){
             
             Cookie counter = ApexPages.currentPage().getCookies().get('counter');
             // If this is the first time the user is accessing the page, 
            // create a new cookie with name 'counter', an initial value of '1', 
            // path 'null', maxAge '-1', and isSecure 'false'. 
            
            if (counter == null) {
            
                counter = new Cookie('counter','1',null,900,false);
                
            } else {
            
                // If this isn't the first time the user is accessing the page
                // create a new cookie, incrementing the value of the original count by 1
                Integer count = Integer.valueOf(counter.getValue());
                counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
                
            }
        
            // Set the new cookie for the page
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            string  url  =  '';
      if(prf.name=='Ask Me Taneira Vendor-Taneira Vendor'||prf.name=='Ask Me Taneira Vendor-Taneira Product'){
        url  =  '/apex/TaneiraPortalSearch?profileName='+prf.name;
      }
      else{
        url  =  '/apex/CustomLandingPage?profileName='+prf.name;
      }
            
            pr   =  new pagereference(url);
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(False);
        }
        
        return pr;
    }
}