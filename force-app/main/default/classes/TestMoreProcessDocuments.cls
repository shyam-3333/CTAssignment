@isTest(SeeAllData=true)
private class TestMoreProcessDocuments{

    static TestMethod void testMoreProcessDocumentsMethod(){
    
    test.startTest(); 
    List<product__c> productList                   =    TestForAskme.productRecord(3);
    
                     Insert productList;
         
    List<variant__c> vrntList                      =    TestForAskme.variantRecord(productList,2); 
    
                     Insert vrntList;
    List<product_file__c>  prosflListForIBD    =    TestForAskme.createPrductfileToVariant(vrntList,'IBD',2);
                 
                                     Insert prosflListForIBD; 
                                     
    List<product_file__c>  prosflListForWI    =    TestForAskme.createPrductfileToVariant(vrntList,'WI',2);                           
                    
                     Insert prosflListForWI; 
                     
    List<product_file__c>  proflforDD           =    TestForAskme.createPrductfileToVariant(vrntList,'DD',2);
    
                     Insert proflforDD;
                     
    List<product_file__c>  proflforTS           =    TestForAskme.createPrductfileToVariant(vrntList,'TS',2);
    
                     Insert proflforTS;
                     
    List<product_file__c>  proflforPI           =    TestForAskme.createPrductfileToVariant(vrntList,'PI',2);
    
                     Insert proflforPI;
                     
    List<id> attachmentIds                         =     new List<id>();  
                                   
                                   
     for(product_file__c prf:prosflListForIBD){
     
             attachmentIds.add(prf.id);
     }
     
     for(product_file__c prf:prosflListForWI){
     
             attachmentIds.add(prf.id);
     }   
     
     for(product_file__c prf:proflforDD){
     
             attachmentIds.add(prf.id);
     }
     for(product_file__c prf:proflforTS){
     
             attachmentIds.add(prf.id);
     } 
     for(product_file__c prf:proflforPI){
     
             attachmentIds.add(prf.id);
     }              
                     
    List<Attachment>  attchForMaster                =    TestForAskme.createAttachments(attachmentIds,1);
                     
                     insert attchForMaster; 
    Test.stopTest();
                     
         
         Apexpages.currentPage().getParameters().put('id',vrntList[0].id);                     
                 moreProcessDocument mrds    =   new moreProcessDocument();
                     mrds.sessionManagement();
                 ApexPages.currentPage().setCookies(new Cookie[]{new cookie('Counter','1',null,900,false)});
                     mrds.sessionManagement();  
    }
    
}