@isTest()
public class npd_approval_controllerTest{
    public static testMethod void testMethodOne(){

        NPD_Collections__c npdCollection = NPD_TestUtilityClass.getCollections();
        npdCollection.Name = 'Test Collections';
        npdCollection.Collection_Name__c = 'Test Collections';
        insert npdCollection;
        NPD_Activity__c   activityDialStandard = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityDialStandard.name__c = 'Dial Drawing Release and Recipt';
        activityDialStandard.NPD_Collections__c = npdCollection.Id;
        activityDialStandard.Planned_Lead_Time__c = 10;
        activityDialStandard.Actual_Start_Date__c = System.Today();
        activityDialStandard.Actual_End_Date__c = System.Today();
        activityDialStandard.ISCM_Briefing_Date__c = System.Today();
        activityDialStandard.Status__c    = 'In Progress';
        activityDialStandard.Line_Item_Approval_Required__c = True;
        insert activityDialStandard;
        
           
         npd_approval_controller appctr2 = new npd_approval_controller();
        NPD_Activity__c   activityDial = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        
        activityDial.name__c = 'Concept submission and approval';
        activityDial.NPD_Collections__c = npdCollection.Id;
        activityDial.Planned_Lead_Time__c = 10;
        activityDial.Actual_Start_Date__c = System.Today();
        activityDial.Actual_End_Date__c = System.Today();
        activityDial.ISCM_Briefing_Date__c = System.Today();
        activityDial.Status__c    = 'In Progress';
        activityDial.Line_Item_Approval_Required__c = True;
        activityDial.Marketing_brief_stage_approver__c = '00530000003Nll9';
        insert activityDial;
        
        
         npd_approval_controller appctr3 = new npd_approval_controller();

         npd_approval_controller.item_wrapper appctrl = new npd_approval_controller.item_wrapper();
             appctr2.demo1();
        
    }

}