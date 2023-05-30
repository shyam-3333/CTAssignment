/*********************************************************************
   Class Name       : MultiSelectTest
   Type             : Test Class
   Description      : This test class covers code coverage of MultiSelectCounsellorComponentController. 
   Created By       : Keyur Modi
   Created Date     : 11/02/2016
   LastModifiedby   : Keyur Modi
   LastModifiedDate : 11/02/2016  
*********************************************************************/

@isTest(SeeAllData=True)
private class MultiSelectTest {
    
    static testMethod void unitTest() {
        Test.startTest(); 
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));
        MultiSelectCounsellorComponentController multiCont = new MultiSelectCounsellorComponentController();
        multiCont.rightOptionsHidden= 'US';
        multiCont.leftOptionsHidden='Canada'; 
        multiCont.setOptions(options,'US & Canada & Mexico');
       
        //multiCont.rightOptionsHidden();
        Test.StopTest();
    }
}