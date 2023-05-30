/*************************************************************
**Created By  : Vijayavardan Reddy.
**Modified By : Vijayavardan Reddy.
**Created Date: 16-June-2014.
**Description : Unti testing for Search page.
****************************************************************/  

@isTest(seealldata=true)
private class TestCustomLanding{

    public static testmethod void customLandingMetod(){
        test.startTest();
        User productUser  =    TestForAskme.toCreateUser('Process-Product profile','productCustom@test.com');
             productUser.UserPermissionsSFContentUser=false;
            
             Insert productUser;  
             System.runAs(productUser){
             
                 List<product__c> productList  =     TestForAskme.productRecord(5);
                 
                                     Insert productList;
                         
                 List<variant__c> vrntList     =     TestForAskme.variantRecord(productList,3); 
                 
                                     Insert vrntList;
                 test.stopTest();
                     
                 apexpages.currentPage().getParameters().put('profileName','What user Profile');
                 CustomLanding   clndgObj      =     new   CustomLanding();
                 
                         clndgObj.sessionManagement();
                         clndgObj.getjsonDescriptionData();
                         clndgObj.searchTitan();
                     ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('counter','1','1000',null,false)});
                      clndgObj.searchTitan();   
                 apexpages.currentPage().getParameters().put('profileName','Work instructions user profile');
                 
                 
                 CustomLanding   clndgObj1      =     new   CustomLanding();
                         
                         clndgObj1.sessionManagement();
                         clndgObj1.genderSelectedValues.add('Gender');
                         clndgObj1.searchTitan();
                         clndgObj1.seachKeyWord  ='1234vj010';
                         clndgObj1.searchTitan();
                         clndgobj1.logout();
                                                                                
             }
                
    }
   

}