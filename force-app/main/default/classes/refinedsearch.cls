/***********************************************************************************************
**Created By    : Vijayavardan reddy.
**Modified By   : Vijayavardan reddy.
**Created Date  : 10-may-2014.
**Description   : Retrieves the data based on search key word and also  with the filter criteria.
*************************************************************************************************/

public with sharing class refinedsearch {
    
    //Static variables declaration
    public Static string brandAttributes{get;set;}
    public Static string designAttributes{get;set;}
    public Static string genderAttributes{get;set;}
    public Static string materialAttributes{get;set;}
    public Static string shapeAttributes{get;set;}
    public Static string vendorAttributes{get;set;}
    
    //String variables  declaration     
    public String  attchmentid{get;set;}
    public String  ProductAttributes{get;set;}
    public string  filterKey{get;set;}
    public string  searchkey{get;set;}
    String profileName;
    String  variantSearchParent;
    id productRecordType;
           
    //List variables  declaration     
    public List<String>             listOfbrands{get;set;}
    public List<WrapperAttributes>  lstWrapperAttributes{get;set;}
           list<string>             genderList ;
           List<String>             brandList;
           
    //List variables  declaration       
    public Map<String, SObjectField>  allFieldsMap;
    public Map<string,List<string>>   pickListMap{get;set;}
    public map<string,string>         fieldApiMap{get;set;}
           map<String,List<String>>   mapToQuery;
           map<string,List<integer>>  priceMap;
           
           
    //Set variables declaration
    set<id>      brandIds;
    Set<string>  genderSet;
    Set<string>  brandSet;
    Set<String>  designSet; 
    Set<String>  materialSet;
    Set<String>  shapeSet;
    Set<String>  vendorSet;
    
    //Constructor declaration
    public  refinedsearch(){
    
        profileName=apexpages.currentPage().getParameters().get('profileName');
        brandList       =    new List<string>();
        genderList      =    new List<string>();
        listOfbrands    =    new List<String>();
        priceMap        =    new map<string,List<integer>>();
        mapToQuery      =    new map<String,list<string>>();
        pickListMap     =    new Map<string,List<string>>();
        fieldApiMap     =    new map<string,string>();
        allFieldsMap    =    new Map<String, SObjectField>();
        genderSet       =    new set<string>();
        brandSet        =    new set<string>();
        designSet       =    new set<string>();
        materialSet     =    new set<string>();
        shapeSet         =    new set<string>();
        vendorSet       =    new set<string>();
                     
    }//End of consttructor
    
    //On load action method for session management and displying the model details with respect to the search key or advanced search values
    public PageReference onLoadFunction(){
    
        String  brands  ='';
        String  gender ='';
        
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
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
        
        productRecordType = [SELECT DeveloperName,Id,Name,SobjectType FROM RecordType WHERE DeveloperName = 'Master' AND SobjectType = 'Product__c' limit 1].id;
        system.debug('--productRecordType--'+productRecordType);
        //Collect the brands and gender values which are selected in the advanced search popup
        brands          =    apexpages.currentPage().getParameters().get('brands');
        gender          =    apexpages.currentPage().getParameters().get('gender');
         
        //Query string for dynamically retrieving the model details
        String queryString         = 'Select Name,Brand__c, Launch_Year__c,Range__c,Gender__c,Vendor__c,Material__c,Design__c,Construction__c,Shape__c, Launch_Month__c from Product__c where Name!=null and recordTypeId =: productRecordType'  ;
            
        //Condition to check whether the brands and gender values are null and then add the condition to the query string     
        if((brands==null || brands == 'null'||brands == '') && (gender==null || gender == 'null' || gender=='')){
        
            searchkey    =    apexpages.currentPage().getParameters().get('searchkey');
            
            //condition to check whether the search key word is not null or none  and if the search key word is variant then search with parent id if the search keyword is model then search with the mosel name.
            if(searchkey!=null&&searchkey!='' ){
            
                variant__c  vrnt=null;
                
                try{
                
                   vrnt=[SELECT id,model__c,name FROM Variant__c where name=:searchkey LIMIT 1 ];
                   
                }catch(Exception e){
                   System.debug('*****************'+e);
                }
                
                if(vrnt!=null){
                
                   variantSearchParent=vrnt.model__c;
                   queryString=queryString+' AND id=:variantSearchParent';
                   
                }else{
                
                   queryString =queryString +' and name=:searchkey';
                
                }
                
            }//End of if
           
        }//End of If
        
        //condition to check whether brand is null or not and adding the condition to the dynamic query string
        if(brands!= 'null' && brands!='' && brands!=null && brands!=''){
        
            brandList     =  brands.split('KVP');
            queryString   =  queryString+' And Brand__c in:brandList';
            
        }//End of if
        
        
        //Condition to check whether the gender is not null if it is not null then we will add the condition to the dynamic query.    
        if(gender!='null'&&gender!=''&& gender!=null ){
        
            //Checking whether gender string contain the ; which alson known as multiple values that gender is the multipicklist values
            if(gender.contains(';')){
            
                genderList   =  gender.split(';');
                queryString +=  ' And Gender__c in:genderList';
            }//End of if  
            
            else
            queryString   +=  ' And Gender__c =\''+gender+'\'';  
              
        }//End of if
        
        //Calling to method for converting the 
        convertToJSON(queryString);
        
        //Get all the fields in a map using schema
        allFieldsMap=Schema.getGlobalDescribe().get('Product__c').getDescribe().fields.getMap(); 
        
        //Iterate the loop to collect the custom pick list values
        for(String str:allFieldsMap.keySet()){
        
            String fieldLabel=allFieldsMap.get(str).getDescribe().getLabel();
            String fieldName=allFieldsMap.get(str).getDescribe().getName();
            
            //Condition to check whether the field is custom or not
            if(fieldName.contains('__c')){
                fieldApiMap.put(fieldLabel,allFieldsMap.get(str).getDescribe().getName());
                //Iterate the loop to collect the pick list values
                for(Schema.PicklistEntry spr:allFieldsMap.get(str).getDescribe().getPicklistValues()){
                    if(!pickListMap.containsKey(fieldLabel)){
                        pickListMap.put(fieldLabel,new list<string>{spr.getLabel()});
                    }else{
                        pickListMap.get(fieldLabel).add(spr.getLabel());
                    }
                    if(fieldName=='Brand__c'){
                        listOfbrands.add(spr.getLabel());
                    }
                }//End of for
            }//End of if
        }//End of for loop
        
       //Wrapper classes varibles declaration and intializations 
        List<BrandWrapper>    BrandWrapperList      =   new List<BrandWrapper>();
        List<DesignWrapper>   DesignWrapperList     =   new List<DesignWrapper>();
        List<GenderWrapper>   GenderWrapperList     =   new List<GenderWrapper>();
        List<MaterialWrapper> MaterialWrapperList   =   new List<MaterialWrapper>();
        List<ShapeWrapper>    ShapeWrapperList      =   new List<ShapeWrapper>();
        List<VendorWrapper>   VendorWrapperList     =   new List<VendorWrapper>();
        
        //Condition to check whether the map size is greater than zero
        if(pickListMap.size()>0 ){
            //Iterate the picklist map to collect different types of values in list of wrraper classes to display in the front end
            for(String picklistname: pickListMap.keySet()){
            
                
                if(pickListMap.get(picklistname)!=null){
                
                    //Checks whether the name of the pick list is brand or not
                    if(picklistname == 'Brand'){
                    
                        //Iterate the for loop to collect all the brands
                        for(string pickvalue:pickListMap.get(picklistname)){
                            
                            BrandWrapper bwr   =   new BrandWrapper();
                                bwr.name       =    pickvalue;
                                
                            BrandWrapperList.add(bwr);
                        }//End of for loop
                        
                    }else if(picklistname == 'Design'){
                    
                        //Iterate the loop to collect al the desings in a wrapper class list 
                        for(string pickvalue:pickListMap.get(picklistname)){
                            
                            DesignWrapper dwr   =   new DesignWrapper();
                                dwr.name       =    pickvalue;
                                
                            DesignWrapperList.add(dwr);
                        }//End of for loop
                        
                    }else if(picklistname == 'Gender'){
                        
                        //Iterate the loop to collect all the gendes in a wrapper list to display                         
                        for(string pickvalue:pickListMap.get(picklistname)){
                            
                            GenderWrapper dwr   =   new GenderWrapper();
                                dwr.name       =    pickvalue;
                                
                            GenderWrapperList.add(dwr);
                            
                        }//End of for loop
                        
                    }else if(picklistname == 'Material'){
                    
                        //Iterate the loop to collect all the materials in a wrapper list
                        for(string pickvalue:pickListMap.get(picklistname)){
                            
                            MaterialWrapper dwr   =   new MaterialWrapper();
                                dwr.name       =    pickvalue;
                                
                            MaterialWrapperList.add(dwr);
                        }//End of for loop
                        
                    }else if(picklistname == 'Shape'){
                        
                        //Iterate the loop to collect all shapes values in a wrapper list 
                        for(string pickvalue:pickListMap.get(picklistname)){
                            
                            ShapeWrapper dwr   =   new ShapeWrapper();
                                dwr.name       =    pickvalue;
                                
                            ShapeWrapperList.add(dwr);
                        }//End of for loop
                        
                    }else if(picklistname == 'Vendor'){
                    
                        //Iterate the loop to collect all vendor values  in a wrapper list
                        for(string pickvalue:pickListMap.get(picklistname)){
                            
                            VendorWrapper dwr   =   new VendorWrapper();
                                dwr.name       =    pickvalue;
                                
                            VendorWrapperList.add(dwr);
                        }// End of for loop
                        
                    }
                }//End of if
            }//End of for loop
        }//End of if
        
        //Converting List of wrapper classes to Json String
        brandAttributes    = json.serializePretty(BrandWrapperList);
        designAttributes   = json.serializePretty(DesignWrapperList);
        genderAttributes   = json.serializePretty(GenderWrapperList);
        materialAttributes = json.serializePretty(MaterialWrapperList);
        shapeAttributes    = json.serializePretty(ShapeWrapperList);
        vendorAttributes   = json.serializePretty(VendorWrapperList);
        
        return null;
    
    }//End of method
    
    //Method to checks the session time and navigating to the final result page
    public PageReference  moveToFinalResult(){
    
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
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
    
        //Url for final result page
        String url='/apex/FinalResult?id='+attchmentid+'&varinatname='+attchmentid+'&profileName='+profileName;
        
        //Navigate to the final result page
        PageReference pr = new PageReference(url);
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(true);
            return pr;
    }//End of method
    
    //Method to move previous page
    public PageReference moveToBack(){
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
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
        
        //Navigating to the previous page
        PageReference pr = new PageReference('/apex/CustomLandingPage?profileName='+profileName);
            pr.setCookies(new Cookie[]{counter});
            pr.setredirect(true);
            return pr;
    }//End of method
    
    
    //Method to refresh the table
    public pagereference refresh() {
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
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
    
    
        searchkey='';
        String queryString = 'Select Name,Brand__c, Launch_Year__c,Range__c,Gender__c,Vendor__c,Material__c,Design__c,Construction__c,Shape__c, Launch_Month__c from Product__c where Name!=null and recordTypeId =: productRecordType';  
        
        //Calling the method to convert list values to JSON string 
        convertToJSON(queryString);
        return null;
        
    }//End of method
    
    //Method to filter the details according the search key
    public pagereference searchModel(){
    
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
         // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        
        if (counter == null) {
        
            PageReference pr1 = new PageReference('/apex/NewLogin');
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
        
        //Make the dynamic query for getting the values with respect to the search key     
        String queryString = 'Select Name,Brand__c, Launch_Year__c,Range__c,Gender__c,Vendor__c,Material__c,Design__c,Construction__c,Shape__c, Launch_Month__c from Product__c where Name!=null and recordTypeId =: productRecordType';  
        if(searchkey!=null&&searchkey!='' ){
        
           queryString =queryString +' and name=:searchkey';
        }
        
        //Calling the method to convert the list of models to JSON string
        convertToJSON(queryString);
        return null;
    }//End of method
     
    //Method to filter the details with respect to the filter criteria.
    public pagereference searching(){

        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
    
        if (counter == null) {
    
        PageReference pr1 = new PageReference('/apex/NewLogin');
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
    
    
        string[] listOfString;
        
        //Make the dynamic string to get all the models
        String queryString1 = 'Select Name,Brand__c, Launch_Year__c,Range__c,Gender__c,Vendor__c,Material__c,Design__c,Construction__c,Shape__c, Launch_Month__c from Product__c where Name!=null and recordTypeId =: productRecordType';  
        
        //condition to check whether filter key is not null 
        if(filterKey !=null){
            
            
            string[]  strList  =  filterKey.split('KVP');
            
            //Condition to check whether the base string is gender or not
            if(strList[0] == 'gender'){
                //collect the gender values which are selected in the front end
                if(!genderSet.contains(strList[1])){
                
                    genderSet.add(strList[1]);
                    
                }else{
                    set<string> genderSet1 = new set<string>();
                                
                    for(string str:genderSet ){
                        if(str != strList[1]){
                        
                            genderSet1.add(str);
                            
                        }
                    }
                    genderSet  = new set<string>();
                    
                    if(!genderSet1.isempty()){
                        
                        genderSet.addAll(genderSet1);    
                    }
                }
                
            }else if(strList[0] == 'brand'){
                //Colect the brandas which are selected in the front end and remove from the set which are unselected
                if(!brandSet.contains(strList[1])){
                
                    brandSet.add(strList[1]);
                }else{
                    set<string> brandSet1 = new set<string>();
                                
                    for(string str:brandSet ){
                        if(str != strList[1]){
                        
                            brandSet1.add(str);
                            
                        }
                    }
                    brandSet  = new set<string>();
                    
                    if(!brandSet1.isempty()){
                        
                        brandSet.addAll(brandSet1);    
                    }
                }
                
            }else if(strList[0] == 'design'){
                //Collect the desins whicha re selected in the front end and remove from the set which are unselected
                if(!designSet.contains(strList[1])){
                
                    designSet.add(strList[1]);
                }else{
                    set<string> designSet1 = new set<string>();
                                
                    for(string str:designSet ){
                        if(str != strList[1]){
                        
                            designSet1.add(str);
                            
                        }
                    }
                    designSet  = new set<string>();
                    
                    if(!designSet1.isempty()){
                        
                        designSet.addAll(designSet1);    
                    }
                }
                
            }else if(strList[0] == 'material'){
                //Collects the materials which are selected from front end and remove from the set which are unselected
                if(!materialSet.contains(strList[1])){
                
                    materialSet.add(strList[1]);
                }else{
                    set<string> materialSet1 = new set<string>();
                                
                    for(string str:materialSet){
                        if(str != strList[1]){
                        
                            materialSet1.add(str);
                            
                        }
                    }
                    materialSet = new set<string>();
                    
                    if(!materialSet1.isempty()){
                        
                        materialSet.addAll(materialSet1);    
                    }
                }
                
            }else if(strList[0] == 'shape'){
                //Collect the shape values whicha are selected from front end and remove from the set
                if(!shapeSet.contains(strList[1])){
                
                    shapeSet.add(strList[1]);
                }else{
                    set<string> shapeSet1 = new set<string>();
                                
                    for(string str:shapeSet){
                        if(str != strList[1]){
                        
                            shapeSet1.add(str);
                            
                        }
                    }
                    shapeSet = new set<string>();
                    
                    if(!shapeSet1.isempty()){
                        
                        shapeSet.addAll(shapeSet1);    
                    }
                }
                
            }else if(strList[0] == 'vendor'){
                //Collects the vendors which are selected from front end
                if(!vendorSet.contains(strList[1])){
                
                    vendorSet.add(strList[1]);
                }else{
                    set<string> vendorSet1 = new set<string>();
                                
                    for(string str:vendorSet){
                        if(str != strList[1]){
                        
                            vendorSet1.add(str);
                            
                        }
                    }
                    vendorSet = new set<string>();
                    
                    if(!vendorSet1.isempty()){
                        
                        vendorSet.addAll(vendorSet1);    
                    }
                }
                
            }
            
            //Checks the set whether the gender set is empty or not. if it not empty add the condition to the dynamic query
            if(!genderSet.isEmpty()){
                queryString1  = queryString1+'  AND gender__c in:genderSet';
            } 
            //Checks whether the brandset is empty or not. if it not empty add  the condition to the dynamic query
             if(!brandSet.isEmpty()){
            
                queryString1  = queryString1+'  AND brand__c in:brandSet';
            }
            
            //Checks whether the desing set is empty or not. if it not empty add the condition to the dynamic query.
            if(!designSet.isEmpty()){
            
                queryString1  = queryString1+'  AND design__c in:designSet';
            }
            
            //Checks whether the material set is empty or not if it not empty then add the condition to the dynamic query.
            if(!materialSet.isEmpty()){
            
                queryString1  = queryString1+'  AND material__c in:materialSet';
            }
            
            //Checks whether the shapeset is empty or not. if it not empty then add the condition to the dynamic query.
            if(!shapeSet.isEmpty()){
            
                queryString1  = queryString1+'  AND shape__c in:shapeSet';
            }
            
            //Checks the vendor set is empty or not. if it is not then add the condition to the dynamic query
            if(!vendorSet.isEmpty()){
            
                queryString1  = queryString1+'  AND vendor__c in:vendorSet';
            } 
        
        }//End of if
        
        //Calling the method to convert the list values into the JSON string 
        convertToJSON(queryString1);
        return null;
    }//End of method
   
    //method to expire the cookie that is logout from the page
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
   
   
   //Method to conver the list of values to JSON String
    void convertToJSON(string queryString){
       
        lstWrapperAttributes = new list<WrapperAttributes>();
            //Iterate the loop to  collect the wrppaer attibutes in a list
            for(product__c eachPro :database.query(queryString )){
                    WrapperAttributes objWrapperAttributes = new WrapperAttributes();
                    objWrapperAttributes.Model          =   eachPro.name;
                    objWrapperAttributes.Brand          =   eachPro.Brand__c;
                    objWrapperAttributes.Range          =   eachPro.Range__c;
                    objWrapperAttributes.Gender         =   eachPro.Gender__c;
                    objWrapperAttributes.Vendor         =   eachPro.Vendor__c;
                    objWrapperAttributes.Material       =   eachPro.Material__c;
                    objWrapperAttributes.Design         =   eachPro.Design__c;
                    objWrapperAttributes.Launchmonth    =   String.valueOf(eachPro.Launch_month__c);
                    objWrapperAttributes.LaunchYear     =   eachPro.Launch_Year__c;
                    objWrapperAttributes.Construction   =   eachPro.Construction__c;  
                    objWrapperAttributes.Shape          =   eachPro.Shape__c;
                    objWrapperAttributes.id             =   eachPro.Id;
                    //objWrapperAttributes.profileName    =   profileName;
                    
                lstWrapperAttributes.add(objWrapperAttributes);                                     
            }
        //Converting the list of wrapper attribute into JSON string    
        ProductAttributes = json.serializePretty(lstWrapperAttributes);
       
    }//End of method
    
    //Wrapper class to store model values
    public Class WrapperAttributes {
    
        public String id {get;set;}
        public String Model {get;set;}
        public String Brand {get;set;}
        public String Range {get;set;}
        public String Gender {get;set;}
        public String Vendor {get;set;}
        public String Material {get;set;}
        public String Design {get;set;}
        public String Launchmonth{get;set;}
        public String LaunchYear {get;set;}
        public String Construction {get;set;} 
        public String Shape {get;set;} 
       
        
    }//End of class
    
    //Wrapper class to store all brands
    public class BrandWrapper{

        public string name{get;set;}
        
    }//End of class
    
    //Wrapper class to store all designs
    public class DesignWrapper{
    
        public string name{get;set;}
        
    }//End of class
    
    //Wrapper class to store all gender values
    public class GenderWrapper{
    
        public string name{get;set;}
        
    }//End of class
    
    
    //Wrapper class to store all materials
    public class MaterialWrapper{
    
        public string name{get;set;}
    }//End of class
    
    //Wrapper class to store all shapes
    public class ShapeWrapper{
    
        public string name{get;set;}
    }//End of class
    
    //Wrapper class to store all vendors
    public class VendorWrapper{
    
        public string name{get;set;}
    }//End of class
    
}//End of main class