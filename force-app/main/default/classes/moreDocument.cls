/**********************************************************************************************
**Created By   :  Vijayavardan Reddy.
**Modified By  :  Vijayavardan reddy.
**Created Date :  25-May-2014.
**Description  : Collects the all the model documetns and give it to the fornt to display them.
***********************************************************************************************/

public with sharing class moreDocument {
    
    //String variable declarations
    public String modelid;
    public string modelName;
    
    //static variable declarations
    public Static string documentLinks{get;set;}
    
    //list varaible declarations
    List<Product_file__c> productFilesList;
    
    //Map variable declarations
    Map<integer,attachment> masterMap;
    Map<integer,attachment> specMap;
    Map<integer,attachment> specMap1;

    
    //Constructor declaration
    public  moreDocument(){
    
    }//End of constructor
    
    //onload action method to matain the session and prepares the wrapper class  to conver the list of documetns  into Json and give it to the front end
    public pagereference sessionManagement(){
    
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
            counter = new Cookie('counter', String.valueOf(count+1),null,100,false);
            
        }
        
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
        modelid           =  ApexPages.currentPage().getParameters().get('id');
        productFilesList  =  new List<Product_file__c>();
        masterMap         =  new  Map<integer,attachment>();
        specMap           =  new  Map<integer,attachment>();
        specMap1           =  new  Map<integer,attachment>();
        Integer masterInt =  1;
        integer specInt   =  1; 
        integer specInt1   =  1; 
        
        
        // Query to get the product files related to the product which we selected in the front end 
        try{    
             productFilesList   =    [Select id, product__r.name, File_Type__c,(SELECT Name, id From Attachments) from Product_file__c where product__c=:modelid and (File_Type__c = 'Master' OR File_Type__c = 'Spec') LIMIT 50000];
             modelName          =    productFilesList[0].product__r.name; 
             
         }catch(Exception exe){
             System.debug('<*****************>'+exe);
         }
         
         //iterate loop to create two maps tohold the product master document and spec documents seperately.
         for(Product_file__c prdfl:productFilesList){
             
             //Condition to check whether the product fiel type is Master or not if it is master store.
             if(prdfl.File_Type__c == 'Master'){
                 if(!prdfl.attachments.isempty()){
                     masterMap.put(masterInt,prdfl.attachments[0]);
                     masterInt++; 
                 }
                 
             }else if(prdfl.File_Type__c == 'Spec'){
                 if(!prdfl.attachments.isempty() && prdfl.attachments[0].id != null){
                         specMap.put(specInt,prdfl.attachments[0]);
                         specInt++;
                 }
                 if(prdfl.attachments.size()>1)
                 if(!prdfl.attachments.isempty() && prdfl.attachments[1].id != null){
                         specMap1.put(specInt1,prdfl.attachments[1]);
                         System.debug('+++++++++++++++'+specMap1);
                         specInt1++;
                 }
             }//End of If
             
         }//End of for 
         
        List<wrapperDocumetns> wrapperDocumetnsList  =  new List<wrapperDocumetns>();
        
         
        Integer totalrecords =  (masterMap.size()> specMap.size())?masterMap.size():specMap.size();
                 totalrecords = (totalrecords > specMap1.size())?totalrecords : specMap1.size();
             //Iterate the loop to prepare the wrapper calss for displaying the model documents
             for(integer each=1;each<=totalrecords;each++){
                 wrapperDocumetns wd    =   new wrapperDocumetns();
                 if(each==1){                 
                      wd.model    =   modelName;
                 }
                 
                 //Condition to check whether the master map contains any values if it contains then add it to the wrapper class
                 if(!masterMap.isEmpty() && masterMap.containsKey(each) && masterMap.get(each)!=null){
                      wd.masterDocument     =   masterMap.get(each).name;
                      wd.masterDocumentID   =   masterMap.get(each).id;
                 }//End of if
                 
                 //Conditon to check whether the specmap contains anything  if it contains add it to the wrapper calss 
                 if(!specMap.isempty() && specMap.containsKey(each) && specMap.get(each)!=null){
                      wd.specDocument       =   specMap.get(each).name;
                      wd.specDocumentId     =   specMap.get(each).id;
                  }
                   if(!specMap1.isempty() && specMap1.containsKey(each) && specMap1.get(each)!=null){
                      wd.specDocument1       =   specMap1.get(each).name;
                      wd.specDocumentId1     =   specMap1.get(each).id;
                  }
                  
                 wrapperDocumetnsList.add(wd); 
             }//End of for
        
        //Converting the list of values to JSON string
        documentLinks   = json.serializePretty(wrapperDocumetnsList);
        
       return null;
    
    }//End of method 
    
    //Class to stoer the model with their documetns 
    public class wrapperDocumetns{
    
        public String model{get;set;}
        public String masterDocument{get;set;}
        public string masterDocumentID{get;set;}
        public String specDocument{get;set;}
        public String specDocumentId{get;set;}
         public String specDocument1{get;set;}
        public String specDocumentId1{get;set;}
    }//End of class

}//End of main class