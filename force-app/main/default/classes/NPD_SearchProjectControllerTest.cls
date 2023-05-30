/*********************************************************************
   Class Name       : NPD_SearchProjectControllerTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPD_SearchProjectController. 
   Created By       : Keyur Modi
   Created Date     : 28/11/2015
   LastModifiedby   : Keyur Modi
   LastModifiedDate : 28/11/2015  
*********************************************************************/
@isTest
Public class NPD_SearchProjectControllerTest{
    
    public static testMethod void test(){
        Test.StartTest(); 
        PageReference pageRef = Page.NPD_SearchActivityPage;
        Test.setCurrentPage(pageRef);
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('namefield', 'Test');
        ApexPages.currentPage().getParameters().put('idfield', 'Test');
        ApexPages.currentPage().getParameters().put('pageName', 'Collectionlookup');
        ApexPages.currentPage().getParameters().put('collectionid', collection.id);
        
        NPD_SearchProjectController searchProj =new NPD_SearchProjectController();
        
        searchProj.searchProject();
        searchProj.projectDetaiview();
        Test.StopTest();
    }
    
    public static testMethod void test1(){
        Test.StartTest(); 
        PageReference pageRef = Page.NPD_SearchActivityPage;
        Test.setCurrentPage(pageRef);
        
        //Insert collection
        NPD_Collections__c  collection = NPD_TestUtilityClass.getCollections();
        insert collection;
        
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('namefield', 'Test');
        ApexPages.currentPage().getParameters().put('idfield', 'Test');
        ApexPages.currentPage().getParameters().put('pageName', 'Model');
        ApexPages.currentPage().getParameters().put('collectionid', collection.id);
        
        NPD_SearchProjectController searchProj =new NPD_SearchProjectController();
        
        searchProj.searchProject();
        searchProj.projectDetaiview();
        Test.StopTest();
    }
}