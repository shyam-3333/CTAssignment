public with sharing class documentDisplay {

    public String attchmentId{get;set;}
    public string ContType{get;set;}
    public String imagebody{get;set;}
    
    public documentDisplay(){
        
    }
        
    public pagereference  sessionManagement(){
      
      Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
            PageReference pr = new PageReference('/apex/NewLogin');
            //pr.setCookies(new Cookie[]{counter});
            pr.setredirect(false);
            return pr;
            
        } else {
        
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
            
        }
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        attchmentId=apexpages.currentPage().getParameters().get('id');
       
            return null;
    }
      
        
        
}