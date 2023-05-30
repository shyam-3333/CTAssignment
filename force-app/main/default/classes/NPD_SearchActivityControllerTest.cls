/*********************************************************************
   Class Name       : NPD_SearchActivityControllerTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPD_SearchActivityController. 
   Created By       : Keyur Modi
   Created Date     : 8/12/2015
   LastModifiedby   : Dheeraj Gangulli
   LastModifiedDate : 04/03/2016  
*********************************************************************/
@isTest
private class NPD_SearchActivityControllerTest{
    
    static testMethod void unitTest() {
        Test.StartTest();
        
        Apexpages.currentpage().getparameters().put('namefield','Test');
        Apexpages.currentpage().getparameters().put('idfield','test');
        Apexpages.currentpage().getparameters().put('pageName','Collectionlookup');
        
        NPD_SearchActivityController npdSearch = new NPD_SearchActivityController();
        npdSearch.searchActivity();
        npdSearch.SaveBulkActivity();
        
        
        Apexpages.currentpage().getparameters().put('namefield','Test');
        Apexpages.currentpage().getparameters().put('idfield','test');
        Apexpages.currentpage().getparameters().put('pageName','Model');
        
        NPD_SearchActivityController npdSearch1 = new NPD_SearchActivityController();
        npdSearch1.searchActivity();
        npdSearch1.SaveBulkActivity();
        npdSearch1.EditBulkActivity();
        
        npdSearch1.strCollectionsId = 'Test Id';
        npdSearch1.searchActivity();
        
        npdSearch1.strModelId = 'Test Id';
        npdSearch1.searchActivity();
        
        npdSearch1.row1 = null;
        npdSearch1.strCollectionsName = null;
        npdSearch1.strActivityId = null;
        npdSearch1.strModelName = null;
        
        
        Test.StopTest();
    }
}