/*********************************************************************************
**Created By   : Vijayavardan Reddy.
**Modified By  : Vijayavardan Reddy.
**Created Date : 17-june-2014.
**Description  : Unit testing for document display when the user click on spec link.
************************************************************************************/


@isTest(seeAllData=true)
private class TestDocumentDisplay{
    
    Static TestMethod void testDocumetnDispaly(){
        User productUser  =    TestForAskme.toCreateUser('Process-Product profile','productCustom@test.com');
             productUser.UserPermissionsSFContentUser=false;
            
             Insert productUser;  
             System.runAs(productUser){
                 test.startTest();
                     List<product__c> productList                   =    TestForAskme.productRecord(5);
                     
                                         Insert productList;
                             
                     List<variant__c> vrntList                      =    TestForAskme.variantRecord(productList,3); 
                     
                                         Insert vrntList;
                     
                     List<id>               attachmentIds          =     new List<id>();                    
                     List<product_file__c>  proflforImage           =    TestForAskme.createPrductfileToVariant(vrntList,'WI',2);
                 
                                     Insert proflforImage;
                     
                     List<product_file__c>  proflforImage1           =    TestForAskme.createPrductfileToVariant(vrntList,'TS',2);
                 
                                     Insert proflforImage1;
                     List<product_file__c>  proflforImage2           =    TestForAskme.createPrductfileToVariant(vrntList,'DD',2);
                 
                                     Insert proflforImage2;
                                     
                     List<product_file__c>  proflforImage3           =    TestForAskme.createPrductfileToVariant(vrntList,'PI',2);
                 
                                     Insert proflforImage3;
                                     
                                     
                                     
                         for(product_file__c prf:proflforImage){
                         
                                 attachmentIds.add(prf.id);
                         } 
                         for(product_file__c prf:proflforImage1){
                         
                                 attachmentIds.add(prf.id);
                         } 
                         for(product_file__c prf:proflforImage2){
                         
                                 attachmentIds.add(prf.id);
                         }   
                         
                        for(product_file__c prf:proflforImage3){
                         
                                 attachmentIds.add(prf.id);
                         }
                                         
                     List<Attachment>  attchForMaster                =    TestForAskme.createAttachments(attachmentIds,1);
                                         
                                         insert attchForMaster; 
                                         
                                         System.debug('**********************'+attchForMaster);
                                test.stopTest();
                
                 Apexpages.currentPage().getParameters().put('id',attchForMaster[0].id);                     
                 documentDisplay  mrds    =   new documentDisplay();
                     mrds.sessionManagement();
                 ApexPages.currentPage().setCookies(new Cookie[]{new cookie('Counter','1',null,900,false)});
                     mrds.sessionManagement();
        }
    }    
}