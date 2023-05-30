/*********************************************************************************
**Created By   : Vijayavardan Reddy.
**Modified By  : Vijayavardan Reddy.
**Created Date : 17-june-2014.
**Description  : Unit testing for document display when the user click on spec link.
************************************************************************************/


@isTest(seeAllData=true)
private class TestMoreDocuments{
    
    Static TestMethod void testMoreDocumentsMethod(){
        User productUser  =    TestForAskme.toCreateUser('Process-Product profile','productCustom@test.com');
             productUser.UserPermissionsSFContentUser=false;
            
             Insert productUser;  
             System.runAs(productUser){
                 test.startTest();
                     List<product__c> productList                   =    TestForAskme.productRecord(5);
                     
                                         Insert productList;
                             
                     List<variant__c> vrntList                      =    TestForAskme.variantRecord(productList,3); 
                     
                                         Insert vrntList;
                                         
                     List<product_file__c>  prosflListForMaster    =    TestForAskme.createPrductfileToProduct(productList,'Master',2);
                     
                                         Insert prosflListForMaster; 
                             System.debug('***************'+prosflListForMaster);
                                         
                     List<product_file__c>  prosflListForSpec      =    TestForAskme.createPrductfileToProduct(productList,'Spec',2);                           
                                        
                                         Insert prosflListForSpec; 
                                         
                             System.debug('************************'+prosflListForSpec);
                     List<id>               attachmentIds          =     new List<id>();
                     
                         for(product_file__c prf:prosflListForSpec){
                         
                                 attachmentIds.add(prf.id);
                         }   
                         
                         for(product_file__c prf:prosflListForMaster){
                         
                                 attachmentIds.add(prf.id);
                         }             
                                         
                     List<Attachment>  attchForMaster                =    TestForAskme.createAttachments(attachmentIds,3);
                                         
                                         insert attchForMaster; 
                                         
                                         System.debug('**********************'+attchForMaster);
                                test.stopTest();
                
                 Apexpages.currentPage().getParameters().put('id',productList[0].id);                     
                 moreDocument mrds    =   new moreDocument();
                     mrds.sessionManagement();
                 ApexPages.currentPage().setCookies(new Cookie[]{new cookie('Counter','1',null,900,false)});
                     mrds.sessionManagement();
        }
    }    
}