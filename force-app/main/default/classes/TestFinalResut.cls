/*********************************************************
**Created By   :  Vijayavardan Reddy.
**Modified By  :  Vijayavardan Reddy.
**Created Date :  17-June-2014.
**Description  :  Unit testing for final result.
**********************************************************/
@isTest(seealldata=true)
private class TestFinalResut{
    
        Static TestMethod void TestFinalResut(){
        
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
                                     
                 List<product_file__c>  prosflListForSpec    =    TestForAskme.createPrductfileToProduct(productList,'Spec sheet',2);                           
                                    
                                     Insert prosflListForSpec; 
                                     
                 List<product_file__c>  proflforImage           =    TestForAskme.createPrductfileToVariant(vrntList,'Image',2);
                 
                                     Insert proflforImage;
                         
                                     
                 List<id> attachmentIds                         =     new List<id>();  
                                   
                                   
                     for(product_file__c prf:proflforImage ){
                     
                             attachmentIds.add(prf.id);
                     }
                     
                     for(product_file__c prf:prosflListForSpec){
                     
                             attachmentIds.add(prf.id);
                     }   
                     
                     for(product_file__c prf:prosflListForMaster){
                     
                             attachmentIds.add(prf.id);
                     }             
                                     
                 List<Attachment>  attchForMaster                =    TestForAskme.createAttachments(attachmentIds,1);
                             insert attchForMaster;
                     Test.stoptest(); 
                                     
                             
                                     
                         FinalResultExtensions    fnrlExt        =    new FinalResultExtensions();
                                                  
                                                  fnrlExt.sessionManagement();
                                                  fnrlExt.moveToBack();
                                                  fnrlExt.moveToHome();
                                                  
                         FinalResultExtensions.WrapperVariants   wrpvrnt1    =    new   FinalResultExtensions.WrapperVariants();
                         FinalResultExtensions.WorkInstructions  wrpvrnt2    =    new   FinalResultExtensions.WorkInstructions();
                           
                           ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('counter','1','1000',null,false)});
                           Apexpages.currentPage().getParameters().put('profileName','What user Profile');
                           ApexPages.currentPage().getParameters().put('id',productList[0].id);
                           ApexPages.currentPage().getParameters().put('varinatname',productList[0].id);
                                           fnrlExt.sessionManagement();
                                           fnrlExt.moveToBack();
                                           fnrlExt.moveToHome();

                         
                         ApexPages.currentPage().getParameters().put('id',productList[0].id);
                           ApexPages.currentPage().getParameters().put('varinatname','1234vj010');
                                           
                                           fnrlExt.sessionManagement();
            
            }
        }
        
        
       Static TestMethod void TestFinalResut1(){
        
            User productUser  =    TestForAskme.toCreateUser('Process-Product profile','productCustom@test.com');
             productUser.UserPermissionsSFContentUser=false;
            
             Insert productUser;  
             System.runAs(productUser){
                 Test.starttest();
                 List<product__c> productList                   =    TestForAskme.productRecord(5);
                 
                                     Insert productList;
                         
                 List<variant__c> vrntList                      =    TestForAskme.variantRecord(productList,3); 
                 
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
                         test.stopTest();
                                     
                         ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('counter','1','1000',null,false)});            
                         Apexpages.currentPage().getParameters().put('profileName','Work instructions user profile');
                         ApexPages.currentPage().getParameters().put('id',productList[0].id);
                           ApexPages.currentPage().getParameters().put('varinatname','1234vj010');    
                                     
                         FinalResultExtensions    fnrlExt        =    new FinalResultExtensions();
                                           fnrlExt.sessionManagement();
                                           fnrlExt.logout();
             }
         }
        
        

}