public with sharing class moreProcessDocument {

    Id variantId;
    List<product_file__c> productFilesList;
    map<string,List<attachment>> docsMap;
    String currentVariantName;
    //static variable declarations
    public Static string documentLinks{get;set;}
    
    //Constructor declaration
    public moreProcessDocument(){
    
    }//End of constructor 

    public PageReference sessionManagement() {
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
        
        variantId           =  ApexPages.currentPage().getParameters().get('id');
        productFilesList    =  new List<Product_file__c>();
        docsMap             =  New map<string,List<attachment>>();
        
        // Query to get the product files related to the product which we selected in the front end 
        try{    
             productFilesList   =    [Select id, Variant__r.name, File_Type__c,(SELECT Name, id From Attachments LIMIT 1) from Product_file__c where variant__c=:variantId  LIMIT 50000];
              
         }catch(Exception exe){
             System.debug('<*****************>'+exe);
         }
         for(Product_file__c prdfl:productFilesList){
             currentVariantName   =   prdfl.variant__r.name;  
            if(docsMap.containsKey(prdfl.File_Type__c)){
                docsMap.get(prdfl.File_Type__c).add(prdfl.attachments[0]);
            }else{
                docsMap.put(prdfl.File_Type__c,new List<Attachment>{prdfl.attachments[0]});
            }   
         
         }
         
        Integer HighestNumberOfDocs =0;
        List<processDocuments>  procDocs  = new List<processDocuments>();
        
        if(!docsMap.isEmpty()&&docsmap.values().size()>0){
            
            for(string mapKey:docsMap.keyset()){
                
                    HighestNumberOfDocs=(HighestNumberOfDocs<=docsMap.get(mapKey).size())?docsMap.get(mapKey).size():HighestNumberOfDocs;
                
            }
            System.debug('***********docsMap***********'+docsMap);
            System.debug('*********HighestNumberOfDocs*******'+HighestNumberOfDocs);
            for(integer each = 0;each<HighestNumberOfDocs;each++){
                processDocuments    porDocObj   =   New processDocuments();
                        porDocObj.variantName   =   currentVariantName;
                
                if(docsMap.containsKey('WI')&&docsMap.get('WI')!=null&&each<docsMap.get('WI').size()){
                             porDocObj.WIName   =   docsMap.get('WI')[each].name;
                             porDocObj.WiId     =   docsMap.get('WI')[each].Id;
                                    
                }
                if(docsMap.containsKey('TS')&&docsMap.get('TS')!=null&&each<docsMap.get('TS').size()){
                             porDocObj.TSName   =   docsMap.get('TS')[each].name;
                             porDocObj.TSId     =   docsMap.get('TS')[each].Id;
                                    
                }
                if(docsMap.containsKey('PI')&&docsMap.get('PI')!=null&&each<docsMap.get('PI').size()){
                             porDocObj.PIName   =   docsMap.get('PI')[each].name;
                             porDocObj.PIId     =   docsMap.get('PI')[each].Id;
                                    
                } 
                if(docsMap.containsKey('DD')&&docsMap.get('DD')!=null&&each<docsMap.get('DD').size()){
                             porDocObj.DDName   =   docsMap.get('DD')[each].name;
                             porDocObj.DDId     =   docsMap.get('DD')[each].Id;
                                    
                }  
                if(docsMap.containsKey('IBD')&&docsMap.get('IBD')!=null&&each<docsMap.get('IBD').size()){
                             porDocObj.IBDName   =   docsMap.get('IBD')[each].name;
                             porDocObj.IBDId     =   docsMap.get('IBD')[each].Id;
                                    
                } 
                
                procDocs.add(porDocObj);
            }
            
            //Converting the list of values to JSON string
            documentLinks   = json.serializePretty(procDocs);
            System.debug('*********documentLinks*******'+documentLinks);
        }
        
    
        return null;
    }
    
    public class processDocuments{
        Public String variantName{get;set;}
        Public String WIName{get;set;}
        Public String WIId{get;set;}
        Public String TSName{get;set;}
        Public String TSId{get;set;}
        Public String PIName{get;set;}
        Public String PIId{get;set;}
        Public String DDName{get;set;}
        Public String DDId{get;set;}
        Public String IBDName{get;set;}
        Public String IBDId{get;set;}
    }

}