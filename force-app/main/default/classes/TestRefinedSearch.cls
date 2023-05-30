/*************************************************************
**Created By  : Vijayavardan Reddy.
**Modified By : Vijayavardan Reddy.
**Created Date: 16-June-2014.
**Description : Unti testing for fileteing criteria.
****************************************************************/ 

@isTest(seealldata=true)
private class TestRefinedSearch{

    public static TestMethod void refienedsearchmethod(){
    
        Test.startTest();
        User productUser  =    TestForAskme.toCreateUser('Process-Product profile','productCustom@test.com');
             productUser.UserPermissionsSFContentUser=false;
            
             Insert productUser;  
         System.runAs(productUser){
         
             List<product__c> productList                   =    TestForAskme.productRecord(5);
             
                                 Insert productList;
                     
             List<variant__c> vrntList                      =    TestForAskme.variantRecord(productList,3); 
             
                                 Insert vrntList;
                                 
             List<product_file__c>  prosflListForMaster    =    TestForAskme.createPrductfileToProduct(productList,'master',2);
             
                                 Insert prosflListForMaster; 
                                 
             List<product_file__c>  prosflListForSpec    =    TestForAskme.createPrductfileToProduct(productList,'Spec Sheet',2);                           
                                
                                 Insert prosflListForSpec; 
                                 
             List<product_file__c>  proflforImage           =    TestForAskme.createPrductfileToVariant(vrntList,'image',2);
             
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
                                 
             List<Attachment>  attchForMaster               =    TestForAskme.createAttachments(attachmentIds,1);
             
                                 insert    attchForMaster; 
                 Test.StopTest();
                 
                 apexpages.currentPage().getParameters().put('profileName','What user profile');  
                 
                                    
                 refinedsearch   rfsrch                     =    new  refinedsearch();
                                 rfsrch.onLoadFunction();
                                 rfsrch.moveToFinalResult();
                                 rfsrch.moveToBack();
                                 rfsrch.refresh();
                                 rfsrch.searchModel();
                                 rfsrch.searching();
                                 
                 refinedsearch.WrapperAttributes   wrpAttr     =   new refinedsearch.WrapperAttributes();
                 refinedsearch.BrandWrapper        brandWrp1   =  new refinedsearch.BrandWrapper();
                 refinedsearch.DesignWrapper       brandWrp2   =  new refinedsearch.DesignWrapper();
                 refinedsearch.GenderWrapper       brandWrp3   =  new refinedsearch.GenderWrapper();
                 refinedsearch.MaterialWrapper     brandWrp4   =  new refinedsearch.MaterialWrapper();
                 refinedsearch.ShapeWrapper        brandWrp5   =  new refinedsearch.ShapeWrapper();
                 refinedsearch.VendorWrapper       brandWrp6   =  new refinedsearch.VendorWrapper();
                 ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('Counter','1',null,1000,false)});
                 apexpages.currentPage().getParameters().put('searchkey','1234vj010');
                
                                rfsrch.onLoadFunction();
                                
                 apexpages.currentPage().getParameters().put('searchkey','12340');
                
                                rfsrch.onLoadFunction();
                                rfsrch.searchModel();
                                
                 apexpages.currentPage().getParameters().put('brands','TitanKVPSF');
                 apexpages.currentPage().getParameters().put('gender','Gents'); 
                                rfsrch.onLoadFunction();
                 apexpages.currentPage().getParameters().put('gender','Gents;Ladies');
                      
                                 rfsrch.onLoadFunction();
                                 rfsrch.moveToFinalResult();
                                 rfsrch.moveToBack();
                                 rfsrch.refresh();
                                 
                                 rfsrch.filterKey='genderKVPGents';
                                 rfsrch.searching();
                                 rfsrch.filterKey='brandKVPTitan';
                                 rfsrch.searching();
                                 rfsrch.filterKey='designKVPDH';
                                 rfsrch.searching();
                                 rfsrch.filterKey='materialKVPBrass';
                                 rfsrch.searching();
                                 rfsrch.filterKey='shapeKVPOval';
                                 rfsrch.searching();
                                 rfsrch.filterKey='vendorKVP20C';
                                 rfsrch.searching();
                                 
                                 rfsrch.filterKey='genderKVPLadies';
                                 rfsrch.searching();
                                 rfsrch.filterKey='brandKVPSF';
                                 rfsrch.searching();
                                 rfsrch.filterKey='designKVPINH';
                                 rfsrch.searching();
                                 rfsrch.filterKey='materialKVPGold';
                                 rfsrch.searching();
                                 rfsrch.filterKey='shapeKVPOthers';
                                 rfsrch.searching();
                                 rfsrch.filterKey='vendorKVPAnda';
                                 rfsrch.searching();
                                 
                                 rfsrch.filterKey='genderKVPGents';
                                 rfsrch.searching();
                                 rfsrch.filterKey='brandKVPTitan';
                                 rfsrch.searching();
                                 rfsrch.filterKey='designKVPDH';
                                 rfsrch.searching();
                                 rfsrch.filterKey='materialKVPBrass';
                                 rfsrch.searching();
                                 rfsrch.filterKey='shapeKVPOval';
                                 rfsrch.searching();
                                 rfsrch.filterKey='vendorKVP20C';
                                 rfsrch.searching();
                                 rfsrch.logout();
                     
         }
    
    }


}