/**********************************************************************************************************************************************
**Created By   : Vijayavardan reddy.
**Modified By  : Vijayavardan reddy.
**Created Date : 7-5-2014.
**Description  : Displays the search and Advance seach buttons for product users and only search button for process users along with search box 
                 doing search with either model or variant.
***********************************************************************************************************************************************/ 

public with sharing class CustomLanding {

    //Variable declaration
    Public  String               seachKeyWord{get;set;}
    public  String               brands{get;set;}
    public  String               profileName{get;set;}
    public  boolean              advanceSearchDisplay{get;set;}
    public  List<SelectOption>   genderPicklistValues{get;set;}
    public  List<String>         genderSelectedValues{get;set;}
    public  Set<String>          gendeSelectedValues{get;set;}        
    
    transient public String[] jsonDescriptionData;
    
    //Constructor declaration
    public  CustomLanding(){
    
        seachKeyWord         =  null;
        profileName          =  apexpages.currentPage().getParameters().get('profileName');
        genderPicklistValues =  new List<SelectOption>();
        genderSelectedValues =  new List<String>();
        advanceSearchDisplay = (profileName =='Work instructions user profile')?false:true;
        
    }//End of constructor
    
    //On load action method declaration for session management
    public pagereference  sessionManagement(){
        
      PageReference pr =null;  
      Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '900', and isSecure 'false'. 
        
        
        if (counter == null) {
                pr = new PageReference('/apex/NewLogin');
                pr.setredirect(true);
        } else {
        
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
        }
        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        //for loop to collect the pick list values of gender in a list to display in popup
        for(Schema.PicklistEntry spr:Schema.getGlobalDescribe().get('Product__c').getDescribe().fields.getMap().get('gender__c').getDescribe().getPicklistValues()){
            
            genderPicklistValues .add(new SelectOption(spr.getValue(),spr.getlabel()));
        }//End of for
        
        return pr;
    }//End of method
    
    //Method declaration for autocomplete values
    public List<string> getjsonDescriptionData(){
        jsonDescriptionData = new List<string>();
            //List of variants
            //List<product__c> productList=[SELECT id,name FROM product__c LIMIT 50000];
            List<variant__c> variantlist=[SELECT Id,Name, Model__c,model__r.name from Variant__c LIMIT 50000];
            
            //Set to get all variants as string
            Set<String> pncodeSet=new Set<String>();
             String quoteStr='"';
            //Iterate to collect set of all nico pin
            for(variant__c cpnCod : variantlist){
                if(!cpnCod.name.contains(quoteStr)){
                    pncodeSet.add(cpnCod.Name);
                }//End of if
                pncodeSet.add(cpnCod.model__r.name);
            }//End of for loop
            //Iterate to collect all pin in string format
            for(String str:pncodeSet){
                jsonDescriptionData.add('"'+str+'"');
            }
            //To sort the nicopin list
           jsonDescriptionData.sort();
            return jsonDescriptionData;
    }//End of method
        
    //Method for navigating to refined search page for product user or final result page for process user with search key  values
    public pageReference searchTitan(){
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr = new PageReference('/apex/NewLogin');
                pr.setredirect(true);
                pr.setCookies(new Cookie[]{counter});
                return pr;
                
        } else {
        
            // If this isn't the first time the user is accessing the page
            // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
        
        }
        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        String genderString  =  '';
        string url           =  '';
        
        //Iterate the for loop to make a string with the gender values. 
        for(String str:genderSelectedValues){
            genderString  = genderString+str+';';
        }//End of for loop.
        
        //Condition to check the logged in profile to navigate for a particular page
        if(profileName=='What user profile' || profileName=='Process and Product end user'){
        
            url='/apex/RefinedSearchpage?searchkey='+seachKeyWord+'&brands='+brands+'&gender='+genderString+'&profileName='+profileName;
            
        }else if(profileName=='Work instructions user profile'){
        
            Variant__c vrnt=new variant__c();
            
            try{
            
                vrnt=[SELECT id,name,model__c FROM Variant__c WHERE name=:seachKeyWord limit 1];
                
            }catch(Exception e){
            
                System.debug('<******>'+e);
                
            }
            url = '/apex/FinalResult?id='+vrnt.model__c+'&varinatname='+seachKeyWord+'&profileName='+profileName;
        }
        
        
        //Navigate to next page either refined saearch page or fianl page
        PageReference pr = new PageReference(url);
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(true);
        return pr;
       
    }//End of Method
    
    //Method to logout by expiring the cookie
    public pagereference logout(){
    
       Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
         
         counter = new Cookie('counter','1',null,0,false);
         
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
       //Navigating to login page with expired Cookie
       PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
    }//End of Logout method
    
}//End of class