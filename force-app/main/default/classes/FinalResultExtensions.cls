/****************************************************************************************************************************
**Created By   : Vijayavardan Reddy.
**Modified By  : Vijayavardan reddy.
**Created Date : 12-May-2014.
**Description  : Retrieves the variant data from database and  prepares the JSON strings to dislay the values in the front end.
*******************************************************************************************************************************/

public with sharing class FinalResultExtensions {

    //Variable declaration
    String varinatname;
    String modelid;
    String idval;
    public String currentProfileName{get;set;}
    public Static String VariantsJSON{get;set;}
    public Boolean noRecordDisplay{get;set;}
    List<Product_file__c>   productfilesList;
    Public List<Variant__c> lstVariants{get;set;}
    public List<WrapperVariants> lstWrapperVariants;
    public List<WorkInstructions> lstWorkInstructions;
    
    //Constructor declaration       
    public FinalResultExtensions() {
        productfilesList      =  new List<Product_file__c>();
    }//End of constructor
    
    //Onload action method for session management and collects the varaint details
    public pagereference sessionManagement(){
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr = new PageReference('/apex/NewLogin');
            pr.setredirect(true);
            return pr;
            
        } else {
        
            // If this isn't the first time the user is accessing the page
            // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(counter.getValue());
            counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
            
        }
        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        currentProfileName    =  apexpages.currentPage().getParameters().get('profileName');
        idVal                 =  ApexPages.currentPage().getParameters().get('id');
        varinatname           =  ApexPages.currentPage().getParameters().get('varinatname');
        lstVariants=new List<Variant__c>();
        
        // Condition to check whether the parameter from the url is not null and both parameters are equla if it is  not null and both parameters are equal  then collects the list of variants with respect to the model id
        if(idVal!='null'  &&  idVal!= null &&  idVal!='' &&  idVal == varinatname){ 
            try{
            
                lstVariants = [SELECT Alt__c,Calibre__c,Calib_Type__c,Case_Color__c,Case_Mat__c,Cluster__c,Construction__c,
                               CreatedById,CreatedDate,CurrencyIsoCode,Dial_Color__c,Dial_Number__c,Function__c,Id,Model__r.name,Model__r.brand__c,model__r.gender__c,
                               Movement__c,Name,OwnerId,PMR_REM__c,Price__c,Range__c,Revision_Date__c,Revision__c,SRC__c,Strap__c,
                               SystemModstamp,Type__c,Version__c,WRT__c,spec__c,Model__c FROM Variant__c WHERE Model__c =: idVal] ;
                               
               
               }catch(Exception excp){
                   System.debug('<*******************>'+excp);
               }                
           
        }//End of if
        
        //Condition to ccheck whether the variant name is not null
        else if(varinatname!=null&&varinatname!=''){
            try{
            
                lstVariants = [SELECT Alt__c,Calibre__c,Calib_Type__c,Case_Color__c,Case_Mat__c,Cluster__c,Construction__c,model__c,
                               CreatedById,CreatedDate,CurrencyIsoCode,Dial_Color__c,Dial_Number__c,Function__c,Id,Model__r.name,Model__r.brand__c,model__r.gender__c,
                               Movement__c,Name,OwnerId,PMR_REM__c,Price__c,Range__c,Revision_Date__c,Revision__c,SRC__c,Strap__c,
                               SystemModstamp,Type__c,Version__c,WRT__c,spec__c FROM Variant__c WHERE Name =: varinatname or model__r.name =: varinatname]; 
                           
            }catch(exception excp){
                System.debug('<*******************>'+excp);
            }          
           
        }//End of else if
        
        //Condition to check whether the variant list isnot empty if it is not then collects all the child product files 
        if(!lstVariants.isempty()){
            modelid=lstVariants[0].model__c;
            productfilesList =  [select id,Variant__c, File_Type__c,(select name,id,ContentType from attachments ORDER BY CreatedDate DESC LIMIT 1) from Product_file__c where Variant__c in:lstVariants ];
        }//End of if   
             
        //Condition to check whther the logged in user profile is either what user or system administrator if the condition is satisfied then prepare the wrapper class list to display variant details     
        if(currentProfileName=='What user profile' || currentProfileName=='Process and Product end user'){
        
            lstWrapperVariants   =   new List<WrapperVariants>();
            
            //Iterate the loop to collect the variant details in a wrapper class list
            for(Variant__c eachVar : lstVariants ){
                
                WrapperVariants objWrapperVariants = new WrapperVariants();
                
                //Iterate the loop to collect the attachment id  in wrapper class variable which has parent product file type as image
                for(Product_file__c pfl:productfilesList){
                    
                    //Condition to check whether the the parent of the product file and variant to be equal and also checks whether the current product file has atleat one attachment.
                    if(pfl.Variant__c==eachVar.id && pfl.attachments.size()>0 ){
                    
                        //Condition to check the product file type
                        if(pfl.File_Type__c=='Image'){
                        
                           objWrapperVariants.imageId     =   pfl.attachments[0].id;
                              
                        }//End of if
                        
                    }//End of if
                }//End of for
                
                objWrapperVariants.productId        = modelid;
                objWrapperVariants.brand            = eachVar.model__r.brand__c;
                objWrapperVariants.model            = eachVar.model__r.name;
                objWrapperVariants.variant          = eachVar.Name;
                objWrapperVariants.gender           = eachVar.model__r.gender__c;
                objWrapperVariants.cluster          = eachVar.Cluster__c;
                objWrapperVariants.range            = eachVar.range__c;
                objWrapperVariants.DialNum          = eachVar.Dial_Number__c;
                objWrapperVariants.CaseMat          = eachVar.Case_Mat__c;
                objWrapperVariants.movement         = eachVar.Movement__c;
                objWrapperVariants.function         = eachVar.Function__c;
                objWrapperVariants.strap            = eachVar.strap__c;
                objWrapperVariants.spec             = eachVar.spec__c;
                objWrapperVariants.Rev              = eachVar.Revision__c;
                objWrapperVariants.AltRemarks       = eachVar.Alt__c; 
                objWrapperVariants.variantId        = eachVar.id;
                    
                lstWrapperVariants.add(objWrapperVariants);
            
            }//End of for
            
            VariantsJSON = Json.serializePretty(lstWrapperVariants);
            noRecordDisplay =  (lstWrapperVariants.isempty())?true:false;
            
                
        }//End Of If
        
        //Condition to check whether the current profile is work  instructions user profile
        else  if(currentProfileName=='Work instructions user profile' ){
        
                lstWorkInstructions  =   New List<WorkInstructions>();  
                
                //Iterate the loop to coolect the variant details in a wrapper class list
                for(Variant__c eachVar : lstVariants ){
                
                    WorkInstructions  objWorkInstructions   =  new WorkInstructions();
                    
                    //Iterate to loop to collect the attachments with respect to the parent variants 
                    for(Product_file__c pfl:productfilesList){
                        
                        //Condition to check whether the current variant id and the current product file parent variant id are equal and the product file has atleast one attachment
                        if(pfl.Variant__c==eachVar.id && pfl.attachments.size()>0 ){
                            if(pfl.File_Type__c=='WI'){
                            
                                objWorkInstructions.workins        =  pfl.attachments[0].id;
                                objWorkInstructions.titleWI        =  pfl.attachments[0].name;  
                                
                            }else  if(pfl.File_Type__c=='DD'){
                            
                                objWorkInstructions.doAndDonots    =  pfl.attachments[0].id;
                                objWorkInstructions.titleDD        =  pfl.attachments[0].name;  
                                
                            }else  if(pfl.File_Type__c=='PI'){
                            
                                objWorkInstructions.packInfo       =  pfl.attachments[0].id;
                                objWorkInstructions.titlePI        =  pfl.attachments[0].name;  
                                
                            }else if(pfl.File_Type__c=='TS'){
                            
                                objWorkInstructions.troubleShooting  =  pfl.attachments[0].id;
                                objWorkInstructions.titleTS          =  pfl.attachments[0].name;  
                            }else if(pfl.File_Type__c=='IBD'){ 
                            
                                objWorkInstructions.IBDSpares        =  pfl.attachments[0].id;
                                objWorkInstructions.titleIbd         =  pfl.attachments[0].name;
                            }
                            
                        }//End of if
                    }//End of for
                    
                    objWorkInstructions.brand           =  eachVar.model__r.brand__c;
                    objWorkInstructions.model           =  eachVar.model__r.name;
                    objWorkInstructions.variant         =  eachVar.Name;
                    objWorkInstructions.price           =  string.valueOf(eachVar.price__c);
                    objWorkInstructions.gender          =  eachVar.model__r.gender__c;
                    objWorkInstructions.cluster         =  eachVar.Cluster__c;
                    objWorkInstructions.DialNum         =  eachVar.Dial_Number__c;
                    objWorkInstructions.movement        =  eachVar.Movement__c;
                    objWorkInstructions.strap           =  eachVar.strap__c;
                    
                    lstWorkInstructions.add(objWorkInstructions);
                
            }//End of for 
            
            //Converting the list of procees data in a JSON string
            VariantsJSON = Json.serializePretty(lstWorkInstructions);
            noRecordDisplay =  (lstWorkInstructions.isempty())?true:false;
            
        }//End of method
        return null;
    }
    
    
    //Method to navigate to the previous page
    public pagereference moveToBack(){
    
         Cookie counter = ApexPages.currentPage().getCookies().get('counter');
             // If this is the first time the user is accessing the page, 
            // create a new cookie with name 'counter', an initial value of '1', 
            // path 'null', maxAge '-1', and isSecure 'false'. 
            
            if (counter == null) {
                PageReference pr1 = new PageReference('/apex/NewLogin');
                //pr.setCookies(new Cookie[]{counter});
                pr1.setredirect(true);
                return pr1;
                
            } else {
            // If this isn't the first time the user is accessing the page
            // create a new cookie, incrementing the value of the original count by 1
                Integer count = Integer.valueOf(counter.getValue());
                counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
                
            }
        
            // Set the new cookie for the page
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
    
        String url='';
        //Conditon to check whether the current profile is eithet what user profiel or system administrator if the condition is satisfied navigating to the refinedsearch page else navigating to search page.
        if(currentProfileName=='What user profile' || currentProfileName=='Process and Product end user'){
        
             url='/apex/RefinedSearchpage?profileName='+currentProfileName;
            
        }else{
        
             url='/apex/CustomLandingPage?profileName='+currentProfileName;
        }
        
       //Redirecting to the previos page 
       PageReference pr = new PageReference(url);
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(true);
            return pr;
    }//End of method
    
    //Method to navigate to the search page
    public pagereference moveToHome(){
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
             // If this is the first time the user is accessing the page, 
            // create a new cookie with name 'counter', an initial value of '1', 
            // path 'null', maxAge '-1', and isSecure 'false'. 
            
            if (counter == null) {
                PageReference pr1 = new PageReference('/apex/NewLogin');
                //pr.setCookies(new Cookie[]{counter});
                pr1.setredirect(true);
                return pr1;
                
            } else {
            // If this isn't the first time the user is accessing the page
            // create a new cookie, incrementing the value of the original count by 1
                Integer count = Integer.valueOf(counter.getValue());
                counter = new Cookie('counter', String.valueOf(count+1),null,900,false);
                
            }
        
            // Set the new cookie for the page
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        PageReference pr = new PageReference('/apex/CustomLandingPage?profileName='+currentProfileName);
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(true);
            return pr;
    }//End of emthod
    
    //Method to expire the cookie
    public pagereference logout(){
    
       Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
         
         counter = new Cookie('counter','1',null,0,false);
            
       
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
       PageReference pr1 = new PageReference('/apex/NewLogin');
            pr1.setredirect(true);
            return pr1;
    }//End of method
   
    //Wrapper class to store the product data
    public Class WrapperVariants{
        
        public string brand{get;set;}
        public string model{get;set;}
        Public String variant {get;set;}
        public string price{get;set;}
        public string gender{get;set;} 
        public string cluster{get;set;}
        public string range{get;set;}
        public string dialNum{get;set;}
        Public String CaseMat {get;set;}
        public string movement{get;set;}
        public string function{get;set;}
        public string strap{get;set;}
        public string spec{get;set;}
        public string Rev{get;set;}
        public string AltRemarks{get;set;}
        public string imageId{get;set;}
        public String specId{get;set;}
        public string title{get;set;}
        public String productId{get;set;}
        public string variantId{get;set;}
        
    }//End of wrapper class
    
    //Wrapper class to store process data
    public Class WorkInstructions{
    
        public string sno{get;set;} 
        public string brand{get;set;}
        public string model{get;set;}
        Public String variant {get;set;}
        public string price{get;set;}
        public string workins{get;set;}
        public string doAndDonots{get;set;}
        Public String packInfo{get;set;}
        public string troubleShooting{get;set;}
        public string titleWI{get;set;}
        public string titleDD{get;set;}
        public string titlePI{get;set;}
        public string titleTS{get;set;}
        public String IBDSpares{get;set;}
        Public String titleIbd{get;set;}
        Public String gender{get;set;}
        Public String cluster{get;set;}         
        Public String DialNum{get;set;}         
        Public String movement{get;set;}        
        Public String strap{get;set;} 
    }//End of class    
    
}//End of class